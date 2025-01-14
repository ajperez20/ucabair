-- =========================================================
-- Procedimiento almacenado para la solicitud del cliente
-- =========================================================
DROP FUNCTION IF EXISTS registrar_solicitud(INT, VARCHAR, INT, INT, VARCHAR);

CREATE OR REPLACE FUNCTION registrar_solicitud(
    cliente_id INT,
    tipo VARCHAR,
    modelo_id INT,
    cantidad INT,
	sld_descripcion VARCHAR
)
RETURNS TABLE (solicitud_id INT, mensaje VARCHAR) AS $$
DECLARE
    modelo_precio INT;
BEGIN
    -- Insertar en SOLICITUD_CLIENTE
    INSERT INTO SOLICITUD_CLIENTE 
		(
			sct_total, 
			fk_cjd_id, 
			fk_ctn_id, 
			sct_observacion
		)
    VALUES 
		(
			0, 
			CASE WHEN tipo = 'JURIDICO' THEN cliente_id ELSE NULL END, 
			CASE WHEN tipo = 'NATURAL' THEN cliente_id ELSE NULL END,
			sld_descripcion
		)
    RETURNING 
		sct_id 
	INTO 
		solicitud_id;

    -- Insertar en DETALLE_SLD_CLIENTE
    INSERT INTO DETALLE_SLD_CLIENTE 
		(
			ddc_cantidad_aviones, 
			fk_sct_id, 
			fk_mda_id
		)
    VALUES 
		(
			cantidad, 
			solicitud_id, 
			modelo_id
		);

    -- Obtener el precio del modelo de avión
    SELECT mda_precio INTO modelo_precio
    FROM MODELO_AVION_CONF
    WHERE mda_id = modelo_id;

    -- Calcular el total y actualizar SOLICITUD_CLIENTE
    UPDATE SOLICITUD_CLIENTE
    SET sct_total = modelo_precio * cantidad
    WHERE sct_id = solicitud_id;

    -- Retornar el ID de la solicitud y el mensaje de éxito
    RETURN QUERY SELECT solicitud_id, 'Solicitud creada exitosamente'::VARCHAR;
END;
$$ LANGUAGE plpgsql;



-- Llamada a la función
-- SELECT * FROM registrar_solicitud(1, 'NATURAL', 1, 2, 'Solicitud de AU80');





