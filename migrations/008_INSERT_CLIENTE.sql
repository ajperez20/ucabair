-- ==============================================
-- Inserción de datos: Cliente Natural
-- ==============================================
INSERT INTO CLIENTE_NATURAL (ctn_direccion, ctn_url_pagina, ctn_dni, ctn_nombre, ctn_apellido, fk_lug_id)
VALUES
-- Amazonas
('Calle 1, Amazonas', 'https://www.juanperez.com', 'V123456781', 'Juan', 'Pérez', 1),
('Calle 2, Amazonas', 'https://www.mariagomez.com', 'V123456782', 'María', 'Gómez', 1),
('Calle 3, Amazonas', 'https://www.luisrodriguez.com', 'V123456783', 'Luis', 'Rodríguez', 1),
('Calle 4, Amazonas', 'https://www.anamartinez.com', 'V123456784', 'Ana', 'Martínez', 1),

-- Anzoátegui
('Calle 1, Anzoátegui', 'https://www.pedrolopez.com', 'V123456785', 'Pedro', 'López', 2),
('Calle 2, Anzoátegui', 'https://www.sofiahernandez.com', 'V123456786', 'Sofía', 'Hernández', 2),
('Calle 3, Anzoátegui', 'https://www.carlosgonzalez.com', 'V123456787', 'Carlos', 'González', 2),
('Calle 4, Anzoátegui', 'https://www.luisadiaz.com', 'V123456788', 'Luisa', 'Díaz', 2),

-- Apure
('Calle 1, Apure', 'https://www.miguelramirez.com', 'V123456789', 'Miguel', 'Ramírez', 3),
('Calle 2, Apure', 'https://www.isabeltorres.com', 'V123456790', 'Isabel', 'Torres', 3),
('Calle 3, Apure', 'https://www.josefernandez.com', 'V123456791', 'José', 'Fernández', 3),
('Calle 4, Apure', 'https://www.lauramorales.com', 'V123456792', 'Laura', 'Morales', 3),

-- Aragua
('Calle 1, Aragua', 'https://www.fernandojimenez.com', 'V123456793', 'Fernando', 'Jiménez', 4),
('Calle 2, Aragua', 'https://www.andreacastro.com', 'V123456794', 'Andrea', 'Castro', 4),
('Calle 3, Aragua', 'https://www.rauloortiz.com', 'V123456795', 'Raúl', 'Ortiz', 4),
('Calle 4, Aragua', 'https://www.patriciaromero.com', 'V123456796', 'Patricia', 'Romero', 4),

-- Barinas
('Calle 1, Barinas', 'https://www.jorgemartinez.com', 'V123456797', 'Jorge', 'Martínez', 5),
('Calle 2, Barinas', 'https://www.luciafernandez.com', 'V123456798', 'Lucía', 'Fernández', 5),
('Calle 3, Barinas', 'https://www.ricardolopez.com', 'V123456799', 'Ricardo', 'López', 5),
('Calle 4, Barinas', 'https://www.martacastro.com', 'V123456800', 'Marta', 'Castro', 5),

-- Bolívar
('Calle 1, Bolívar', 'https://www.joseperez.com', 'V123456801', 'José', 'Pérez', 6),
('Calle 2, Bolívar', 'https://www.saralopez.com', 'V123456802', 'Sara', 'López', 6),
('Calle 3, Bolívar', 'https://www.robertohernandez.com', 'V123456803', 'Roberto', 'Hernández', 6),
('Calle 4, Bolívar', 'https://www.angelamartinez.com', 'V123456804', 'Ángela', 'Martínez', 6),

-- Carabobo
('Calle 1, Carabobo', 'https://www.carlosgomez.com', 'V123456805', 'Carlos', 'Gómez', 7),
('Calle 2, Carabobo', 'https://www.juanadominguez.com', 'V123456806', 'Juana', 'Domínguez', 7),
('Calle 3, Carabobo', 'https://www.diegolopez.com', 'V123456807', 'Diego', 'López', 7),
('Calle 4, Carabobo', 'https://www.sandrafernandez.com', 'V123456808', 'Sandra', 'Fernández', 7),

-- Cojedes
('Calle 1, Cojedes', 'https://www.juanruiz.com', 'V123456809', 'Juan', 'Ruiz', 8),
('Calle 2, Cojedes', 'https://www.mariarodriguez.com', 'V123456810', 'María', 'Rodríguez', 8),
('Calle 3, Cojedes', 'https://www.pedromartinez.com', 'V123456811', 'Pedro', 'Martínez', 8),
('Calle 4, Cojedes', 'https://www.analuna.com', 'V123456812', 'Ana', 'Luna', 8),

