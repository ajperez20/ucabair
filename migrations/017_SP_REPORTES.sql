-- =========================================================
-- Procedimiento almacenado para obtener los 10 clientes con más compras en un año
-- =========================================================
DROP FUNCTION IF EXISTS SP_TOP_10_CLIENTES;

CREATE OR REPLACE FUNCTION SP_TOP_10_CLIENTES(
    IN p_anio INTEGER
)
    RETURNS TABLE
            (
                cliente_tipo           TEXT,
                cliente_id             INTEGER,
                cliente_identificacion TEXT,
                cliente_nombre         TEXT,
                cantidad_compras       BIGINT,
                total_compras          NUMERIC
            )
AS
$$
BEGIN
    RETURN QUERY
        -- Clientes Naturales
        (SELECT 'NATURAL'::TEXT                                 as cliente_tipo,
                cn.ctn_id                                       as cliente_id,
                cn.ctn_dni::TEXT                                as cliente_identificacion,
                (cn.ctn_nombre || ' ' || cn.ctn_apellido)::TEXT as cliente_nombre,
                COUNT(sc.sct_id)                                as cantidad_compras,
                COALESCE(SUM(sc.sct_total), 0)::NUMERIC         as total_compras
         FROM cliente_natural cn
                  LEFT JOIN solicitud_cliente sc ON cn.ctn_id = sc.fk_ctn_id
             AND EXTRACT(YEAR FROM sc.sct_fecha) = p_anio
         GROUP BY cn.ctn_id, cn.ctn_dni, cn.ctn_nombre, cn.ctn_apellido)

        UNION ALL

        -- Clientes Jurídicos
        (SELECT 'JURIDICO'::TEXT                        as cliente_tipo,
                cj.cjd_id                               as cliente_id,
                cj.cjd_rif::TEXT                        as cliente_identificacion,
                cj.cjd_nombre::TEXT                     as cliente_nombre,
                COUNT(sc.sct_id)                        as cantidad_compras,
                COALESCE(SUM(sc.sct_total), 0)::NUMERIC as total_compras
         FROM cliente_juridico cj
                  LEFT JOIN solicitud_cliente sc ON cj.cjd_id = sc.fk_cjd_id
             AND EXTRACT(YEAR FROM sc.sct_fecha) = p_anio
         GROUP BY cj.cjd_id, cj.cjd_rif, cj.cjd_nombre)

        ORDER BY total_compras DESC, cantidad_compras DESC
        LIMIT 10;
END;
$$ LANGUAGE plpgsql;

-- =========================================================
-- Procedimiento almacenado para obtener el Calculo de Nominas
-- =========================================================
DROP FUNCTION IF EXISTS SP_REPORTE_NOMINA(INT);

CREATE OR REPLACE FUNCTION SP_REPORTE_NOMINA(anio INT)
    RETURNS TABLE (
                      empleado_dni TEXT,
                      empleado_nombre TEXT,
                      cargo TEXT,
                      total_horas_trabajadas NUMERIC,
                      total_horas_extras NUMERIC,
                      total_pagado NUMERIC,
                      mes TEXT
                  ) AS $$
BEGIN
    RETURN QUERY
        SELECT
            e.per_dni::TEXT,
            (e.per_nombre || ' ' || e.per_apellido)::TEXT,
            c.car_nombre::TEXT,
            COALESCE(SUM(EXTRACT(EPOCH FROM (a.asi_hora_fin - a.asi_hora_inicio))/3600), 0)::NUMERIC,
            COALESCE(GREATEST(SUM(EXTRACT(EPOCH FROM (a.asi_hora_fin - a.asi_hora_inicio))/3600) - 160, 0), 0)::NUMERIC,
            COALESCE(pn.pnn_total_pago, 0)::NUMERIC,
            TO_CHAR(pn.pnn_fecha_pago, 'TMMonth')::TEXT
        FROM PAGO_NOMINA pn
                 JOIN EMPLEADO e ON pn.fk_per_id = e.per_id
                 JOIN EMPLEADO_CARGO ec ON e.per_id = ec.fk_per_id
            AND (ec.emc_fecha_fin IS NULL OR ec.emc_fecha_fin > CURRENT_DATE)
                 JOIN CARGO c ON ec.fk_car_id = c.car_id
                 LEFT JOIN ASISTENCIA a ON e.per_id = a.fk_per_id
            AND a.asi_pagada = true
        WHERE EXTRACT(YEAR FROM pn.pnn_fecha_pago) = anio
        GROUP BY
            e.per_dni,
            e.per_nombre,
            e.per_apellido,
            c.car_nombre,
            pn.pnn_total_pago,
            pn.pnn_fecha_pago
        ORDER BY
            EXTRACT(MONTH FROM pn.pnn_fecha_pago),
            e.per_nombre || ' ' || e.per_apellido;
END;
$$ LANGUAGE plpgsql;

-- =========================================================
-- Procedimiento almacenado para obtener el control de Asistencias
-- =========================================================
DROP FUNCTION IF EXISTS SP_REPORTE_ASISTENCIAS(INT);

CREATE OR REPLACE FUNCTION SP_REPORTE_ASISTENCIAS(anio INT)
    RETURNS TABLE (
                      empleado_dni TEXT,
                      empleado_nombre TEXT,
                      cargo TEXT,
                      mes TEXT,
                      dias_trabajados INT,
                      horas_regulares NUMERIC,
                      horas_extras NUMERIC,
                      asistencias_completadas INT,
                      asistencias_pendientes INT,
                      porcentaje_asistencia NUMERIC
                  ) AS $$
