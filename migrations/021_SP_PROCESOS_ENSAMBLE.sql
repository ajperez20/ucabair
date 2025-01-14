-- =========================================================
-- Procedimiento almacenado para generar fase_ensamble_avion
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
