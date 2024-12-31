-- ==============================================
-- Inserción de datos: Cargos
-- ==============================================
INSERT INTO CARGO (car_nombre, car_descripcion)
VALUES 
('Ingeniero Aeronáutico', 'Diseño y desarrollo de aeronaves.'),
('Técnico en Electrónica Aeronáutica', 'Mantenimiento de sistemas electrónicos en aviones.'),
('Inspector de Calidad', 'Asegura la calidad de componentes aeronáuticos.'),
('Supervisor de Producción', 'Supervisa líneas de producción en la fábrica.'),
('Mecánico de Aviones', 'Mantenimiento y reparación de aeronaves.'),
('Técnico de Mantenimiento', 'Mantenimiento preventivo y correctivo de equipos.'),
('Diseñador Aeronáutico', 'Diseño de estructuras de aeronaves.'),
('Programador de Sistemas', 'Desarrollo y mantenimiento de sistemas de software.'),
('Técnico en Materiales Compuestos', 'Trabajo con materiales avanzados en aviones.'),
('Especialista en Motores', 'Reparación y mantenimiento de motores aeronáuticos.'),
('Inspector de Seguridad', 'Cumplimiento de normas de seguridad.'),
('Operador de Máquina CNC', 'Manejo de máquinas CNC para fabricar piezas.'),
('Ensamblador de Estructuras', 'Ensamblaje de estructuras de aviones.'),
('Técnico en Hidráulica y Neumática', 'Mantenimiento de sistemas hidráulicos y neumáticos.'),
('Ingeniero de Pruebas', 'Pruebas y validación de componentes aeronáuticos.'),
('Coordinador de Logística', 'Gestión de cadena de suministro y distribución.'),
('Técnico en Aviónica', 'Especialista en la electrónica de las aeronaves.'),
('Planificador de Producción', 'Planificación de actividades de producción.'),
('Especialista en Control de Calidad', 'Supervisión de sistemas de calidad.'),
('Técnico en Instrumentación', 'Mantenimiento de instrumentos de medición en aviones.');