-- Delta Amacuro
('Calle 1, Delta Amacuro', 'https://www.robertolopez.com', 'V123456813', 'Roberto', 'López', 9),
('Calle 2, Delta Amacuro', 'https://www.susanagomez.com', 'V123456814', 'Susana', 'Gómez', 9),
('Calle 3, Delta Amacuro', 'https://www.ricardorodriguez.com', 'V123456815', 'Ricardo', 'Rodríguez', 9),
('Calle 4, Delta Amacuro', 'https://www.mariaperez.com', 'V123456816', 'María', 'Pérez', 9),

-- Distrito Capital
('Calle 1, Distrito Capital', 'https://www.andresmartinez.com', 'V123456817', 'Andrés', 'Martínez', 10),
('Calle 2, Distrito Capital', 'https://www.lauragomez.com', 'V123456818', 'Laura', 'Gómez', 10),
('Calle 3, Distrito Capital', 'https://www.josegarcia.com', 'V123456819', 'José', 'García', 10),
('Calle 4, Distrito Capital', 'https://www.fernandadiaz.com', 'V123456820', 'Fernando', 'Díaz', 10),

-- Falcón
('Calle 1, Falcón', 'https://www.susanafernandez.com', 'V123456821', 'Susana', 'Fernández', 11),
('Calle 2, Falcón', 'https://www.pablohernandez.com', 'V123456822', 'Pablo', 'Hernández', 11),
('Calle 3, Falcón', 'https://www.alejandrolopez.com', 'V123456823', 'Alejandro', 'López', 11),
('Calle 4, Falcón', 'https://www.monicagomez.com', 'V123456824', 'Mónica', 'Gómez', 11),

-- Guárico
('Calle 1, Guárico', 'https://www.juancarlos.com', 'V123456825', 'Juan', 'Carlos', 12),
('Calle 2, Guárico', 'https://www.marialopez.com', 'V123456826', 'María', 'López', 12),
('Calle 3, Guárico', 'https://www.pedrofernandez.com', 'V123456827', 'Pedro', 'Fernández', 12),
('Calle 4, Guárico', 'https://www.anamartinez.com', 'V123456828', 'Ana', 'Martínez', 12);

-- ==============================================
-- Inserción de datos: Cliente Jurídico
-- ==============================================
INSERT INTO CLIENTE_JURIDICO (cjd_direccion, cjd_url_pagina, cjd_rif, cjd_nombre, cjd_descripcion, fk_lug_id)
VALUES
-- Lara
('Av. Principal, Lara', 'https://www.ultrafly.com', 'J123456825', 'UltraFly', 'Vuelos ultrarrápidos', 13),
('Av. Secundaria, Lara', 'https://www.horizonair.com', 'J123456826', 'Horizon Air', 'Vuelos al horizonte', 13),
('Calle 1, Lara', 'https://www.starwings.com', 'J123456827', 'StarWings', 'Alas estelares', 13),
('Calle 2, Lara', 'https://www.aeroconnect.com', 'J123456828', 'AeroConnect', 'Conexión aérea', 13),

-- La Guaira
('Av. Principal, La Guaira', 'https://www.airplanet.com', 'J123456821', 'AirPlanet', 'Vuelos planetarios', 14),
('Av. Secundaria, La Guaira', 'https://www.skylimit.com', 'J123456822', 'SkyLimit', 'Sin límites', 14),
('Calle 1, La Guaira', 'https://www.aerodream.com', 'J123456823', 'AeroDream', 'Sueños aéreos', 14),
('Calle 2, La Guaira', 'https://www.spaceconnect.com', 'J123456824', 'SpaceConnect', 'Conexión espacial', 14),

-- Mérida
('Av. Principal, Mérida', 'https://www.volareair.com', 'J123456781', 'Volare Air', 'Servicio de vuelos', 15),
('Av. Secundaria, Mérida', 'https://www.surairlines.com', 'J123456782', 'Sur Airlines', 'Viajes regionales', 15),
('Calle 1, Mérida', 'https://www.aeromaster.com', 'J123456783', 'AeroMaster', 'Pasajeros y carga', 15),
('Calle 2, Mérida', 'https://www.skyconnect.com', 'J123456784', 'SkyConnect', 'Conexión aérea', 15),

-- Miranda
('Av. Principal, Miranda', 'https://www.globalfly.com', 'J123456785', 'Global Fly', 'Servicios globales', 16),
('Av. Secundaria, Miranda', 'https://www.royalwings.com', 'J123456786', 'Royal Wings', 'Vuelos lujosos', 16),
('Calle 1, Miranda', 'https://www.cloudjets.com', 'J123456787', 'CloudJets', 'Vuelos rápidos', 16),
('Calle 2, Miranda', 'https://www.eagleairways.com', 'J123456788', 'Eagle Airways', 'Servicio de vuelos', 16),

