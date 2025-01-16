-- =========================================================
-- Procedimiento almacenado para calcular el pago de los 
-- empleados según las horas de trabajo cumplidas.
-- =========================================================

DROP FUNCTION IF EXISTS calcular_pago_empleado(INT);

CREATE OR REPLACE FUNCTION calcular_pago_empleado(empleado_id_input INT)
RETURNS TABLE(empleado_id INT, pago_total NUMERIC) AS $$
DECLARE
    horas_establecidas NUMERIC;
    horas_cumplidas NUMERIC;
    horas_extras NUMERIC;
    pago_total NUMERIC;
    precio_por_hora CONSTANT NUMERIC := 15;
BEGIN
    SELECT 
        SUM(EXTRACT(EPOCH FROM (hor.hor_hora_fin - hor.hor_hora_inicio)) / 3600) 
    INTO 
        horas_establecidas
    FROM 
        EMP_CARGO_HORARIO ech
    JOIN 
        HORARIO hor ON ech.fk_hor_id = hor.hor_id
    WHERE 
        ech.fk_per_id = empleado_id_input
    GROUP BY 
        ech.fk_per_id;

    SELECT 
        SUM(EXTRACT(EPOCH FROM (asi.asi_hora_fin - asi.asi_hora_inicio)) / 3600)
    INTO 
        horas_cumplidas
    FROM 
        ASISTENCIA asi
    WHERE 
        asi.fk_per_id = empleado_id_input
        AND asi.asi_hora_fin IS NOT NULL;

    IF horas_cumplidas IS NULL THEN
        horas_cumplidas := 0;
    END IF;

    IF horas_cumplidas > horas_establecidas THEN
        horas_extras := horas_cumplidas - horas_establecidas;
    ELSE
        horas_extras := 0;
    END IF;

    pago_total := ROUND((horas_establecidas * precio_por_hora) + (horas_extras * precio_por_hora));

    RETURN QUERY SELECT empleado_id_input AS empleado_id, pago_total;
END;
$$ LANGUAGE plpgsql;

-- ================================================================
-- Procedimiento almacenado para el pago de nomina
-- ================================================================

DROP FUNCTION IF EXISTS registrar_pago_nomina(INT, INT, INT, INT);

CREATE OR REPLACE FUNCTION registrar_pago_nomina(
    metodo_id INT,
    moneda_id INT,
    nomina_id INT,
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
            INSERT INTO PAGO (pago_monto, pago_fecha, fk_mon_id, fk_met_id, fk_pnn_id)
            VALUES (total_pagar, CURRENT_DATE, moneda_id, metodo_id, nomina_id)
            RETURNING pago_id INTO id_pago;

        WHEN moneda = '€' THEN
            total_convertido = total_pagar / valor_moneda;
            INSERT INTO PAGO (pago_monto, pago_fecha, fk_mon_id, fk_met_id, fk_pnn_id)
            VALUES (total_convertido, CURRENT_DATE, moneda_id, metodo_id, nomina_id)
            RETURNING pago_id INTO id_pago;

        WHEN moneda = 'BS' THEN
            total_convertido = total_pagar * valor_moneda;
            INSERT INTO PAGO (pago_monto, pago_fecha, fk_mon_id, fk_met_id, fk_pnn_id)
            VALUES (total_convertido, CURRENT_DATE, moneda_id, metodo_id, nomina_id)
            RETURNING pago_id INTO id_pago;
    END CASE;
    
    -- Retornar el id del pago y un mensaje
    RETURN QUERY SELECT id_pago, 'Pago creado exitosamente'::VARCHAR;
END;
$$ LANGUAGE plpgsql;