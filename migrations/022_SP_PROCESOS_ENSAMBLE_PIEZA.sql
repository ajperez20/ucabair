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
    mensaje VARCHAR
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
    RETURN QUERY 
    SELECT 
        zona_id, proceso_id, 
        pieza_id, fase_id, 
        'Fase Ensamble Pieza creado exitosamente'::VARCHAR AS mensaje;
END;
$$ LANGUAGE plpgsql;

-- =========================================================================
-- procedimiento almacenado para generar ENSAMBLE_SOLICITUD_MATERIA 
-- =========================================================================

DROP FUNCTION IF EXISTS registrar_solicitud_material(INT, INT, INT, INT, INT, INT, INT, VARCHAR);

CREATE OR REPLACE FUNCTION registrar_solicitud_material(
    zona_id INT,
    proceso_id INT,
    fase_id INT,
	materia_id INT,
	stok_id INT,
	sede_id INT,
    cantidad_piezas INT,
    unidad_medida VARCHAR
)
RETURNS TABLE(
    solicitud_id INT,
    mensaje TEXT
) AS $$
DECLARE
	solicitud_id INT;
    material_disponible INT;
BEGIN

    SELECT mps_cantidad_disponible 
    INTO material_disponible
    FROM MATERIA_PRIMA_STOCK
    WHERE mps_id = stok_id;

    IF cantidad_piezas <= material_disponible THEN
    -- Inserción en la tabla ENSAMBLE_SOLICITUD_MATERIA
        INSERT INTO ENSAMBLE_SOLICITUD_MATERIA (
            fk_zon_id,
            fk_esp_id,
            fk_eez_id,
            elm_cantidad,
            elm_unidad_medida,
            fk_rpm_id,
            fk_mps_id,
            fk_sed_id
        ) VALUES (
            zona_id,
            proceso_id,
            fase_id,
            cantidad_piezas,
            unidad_medida,
            materia_id,
            stok_id,
            sede_id
        )
        RETURNING elm_id INTO solicitud_id;
    
        -- Inserción en la tabla ESTATUS_SME
        INSERT INTO ESTATUS_SME (
            sme_fecha_inicio,
            sme_fecha_fin,
            fk_est_id,
            fk_elm_id,
            fk_esp_id,
            fk_zon_id,
            fk_eez_id
        ) VALUES (
            CURRENT_DATE,
            NULL,
            3,
            solicitud_id,
            proceso_id,
            zona_id,
            fase_id
        );

        -- Retorno de la tabla con solicitud_id y mensaje de confirmación
        RETURN QUERY
        SELECT
            solicitud_id,
            'Solicitud Material creada correctamente' AS mensaje;
    END IF;

    IF cantidad_piezas > material_disponible THEN
        -- Retorno de la tabla con solicitud_id y mensaje de confirmación
        RETURN QUERY
        SELECT
            0,
            'NO SE PUEDO CREAR LA SOLICITUD' AS mensaje;
    END IF;

END;
$$ LANGUAGE plpgsql;

