--  CONFIGURACIÓN PRUEBAS

-- =====================================
-- Inserción de datos: PRUEBA_CONF
-- ======================================
INSERT INTO PRUEBA_CONF (prc_nombre_prueba, prc_tiempo_estimado)
VALUES
-- Pruebas para Modelos de Ala
('Prueba de resistencia de Ala Recta', '2 hours'),
('Prueba de aerodinámica de Ala Recta', '3 hours'),
('Prueba de resistencia de Ala Trapezoidal', '2 hours'),
('Prueba de aerodinámica de Ala Trapezoidal', '3 hours'),
('Prueba de resistencia de Ala Delta', '2 hours'),
('Prueba de aerodinámica de Ala Delta', '3 hours'),
('Prueba de resistencia de Ala en Flecha', '2 hours'),
('Prueba de aerodinámica de Ala en Flecha', '3 hours'),
('Prueba de resistencia de Ala en Flecha Inversa', '2 hours'),
('Prueba de aerodinámica de Ala en Flecha Inversa', '3 hours'),

-- Pruebas para Modelos de Estabilizadores
('Prueba de resistencia de Forma Estándar', '2 hours'),
('Prueba de aerodinámica de Forma Estándar', '3 hours'),
('Prueba de resistencia de Forma en T', '2 hours'),
('Prueba de aerodinámica de Forma en T', '3 hours'),
('Prueba de resistencia de Forma en Cruz', '2 hours'),
('Prueba de aerodinámica de Forma en Cruz', '3 hours'),
('Prueba de resistencia de Forma 2 Verticales', '2 hours'),
('Prueba de aerodinámica de Forma 2 Verticales', '3 hours'),
('Prueba de resistencia de Forma 3 Verticales', '2 hours'),
('Prueba de aerodinámica de Forma 3 Verticales', '3 hours'),
('Prueba de resistencia de Forma en V', '2 hours'),
('Prueba de aerodinámica de Forma en V', '3 hours'),

-- Pruebas para Modelos de Tren de Aterrizaje
('Prueba de resistencia de Tren Fijo', '2 hours'),
('Prueba de funcionamiento de Tren Retráctil', '3 hours'),

-- Pruebas para Modelos de Sistemas de Control
('Prueba de precisión de Anemómetro', '2 hours'),
('Prueba de precisión de Altímetro', '2 hours'),
('Prueba de precisión de Variómetro', '2 hours'),
('Prueba de precisión de Inclinómetro', '2 hours'),
('Prueba de precisión de Horizonte Artificial', '2 hours'),
('Prueba de precisión de Brújula', '2 hours'),
('Prueba de precisión de Indicador de Rumbos', '2 hours'),
('Prueba de precisión de ADF', '2 hours'),
('Prueba de precisión de DME', '2 hours'),
('Prueba de precisión de CDI', '2 hours'),
('Prueba de precisión de ILS', '2 hours'),
('Prueba de funcionamiento de Piloto Automático', '4 hours'),
('Prueba de precisión del Sistema de Gestión de Vuelo', '3 hours'),
('Prueba de precisión del Manómetro', '2 hours'),
('Prueba de precisión del Termómetro de Aceite', '2 hours'),
('Prueba de precisión del Caudal de Combustible', '2 hours'),
('Prueba de precisión de Temperatura de Culatas', '2 hours'),
('Prueba de precisión del Nivel de Combustible', '2 hours'),

-- Pruebas para Tipos de Elementos Internos
('Prueba de comodidad de Asientos', '2 hours'),
('Prueba de capacidad de Porta Equipajes', '2 hours'),
('Prueba de resistencia de Alfombrado', '2 hours'),
('Prueba de funcionamiento de Piezas Sanitarias', '2 hours'),
('Prueba de visibilidad de Ventanillas', '2 hours'),
('Prueba de durabilidad de Cortinas', '2 hours'),

-- Pruebas para Modelos de Avión
('Prueba de vuelo de AU-80', '5 hours'),
('Prueba de carga de AU-80', '4 hours'),
('Prueba de vuelo de AU-801', '5 hours'),
('Prueba de carga de AU-801', '4 hours'),
('Prueba de vuelo de AU-802', '5 hours'),
('Prueba de carga de AU-802', '4 hours'),
('Prueba de vuelo de AU-747Plus', '6 hours'),
('Prueba de carga de AU-747Plus', '5 hours'),
('Prueba de vuelo de AU-87A', '6 hours'),
('Prueba de carga de AU-87A', '5 hours'),
('Prueba de vuelo de AU-802A', '5 hours'),
('Prueba de carga de AU-802A', '4 hours'),
('Prueba de vuelo de AU-802B', '5 hours'),
('Prueba de carga de AU-802B', '4 hours'),
('Prueba de vuelo de AU-802C', '5 hours'),
('Prueba de carga de AU-802C', '4 hours'),
('Prueba de vuelo de AU-802D', '5 hours'),
('Prueba de carga de AU-802D', '4 hours'),
('Prueba de vuelo de AU-802E', '5 hours'),
('Prueba de carga de AU-802E', '4 hours'),
('Prueba de vuelo de AU-802F', '5 hours'),
('Prueba de carga de AU-802F', '4 hours'),
('Prueba de vuelo de AU-747Platinium', '6 hours'),
('Prueba de carga de AU-747Platinium', '5 hours'),
('Prueba de vuelo de AU-747Gold', '6 hours'),
('Prueba de carga de AU-747Gold', '5 hours'),
('Prueba de vuelo de AU-747Silver', '6 hours'),
('Prueba de carga de AU-747Silver', '5 hours'),
('Prueba de vuelo de AU-747SilverB', '6 hours'),
('Prueba de carga de AU-747SilverB', '5 hours'),
('Prueba de vuelo de AU-87ABusiness', '6 hours'),
('Prueba de carga de AU-87ABusiness', '5 hours');


