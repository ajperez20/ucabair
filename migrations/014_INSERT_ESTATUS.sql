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


-- =====================================
-- Inserción de datos: ESTATUS_PPS
-- ======================================

-- Historial de estados para piezas probadas en Maracay (zona 5)
INSERT INTO ESTATUS_PPS (ssp_fecha_inicio, ssp_fecha_fin, fk_pie_id, fk_zon_id, fk_pru_id, fk_est_id)
VALUES
('2023-01-15', '2023-01-16', 1, 5, 1, 3), -- Pendiente (Ala Recta)
('2023-01-16', '2023-01-19', 1, 5, 1, 6), -- En proceso
('2023-01-19', '2023-01-20', 1, 5, 1, 5), -- Completado

('2023-01-16', '2023-01-17', 2, 5, 3, 3), -- Pendiente (Ala Trapezoidal)
('2023-01-17', '2023-01-20', 2, 5, 3, 6), -- En proceso
('2023-01-20', '2023-01-21', 2, 5, 3, 5), -- Completado

('2023-01-17', '2023-01-18', 3, 5, 5, 3), -- Pendiente (Ala Delta)
('2023-01-18', '2023-01-21', 3, 5, 5, 6), -- En proceso
('2023-01-21', '2023-01-22', 3, 5, 5, 5), -- Completado

('2023-01-18', '2023-01-19', 4, 5, 7, 3), -- Pendiente (Ala en Flecha)
('2023-01-19', '2023-01-22', 4, 5, 7, 6), -- En proceso
('2023-01-22', '2023-01-23', 4, 5, 7, 5), -- Completado

('2023-01-19', '2023-01-20', 5, 5, 9, 3), -- Pendiente (Ala en Flecha Inversa)
('2023-01-20', '2023-01-23', 5, 5, 9, 6), -- En proceso
('2023-01-23', '2023-01-24', 5, 5, 9, 5), -- Completado

('2023-01-20', '2023-01-21', 6, 5, 11, 3), -- Pendiente (Forma Estándar)
('2023-01-21', '2023-01-24', 6, 5, 11, 6), -- En proceso
('2023-01-24', '2023-01-25', 6, 5, 11, 5), -- Completado

('2023-01-21', '2023-01-22', 7, 5, 13, 3), -- Pendiente (Forma en T)
('2023-01-22', '2023-01-25', 7, 5, 13, 6), -- En proceso
('2023-01-25', '2023-01-26', 7, 5, 13, 5), -- Completado

('2023-01-22', '2023-01-23', 8, 5, 15, 3), -- Pendiente (Forma en Cruz)
('2023-01-23', '2023-01-26', 8, 5, 15, 6), -- En proceso
('2023-01-26', '2023-01-27', 8, 5, 15, 5), -- Completado

('2023-01-23', '2023-01-24', 9, 5, 17, 3), -- Pendiente (Forma 2 Verticales)
('2023-01-24', '2023-01-27', 9, 5, 17, 6), -- En proceso
('2023-01-27', '2023-01-28', 9, 5, 17, 5), -- Completado

('2023-01-24', '2023-01-25', 10, 5, 19, 3), -- Pendiente (Forma 3 Verticales)
('2023-01-25', '2023-01-28', 10, 5, 19, 6), -- En proceso
('2023-01-28', '2023-01-29', 10, 5, 19, 5), -- Completado

('2023-01-25', '2023-01-26', 11, 5, 21, 3), -- Pendiente (Forma en V)
('2023-01-26', '2023-01-29', 11, 5, 21, 6), -- En proceso
('2023-01-29', '2023-01-30', 11, 5, 21, 5), -- Completado

('2023-01-26', '2023-01-27', 12, 5, 53, 3), -- Pendiente (Flaps)
('2023-01-27', '2023-01-30', 12, 5, 53, 6), -- En proceso
('2023-01-30', '2023-01-31', 12, 5, 53, 5), -- Completado

('2023-01-27', '2023-01-28', 13, 5, 54, 3), -- Pendiente (Slats)
('2023-01-28', '2023-01-31', 13, 5, 54, 6), -- En proceso
('2023-01-31', '2023-02-01', 13, 5, 54, 5), -- Completado

('2023-01-28', '2023-01-29', 14, 5, 55, 3), -- Pendiente (Spoilers)
('2023-01-29', '2023-02-01', 14, 5, 55, 6), -- En proceso
('2023-02-01', '2023-02-02', 14, 5, 55, 5), -- Completado

('2023-01-29', '2023-01-30', 15, 5, 56, 3), -- Pendiente (Superficie de sustentación)
('2023-01-30', '2023-02-01', 15, 5, 56, 6), -- En proceso
('2023-02-01', '2023-02-02', 15, 5, 56, 5); -- Completado

-- Historial de estados para piezas probadas en Colón (zona 11)
INSERT INTO ESTATUS_PPS (ssp_fecha_inicio, ssp_fecha_fin, fk_pie_id, fk_zon_id, fk_pru_id, fk_est_id)
VALUES
('2023-02-01', '2023-02-02', 16, 11, 57, 3), -- Pendiente (Fuselaje)
('2023-02-02', '2023-02-09', 16, 11, 57, 6), -- En proceso
('2023-02-09', '2023-02-10', 16, 11, 57, 5), -- Completado

('2023-02-02', '2023-02-03', 17, 11, 23, 3), -- Pendiente (Tren Fijo)
('2023-02-03', '2023-02-10', 17, 11, 23, 6), -- En proceso
('2023-02-10', '2023-02-11', 17, 11, 23, 5), -- Completado

('2023-02-03', '2023-02-04', 18, 11, 24, 3), -- Pendiente (Tren Retráctil)
('2023-02-04', '2023-02-11', 18, 11, 24, 6), -- En proceso
('2023-02-11', '2023-02-12', 18, 11, 24, 5); -- Completado

-- Historial de estados para piezas probadas en La Guaira (zona 14)
INSERT INTO ESTATUS_PPS (ssp_fecha_inicio, ssp_fecha_fin, fk_pie_id, fk_zon_id, fk_pru_id, fk_est_id)
VALUES
('2023-03-01', '2023-03-02', 19, 14, 49, 3), -- Pendiente (Motor)
('2023-03-02', '2023-03-09', 19, 14, 49, 6), -- En proceso
('2023-03-09', '2023-03-10', 19, 14, 49, 5); -- Completado

-- Historial de estados para piezas probadas en Guatire (zona 21)
INSERT INTO ESTATUS_PPS (ssp_fecha_inicio, ssp_fecha_fin, fk_pie_id, fk_zon_id, fk_pru_id, fk_est_id)
VALUES
('2023-04-01', '2023-04-02', 20, 21, 25, 3), -- Pendiente (Anemómetro)
('2023-04-02', '2023-04-04', 20, 21, 25, 6), -- En proceso
('2023-04-04', '2023-04-05', 20, 21, 25, 5), -- Completado

('2023-04-02', '2023-04-03', 21, 21, 26, 3), -- Pendiente (Altímetro)
('2023-04-03', '2023-04-05', 21, 21, 26, 6), -- En proceso
('2023-04-05', '2023-04-06', 21, 21, 26, 5), -- Completado

('2023-04-03', '2023-04-04', 22, 21, 27, 3), -- Pendiente (Variómetro)
('2023-04-04', '2023-04-06', 22, 21, 27, 6), -- En proceso
('2023-04-06', '2023-04-07', 22, 21, 27, 5), -- Completado