-- Monagas
('Av. Principal, Monagas', 'https://www.freedomair.com', 'J123456789', 'Freedom Air', 'Viajes sin límites', 17),
('Av. Secundaria, Monagas', 'https://www.sunrisejets.com', 'J123456790', 'Sunrise Jets', 'Vuelos al amanecer', 17),
('Calle 1, Monagas', 'https://www.expressflights.com', 'J123456791', 'Express Flights', 'Rutas express', 17),
('Calle 2, Monagas', 'https://www.galaxyairlines.com', 'J123456792', 'Galaxy Airlines', 'Viajes interplanetarios', 17),

-- Nueva Esparta
('Av. Principal, Nueva Esparta', 'https://www.starconnect.com', 'J123456793', 'Star Connect', 'Conexión de estrellas', 18),
('Av. Secundaria, Nueva Esparta', 'https://www.aerostar.com', 'J123456794', 'AeroStar', 'Vuelos económicos', 18),
('Calle 1, Nueva Esparta', 'https://www.bluewings.com', 'J123456795', 'Blue Wings', 'Aventuras aéreas', 18),
('Calle 2, Nueva Esparta', 'https://www.jetstream.com', 'J123456796', 'JetStream', 'Vuelos rápidos', 18),

-- Portuguesa
('Av. Principal, Portuguesa', 'https://www.flyhigh.com', 'J123456797', 'Fly High', 'Vuelos nacionales', 19),
('Av. Secundaria, Portuguesa', 'https://www.silverair.com', 'J123456798', 'Silver Air', 'Vuelos seguros', 19),
('Calle 1, Portuguesa', 'https://www.swiftairways.com', 'J123456799', 'Swift Airways', 'Vuelos rápidos', 19),
('Calle 2, Portuguesa', 'https://www.unitedjets.com', 'J123456800', 'United Jets', 'Servicio de calidad', 19),

-- Sucre
('Av. Principal, Sucre', 'https://www.southwings.com', 'J123456801', 'South Wings', 'Vuelos regionales', 20),
('Av. Secundaria, Sucre', 'https://www.oceanicair.com', 'J123456802', 'Oceanic Air', 'Viajes costeros', 20),
('Calle 1, Sucre', 'https://www.orbitair.com', 'J123456803', 'Orbit Air', 'Vuelos espaciales', 20),
('Calle 2, Sucre', 'https://www.skylinejets.com', 'J123456804', 'Skyline Jets', 'Vuelos rápidos', 20),

-- Táchira
('Av. Principal, Táchira', 'https://www.flydream.com', 'J123456805', 'Fly Dream', 'Sueños voladores', 21),
('Av. Secundaria, Táchira', 'https://www.pacificair.com', 'J123456806', 'Pacific Air', 'Servicio de vuelos', 21),
('Calle 1, Táchira', 'https://www.northairlines.com', 'J123456807', 'North Airlines', 'Vuelos rápidos', 21),
('Calle 2, Táchira', 'https://www.starline.com', 'J123456808', 'StarLine', 'Servicio estelar', 21),

-- Trujillo
('Av. Principal, Trujillo', 'https://www.windjets.com', 'J123456809', 'WindJets', 'Vuelos económicos', 22),
('Av. Secundaria, Trujillo', 'https://www.sundownair.com', 'J123456810', 'Sundown Air', 'Vuelos nocturnos', 22),
('Calle 1, Trujillo', 'https://www.jupiterair.com', 'J123456811', 'Jupiter Air', 'Vuelos espaciales', 22),
('Calle 2, Trujillo', 'https://www.skybridge.com', 'J123456812', 'SkyBridge', 'Conexión aérea', 22),

-- Yaracuy
('Av. Principal, Yaracuy', 'https://www.galaxyjets.com', 'J123456813', 'Galaxy Jets', 'Rutas galácticas', 23),
('Av. Secundaria, Yaracuy', 'https://www.starfly.com', 'J123456814', 'StarFly', 'Vuelos estelares', 23),
('Calle 1, Yaracuy', 'https://www.jetsetter.com', 'J123456815', 'JetSetter', 'Viajes de lujo', 23),
('Calle 2, Yaracuy', 'https://www.altitudeair.com', 'J123456816', 'Altitude Air', 'Altos vuelos', 23),