BEGIN
    RETURN QUERY
        WITH asistencias_mes AS (
            SELECT
                e.per_id,
                e.per_dni,
                e.per_nombre || ' ' || e.per_apellido as nombre_completo,
                c.car_nombre,
                TO_CHAR(pn.pnn_fecha_pago, 'TMMonth') as mes_nombre,
                EXTRACT(MONTH FROM pn.pnn_fecha_pago) as mes_numero,
                COUNT(DISTINCT pn.pnn_fecha_pago) as dias_asistidos,
                SUM(CASE
                        WHEN a.asi_hora_fin IS NOT NULL
                            THEN EXTRACT(EPOCH FROM (a.asi_hora_fin - a.asi_hora_inicio))/3600
                        ELSE 0
                    END) as total_horas,
                COUNT(CASE WHEN a.asi_hora_fin IS NOT NULL THEN 1 END) as asistencias_completas,
                COUNT(CASE WHEN a.asi_hora_fin IS NULL THEN 1 END) as asistencias_incompletas,
                COUNT(*) as total_asistencias
            FROM PAGO_NOMINA pn
                     JOIN EMPLEADO e ON pn.fk_per_id = e.per_id
                     JOIN EMPLEADO_CARGO ec ON e.per_id = ec.fk_per_id
                AND (ec.emc_fecha_fin IS NULL OR ec.emc_fecha_fin > CURRENT_DATE)
                     JOIN CARGO c ON ec.fk_car_id = c.car_id
                     LEFT JOIN ASISTENCIA a ON e.per_id = a.fk_per_id
                AND a.asi_pagada = true
            WHERE EXTRACT(YEAR FROM pn.pnn_fecha_pago) = anio
            GROUP BY
                e.per_id,
                e.per_dni,
                nombre_completo,
                c.car_nombre,
                mes_nombre,
                mes_numero
        )
        SELECT
            per_dni::TEXT as empleado_dni,
            nombre_completo::TEXT as empleado_nombre,
            car_nombre::TEXT as cargo,
            mes_nombre::TEXT as mes,
            dias_asistidos::INT as dias_trabajados,
            CASE
                WHEN total_horas <= 160 THEN total_horas
                ELSE 160
                END::NUMERIC as horas_regulares,
            CASE
                WHEN total_horas > 160 THEN total_horas - 160
                ELSE 0
                END::NUMERIC as horas_extras,
            asistencias_completas::INT as asistencias_completadas,
            asistencias_incompletas::INT as asistencias_pendientes,
            ROUND((asistencias_completas::NUMERIC / NULLIF(total_asistencias, 0) * 100), 2) as porcentaje_asistencia
        FROM asistencias_mes
        ORDER BY mes_numero, nombre_completo;
END;
$$ LANGUAGE plpgsql;

-- =========================================================
-- Procedimiento almacenado para obtener Fabricación de Aviones
-- =========================================================
DROP FUNCTION IF EXISTS SP_REPORTE_FABRICACION_AVION();

CREATE OR REPLACE FUNCTION SP_REPORTE_FABRICACION_AVION()
    RETURNS TABLE (
                      solicitud_id INT,
                      fecha_solicitud DATE,
                      cliente_nombre TEXT,
                      modelo_avion TEXT,
                      proceso TEXT,
                      estado TEXT,
                      zona TEXT,
                      area TEXT,
                      sede TEXT,
                      fecha_inicio DATE,
                      fecha_fin DATE,
                      tiempo_proceso NUMERIC,
                      piezas_utilizadas INT,
                      pruebas_realizadas INT,
                      pruebas_exitosas INT
                  ) AS $$
BEGIN
    RETURN QUERY
        SELECT
            sc.sct_id,
            sc.sct_fecha,
            CASE
                WHEN cj.cjd_id IS NOT NULL THEN cj.cjd_nombre
                WHEN cn.ctn_id IS NOT NULL THEN cn.ctn_nombre || ' ' || cn.ctn_apellido
                ELSE 'Cliente no encontrado'
                END::TEXT as cliente,
            mac.mda_nombre::TEXT as modelo,
            pea.eav_nombre_proceso::TEXT as proceso,
            CASE
                WHEN efa.fk_est_id IS NULL THEN 'No iniciado'
                WHEN efa.efa_fecha_fin IS NULL THEN 'En proceso'
                ELSE 'Completado'
                END::TEXT as estado,
            z.zon_nombre::TEXT as zona,
            a.are_nombre::TEXT as area,
            s.sed_nombre::TEXT as sede,
            fea.fln_fecha_inicio::DATE,
            fea.fln_fecha_fin::DATE,
            CASE
                WHEN fea.fln_fecha_fin IS NOT NULL
                    THEN EXTRACT(EPOCH FROM (fea.fln_fecha_fin - fea.fln_fecha_inicio))/3600
                ELSE NULL
                END::NUMERIC as duracion_horas,
            COUNT(DISTINCT esp.edz_id)::INT as cantidad_piezas,
            COUNT(DISTINCT pps.fk_pru_id)::INT as total_pruebas,
            COUNT(DISTINCT CASE
                               WHEN pps.pzb_resultado_prueba = 'EXITOSA' THEN pps.fk_pru_id
                END)::INT as pruebas_exitosas
        FROM SOLICITUD_CLIENTE sc
                 LEFT JOIN CLIENTE_JURIDICO cj ON sc.fk_cjd_id = cj.cjd_id
                 LEFT JOIN CLIENTE_NATURAL cn ON sc.fk_ctn_id = cn.ctn_id
                 JOIN FASE_ENSAMBLE_AVION fea ON sc.sct_id = fea.fk_sct_id
                 JOIN MODELO_AVION_CONF mac ON fea.fk_mda_id = mac.mda_id
                 JOIN PROCESO_ENSAMBLE_AVION_EJEC pea ON fea.fk_eav_id = pea.eav_id
                 JOIN ZONA z ON fea.fk_zon_id = z.zon_id
                 JOIN AREA a ON z.fk_are_id = a.are_id
                 JOIN SEDE_PLANTA s ON a.fk_sed_id = s.sed_id
                 LEFT JOIN ESTATUS_FEA efa ON
            fea.fk_eav_id = efa.fk_eav_id AND
            fea.fk_mda_id = efa.fk_mda_id AND
            fea.fk_zon_id = efa.fk_zon_id AND
            fea.fk_sct_id = efa.fk_sct_id
                 LEFT JOIN ENSAMBLE_SOLICITUD_PIEZA esp ON
            fea.fk_eav_id = esp.fk_eav_id AND
            fea.fk_mda_id = esp.fk_mda_id AND
            fea.fk_zon_id = esp.fk_zon_id AND
            fea.fk_sct_id = esp.fk_sct_id
                 LEFT JOIN PRUEBA_PIEZA_SOLICITUD pps ON esp.edz_id = pps.fk_edz_id
        GROUP BY
            sc.sct_id,
            sc.sct_fecha,
            cliente,
            mac.mda_nombre,
            pea.eav_nombre_proceso,
            efa.fk_est_id,
            efa.efa_fecha_fin,
            z.zon_nombre,
            a.are_nombre,
            s.sed_nombre,
            fea.fln_fecha_inicio,
            fea.fln_fecha_fin
        ORDER BY
            sc.sct_fecha DESC,
            mac.mda_nombre,
            pea.eav_nombre_proceso;
END;
$$ LANGUAGE plpgsql;

-- =========================================================
-- Procedimiento almacenado para obtener el reporte de estatus piezas
-- =========================================================
DROP FUNCTION IF EXISTS SP_REPORTE_ESTATUS_PIEZAS();

