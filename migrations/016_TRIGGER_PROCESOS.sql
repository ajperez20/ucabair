-- =========================================================
-- Trigger y Procedimientos: ENSAMBLE_SOLICITUD_MATERIA
-- =========================================================

CREATE OR REPLACE FUNCTION verificar_cantidad_solicitada()
RETURNS TRIGGER AS $$
DECLARE
    cantidad_material INT;
BEGIN
    SELECT mps_cantidad_disponible 
    INTO cantidad_material
    FROM MATERIA_PRIMA_STOCK
    WHERE mps_id = NEW.fk_mps_id;

    IF NEW.elm_cantidad > cantidad_material THEN
        RAISE NOTICE 'NO SE PERMITE LA SOLICITUD (CANTIDAD NO DISPONIBLE) = %', NEW.elm_cantidad;
        RAISE NOTICE '(CANTIDAD DISPONIBLE) = % ', cantidad_material;
        RETURN NULL;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER crear_solicitud_materia
BEFORE INSERT ON ENSAMBLE_SOLICITUD_MATERIA
FOR EACH ROW
EXECUTE FUNCTION verificar_cantidad_solicitada();


CREATE OR REPLACE FUNCTION actualizar_stock_materia()
RETURNS TRIGGER AS $$
BEGIN
    RAISE NOTICE 'RETIRANDO MATERIAL DEL STOCK';
    UPDATE MATERIA_PRIMA_STOCK 
    SET mps_cantidad_disponible = mps_cantidad_disponible - NEW.elm_cantidad
    WHERE mps_id = NEW.fk_mps_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER enviar_solicitud_materia
AFTER INSERT ON ENSAMBLE_SOLICITUD_MATERIA
FOR EACH ROW
EXECUTE FUNCTION actualizar_stock_materia();