-- ==============================================
-- Inserción de datos: Empleados
-- ==============================================
INSERT INTO EMPLEADO (per_dni, per_nombre, per_apellido, per_direccion, per_experiencia, per_profesion, fk_lug_id)
VALUES 
('V12345678', 'Juan', 'Pérez', 'Calle 123', 5, 'Ingeniero Aeronáutico', 1),
('V23456789', 'María', 'Gómez', 'Avenida 45', 8, 'Mecánica de Aviones', 2),
('V34567890', 'Pedro', 'Martínez', 'Calle 67', 3, 'Técnico en Electrónica Aeronáutica', 3),
('V45678901', 'Luisa', 'Fernández', 'Calle 89', 10, 'Inspector de Calidad', 4),
('V56789012', 'Carlos', 'Rodríguez', 'Boulevard 101', 7, 'Programador de Sistemas', 5),
('V67890123', 'Ana', 'Morales', 'Carrera 23', 12, 'Supervisora de Producción', 6),
('V78901234', 'José', 'Hernández', 'Calle 56', 4, 'Diseñador Aeronáutico', 7),
('V89012345', 'Marta', 'López', 'Avenida 78', 9, 'Mecánica de Aviones', 8),
('V90123456', 'Luis', 'García', 'Calle 910', 6, 'Técnico de Mantenimiento', 9),
('V12345679', 'Sara', 'Vega', 'Calle 1112', 2, 'Técnico en Materiales Compuestos', 10),
('V23456780', 'David', 'Ramos', 'Avenida 1314', 11, 'Especialista en Motores', 11),
('V34567891', 'Laura', 'Torres', 'Carrera 1516', 5, 'Inspector de Seguridad', 12),
('V45678902', 'Andrés', 'Ruiz', 'Calle 1718', 3, 'Operador de Máquina CNC', 13),
('V56789013', 'Carmen', 'Díaz', 'Boulevard 1920', 4, 'Ensamblador de Estructuras', 14),
('V67890124', 'Manuel', 'Mejía', 'Calle 2122', 7, 'Técnico en Hidráulica y Neumática', 15),
('V78901235', 'Gloria', 'Ortiz', 'Avenida 2324', 6, 'Ingeniera de Pruebas', 16),
('V89012346', 'Rafael', 'Navarro', 'Calle 2526', 10, 'Coordinador de Logística', 17),
('V90123457', 'Sofía', 'Pineda', 'Carrera 2728', 8, 'Técnico en Aviónica', 18),
('V12345680', 'Fabio', 'Serrano', 'Boulevard 2930', 3, 'Planificador de Producción', 19),
('V23456781', 'Diana', 'Castillo', 'Calle 3132', 5, 'Especialista en Control de Calidad', 20),
('V34567892', 'Jorge', 'Suárez', 'Avenida 3334', 6, 'Técnico en Instrumentación', 21),
('V45678903', 'Elena', 'Espinosa', 'Calle 3536', 4, 'Ingeniera Aeronáutica', 22),
('V56789014', 'Camilo', 'Correa', 'Boulevard 3738', 2, 'Técnico en Electrónica Aeronáutica', 23),
('V67890125', 'Estela', 'Guzmán', 'Calle 3940', 12, 'Inspector de Calidad', 24),
('V78901236', 'Víctor', 'Santana', 'Avenida 4142', 9, 'Programador de Sistemas', 1),
('V89012347', 'Olga', 'Álvarez', 'Calle 4344', 11, 'Técnico de Mantenimiento', 2),
('V90123458', 'Gustavo', 'Montoya', 'Boulevard 4546', 7, 'Supervisor de Producción', 3),
('V12345681', 'Verónica', 'Palacios', 'Calle 4748', 4, 'Diseñador Aeronáutico', 4),
('V23456782', 'Sebastián', 'Blanco', 'Carrera 4950', 3, 'Técnico en Materiales Compuestos', 5),
('V34567893', 'Adriana', 'Bermúdez', 'Calle 5152', 6, 'Especialista en Motores', 6),
('V45678904', 'Enrique', 'Cabrera', 'Avenida 5354', 5, 'Inspector de Seguridad', 7),
('V56789015', 'Mariela', 'Zambrano', 'Calle 5556', 7, 'Operador de Máquina CNC', 8),
('V67890126', 'Fernando', 'Jiménez', 'Boulevard 5758', 8, 'Ensamblador de Estructuras', 9),
('V78901237', 'Patricia', 'Acosta', 'Calle 5960', 10, 'Técnico en Hidráulica y Neumática', 10),
('V89012348', 'Héctor', 'Mendoza', 'Carrera 6162', 12, 'Ingeniero de Pruebas', 11),
('V90123459', 'Claudia', 'Peña', 'Calle 6364', 9, 'Coordinadora de Logística', 12),
('V12345682', 'Eduardo', 'Ibarra', 'Avenida 6566', 6, 'Técnico en Aviónica', 13),
('V23456783', 'Lucía', 'Arce', 'Calle 6768', 4, 'Planificadora de Producción', 14),
('V34567894', 'Tomás', 'Barrera', 'Carrera 6970', 8, 'Especialista en Control de Calidad', 15);