-- =====================================
-- Inserción de datos: MODELO_PRUEBA
-- ======================================
INSERT INTO MODELO_PRUEBA (fk_prc_id, fk_mec_id)
VALUES
-- Relaciones para Modelos de Alas
(1, 1), -- Prueba de resistencia de Ala Recta
(2, 1), -- Prueba de aerodinámica de Ala Recta
(3, 2), -- Prueba de resistencia de Ala Trapezoidal
(4, 2), -- Prueba de aerodinámica de Ala Trapezoidal
(5, 3), -- Prueba de resistencia de Ala Delta
(6, 3), -- Prueba de aerodinámica de Ala Delta
(7, 4), -- Prueba de resistencia de Ala en Flecha
(8, 4), -- Prueba de aerodinámica de Ala en Flecha
(9, 5), -- Prueba de resistencia de Ala en Flecha Inversa
(10, 5), -- Prueba de aerodinámica de Ala en Flecha Inversa

-- Relaciones para Modelos de Estabilizadores
(11, 6), -- Prueba de resistencia de Forma Estándar
(12, 6), -- Prueba de aerodinámica de Forma Estándar
(13, 7), -- Prueba de resistencia de Forma en T
(14, 7), -- Prueba de aerodinámica de Forma en T
(15, 8), -- Prueba de resistencia de Forma en Cruz
(16, 8), -- Prueba de aerodinámica de Forma en Cruz
(17, 9), -- Prueba de resistencia de Forma 2 Verticales
(18, 9), -- Prueba de aerodinámica de Forma 2 Verticales
(19, 10), -- Prueba de resistencia de Forma 3 Verticales
(20, 10), -- Prueba de aerodinámica de Forma 3 Verticales
(21, 11), -- Prueba de resistencia de Forma en V
(22, 11), -- Prueba de aerodinámica de Forma en V

-- Relaciones para Modelos de Tren de Aterrizaje
(23, 12), -- Prueba de resistencia de Tren Fijo
(24, 13), -- Prueba de funcionamiento de Tren Retráctil

-- Relaciones para Modelos de Sistemas de Control
(25, 14), -- Prueba de precisión de Anemómetro
(26, 15), -- Prueba de precisión de Altímetro
(27, 16), -- Prueba de precisión de Variómetro
(28, 17), -- Prueba de precisión de Inclinómetro
(29, 18), -- Prueba de precisión de Horizonte Artificial
(30, 19), -- Prueba de precisión de Brújula
(31, 20), -- Prueba de precisión de Indicador de Rumbos
(32, 21), -- Prueba de precisión de ADF
(33, 22), -- Prueba de precisión de DME
(34, 23), -- Prueba de precisión de CDI
(35, 24), -- Prueba de precisión de ILS
(36, 25), -- Prueba de funcionamiento de Piloto Automático
(37, 26), -- Prueba de precisión del Sistema de Gestión de Vuelo
(38, 27), -- Prueba de precisión del Manómetro
(39, 28), -- Prueba de precisión del Termómetro de Aceite
(40, 29), -- Prueba de precisión del Caudal de Combustible
(41, 30), -- Prueba de precisión de Temperatura de Culatas
(42, 31), -- Prueba de precisión del Nivel de Combustible

-- Relaciones para Tipos de Elementos Internos
(43, 32), -- Prueba de comodidad de Asientos
(44, 33), -- Prueba de capacidad de Porta Equipajes
(45, 34), -- Prueba de resistencia de Alfombrado
(46, 35), -- Prueba de funcionamiento de Piezas Sanitarias
(47, 36), -- Prueba de visibilidad de Ventanillas
(48, 37); -- Prueba de durabilidad de Cortinas


-- =====================================
-- Inserción de datos: FASE_PRUEBA
-- ======================================
INSERT INTO FASE_PRUEBA (fk_mda_id, fk_prc_id)
VALUES
(1, 49), -- Prueba de vuelo de AU-80
(1, 50), -- Prueba de carga de AU-80
(2, 51), -- Prueba de vuelo de AU-801
(2, 52), -- Prueba de carga de AU-801
(3, 53), -- Prueba de vuelo de AU-802
(3, 54), -- Prueba de carga de AU-802
(4, 55), -- Prueba de vuelo de AU-747Plus
(4, 56), -- Prueba de carga de AU-747Plus
(5, 57), -- Prueba de vuelo de AU-87A
(5, 58), -- Prueba de carga de AU-87A
(6, 59), -- Prueba de vuelo de AU-802A
(6, 60), -- Prueba de carga de AU-802A
(7, 61), -- Prueba de vuelo de AU-802B
(7, 62), -- Prueba de carga de AU-802B
(8, 63), -- Prueba de vuelo de AU-802C
(8, 64), -- Prueba de carga de AU-802C
(9, 65), -- Prueba de vuelo de AU-802D
(9, 66), -- Prueba de carga de AU-802D
(10, 67), -- Prueba de vuelo de AU-802E
(10, 68), -- Prueba de carga de AU-802E
(11, 69), -- Prueba de vuelo de AU-802F
(11, 70), -- Prueba de carga de AU-802F
(12, 71), -- Prueba de vuelo de AU-747Platinium
(12, 72), -- Prueba de carga de AU-747Platinium
(13, 73), -- Prueba de vuelo de AU-747Gold
(13, 74), -- Prueba de carga de AU-747Gold
(14, 75), -- Prueba de vuelo de AU-747Silver
(14, 76), -- Prueba de carga de AU-747Silver
(15, 77), -- Prueba de vuelo de AU-747SilverB
(15, 78), -- Prueba de carga de AU-747SilverB
(16, 79), -- Prueba de vuelo de AU-87ABusiness
(16, 80); -- Prueba de carga de AU-87ABusiness

