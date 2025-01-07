-- ==========================================================
-- Inserción de datos: PROCESO_ENSAMBLE_AVION_CONF
-- ==========================================================

INSERT INTO PROCESO_ENSAMBLE_AVION_CONF (epv_nombre_proceso, epv_tiempo_estimado, epv_descripcion)
VALUES ('Fabricación de Componentes', '1 month', 'Fabricación de partes: alas, fuselaje, estabilizadores, etc.'),
	   ('Ensamblaje del Fuselaje', '2 weeks', 'Unión de secciones y montaje de la estructura principal.'),
	   ('Ensamblaje de las Alas', '1 week', 'Unión de partes y fijación al fuselaje.'),
	   ('Instalación del Empenaje', '3 days', 'Montaje del estabilizador vertical y horizontal (cola).'),
	   ('Instalación del Tren de Aterrizaje', '4 days', 'Montaje del sistema de aterrizaje.'),
	   ('Instalación de Sistemas', '3 weeks', 'Instalación de sistemas: eléctricos, hidráulicos, combustible, control y aviónica.'),
	   ('Instalación de Motores', '1 week', 'Montaje de los motores.'),
	   ('Instalación del Cableado', '2 weeks', 'Instalación del cableado eléctrico y de sistemas.'),
       ('Ajustes Finales y Calibración', '1 week', 'Ajuste y calibración de sistemas y componentes.'),
	   ('Pintura', '1 week', 'Aplicación de pintura y acabados.'),
	   ('Acondicionamiento Interior', '2 weeks', 'Instalación de interiores');


-- ==========================================================
-- Inserción de datos: FASE_ENSAMBLE_AVION_CONF
-- ==========================================================

INSERT INTO FASE_ENSAMBLE_AVION_CONF (fk_epv_id, fk_mda_id) 
VALUES (1, 3),  -- Fabricación de Componentes - AU-802 
	   (2, 7),  -- Ensamblaje del Fuselaje - AU-802B 
	   (3, 1),  -- Ensamblaje de las Alas - AU-80 
	   (4, 12), -- Instalación del Empenaje - AU-747Gold 
	   (5, 5),  -- Instalación del Tren de Aterrizaje - AU-87A 
	   (6, 9),  -- Instalación de Sistemas - AU-802D 
	   (6, 8),  -- Instalación de Sistemas - AU-802C 
	   (7, 4),  -- Instalación de Motores - AU-747Plus 
	   (8, 2),  -- Instalación del Cableado - AU-801 
	   (9, 15), -- Ajustes Finales y Calibración - AU-87ABusiness
	   (10, 8); -- Pintura - AU-802C 


-- ===================================================
-- Inserción de datos: PROCESO_ENSAMBLE_PIEZA_CONF
-- ===================================================
INSERT INTO PROCESO_ENSAMBLE_PIEZA_CONF (epc_nombre_proceso, epc_tiempo_estimado, epc_descripcion) 
VALUES ('Corte', '4 hours', 'Corte de material base a la forma inicial.'),
	   ('Mecanizado', '10 hours', 'Remoción de material para dar forma precisa a la pieza.'),
	   ('Conformado', '6 hours', 'Procesos de doblado, plegado o estirado.'),
	   ('Soldadura', '8 hours', 'Unión de componentes mediante soldadura.'),
	   ('Tratamiento Térmico', '12 hours', 'Mejora de propiedades mecánicas con calor.'),
	   ('Inspección END', '4 hours', 'Detección de defectos sin dañar la pieza.'),
	   ('Acabado Superficial', '6 hours', 'Tratamientos protectores y estéticos.'),
	   ('Pintura', '8 hours', 'Aplicación de pintura y recubrimientos.'),
	   ('Ensamble', '10 hours', 'Unión de subcomponentes.'),
	   ('Detallado/Acabado Manual', '4 hours', 'Ajustes finales y pulido.');

-- ===================================================
-- Inserción de datos: FASE_ENSAMBLE_PIEZA_CONF
-- ===================================================
INSERT INTO FASE_ENSAMBLE_PIEZA_CONF (fk_epc_id, fk_mec_id)
VALUES (1, 1),
	   (7, 2),
	   (2, 4),
	   (9, 3),
	   (6, 5),
	   (3, 7),
	   (5, 8),
	   (1, 15),
	   (2, 6),
	   (2, 3);
	   