-- ==============================================
-- Inserción de datos: Empleado Cargo
-- ==============================================
INSERT INTO EMPLEADO_CARGO (emc_fecha_inicio, emc_fecha_fin, fk_car_id, fk_per_id)
VALUES 
('2022-01-15', NULL, 1, 1),  -- Ingeniero Aeronáutico
('2023-03-21', NULL, 5, 2),  -- Mecánica de Aviones
('2021-06-10', NULL, 2, 3),  -- Técnico en Electrónica Aeronáutica
('2020-09-30', NULL, 3, 4),  -- Inspector de Calidad
('2022-02-05', NULL, 8, 5),  -- Programador de Sistemas
('2021-11-25', NULL, 4, 6),  -- Supervisora de Producción
('2022-07-14', NULL, 7, 7),  -- Diseñador Aeronáutico
('2023-04-18', NULL, 5, 8),  -- Mecánica de Aviones
('2020-12-09', NULL, 6, 9),  -- Técnico de Mantenimiento
('2022-08-22', NULL, 9, 10), -- Técnico en Materiales Compuestos
('2021-05-17', NULL, 10, 11),-- Especialista en Motores
('2023-01-28', NULL, 11, 12),-- Inspector de Seguridad
('2022-06-11', NULL, 12, 13),-- Operador de Máquina CNC
('2020-10-05', NULL, 13, 14),-- Ensamblador de Estructuras
('2021-09-12', NULL, 14, 15),-- Técnico en Hidráulica y Neumática
('2022-03-29', NULL, 15, 16),-- Ingeniera de Pruebas
('2023-02-07', NULL, 16, 17),-- Coordinador de Logística
('2021-07-03', NULL, 17, 18),-- Técnico en Aviónica
('2022-04-27', NULL, 18, 19),-- Planificador de Producción
('2020-08-15', NULL, 19, 20),-- Especialista en Control de Calidad
('2023-05-19', NULL, 20, 21),-- Técnico en Instrumentación
('2021-11-01', NULL, 1, 22), -- Ingeniera Aeronáutica
('2022-09-26', NULL, 2, 23), -- Técnico en Electrónica Aeronáutica
('2023-03-12', NULL, 3, 24), -- Inspector de Calidad
('2020-12-24', NULL, 8, 25), -- Programador de Sistemas
('2021-06-05', NULL, 6, 26), -- Técnico de Mantenimiento
('2022-10-30', NULL, 4, 27), -- Supervisor de Producción
('2023-04-07', NULL, 7, 28), -- Diseñador Aeronáutico
('2021-05-21', NULL, 9, 29), -- Técnico en Materiales Compuestos
('2022-08-11', NULL, 10, 30),-- Especialista en Motores
('2023-01-16', NULL, 11, 31),-- Inspector de Seguridad
('2020-11-05', NULL, 12, 32),-- Operador de Máquina CNC
('2021-07-30', NULL, 13, 33),-- Ensamblador de Estructuras
('2022-04-02', NULL, 14, 34),-- Técnico en Hidráulica y Neumática
('2023-02-25', NULL, 15, 35),-- Ingeniero de Pruebas
('2021-09-09', NULL, 16, 36),-- Coordinadora de Logística
('2022-03-19', NULL, 17, 37),-- Técnico en Aviónica
('2020-07-12', NULL, 18, 38),-- Planificadora de Producción
('2021-08-05', NULL, 19, 39),-- Especialista en Control de Calidad
('2023-05-03', NULL, 20, 40);-- Técnico en Instrumentación




-- ==============================================
-- Inserción de datos: Título
-- ==============================================
INSERT INTO TITULO (tit_nombre, tit_descripcion)
VALUES ('TSU Mecánico', 'Técnico Superior en Mecánica'),
       ('Ing. Aeronáutica', 'Ingeniero en Aeronáutica'),
       ('Ing. Industrial', 'Ingeniero en procesos industriales'),
       ('Master en Logística', 'Postgrado en logística y distribución');

-- ==============================================
-- Inserción de datos: Empleado Titulo
-- ==============================================
INSERT INTO EMPLEADO_TITULO (edt_fecha_obtencion, edt_nombre_universidad, edt_descripcion, fk_tit_id, fk_per_id)
VALUES ('2015-07-01', 'Universidad de Maracay', 'Pregrado en Aeronáutica', 2, 1), -- Juan
       ('2012-10-15', 'Instituto Técnico La Guaira', 'TSU en Mecánica', 1, 2),    -- María
       ('2021-02-10', 'Universidad de Zulia', 'Postgrado en Logística', 4, 5);    -- José

-- ==============================================
-- Inserción de datos: Empleado Teléfono
-- ==============================================
INSERT INTO TELEFONO (tel_codigo_area, tel_numero, fk_per_id, fk_com_id, fk_cjd_id, fk_ctn_id)
VALUES
    ('+58', '4123456789', 1, NULL, NULL, NULL), -- Juan
    ('+58', '4145678901', 2, NULL, NULL, NULL), -- María
    ('+58', '4167890123', 3, NULL, NULL, NULL), -- Carlos
    ('+58', '4249012345', 4, NULL, NULL, NULL), -- Elena
    ('+58', '4261234567', 5, NULL, NULL, NULL); -- José

