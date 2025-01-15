-- =========================================================
-- Procedimiento almacenado para la solicitud del cliente
-- =========================================================
DROP FUNCTION IF EXISTS REGISTRAR_SOLICITUD(INT, VARCHAR, INT, INT, VARCHAR);

CREATE OR REPLACE FUNCTION REGISTRAR_SOLICITUD(
    cliente_id INT,
    tipo VARCHAR,
    modelo_id INT,
    cantidad INT,
    sld_descripcion VARCHAR
)
    RETURNS TABLE
            (
                solicitud_id INT,
                mensaje      VARCHAR
            )
AS
$$
DECLARE
    modelo_precio INT;
BEGIN
    -- Insertar en SOLICITUD_CLIENTE
    INSERT INTO SOLICITUD_CLIENTE
    (sct_total,
     fk_cjd_id,
     fk_ctn_id,
     sct_observacion)
    VALUES (0,
            CASE WHEN tipo = 'JURIDICO' THEN cliente_id ELSE NULL END,
            CASE WHEN tipo = 'NATURAL' THEN cliente_id ELSE NULL END,
            sld_descripcion)
    RETURNING
        sct_id
        INTO
            solicitud_id;

    -- Insertar en DETALLE_SLD_CLIENTE
    INSERT INTO DETALLE_SLD_CLIENTE
    (ddc_cantidad_aviones,
     fk_sct_id,
     fk_mda_id)
    VALUES (cantidad,
            solicitud_id,
            modelo_id);

    -- Obtener el precio del modelo de avión
    SELECT mda_precio
    INTO modelo_precio
    FROM MODELO_AVION_CONF
    WHERE mda_id = modelo_id;

    -- Calcular el total y actualizar SOLICITUD_CLIENTE
    UPDATE SOLICITUD_CLIENTE
    SET sct_total = modelo_precio * cantidad
    WHERE sct_id = solicitud_id;

    -- Insertar el estado inicial (usando el ID 3 que corresponde a 'Pendiente')
    INSERT INTO ESTATUS_SCAV (scv_fecha_inicio,
                              fk_sct_id,
                              fk_est_id)
    VALUES (CURRENT_DATE,
            solicitud_id,
            3 -- ID del estado 'Pendiente'
           );

    -- Retornar el ID de la solicitud y el mensaje de éxito
    RETURN QUERY SELECT solicitud_id, 'Solicitud creada exitosamente'::VARCHAR;
END;
$$ LANGUAGE plpgsql;

-- ================================================================
-- Procedimiento almacenado para el pago de la solicitud del cliente
-- ================================================================
DROP FUNCTION IF EXISTS registrar_pago_cliente(INT, INT, INT, INT);

CREATE OR REPLACE FUNCTION registrar_pago_cliente(
    metodo_id INT,
    moneda_id INT,
    solicitud_cliente_id INT,
    total_pagar INT
)
RETURNS TABLE (
    pago INT,
    mensaje VARCHAR(255)
) AS $$
DECLARE 
    valor_moneda FLOAT;
    moneda VARCHAR;
    total_convertido NUMERIC(100, 2);
    id_pago INT;
BEGIN
    -- Obtener la tasa de cambio y tipo de moneda
    SELECT mon_valor_cambio, mon_tipo 
    INTO valor_moneda, moneda
    FROM MONEDA
    WHERE mon_id = moneda_id;

    -- Usar CASE para determinar la moneda y realizar el insert correspondiente
    CASE 
        WHEN moneda = '$' THEN
            INSERT INTO PAGO (pago_monto, pago_fecha, fk_mon_id, fk_met_id, fk_sct_id)
            VALUES (total_pagar, CURRENT_DATE, moneda_id, metodo_id, solicitud_cliente_id)
            RETURNING pago_id INTO id_pago;

        WHEN moneda = '€' THEN
            total_convertido = total_pagar / valor_moneda;
            INSERT INTO PAGO (pago_monto, pago_fecha, fk_mon_id, fk_met_id, fk_sct_id)
            VALUES (total_convertido, CURRENT_DATE, moneda_id, metodo_id, solicitud_cliente_id)
            RETURNING pago_id INTO id_pago;

        WHEN moneda = 'BS' THEN
            total_convertido = total_pagar * valor_moneda;
            INSERT INTO PAGO (pago_monto, pago_fecha, fk_mon_id, fk_met_id, fk_sct_id)
            VALUES (total_convertido, CURRENT_DATE, moneda_id, metodo_id, solicitud_cliente_id)
            RETURNING pago_id INTO id_pago;
    END CASE;
    
    -- Retornar el id del pago y un mensaje
    RETURN QUERY SELECT id_pago, 'Pago creado exitosamente'::VARCHAR;
END;
$$ LANGUAGE plpgsql;