('2023-04-04', '2023-04-05', 23, 21, 28, 3), -- Pendiente (Inclinómetro)
('2023-04-05', '2023-04-07', 23, 21, 28, 6), -- En proceso
('2023-04-07', '2023-04-08', 23, 21, 28, 5), -- Completado

('2023-04-05', '2023-04-06', 24, 21, 29, 3), -- Pendiente (Horizonte Artificial)
('2023-04-06', '2023-04-08', 24, 21, 29, 6), -- En proceso
('2023-04-08', '2023-04-09', 24, 21, 29, 5), -- Completado

('2023-04-06', '2023-04-07', 25, 21, 30, 3), -- Pendiente (Brújula)
('2023-04-07', '2023-04-09', 25, 21, 30, 6), -- En proceso
('2023-04-09', '2023-04-10', 25, 21, 30, 5), -- Completado

('2023-04-07', '2023-04-08', 26, 21, 31, 3), -- Pendiente (Indicador de Rumbos)
('2023-04-08', '2023-04-10', 26, 21, 31, 6), -- En proceso
('2023-04-10', '2023-04-11', 26, 21, 31, 5), -- Completado

('2023-04-08', '2023-04-09', 27, 21, 32, 3), -- Pendiente (ADF)
('2023-04-09', '2023-04-11', 27, 21, 32, 6), -- En proceso
('2023-04-11', '2023-04-12', 27, 21, 32, 5), -- Completado

('2023-04-09', '2023-04-10', 28, 21, 33, 3), -- Pendiente (DME)
('2023-04-10', '2023-04-12', 28, 21, 33, 6), -- En proceso
('2023-04-12', '2023-04-13', 28, 21, 33, 5), -- Completado

('2023-04-10', '2023-04-11', 29, 21, 34, 3), -- Pendiente (CDI)
('2023-04-11', '2023-04-13', 29, 21, 34, 6), -- En proceso
('2023-04-13', '2023-04-14', 29, 21, 34, 5), -- Completado

('2023-04-11', '2023-04-12', 30, 21, 35, 3), -- Pendiente (ILS)
('2023-04-12', '2023-04-14', 30, 21, 35, 6), -- En proceso
('2023-04-14', '2023-04-15', 30, 21, 35, 5), -- Completado

('2023-04-12', '2023-04-13', 31, 21, 36, 3), -- Pendiente (Piloto Automático)
('2023-04-13', '2023-04-15', 31, 21, 36, 6), -- En proceso
('2023-04-15', '2023-04-16', 31, 21, 36, 5), -- Completado

('2023-04-13', '2023-04-14', 32, 21, 37, 3), -- Pendiente (Sistema de Gestión de Vuelo)
('2023-04-14', '2023-04-16', 32, 21, 37, 6), -- En proceso
('2023-04-16', '2023-04-17', 32, 21, 37, 5), -- Completado

('2023-04-14', '2023-04-15', 33, 21, 38, 3), -- Pendiente (Manómetro)
('2023-04-15', '2023-04-17', 33, 21, 38, 6), -- En proceso
('2023-04-17', '2023-04-18', 33, 21, 38, 5), -- Completado

('2023-04-15', '2023-04-16', 34, 21, 39, 3), -- Pendiente (Termómetro de Aceite)
('2023-04-16', '2023-04-18', 34, 21, 39, 6), -- En proceso
('2023-04-18', '2023-04-19', 34, 21, 39, 5), -- Completado

('2023-04-16', '2023-04-17', 35, 21, 40, 3), -- Pendiente (Caudal de Combustible)
('2023-04-17', '2023-04-19', 35, 21, 40, 6), -- En proceso
('2023-04-19', '2023-04-20', 35, 21, 40, 5), -- Completado

('2023-04-17', '2023-04-18', 36, 21, 41, 3), -- Pendiente (Temperatura de Culatas)
('2023-04-18', '2023-04-20', 36, 21, 41, 6), -- En proceso
('2023-04-20', '2023-04-21', 36, 21, 41, 5), -- Completado

('2023-04-18', '2023-04-19', 37, 21, 42, 3), -- Pendiente (Nivel de Combustible)
('2023-04-19', '2023-04-21', 37, 21, 42, 6), -- En proceso
('2023-04-21', '2023-04-22', 37, 21, 42, 5); -- Completado

-- Historial de estados para piezas probadas en Valencia (zona 29)
INSERT INTO ESTATUS_PPS (ssp_fecha_inicio, ssp_fecha_fin, fk_pie_id, fk_zon_id, fk_pru_id, fk_est_id)
VALUES
('2023-05-01', '2023-05-02', 38, 29, 43, 3), -- Pendiente (Asientos)
('2023-05-02', '2023-05-04', 38, 29, 43, 6), -- En proceso
('2023-05-04', '2023-05-05', 38, 29, 43, 5), -- Completado

('2023-05-02', '2023-05-03', 39, 29, 44, 3), -- Pendiente (Porta Equipajes)
('2023-05-03', '2023-05-05', 39, 29, 44, 6), -- En proceso
('2023-05-05', '2023-05-06', 39, 29, 44, 5), -- Completado

('2023-05-03', '2023-05-04', 40, 29, 47, 3), -- Pendiente (Ventanillas)
('2023-05-04', '2023-05-06', 40, 29, 47, 6), -- En proceso
('2023-05-06', '2023-05-07', 40, 29, 47, 5), -- Completado

('2023-05-04', '2023-05-05', 41, 29, 45, 3), -- Pendiente (Alfombrado)
('2023-05-05', '2023-05-07', 41, 29, 45, 6), -- En proceso
('2023-05-07', '2023-05-08', 41, 29, 45, 5), -- Completado

('2023-05-05', '2023-05-06', 42, 29, 46, 3), -- Pendiente (Piezas Sanitarias)
('2023-05-06', '2023-05-08', 42, 29, 46, 6), -- En proceso
('2023-05-08', '2023-05-09', 42, 29, 46, 5), -- Completado

('2023-05-06', '2023-05-07', 43, 29, 48, 3), -- Pendiente (Cortinas)
('2023-05-07', '2023-05-09', 43, 29, 48, 6), -- En proceso
('2023-05-09', '2023-05-10', 43, 29, 48, 5); -- Completado


-- =====================================
-- Inserción de datos: ESTATUS_PMS
-- ======================================

-- Historial de estatus para las pruebas realizadas en Maracay
INSERT INTO ESTATUS_PMS (sms_fecha_inicio, sms_fecha_fin, fk_est_id, fk_zon_id, fk_sed_id, fk_rpm_id, fk_mps_id, fk_pru_id)
VALUES
-- Acero A36
('2023-01-15', '2023-01-16', 3, 5, 1, 1, 1, 90), -- Pendiente
('2023-01-16', '2023-01-19', 6, 5, 1, 1, 1, 90), -- En proceso
('2023-01-19', '2023-01-20', 5, 5, 1, 1, 1, 90), -- Completado

-- Aleación de aluminio 2024
('2023-01-16', '2023-01-17', 3, 5, 1, 4, 2, 93), -- Pendiente
('2023-01-17', '2023-01-20', 6, 5, 1, 4, 2, 93), -- En proceso
('2023-01-20', '2023-01-21', 5, 5, 1, 4, 2, 93), -- Completado