-- ==============================================
-- Inserción de datos: Red Social
-- ==============================================
INSERT INTO RED_SOCIAL (res_usuario, fk_per_id, fk_com_id, fk_cjd_id, fk_ctn_id)
VALUES ('juan_perez', 1, NULL, NULL, NULL),      -- Juan
       ('maria_garcia', 2, NULL, NULL, NULL),    -- María
       ('carlos_lopez', 3, NULL, NULL, NULL),    -- Carlos
       ('elena_rodriguez', 4, NULL, NULL, NULL), -- Elena
       ('jose_martinez', 5, NULL, NULL, NULL);   -- José

-- ==============================================
-- Inserción de datos: Correo Electrónico
-- ==============================================
INSERT INTO CORREO_ELECTRONICO (cor_dir_correo, fk_per_id, fk_com_id, fk_cjd_id, fk_ctn_id)
VALUES ('juan.perez@example.com', 1, NULL, NULL, NULL),      -- Juan
       ('maria.garcia@example.com', 2, NULL, NULL, NULL),    -- María
       ('carlos.lopez@example.com', 3, NULL, NULL, NULL),    -- Carlos
       ('elena.rodriguez@example.com', 4, NULL, NULL, NULL), -- Elena
       ('jose.martinez@example.com', 5, NULL, NULL, NULL);   -- José

-- ==============================================
-- Inserción de datos: Beneficiario
-- ==============================================
INSERT INTO BENEFICIARIO (ben_dni, ben_nombre, ben_apellido, ben_direccion, fk_lug_id)
VALUES (33445566, 'Luis', 'Pérez', 'Av. Principal, Maracay', 1),
       (55667788, 'Ana', 'García', 'Calle Bolivar, La Guaira', 2);

-- ==============================================
-- Inserción de datos: Persona Beneficiario
-- ==============================================
INSERT INTO PER_BEN (prb_parentezco, fk_ben_id, fk_per_id)
VALUES ('PADRE', 1, 1), -- Luis (ben_id=1) es beneficiario de Juan (per_id=1)
       ('OTRO', 2, 2);  -- Ana (ben_id=2) es beneficiaria de María (per_id=2)

-- ==============================================
-- Inserción de datos: Experiencia
-- ==============================================
INSERT INTO EXPERIENCIA (exp_nombre_empresa, exp_fecha_inicio, exp_fecha_fin, fk_per_id)
VALUES ('Aviones S.A.', '2018-01-01', '2020-12-31', 1),     -- Juan
       ('Motores Globales', '2017-03-01', '2021-05-30', 2), -- María
       ('Aerotec', '2019-07-10', '2022-02-15', 3),          -- Carlos
       ('Aeroespacial', '2020-03-15', '2022-12-31', 4),     -- Elena
       ('Logística Express', '2018-09-01', '2022-12-31', 5);-- José

-- ==============================================
-- Inserción de datos: Horario
-- ==============================================
INSERT INTO HORARIO (hor_dia, hor_hora_inicio, hor_hora_fin)
VALUES ('LUNES', '08:00:00', '16:00:00'),
       ('MARTES', '08:00:00', '16:00:00'),
       ('MIERCOLES', '08:00:00', '16:00:00'),
       ('JUEVES', '08:00:00', '16:00:00'),
       ('VIERNES', '08:00:00', '16:00:00');