-- =====================================
-- Inserción de datos: MATERIAL_FASE
-- ======================================
INSERT INTO MATERIAL_FASE (mtf_unidad_medida, mtf_cantidad_material, fk_mac_id, fk_epc_id, fk_mec_id)
VALUES ('kg', 50, 1, 1, 1),
	   ('kg', 25, 2, 7, 2),
	   ('kg', 100, 3, 2, 4),
	   ('kg', 15, 4, 9, 3),
	   ('m²', 10, 5, 6, 5),
	   ('kg', 20, 6, 3, 7),
	   ('m', 50, 7, 5, 8),
	   ('kg', 30, 8, 1, 15),
	   ('kg', 5, 9, 2, 6),
	   ('kg', 40, 10, 2, 3);


-- =====================================
-- Inserción de datos: AVION_COMPONENTE
-- ======================================

INSERT INTO AVION_COMPONENTE (ctm_cantidad_piezas, fk_epv_id, fk_mda_id, fk_mec_id) VALUES
-- AU-802 - Fabricación de Componentes
(2, 1, 3, 1),    -- 2 Alas Rectas
(1, 1, 3, 6),    -- 1 Estabilizador Forma Estándar

-- AU-802B - Ensamblaje del Fuselaje
(20, 2, 7, 32),  -- 20 Asientos
(20, 2, 7, 33),  -- 20 Porta Equipajes
(1, 2, 7, 35),   -- 1 Piezas Sanitarias

-- AU-747Platinium - Instalación del Empenaje
(1, 4, 12, 8),   -- 1 Estabilizador Forma en Cruz

-- AU-87A - Instalación del Tren de Aterrizaje
(1, 5, 5, 13),   -- 1 Tren Retráctil

-- AU-802D - Instalación de Sistemas (Aquí va el anemómetro y otros instrumentos)
(1, 6, 9, 14),   -- 1 Anemómetro
(1, 6, 9, 15),   -- 1 Altímetro
(1, 6, 9, 22),   -- 1 DME
(1, 6, 9, 23),   -- 1 CDI
(1, 6, 9, 25),   -- 1 Piloto Automático
(1, 6, 9, 24),   -- 1 ILS
(1, 6, 9, 26);   -- 1 Sistema de Gestión de Vuelo


-- ==========================================================
-- Inserción de datos: PROCESO_ENSAMBLE_AVION_EJEC
-- ==========================================================
INSERT INTO PROCESO_ENSAMBLE_AVION_EJEC (eav_nombre_proceso, eav_tiempo_estimado, eav_descripcion)
VALUES 
('Fabricación de Componentes', '1 month', 'Fabricación de partes: alas, fuselaje, estabilizadores, etc.'),
('Ensamblaje del Fuselaje', '2 weeks', 'Unión de secciones y montaje de la estructura principal.'),
('Ensamblaje de las Alas', '1 week', 'Unión de partes y fijación al fuselaje.'),
('Instalación del Empenaje', '3 days', 'Montaje del estabilizador vertical y horizontal (cola).'),
('Instalación del Tren de Aterrizaje', '4 days', 'Montaje del sistema de aterrizaje.'),
('Instalación de Sistemas', '3 weeks', 'Instalación de sistemas: eléctricos, hidráulicos, combustible, control y aviónica.'),
('Instalación de Motores', '1 week', 'Montaje de los motores.'),
('Instalación del Cableado', '2 weeks', 'Instalación del cableado eléctrico y de sistemas.'),
('Ajustes Finales y Calibración', '1 week', 'Ajuste y calibración de sistemas y componentes.'),
('Pintura', '1 week', 'Aplicación de pintura y acabados.'),
('Acondicionamiento Interior', '2 weeks', 'Instalación de interiores'),
('Retoques finales', '1 week', 'Revisión de detalles antes de la entrega');

