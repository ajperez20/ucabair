-- =========================================================
-- Trigger y Procedimientos: Pago Solicitud Proveedor
-- =========================================================

CREATE OR REPLACE FUNCTION registrar_pagos()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.fk_spr_id IS NOT NULL THEN
        RAISE NOTICE 'REGISTRANDO PAGO SOLICITUD PROVEEDORES';
        RAISE NOTICE 'CAMBIANDO EL ESTATUS SOLICITUD PROVEEDORES';
        INSERT INTO ESTATUS_SSP
        (
            ups_fecha_inicio, 
            ups_fecha_fin, 
            fk_spr_id, 
            fk_est_id
        )
        VALUES
        (
            CURRENT_DATE, 
            NULL,
            NEW.fk_spr_id, 
            5
        );
        RETURN NEW;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER pagos_solicitudes 
AFTER INSERT ON PAGO
FOR EACH ROW
EXECUTE FUNCTION registrar_pagos();










