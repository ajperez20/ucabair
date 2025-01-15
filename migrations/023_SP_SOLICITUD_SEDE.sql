-- =========================================================================
-- procedimiento almacenado para generar SOLICITUD_SEDE 
-- =========================================================================

DROP FUNCTION IF EXISTS registrar_solicitud_sedes(INT, INT, INT, VARCHAR, INT);

CREATE OR REPLACE FUNCTION registrar_solicitud_sedes(
    cantidad_piezas INT,
    sede_solicitante INT,
    sede_atiende INT,
    descripcion VARCHAR(255),
    pieza_id INT
)
RETURNS TABLE(
    solicitud_id INT,
    mensaje TEXT
) AS $$
DECLARE
    solicitud_sede_id INT;
    piezas_disponible INT;
BEGIN

    SELECT pie_cantidad_disponible 
    INTO piezas_disponible
    FROM PIEZA_STOCK
    WHERE pie_id = pieza_id;

    IF cantidad_piezas <= piezas_disponible THEN
        -- Insertar en la tabla SOLICITUD_SEDE y obtener el sse_id generado
        INSERT INTO SOLICITUD_SEDE (sse_fecha, sse_descripcion, fk_sed_atiende, fk_sed_solicita)
        VALUES (current_date, descripcion, sede_atiende, sede_solicitante)
        RETURNING sse_id INTO solicitud_sede_id;

        -- Insertar en la tabla DETALLE_SLD_SEDE
        INSERT INTO DETALLE_SLD_SEDE (dss_cantidad, dss_descripcion, fk_sse_id, fk_pie_id)
        VALUES (cantidad_piezas, descripcion, solicitud_sede_id, pieza_id);

        -- Insertar en la tabla ESTATUS_SOL_PIEZA
        INSERT INTO ESTATUS_SOL_PIEZA (slz_fecha_inicio, slz_fecha_fin, fk_sse_id, fk_est_id)
        VALUES (current_date, NULL, solicitud_sede_id, 3);

		PERFORM actualizar_estatus_solicitud(solicitud_sede_id);

        PERFORM actualizar_stock_solicitud(solicitud_sede_id);
        -- Retorno de la tabla con solicitud_id y mensaje de confirmación
        RETURN QUERY
        SELECT
            solicitud_sede_id,
            'Solicitud Material creada correctamente' AS mensaje;
    END IF;

    IF cantidad_piezas > piezas_disponible THEN
        -- Retorno de la tabla con solicitud_id y mensaje de confirmación
        RETURN QUERY
        SELECT
            0,
            'NO SE PUEDO CREAR LA SOLICITUD' AS mensaje;
    END IF;
    
END;
$$ LANGUAGE plpgsql;

-- -- =========================================================================
-- Procedimiento para actualizar pieza_stock según una solicitud_sede
-- -- =========================================================================
DROP FUNCTION IF EXISTS actualizar_estatus_solicitud(INT);
DROP FUNCTION IF EXISTS actualizar_stock_solicitud(INT);

CREATE OR REPLACE FUNCTION actualizar_estatus_solicitud(sse_id INT)
RETURNS void AS $$
BEGIN
        UPDATE ESTATUS_SOL_PIEZA ep
        SET slz_fecha_fin = CURRENT_DATE
        WHERE 
            ep.fk_sse_id = sse_id
            AND
            ep.fk_est_id = 3;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION actualizar_stock_solicitud(solicitud_id INT)
RETURNS VOID AS $$
DECLARE 
    estatus_id INT;
    sede_id INT;
    pieza_id INT;
    pieza_serial VARCHAR(255);
    pieza_fabricacion DATE;
    pieza_nombre VARCHAR(255);
    cantidad_solicitada INT;
BEGIN
    SELECT fk_pie_id, dss_cantidad
    INTO pieza_id, cantidad_solicitada
    FROM DETALLE_SLD_SEDE
    WHERE fk_sse_id = solicitud_id;

    SELECT  
        pie_numero_serial, 
        pie_nombre, 
        pie_fecha_fabricacion
    INTO
        pieza_serial,
        pieza_nombre,
        pieza_fabricacion
    FROM PIEZA_STOCK p
    WHERE 
        pie_id = pieza_id;

    SELECT fk_sed_solicita
    INTO sede_id
    FROM SOLICITUD_SEDE
    WHERE sse_id = solicitud_id;
    
    INSERT INTO ESTATUS_SOL_PIEZA 
    (
        slz_fecha_inicio, 
        slz_fecha_fin, 
        fk_sse_id, 
        fk_est_id
    )
    VALUES 
    (
        current_date, 
        NULL,
        solicitud_id, 
        5
    )
    RETURNING fk_est_id INTO estatus_id;

    IF estatus_id = 5 THEN
        INSERT INTO PIEZA_STOCK
        (
            pie_numero_serial,
            pie_nombre,
            pie_fecha_fabricacion,
            pie_cantidad_disponible,
            fk_sed_id
        )
        VALUES
        (
            pieza_serial,
            pieza_nombre,
            pieza_fabricacion,
            cantidad_solicitada,
            sede_id
        );

        UPDATE PIEZA_STOCK PS
        SET pie_cantidad_disponible = pie_cantidad_disponible - cantidad_solicitada
        WHERE PS.pie_id = pieza_id;
    END IF;
END;
$$ LANGUAGE plpgsql;