-- ==========================================================
-- Inserción de datos: PROCESO_ENSAMBLE_PIEZA (Ejecución)
-- ==========================================================
INSERT INTO PROCESO_ENSAMBLE_PIEZA_EJEC (esp_nombre_proceso, esp_tiempo_estimado, esp_descripcion) 
VALUES ('Corte', '4 hours', 'Corte de material base a la forma inicial.'),
       ('Mecanizado', '10 hours', 'Remoción de material para dar forma precisa a la pieza.'),
       ('Conformado', '6 hours', 'Procesos de doblado, plegado o estirado.'),
       ('Soldadura', '8 hours', 'Unión de componentes mediante soldadura.'),
       ('Tratamiento Térmico', '12 hours', 'Mejora de propiedades mecánicas con calor.'),
       ('Inspección END', '4 hours', 'Detección de defectos sin dañar la pieza.'),
       ('Acabado Superficial', '6 hours', 'Tratamientos protectores y estéticos.'),
       ('Pintura', '8 hours', 'Aplicación de pintura y recubrimientos.'),
       ('Ensamble', '10 hours', 'Unión de subcomponentes.'),
       ('Detallado/Acabado Manual', '4 hours', 'Ajustes finales y pulido.');

-- FASE ENSAMBLE A PARTIR DE SOLICITUD DE CLIENTES NATURALES

-- ==========================================================
-- Inserción de datos: FASE_ENSAMBLE_AVION  AU-80
-- ==========================================================

-- Maracay
INSERT INTO FASE_ENSAMBLE_AVION (fln_fecha_inicio, fln_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id) 
VALUES 
-- Zona de alas
('2024-01-01', NULL, 1, 1, 1, 1),
-- Zona de estabilizadores
('2024-02-01', NULL, 1, 1, 2, 1),
-- Zona de alerones y flaps
('2024-03-01', NULL, 1, 1, 3, 1);

-- Colón
INSERT INTO FASE_ENSAMBLE_AVION (fln_fecha_inicio, fln_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id) 
VALUES  
-- Zona de trenes de aterrizaje
('2024-01-01', NULL, 1, 1, 9, 1),
-- Zona de fuselajes
('2024-02-01', NULL, 1, 1, 10, 1);

-- Guaira
INSERT INTO FASE_ENSAMBLE_AVION (fln_fecha_inicio, fln_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id) 
VALUES 
-- Zona de ensamblaje 
('2024-01-01', NULL, 1, 1, 15, 1),
-- Zona de calibración 
('2024-02-01', NULL, 1, 1, 16, 1);

-- Guatire
INSERT INTO FASE_ENSAMBLE_AVION (fln_fecha_inicio, fln_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id) 
VALUES 
-- Zona de integración 
('2024-01-01', NULL, 1, 1, 19, 1),
-- Zona de soldadura 
('2024-02-01', NULL, 1, 1, 20, 1);

--Valencia
INSERT INTO FASE_ENSAMBLE_AVION (fln_fecha_inicio, fln_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id) 
VALUES 
-- Zona de porta equipajes 
('2024-01-01', NULL, 1, 1, 25, 1),
-- Zona de piezas sanitarias
('2024-02-01', NULL, 1, 1, 26, 1);

-- ==========================================================
-- Inserción de datos: FASE_ENSAMBLE_AVION  AU-801
-- ==========================================================

-- Maracay
INSERT INTO FASE_ENSAMBLE_AVION (fln_fecha_inicio, fln_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id) 
VALUES 
-- Zona de alas
('2024-01-01', NULL, 1, 2, 1, 2),
-- Zona de estabilizadores
('2024-02-01', NULL, 1, 2, 2, 2),
-- Zona de alerones y flaps
('2024-03-01', NULL, 1, 2, 3, 2);

-- Colón
INSERT INTO FASE_ENSAMBLE_AVION (fln_fecha_inicio, fln_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id) 
VALUES 
-- Zona de trenes de aterrizaje
('2024-01-01', NULL, 1, 2, 9, 2),
-- Zona de fuselajes
('2024-02-01', NULL, 1, 2, 10, 2);

-- Guaira
INSERT INTO FASE_ENSAMBLE_AVION (fln_fecha_inicio, fln_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id) 
VALUES 
-- Zona de ensamblaje 
('2024-01-01', NULL, 1, 2, 15, 2),
-- Zona de calibración 
('2024-02-01', NULL, 1, 2, 16, 2);

