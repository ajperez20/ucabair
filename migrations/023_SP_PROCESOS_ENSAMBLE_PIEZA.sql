-- =========================================================
-- procedimiento almacenado para generar FASE_ENSAMBLE_PIEZA 
-- =========================================================

DROP FUNCTION IF EXISTS registrar_ensamble_pieza(INT, INT, INT);

CREATE OR REPLACE FUNCTION registrar_ensamble_pieza(
    zona_id INT,
    proceso_id INT,
    pieza_id INT
)
RETURNS TABLE (
    zona INT,
    proceso INT,
    pieza INT,
    fase INT,
    mensaje TEXT
) AS $$
DECLARE
    fase_id INT;
BEGIN
    -- Insertar un nuevo registro en la tabla FASE_ENSAMBLE_PIEZA
    INSERT INTO FASE_ENSAMBLE_PIEZA (eez_fecha_inicio, eez_fecha_fin, fk_esp_id, fk_zon_id, fk_pie_id)
    VALUES (CURRENT_DATE, NULL, proceso_id, zona_id, pieza_id)
    RETURNING eez_id INTO fase_id;
    
    -- Insertar un nuevo registro en la tabla ESTATUS_FEP
    INSERT INTO ESTATUS_FEP (sfe_fecha_inicio, sfe_fecha_fin, fk_esp_id, fk_zon_id, fk_eez_id, fk_est_id)
    VALUES (CURRENT_DATE, NULL, proceso_id, zona_id, fase_id, 3);
    
    -- Retornar los valores y el mensaje
    RETURN QUERY SELECT zona_id, proceso_id, pieza_id, fase_id, 'Fase Ensamble Pieza creado exitosamente';
END;
$$ LANGUAGE plpgsql;