-- Fibra de carbono
('2023-01-17', '2023-01-18', 3, 5, 1, 8, 3, 97), -- Pendiente
('2023-01-18', '2023-01-21', 6, 5, 1, 8, 3, 97), -- En proceso
('2023-01-21', '2023-01-22', 5, 5, 1, 8, 3, 97), -- Completado

-- Resinas epoxi
('2023-01-18', '2023-01-19', 3, 5, 1, 13, 4, 102), -- Pendiente
('2023-01-19', '2023-01-22', 6, 5, 1, 13, 4, 102), -- En proceso
('2023-01-22', '2023-01-23', 5, 5, 1, 13, 4, 102); -- Completado


-- Historial de estatus para las pruebas realizadas en Colón
INSERT INTO ESTATUS_PMS (sms_fecha_inicio, sms_fecha_fin, fk_est_id, fk_zon_id, fk_sed_id, fk_rpm_id, fk_mps_id, fk_pru_id)
VALUES
-- Aleación de aluminio 7075
('2023-02-01', '2023-02-02', 3, 11, 2, 5, 5, 94), -- Pendiente
('2023-02-02', '2023-02-09', 6, 11, 2, 5, 5, 94), -- En proceso
('2023-02-09', '2023-02-10', 5, 11, 2, 5, 5, 94), -- Completado

-- Acero aleado 4340
('2023-02-02', '2023-02-03', 3, 11, 2, 6, 6, 95), -- Pendiente
('2023-02-03', '2023-02-10', 6, 11, 2, 6, 6, 95), -- En proceso
('2023-02-10', '2023-02-11', 5, 11, 2, 6, 6, 95), -- Completado

-- Fibra de vidrio
('2023-02-03', '2023-02-04', 3, 11, 2, 9, 7, 98), -- Pendiente
('2023-02-04', '2023-02-11', 6, 11, 2, 9, 7, 98), -- En proceso
('2023-02-11', '2023-02-12', 5, 11, 2, 9, 7, 98), -- Completado

-- Resinas epoxi
('2023-02-04', '2023-02-05', 3, 11, 2, 13, 8, 102), -- Pendiente
('2023-02-05', '2023-02-12', 6, 11, 2, 13, 8, 102), -- En proceso
('2023-02-12', '2023-02-13', 5, 11, 2, 13, 8, 102); -- Completado

-- Historial de estatus para las pruebas realizadas en La Guaira
INSERT INTO ESTATUS_PMS (sms_fecha_inicio, sms_fecha_fin, fk_est_id, fk_zon_id, fk_sed_id, fk_rpm_id, fk_mps_id, fk_pru_id)
VALUES
-- Titanio Grado 5
('2023-03-01', '2023-03-02', 3, 14, 3, 2, 9, 91), -- Pendiente
('2023-03-02', '2023-03-09', 6, 14, 3, 2, 9, 91), -- En proceso
('2023-03-09', '2023-03-10', 5, 14, 3, 2, 9, 91), -- Completado

-- Titanio Ti-6Al-4V
('2023-03-02', '2023-03-03', 3, 14, 3, 7, 10, 96), -- Pendiente
('2023-03-03', '2023-03-10', 6, 14, 3, 7, 10, 96), -- En proceso
('2023-03-10', '2023-03-11', 5, 14, 3, 7, 10, 96), -- Completado

-- Acero inoxidable 304
('2023-03-03', '2023-03-04', 3, 14, 3, 10, 11, 99), -- Pendiente
('2023-03-04', '2023-03-12', 6, 14, 3, 10, 11, 99), -- En proceso
('2023-03-12', '2023-03-13', 5, 14, 3, 10, 11, 99), -- Completado

-- Níquel
('2023-03-04', '2023-03-05', 3, 14, 3, 16, 12, 105), -- Pendiente
('2023-03-05', '2023-03-12', 6, 14, 3, 16, 12, 105), -- En proceso
('2023-03-12', '2023-03-13', 5, 14, 3, 16, 12, 105); -- Completado

-- Historial de estatus para las pruebas realizadas en Guatire
INSERT INTO ESTATUS_PMS (sms_fecha_inicio, sms_fecha_fin, fk_est_id, fk_zon_id, fk_sed_id, fk_rpm_id, fk_mps_id, fk_pru_id)
VALUES
-- Compuesto Kevlar
('2023-04-01', '2023-04-02', 3, 21, 4, 3, 13, 92), -- Pendiente
('2023-04-02', '2023-04-04', 6, 21, 4, 3, 13, 92), -- En proceso
('2023-04-04', '2023-04-05', 5, 21, 4, 3, 13, 92), -- Completado

-- Polímeros reforzados (FRP)
('2023-04-02', '2023-04-03', 3, 21, 4, 12, 14, 101), -- Pendiente
('2023-04-03', '2023-04-05', 6, 21, 4, 12, 14, 101), -- En proceso
('2023-04-05', '2023-04-06', 5, 21, 4, 12, 14, 101), -- Completado

-- Caucho de silicona
('2023-04-03', '2023-04-04', 3, 21, 4, 15, 15, 104), -- Pendiente
('2023-04-04', '2023-04-06', 6, 21, 4, 15, 15, 104), -- En proceso
('2023-04-06', '2023-04-07', 5, 21, 4, 15, 15, 104); -- Completado

-- Historial de estatus para las pruebas realizadas en Valencia
INSERT INTO ESTATUS_PMS (sms_fecha_inicio, sms_fecha_fin, fk_est_id, fk_zon_id, fk_sed_id, fk_rpm_id, fk_mps_id, fk_pru_id)
VALUES
-- Magnesio
('2023-05-01', '2023-05-02', 3, 29, 5, 11, 16, 100), -- Pendiente
('2023-05-02', '2023-05-04', 6, 29, 5, 11, 16, 100), -- En proceso
('2023-05-04', '2023-05-05', 5, 29, 5, 11, 16, 100), -- Completado

-- Madera de balsa
('2023-05-02', '2023-05-03', 3, 29, 5, 17, 17, 106), -- Pendiente
('2023-05-03', '2023-05-05', 6, 29, 5, 17, 17, 106), -- En proceso
('2023-05-05', '2023-05-06', 5, 29, 5, 17, 17, 106), -- Completado

-- Caucho de silicona
('2023-05-03', '2023-05-04', 3, 29, 5, 14, 18, 104), -- Pendiente
('2023-05-04', '2023-05-06', 6, 29, 5, 14, 18, 104), -- En proceso
('2023-05-06', '2023-05-07', 5, 29, 5, 14, 18, 104); -- Completado


-- ESTATUS_FEA A PARTIR DE SOLICITUD DE CLIENTES NATURALES

-- ==========================================================
-- Inserción de datos: ESTATUS_FEA para AU-80
-- ==========================================================

-- Para Maracay

-- Zona de alas
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id ,fk_est_id)
VALUES 
('2024-01-01', NULL, 1, 1, 1, 1, 3),  -- Pendiente
('2024-01-01', NULL, 1, 1, 1, 1, 6);  -- En proceso

-- Zona de estabilizadores
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id ,fk_est_id)
VALUES 
('2024-02-01', NULL, 1, 1, 2, 1, 3),  -- Pendiente
('2024-02-01', NULL, 1, 1, 2, 1, 6);  -- En proceso

-- Zona de alerones y flaps
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id ,fk_est_id)
VALUES 
('2024-03-01', NULL, 1, 1, 3, 1, 3),  -- Pendiente
('2024-03-01', NULL, 1, 1, 3, 1, 6);  -- En proceso

-- Para Colón

