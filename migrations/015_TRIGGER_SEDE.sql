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
BEGIN
    IF NEW.mps_cantidad_disponible < 150 THEN
        -- Aquí puedes añadir el código para enviar la solicitud
        RAISE NOTICE 'Solicitud enviada porque la cantidad de material es %', NEW.mps_cantidad_disponible;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE TRIGGER crear_solicitud_proveedor
AFTER UPDATE ON MATERIA_PRIMA_STOCK
FOR EACH ROW
EXECUTE FUNCTION enviar_solicitud_proveedor();
