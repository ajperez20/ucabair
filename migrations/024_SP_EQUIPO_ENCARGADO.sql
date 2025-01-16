DROP FUNCTION IF EXISTS registrar_equipo_encargado(
    INT, INT, INT, INT, INT, INT, INT, INT, INT, INT, VARCHAR
);

CREATE OR REPLACE FUNCTION registrar_equipo_encargado(
    zona_id INT,
    proceso_pieza_id INT,
    proceso_avion_id INT,
    fase_pieza_id INT,
    prueba_id INT,
    pieza_id INT,
    solicitud_cliente_id INT,
    modelo_avion_id INT,
    solicitud_pieza_id INT,
    empleado_id INT,
    descripcion VARCHAR(255)
)
RETURNS TABLE (
    equipo INT,
    mensaje VARCHAR
) AS $$
DECLARE 
    equipo_id INT;
BEGIN
    -- Insertar datos en la tabla EQUIPO_ENCARGADO
    INSERT INTO EQUIPO_ENCARGADO (
        fk_zon_id,
        fk_esp_id,
        fk_eez_id,
        fk_pru_id,
        fk_pie_id,
        fk_sct_id,
        fk_eav_id,
        fk_mda_id,
        fk_edz_id,
        fk_per_id,
        eqc_descripcion
    ) VALUES (
        zona_id,
        proceso_pieza_id,
        fase_pieza_id,
        prueba_id,
        pieza_id,
        solicitud_cliente_id,
        proceso_avion_id,
        modelo_avion_id,
        solicitud_pieza_id,
        empleado_id,
        descripcion
    )
    RETURNING eqc_id INTO equipo_id;

    RETURN QUERY
        SELECT
            equipo_id,
            'Se creó el equipo exitosamente' AS mensaje;
END;
$$ LANGUAGE plpgsql;