-- Guatire
INSERT INTO FASE_ENSAMBLE_AVION (fln_fecha_inicio, fln_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id) 
VALUES 
-- Zona de integración 
('2024-01-01', NULL, 1, 2, 19, 2),
-- Zona de soldadura 
('2024-02-01', NULL, 1, 2, 20, 2);

--Valencia
INSERT INTO FASE_ENSAMBLE_AVION (fln_fecha_inicio, fln_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id) 
VALUES 
-- Zona de porta equipajes 
('2024-01-01', NULL, 1, 2, 25, 2),
-- Zona de piezas sanitarias
('2024-02-01', NULL, 1, 2, 26, 2);

-- ==========================================================
-- Inserción de datos: FASE_ENSAMBLE_AVION  AU-802A 
-- ==========================================================

-- Maracay
INSERT INTO FASE_ENSAMBLE_AVION (fln_fecha_inicio, fln_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id) 
VALUES 
-- Zona de alas
('2024-01-01', NULL, 1, 6, 1, 3),
-- Zona de estabilizadores
('2024-02-01', NULL, 1, 6, 2, 3),
-- Zona de alerones y flaps
('2024-03-01', NULL, 1, 6, 3, 3);

-- Colón
INSERT INTO FASE_ENSAMBLE_AVION (fln_fecha_inicio, fln_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id) 
VALUES 
-- Zona de trenes de aterrizaje
('2024-01-01', NULL, 1, 6, 9, 3),
-- Zona de fuselajes
('2024-02-01', NULL, 1, 6, 10, 3);

-- Guaira
INSERT INTO FASE_ENSAMBLE_AVION (fln_fecha_inicio, fln_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id) 
VALUES 
-- Zona de ensamblaje 
('2024-01-01', NULL, 1, 6, 15, 3),
-- Zona de calibración 
('2024-02-01', NULL, 1, 6, 16, 3);

-- Guatire
INSERT INTO FASE_ENSAMBLE_AVION (fln_fecha_inicio, fln_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id) 
VALUES 
-- Zona de integración 
('2024-01-01', NULL, 1, 6, 19, 3),
-- Zona de soldadura 
('2024-02-01', NULL, 1, 6, 20, 3);

--Valencia
INSERT INTO FASE_ENSAMBLE_AVION (fln_fecha_inicio, fln_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id) 
VALUES  
-- Zona de porta equipajes 
('2024-01-01', NULL, 1, 6, 25, 3),
-- Zona de piezas sanitarias
('2024-02-01', NULL, 1, 6, 26, 3);

-- ==========================================================
-- Inserción de datos: FASE_ENSAMBLE_AVION  AU-747PLUS
-- ==========================================================

-- Maracay
INSERT INTO FASE_ENSAMBLE_AVION (fln_fecha_inicio, fln_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id) 
VALUES  
-- Zona de alas
('2024-01-01', NULL, 1, 4, 1, 4),
-- Zona de estabilizadores
('2024-02-01', NULL, 1, 4, 2, 4),
-- Zona de alerones y flaps
('2024-03-01', NULL, 1, 4, 3, 4);

-- Colón
INSERT INTO FASE_ENSAMBLE_AVION (fln_fecha_inicio, fln_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id) 
VALUES 
-- Zona de trenes de aterrizaje
('2024-01-01', NULL, 1, 4, 9, 4),
-- Zona de fuselajes
('2024-02-01', NULL, 1, 4, 10, 4);

-- Guaira
INSERT INTO FASE_ENSAMBLE_AVION (fln_fecha_inicio, fln_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id) 
VALUES 
-- Zona de ensamblaje 
('2024-01-01', NULL, 1, 4, 15, 4),
-- Zona de calibración 
('2024-02-01', NULL, 1, 4, 16, 4);

-- Guatire
INSERT INTO FASE_ENSAMBLE_AVION (fln_fecha_inicio, fln_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id) 
VALUES 
-- Zona de integración 
('2024-01-01', NULL, 1, 4, 19, 4),
-- Zona de soldadura 
('2024-02-01', NULL, 1, 4, 20, 4);

