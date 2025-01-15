-- =========================================================
-- trigger que generará FASE_ENSAMBLE_PIEZA 
-- si se cumple el umbral mínimo establecido
-- =========================================================

DROP TRIGGER IF EXISTS trigger_actualizar_pieza_stock ON PIEZA_STOCK;
DROP FUNCTION IF EXISTS actualizar_pieza_stock;

CREATE OR REPLACE FUNCTION actualizar_pieza_stock()
RETURNS TRIGGER AS $$
BEGIN

    IF NEW.pie_cantidad_disponible < 150 THEN
        RAISE NOTICE 'REGISTRANDO ENSAMBLE PIEZA PARA LA PIEZA % ', NEW.pie_nombre;
        INSERT INTO FASE_ENSAMBLE_PIEZA (eez_fecha_inicio, eez_fecha_fin, fk_esp_id, fk_zon_id, fk_pie_id)
        VALUES (CURRENT_DATE, NULL, 9, 31, NEW.pie_id);
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_actualizar_pieza_stock
AFTER UPDATE ON PIEZA_STOCK
FOR EACH ROW
EXECUTE FUNCTION actualizar_pieza_stock();
