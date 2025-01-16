-- =========================================================
-- Procedimiento almacenado para calcular el pago de los 
-- empleados según las horas de trabajo cumplidas.
-- =========================================================

DROP FUNCTION IF EXISTS calcular_pago_empleado(INT);

CREATE OR REPLACE FUNCTION calcular_pago_empleado(empleado_id_input INT)
    RETURNS TABLE(empleado_id INT, pago_total NUMERIC) AS $$
DECLARE
    horas_establecidas NUMERIC := 0;
    horas_cumplidas NUMERIC := 0;
    horas_extras NUMERIC := 0;
    pago_total NUMERIC := 0;
    precio_por_hora CONSTANT NUMERIC := 15;
BEGIN
    -- Verificar si hay asistencias sin pagar
    IF NOT EXISTS (
        SELECT 1
        FROM ASISTENCIA
        WHERE fk_per_id = empleado_id_input
          AND asi_pagada = FALSE
          AND asi_hora_fin IS NOT NULL
    ) THEN
        RETURN QUERY SELECT empleado_id_input AS empleado_id, pago_total;
        RETURN;
    END IF;

    -- Obtener horas establecidas
    SELECT
        COALESCE(SUM(EXTRACT(EPOCH FROM (hor.hor_hora_fin - hor.hor_hora_inicio)) / 3600), 0)
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

    -- Obtener horas cumplidas de asistencias no pagadas
    SELECT
        COALESCE(SUM(EXTRACT(EPOCH FROM (asi.asi_hora_fin - asi.asi_hora_inicio)) / 3600), 0)
    INTO
        horas_cumplidas
    FROM
        ASISTENCIA asi
    WHERE
        asi.fk_per_id = empleado_id_input
      AND asi.asi_hora_fin IS NOT NULL
      AND asi.asi_pagada = FALSE;

    -- Calcular horas extras
    IF horas_cumplidas > horas_establecidas THEN
        horas_extras := horas_cumplidas - horas_establecidas;
    ELSE
        horas_extras := 0;
    END IF;

    -- Calcular pago total
    pago_total := ROUND((horas_establecidas * precio_por_hora) + (horas_extras * precio_por_hora));

    -- Debug: imprimir valores
    RAISE NOTICE 'Empleado ID: %, Horas establecidas: %, Horas cumplidas: %, Horas extras: %, Pago total: %',
        empleado_id_input, horas_establecidas, horas_cumplidas, horas_extras, pago_total;

    -- Retornar resultado
    RETURN QUERY SELECT empleado_id_input AS empleado_id, pago_total;
END;
$$ LANGUAGE plpgsql;

-- ================================================================
-- Procedimiento almacenado para el pago de nomina por empleado
-- ================================================================

DROP FUNCTION IF EXISTS registrar_pago_nomina(DATE, NUMERIC, VARCHAR, INT, INT, INT);

CREATE OR REPLACE FUNCTION registrar_pago_nomina(
    fecha_pago DATE,
    total_pagar NUMERIC,
    descripcion VARCHAR,
    empleado_id INT,
    metodo_id INT,
    moneda_id INT
)
    RETURNS BOOLEAN AS $$
DECLARE
    v_nomina_id INT;
BEGIN
    -- 1. Crear el registro en PAGO_NOMINA
    INSERT INTO PAGO_NOMINA (
        pnn_fecha_pago,
        pnn_total_pago,
        pnn_descripcion,
        fk_per_id
    ) VALUES (
                 fecha_pago,
                 total_pagar,
                 descripcion,
                 empleado_id
             ) RETURNING pnn_id INTO v_nomina_id;

    -- 2. Marcar asistencias como pagadas
    UPDATE ASISTENCIA
    SET asi_pagada = TRUE
    WHERE fk_per_id = empleado_id
      AND asi_pagada = FALSE;

    -- 3. Insertar el pago
    INSERT INTO PAGO (
        pago_monto,
        pago_fecha,
        fk_mon_id,
        fk_met_id,
        fk_pnn_id
    )
    VALUES (
               total_pagar,
               fecha_pago,
               moneda_id,
               metodo_id,
               v_nomina_id
           );

    -- 4. Retornar éxito
    RETURN TRUE;

EXCEPTION WHEN OTHERS THEN
    RETURN FALSE;
END;
$$ LANGUAGE plpgsql;

-- =========================================================
-- Procedimiento almacenado para calcular el pago de todos los
-- empleados 
-- =========================================================

DROP FUNCTION IF EXISTS calcular_pago_empleado_todos();