--Valencia
INSERT INTO FASE_ENSAMBLE_AVION (fln_fecha_inicio, fln_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id) 
VALUES 
-- Zona de porta equipajes 
('2024-01-01', NULL, 1, 4, 25, 4),
-- Zona de piezas sanitarias
('2024-02-01', NULL, 1, 4, 26, 4);



-- FASE ENSAMBLE A PARTIR DE SOLICITUDES DE CLIENTES JURÍDICOS

-- ==========================================================
-- Inserción de datos: FASE_ENSAMBLE_AVION  AU-802F
-- ==========================================================

-- Maracay
INSERT INTO FASE_ENSAMBLE_AVION (fln_fecha_inicio, fln_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id) 
VALUES 
-- Zona de alas
('2024-01-01', NULL, 1, 11, 1, 5),
-- Zona de estabilizadores
('2024-02-01', NULL, 1, 11, 2, 5),
-- Zona de alerones y flaps
('2024-03-01', NULL, 1, 11, 3, 5);

-- Colón
INSERT INTO FASE_ENSAMBLE_AVION (fln_fecha_inicio, fln_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id) 
VALUES 
-- Zona de trenes de aterrizaje
('2024-01-01', NULL, 1, 11, 9, 5),
-- Zona de fuselajes
('2024-02-01', NULL, 1, 11, 10, 5);

-- Guaira
INSERT INTO FASE_ENSAMBLE_AVION (fln_fecha_inicio, fln_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id) 
VALUES 
-- Zona de ensamblaje 
('2024-01-01', NULL, 1, 11, 15, 5),
-- Zona de calibración 
('2024-02-01', NULL, 1, 11, 16, 5);

-- Guatire
INSERT INTO FASE_ENSAMBLE_AVION (fln_fecha_inicio, fln_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id) 
VALUES 
-- Zona de integración 
('2024-01-01', NULL, 1, 11, 19, 5),
-- Zona de soldadura 
('2024-02-01', NULL, 1, 11, 20, 5);

--Valencia
INSERT INTO FASE_ENSAMBLE_AVION (fln_fecha_inicio, fln_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id) 
VALUES 
-- Zona de porta equipajes 
('2024-01-01', NULL, 1, 11, 25, 5),
-- Zona de piezas sanitarias
('2024-02-01', NULL, 1, 11, 26, 5);

-- ==========================================================
-- Inserción de datos: FASE_ENSAMBLE_AVION  AU-747Gold
-- ==========================================================

-- Maracay
INSERT INTO FASE_ENSAMBLE_AVION (fln_fecha_inicio, fln_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id) 
VALUES  
-- Zona de alas
('2024-01-01', NULL, 1, 13, 1, 6),
-- Zona de estabilizadores
('2024-02-01', NULL, 1, 13, 2, 6),
-- Zona de alerones y flaps
('2024-03-01', NULL, 1, 13, 3, 6);

-- Colón
INSERT INTO FASE_ENSAMBLE_AVION (fln_fecha_inicio, fln_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id) 
VALUES 
-- Zona de trenes de aterrizaje
('2024-01-01', NULL, 1, 13, 9, 6),
-- Zona de fuselajes
('2024-02-01', NULL, 1, 13, 10, 6);

-- Guaira
INSERT INTO FASE_ENSAMBLE_AVION (fln_fecha_inicio, fln_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id) 
VALUES 
-- Zona de ensamblaje 
('2024-01-01', NULL, 1, 13, 15, 6),
-- Zona de calibración 
('2024-02-01', NULL, 1, 13, 16, 6);

-- Guatire
INSERT INTO FASE_ENSAMBLE_AVION (fln_fecha_inicio, fln_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id) 
VALUES 
-- Zona de integración 
('2024-01-01', NULL, 1, 13, 19, 6),
-- Zona de soldadura 
('2024-02-01', NULL, 1, 13, 20, 6);

--Valencia
INSERT INTO FASE_ENSAMBLE_AVION (fln_fecha_inicio, fln_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id) 
VALUES 
-- Zona de porta equipajes 
('2024-01-01', NULL, 1, 13, 25, 6),
-- Zona de piezas sanitarias
('2024-02-01', NULL, 1, 13, 26, 6);

-- ==========================================================
-- Inserción de datos: FASE_ENSAMBLE_AVION  AU-87ABusiness
-- ==========================================================

