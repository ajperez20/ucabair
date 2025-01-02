-- =====================================
-- Inserción de datos: ESTATUS
-- ======================================
INSERT INTO ESTATUS (est_tipo_estatus, est_descripcion)
VALUES ('Activo', 'El registro está activo y en operación.');

INSERT INTO ESTATUS (est_tipo_estatus, est_descripcion)
VALUES ('Inactivo', 'El registro está inactivo y no está en operación.');

INSERT INTO ESTATUS (est_tipo_estatus, est_descripcion)
VALUES ('Pendiente', 'El registro está en espera de revisión o acción.');

INSERT INTO ESTATUS (est_tipo_estatus, est_descripcion)
VALUES ('Cancelado', 'El registro ha sido cancelado.');

INSERT INTO ESTATUS (est_tipo_estatus, est_descripcion)
VALUES ('Completado', 'El registro ha sido completado exitosamente.');

INSERT INTO ESTATUS (est_tipo_estatus, est_descripcion)
VALUES ('En proceso', 'El registro está siendo procesado actualmente.');

-- =====================================
-- Inserción de datos: ESTATUS_SSP
-- ======================================
INSERT INTO ESTATUS_SSP (ups_fecha_inicio, ups_fecha_fin, fk_spr_id, fk_est_id)
VALUES
-- Solicitudes de la sede Maracay
('2023-01-21', '2023-01-25', 1, 5), -- Solicitud de Acero A36, Completado
('2023-09-18', NULL, 2, 3), -- Solicitud de Acero A36, Pendiente
('2023-05-21', '2023-05-25', 3, 4), -- Solicitud de Fibra de carbono, Cancelado
('2024-07-21', NULL, 4, 6), -- Solicitud de Acero A36, En proceso
('2024-06-05', NULL, 5, 1), -- Solicitud de Aleación de aluminio 2024, Activo
('2024-05-15', '2024-05-20', 6, 5), -- Solicitud de Resinas epoxi, Completado
('2023-03-10', NULL, 7, 2), -- Solicitud de Fibra de carbono, Inactivo
('2024-01-11', NULL, 8, 6), -- Solicitud de Acero A36, En proceso
('2023-12-06', '2023-12-10', 9, 5), -- Solicitud de Aleación de aluminio 2024, Completado
('2023-08-09', NULL, 10, 1), -- Solicitud de Resinas epoxi, Activo

-- Solicitudes de la sede Colón
('2024-02-01', NULL, 11, 3), -- Solicitud de Aleación aluminio 7075, Pendiente
('2023-06-18', '2023-06-25', 12, 5), -- Solicitud de Acero aleado 4340, Completado
('2023-08-10', '2023-08-14', 13, 4), -- Solicitud de Fibra de vidrio, Cancelado
('2023-09-20', NULL, 14, 2), -- Solicitud de Resinas epoxi, Inactivo
('2024-04-15', NULL, 15, 1), -- Solicitud de Aleación aluminio 7075, Activo
('2023-07-25', '2023-08-01', 16, 5), -- Solicitud de Acero aleado 4340, Completado
('2023-10-11', NULL, 17, 6), -- Solicitud de Fibra de vidrio, En proceso
('2024-01-08', '2024-01-12', 18, 5), -- Solicitud de Resinas epoxi, Completado
('2023-11-05', NULL, 19, 3), -- Solicitud de Aleación aluminio 7075, Pendiente
('2024-03-12', '2024-03-15', 20, 4), -- Solicitud de Acero aleado 4340, Cancelado

-- Solicitudes de la sede La Guaira
('2023-01-11', '2023-01-15', 21, 5), -- Solicitud de Titanio Grado 5, Completado
('2023-08-25', NULL, 22, 6), -- Solicitud de Titanio Ti-6Al-4V, En proceso
('2023-12-05', '2023-12-10', 23, 5), -- Solicitud de Acero inoxidable 304, Completado
('2024-02-10', NULL, 24, 2), -- Solicitud de Níquel, Inactivo
('2023-09-15', NULL, 25, 3), -- Solicitud de Titanio Ti-6Al-4V, Pendiente
('2023-11-20', '2023-11-25', 26, 5), -- Solicitud de Acero inoxidable 304, Completado
('2024-01-05', NULL, 27, 1), -- Solicitud de Níquel, Activo
('2023-06-15', '2023-06-20', 28, 4), -- Solicitud de Titanio Grado 5, Cancelado
('2023-03-12', NULL, 29, 6), -- Solicitud de Titanio Ti-6Al-4V, En proceso
('2023-04-18', '2023-04-22', 30, 5), -- Solicitud de Acero inoxidable 304, Completado