-- Zona de trenes de aterrizaje
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id ,fk_est_id)
VALUES 
('2024-01-01', NULL, 1, 1, 9, 1, 3),  -- Pendiente
('2024-01-01', NULL, 1, 1, 9, 1, 6);  -- En proceso

-- Zona de fuselajes
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES
('2024-02-01', NULL, 1, 1, 10, 1, 3),  -- Pendiente
('2024-02-01', NULL, 1, 1, 10, 1, 6);  -- En proceso

-- Para Guaira

-- Zona de ensamblaje
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id ,fk_est_id)
VALUES 
('2024-01-01', NULL, 1, 1, 15, 1, 3),  -- Pendiente
('2024-01-01', NULL, 1, 1, 15, 1, 6);  -- En proceso

-- Zona de calibración
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id ,fk_est_id)
VALUES 
('2024-02-01', NULL, 1, 1, 16, 1, 3),  -- Pendiente
('2024-02-01', NULL, 1, 1, 16, 1, 6);  -- En proceso

-- Para Guatire

-- Zona de integración
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id ,fk_est_id)
VALUES 
('2024-01-01', NULL, 1, 1, 19, 1, 3),  -- Pendiente
('2024-01-01', NULL, 1, 1, 19, 1, 6);  -- En proceso

-- Zona de soldadura
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id ,fk_est_id)
VALUES 
('2024-02-01', NULL, 1, 1, 20, 1, 3),  -- Pendiente
('2024-02-01', NULL, 1, 1, 20, 1, 6);  -- En proceso

-- Para Valencia

-- Zona de porta equipajes
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id ,fk_est_id)
VALUES 
('2024-01-01', NULL, 1, 1, 25, 1, 3),  -- Pendiente
('2024-01-01', NULL, 1, 1, 25, 1, 6);  -- En proceso

-- Zona de piezas sanitarias
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-02-01', NULL, 1, 1, 26, 1, 3),  -- Pendiente
('2024-02-01', NULL, 1, 1, 26, 1, 6);  -- En proceso

-- ==========================================================
-- Inserción de datos: ESTATUS_FEA para AU-801
-- ==========================================================

-- Para Maracay

-- Zona de alas
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-01-01', NULL, 1, 2, 1, 2, 3),  -- Pendiente
('2024-01-01', NULL, 1, 2, 1, 2, 6);  -- En proceso

-- Zona de estabilizadores
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-02-01', NULL, 1, 2, 2, 2, 3),  -- Pendiente
('2024-02-01', NULL, 1, 2, 2, 2, 6);  -- En proceso

-- Zona de alerones y flaps
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-03-01', NULL, 1, 2, 3, 2, 3),  -- Pendiente
('2024-03-01', NULL, 1, 2, 3, 2, 6);  -- En proceso

-- Para Colón

-- Zona de trenes de aterrizaje
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-01-01', NULL, 1, 2, 9, 2, 3),  -- Pendiente
('2024-01-01', NULL, 1, 2, 9, 2, 6);  -- En proceso

-- Zona de fuselajes
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-02-01', NULL, 1, 2, 10, 2, 3),  -- Pendiente
('2024-02-01', NULL, 1, 2, 10, 2, 6);  -- En proceso

-- Para Guaira

-- Zona de ensamblaje
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-01-01', NULL, 1, 2, 15, 2, 3),  -- Pendiente
('2024-01-01', NULL, 1, 2, 15, 2, 6);  -- En proceso

-- Zona de calibración
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-02-01', NULL, 1, 2, 16, 2, 3),  -- Pendiente
('2024-02-01', NULL, 1, 2, 16, 2, 6);  -- En proceso

-- Para Guatire

-- Zona de integración
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-01-01', NULL, 1, 2, 19, 2, 3),  -- Pendiente
('2024-01-01', NULL, 1, 2, 19, 2, 6);  -- En proceso

-- Zona de soldadura
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-02-01', NULL, 1, 2, 20, 2, 3),  -- Pendiente
('2024-02-01', NULL, 1, 2, 20, 2, 6);  -- En proceso

-- Para Valencia

-- Zona de porta equipajes
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-01-01', NULL, 1, 2, 25, 2, 3),  -- Pendiente
('2024-01-01', NULL, 1, 2, 25, 2, 6);  -- En proceso

-- Zona de piezas sanitarias
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-02-01', NULL, 1, 2, 26, 2, 3),  -- Pendiente
('2024-02-01', NULL, 1, 2, 26, 2, 6);  -- En proceso

-- ==========================================================
-- Inserción de datos: ESTATUS_FEA para AU-802A
-- ==========================================================

-- Para Maracay

-- Zona de alas
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-01-01', NULL, 1, 6, 1, 3, 3),  -- Pendiente
('2024-01-01', NULL, 1, 6, 1, 3, 6);  -- En proceso

-- Zona de estabilizadores
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-02-01', NULL, 1, 6, 2, 3, 3),  -- Pendiente
('2024-02-01', NULL, 1, 6, 2, 3, 6);  -- En proceso

-- Zona de alerones y flaps
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-03-01', NULL, 1, 6, 3, 3, 3),  -- Pendiente
('2024-03-01', NULL, 1, 6, 3, 3, 6);  -- En proceso

-- Para Colón

-- Zona de trenes de aterrizaje
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-01-01', NULL, 1, 6, 9, 3, 3),  -- Pendiente
('2024-01-01', NULL, 1, 6, 9, 3, 6);  -- En proceso

-- Zona de fuselajes
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-02-01', NULL, 1, 6, 10, 3, 3),  -- Pendiente
('2024-02-01', NULL, 1, 6, 10, 3, 6);  -- En proceso

-- Para Guaira

-- Zona de ensamblaje
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-01-01', NULL, 1, 6, 15, 3, 3),  -- Pendiente
('2024-01-01', NULL, 1, 6, 15, 3, 6);  -- En proceso

-- Zona de calibración
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-02-01', NULL, 1, 6, 16, 3, 3),  -- Pendiente
('2024-02-01', NULL, 1, 6, 16, 3, 6);  -- En proceso

-- Para Guatire

-- Zona de integración
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-01-01', NULL, 1, 6, 19, 3, 3),  -- Pendiente
('2024-01-01', NULL, 1, 6, 19, 3, 6);  -- En proceso

-- Zona de soldadura
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-02-01', NULL, 1, 6, 20, 3, 3),  -- Pendiente
('2024-02-01', NULL, 1, 6, 20, 3, 6);  -- En proceso

-- Para Valencia

-- Zona de porta equipajes
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-01-01', NULL, 1, 6, 25, 3, 3),  -- Pendiente
('2024-01-01', NULL, 1, 6, 25, 3, 6);  -- En proceso

-- Zona de piezas sanitarias
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-02-01', NULL, 1, 6, 26, 3, 3),  -- Pendiente
('2024-02-01', NULL, 1, 6, 26, 3, 6);  -- En proceso

-- ==========================================================
-- Inserción de datos: ESTATUS_FEA para AU-747PLUS
-- ==========================================================

-- Para Maracay

-- Zona de alas
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-01-01', NULL, 1, 4, 1, 4, 3),  -- Pendiente
('2024-01-01', NULL, 1, 4, 1, 4, 6);  -- En proceso

-- Zona de estabilizadores
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-02-01', NULL, 1, 4, 2, 4, 3),  -- Pendiente
('2024-02-01', NULL, 1, 4, 2, 4, 6);  -- En proceso