CREATE OR REPLACE FUNCTION calcular_pago_empleado_todos()
    RETURNS void AS $$
DECLARE
    horas_establecidas NUMERIC := 0;
    horas_cumplidas NUMERIC := 0;
    horas_extras NUMERIC := 0;
    pago_total NUMERIC := 0;
    precio_por_hora CONSTANT NUMERIC := 15;

    per_id_cursor CURSOR FOR
        SELECT fk_per_id
        FROM ASISTENCIA;
    per_id_record RECORD;
BEGIN
    -- Abrir el cursor
    OPEN per_id_cursor;

    -- Recorrer todos los resultados
    LOOP
        FETCH per_id_cursor INTO per_id_record;
        EXIT WHEN NOT FOUND;

        IF EXISTS (
            SELECT 1
            FROM ASISTENCIA
            WHERE fk_per_id = per_id_record.fk_per_id
            AND asi_pagada = FALSE
            AND asi_hora_fin IS NOT NULL
        ) THEN
            SELECT
                COALESCE(SUM(EXTRACT(EPOCH FROM (hor.hor_hora_fin - hor.hor_hora_inicio)) / 3600), 0)
            INTO
                horas_establecidas
            FROM
                EMP_CARGO_HORARIO ech
                    JOIN
                HORARIO hor ON ech.fk_hor_id = hor.hor_id
            WHERE
                ech.fk_per_id = per_id_record.fk_per_id  -- Asegúrate de usar el campo correcto
            GROUP BY
                ech.fk_per_id;

            -- Obtener horas cumplidas de asistencias no pagadas
            SELECT
                COALESCE(SUM(EXTRACT(EPOCH FROM (asi.asi_hora_fin - asi.asi_hora_inicio)) / 3600), 0)
            INTO
                horas_cumplidas
            FROM
                ASISTENCIA asi
            WHERE
                asi.fk_per_id = per_id_record.fk_per_id  -- Asegúrate de usar el campo correcto
            AND asi.asi_hora_fin IS NOT NULL
            AND asi.asi_pagada = FALSE;

            -- Calcular horas extras
            IF horas_cumplidas > horas_establecidas THEN
                horas_extras := horas_cumplidas - horas_establecidas;
            ELSE
                horas_extras := 0;
            END IF;

            -- Calcular pago total
            pago_total := ROUND((horas_establecidas * precio_por_hora) + (horas_extras * precio_por_hora));

            PERFORM registrar_pago_nomina_todos(
                CURRENT_DATE,
                pago_total,
                'PAGO NOMINA',
                per_id_record.fk_per_id,  -- Asegúrate de usar el campo correcto
                1,
                1
            );

            horas_establecidas := 0;
            horas_cumplidas  := 0;
            horas_extras  := 0;
            pago_total  := 0;
        END IF; 
    END LOOP;
    -- Cerrar el cursor
    CLOSE per_id_cursor;

END;
$$ LANGUAGE plpgsql;


-- ================================================================
-- Procedimiento almacenado para el pago a todos los empleados
-- ================================================================

DROP FUNCTION IF EXISTS registrar_pago_nomina_todos(DATE, NUMERIC, VARCHAR, INT, INT, INT);

CREATE OR REPLACE FUNCTION registrar_pago_nomina_todos(
    fecha_pago DATE,
    total_pagar NUMERIC,
    descripcion VARCHAR,
    empleado_id INT,
    metodo_id INT,
    moneda_id INT
)
    RETURNS void AS $$
DECLARE
    v_nomina_id INT;
BEGIN
    -- 1. Crear el registro en PAGO_NOMINA
    INSERT INTO PAGO_NOMINA (
        pnn_fecha_pago,
        pnn_total_pago,
        pnn_descripcion,
        fk_per_id
    ) VALUES (
                 fecha_pago,
                 total_pagar,
                 descripcion,
                 empleado_id
             ) RETURNING pnn_id INTO v_nomina_id;

    -- 2. Marcar asistencias como pagadas
    UPDATE ASISTENCIA
    SET asi_pagada = TRUE
    WHERE fk_per_id = empleado_id
      AND asi_pagada = FALSE;

    -- 3. Insertar el pago
    INSERT INTO PAGO (
        pago_monto,
        pago_fecha,
        fk_mon_id,
        fk_met_id,
        fk_pnn_id
    )
    VALUES (
               total_pagar,
               fecha_pago,
               moneda_id,
               metodo_id,
               v_nomina_id
           );
END;
$$ LANGUAGE plpgsql;