CREATE OR REPLACE FUNCTION SP_REPORTE_ESTATUS_PIEZAS()
    RETURNS TABLE (
                      pieza_id INT,
                      pieza_nombre VARCHAR(255),
                      numero_serial VARCHAR(255),
                      tipo_pieza VARCHAR(255),
                      estado VARCHAR(50),
                      ubicacion_sede VARCHAR(255),
                      cantidad_disponible INT,
                      pruebas_realizadas INT,
                      pruebas_aprobadas INT,
                      proceso_actual VARCHAR(255),
                      fecha_ultimo_movimiento DATE,
                      estado_proceso VARCHAR(50)
                  ) AS $$
BEGIN
    RETURN QUERY
        WITH pruebas_stats AS (
            SELECT
                pps.fk_pie_id,
                COUNT(pps.fk_pru_id) as total_pruebas,
                COUNT(CASE WHEN pps.psz_resultado = 'EXITOSA' THEN 1 END) as pruebas_ok
            FROM PRUEBA_PIEZA_SEDE pps
            GROUP BY pps.fk_pie_id
        ),
             ultimo_proceso AS (
                 SELECT DISTINCT ON (fep.fk_pie_id)
                     fep.fk_pie_id,
                     pep.epc_nombre_proceso as proceso,
                     fep.eez_fecha_inicio,
                     CASE
                         WHEN fep.eez_fecha_fin IS NULL THEN 'En Proceso'::VARCHAR(50)
                         ELSE 'Completado'::VARCHAR(50)
                         END as estado_proc
                 FROM FASE_ENSAMBLE_PIEZA fep
                          JOIN PROCESO_ENSAMBLE_PIEZA_CONF pep ON fep.fk_esp_id = pep.epc_id
                 ORDER BY fep.fk_pie_id, fep.eez_fecha_inicio DESC
             )
        SELECT
            ps.pie_id::INT,
            ps.pie_nombre::VARCHAR(255),
            ps.pie_numero_serial::VARCHAR(255),
            tpc.tpc_nombre::VARCHAR(255),
            (CASE
                 WHEN ps.pie_cantidad_disponible = 0 THEN 'Agotado'
                 WHEN ps.pie_cantidad_disponible < 10 THEN 'Stock Crítico'
                 ELSE 'Disponible'
                END)::VARCHAR(50),
            COALESCE(s.sed_nombre, 'Sin ubicación')::VARCHAR(255),
            ps.pie_cantidad_disponible::INT,
            COALESCE(p.total_pruebas, 0)::INT,
            COALESCE(p.pruebas_ok, 0)::INT,
            COALESCE(up.proceso, 'Sin proceso actual')::VARCHAR(255),
            up.eez_fecha_inicio::DATE,
            COALESCE(up.estado_proc, 'No iniciado')::VARCHAR(50)
        FROM PIEZA_STOCK ps
                 JOIN MODELO_PIEZA_CONF mpc ON ps.pie_id = mpc.mec_id
                 JOIN TIPO_PIEZA_CONF tpc ON mpc.fk_tpc_id = tpc.tpc_id
                 LEFT JOIN SEDE_PLANTA s ON ps.fk_sed_id = s.sed_id
                 LEFT JOIN pruebas_stats p ON ps.pie_id = p.fk_pie_id
                 LEFT JOIN ultimo_proceso up ON ps.pie_id = up.fk_pie_id
        ORDER BY ps.pie_fecha_fabricacion DESC, ps.pie_nombre;
END;
$$ LANGUAGE plpgsql;

-- =========================================================
-- Procedimiento almacenado para obtener el Equipo mas Eficiente
-- =========================================================
DROP FUNCTION IF EXISTS SP_REPORTE_EQUIPO_EFICIENTE(INT);

CREATE OR REPLACE FUNCTION SP_REPORTE_EQUIPO_EFICIENTE(anio INT)
    RETURNS TABLE (
                      zona_nombre VARCHAR(100),
                      area_nombre VARCHAR(100),
                      sede_nombre VARCHAR(100),
                      supervisor_nombre TEXT,
                      procesos_asignados BIGINT,
                      procesos_completados BIGINT,
                      procesos_pendientes BIGINT,
                      porcentaje_completado NUMERIC
                  ) AS $$
BEGIN
    RETURN QUERY
        SELECT
            z.zon_nombre::VARCHAR(100),
            a.are_nombre::VARCHAR(100),
            s.sed_nombre::VARCHAR(100),
            (e.per_nombre || ' ' || e.per_apellido)::TEXT,
            COUNT(DISTINCT fep.fk_esp_id)::BIGINT as procesos_asignados,
            COUNT(DISTINCT CASE
                               WHEN fep.eez_fecha_fin IS NOT NULL
                                   THEN fep.fk_esp_id
                END)::BIGINT as procesos_completados,
            COUNT(DISTINCT CASE
                               WHEN fep.eez_fecha_fin IS NULL
                                   THEN fep.fk_esp_id
                END)::BIGINT as procesos_pendientes,
            ROUND(
                    (COUNT(DISTINCT CASE
                                        WHEN fep.eez_fecha_fin IS NOT NULL
                                            THEN fep.fk_esp_id
                        END)::NUMERIC /
                     NULLIF(COUNT(DISTINCT fep.fk_esp_id), 0) * 100), 2
            )::NUMERIC as porcentaje_completado
        FROM ZONA z
                 JOIN AREA a ON z.fk_are_id = a.are_id
                 JOIN SEDE_PLANTA s ON a.fk_sed_id = s.sed_id
                 JOIN EQUIPO_ENCARGADO ee ON z.zon_id = ee.fk_zon_id
                 JOIN EMPLEADO e ON ee.fk_per_id = e.per_id
                 LEFT JOIN FASE_ENSAMBLE_PIEZA fep ON z.zon_id = fep.fk_zon_id
        WHERE EXTRACT(YEAR FROM fep.eez_fecha_inicio) = anio
        GROUP BY
            z.zon_nombre,
            a.are_nombre,
            s.sed_nombre,
            e.per_nombre,
            e.per_apellido
        HAVING COUNT(DISTINCT fep.fk_esp_id) > 0
        ORDER BY porcentaje_completado DESC;
END;
$$ LANGUAGE plpgsql;

-- =========================================================
-- Procedimiento almacenado para obtener Especificaciones de Modelos
-- =========================================================
DROP FUNCTION IF EXISTS SP_REPORTE_ESPECIFICACIONES_MODELOS;

CREATE OR REPLACE FUNCTION SP_REPORTE_ESPECIFICACIONES_MODELOS()
    RETURNS TABLE (
                      modelo_id INT,
                      modelo_nombre VARCHAR(50),
                      tipo_avion VARCHAR(50),
                      caracteristica VARCHAR(255),
                      valor INT,
                      unidad_medida VARCHAR(30),
                      cantidad_piezas BIGINT,
                      precio_base INT
                  ) AS $$