-- ==============================================
-- Inserción de datos: Empleado Cargo Horario
-- ==============================================
INSERT INTO EMP_CARGO_HORARIO (fk_per_id, fk_car_id, fk_emc_id, fk_hor_id)
VALUES (1, 1, 1, 1), -- Juan (per_id=1) + Ingeniero Aeronáutico (car_id=1) + Horario Lunes (hor_id=1)
       (1, 1, 1, 2), -- Juan (per_id=1) + Ingeniero Aeronáutico (car_id=1) + Horario Martes (hor_id=2)
       (2, 2, 2, 1), -- María (per_id=2) + Técnico de Motores (car_id=2) + Horario Lunes (hor_id=1)
       (2, 2, 2, 2), -- María (per_id=2) + Técnico de Motores (car_id=2) + Horario Martes (hor_id=2)
       (2, 2, 2, 3), -- María (per_id=2) + Técnico de Motores (car_id=2) + Horario Miércoles (hor_id=3)
       (3, 3, 3, 1), -- Carlos (per_id=3) + Inspector de Calidad (car_id=3) + Horario Lunes (hor_id=1)
       (3, 3, 3, 2), -- Carlos (per_id=3) + Inspector de Calidad (car_id=3) + Horario Martes (hor_id=2)
       (3, 3, 3, 3), -- Carlos (per_id=3) + Inspector de Calidad (car_id=3) + Horario Miércoles (hor_id=3)
       (3, 3, 3, 4), -- Carlos (per_id=3) + Inspector de Calidad (car_id=3) + Horario Jueves (hor_id=4)
       (3, 3, 3, 5), -- Carlos (per_id=3) + Inspector de Calidad (car_id=3) + Horario Viernes (hor_id=5)
       (4, 4, 4, 1), -- Elena (per_id=4) + Supervisor de Ensamble (car_id=4) + Horario Lunes (hor_id=1)
       (4, 4, 4, 2), -- Elena (per_id=4) + Supervisor de Ensamble (car_id=4) + Horario Martes (hor_id=2)
       (4, 4, 4, 3), -- Elena (per_id=4) + Supervisor de Ensamble (car_id=4) + Horario Miércoles (hor_id=3)
       (4, 4, 4, 4), -- Elena (per_id=4) + Supervisor de Ensamble (car_id=4) + Horario Jueves (hor_id=4)
       (4, 4, 4, 5), -- Elena (per_id=4) + Supervisor de Ensamble (car_id=4) + Horario Viernes (hor_id=5)
       (5, 5, 5, 1), -- José (per_id=5) + Ingeniero Aeronáutico (car_id=5) + Horario Lunes (hor_id=1)
       (5, 5, 5, 2), -- José (per_id=5) + Ingeniero Aeronáutico (car_id=5) + Horario Martes (hor_id=2)
       (5, 5, 5, 3), -- José (per_id=5) + Ingeniero Aeronáutico (car_id=5) + Horario Miércoles (hor_id=3)
       (5, 5, 5, 4), -- José (per_id=5) + Ingeniero Aeronáutico (car_id=5) + Horario Jueves (hor_id=4)
       (5, 5, 5, 5); -- José (per_id=5) + Ingeniero Aeronáutico (car_id=5) + Horario Viernes (hor_id=5)

-- ==============================================
-- Inserción de datos: Asistencia
-- ==============================================
INSERT INTO ASISTENCIA (asi_hora_inicio, asi_hora_fin, fk_per_id, fk_car_id, fk_emc_id, fk_hor_id)
VALUES ('08:05:00', '16:01:00', 1, 1, 1, 1),
       ('08:00:00', '15:59:00', 1, 1, 1, 2),
       ('08:10:00', '16:05:00', 2, 2, 2, 1),
       ('08:00:00', '16:00:00', 2, 2, 2, 2),
       ('08:00:00', '16:00:00', 2, 2, 2, 3),
       ('08:00:00', '16:00:00', 3, 3, 3, 1),
       ('08:00:00', '16:00:00', 3, 3, 3, 2),
       ('08:00:00', '16:00:00', 3, 3, 3, 3),
       ('08:00:00', '16:00:00', 3, 3, 3, 4),
       ('08:00:00', '16:00:00', 3, 3, 3, 5),
       ('08:00:00', '16:00:00', 4, 4, 4, 1),
       ('08:00:00', '16:00:00', 4, 4, 4, 2),
       ('08:00:00', '16:00:00', 4, 4, 4, 3),
       ('08:00:00', '16:00:00', 4, 4, 4, 4),
       ('08:00:00', '16:00:00', 4, 4, 4, 5),
       ('08:00:00', '16:00:00', 5, 5, 5, 1),
       ('08:00:00', '16:00:00', 5, 5, 5, 2),
       ('08:00:00', '16:00:00', 5, 5, 5, 3),
       ('08:00:00', '16:00:00', 5, 5, 5, 4),
       ('08:00:00', '16:00:00', 5, 5, 5, 5);