--  EJECUCIÓN PRUEBAS
-- =====================================
-- Inserción de datos: PRUEBA
-- ======================================
INSERT INTO PRUEBA (pru_nombre, pru_tiempo_estimado, pru_descripcion)
VALUES 
-- Pruebas para Modelos de Ala
('Prueba de resistencia de Ala Recta', '2 hours', 'Evaluación de la resistencia estructural de alas rectas.'),
('Prueba de aerodinámica de Ala Recta', '3 hours', 'Pruebas aerodinámicas en túneles de viento.'),
('Prueba de resistencia de Ala Trapezoidal', '2 hours', 'Medición de la resistencia de alas trapezoidales.'),
('Prueba de aerodinámica de Ala Trapezoidal', '3 hours', 'Evaluación del rendimiento aerodinámico de alas trapezoidales.'),
('Prueba de resistencia de Ala Delta', '2 hours', 'Pruebas de resistencia estructural en alas delta.'),
('Prueba de aerodinámica de Ala Delta', '3 hours', 'Simulación de flujo aerodinámico sobre alas delta.'),
('Prueba de resistencia de Ala en Flecha', '2 hours', 'Análisis de resistencia en alas con diseño en flecha.'),
('Prueba de aerodinámica de Ala en Flecha', '3 hours', 'Pruebas aerodinámicas avanzadas en alas en flecha.'),
('Prueba de resistencia de Ala en Flecha Inversa', '2 hours', 'Pruebas estructurales en alas de flecha inversa.'),
('Prueba de aerodinámica de Ala en Flecha Inversa', '3 hours', 'Evaluación aerodinámica de alas con flecha inversa.'),

-- Pruebas para Modelos de Estabilizadores
('Prueba de resistencia de Forma Estándar', '2 hours', 'Pruebas de resistencia en estabilizadores estándar.'),
('Prueba de aerodinámica de Forma Estándar', '3 hours', 'Evaluación del flujo de aire sobre estabilizadores estándar.'),
('Prueba de resistencia de Forma en T', '2 hours', 'Pruebas de resistencia en estabilizadores en forma de T.'),
('Prueba de aerodinámica de Forma en T', '3 hours', 'Simulación de flujo aerodinámico en estabilizadores en T.'),
('Prueba de resistencia de Forma en Cruz', '2 hours', 'Pruebas de resistencia en estabilizadores en forma de cruz.'),
('Prueba de aerodinámica de Forma en Cruz', '3 hours', 'Evaluación del rendimiento aerodinámico de estabilizadores en cruz.'),
('Prueba de resistencia de Forma 2 Verticales', '2 hours', 'Pruebas de resistencia en configuraciones con 2 estabilizadores verticales.'),
('Prueba de aerodinámica de Forma 2 Verticales', '3 hours', 'Evaluación aerodinámica de configuraciones con 2 verticales.'),
('Prueba de resistencia de Forma 3 Verticales', '2 hours', 'Pruebas de resistencia en configuraciones con 3 estabilizadores verticales.'),
('Prueba de aerodinámica de Forma 3 Verticales', '3 hours', 'Evaluación aerodinámica de estabilizadores en 3 verticales.'),
('Prueba de resistencia de Forma en V', '2 hours', 'Pruebas estructurales en estabilizadores en forma de V.'),
('Prueba de aerodinámica de Forma en V', '3 hours', 'Evaluación aerodinámica en estabilizadores en forma de V.'),

-- Pruebas para Modelos de Tren de Aterrizaje
('Prueba de resistencia de Tren Fijo', '2 hours', 'Pruebas de resistencia estructural de trenes de aterrizaje fijos.'),
('Prueba de funcionamiento de Tren Retráctil', '3 hours', 'Evaluación del mecanismo de retracción y extensión.'),