BEGIN
    RETURN QUERY
        SELECT
            mac.mda_id,
            mac.mda_nombre,
            ta.tiv_nombre,
            cac.pvv_nombre_caracteristica,
            mac2.mnc_valor,
            mac2.mnc_unidad_medida,
            COUNT(DISTINCT ac.fk_mec_id),
            mac.mda_precio
        FROM MODELO_AVION_CONF mac
                 JOIN TIPO_AVION ta ON mac.fk_tiv_id = ta.tiv_id
                 JOIN MODELO_AVION_CARACTERISTICA mac2 ON mac.mda_id = mac2.fk_mda_id
                 JOIN CARACTERISTICA_ANV_CONF cac ON mac2.fk_pvv_id = cac.pvv_id
                 LEFT JOIN AVION_COMPONENTE ac ON mac.mda_id = ac.fk_mda_id
        GROUP BY
            mac.mda_id,
            mac.mda_nombre,
            ta.tiv_nombre,
            cac.pvv_nombre_caracteristica,
            mac2.mnc_valor,
            mac2.mnc_unidad_medida
        ORDER BY mac.mda_nombre, cac.pvv_nombre_caracteristica;
END;
$$ LANGUAGE plpgsql;

-- =========================================================
-- Procedimiento almacenado para obtener Pruebas Fallidas
-- =========================================================
DROP FUNCTION IF EXISTS SP_REPORTE_PRUEBAS_FALLIDAS(INT);

CREATE OR REPLACE FUNCTION SP_REPORTE_PRUEBAS_FALLIDAS(anio INT)
    RETURNS TABLE (
                      prueba_nombre VARCHAR(255),
                      pieza_nombre VARCHAR(80),
                      fecha_prueba DATE,
                      zona_nombre VARCHAR(100),
                      sede_nombre VARCHAR(100),
                      resultado VARCHAR(255),
                      dias_transcurridos INT,
                      observaciones TEXT
                  ) AS $$
BEGIN
    RETURN QUERY
        SELECT
            pr.pru_nombre::VARCHAR(255),
            ps.pie_nombre::VARCHAR(80),
            pps.psz_fecha_inicio::DATE,
            z.zon_nombre::VARCHAR(100),
            s.sed_nombre::VARCHAR(100),
            pps.psz_resultado::VARCHAR(255),
            CASE
                WHEN pps.psz_fecha_fin IS NOT NULL THEN
                    (pps.psz_fecha_fin::DATE - pps.psz_fecha_inicio::DATE)
                ELSE 0
                END::INT,
            COALESCE(e.est_descripcion, 'Sin observaciones')::TEXT
        FROM PRUEBA pr
                 JOIN PRUEBA_PIEZA_SEDE pps ON pr.pru_id = pps.fk_pru_id
                 JOIN PIEZA_STOCK ps ON pps.fk_pie_id = ps.pie_id
                 JOIN ZONA z ON pps.fk_zon_id = z.zon_id
                 JOIN AREA a ON z.fk_are_id = a.are_id
                 JOIN SEDE_PLANTA s ON a.fk_sed_id = s.sed_id
                 LEFT JOIN ESTATUS_PPS eps ON pps.fk_pie_id = eps.fk_pie_id
            AND pps.fk_zon_id = eps.fk_zon_id
            AND pps.fk_pru_id = eps.fk_pru_id
                 LEFT JOIN ESTATUS e ON eps.fk_est_id = e.est_id
        WHERE EXTRACT(YEAR FROM pps.psz_fecha_inicio) = anio
          AND pps.psz_resultado = 'FALLIDA'
        ORDER BY pps.psz_fecha_inicio DESC;
END;
$$ LANGUAGE plpgsql;

-- =========================================================
-- Procedimiento almacenado para obtener Inventario Mensual
-- =========================================================
DROP FUNCTION IF EXISTS SP_REPORTE_INVENTARIO_MENSUAL(INT);

CREATE OR REPLACE FUNCTION SP_REPORTE_INVENTARIO_MENSUAL(anio INT)
    RETURNS TABLE (
                      sede_nombre VARCHAR(100),
                      mes TEXT,
                      pieza_nombre VARCHAR(80),
                      stock_inicial INT,
                      entradas INT,
                      salidas INT,
                      stock_final INT,
                      valor_total NUMERIC
                  ) AS $$
BEGIN
    RETURN QUERY
        SELECT
            s.sed_nombre,
            TO_CHAR(DATE_TRUNC('month', MAKE_DATE(anio, EXTRACT(MONTH FROM ps.pie_fecha_fabricacion)::INT, 1)), 'TMMonth'),
            ps.pie_nombre,
            ps.pie_cantidad_disponible,
            COALESCE(SUM(dss.dss_cantidad), 0)::INT as entradas,
            COALESCE(SUM(esp.edz_cantidad_piezas), 0)::INT as salidas,
            (ps.pie_cantidad_disponible + COALESCE(SUM(dss.dss_cantidad), 0) - COALESCE(SUM(esp.edz_cantidad_piezas), 0))::INT,
            (ps.pie_cantidad_disponible * COALESCE((
                                                       SELECT MAX(p.pago_monto)
                                                       FROM PAGO p
                                                                JOIN SOLICITUD_PROVEEDOR sp ON p.fk_spr_id = sp.spr_id
                                                       WHERE EXTRACT(YEAR FROM p.pago_fecha) = anio
                                                   ), 0))::NUMERIC
        FROM PIEZA_STOCK ps
                 JOIN SEDE_PLANTA s ON ps.fk_sed_id = s.sed_id
                 LEFT JOIN DETALLE_SLD_SEDE dss ON ps.pie_id = dss.fk_pie_id
                 LEFT JOIN ENSAMBLE_SOLICITUD_PIEZA esp ON ps.pie_id = esp.fk_pie_id
        WHERE EXTRACT(YEAR FROM ps.pie_fecha_fabricacion) = anio
        GROUP BY
            s.sed_nombre,
            EXTRACT(MONTH FROM ps.pie_fecha_fabricacion),
            ps.pie_nombre,
            ps.pie_cantidad_disponible
        ORDER BY
            s.sed_nombre,
            EXTRACT(MONTH FROM ps.pie_fecha_fabricacion);
END;
$$ LANGUAGE plpgsql;

-- =========================================================
-- Procedimiento almacenado para obtener Producción por Sede
-- =========================================================
DROP FUNCTION IF EXISTS SP_REPORTE_PRODUCCION_SEDE(INT);

