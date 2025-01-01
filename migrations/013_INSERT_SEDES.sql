-- =====================================
-- Inserción de datos: SEDES
-- ======================================

INSERT INTO SEDE_PLANTA (sed_nombre, sed_direccion, sed_descripcion, fk_lug_id)
VALUES ('Maracay', 'Maracay', 'Ensamble de alas, pruebas de calidad y producción de estabilizadores.', 4);

INSERT INTO SEDE_PLANTA (sed_nombre, sed_direccion, sed_descripcion, fk_lug_id)
VALUES ('Colón', 'Colón', 'Producción de fuselajes, trenes de aterrizaje y soporte logístico.', 24);

INSERT INTO SEDE_PLANTA (sed_nombre, sed_direccion, sed_descripcion, fk_lug_id)
VALUES ('La Guaira', 'La Guaira', 'Pruebas exhaustivas de materiales y fabricación de motores.', 14);

INSERT INTO SEDE_PLANTA (sed_nombre, sed_direccion, sed_descripcion, fk_lug_id)
VALUES ('Guatire', 'Guatire', 'Producción de instrumentos de control y sistemas electrónicos.', 16);

INSERT INTO SEDE_PLANTA (sed_nombre, sed_direccion, sed_descripcion, fk_lug_id)
VALUES ('Valencia', 'Valencia', 'Fabricación de interiores de cabina, asientos y ventanillas.', 7);


-- =====================================
-- Inserción de datos: Areas
-- ======================================

-- Áreas para la sede Maracay
INSERT INTO AREA (are_nombre, are_descripcion, fk_sed_id)
VALUES ('Ensamble', 'Área para ensamblar alas, estabilizadores y alerones.', 1);

INSERT INTO AREA (are_nombre, are_descripcion, fk_sed_id)
VALUES ('Pruebas de calidad', 'Verificación de materiales y piezas ensambladas.', 1);

INSERT INTO AREA (are_nombre, are_descripcion, fk_sed_id)
VALUES ('Despacho', 'Zona destinada al embalaje y envío de componentes.', 1);

-- Áreas para la sede Colón
INSERT INTO AREA (are_nombre, are_descripcion, fk_sed_id)
VALUES ('Diseño estructural', 'Elaboración de planos y simulaciones de fuselajes.', 2);

INSERT INTO AREA (are_nombre, are_descripcion, fk_sed_id)
VALUES ('Producción', 'Construcción de fuselajes y trenes de aterrizaje.', 2);

INSERT INTO AREA (are_nombre, are_descripcion, fk_sed_id)
VALUES ('Pruebas de resistencia', 'Evaluación de la calidad estructural y resistencia.', 2);

-- Áreas para la sede La Guaira
INSERT INTO AREA (are_nombre, are_descripcion, fk_sed_id)
VALUES ('Recepción de materiales', 'Almacenamiento e inspección de materiales.', 3);

INSERT INTO AREA (are_nombre, are_descripcion, fk_sed_id)
VALUES ('Pruebas de calidad', 'Evaluación térmica y mecánica de materiales.', 3);

INSERT INTO AREA (are_nombre, are_descripcion, fk_sed_id)
VALUES ('Producción de motores', 'Ensamble y calibración de sistemas motopropulsores.', 3);

-- Áreas para la sede Guatire
INSERT INTO AREA (are_nombre, are_descripcion, fk_sed_id)
VALUES ('Diseño electrónico', 'Desarrollo de sistemas electrónicos y software.', 4);

INSERT INTO AREA (are_nombre, are_descripcion, fk_sed_id)
VALUES ('Ensamble', 'Integración y montaje de instrumentos de control.', 4);

INSERT INTO AREA (are_nombre, are_descripcion, fk_sed_id)
VALUES ('Pruebas funcionales', 'Simulación y calibración de instrumentos.', 4);

-- Áreas para la sede Valencia
INSERT INTO AREA (are_nombre, are_descripcion, fk_sed_id)
VALUES ('Diseño de interiores', 'Diseño de asientos, ventanillas y alfombrados.', 5);

INSERT INTO AREA (are_nombre, are_descripcion, fk_sed_id)
VALUES ('Producción', 'Fabricación de porta equipajes y piezas sanitarias.', 5);

INSERT INTO AREA (are_nombre, are_descripcion, fk_sed_id)
VALUES ('Acabado y personalización', 'Pintura y montaje final de los interiores.', 5);

-- =====================================
-- Inserción de datos: Zonas
-- ======================================

-- Zonas para el área "Ensamble" en Maracay
INSERT INTO ZONA (zon_nombre, zon_descripcion, fk_are_id)
VALUES ('Zona de alas', 'Ensamblaje y ajuste de alas.', 1);

INSERT INTO ZONA (zon_nombre, zon_descripcion, fk_are_id)
VALUES ('Zona de estabilizadores', 'Ensamblaje de estabilizadores horizontales y verticales.', 1);

INSERT INTO ZONA (zon_nombre, zon_descripcion, fk_are_id)
VALUES ('Zona de alerones y flaps', 'Producción y montaje de alerones y flaps.', 1);

-- Zonas para el área "Pruebas de calidad" en Maracay
INSERT INTO ZONA (zon_nombre, zon_descripcion, fk_are_id)
VALUES ('Zona de recepción de materiales', 'Verificación de calidad tras el traslado.', 2);

INSERT INTO ZONA (zon_nombre, zon_descripcion, fk_are_id)
VALUES ('Zona de pruebas aerodinámicas', 'Evaluación del rendimiento de piezas ensambladas.', 2);

