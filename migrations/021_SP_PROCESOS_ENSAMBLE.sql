-- =========================================================
-- Procedimiento almacenado para generar FASE_ENSAMBLE_AVIÓN
-- =========================================================

DROP FUNCTION IF EXISTS registrar_proceso_ensamble(INT, INT, INT, INT);

CREATE OR REPLACE FUNCTION registrar_proceso_ensamble(
    modelo_id INT,
    solicitud_id INT,
    zona_id INT,
    proceso_id INT
)
RETURNS 
	TABLE 
		(
			proceso INT,
			modelo INT,
			zona INT,
			solicitud INT,
			mensaje VARCHAR
		) 
AS $$
DECLARE
    nuevo_fase_id RECORD;
BEGIN
    -- Inserción en la tabla FASE_ENSAMBLE_AVION y obtención del ID insertado
    INSERT INTO FASE_ENSAMBLE_AVION (fln_fecha_inicio, fln_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id)
    VALUES (CURRENT_DATE, NULL, proceso_id, modelo_id, zona_id, solicitud_id);

    -- Inserción en la tabla ESTATUS_FEA
    INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
    VALUES (CURRENT_DATE, NULL, proceso_id, modelo_id, zona_id, solicitud_id, 3);

    -- Mensaje de confirmación
    RETURN QUERY SELECT proceso_id AS proceso, modelo_id AS modelo, zona_id AS zona_id, solicitud_id AS solicitud,'Proceso ensamble creado exitosamente'::VARCHAR AS mensaje;
END;
$$ LANGUAGE plpgsql;

-- =================================================================
-- Procedimiento almacenado para generar ENSAMBLE_SOLICITUD_PIEZA
-- =================================================================

DROP FUNCTION IF EXISTS registrar_solicitud_ensamble_pieza(INT, INT, INT, INT, INT, INT);

CREATE OR REPLACE FUNCTION registrar_solicitud_ensamble_pieza(
    cantidad_pieza INT,
    proceso_id INT,
    modelo_id INT,
    zona_id INT,
    solicitud_id INT,
    pieza_id INT
)
RETURNS TABLE (
    solicitud_pieza_id INT,
    mensaje VARCHAR
) AS $$
DECLARE
    solicitud_pieza_id INT;
BEGIN
    -- Insertar en ENSAMBLE_SOLICITUD_PIEZA y obtener el edz_id generado
    INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (
        edz_cantidad_piezas, 
        fk_eav_id, 
        fk_mda_id, 
        fk_zon_id, 
        fk_sct_id, 
        fk_pie_id
    ) VALUES (
        cantidad_pieza, 
        proceso_id, 
        modelo_id, 
        zona_id, 
        solicitud_id, 
        pieza_id
    ) RETURNING edz_id INTO solicitud_pieza_id;

    -- Insertar en ESTATUS_ESP
    INSERT INTO ESTATUS_ESP (
        ets_fecha_inicio, 
        ets_fecha_fin, 
        fk_est_id, 
        fk_edz_id
    ) VALUES (
        CURRENT_DATE, 
        NULL, 
        3,
        solicitud_pieza_id
    );

    -- Establecer el mensaje de retorno
    RETURN QUERY SELECT 
        solicitud_pieza_id, 
        'Solicitud creada exitosamente'::VARCHAR AS mensaje;
END;
$$ LANGUAGE plpgsql;