CREATE OR REPLACE FUNCTION SP_REPORTE_PRODUCCION_SEDE(anio INT)
    RETURNS TABLE (
                      sede_nombre VARCHAR(100),
                      total_aviones BIGINT,
                      total_piezas BIGINT,
                      total_pruebas BIGINT,
                      empleados_activos BIGINT,
                      procesos_completados BIGINT,
                      procesos_pendientes BIGINT,
                      porcentaje_completado NUMERIC
                  ) AS $$
BEGIN
    RETURN QUERY
        SELECT
            s.sed_nombre::VARCHAR(100),
            COUNT(DISTINCT fea.fk_sct_id)::BIGINT,
            COUNT(DISTINCT ps.pie_id)::BIGINT,
            COUNT(DISTINCT pps.fk_pru_id)::BIGINT,
            COUNT(DISTINCT ec.fk_per_id)::BIGINT,
            COUNT(DISTINCT CASE
                               WHEN fea.fln_fecha_fin IS NOT NULL
                                   THEN fea.fk_eav_id
                END)::BIGINT,
            COUNT(DISTINCT CASE
                               WHEN fea.fln_fecha_fin IS NULL
                                   THEN fea.fk_eav_id
                END)::BIGINT,
            ROUND(
                    (COUNT(DISTINCT CASE
                                        WHEN fea.fln_fecha_fin IS NOT NULL
                                            THEN fea.fk_eav_id
                        END)::NUMERIC * 100.0 /
                     NULLIF(COUNT(DISTINCT fea.fk_eav_id), 0)
                        ), 2
            )::NUMERIC
        FROM SEDE_PLANTA s
                 LEFT JOIN AREA a ON s.sed_id = a.fk_sed_id
                 LEFT JOIN ZONA z ON a.are_id = z.fk_are_id
                 LEFT JOIN FASE_ENSAMBLE_AVION fea ON z.zon_id = fea.fk_zon_id
                 LEFT JOIN PIEZA_STOCK ps ON s.sed_id = ps.fk_sed_id
                 LEFT JOIN PRUEBA_PIEZA_SEDE pps ON ps.pie_id = pps.fk_pie_id
                 LEFT JOIN EMPLEADO_CARGO ec ON ec.emc_fecha_fin IS NULL
        WHERE DATE_PART('year', COALESCE(fea.fln_fecha_inicio, CURRENT_DATE)) = anio
        GROUP BY s.sed_nombre
        ORDER BY s.sed_nombre;
END;
$$ LANGUAGE plpgsql;

-- =========================================================
-- Procedimiento almacenado para obtener Listado de Proveedores
-- =========================================================
DROP FUNCTION IF EXISTS SP_REPORTE_LISTADO_PROVEEDORES;

CREATE OR REPLACE FUNCTION SP_REPORTE_LISTADO_PROVEEDORES()
    RETURNS TABLE (
                      proveedor_nombre VARCHAR(30),
                      ubicacion VARCHAR(90),
                      cantidad_materiales BIGINT,
                      precio_promedio NUMERIC,
                      anios_operacion BIGINT,
                      total_solicitudes BIGINT,
                      total_ventas NUMERIC,
                      porcentaje_cumplimiento NUMERIC
                  ) AS $$
BEGIN
    RETURN QUERY
        SELECT
            p.com_nombre::VARCHAR(30),
            l.lug_nombre::VARCHAR(90),
            COUNT(DISTINCT pms.fk_rpm_id)::BIGINT as cantidad_materiales,
            ROUND(AVG(pms.mtp_precio)::NUMERIC, 2) as precio_promedio,
            (EXTRACT(YEAR FROM CURRENT_DATE) -
             EXTRACT(YEAR FROM p.com_fechaI_operaciones))::BIGINT as anios_operacion,
            COUNT(DISTINCT sp.spr_id)::BIGINT as total_solicitudes,
            COALESCE(SUM(sp.spr_total), 0)::NUMERIC as total_ventas,
            ROUND(
                    (COUNT(CASE
                               WHEN esp.ups_fecha_fin IS NOT NULL
                                   THEN 1
                        END)::NUMERIC * 100 /
                     NULLIF(COUNT(sp.spr_id), 0)
                        ), 2
            )::NUMERIC as porcentaje_cumplimiento
        FROM PROVEEDOR p
                 JOIN LUGAR l ON p.fk_lug_id = l.lug_id
                 LEFT JOIN PROVEEDOR_MP_STOCK pms ON p.fk_mtp_id = pms.mtp_id
                 LEFT JOIN SOLICITUD_PROVEEDOR sp ON p.com_id = sp.fk_com_id
                 LEFT JOIN ESTATUS_SSP esp ON sp.spr_id = esp.fk_spr_id
        GROUP BY
            p.com_nombre,
            l.lug_nombre,
            p.com_fechaI_operaciones
        ORDER BY total_ventas DESC;
END;
$$ LANGUAGE plpgsql;


-- =========================================================
-- Procedimiento almacenado para obtener Ingresos a Inventario
-- =========================================================
DROP FUNCTION IF EXISTS SP_REPORTE_INGRESOS_INVENTARIO(INT);

CREATE OR REPLACE FUNCTION SP_REPORTE_INGRESOS_INVENTARIO(anio INT)
    RETURNS TABLE (
                      sede_nombre VARCHAR(100),
                      mes_ingreso TEXT,
                      material_nombre VARCHAR(50),
                      cantidad INT,
                      unidad_medida VARCHAR(30),
                      proveedor_nombre VARCHAR(30),
                      costo_unitario NUMERIC,
                      costo_total NUMERIC,
                      estado_solicitud VARCHAR(50)
                  ) AS $$
BEGIN
    RETURN QUERY
        SELECT
            s.sed_nombre::VARCHAR(100),
            TO_CHAR(sp.spr_fecha, 'TMMonth')::TEXT,
            mp.rpm_nombre::VARCHAR(50),
            dsp.dsp_cantidad::INT,
            dsp.dsp_unidad_medida::VARCHAR(30),
            p.com_nombre::VARCHAR(30),
            pms.mtp_precio::NUMERIC,
            (dsp.dsp_cantidad * pms.mtp_precio)::NUMERIC,
            e.est_tipo_estatus::VARCHAR(50)
        FROM SOLICITUD_PROVEEDOR sp
                 JOIN SEDE_PLANTA s ON sp.fk_sed_id = s.sed_id
                 JOIN MATERIA_PRIMA mp ON sp.fk_rpm_id = mp.rpm_id
                 JOIN DETALLE_SLD_PROVEEDOR dsp ON sp.spr_id = dsp.fk_spr_id
                 JOIN PROVEEDOR p ON sp.fk_com_id = p.com_id
                 JOIN PROVEEDOR_MP_STOCK pms ON dsp.fk_mtp_id = pms.mtp_id
                 LEFT JOIN ESTATUS_SSP esp ON sp.spr_id = esp.fk_spr_id
                 LEFT JOIN ESTATUS e ON esp.fk_est_id = e.est_id
        WHERE DATE_PART('year', sp.spr_fecha) = anio
        ORDER BY
            s.sed_nombre,
            sp.spr_fecha,
            mp.rpm_nombre;