-- Pruebas para Modelos de Sistemas de Control
('Prueba de precisión de Anemómetro', '2 hours', 'Validación de precisión en mediciones de velocidad del aire.'),
('Prueba de precisión de Altímetro', '2 hours', 'Validación de precisión en altímetros.'),
('Prueba de precisión de Variómetro', '2 hours', 'Pruebas de precisión en indicación de velocidad vertical.'),
('Prueba de precisión de Inclinómetro', '2 hours', 'Validación de inclinómetros para ángulos de inclinación.'),
('Prueba de precisión de Horizonte Artificial', '2 hours', 'Validación de precisión en horizontes artificiales.'),
('Prueba de precisión de Brújula', '2 hours', 'Pruebas de precisión en brújulas magnéticas.'),
('Prueba de precisión de Indicador de Rumbos', '2 hours', 'Validación de precisión en indicadores de rumbo.'),
('Prueba de precisión de ADF', '2 hours', 'Pruebas de precisión en equipos ADF.'),
('Prueba de precisión de DME', '2 hours', 'Validación de medición de distancia en sistemas DME.'),
('Prueba de precisión de CDI', '2 hours', 'Validación de precisión en desviación de curso.'),
('Prueba de precisión de ILS', '2 hours', 'Pruebas de precisión en sistemas ILS.'),
('Prueba de funcionamiento de Piloto Automático', '4 hours', 'Evaluación del funcionamiento de pilotos automáticos.'),
('Prueba de Sistema de Gestión de Vuelo', '9 hours', 'Pruebas de precisión del Sistema de Gestión de Vuelo.'),
('Prueba de Manómetro', '2 hours', 'Validación de precisión del Manómetro.'),
('Prueba de Termómetro de Aceite', '2 hours', 'Validación de precisión del Termómetro de Aceite.'),
('Prueba de Caudal de Combustible', '2 hours', 'Pruebas del medidor de gasto de combustible.'),
('Prueba de Temperatura de Culatas', '2 hours', 'Validación de precisión'),
('Prueba de Nivel de Combustible', '2 hours', 'Pruebas de precisión en el medidor de combustible'),

-- Pruebas para Tipos de Elementos Internos
('Prueba de comodidad de Asientos', '2 hours', 'Evaluación de la ergonomía y comodidad de los asientos.'),
('Prueba de capacidad de Porta Equipajes', '2 hours', 'Validación de la capacidad máxima de carga en porta equipajes.'),
('Prueba de resistencia de Alfombrado', '2 hours', 'Pruebas de resistencia al desgaste y carga en alfombrados.'),
('Prueba de funcionamiento de Piezas Sanitarias', '2 hours', 'Verificación del correcto funcionamiento de las piezas sanitarias.'),
('Prueba de visibilidad de Ventanillas', '2 hours', 'Evaluación de la claridad y resistencia de las ventanillas.'),
('Prueba de durabilidad de Cortinas', '2 hours', 'Validación de la durabilidad y resistencia de las cortinas.'),

-- Pruebas para Motores
('Prueba de potencia de Motor', '3 hours', 'Validación de la potencia generada por el motor en diferentes condiciones.'),
('Prueba de eficiencia de Motor', '4 hours', 'Evaluación de la eficiencia del motor en consumo de combustible.'),
('Prueba de resistencia de Motor', '5 hours', 'Pruebas de resistencia y durabilidad del motor en condiciones extremas.'),
('Prueba de seguridad de Motor', '3 hours', 'Verificación de los sistemas de seguridad y fallas del motor.'),

-- Pruebas para Flaps, Slats, Spoilers, Superficie de sustentación
('Prueba de resistencia de Flaps', '2 hours', 'Evaluación de resistencia de los flaps en diferentes configuraciones.'),
('Prueba de resistencia de Slats', '2 hours', 'Evaluación estructural de los slats en condiciones de vuelo.'),
('Prueba de funcionamiento de Spoilers', '3 hours', 'Validación de la operatividad de los spoilers en vuelo.'),
('Prueba de durabilidad de Superficie de Sustentación', '4 hours', 'Validación de durabilidad en condiciones extremas.'),

-- Pruebas para Fuselaje
('Prueba de Fuselaje', '9 hours', 'Evaluación del fuselaje'),