-- Zulia
('Av. Principal, Zulia', 'https://www.skytours.com', 'J123456817', 'SkyTours', 'Vuelos turísticos', 24),
('Av. Secundaria, Zulia', 'https://www.nimbusair.com', 'J123456818', 'Nimbus Air', 'Vuelos rápidos', 24),
('Calle 1, Zulia', 'https://www.celestialjets.com', 'J123456819', 'Celestial Jets', 'Vuelos celestiales', 24),
('Calle 2, Zulia', 'https://www.venusexpress.com', 'J123456820', 'Venus Express', 'Viajes al espacio', 24);

-- =================================================
-- Inserción de datos: Teléfonos Clientes Naturales 
-- =================================================
INSERT INTO TELEFONO (tel_codigo_area, tel_numero, fk_per_id, fk_com_id, fk_cjd_id, fk_ctn_id)
VALUES
('+58', '2123456789', NULL, NULL, NULL, 1),
('+58', '4143456790', NULL, NULL, NULL, 2),
('+58', '4163456791', NULL, NULL, NULL, 3),
('+58', '4263456792', NULL, NULL, NULL, 4),
('+58', '2123456793', NULL, NULL, NULL, 5),
('+58', '4143456794', NULL, NULL, NULL, 6),
('+58', '4163456795', NULL, NULL, NULL, 7),
('+58', '4263456796', NULL, NULL, NULL, 8),
('+58', '2123456797', NULL, NULL, NULL, 9),
('+58', '4143456798', NULL, NULL, NULL, 10),
('+58', '4163456799', NULL, NULL, NULL, 11),
('+58', '4263456800', NULL, NULL, NULL, 12),
('+58', '2123456801', NULL, NULL, NULL, 13),
('+58', '4143456802', NULL, NULL, NULL, 14),
('+58', '4163456803', NULL, NULL, NULL, 15),
('+58', '4263456804', NULL, NULL, NULL, 16),
('+58', '2123456805', NULL, NULL, NULL, 17),
('+58', '4143456806', NULL, NULL, NULL, 18),
('+58', '4163456807', NULL, NULL, NULL, 19),
('+58', '4263456808', NULL, NULL, NULL, 20),
('+58', '2123456809', NULL, NULL, NULL, 21),
('+58', '4143456810', NULL, NULL, NULL, 22),
('+58', '4163456811', NULL, NULL, NULL, 23),
('+58', '4263456812', NULL, NULL, NULL, 24),
('+58', '2123456813', NULL, NULL, NULL, 25),
('+58', '4143456814', NULL, NULL, NULL, 26),
('+58', '4163456815', NULL, NULL, NULL, 27),
('+58', '4263456816', NULL, NULL, NULL, 28),
('+58', '2123456817', NULL, NULL, NULL, 29),
('+58', '4143456818', NULL, NULL, NULL, 30),
('+58', '4163456819', NULL, NULL, NULL, 31),
('+58', '4263456820', NULL, NULL, NULL, 32),
('+58', '2123456821', NULL, NULL, NULL, 33),
('+58', '4143456822', NULL, NULL, NULL, 34),
('+58', '4163456823', NULL, NULL, NULL, 35),
('+58', '4263456824', NULL, NULL, NULL, 36),
('+58', '2123456825', NULL, NULL, NULL, 37),
('+58', '4143456826', NULL, NULL, NULL, 38),
('+58', '4163456827', NULL, NULL, NULL, 39),
('+58', '4263456828', NULL, NULL, NULL, 40),
('+58', '2123456829', NULL, NULL, NULL, 41),
('+58', '4143456830', NULL, NULL, NULL, 42),
('+58', '4163456831', NULL, NULL, NULL, 43),
('+58', '4263456832', NULL, NULL, NULL, 44),
('+58', '2123456833', NULL, NULL, NULL, 45),
('+58', '4143456834', NULL, NULL, NULL, 46),
('+58', '4163456835', NULL, NULL, NULL, 47),
('+58', '4263456836', NULL, NULL, NULL, 48);