END;
$$ LANGUAGE plpgsql;

-- =========================================================
-- Procedimiento almacenado para obtener Pagos a Proveedores
-- =========================================================
DROP FUNCTION IF EXISTS SP_REPORTE_PAGOS_PROVEEDORES(INT);

CREATE OR REPLACE FUNCTION SP_REPORTE_PAGOS_PROVEEDORES(anio INT)
    RETURNS TABLE (
                      mes TEXT,
                      proveedor_nombre VARCHAR(30),
                      solicitud_id INT,
                      fecha_pago DATE,
                      monto_pagado NUMERIC,
                      metodo_pago VARCHAR(60),
                      moneda VARCHAR(20),
                      tasa_cambio FLOAT,
                      estado_pago VARCHAR(50)
                  ) AS $$
BEGIN
    RETURN QUERY
        SELECT
            TO_CHAR(p.pago_fecha, 'TMMonth')::TEXT,
            pv.com_nombre::VARCHAR(30),
            sp.spr_id::INT,
            p.pago_fecha::DATE,
            p.pago_monto::NUMERIC,
            mp.tipo_metodo::VARCHAR(60),
            m.mon_tipo::VARCHAR(20),
            m.mon_valor_cambio::FLOAT,
            e.est_tipo_estatus::VARCHAR(50)
        FROM PAGO p
                 JOIN SOLICITUD_PROVEEDOR sp ON p.fk_spr_id = sp.spr_id
                 JOIN PROVEEDOR pv ON sp.fk_com_id = pv.com_id
                 JOIN METODO_PAGO mp ON p.fk_met_id = mp.met_id
                 JOIN MONEDA m ON p.fk_mon_id = m.mon_id
                 LEFT JOIN ESTATUS_SSP esp ON sp.spr_id = esp.fk_spr_id
                 LEFT JOIN ESTATUS e ON esp.fk_est_id = e.est_id
        WHERE DATE_PART('year', p.pago_fecha) = anio
        ORDER BY
            p.pago_fecha,
            pv.com_nombre;
END;
$$ LANGUAGE plpgsql;

-- =========================================================
-- Procedimiento almacenado para obtener Modelo-Piezas
-- =========================================================
DROP FUNCTION IF EXISTS SP_REPORTE_MODELO_PIEZAS;

CREATE OR REPLACE FUNCTION SP_REPORTE_MODELO_PIEZAS()
    RETURNS TABLE (
                      modelo_avion VARCHAR(50),
                      tipo_avion VARCHAR(50),
                      nombre_pieza VARCHAR(50),
                      tipo_pieza VARCHAR(50),
                      cantidad_requerida INT,
                      materiales_requeridos TEXT,
                      cantidad_procesos BIGINT,
                      costo_estimado NUMERIC
                  ) AS $$
BEGIN
    RETURN QUERY
        SELECT
            mac.mda_nombre::VARCHAR(50),
            ta.tiv_nombre::VARCHAR(50),
            mpc.mec_nombre_pieza::VARCHAR(50),
            tpc.tpc_nombre::VARCHAR(50),
            ac.ctm_cantidad_piezas::INT,
            STRING_AGG(
                    DISTINCT COALESCE(
                    mp.mac_nombre_material || ' (' ||
                    mf.mtf_cantidad_material::TEXT || ' ' ||
                    mf.mtf_unidad_medida || ')',
                    'Sin materiales'
                             ),
                    '; '
            )::TEXT,
            COUNT(DISTINCT pepc.epc_id)::BIGINT,
            COALESCE(AVG(mf.mtf_cantidad_material), 0)::NUMERIC
        FROM MODELO_AVION_CONF mac
                 JOIN TIPO_AVION ta ON mac.fk_tiv_id = ta.tiv_id
                 JOIN AVION_COMPONENTE ac ON mac.mda_id = ac.fk_mda_id
                 JOIN MODELO_PIEZA_CONF mpc ON ac.fk_mec_id = mpc.mec_id
                 JOIN TIPO_PIEZA_CONF tpc ON mpc.fk_tpc_id = tpc.tpc_id
                 LEFT JOIN MATERIAL_FASE mf ON mpc.mec_id = mf.fk_mec_id
                 LEFT JOIN MATERIAL_PIEZA_CONF mp ON mf.fk_mac_id = mp.mac_id
                 LEFT JOIN FASE_ENSAMBLE_PIEZA_CONF fepc ON mpc.mec_id = fepc.fk_mec_id
                 LEFT JOIN PROCESO_ENSAMBLE_PIEZA_CONF pepc ON fepc.fk_epc_id = pepc.epc_id
        GROUP BY
            mac.mda_nombre,
            ta.tiv_nombre,
            mpc.mec_nombre_pieza,
            tpc.tpc_nombre,
            ac.ctm_cantidad_piezas
        ORDER BY
            mac.mda_nombre,
            mpc.mec_nombre_pieza;
END;
$$ LANGUAGE plpgsql;

-- =========================================================
-- Procedimiento almacenado para obtener Modelo-Pruebas
-- =========================================================
DROP FUNCTION IF EXISTS SP_REPORTE_MODELO_PRUEBAS;

CREATE OR REPLACE FUNCTION SP_REPORTE_MODELO_PRUEBAS()
    RETURNS TABLE (
                      modelo_avion VARCHAR(50),
                      nombre_prueba VARCHAR(255),
                      total_pruebas BIGINT,
                      pruebas_exitosas BIGINT,
                      porcentaje_exito NUMERIC,
                      estado_general VARCHAR(50),
                      observaciones TEXT
                  ) AS $$