-- Maracay
INSERT INTO FASE_ENSAMBLE_AVION (fln_fecha_inicio, fln_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id) 
VALUES 
-- Zona de alas
('2024-01-01', NULL, 1, 16, 1, 7),
-- Zona de estabilizadores
('2024-02-01', NULL, 1, 16, 2, 7),
-- Zona de alerones y flaps
('2024-03-01', NULL, 1, 16, 3, 7);

-- Colón
INSERT INTO FASE_ENSAMBLE_AVION (fln_fecha_inicio, fln_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id) 
VALUES 
-- Zona de trenes de aterrizaje
('2024-01-01', NULL, 1, 16, 9, 7),
-- Zona de fuselajes
('2024-02-01', NULL, 1, 16, 10, 7);

-- Guaira
INSERT INTO FASE_ENSAMBLE_AVION (fln_fecha_inicio, fln_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id) 
VALUES 
-- Zona de ensamblaje 
('2024-01-01', NULL, 1, 16, 15, 7),
-- Zona de calibración 
('2024-02-01', NULL, 1, 16, 16, 7);

-- Guatire
INSERT INTO FASE_ENSAMBLE_AVION (fln_fecha_inicio, fln_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id) 
VALUES 
-- Zona de integración 
('2024-01-01', NULL, 1, 16, 19, 7),
-- Zona de soldadura 
('2024-02-01', NULL, 1, 16, 20, 7);

--Valencia
INSERT INTO FASE_ENSAMBLE_AVION (fln_fecha_inicio, fln_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id) 
VALUES 
-- Zona de porta equipajes 
('2024-01-01', NULL, 1, 16, 25, 7),
-- Zona de piezas sanitarias
('2024-02-01', NULL, 1, 16, 26, 7);

-- ==========================================================
-- Inserción de datos: FASE_ENSAMBLE_AVION  AU-802E
-- ==========================================================

-- Maracay
INSERT INTO FASE_ENSAMBLE_AVION (fln_fecha_inicio, fln_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id) 
VALUES 
-- Zona de alas
('2024-01-01', NULL, 1, 10, 1, 8),
-- Zona de estabilizadores
('2024-02-01', NULL, 1, 10, 2, 8),
-- Zona de alerones y flaps
('2024-03-01', NULL, 1, 10, 3, 8);

-- Colón
INSERT INTO FASE_ENSAMBLE_AVION (fln_fecha_inicio, fln_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id) 
VALUES 
-- Zona de trenes de aterrizaje
('2024-01-01', NULL, 1, 10, 9, 8),
-- Zona de fuselajes
('2024-02-01', NULL, 1, 10, 10, 8);

-- Guaira
INSERT INTO FASE_ENSAMBLE_AVION (fln_fecha_inicio, fln_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id) 
VALUES 
-- Zona de ensamblaje 
('2024-01-01', NULL, 1, 10, 15, 8),
-- Zona de calibración 
('2024-02-01', NULL, 1, 10, 16, 8);

-- Guatire
INSERT INTO FASE_ENSAMBLE_AVION (fln_fecha_inicio, fln_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id) 
VALUES 
-- Zona de integración 
('2024-01-01', NULL, 1, 10, 19, 8),
-- Zona de soldadura 
('2024-02-01', NULL, 1, 10, 20, 8);

--Valencia
INSERT INTO FASE_ENSAMBLE_AVION (fln_fecha_inicio, fln_fecha_fin, fk_eav_id, fk_mda_id, fk_zon_id, fk_sct_id) 
VALUES 
-- Zona de porta equipajes 
('2024-01-01', NULL, 1, 10, 25, 8),
-- Zona de piezas sanitarias
('2024-02-01', NULL, 1, 10, 26, 8);

-- ===================================================================
-- Inserción de datos: ENSAMBLE_SOLICITUD_PIEZA (Clientes Naturales)
-- ===================================================================

-- Solicitudes para el modelo AU-80

-- Maracay (Zona de alas)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(2, 1, 1, 1, 1);  -- Ala Recta

-- Maracay (Zona de estabilizadores)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(3, 1, 1, 2, 6);   -- Forma Estándar