-- =================================================
-- Inserción de datos: Teléfonos Clientes JURÍDICOS 
-- =================================================
-- Teléfonos para Clientes Jurídicos
INSERT INTO TELEFONO (tel_codigo_area, tel_numero, fk_per_id, fk_com_id, fk_cjd_id, fk_ctn_id)
VALUES
('+58', '2123456790', NULL, NULL, 1, NULL),
('+58', '4143456791', NULL, NULL, 2, NULL),
('+58', '4163456792', NULL, NULL, 3, NULL),
('+58', '4263456793', NULL, NULL, 4, NULL),
('+58', '2123456794', NULL, NULL, 5, NULL),
('+58', '4143456795', NULL, NULL, 6, NULL),
('+58', '4163456796', NULL, NULL, 7, NULL),
('+58', '4263456797', NULL, NULL, 8, NULL),
('+58', '2123456798', NULL, NULL, 9, NULL),
('+58', '4143456799', NULL, NULL, 10, NULL),
('+58', '4163456800', NULL, NULL, 11, NULL),
('+58', '4263456801', NULL, NULL, 12, NULL),
('+58', '2123456802', NULL, NULL, 13, NULL),
('+58', '4143456803', NULL, NULL, 14, NULL),
('+58', '4163456804', NULL, NULL, 15, NULL),
('+58', '4263456805', NULL, NULL, 16, NULL),
('+58', '2123456806', NULL, NULL, 17, NULL),
('+58', '4143456807', NULL, NULL, 18, NULL),
('+58', '4163456808', NULL, NULL, 19, NULL),
('+58', '4263456809', NULL, NULL, 20, NULL),
('+58', '2123456810', NULL, NULL, 21, NULL),
('+58', '4143456811', NULL, NULL, 22, NULL),
('+58', '4163456812', NULL, NULL, 23, NULL),
('+58', '4263456813', NULL, NULL, 24, NULL),
('+58', '2123456814', NULL, NULL, 25, NULL),
('+58', '4143456815', NULL, NULL, 26, NULL),
('+58', '4163456816', NULL, NULL, 27, NULL),
('+58', '4263456817', NULL, NULL, 28, NULL),
('+58', '2123456818', NULL, NULL, 29, NULL),
('+58', '4143456819', NULL, NULL, 30, NULL),
('+58', '4163456820', NULL, NULL, 31, NULL),
('+58', '4263456821', NULL, NULL, 32, NULL),
('+58', '2123456822', NULL, NULL, 33, NULL),
('+58', '4143456823', NULL, NULL, 34, NULL),
('+58', '4163456824', NULL, NULL, 35, NULL),
('+58', '4263456825', NULL, NULL, 36, NULL),
('+58', '2123456826', NULL, NULL, 37, NULL),
('+58', '4143456827', NULL, NULL, 38, NULL),
('+58', '4163456828', NULL, NULL, 39, NULL),
('+58', '4263456829', NULL, NULL, 40, NULL),
('+58', '2123456830', NULL, NULL, 41, NULL),
('+58', '4143456831', NULL, NULL, 42, NULL),
('+58', '4163456832', NULL, NULL, 43, NULL),
('+58', '4263456833', NULL, NULL, 44, NULL),
('+58', '2123456834', NULL, NULL, 45, NULL),
('+58', '4143456835', NULL, NULL, 46, NULL),
('+58', '4163456836', NULL, NULL, 47, NULL),
('+58', '4263456837', NULL, NULL, 48, NULL);

-- =============================================================
-- Inserción de datos: Correos Electrónicos Clientes Naturales
-- =============================================================
INSERT INTO CORREO_ELECTRONICO (cor_dir_correo, fk_per_id, fk_com_id, fk_cjd_id, fk_ctn_id)
VALUES
('juanperez@example.com', NULL, NULL, NULL, 1),
('mariagomez@example.com', NULL, NULL, NULL, 2),
('luisrodriguez@example.com', NULL, NULL, NULL, 3),
('anamartinez@example.com', NULL, NULL, NULL, 4),
('pedrolopez@example.com', NULL, NULL, NULL, 5),
('sofiahernandez@example.com', NULL, NULL, NULL, 6),
('carlosgonzalez@example.com', NULL, NULL, NULL, 7),
('luisadiaz@example.com', NULL, NULL, NULL, 8),
('miguelramirez@example.com', NULL, NULL, NULL, 9),
('isabeltorres@example.com', NULL, NULL, NULL, 10),
('josefernandez@example.com', NULL, NULL, NULL, 11),
('lauramorales@example.com', NULL, NULL, NULL, 12),
('fernandojimenez@example.com', NULL, NULL, NULL, 13),
('andreacastro@example.com', NULL, NULL, NULL, 14),
('rauloortiz@example.com', NULL, NULL, NULL, 15),
('patriciaromero@example.com', NULL, NULL, NULL, 16),
('jorgemartinez@example.com', NULL, NULL, NULL, 17),
('luciafernandez@example.com', NULL, NULL, NULL, 18),
('ricardolopez@example.com', NULL, NULL, NULL, 19),
('martacastro@example.com', NULL, NULL, NULL, 20),
('joseperez@example.com', NULL, NULL, NULL, 21),
('saralopez@example.com', NULL, NULL, NULL, 22),
('robertohernandez@example.com', NULL, NULL, NULL, 23),
('angelamartinez@example.com', NULL, NULL, NULL, 24),
('carlosgomez@example.com', NULL, NULL, NULL, 25),
('juanadominguez@example.com', NULL, NULL, NULL, 26),
('diegolopez@example.com', NULL, NULL, NULL, 27),
('sandrafernandez@example.com', NULL, NULL, NULL, 28),
('juanruiz@example.com', NULL, NULL, NULL, 29),
('mariarodriguez@example.com', NULL, NULL, NULL, 30),
('pedromartinez@example.com', NULL, NULL, NULL, 31),
('analuna@example.com', NULL, NULL, NULL, 32),
('robertolopez@example.com', NULL, NULL, NULL, 33),
('susanagomez@example.com', NULL, NULL, NULL, 34),
('ricardorodriguez@example.com', NULL, NULL, NULL, 35),
('mariaperez@example.com', NULL, NULL, NULL, 36),
('andresmartinez@example.com', NULL, NULL, NULL, 37),
('lauragomez@example.com', NULL, NULL, NULL, 38),
('josegarcia@example.com', NULL, NULL, NULL, 39),
('fernandadiaz@example.com', NULL, NULL, NULL, 40),
('susanafernandez@example.com', NULL, NULL, NULL, 41),
('pablohernandez@example.com', NULL, NULL, NULL, 42),
('alejandrolopez@example.com', NULL, NULL, NULL, 43),
('monicagomez@example.com', NULL, NULL, NULL, 44),
('juancarlos@example.com', NULL, NULL, NULL, 45),
('marialopez@example.com', NULL, NULL, NULL, 46),
('pedrofernandez@example.com', NULL, NULL, NULL, 47),
('anamartinez@example.com', NULL, NULL, NULL, 48);

