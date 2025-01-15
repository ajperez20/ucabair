-- =========================================================================
-- procedimiento almacenado para generar SOLICITUD_SEDE 
-- =========================================================================

DROP FUNCTION IF EXISTS registrar_solicitud_sedes(INT, INT, INT, VARCHAR, INT);

CREATE OR REPLACE FUNCTION registrar_solicitud_sedes(
    cantidad_piezas INT,
    sede_solicitante INT,
    sede_atiende INT,
    descripcion VARCHAR(255),
    pieza_id INT
)
RETURNS TABLE(
    solicitud_id INT,
    mensaje TEXT
) AS $$
DECLARE
    solicitud_sede_id INT;
    piezas_disponible INT;
BEGIN

    SELECT pie_cantidad_disponible 
    INTO piezas_disponible
    FROM PIEZA_STOCK
    WHERE pie_id = pieza_id;

    IF cantidad_piezas <= piezas_disponible THEN
        -- Insertar en la tabla SOLICITUD_SEDE y obtener el sse_id generado
        INSERT INTO SOLICITUD_SEDE (sse_fecha, sse_descripcion, fk_sed_atiende, fk_sed_solicita)
        VALUES (current_date, descripcion, sede_atiende, sede_solicitante)
        RETURNING sse_id INTO solicitud_sede_id;

        -- Insertar en la tabla DETALLE_SLD_SEDE
        INSERT INTO DETALLE_SLD_SEDE (dss_cantidad, dss_descripcion, fk_sse_id, fk_pie_id)
        VALUES (cantidad_piezas, descripcion, solicitud_sede_id, pieza_id);

        -- Insertar en la tabla ESTATUS_SOL_PIEZA
        INSERT INTO ESTATUS_SOL_PIEZA (slz_fecha_inicio, slz_fecha_fin, fk_sse_id, fk_est_id)
        VALUES (current_date, NULL, solicitud_sede_id, 3);

		PERFORM actualizar_estatus_solicitud(solicitud_sede_id);
        
        PERFORM actualizar_stock_solicitud(solicitud_sede_id);
        -- Retorno de la tabla con solicitud_id y mensaje de confirmación
        RETURN QUERY
        SELECT
            solicitud_sede_id,
            'Solicitud Material creada correctamente' AS mensaje;
    END IF;

    IF cantidad_piezas > piezas_disponible THEN
        -- Retorno de la tabla con solicitud_id y mensaje de confirmación
        RETURN QUERY
        SELECT
            0,
            'NO SE PUEDO CREAR LA SOLICITUD' AS mensaje;
    END IF;
    
END;
$$ LANGUAGE plpgsql;

