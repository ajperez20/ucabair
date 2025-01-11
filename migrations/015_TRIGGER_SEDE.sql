-- ==================================================
-- Trigger y Procedimientos: MATERIA_PRIMA_STOCK
-- ==================================================

CREATE OR REPLACE FUNCTION verificar_cantidad_stock()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.mps_cantidad_disponible < 0 THEN
        RAISE NOTICE 'NO SE PERMITE LA ACTUALIZACIÓN';
        RETURN NULL; -- Impedir la actualización
    END IF;

    RETURN NEW; -- Permitir la actualización
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE TRIGGER cantidad_minima_stock
BEFORE UPDATE ON MATERIA_PRIMA_STOCK
FOR EACH ROW
EXECUTE FUNCTION verificar_cantidad_stock();


CREATE OR REPLACE FUNCTION enviar_solicitud_proveedor()
RETURNS TRIGGER AS $$
DECLARE
	proveedor_id INT;
BEGIN

	SELECT p.com_id
	INTO proveedor_id
	FROM 
		proveedor p, 
		proveedor_mp_stock ps
	WHERE 
		p.fk_mtp_id = ps.mtp_id
		AND
		ps.fk_rpm_id = NEW.fk_rpm_id;
		
    IF NEW.mps_cantidad_disponible < 150 THEN
		INSERT INTO SOLICITUD_PROVEEDOR 
		(
			spr_fecha, spr_total, 
			spr_descripcion, 
			fk_com_id, 
			fk_mps_id, 
			fk_sed_id, 
			fk_rpm_id
		)
		VALUES 
		(
			CURRENT_DATE, 
		 	0, 
			(SELECT 'Solicitud de' || rpm_nombre
			FROM materia_prima 
			WHERE rpm_id = NEW.fk_rpm_id),
			proveedor_id,
			NEW.mps_id,
			NEW.fk_sed_id,
			NEW.fk_rpm_id
		);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE TRIGGER crear_solicitud_proveedor
AFTER UPDATE ON MATERIA_PRIMA_STOCK
FOR EACH ROW
EXECUTE FUNCTION enviar_solicitud_proveedor();