-- Zona de alerones y flaps
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-03-01', NULL, 1, 4, 3, 4, 3),  -- Pendiente
('2024-03-01', NULL, 1, 4, 3, 4, 6);  -- En proceso

-- Para Colón

-- Zona de trenes de aterrizaje
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-01-01', NULL, 1, 4, 9, 4, 3),  -- Pendiente
('2024-01-01', NULL, 1, 4, 9, 4, 6);  -- En proceso

-- Zona de fuselajes
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-02-01', NULL, 1, 4, 10, 4, 3),  -- Pendiente
('2024-02-01', NULL, 1, 4, 10, 4, 6);  -- En proceso

-- Para Guaira

-- Zona de ensamblaje
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-01-01', NULL, 1, 4, 15, 4, 3),  -- Pendiente
('2024-01-01', NULL, 1, 4, 15, 4, 6);  -- En proceso

-- Zona de calibración
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-02-01', NULL, 1, 4, 16, 4, 3),  -- Pendiente
('2024-02-01', NULL, 1, 4, 16, 4, 6);  -- En proceso

-- Para Guatire

-- Zona de integración
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-01-01', NULL, 1, 4, 19, 4, 3),  -- Pendiente
('2024-01-01', NULL, 1, 4, 19, 4, 6);  -- En proceso

-- Zona de soldadura
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-02-01', NULL, 1, 4, 20, 4, 3),  -- Pendiente
('2024-02-01', NULL, 1, 4, 20, 4, 6);  -- En proceso

-- Para Valencia

-- Zona de porta equipajes
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-01-01', NULL, 1, 4, 25, 4, 3),  -- Pendiente
('2024-01-01', NULL, 1, 4, 25, 4, 6);  -- En proceso

-- Zona de piezas sanitarias
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-02-01', NULL, 1, 4, 26, 4, 3),  -- Pendiente
('2024-02-01', NULL, 1, 4, 26, 4, 6);  -- En proceso


-- ESTATUS_FEA A PARTIR DE SOLICITUD DE CLIENTES JURÍDICOS

-- ==========================================================
-- Inserción de datos: ESTATUS_FEA para AU-802F
-- ==========================================================

-- Para Maracay

-- Zona de alas
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-01-01', NULL, 1, 11, 1, 5, 3),  -- Pendiente
('2024-01-01', NULL, 1, 11, 1, 5, 6);  -- En proceso

-- Zona de estabilizadores
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-02-01', NULL, 1, 11, 2, 5, 3),  -- Pendiente
('2024-02-01', NULL, 1, 11, 2, 5, 6);  -- En proceso

-- Zona de alerones y flaps
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-03-01', NULL, 1, 11, 3, 5, 3),  -- Pendiente
('2024-03-01', NULL, 1, 11, 3, 5, 6);  -- En proceso

-- Para Colón

-- Zona de trenes de aterrizaje
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-01-01', NULL, 1, 11, 9, 5, 3),  -- Pendiente
('2024-01-01', NULL, 1, 11, 9, 5, 6);  -- En proceso

-- Zona de fuselajes
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-02-01', NULL, 1, 11, 10, 5, 3),  -- Pendiente
('2024-02-01', NULL, 1, 11, 10, 5, 6);  -- En proceso

-- Para Guaira

-- Zona de ensamblaje
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-01-01', NULL, 1, 11, 15, 5, 3),  -- Pendiente
('2024-01-01', NULL, 1, 11, 15, 5, 6);  -- En proceso

-- Zona de calibración
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-02-01', NULL, 1, 11, 16, 5, 3),  -- Pendiente
('2024-02-01', NULL, 1, 11, 16, 5, 6);  -- En proceso

-- Para Guatire

-- Zona de integración
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-01-01', NULL, 1, 11, 19, 5, 3),  -- Pendiente
('2024-01-01', NULL, 1, 11, 19, 5, 6);  -- En proceso

-- Zona de soldadura
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-02-01', NULL, 1, 11, 20, 5, 3),  -- Pendiente
('2024-02-01', NULL, 1, 11, 20, 5, 6);  -- En proceso

-- Para Valencia

-- Zona de porta equipajes
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-01-01', NULL, 1, 11, 25, 5, 3),  -- Pendiente
('2024-01-01', NULL, 1, 11, 25, 5, 6);  -- En proceso

-- Zona de piezas sanitarias
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-02-01', NULL, 1, 11, 26, 5, 3),  -- Pendiente
('2024-02-01', NULL, 1, 11, 26, 5, 6);  -- En proceso

-- ==========================================================
-- Inserción de datos: ESTATUS_FEA para AU-747GOLD
-- ==========================================================

-- Para Maracay

-- Zona de alas
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-01-01', NULL, 1, 13, 1, 6, 3),  -- Pendiente
('2024-01-01', NULL, 1, 13, 1, 6, 6);  -- En proceso

-- Zona de estabilizadores
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-02-01', NULL, 1, 13, 2, 6, 3),  -- Pendiente
('2024-02-01', NULL, 1, 13, 2, 6, 6);  -- En proceso

-- Zona de alerones y flaps
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-03-01', NULL, 1, 13, 3, 6, 3),  -- Pendiente
('2024-03-01', NULL, 1, 13, 3, 6, 6);  -- En proceso

-- Para Colón

-- Zona de trenes de aterrizaje
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-01-01', NULL, 1, 13, 9, 6, 3),  -- Pendiente
('2024-01-01', NULL, 1, 13, 9, 6, 6);  -- En proceso

-- Zona de fuselajes
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-02-01', NULL, 1, 13, 10, 6, 3),  -- Pendiente
('2024-02-01', NULL, 1, 13, 10, 6, 6);  -- En proceso

-- Para Guaira

-- Zona de ensamblaje
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-01-01', NULL, 1, 13, 15, 6, 3),  -- Pendiente
('2024-01-01', NULL, 1, 13, 15, 6, 6);  -- En proceso

-- Zona de calibración
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-02-01', NULL, 1, 13, 16, 6, 3),  -- Pendiente
('2024-02-01', NULL, 1, 13, 16, 6, 6);  -- En proceso

-- Para Guatire

-- Zona de integración
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-01-01', NULL, 1, 13, 19, 6, 3),  -- Pendiente
('2024-01-01', NULL, 1, 13, 19, 6, 6);  -- En proceso

-- Zona de soldadura
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-02-01', NULL, 1, 13, 20, 6, 3),  -- Pendiente
('2024-02-01', NULL, 1, 13, 20, 6, 6);  -- En proceso

-- Para Valencia

-- Zona de porta equipajes
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-01-01', NULL, 1, 13, 25, 6, 3),  -- Pendiente
('2024-01-01', NULL, 1, 13, 25, 6, 6);  -- En proceso

-- Zona de piezas sanitarias
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-02-01', NULL, 1, 13, 26, 6, 3),  -- Pendiente
('2024-02-01', NULL, 1, 13, 26, 6, 6);  -- En proceso

-- ==========================================================
-- Inserción de datos: ESTATUS_FEA para AU-87ABusiness
-- ==========================================================

-- Para Maracay

-- Zona de alas
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-01-01', NULL, 1, 16, 1, 7, 3),  -- Pendiente
('2024-01-01', NULL, 1, 16, 1, 7, 6);  -- En proceso

-- Zona de estabilizadores
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-02-01', NULL, 1, 16, 2, 7, 3),  -- Pendiente
('2024-02-01', NULL, 1, 16, 2, 7, 6);  -- En proceso

