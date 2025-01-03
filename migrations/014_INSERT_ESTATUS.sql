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