-- Pruebas para Modelos de Avión
('Prueba de vuelo de AU-80', '5 hours', 'Pruebas de vuelo completas para el modelo AU-80.'),
('Prueba de carga de AU-80', '4 hours', 'Evaluación de la capacidad de carga del modelo AU-80.'),
('Prueba de vuelo de AU-801', '5 hours', 'Pruebas de vuelo completas para el modelo AU-801.'),
('Prueba de carga de AU-801', '4 hours', 'Evaluación de la capacidad de carga del modelo AU-801.'),
('Prueba de vuelo de AU-802', '5 hours', 'Pruebas de vuelo completas para el modelo AU-802.'),
('Prueba de carga de AU-802', '4 hours', 'Evaluación de la capacidad de carga del modelo AU-802.'),
('Prueba de vuelo de AU-747Plus', '6 hours', 'Pruebas de vuelo completas para el modelo AU-747Plus.'),
('Prueba de carga de AU-747Plus', '5 hours', 'Evaluación de la capacidad de carga del modelo AU-747Plus.'),
('Prueba de vuelo de AU-87A', '6 hours', 'Pruebas de vuelo completas para el modelo AU-87A.'),
('Prueba de carga de AU-87A', '5 hours', 'Evaluación de la capacidad de carga del modelo AU-87A.'),
('Prueba de vuelo de AU-802A', '5 hours', 'Pruebas de vuelo completas para el modelo AU-802A.'),
('Prueba de carga de AU-802A', '4 hours', 'Evaluación de la capacidad de carga del modelo AU-802A.'),
('Prueba de vuelo de AU-802B', '5 hours', 'Pruebas de vuelo completas para el modelo AU-802B.'),
('Prueba de carga de AU-802B', '4 hours', 'Evaluación de la capacidad de carga del modelo AU-802B.'),
('Prueba de vuelo de AU-802C', '5 hours', 'Pruebas de vuelo completas para el modelo AU-802C.'),
('Prueba de carga de AU-802C', '4 hours', 'Evaluación de la capacidad de carga del modelo AU-802C.'),
('Prueba de vuelo de AU-802D', '5 hours', 'Pruebas de vuelo completas para el modelo AU-802D.'),
('Prueba de carga de AU-802D', '4 hours', 'Evaluación de la capacidad de carga del modelo AU-802D.'),
('Prueba de vuelo de AU-802E', '5 hours', 'Pruebas de vuelo completas para el modelo AU-802E.'),
('Prueba de carga de AU-802E', '4 hours', 'Evaluación de la capacidad de carga del modelo AU-802E.'),
('Prueba de vuelo de AU-802F', '5 hours', 'Pruebas de vuelo completas para el modelo AU-802F.'),
('Prueba de carga de AU-802F', '4 hours', 'Evaluación de la capacidad de carga del modelo AU-802F.'),
('Prueba de vuelo de AU-747Platinium', '6 hours', 'Pruebas de vuelo completas para el modelo AU-747Platinium.'),
('Prueba de carga de AU-747Platinium', '5 hours', 'Evaluación de la capacidad de carga del modelo AU-747Platinium.'),
('Prueba de vuelo de AU-747Gold', '6 hours', 'Pruebas de vuelo completas para el modelo AU-747Gold.'),
('Prueba de carga de AU-747Gold', '5 hours', 'Evaluación de la capacidad de carga del modelo AU-747Gold.'),
('Prueba de vuelo de AU-747Silver', '6 hours', 'Pruebas de vuelo completas para el modelo AU-747Silver.'),
('Prueba de carga de AU-747Silver', '5 hours', 'Evaluación de la capacidad de carga del modelo AU-747Silver.'),
('Prueba de vuelo de AU-747SilverB', '6 hours', 'Pruebas de vuelo completas para el modelo AU-747SilverB.'),
('Prueba de carga de AU-747SilverB', '5 hours', 'Evaluación de la capacidad de carga del modelo AU-747SilverB.'),
('Prueba de vuelo de AU-87ABusiness', '6 hours', 'Pruebas de vuelo completas para el modelo AU-87ABusiness.'),
('Prueba de carga de AU-87ABusiness', '5 hours', 'Evaluación de la capacidad de carga del modelo AU-87ABusiness.'),

-- Pruebas para Materias Primas
('Prueba de resistencia a la tracción de Acero A36', '3 hours', 'Evaluación de la resistencia a la tracción del Acero A36.'),
('Prueba de resistencia a la corrosión de Titanio Grado 5', '4 hours', 'Validación de la resistencia a la corrosión del Titanio Grado 5.'),
('Prueba de impacto en Compuesto Kevlar', '2 hours', 'Evaluación de la resistencia al impacto del Compuesto Kevlar.'),
('Prueba de elasticidad de Aleación de aluminio 2024', '3 hours', 'Medición de la elasticidad de la Aleación de aluminio 2024.'),
('Prueba de fatiga de Aleación de aluminio 7075', '4 hours', 'Evaluación de la resistencia a ciclos de carga en Aleación de aluminio 7075.'),
('Prueba de dureza de Acero aleado 4340', '2 hours', 'Medición de la dureza del Acero aleado 4340.'),
('Prueba de resistencia a altas temperaturas de Titanio Ti-6Al-4V', '5 hours', 'Evaluación del comportamiento del Titanio Ti-6Al-4V a altas temperaturas.'),
('Prueba de resistencia al impacto de Fibra de carbono', '3 hours', 'Evaluación de la resistencia al impacto de la Fibra de carbono.'),
('Prueba de resistencia al impacto de Fibra de vidrio', '2 hours', 'Validación de la resistencia al impacto de la Fibra de vidrio.'),
('Prueba de resistencia a la corrosión de Acero inoxidable 304', '3 hours', 'Evaluación de la resistencia a la corrosión del Acero inoxidable 304.'),
('Prueba de inflamabilidad de Magnesio', '2 hours', 'Validación del comportamiento del Magnesio ante fuego.'),
('Prueba de envejecimiento acelerado de Polímeros reforzados (FRP)', '6 hours', 'Evaluación de la durabilidad de los Polímeros reforzados (FRP) con el tiempo.'),
('Prueba de curado de Resinas epoxi', '3 hours', 'Evaluación de la calidad del curado de las Resinas epoxi.'),
('Prueba de elasticidad de Poliuretano', '2 hours', 'Medición de la elasticidad del Poliuretano para aplicaciones de sellado.'),
('Prueba de resistencia térmica de Caucho de silicona', '3 hours', 'Evaluación de la resistencia térmica del Caucho de silicona a altas temperaturas.'),
('Prueba de resistencia a la oxidación de Níquel', '4 hours', 'Evaluación de la resistencia a la oxidación del Níquel en condiciones extremas.'),
('Prueba de resistencia a la compresión de Madera de balsa', '2 hours', 'Evaluación de la resistencia a la compresión de la Madera de balsa.');