BEGIN
    RETURN QUERY
        SELECT
            mac.mda_nombre::VARCHAR(50),
            pc.prc_nombre_prueba::VARCHAR(255),
            COUNT(DISTINCT pps.fk_pru_id)::BIGINT,
            COUNT(DISTINCT CASE
                               WHEN pps.psz_resultado = 'EXITOSA'
                                   THEN pps.fk_pru_id
                END)::BIGINT,
            ROUND(
                    (COUNT(DISTINCT CASE
                                        WHEN pps.psz_resultado = 'EXITOSA'
                                            THEN pps.fk_pru_id
                        END)::NUMERIC * 100.0 /
                     NULLIF(COUNT(DISTINCT pps.fk_pru_id), 0)
                        ), 2
            )::NUMERIC,
            CASE
                WHEN COUNT(DISTINCT CASE
                                        WHEN pps.psz_resultado = 'EXITOSA'
                                            THEN pps.fk_pru_id
                    END) >= COUNT(DISTINCT pps.fk_pru_id) * 0.8
                    THEN 'SATISFACTORIO'
                WHEN COUNT(DISTINCT CASE
                                        WHEN pps.psz_resultado = 'EXITOSA'
                                            THEN pps.fk_pru_id
                    END) >= COUNT(DISTINCT pps.fk_pru_id) * 0.5
                    THEN 'REGULAR'
                ELSE 'NECESITA MEJORAS'
                END::VARCHAR(50),
            STRING_AGG(
                    DISTINCT CASE
                                 WHEN pps.psz_resultado = 'FALLIDA'
                                     THEN COALESCE(e.est_descripcion, 'Sin observaciones')
                END,
                    '; '
            )::TEXT
        FROM MODELO_AVION_CONF mac
                 JOIN FASE_PRUEBA fp ON mac.mda_id = fp.fk_mda_id
                 JOIN PRUEBA_CONF pc ON fp.fk_prc_id = pc.prc_id
                 LEFT JOIN PRUEBA_PIEZA_SEDE pps ON pc.prc_id = pps.fk_pru_id
                 LEFT JOIN ESTATUS_PPS eps ON pps.fk_pie_id = eps.fk_pie_id
            AND pps.fk_zon_id = eps.fk_zon_id
            AND pps.fk_pru_id = eps.fk_pru_id
                 LEFT JOIN ESTATUS e ON eps.fk_est_id = e.est_id
        GROUP BY
            mac.mda_nombre,
            pc.prc_nombre_prueba
        ORDER BY
            mac.mda_nombre,
            pc.prc_nombre_prueba;
END;
$$ LANGUAGE plpgsql;

-- =========================================================
-- Procedimiento almacenado para obtener Horarios de Empleados
-- =========================================================
DROP FUNCTION IF EXISTS SP_REPORTE_EMPLEADOS_HORARIOS;

CREATE OR REPLACE FUNCTION SP_REPORTE_EMPLEADOS_HORARIOS()
    RETURNS TABLE (
                      empleado_dni VARCHAR(50),
                      empleado_nombre TEXT,
                      cargo_actual VARCHAR(50),
                      dia_semana VARCHAR(9),
                      hora_inicio TIME,
                      hora_fin TIME,
                      horas_asignadas NUMERIC,
                      asistencias_mes BIGINT,
                      promedio_puntualidad NUMERIC,
                      horas_extra_mes NUMERIC
                  ) AS $$
BEGIN
    RETURN QUERY
        SELECT
            e.per_dni,
            (e.per_nombre || ' ' || e.per_apellido)::TEXT,
            c.car_nombre,
            h.hor_dia,
            h.hor_hora_inicio,
            h.hor_hora_fin,
            EXTRACT(EPOCH FROM (h.hor_hora_fin - h.hor_hora_inicio))/3600::NUMERIC,
            COUNT(DISTINCT a.asi_id) as total_asistencias,
            AVG(
                    CASE
                        WHEN a.asi_hora_inicio <= h.hor_hora_inicio THEN 100
                        WHEN a.asi_hora_inicio > h.hor_hora_inicio THEN
                            100 - (EXTRACT(EPOCH FROM (a.asi_hora_inicio - h.hor_hora_inicio))/60)
                        END
            )::NUMERIC as puntualidad,
            COALESCE(
                    SUM(
                            CASE
                                WHEN EXTRACT(EPOCH FROM (a.asi_hora_fin - a.asi_hora_inicio))/3600 >
                                     EXTRACT(EPOCH FROM (h.hor_hora_fin - h.hor_hora_inicio))/3600
                                    THEN EXTRACT(EPOCH FROM (a.asi_hora_fin - a.asi_hora_inicio))/3600 -
                                         EXTRACT(EPOCH FROM (h.hor_hora_fin - h.hor_hora_inicio))/3600
                                ELSE 0
                                END
                    ), 0
            )::NUMERIC as horas_extra
        FROM EMPLEADO e
                 JOIN EMPLEADO_CARGO ec ON e.per_id = ec.fk_per_id
                 JOIN CARGO c ON ec.fk_car_id = c.car_id
                 JOIN EMP_CARGO_HORARIO ech ON ec.fk_per_id = ech.fk_per_id
            AND ec.fk_car_id = ech.fk_car_id
            AND ec.emc_id = ech.fk_emc_id
                 JOIN HORARIO h ON ech.fk_hor_id = h.hor_id
                 LEFT JOIN ASISTENCIA a ON e.per_id = a.fk_per_id
            AND EXTRACT(MONTH FROM CURRENT_DATE) = EXTRACT(MONTH FROM CURRENT_DATE)
        WHERE ec.emc_fecha_fin IS NULL
        GROUP BY
            e.per_dni,
            e.per_nombre,
            e.per_apellido,
            c.car_nombre,
            h.hor_dia,
            h.hor_hora_inicio,
            h.hor_hora_fin
        ORDER BY
            e.per_nombre,
            e.per_apellido,
            h.hor_dia;
END;
$$ LANGUAGE plpgsql;

-- =========================================================
-- Procedimiento almacenado para obtener Empleados en Proyectos
-- =========================================================
DROP FUNCTION IF EXISTS SP_REPORTE_EMPLEADOS_PROYECTOS;

CREATE OR REPLACE FUNCTION SP_REPORTE_EMPLEADOS_PROYECTOS()
    RETURNS TABLE (
                      empleado_dni VARCHAR(50),
                      empleado_nombre TEXT,
                      cargo TEXT,
                      zona_asignada TEXT,
                      area_trabajo TEXT,
                      sede_actual TEXT,
                      proyectos_activos BIGINT,
                      procesos_completados BIGINT,
                      piezas_procesadas BIGINT,
                      eficiencia_promedio NUMERIC
                  ) AS $$