-- =============================================================
-- Inserción de datos: Correos Electrónicos Clientes Jurídicos
-- =============================================================
INSERT INTO CORREO_ELECTRONICO (cor_dir_correo, fk_per_id, fk_com_id, fk_cjd_id, fk_ctn_id)
VALUES
('ultrafly@example.com', NULL, NULL, 1, NULL),
('horizonair@example.com', NULL, NULL, 2, NULL),
('starwings@example.com', NULL, NULL, 3, NULL),
('aeroconnect@example.com', NULL, NULL, 4, NULL),
('airplanet@example.com', NULL, NULL, 5, NULL),
('skylimit@example.com', NULL, NULL, 6, NULL),
('aerodream@example.com', NULL, NULL, 7, NULL),
('spaceconnect@example.com', NULL, NULL, 8, NULL),
('volareair@example.com', NULL, NULL, 9, NULL),
('surairlines@example.com', NULL, NULL, 10, NULL),
('aeromaster@example.com', NULL, NULL, 11, NULL),
('skyconnect@example.com', NULL, NULL, 12, NULL),
('globalfly@example.com', NULL, NULL, 13, NULL),
('royalwings@example.com', NULL, NULL, 14, NULL),
('cloudjets@example.com', NULL, NULL, 15, NULL),
('eagleairways@example.com', NULL, NULL, 16, NULL),
('freedomair@example.com', NULL, NULL, 17, NULL),
('sunrisejets@example.com', NULL, NULL, 18, NULL),
('expressflights@example.com', NULL, NULL, 19, NULL),
('galaxyairlines@example.com', NULL, NULL, 20, NULL),
('starconnect@example.com', NULL, NULL, 21, NULL),
('aerostar@example.com', NULL, NULL, 22, NULL),
('bluewings@example.com', NULL, NULL, 23, NULL),
('jetstream@example.com', NULL, NULL, 24, NULL),
('flyhigh@example.com', NULL, NULL, 25, NULL),
('silverair@example.com', NULL, NULL, 26, NULL),
('swiftairways@example.com', NULL, NULL, 27, NULL),
('unitedjets@example.com', NULL, NULL, 28, NULL),
('southwings@example.com', NULL, NULL, 29, NULL),
('oceanicair@example.com', NULL, NULL, 30, NULL),
('orbitair@example.com', NULL, NULL, 31, NULL),
('skylinejets@example.com', NULL, NULL, 32, NULL),
('flydream@example.com', NULL, NULL, 33, NULL),
('pacificair@example.com', NULL, NULL, 34, NULL),
('northairlines@example.com', NULL, NULL, 35, NULL),
('starline@example.com', NULL, NULL, 36, NULL),
('windjets@example.com', NULL, NULL, 37, NULL),
('sundownair@example.com', NULL, NULL, 38, NULL),
('jupiterair@example.com', NULL, NULL, 39, NULL),
('skybridge@example.com', NULL, NULL, 40, NULL),
('galaxyjets@example.com', NULL, NULL, 41, NULL),
('starfly@example.com', NULL, NULL, 42, NULL),
('jetsetter@example.com', NULL, NULL, 43, NULL),
('altitudeair@example.com', NULL, NULL, 44, NULL),
('skytours@example.com', NULL, NULL, 45, NULL),
('nimbusair@example.com', NULL, NULL, 46, NULL),
('celestialjets@example.com', NULL, NULL, 47, NULL),
('venusexpress@example.com', NULL, NULL, 48, NULL);