-- ===========================================
-- Inserción de datos: PRUEBA_PIEZA_SEDE
-- ============================================
INSERT INTO PRUEBA_PIEZA_SEDE (psz_fecha_inicio, psz_fecha_fin, psz_resultado, fk_pie_id, fk_zon_id, fk_pru_id)
VALUES
-- Piezas probadas en Maracay (zona 5)
('2023-01-15', '2023-01-20', 'Aprobada', 1, 5, 1), -- Ala Recta
('2023-01-16', '2023-01-21', 'Aprobada', 2, 5, 3), -- Ala Trapezoidal
('2023-01-17', '2023-01-22', 'Aprobada', 3, 5, 5), -- Ala Delta
('2023-01-18', '2023-01-23', 'Aprobada', 4, 5, 7), -- Ala en Flecha
('2023-01-19', '2023-01-24', 'Aprobada', 5, 5, 9), -- Ala en Flecha Inversa
('2023-01-20', '2023-01-25', 'Aprobada', 6, 5, 11), -- Forma Estándar
('2023-01-21', '2023-01-26', 'Aprobada', 7, 5, 13), -- Forma en T
('2023-01-22', '2023-01-27', 'Aprobada', 8, 5, 15), -- Forma en Cruz
('2023-01-23', '2023-01-28', 'Aprobada', 9, 5, 17), -- Forma 2 Verticales
('2023-01-24', '2023-01-29', 'Aprobada', 10, 5, 19), -- Forma 3 Verticales
('2023-01-25', '2023-01-30', 'Aprobada', 11, 5, 21), -- Forma en V
('2023-01-26', '2023-01-31', 'Aprobada', 12, 5, 53), -- Flaps
('2023-01-27', '2023-02-01', 'Aprobada', 13, 5, 54), -- Slats
('2023-01-28', '2023-02-02', 'Aprobada', 14, 5, 55), -- Spoilers
('2023-01-29', '2023-02-02', 'Aprobada', 15, 5, 56), -- Superficie de sustentación

-- Piezas probadas en Colón (zona 11)
('2023-02-01', '2023-02-10', 'Aprobada', 16, 11, 57), -- Fuselaje
('2023-02-02', '2023-02-11', 'Aprobada', 17, 11, 23), -- Tren Fijo
('2023-02-03', '2023-02-12', 'Aprobada', 18, 11, 24), -- Tren Retráctil

-- Piezas probadas en La Guaira (zona 14)
('2023-03-01', '2023-03-10', 'Aprobada', 19, 14, 49), -- Motor

-- Piezas probadas en Guatire (zona 21, sistemas de control)
('2023-04-01', '2023-04-05', 'Aprobada', 20, 21, 25), -- Anemómetro
('2023-04-02', '2023-04-06', 'Aprobada', 21, 21, 26), -- Altímetro
('2023-04-03', '2023-04-07', 'Aprobada', 22, 21, 27), -- Variómetro
('2023-04-04', '2023-04-08', 'Aprobada', 23, 21, 28), -- Inclinómetro
('2023-04-05', '2023-04-09', 'Aprobada', 24, 21, 29), -- Horizonte Artificial
('2023-04-06', '2023-04-10', 'Aprobada', 25, 21, 30), -- Brújula
('2023-04-07', '2023-04-11', 'Aprobada', 26, 21, 31), -- Indicador de Rumbos
('2023-04-08', '2023-04-12', 'Aprobada', 27, 21, 32), -- ADF
('2023-04-09', '2023-04-13', 'Aprobada', 28, 21, 33), -- DME
('2023-04-10', '2023-04-14', 'Aprobada', 29, 21, 34), -- CDI
('2023-04-11', '2023-04-15', 'Aprobada', 30, 21, 35), -- ILS
('2023-04-12', '2023-04-16', 'Aprobada', 31, 21, 36), -- Piloto Automático
('2023-04-13', '2023-04-17', 'Aprobada', 32, 21, 37), -- Sistema de Gestión de Vuelo
('2023-04-14', '2023-04-18', 'Aprobada', 33, 21, 38), -- Manómetro
('2023-04-15', '2023-04-19', 'Aprobada', 34, 21, 39), -- Termómetro de Aceite
('2023-04-16', '2023-04-20', 'Aprobada', 35, 21, 40), -- Caudal de Combustible
('2023-04-17', '2023-04-21', 'Aprobada', 36, 21, 41), -- Temperatura de Culatas
('2023-04-18', '2023-04-22', 'Aprobada', 37, 21, 42), -- Nivel de Combustible

-- Piezas probadas en Valencia (zona 29, componentes internos)
('2023-05-01', '2023-05-05', 'Aprobada', 38, 29, 43), -- Asientos
('2023-05-02', '2023-05-06', 'Aprobada', 39, 29, 44), -- Porta Equipajes
('2023-05-03', '2023-05-07', 'Aprobada', 40, 29, 47), -- Ventanillas
('2023-05-04', '2023-05-08', 'Aprobada', 41, 29, 45), -- Alfombrado
('2023-05-05', '2023-05-09', 'Aprobada', 42, 29, 46), -- Piezas Sanitarias
('2023-05-06', '2023-05-10', 'Aprobada', 43, 29, 48); -- Cortinas

-- ===========================================
-- Inserción de datos: SEDE_MATERIAL_PRUEBA
-- ============================================

INSERT INTO SEDE_MATERIAL_PRUEBA (pbm_fecha_inicio, pbm_fecha_fin, pbm_resultado_prueba, fk_zon_id, fk_sed_id, fk_rpm_id, fk_mps_id, fk_pru_id)
VALUES
-- Material probado en Maracay
('2023-01-15', '2023-01-20', 'Aprobada', 5, 1, 1, 1, 90), 
('2023-01-16', '2023-01-21', 'Aprobada', 5, 1, 4, 2, 93), 
('2023-01-17', '2023-01-22', 'Aprobada', 5, 1, 8, 3, 97),
('2023-01-18', '2023-01-23', 'Aprobada', 5, 1, 13, 4, 102),