-- Maracay (Zona de alerones y flaps)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(4, 1, 1, 3, 12); -- Flaps

-- Colón (Zona de trenes de aterrizaje)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(3, 1, 1, 9, 17);  -- Tren Fijo

-- Colón (Zona de fuselajes)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(1, 1, 1, 10, 16);-- Fuselaje

-- La Guaira (Zona de ensamblaje y calibración)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(4, 1, 1, 15, 19); -- Motor

-- Guatire (Zona de integración y soldadura)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(3, 1, 1, 19, 20);-- Anemómetro

-- Valencia (Zona de porta equipajes y piezas sanitarias)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(30, 1, 1, 25, 39),-- Porta Equipajes
(3, 1, 1, 26, 42);-- Piezas Sanitarias

-- Solicitudes ajustadas para el modelo AU-801

-- Maracay (Zona de alas)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(2, 1, 2, 1, 2);  -- Ala Trapezoidal

-- Maracay (Zona de estabilizadores)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(4, 1, 2, 2, 8);   -- Forma en Cruz

-- Maracay (Zona de alerones y flaps)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(4, 1, 2, 3, 12); -- Flaps

-- Colón (Zona de trenes de aterrizaje)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(3, 1, 2, 9, 18);  -- Tren Retráctil

-- Colón (Zona de fuselajes)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(1, 1, 2, 10, 16);-- Fuselaje

-- La Guaira (Zona de ensamblaje y calibración)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(3, 1, 2, 15, 19); -- Motor

-- Guatire (Zona de integración y soldadura)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(1, 1, 2, 19, 20);-- Anemómetro

-- Valencia (Zona de porta equipajes y piezas sanitarias)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(30, 1, 2, 25, 39),-- Porta Equipajes
(3, 1, 2, 26, 42);-- Piezas Sanitarias

-- Solicitudes para el modelo AU-802A 

-- Maracay (Zona de alas)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(2, 1, 6, 1, 1);  -- Ala Recta

-- Maracay (Zona de estabilizadores)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(2, 1, 6, 2, 6);   -- Forma Estándar

-- Maracay (Zona de alerones y flaps)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(4, 1, 6, 3, 12); -- Flaps

-- Colón (Zona de trenes de aterrizaje)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(3, 1, 6, 9, 18);  -- Tren Retráctil

-- Colón (Zona de fuselajes)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(1, 1, 6, 10, 16);-- Fuselaje

-- La Guaira (Zona de ensamblaje y calibración)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(2, 1, 6, 15, 19); -- Motor

-- Guatire (Zona de integración y soldadura)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(5, 1, 6, 19, 20);-- Anemómetro

-- Valencia (Zona de porta equipajes y piezas sanitarias)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(10, 1, 6, 25, 39),-- Porta Equipajes
(3, 1, 6, 26, 42);-- Piezas Sanitarias

-- Solicitudes para el modelo AU-747PLUS 

-- Maracay (Zona de alas)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(2, 1, 4, 1, 2);  -- Ala Trapezoidal

-- Maracay (Zona de estabilizadores)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(2, 1, 4, 2, 8);   -- Forma en Cruz

-- Maracay (Zona de alerones y flaps)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(4, 1, 4, 3, 12); -- Flaps

-- Colón (Zona de trenes de aterrizaje)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(3, 1, 4, 9, 17);  -- Tren Fijo

-- Colón (Zona de fuselajes)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(1, 1, 4, 10, 16);-- Fuselaje

-- La Guaira (Zona de ensamblaje y calibración)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(2, 1, 4, 15, 19); -- Motor

-- Guatire (Zona de integración y soldadura)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(5, 1, 4, 19, 20);-- Anemómetro

-- Valencia (Zona de porta equipajes y piezas sanitarias)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(10, 1, 4, 25, 39),-- Porta Equipajes
(3, 1, 4, 26, 42);-- Piezas Sanitarias

-- ===================================================================
-- Inserción de datos: ENSAMBLE_SOLICITUD_PIEZA (Clientes Jurídicos)
-- ===================================================================
-- Solicitudes para el modelo AU-802F

-- Maracay (Zona de alas)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(2, 1, 11, 1, 4);  -- Ala en Flecha