BEGIN
    RETURN QUERY
        SELECT
            e.per_dni::VARCHAR(50),
            (e.per_nombre || ' ' || e.per_apellido)::TEXT,
            STRING_AGG(DISTINCT c.car_nombre, ', ')::TEXT,
            STRING_AGG(DISTINCT COALESCE(z.zon_nombre, 'Sin zona'), ', ')::TEXT,
            STRING_AGG(DISTINCT COALESCE(a.are_nombre, 'Sin área'), ', ')::TEXT,
            STRING_AGG(DISTINCT COALESCE(s.sed_nombre, 'Sin sede'), ', ')::TEXT,
            COUNT(DISTINCT ee.eqc_id)::BIGINT,
            COUNT(DISTINCT CASE
                               WHEN fea.fln_fecha_fin IS NOT NULL
                                   THEN fea.fk_eav_id
                END)::BIGINT,
            COUNT(DISTINCT esp.edz_id)::BIGINT,
            ROUND(
                    (COUNT(DISTINCT CASE
                                        WHEN fea.fln_fecha_fin IS NOT NULL
                                            THEN fea.fk_eav_id
                        END)::NUMERIC * 100.0 /
                     NULLIF(COUNT(DISTINCT ee.eqc_id), 0)
                        ), 2
            )::NUMERIC
        FROM EMPLEADO e
                 JOIN EMPLEADO_CARGO ec ON e.per_id = ec.fk_per_id
                 JOIN CARGO c ON ec.fk_car_id = c.car_id
                 LEFT JOIN EQUIPO_ENCARGADO ee ON e.per_id = ee.fk_per_id
                 LEFT JOIN ZONA z ON ee.fk_zon_id = z.zon_id
                 LEFT JOIN AREA a ON z.fk_are_id = a.are_id
                 LEFT JOIN SEDE_PLANTA s ON a.fk_sed_id = s.sed_id
                 LEFT JOIN FASE_ENSAMBLE_AVION fea ON z.zon_id = fea.fk_zon_id
                 LEFT JOIN ENSAMBLE_SOLICITUD_PIEZA esp ON ee.fk_edz_id = esp.edz_id
        WHERE ec.emc_fecha_fin IS NULL
        GROUP BY
            e.per_dni,
            e.per_nombre,
            e.per_apellido
        ORDER BY
            proyectos_activos DESC,
            eficiencia_promedio DESC;
END;
$$ LANGUAGE plpgsql;

-- =========================================================
-- Procedimiento almacenado para obtener Rentabilidad por Cumplimiento
-- =========================================================
DROP FUNCTION IF EXISTS SP_REPORTE_RENTABILIDAD_CUMPLIMIENTO(INT);

CREATE OR REPLACE FUNCTION SP_REPORTE_RENTABILIDAD_CUMPLIMIENTO(anio INT)
    RETURNS TABLE (
                      modelo_avion VARCHAR(50),
                      tipo_avion VARCHAR(50),
                      cantidad_producida BIGINT,
                      precio_base NUMERIC,
                      costos_materiales NUMERIC,
                      ingreso_total NUMERIC,
                      margen_rentabilidad NUMERIC,
                      estado_rentabilidad VARCHAR(20)
                  ) AS $$
BEGIN
    RETURN QUERY
        SELECT
            mac.mda_nombre::VARCHAR(50),
            ta.tiv_nombre::VARCHAR(50),
            COUNT(DISTINCT ac.avi_id)::BIGINT,
            mac.mda_precio::NUMERIC,
            COALESCE(SUM(sp.spr_total), 0)::NUMERIC,
            (COUNT(DISTINCT ac.avi_id) * mac.mda_precio)::NUMERIC,
            CASE
                WHEN COALESCE(SUM(sp.spr_total), 0) = 0 THEN 100
                ELSE ROUND(((mac.mda_precio - COALESCE(SUM(sp.spr_total), 0)) / mac.mda_precio * 100)::NUMERIC, 2)
                END,
            CASE
                WHEN mac.mda_precio > COALESCE(SUM(sp.spr_total), 0) THEN 'RENTABLE'
                ELSE 'NO RENTABLE'
                END::VARCHAR(20)
        FROM MODELO_AVION_CONF mac
                 JOIN TIPO_AVION ta ON mac.fk_tiv_id = ta.tiv_id
                 LEFT JOIN AVION_CREADO ac ON ac.avi_fecha_creacion >= make_date(anio, 1, 1)
            AND ac.avi_fecha_creacion < make_date(anio + 1, 1, 1)
                 LEFT JOIN SOLICITUD_PROVEEDOR sp ON sp.spr_fecha >= make_date(anio, 1, 1)
            AND sp.spr_fecha < make_date(anio + 1, 1, 1)
        GROUP BY
            mac.mda_nombre,
            ta.tiv_nombre,
            mac.mda_precio
        HAVING COUNT(DISTINCT ac.avi_id) > 0
        ORDER BY margen_rentabilidad DESC;
END;
$$ LANGUAGE plpgsql;


-- =========================================================
-- Procedimiento almacenado para obtener Tipos de Alas más Usados
-- =========================================================
DROP FUNCTION IF EXISTS SP_REPORTE_TIPOS_ALAS_USADOS;

CREATE OR REPLACE FUNCTION SP_REPORTE_TIPOS_ALAS_USADOS()
    RETURNS TABLE (
                      tipo_ala VARCHAR(50),
                      modelos_avion TEXT,
                      cantidad_usada BIGINT,
                      material_principal VARCHAR(80),
                      descripcion_tipo VARCHAR(255)
                  ) AS $$
BEGIN
    RETURN QUERY
        SELECT
            tpc.tpc_nombre::VARCHAR(50),
            STRING_AGG(DISTINCT mac.mda_nombre, ', ')::TEXT,
            COUNT(DISTINCT ac.fk_mec_id)::BIGINT,
            COALESCE(mp.mac_nombre_material, 'No especificado')::VARCHAR(80),
            tpc.tpc_descripcion::VARCHAR(255)
        FROM TIPO_PIEZA_CONF tpc
                 JOIN MODELO_PIEZA_CONF mpc ON tpc.tpc_id = mpc.fk_tpc_id
                 JOIN AVION_COMPONENTE ac ON mpc.mec_id = ac.fk_mec_id
                 JOIN MODELO_AVION_CONF mac ON ac.fk_mda_id = mac.mda_id
                 LEFT JOIN MATERIAL_FASE mf ON mpc.mec_id = mf.fk_mec_id
                 LEFT JOIN MATERIAL_PIEZA_CONF mp ON mf.fk_mac_id = mp.mac_id
        WHERE LOWER(tpc.tpc_nombre) LIKE '%ala%'
        GROUP BY
            tpc.tpc_id,
            tpc.tpc_nombre,
            tpc.tpc_descripcion,
            mp.mac_nombre_material
        ORDER BY cantidad_usada DESC;
END;
$$ LANGUAGE plpgsql;