-- Material probado en Colón
('2023-02-01', '2023-02-10', 'Aprobada', 11, 2, 5, 5, 94),
('2023-02-02', '2023-02-11', 'Aprobada', 11, 2, 6, 6, 95), 
('2023-02-03', '2023-02-12', 'Aprobada', 11, 2, 9, 7, 98),
('2023-02-04', '2023-02-13', 'Aprobada', 11, 2, 13, 8, 102), 

-- Material probado en La Guaira
('2023-03-01', '2023-03-10', 'Aprobada', 14, 3, 2, 9, 91),
('2023-03-02', '2023-03-11', 'Aprobada', 14, 3, 7, 10, 96), 
('2023-03-03', '2023-03-12', 'Aprobada', 14, 3, 10, 11, 99), 
('2023-03-04', '2023-03-13', 'Aprobada', 14, 3, 16, 12, 105), 

-- Material probado en Guatire
('2023-04-01', '2023-04-05', 'Aprobada', 21, 4, 3, 13, 92), 
('2023-04-02', '2023-04-06', 'Aprobada', 21, 4, 12, 14, 101),
('2023-04-03', '2023-04-07', 'Aprobada', 21, 4, 15, 15, 104), 

-- Material probado en Valencia
('2023-05-01', '2023-05-05', 'Aprobada', 29, 5, 11, 16, 100),
('2023-05-02', '2023-05-06', 'Aprobada', 29, 5, 17, 17, 106), 
('2023-05-03', '2023-05-07', 'Aprobada', 29, 5, 14, 18, 104); 


-- ================================================================
-- Inserción de datos: PRUEBA_PIEZA_SOLICITUD Cliente Natural
-- ================================================================

-- Inserts para PRUEBA_PIEZA_SOLICITUD basados en las solicitudes de piezas del modelo AU-80

-- Pruebas para las piezas del modelo AU-80
INSERT INTO PRUEBA_PIEZA_SOLICITUD (pzb_fecha_inicio, pzb_fecha_fin, pzb_resultado_prueba, fk_zon_id, fk_edz_id, fk_pru_id) VALUES
('2024-01-01', '2024-02-01', 'Aprobado', 5, 1, 1),
('2024-02-01', '2024-03-01', 'Aprobado', 5, 2, 11),
('2024-03-01', '2024-04-01', 'Aprobado', 5, 3, 53), 
('2024-04-01', '2024-05-01', 'Aprobado', 11, 4, 23), 
('2024-05-01', '2024-06-01', 'Aprobado', 11, 5, 57),
('2024-06-01', '2024-07-01', 'Aprobado', 14, 6, 49),
('2024-07-01', '2024-08-01', 'Aprobado', 21, 7, 25),
('2024-08-01', '2024-09-01', 'Aprobado', 29, 8, 44),
('2024-09-01', '2024-10-01', 'Aprobado', 29, 9, 46);

-- Pruebas para las piezas del modelo AU-801

INSERT INTO PRUEBA_PIEZA_SOLICITUD (pzb_fecha_inicio, pzb_fecha_fin, pzb_resultado_prueba, fk_zon_id, fk_edz_id, fk_pru_id) VALUES
('2024-01-01', '2024-02-01', 'Aprobado', 5, 10, 3), 
('2024-02-01', '2024-03-01', 'Aprobado', 5, 11, 15), 
('2024-03-01', '2024-04-01', 'Aprobado', 5, 12, 53), 
('2024-04-01', '2024-05-01', 'Aprobado', 11, 13, 24), 
('2024-05-01', '2024-06-01', 'Aprobado', 11, 14, 57),
('2024-06-01', '2024-07-01', 'Aprobado', 14, 15, 49),
('2024-07-01', '2024-08-01', 'Aprobado', 21, 16, 25),
('2024-08-01', '2024-09-01', 'Aprobado', 29, 17, 44),
('2024-09-01', '2024-10-01', 'Aprobado', 29, 18, 46);

-- Pruebas para las piezas del modelo AU-802A

INSERT INTO PRUEBA_PIEZA_SOLICITUD (pzb_fecha_inicio, pzb_fecha_fin, pzb_resultado_prueba, fk_zon_id, fk_edz_id, fk_pru_id) VALUES
('2024-01-01', '2024-02-01', 'Aprobado', 5, 19, 1),
('2024-02-01', '2024-03-01', 'Aprobado', 5, 20, 11),
('2024-03-01', '2024-04-01', 'Aprobado', 5, 21, 53),
('2024-04-01', '2024-05-01', 'Aprobado', 11, 22, 24),
('2024-05-01', '2024-06-01', 'Aprobado', 11, 23, 57),
('2024-06-01', '2024-07-01', 'Aprobado', 14, 24, 49),
('2024-07-01', '2024-08-01', 'Aprobado', 21, 25, 25),
('2024-08-01', '2024-09-01', 'Aprobado', 29, 26, 44),
('2024-09-01', '2024-10-01', 'Aprobado', 29, 27, 46);

-- Pruebas para las piezas del modelo AU-747PLUS