-- Maracay (Zona de estabilizadores)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(2, 1, 11, 2, 10); -- Forma 3 Verticales

-- Maracay (Zona de alerones y flaps)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(4, 1, 11, 3, 12); -- Flaps

-- Colón (Zona de trenes de aterrizaje)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(3, 1, 11, 9, 18);  -- Tren Retráctil

-- Colón (Zona de fuselajes)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(1, 1, 11, 10, 16);-- Fuselaje

-- La Guaira (Zona de ensamblaje y calibración)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(2, 1, 11, 15, 19); -- Motor

-- Guatire (Zona de integración y soldadura)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(5, 1, 11, 19, 20);-- Anemómetro

-- Valencia (Zona de porta equipajes y piezas sanitarias)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(10, 1, 11, 25, 39),-- Porta Equipajes
(3, 1, 11, 26, 42);-- Piezas Sanitarias

-- Solicitudes para el modelo AU-747Gold

-- Maracay (Zona de alas)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(2, 1, 13, 1, 3);  -- Ala Delta

-- Maracay (Zona de estabilizadores)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(2, 1, 13, 2, 11); -- Forma en V

-- Maracay (Zona de alerones y flaps)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(4, 1, 13, 3, 12); -- Flaps

-- Colón (Zona de trenes de aterrizaje)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(3, 1, 13, 9, 17);  -- Tren Fijo

-- Colón (Zona de fuselajes)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(1, 1, 13, 10, 16);-- Fuselaje

-- La Guaira (Zona de ensamblaje y calibración)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(2, 1, 13, 15, 19); -- Motor

-- Guatire (Zona de integración y soldadura)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(5, 1, 13, 19, 20);-- Anemómetro

-- Valencia (Zona de porta equipajes y piezas sanitarias)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(10, 1, 13, 25, 39),-- Porta Equipajes
(3, 1, 13, 26, 42);-- Piezas Sanitarias

-- Solicitudes para el modelo AU-87ABusiness

-- Maracay (Zona de alas)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(2, 1, 16, 1, 5);  -- Ala en Flecha Inversa

-- Maracay (Zona de estabilizadores)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(2, 1, 16, 2, 7);  -- Forma en T

-- Maracay (Zona de alerones y flaps)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(4, 1, 16, 3, 12); -- Flaps

-- Colón (Zona de trenes de aterrizaje)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(3, 1, 16, 9, 17);  -- Tren Fijo

-- Colón (Zona de fuselajes)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(1, 1, 16, 10, 16);-- Fuselaje

-- La Guaira (Zona de ensamblaje y calibración)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(2, 1, 16, 15, 19); -- Motor

-- Guatire (Zona de integración y soldadura)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(5, 1, 16, 19, 20);-- Anemómetro

-- Valencia (Zona de porta equipajes y piezas sanitarias)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(10, 1, 16, 25, 39),-- Porta Equipajes
(3, 1, 16, 26, 42);-- Piezas Sanitarias

-- Solicitudes para el modelo AU-802E

-- Maracay (Zona de alas)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(2, 1, 10, 1, 2);  -- Ala Trapezoidal

-- Maracay (Zona de estabilizadores)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(2, 1, 10, 2, 6);  -- Forma Estándar

-- Maracay (Zona de alerones y flaps)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(4, 1, 10, 3, 12); -- Flaps

-- Colón (Zona de trenes de aterrizaje)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(3, 1, 10, 9, 17);  -- Tren Fijo

-- Colón (Zona de fuselajes)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(1, 1, 10, 10, 16);-- Fuselaje

-- La Guaira (Zona de ensamblaje y calibración)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(2, 1, 10, 15, 19); -- Motor

-- Guatire (Zona de integración y soldadura)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(5, 1, 10, 19, 20);-- Anemómetro

-- Valencia (Zona de porta equipajes y piezas sanitarias)
INSERT INTO ENSAMBLE_SOLICITUD_PIEZA (edz_cantidad_piezas, fk_eav_id, fk_mda_id, fk_zon_id, fk_pie_id)
VALUES 
(10, 1, 10, 25, 39),-- Porta Equipajes
(3, 1, 10, 26, 42);-- Piezas Sanitarias

-- ======================================