-- Solicitudes de la sede Guatire
('2023-07-18', '2023-07-22', 31, 5), -- Solicitud de Compuesto Kevlar, Completado
('2023-06-25', NULL, 32, 3), -- Solicitud de Polímeros reforzados (FRP), Pendiente
('2023-11-08', '2023-11-12', 33, 5), -- Solicitud de Caucho de silicona, Completado
('2023-01-25', NULL, 34, 2), -- Solicitud de Compuesto Kevlar, Inactivo
('2023-03-12', '2023-03-16', 35, 4), -- Solicitud de Polímeros reforzados (FRP), Cancelado
('2023-04-18', '2023-04-22', 36, 5), -- Solicitud de Caucho de silicona, Completado
('2023-08-15', '2023-08-19', 37, 5), -- Solicitud de Compuesto Kevlar, Completado
('2023-10-05', NULL, 38, 1), -- Solicitud de Polímeros reforzados (FRP), Activo
('2024-01-10', NULL, 39, 6), -- Solicitud de Caucho de silicona, En proceso
('2023-09-20', '2023-09-24', 40, 5), -- Solicitud de Compuesto Kevlar, Completado

-- Solicitudes de la sede Valencia
('2023-02-05', '2023-02-10', 41, 5), -- Solicitud de Magnesio, Completado
('2023-04-18', '2023-04-22', 42, 5), -- Solicitud de Madera de balsa, Completado
('2023-07-10', NULL, 43, 6), -- Solicitud de Poliuretano, En proceso
('2023-05-25', NULL, 44, 3), -- Solicitud de Magnesio, Pendiente
('2023-08-12', '2023-08-16', 45, 5), -- Solicitud de Madera de balsa, Completado
('2024-01-08', '2024-01-12', 46, 4), -- Solicitud de Poliuretano, Cancelado
('2023-10-05', '2023-10-10', 47, 5), -- Solicitud de Magnesio, Completado
('2023-11-12', NULL, 48, 2), -- Solicitud de Madera de balsa, Inactivo
('2024-02-20', '2024-02-25', 49, 5), -- Solicitud de Poliuretano, Completado
('2023-09-15', '2023-09-20', 50, 5); -- Solicitud de Magnesio, Completado


-- =====================================
-- Inserción de datos: ESTATUS_SCAV
-- ======================================

-- Estados asociados a las solicitudes de clientes naturales
INSERT INTO ESTATUS_SCAV (scv_fecha_inicio, scv_fecha_fin, fk_sct_id, fk_est_id)
VALUES
-- Solicitud de Juan Pérez
('2023-01-15', '2023-01-20', 1, 3), -- Pendiente
('2023-01-21', NULL, 1, 6),         -- En proceso

-- Solicitud de María Gómez
('2023-02-10', '2023-02-12', 2, 3), -- Pendiente
('2023-02-13', NULL, 2, 6), -- En proceso

-- Solicitud de Luis Rodríguez
('2023-03-25', '2023-03-30', 3, 3), -- Pendiente
('2023-03-31', NULL, 3, 4), -- Cancelado

-- Solicitud de Ana Martínez
('2023-04-05', '2023-04-07', 4, 3), -- Pendiente
('2023-04-08', '2024-04-08', 4, 6), -- En proceso
('2024-04-09', NULL, 4, 5), -- Completado

-- Estados asociados a las solicitudes de clientes jurídicos
-- Solicitud de UltraFly
('2023-05-18', '2023-05-20', 5, 3), -- Pendiente
('2023-05-21', NULL, 5, 6), -- En proceso

-- Solicitud de Horizon Air
('2023-06-20', '2023-06-22', 6, 3), -- Pendiente
('2023-06-23', NULL, 6, 6), -- En proceso

-- Solicitud de StarWings
('2023-07-12', '2023-07-14', 7, 3), -- Pendiente
('2023-07-15', '2023-07-20', 7, 6), -- En proceso
('2023-07-21', NULL, 7, 4),         -- Cancelado

-- Solicitud de AeroConnect
('2023-08-22', '2023-08-24', 8, 3), -- Pendiente
('2023-08-25', '2024-08-30', 8, 6), -- En proceso
('2024-08-31', NULL, 8, 5);         -- Completado