INSERT INTO PRUEBA_PIEZA_SOLICITUD (pzb_fecha_inicio, pzb_fecha_fin, pzb_resultado_prueba, fk_zon_id, fk_edz_id, fk_pru_id) VALUES
('2024-01-01', '2024-02-01', 'Aprobado', 5, 28, 3),
('2024-02-01', '2024-03-01', 'Aprobado', 5, 29, 15),
('2024-03-01', '2024-04-01', 'Aprobado', 5, 30, 53),
('2024-04-01', '2024-05-01', 'Aprobado', 11, 31, 23),
('2024-05-01', '2024-06-01', 'Aprobado', 11, 32, 57),
('2024-06-01', '2024-07-01', 'Aprobado', 14, 33, 49),
('2024-07-01', '2024-08-01', 'Aprobado', 21, 34, 25),
('2024-08-01', '2024-09-01', 'Aprobado', 29, 35, 44),
('2024-09-01', '2024-10-01', 'Aprobado', 29, 36, 46);

-- ================================================================
-- Inserción de datos: PRUEBA_PIEZA_SOLICITUD Cliente Jurídico
-- ================================================================

-- Pruebas para las piezas del modelo AU-802F

INSERT INTO PRUEBA_PIEZA_SOLICITUD (pzb_fecha_inicio, pzb_fecha_fin, pzb_resultado_prueba, fk_zon_id, fk_edz_id, fk_pru_id) VALUES
('2024-01-01', '2024-02-01', 'Aprobado', 5, 37, 7),
('2024-02-01', '2024-03-01', 'Aprobado', 5, 38, 19),
('2024-03-01', '2024-04-01', 'Aprobado', 5, 39, 53),
('2024-04-01', '2024-05-01', 'Aprobado', 11, 40, 24),
('2024-05-01', '2024-06-01', 'Aprobado', 11, 41, 57),
('2024-06-01', '2024-07-01', 'Aprobado', 14, 42, 49),
('2024-07-01', '2024-08-01', 'Aprobado', 21, 43, 25),
('2024-08-01', '2024-09-01', 'Aprobado', 29, 44, 44),
('2024-09-01', '2024-10-01', 'Aprobado', 29, 45, 46);

-- Pruebas para las piezas del modelo AU-747Gold

INSERT INTO PRUEBA_PIEZA_SOLICITUD (pzb_fecha_inicio, pzb_fecha_fin, pzb_resultado_prueba, fk_zon_id, fk_edz_id, fk_pru_id) VALUES
('2024-01-01', '2024-02-01', 'Aprobado', 5, 46, 5),
('2024-02-01', '2024-03-01', 'Aprobado', 5, 47, 21),
('2024-03-01', '2024-04-01', 'Aprobado', 5, 48, 53),
('2024-04-01', '2024-05-01', 'Aprobado', 11, 49, 23),
('2024-05-01', '2024-06-01', 'Aprobado', 11, 50, 57),
('2024-06-01', '2024-07-01', 'Aprobado', 14, 51, 49),
('2024-07-01', '2024-08-01', 'Aprobado', 21, 52, 25),
('2024-08-01', '2024-09-01', 'Aprobado', 29, 53, 44),
('2024-09-01', '2024-10-01', 'Aprobado', 29, 54, 46);

-- Pruebas para las piezas del modelo AU-87ABusiness

INSERT INTO PRUEBA_PIEZA_SOLICITUD (pzb_fecha_inicio, pzb_fecha_fin, pzb_resultado_prueba, fk_zon_id, fk_edz_id, fk_pru_id) VALUES
('2024-01-01', '2024-02-01', 'Aprobado', 5, 55, 9),
('2024-02-01', '2024-03-01', 'Aprobado', 5, 56, 13),
('2024-03-01', '2024-04-01', 'Aprobado', 5, 57, 53),
('2024-04-01', '2024-05-01', 'Aprobado', 11, 58, 23),
('2024-05-01', '2024-06-01', 'Aprobado', 11, 59, 57),
('2024-06-01', '2024-07-01', 'Aprobado', 14, 60, 49),
('2024-07-01', '2024-08-01', 'Aprobado', 21, 61, 25),
('2024-08-01', '2024-09-01', 'Aprobado', 29, 62, 44),
('2024-09-01', '2024-10-01', 'Aprobado', 29, 63, 46);

-- Pruebas para las piezas del modelo AU-802E

INSERT INTO PRUEBA_PIEZA_SOLICITUD (pzb_fecha_inicio, pzb_fecha_fin, pzb_resultado_prueba, fk_zon_id, fk_edz_id, fk_pru_id) VALUES
('2024-01-01', '2024-02-01', 'Aprobado', 5, 64, 3),
('2024-02-01', '2024-03-01', 'Aprobado', 5, 65, 11),
('2024-03-01', '2024-04-01', 'Aprobado', 5, 66, 53),
('2024-04-01', '2024-05-01', 'Aprobado', 11, 67, 23),
('2024-05-01', '2024-06-01', 'Aprobado', 11, 68, 57),
('2024-06-01', '2024-07-01', 'Aprobado', 14, 69, 49),
('2024-07-01', '2024-08-01', 'Aprobado', 21, 70, 25),
('2024-08-01', '2024-09-01', 'Aprobado', 29, 71, 44),
('2024-09-01', '2024-10-01', 'Aprobado', 29, 72, 46);