-- Zona de alerones y flaps
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-03-01', NULL, 1, 16, 3, 7, 3),  -- Pendiente
('2024-03-01', NULL, 1, 16, 3, 7, 6);  -- En proceso

-- Para Colón

-- Zona de trenes de aterrizaje
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-01-01', NULL, 1, 16, 9, 7, 3),  -- Pendiente
('2024-01-01', NULL, 1, 16, 9, 7, 6);  -- En proceso

-- Zona de fuselajes
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-02-01', NULL, 1, 16, 10, 7, 3),  -- Pendiente
('2024-02-01', NULL, 1, 16, 10, 7, 6);  -- En proceso

-- Para Guaira

-- Zona de ensamblaje
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-01-01', NULL, 1, 16, 15, 7, 3),  -- Pendiente
('2024-01-01', NULL, 1, 16, 15, 7, 6);  -- En proceso

-- Zona de calibración
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-02-01', NULL, 1, 16, 16, 7, 3),  -- Pendiente
('2024-02-01', NULL, 1, 16, 16, 7, 6);  -- En proceso

-- Para Guatire

-- Zona de integración
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-01-01', NULL, 1, 16, 19, 7, 3),  -- Pendiente
('2024-01-01', NULL, 1, 16, 19, 7, 6);  -- En proceso

-- Zona de soldadura
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-02-01', NULL, 1, 16, 20, 7, 3),  -- Pendiente
('2024-02-01', NULL, 1, 16, 20, 7, 6);  -- En proceso

-- Para Valencia

-- Zona de porta equipajes
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-01-01', NULL, 1, 16, 25, 7, 3),  -- Pendiente
('2024-01-01', NULL, 1, 16, 25, 7, 6);  -- En proceso

-- Zona de piezas sanitarias
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-02-01', NULL, 1, 16, 26, 7, 3),  -- Pendiente
('2024-02-01', NULL, 1, 16, 26, 7, 6);  -- En proceso

-- ==========================================================
-- Inserción de datos: ESTATUS_FEA para AU-802E
-- ==========================================================

-- Para Maracay

-- Zona de alas
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-01-01', NULL, 1, 10, 1, 8, 3),  -- Pendiente
('2024-01-01', NULL, 1, 10, 1, 8, 6);  -- En proceso

-- Zona de estabilizadores
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-02-01', NULL, 1, 10, 2, 8, 3),  -- Pendiente
('2024-02-01', NULL, 1, 10, 2, 8, 6);  -- En proceso

-- Zona de alerones y flaps
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-03-01', NULL, 1, 10, 3, 8, 3),  -- Pendiente
('2024-03-01', NULL, 1, 10, 3, 8, 6);  -- En proceso

-- Para Colón

-- Zona de trenes de aterrizaje
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-01-01', NULL, 1, 10, 9, 8, 3),  -- Pendiente
('2024-01-01', NULL, 1, 10, 9, 8, 6);  -- En proceso

-- Zona de fuselajes
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-02-01', NULL, 1, 10, 10, 8, 3),  -- Pendiente
('2024-02-01', NULL, 1, 10, 10, 8, 6);  -- En proceso

-- Para Guaira

-- Zona de ensamblaje
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-01-01', NULL, 1, 10, 15, 8, 3),  -- Pendiente
('2024-01-01', NULL, 1, 10, 15, 8, 6);  -- En proceso

-- Zona de calibración
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-02-01', NULL, 1, 10, 16, 8, 3),  -- Pendiente
('2024-02-01', NULL, 1, 10, 16, 8, 6);  -- En proceso

-- Para Guatire

-- Zona de integración
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-01-01', NULL, 1, 10, 19, 8, 3),  -- Pendiente
('2024-01-01', NULL, 1, 10, 19, 8, 6);  -- En proceso

-- Zona de soldadura
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-02-01', NULL, 1, 10, 20, 8, 3),  -- Pendiente
('2024-02-01', NULL, 1, 10, 20, 8, 6);  -- En proceso

-- Para Valencia

-- Zona de porta equipajes
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-01-01', NULL, 1, 10, 25, 8, 3),  -- Pendiente
('2024-01-01', NULL, 1, 10, 25, 8, 6);  -- En proceso

-- Zona de piezas sanitarias
INSERT INTO ESTATUS_FEA (efa_fecha_inicio, efa_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id, fk_est_id)
VALUES 
('2024-02-01', NULL, 1, 10, 26, 8, 3),  -- Pendiente
('2024-02-01', NULL, 1, 10, 26, 8, 6);  -- En proceso

-- ==========================================================
-- Inserción de datos: ESTATUS_ESP (Cliente Naturales)
-- ==========================================================

-- Solicitudes para el modelo AU-80
INSERT INTO ESTATUS_ESP (ets_fecha_inicio, ets_fecha_fin, fk_est_id, fk_edz_id) VALUES
('2024-01-01', '2024-02-01', 3, 1),  -- Pendiente, Maracay (Zona de alas)
('2024-02-01', '2024-03-01', 6, 2),  -- Proceso, Maracay (Zona de estabilizadores)
('2024-03-01', '2024-04-01', 5, 3),  -- Completado, Maracay (Zona de alerones y flaps)
('2024-04-01', '2024-05-01', 3, 4),  -- Pendiente, Colón (Zona de trenes de aterrizaje)
('2024-05-01', '2024-06-01', 6, 5),  -- Proceso, Colón (Zona de fuselajes)
('2024-06-01', '2024-07-01', 5, 6),  -- Completado, La Guaira (Zona de ensamblaje y calibración)
('2024-07-01', '2024-08-01', 3, 7),  -- Pendiente, Guatire (Zona de integración y soldadura)
('2024-08-01', '2024-09-01', 6, 8),  -- Proceso, Valencia (Zona de porta equipajes)
('2024-09-01', '2024-10-01', 5, 9);  -- Completado, Valencia (Zona de piezas sanitarias)

-- Solicitudes para el modelo AU-801
INSERT INTO ESTATUS_ESP (ets_fecha_inicio, ets_fecha_fin, fk_est_id, fk_edz_id) VALUES
('2024-01-01', '2024-02-01', 3, 10), -- Pendiente, Maracay (Zona de alas)
('2024-02-01', '2024-03-01', 6, 11), -- Proceso, Maracay (Zona de estabilizadores)
('2024-03-01', '2024-04-01', 5, 12), -- Completado, Maracay (Zona de alerones y flaps)
('2024-04-01', '2024-05-01', 3, 13), -- Pendiente, Colón (Zona de trenes de aterrizaje)
('2024-05-01', '2024-06-01', 6, 14), -- Proceso, Colón (Zona de fuselajes)
('2024-06-01', '2024-07-01', 5, 15), -- Completado, La Guaira (Zona de ensamblaje y calibración)
('2024-07-01', '2024-08-01', 3, 16), -- Pendiente, Guatire (Zona de integración y soldadura)
('2024-08-01', '2024-09-01', 6, 17), -- Proceso, Valencia (Zona de porta equipajes)
('2024-09-01', '2024-10-01', 5, 18); -- Completado, Valencia (Zona de piezas sanitarias)

