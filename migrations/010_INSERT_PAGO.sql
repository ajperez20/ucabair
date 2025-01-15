-- ==========================================================
-- Inserción de datos: METODO_PAGO
-- ==========================================================
INSERT INTO METODO_PAGO (tipo_metodo)
VALUES ('EFECTIVO');

INSERT INTO METODO_PAGO (tipo_metodo)
VALUES ('TRANSFERENCIA');

INSERT INTO METODO_PAGO (tipo_metodo)
VALUES ('CHEQUE');

INSERT INTO METODO_PAGO (tipo_metodo)
VALUES ('TDC');

INSERT INTO METODO_PAGO (tipo_metodo)
VALUES ('TDD');

-- ==========================================================
-- Inserción de datos: MONEDA
-- ==========================================================

INSERT INTO MONEDA (mon_tipo, mon_valor_cambio, mon_fecha_fin)
VALUES ('€', 1.3, NULL);

INSERT INTO MONEDA (mon_tipo, mon_valor_cambio, mon_fecha_fin)
VALUES ('BS', 37, NULL);

INSERT INTO MONEDA (mon_tipo, mon_valor_cambio, mon_fecha_fin)
VALUES ('$', 1, NULL);