-- Zonas para el área "Despacho" en Maracay
INSERT INTO ZONA (zon_nombre, zon_descripcion, fk_are_id)
VALUES ('Zona de embalaje', 'Preparación de componentes para envío.', 3);

INSERT INTO ZONA (zon_nombre, zon_descripcion, fk_are_id)
VALUES ('Zona de envío', 'Despacho de componentes a otras plantas.', 3);

-- Zonas para el área "Diseño estructural" en Colón
INSERT INTO ZONA (zon_nombre, zon_descripcion, fk_are_id)
VALUES ('Zona de planos de fuselaje', 'Creación de planos y diseños estructurales.', 4);

INSERT INTO ZONA (zon_nombre, zon_descripcion, fk_are_id)
VALUES ('Zona de simulaciones', 'Pruebas virtuales de resistencia estructural.', 4);

-- Zonas para el área "Producción" en Colón
INSERT INTO ZONA (zon_nombre, zon_descripcion, fk_are_id)
VALUES ('Zona de trenes de aterrizaje', 'Producción y ensamblaje de trenes de aterrizaje.', 5);

INSERT INTO ZONA (zon_nombre, zon_descripcion, fk_are_id)
VALUES ('Zona de fuselajes', 'Producción de fuselajes completos.', 5);

-- Zonas para el área "Pruebas de resistencia" en Colón
INSERT INTO ZONA (zon_nombre, zon_descripcion, fk_are_id)
VALUES ('Zona de carga estructural', 'Pruebas de carga máxima de fuselajes.', 6);

INSERT INTO ZONA (zon_nombre, zon_descripcion, fk_are_id)
VALUES ('Zona de impacto', 'Simulación de impactos para evaluar la resistencia.', 6);

-- Zonas para el área "Recepción de materiales" en La Guaira
INSERT INTO ZONA (zon_nombre, zon_descripcion, fk_are_id)
VALUES ('Zona de almacenamiento temporal', 'Almacenamiento de materiales a corto plazo.', 7);

INSERT INTO ZONA (zon_nombre, zon_descripcion, fk_are_id)
VALUES ('Zona de inspección inicial', 'Inspección preliminar de materiales recibidos.', 7);

-- Zonas para el área "Pruebas de calidad" en La Guaira
INSERT INTO ZONA (zon_nombre, zon_descripcion, fk_are_id)
VALUES ('Zona de pruebas térmicas', 'Evaluación térmica de materiales y componentes.', 8);

INSERT INTO ZONA (zon_nombre, zon_descripcion, fk_are_id)
VALUES ('Zona de pruebas mecánicas', 'Pruebas de resistencia mecánica de materiales.', 8);

-- Zonas para el área "Producción de motores" en La Guaira
INSERT INTO ZONA (zon_nombre, zon_descripcion, fk_are_id)
VALUES ('Zona de ensamblaje', 'Montaje de motores y sistemas motopropulsores.', 9);

INSERT INTO ZONA (zon_nombre, zon_descripcion, fk_are_id)
VALUES ('Zona de calibración', 'Ajuste y verificación de sistemas motopropulsores.', 9);

-- Zonas para el área "Diseño electrónico" en Guatire
INSERT INTO ZONA (zon_nombre, zon_descripcion, fk_are_id)
VALUES ('Zona de desarrollo de software', 'Diseño y desarrollo de sistemas electrónicos.', 10);

INSERT INTO ZONA (zon_nombre, zon_descripcion, fk_are_id)
VALUES ('Zona de circuitos electrónicos', 'Producción y diseño de circuitos electrónicos.', 10);

-- Zonas para el área "Ensamble" en Guatire
INSERT INTO ZONA (zon_nombre, zon_descripcion, fk_are_id)
VALUES ('Zona de integración', 'Montaje de instrumentos de control.', 11);

INSERT INTO ZONA (zon_nombre, zon_descripcion, fk_are_id)
VALUES ('Zona de soldadura', 'Soldadura y ensamblaje de componentes electrónicos.', 11);

-- Zonas para el área "Pruebas funcionales" en Guatire
INSERT INTO ZONA (zon_nombre, zon_descripcion, fk_are_id)
VALUES ('Zona de simulación de vuelo', 'Pruebas de instrumentos en entornos simulados.', 12);

INSERT INTO ZONA (zon_nombre, zon_descripcion, fk_are_id)
VALUES ('Zona de calibración', 'Ajuste de precisión en instrumentos electrónicos.', 12);

-- Zonas para el área "Diseño de interiores" en Valencia
INSERT INTO ZONA (zon_nombre, zon_descripcion, fk_are_id)
VALUES ('Zona de asientos', 'Diseño y producción de asientos de cabina.', 13);

INSERT INTO ZONA (zon_nombre, zon_descripcion, fk_are_id)
VALUES ('Zona de ventanillas y alfombrados', 'Producción de ventanillas y alfombrados.', 13);

-- Zonas para el área "Producción" en Valencia
INSERT INTO ZONA (zon_nombre, zon_descripcion, fk_are_id)
VALUES ('Zona de porta equipajes', 'Fabricación de compartimentos de equipaje.', 14);

INSERT INTO ZONA (zon_nombre, zon_descripcion, fk_are_id)
VALUES ('Zona de piezas sanitarias', 'Producción de piezas sanitarias para cabinas.', 14);

-- Zonas para el área "Acabado y personalización" en Valencia
INSERT INTO ZONA (zon_nombre, zon_descripcion, fk_are_id)
VALUES ('Zona de pintura', 'Aplicación de pintura y personalización de piezas.', 15);

INSERT INTO ZONA (zon_nombre, zon_descripcion, fk_are_id)
VALUES ('Zona de montaje final', 'Montaje y ensamblaje final de los interiores.', 15);