-- Solicitudes para el modelo AU-802A
INSERT INTO ESTATUS_ESP (ets_fecha_inicio, ets_fecha_fin, fk_est_id, fk_edz_id) VALUES
('2024-01-01', '2024-02-01', 3, 19), -- Pendiente, Maracay (Zona de alas)
('2024-02-01', '2024-03-01', 6, 20), -- Proceso, Maracay (Zona de estabilizadores)
('2024-03-01', '2024-04-01', 5, 21), -- Completado, Maracay (Zona de alerones y flaps)
('2024-04-01', '2024-05-01', 3, 22), -- Pendiente, Colón (Zona de trenes de aterrizaje)
('2024-05-01', '2024-06-01', 6, 23), -- Proceso, Colón (Zona de fuselajes)
('2024-06-01', '2024-07-01', 5, 24), -- Completado, La Guaira (Zona de ensamblaje y calibración)
('2024-07-01', '2024-08-01', 3, 25), -- Pendiente, Guatire (Zona de integración y soldadura)
('2024-08-01', '2024-09-01', 6, 26), -- Proceso, Valencia (Zona de porta equipajes)
('2024-09-01', '2024-10-01', 5, 27); -- Completado, Valencia (Zona de piezas sanitarias)

-- Solicitudes para el modelo AU-747PLUS
INSERT INTO ESTATUS_ESP (ets_fecha_inicio, ets_fecha_fin, fk_est_id, fk_edz_id) VALUES
('2024-01-01', '2024-02-01', 3, 28), -- Pendiente, Maracay (Zona de alas)
('2024-02-01', '2024-03-01', 6, 29), -- Proceso, Maracay (Zona de estabilizadores)
('2024-03-01', '2024-04-01', 5, 30), -- Completado, Maracay (Zona de alerones y flaps)
('2024-04-01', '2024-05-01', 3, 31), -- Pendiente, Colón (Zona de trenes de aterrizaje)
('2024-05-01', '2024-06-01', 6, 32), -- Proceso, Colón (Zona de fuselajes)
('2024-06-01', '2024-07-01', 5, 33), -- Completado, La Guaira (Zona de ensamblaje y calibración)
('2024-07-01', '2024-08-01', 3, 34), -- Pendiente, Guatire (Zona de integración y soldadura)
('2024-08-01', '2024-09-01', 6, 35), -- Proceso, Valencia (Zona de porta equipajes)
('2024-09-01', '2024-10-01', 5, 36); -- Completado, Valencia (Zona de piezas sanitarias)


-- ==========================================================
-- Inserción de datos: ESTATUS_ESP (Cliente Jurídicos)
-- ==========================================================

-- Solicitudes para el modelo AU-802F
INSERT INTO ESTATUS_ESP (ets_fecha_inicio, ets_fecha_fin, fk_est_id, fk_edz_id) VALUES
('2024-01-01', '2024-02-01', 3, 37), -- Pendiente, Maracay (Zona de alas)
('2024-02-01', '2024-03-01', 6, 38), -- Proceso, Maracay (Zona de estabilizadores)
('2024-03-01', '2024-04-01', 5, 39), -- Completado, Maracay (Zona de alerones y flaps)
('2024-04-01', '2024-05-01', 3, 40), -- Pendiente, Colón (Zona de trenes de aterrizaje)
('2024-05-01', '2024-06-01', 6, 41), -- Proceso, Colón (Zona de fuselajes)
('2024-06-01', '2024-07-01', 5, 42), -- Completado, La Guaira (Zona de ensamblaje y calibración)
('2024-07-01', '2024-08-01', 3, 43), -- Pendiente, Guatire (Zona de integración y soldadura)
('2024-08-01', '2024-09-01', 6, 44), -- Proceso, Valencia (Zona de porta equipajes)
('2024-09-01', '2024-10-01', 5, 45); -- Completado, Valencia (Zona de piezas sanitarias)

-- Solicitudes para el modelo AU-747Gold
INSERT INTO ESTATUS_ESP (ets_fecha_inicio, ets_fecha_fin, fk_est_id, fk_edz_id) VALUES
('2024-01-01', '2024-02-01', 3, 46), -- Pendiente, Maracay (Zona de alas)
('2024-02-01', '2024-03-01', 6, 47), -- Proceso, Maracay (Zona de estabilizadores)
('2024-03-01', '2024-04-01', 5, 48), -- Completado, Maracay (Zona de alerones y flaps)
('2024-04-01', '2024-05-01', 3, 49), -- Pendiente, Colón (Zona de trenes de aterrizaje)
('2024-05-01', '2024-06-01', 6, 50), -- Proceso, Colón (Zona de fuselajes)
('2024-06-01', '2024-07-01', 5, 51), -- Completado, La Guaira (Zona de ensamblaje y calibración)
('2024-07-01', '2024-08-01', 3, 52), -- Pendiente, Guatire (Zona de integración y soldadura)
('2024-08-01', '2024-09-01', 6, 53), -- Proceso, Valencia (Zona de porta equipajes)
('2024-09-01', '2024-10-01', 5, 54); -- Completado, Valencia (Zona de piezas sanitarias)

-- Solicitudes para el modelo AU-87ABusiness
INSERT INTO ESTATUS_ESP (ets_fecha_inicio, ets_fecha_fin, fk_est_id, fk_edz_id) VALUES
('2024-01-01', '2024-02-01', 3, 55), -- Pendiente, Maracay (Zona de alas)
('2024-02-01', '2024-03-01', 6, 56), -- Proceso, Maracay (Zona de estabilizadores)
('2024-03-01', '2024-04-01', 5, 57), -- Completado, Maracay (Zona de alerones y flaps)
('2024-04-01', '2024-05-01', 3, 58), -- Pendiente, Colón (Zona de trenes de aterrizaje)
('2024-05-01', '2024-06-01', 6, 59), -- Proceso, Colón (Zona de fuselajes)
('2024-06-01', '2024-07-01', 5, 60), -- Completado, La Guaira (Zona de ensamblaje y calibración)
('2024-07-01', '2024-08-01', 3, 61), -- Pendiente, Guatire (Zona de integración y soldadura)
('2024-08-01', '2024-09-01', 6, 62), -- Proceso, Valencia (Zona de porta equipajes)
('2024-09-01', '2024-10-01', 5, 63); -- Completado, Valencia (Zona de piezas sanitarias)

-- Solicitudes para el modelo AU-802E
INSERT INTO ESTATUS_ESP (ets_fecha_inicio, ets_fecha_fin, fk_est_id, fk_edz_id) VALUES
('2024-01-01', '2024-02-01', 3, 64), -- Pendiente, Maracay (Zona de alas)
('2024-02-01', '2024-03-01', 6, 65), -- Proceso, Maracay (Zona de estabilizadores)
('2024-03-01', '2024-04-01', 5, 66), -- Completado, Maracay (Zona de alerones y flaps)
('2024-04-01', '2024-05-01', 3, 67), -- Pendiente, Colón (Zona de trenes de aterrizaje)
('2024-05-01', '2024-06-01', 6, 68), -- Proceso, Colón (Zona de fuselajes)
('2024-06-01', '2024-07-01', 5, 69), -- Completado, La Guaira (Zona de ensamblaje y calibración)
('2024-07-01', '2024-08-01', 3, 70), -- Pendiente, Guatire (Zona de integración y soldadura)
('2024-08-01', '2024-09-01', 6, 71), -- Proceso, Valencia (Zona de porta equipajes)
('2024-09-01', '2024-10-01', 5, 72); -- Completado, Valencia (Zona de piezas sanitarias)

-- ===================================================================
-- Inserción de datos: ESTATUS_PP_SOLICITUD Clientes Naturales
-- ====================================================================