-- ========================================================
-- Inserción de datos: Red Social Clientes Naturales
-- ========================================================
INSERT INTO RED_SOCIAL (res_usuario, fk_per_id, fk_com_id, fk_cjd_id, fk_ctn_id)
VALUES
('@juanperez', NULL, NULL, NULL, 1),
('@mariagomez', NULL, NULL, NULL, 2),
('@luisrodriguez', NULL, NULL, NULL, 3),
('@anamartinez', NULL, NULL, NULL, 4),
('@pedrolopez', NULL, NULL, NULL, 5),
('@sofiahernandez', NULL, NULL, NULL, 6),
('@carlosgonzalez', NULL, NULL, NULL, 7),
('@luisadiaz', NULL, NULL, NULL, 8),
('@miguelramirez', NULL, NULL, NULL, 9),
('@isabeltorres', NULL, NULL, NULL, 10),
('@josefernandez', NULL, NULL, NULL, 11),
('@lauramorales', NULL, NULL, NULL, 12),
('@fernandojimenez', NULL, NULL, NULL, 13),
('@andreacastro', NULL, NULL, NULL, 14),
('@rauloortiz', NULL, NULL, NULL, 15),
('@patriciaromero', NULL, NULL, NULL, 16),
('@jorgemartinez', NULL, NULL, NULL, 17),
('@luciafernandez', NULL, NULL, NULL, 18),
('@ricardolopez', NULL, NULL, NULL, 19),
('@martacastro', NULL, NULL, NULL, 20),
('@joseperez', NULL, NULL, NULL, 21),
('@saralopez', NULL, NULL, NULL, 22),
('@robertohernandez', NULL, NULL, NULL, 23),
('@angelamartinez', NULL, NULL, NULL, 24),
('@carlosgomez', NULL, NULL, NULL, 25),
('@juanadominguez', NULL, NULL, NULL, 26),
('@diegolopez', NULL, NULL, NULL, 27),
('@sandrafernandez', NULL, NULL, NULL, 28),
('@juanruiz', NULL, NULL, NULL, 29),
('@mariarodriguez', NULL, NULL, NULL, 30),
('@pedromartinez', NULL, NULL, NULL, 31),
('@analuna', NULL, NULL, NULL, 32),
('@robertolopez', NULL, NULL, NULL, 33),
('@susanagomez', NULL, NULL, NULL, 34),
('@ricardorodriguez', NULL, NULL, NULL, 35),
('@mariaperez', NULL, NULL, NULL, 36),
('@andresmartinez', NULL, NULL, NULL, 37),
('@lauragomez', NULL, NULL, NULL, 38),
('@josegarcia', NULL, NULL, NULL, 39),
('@fernandadiaz', NULL, NULL, NULL, 40),
('@susanafernandez', NULL, NULL, NULL, 41),
('@pablohernandez', NULL, NULL, NULL, 42),
('@alejandrolopez', NULL, NULL, NULL, 43),
('@monicagomez', NULL, NULL, NULL, 44),
('@juancarlos', NULL, NULL, NULL, 45),
('@marialopez', NULL, NULL, NULL, 46),
('@pedrofernandez', NULL, NULL, NULL, 47),
('@anamartinez', NULL, NULL, NULL, 48);

