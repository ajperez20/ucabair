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