-- Estatus de las pruebas de piezas del modelo AU-80
INSERT INTO ESTATUS_PP_SOLICITUD (api_fecha_inicio, api_fecha_fin, fk_zon_id, fk_edz_id, fk_pru_id, fk_est_id) VALUES
('2024-01-01', '2024-02-01', 5, 1, 1, 5),
('2024-02-01', '2024-03-01', 5, 2, 11, 5),
('2024-03-01', '2024-04-01', 5, 3, 53, 5), 
('2024-04-01', '2024-05-01', 11, 4, 23, 5), 
('2024-05-01', '2024-06-01', 11, 5, 57, 5),
('2024-06-01', '2024-07-01', 14, 6, 49, 5),
('2024-07-01', '2024-08-01', 21, 7, 25, 5),
('2024-08-01', '2024-09-01', 29, 8, 44, 5),
('2024-09-01', '2024-10-01', 29, 9, 46, 5);

-- Estatus de las pruebas de piezas del modelo AU-801
INSERT INTO ESTATUS_PP_SOLICITUD (api_fecha_inicio, api_fecha_fin, fk_zon_id, fk_edz_id, fk_pru_id, fk_est_id) VALUES
('2024-01-01', '2024-02-01', 5, 10, 3, 5),
('2024-02-01', '2024-03-01', 5, 11, 15, 5),
('2024-03-01', '2024-04-01', 5, 12, 53, 5),
('2024-04-01', '2024-05-01', 11, 13, 24, 5),
('2024-05-01', '2024-06-01', 11, 14, 57, 5),
('2024-06-01', '2024-07-01', 14, 15, 49, 5),
('2024-07-01', '2024-08-01', 21, 16, 25, 5),
('2024-08-01', '2024-09-01', 29, 17, 44, 5),
('2024-09-01', '2024-10-01', 29, 18, 46, 5);

-- Estatus de las pruebas de piezas del modelo AU-802A
INSERT INTO ESTATUS_PP_SOLICITUD (api_fecha_inicio, api_fecha_fin, fk_zon_id, fk_edz_id, fk_pru_id, fk_est_id) VALUES
('2024-01-01', '2024-02-01', 5, 19, 1, 5),
('2024-02-01', '2024-03-01', 5, 20, 11, 5),
('2024-03-01', '2024-04-01', 5, 21, 53, 5),
('2024-04-01', '2024-05-01', 11, 22, 24, 5),
('2024-05-01', '2024-06-01', 11, 23, 57, 5),
('2024-06-01', '2024-07-01', 14, 24, 49, 5),
('2024-07-01', '2024-08-01', 21, 25, 25, 5),
('2024-08-01', '2024-09-01', 29, 26, 44, 5),
('2024-09-01', '2024-10-01', 29, 27, 46, 5);

-- Estatus de las pruebas de piezas del modelo AU-747PLUS
INSERT INTO ESTATUS_PP_SOLICITUD (api_fecha_inicio, api_fecha_fin, fk_zon_id, fk_edz_id, fk_pru_id, fk_est_id) VALUES
('2024-01-01', '2024-02-01', 5, 28, 3, 5),
('2024-02-01', '2024-03-01', 5, 29, 15, 5),
('2024-03-01', '2024-04-01', 5, 30, 53, 5),
('2024-04-01', '2024-05-01', 11, 31, 23, 5),
('2024-05-01', '2024-06-01', 11, 32, 57, 5),
('2024-06-01', '2024-07-01', 14, 33, 49, 5),
('2024-07-01', '2024-08-01', 21, 34, 25, 5),
('2024-08-01', '2024-09-01', 29, 35, 44, 5),
('2024-09-01', '2024-10-01', 29, 36, 46, 5);

-- ===================================================================
-- Inserción de datos: ESTATUS_PP_SOLICITUD Clientes Juridico
-- ====================================================================

-- Estatus de las pruebas de piezas del modelo AU-802F
INSERT INTO ESTATUS_PP_SOLICITUD (api_fecha_inicio, api_fecha_fin, fk_zon_id, fk_edz_id, fk_pru_id, fk_est_id) VALUES
('2024-01-01', '2024-02-01', 5, 37, 7, 5),
('2024-02-01', '2024-03-01', 5, 38, 19, 5),
('2024-03-01', '2024-04-01', 5, 39, 53, 5),
('2024-04-01', '2024-05-01', 11, 40, 24, 5),
('2024-05-01', '2024-06-01', 11, 41, 57, 5),
('2024-06-01', '2024-07-01', 14, 42, 49, 5),
('2024-07-01', '2024-08-01', 21, 43, 25, 5),
('2024-08-01', '2024-09-01', 29, 44, 44, 5),
('2024-09-01', '2024-10-01', 29, 45, 46, 5);

-- Estatus de las pruebas de piezas del modelo AU-747Gold
INSERT INTO ESTATUS_PP_SOLICITUD (api_fecha_inicio, api_fecha_fin, fk_zon_id, fk_edz_id, fk_pru_id, fk_est_id) VALUES
('2024-01-01', '2024-02-01', 5, 46, 5, 5),
('2024-02-01', '2024-03-01', 5, 47, 21, 5),
('2024-03-01', '2024-04-01', 5, 48, 53, 5),
('2024-04-01', '2024-05-01', 11, 49, 23, 5),
('2024-05-01', '2024-06-01', 11, 50, 57, 5),
('2024-06-01', '2024-07-01', 14, 51, 49, 5),
('2024-07-01', '2024-08-01', 21, 52, 25, 5),
('2024-08-01', '2024-09-01', 29, 53, 44, 5),
('2024-09-01', '2024-10-01', 29, 54, 46, 5);

-- Estatus de las pruebas de piezas del modelo AU-87ABusiness
INSERT INTO ESTATUS_PP_SOLICITUD (api_fecha_inicio, api_fecha_fin, fk_zon_id, fk_edz_id, fk_pru_id, fk_est_id) VALUES
('2024-01-01', '2024-02-01', 5, 55, 9, 5),
('2024-02-01', '2024-03-01', 5, 56, 13, 5),
('2024-03-01', '2024-04-01', 5, 57, 53, 5),
('2024-04-01', '2024-05-01', 11, 58, 23, 5),
('2024-05-01', '2024-06-01', 11, 59, 57, 5),
('2024-06-01', '2024-07-01', 14, 60, 49, 5),
('2024-07-01', '2024-08-01', 21, 61, 25, 5),
('2024-08-01', '2024-09-01', 29, 62, 44, 5),
('2024-09-01', '2024-10-01', 29, 63, 46, 5);

-- Estatus de las pruebas de piezas del modelo AU-802E
INSERT INTO ESTATUS_PP_SOLICITUD (api_fecha_inicio, api_fecha_fin, fk_zon_id, fk_edz_id, fk_pru_id, fk_est_id) VALUES
('2024-01-01', '2024-02-01', 5, 64, 3, 5),
('2024-02-01', '2024-03-01', 5, 65, 11, 5),
('2024-03-01', '2024-04-01', 5, 66, 53, 5),
('2024-04-01', '2024-05-01', 11, 67, 23, 5),
('2024-05-01', '2024-06-01', 11, 68, 57, 5),
('2024-06-01', '2024-07-01', 14, 69, 49, 5),
('2024-07-01', '2024-08-01', 21, 70, 25, 5),
('2024-08-01', '2024-09-01', 29, 71, 44, 5),
('2024-09-01', '2024-10-01', 29, 72, 46, 5);



-- =========================================================