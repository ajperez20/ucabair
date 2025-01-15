-- =========================================================
-- trigger que generará FASE_ENSAMBLE_PIEZA 
-- si se cumple el umbral mínimo establecido
-- =========================================================

DROP TRIGGER IF EXISTS trigger_actualizar_pieza_stock ON PIEZA_STOCK;
DROP FUNCTION IF EXISTS actualizar_pieza_stock;

CREATE OR REPLACE FUNCTION actualizar_pieza_stock()
RETURNS TRIGGER AS $$
DECLARE
    fase_id INT;
BEGIN

    IF NEW.pie_cantidad_disponible < 150 THEN
        RAISE NOTICE 'REGISTRANDO ENSAMBLE PIEZA PARA LA PIEZA % ', NEW.pie_nombre;
        INSERT INTO FASE_ENSAMBLE_PIEZA (eez_fecha_inicio, eez_fecha_fin, fk_esp_id, fk_zon_id, fk_pie_id)
        VALUES (CURRENT_DATE, NULL, 9, 31, NEW.pie_id)
        RETURNING eez_id INTO fase_id;
		
        INSERT INTO ESTATUS_FEP (sfe_fecha_inicio, sfe_fecha_fin, fk_esp_id, fk_zon_id, fk_eez_id, fk_est_id)
        VALUES (CURRENT_DATE, NULL, 9, 31, fase_id, 3);
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trigger_actualizar_pieza_stock
AFTER UPDATE ON PIEZA_STOCK
FOR EACH ROW
EXECUTE FUNCTION actualizar_pieza_stock();