-- ========================================================
-- Inserción de datos: Red Social Clientes Jurídicos
-- ========================================================
INSERT INTO RED_SOCIAL (res_usuario, fk_per_id, fk_com_id, fk_cjd_id, fk_ctn_id)
VALUES
('@UltraFly', NULL, NULL, 1, NULL),
('@HorizonAir', NULL, NULL, 2, NULL),
('@StarWings', NULL, NULL, 3, NULL),
('@AeroConnect', NULL, NULL, 4, NULL),
('@AirPlanet', NULL, NULL, 5, NULL),
('@SkyLimit', NULL, NULL, 6, NULL),
('@AeroDream', NULL, NULL, 7, NULL),
('@SpaceConnect', NULL, NULL, 8, NULL),
('@VolareAir', NULL, NULL, 9, NULL),
('@SurAirlines', NULL, NULL, 10, NULL),
('@AeroMaster', NULL, NULL, 11, NULL),
('@SkyConnect', NULL, NULL, 12, NULL),
('@GlobalFly', NULL, NULL, 13, NULL),
('@RoyalWings', NULL, NULL, 14, NULL),
('@CloudJets', NULL, NULL, 15, NULL),
('@EagleAirways', NULL, NULL, 16, NULL),
('@FreedomAir', NULL, NULL, 17, NULL),
('@SunriseJets', NULL, NULL, 18, NULL),
('@ExpressFlights', NULL, NULL, 19, NULL),
('@GalaxyAirlines', NULL, NULL, 20, NULL),
('@StarConnect', NULL, NULL, 21, NULL),
('@AeroStar', NULL, NULL, 22, NULL),
('@BlueWings', NULL, NULL, 23, NULL),
('@JetStream', NULL, NULL, 24, NULL),
('@FlyHigh', NULL, NULL, 25, NULL),
('@SilverAir', NULL, NULL, 26, NULL),
('@SwiftAirways', NULL, NULL, 27, NULL),
('@UnitedJets', NULL, NULL, 28, NULL),
('@SouthWings', NULL, NULL, 29, NULL),
('@OceanicAir', NULL, NULL, 30, NULL),
('@OrbitAir', NULL, NULL, 31, NULL),
('@SkylineJets', NULL, NULL, 32, NULL),
('@FlyDream', NULL, NULL, 33, NULL),
('@PacificAir', NULL, NULL, 34, NULL),
('@NorthAirlines', NULL, NULL, 35, NULL),
('@StarLine', NULL, NULL, 36, NULL),
('@WindJets', NULL, NULL, 37, NULL),
('@SundownAir', NULL, NULL, 38, NULL),
('@JupiterAir', NULL, NULL, 39, NULL),
('@SkyBridge', NULL, NULL, 40, NULL),
('@GalaxyJets', NULL, NULL, 41, NULL),
('@StarFly', NULL, NULL, 42, NULL),
('@JetSetter', NULL, NULL, 43, NULL),
('@AltitudeAir', NULL, NULL, 44, NULL),
('@SkyTours', NULL, NULL, 45, NULL),
('@NimbusAir', NULL, NULL, 46, NULL),
('@CelestialJets', NULL, NULL, 47, NULL),
('@VenusExpress', NULL, NULL, 48, NULL);

-- ==============================================
-- Inserción de datos: SOLICITUD_CLIENTE
-- ==============================================
INSERT INTO SOLICITUD_CLIENTE (sct_fecha, sct_total, sct_observacion, fk_ctn_id)
VALUES
-- Solicitudes de Clientes Naturales
('2023-01-15', 5000, 'Solicitud de Juan Pérez', 1),  
('2023-02-10', 7500, 'Solicitud de María Gómez', 2), 
('2023-03-25', 12000, 'Solicitud de Luis Rodríguez', 3),  
('2023-04-05', 8900, 'Solicitud de Ana Martínez', 4);

INSERT INTO SOLICITUD_CLIENTE (sct_fecha, sct_total, sct_observacion, fk_cjd_id)
VALUES
-- Solicitudes de Clientes Jurídicos
('2023-05-18', 15000, 'Solicitud de UltraFly', 1),  
('2023-06-20', 25000, 'Solicitud de Horizon Air', 2),  
('2023-07-12', 18000, 'Solicitud de StarWings', 3),  
('2023-08-22', 21000, 'Solicitud de AeroConnect', 4);  

-- ==============================================
-- Inserción de datos: DETALLE_SLD_CLIENTE
-- ==============================================
INSERT INTO DETALLE_SLD_CLIENTE (ddc_cantidad_aviones, ddc_descripcion, fk_sct_id, fk_mda_id)
VALUES
-- Solicitudes de Clientes Naturales
(2, 'Compra de dos AU-80 para rutas largas.', 1, 1),  
(1, 'Adquisición de un AU-801 para rutas cortas.', 2, 2),  
(3, 'Pedido de tres AU-802A para rutas intermedias.', 3, 6),  
(1, 'Un AU-747Plus para rutas transcontinentales.', 4, 4),

-- Solicitudes de Clientes Jurídicos
(2, 'Compra de dos AU-802F para optimizar rutas.', 5, 11),  
(3, 'Adquisición de tres AU-747Gold para vuelos de larga distancia.', 6, 13),  
(1, 'Pedido de un AU-87ABusiness para transporte empresarial.', 7, 16),  
(2, 'Compra de dos AU-802E para rutas medianas.', 8, 10);


-- ==============================================
-- Inserción de datos: AVION_CREADO
-- ==============================================
INSERT INTO AVION_CREADO (avi_num_serie, avi_fecha_creacion, fk_sct_id)
VALUES 
--Aviones creados para clientes naturales 
('AU-747PLUS-001', '2024-04-09', 4),

--Aviones creados para clientes jurídicos 
('AU-802E-001', '2024-08-31', 8),
('AU-802E-002', '2024-08-31', 8);


