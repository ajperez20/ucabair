-------------------------------------------------------------------------------
-- DROP_TABLES.SQL
-- Elimina las tablas en el orden correcto y de manera agrupada
-------------------------------------------------------------------------------

/* 1. LUGAR (Lugar geográfico) */
DROP TABLE IF EXISTS LUGAR CASCADE;


-------------------------------------------------------------------------------
-- 2. CONFIGURACIÓN DEL PROYECTO
-------------------------------------------------------------------------------
DROP TABLE IF EXISTS MATERIAL_FASE CASCADE;
DROP TABLE IF EXISTS FASE_ENSAMBLE_PIEZA_CONF CASCADE;
DROP TABLE IF EXISTS PROCESO_ENSAMBLE_PIEZA_CONF CASCADE;
DROP TABLE IF EXISTS MATERIAL_PIEZA_CONF CASCADE;
DROP TABLE IF EXISTS MODELO_PIEZA_CARACTERISTICA CASCADE;
DROP TABLE IF EXISTS CARACTERISTICA_PIEZA_CONF CASCADE;
DROP TABLE IF EXISTS FASE_PRUEBA CASCADE;
DROP TABLE IF EXISTS MODELO_PRUEBA CASCADE;
DROP TABLE IF EXISTS PRUEBA_CONF CASCADE;
DROP TABLE IF EXISTS AVION_COMPONENTE CASCADE;
DROP TABLE IF EXISTS TIPO_PIEZA_CONF CASCADE;
DROP TABLE IF EXISTS TIPO_PIEZA_CONF_COMPOSICION CASCADE;
DROP TABLE IF EXISTS MODELO_PIEZA_CONF CASCADE;
DROP TABLE IF EXISTS FASE_ENSAMBLE_AVION_CONF CASCADE;
DROP TABLE IF EXISTS PROCESO_ENSAMBLE_AVION_CONF CASCADE;
DROP TABLE IF EXISTS MODELO_AVION_CARACTERISTICA CASCADE;
DROP TABLE IF EXISTS MODELO_AVION_CONF CASCADE;
DROP TABLE IF EXISTS CARACTERISTICA_ANV_CONF CASCADE;
DROP TABLE IF EXISTS TIPO_AVION CASCADE;
DROP TABLE IF EXISTS MATERIA_PRIMA CASCADE;

-------------------------------------------------------------------------------
-- 3. EJECUCIÓN DEL PROYECTO
-------------------------------------------------------------------------------
DROP TABLE IF EXISTS ESTATUS_PPS CASCADE;
DROP TABLE IF EXISTS PRUEBA_PIEZA_SEDE CASCADE;
DROP TABLE IF EXISTS PIEZA_STOCK CASCADE;
DROP TABLE IF EXISTS ESTATUS_PPEM CASCADE;
DROP TABLE IF EXISTS ENSAMBLE_MATERIAL_PRUEBA CASCADE;
DROP TABLE IF EXISTS ESTATUS_SME CASCADE;
DROP TABLE IF EXISTS ENSAMBLE_SOLICITUD_MATERIA CASCADE;
DROP TABLE IF EXISTS ESTATUS_FEP CASCADE;
DROP TABLE IF EXISTS FASE_ENSAMBLE_PIEZA CASCADE;
DROP TABLE IF EXISTS PROCESO_ENSAMBLE_PIEZA_EJEC CASCADE;
DROP TABLE IF EXISTS ESTATUS_PMS CASCADE;
DROP TABLE IF EXISTS SEDE_MATERIAL_PRUEBA CASCADE;
DROP TABLE IF EXISTS MATERIA_PRIMA_STOCK CASCADE;
DROP TABLE IF EXISTS PRUEBA CASCADE;
DROP TABLE IF EXISTS ESTATUS_FEA CASCADE;
DROP TABLE IF EXISTS FASE_ENSAMBLE_AVION CASCADE;
DROP TABLE IF EXISTS PROCESO_ENSAMBLE_AVION_EJEC CASCADE;
DROP TABLE IF EXISTS ESTATUS_ESP CASCADE;
DROP TABLE IF EXISTS ENSAMBLE_SOLICITUD_PIEZA CASCADE;
DROP TABLE IF EXISTS AVION_CREADO CASCADE;
DROP TABLE IF EXISTS ESTATUS_PP_SOLICITUD CASCADE;
DROP TABLE IF EXISTS PRUEBA_PIEZA_SOLICITUD CASCADE;
DROP TABLE IF EXISTS ESTATUS_SOL_PIEZA CASCADE;
DROP TABLE IF EXISTS DETALLE_SLD_SEDE CASCADE;
DROP TABLE IF EXISTS SOLICITUD_SEDE CASCADE;
DROP TABLE IF EXISTS ESTATUS_SCAV CASCADE;
DROP TABLE IF EXISTS SOLICITUD_CLIENTE CASCADE;
DROP TABLE IF EXISTS CLIENTE_JURIDICO CASCADE;
DROP TABLE IF EXISTS CLIENTE_NATURAL CASCADE;
DROP TABLE IF EXISTS DETALLE_SLD_CLIENTE CASCADE;
DROP TABLE IF EXISTS ZONA CASCADE;
DROP TABLE IF EXISTS AREA CASCADE;
DROP TABLE IF EXISTS SEDE_PLANTA CASCADE;
DROP TABLE IF EXISTS ESTATUS CASCADE;
DROP TRIGGER IF EXISTS cantidad_minima_stock ON MATERIA_PRIMA_STOCK;
DROP FUNCTION IF EXISTS verificar_cantidad_stock();
DROP TRIGGER IF EXISTS crear_solicitud_proveedor ON MATERIA_PRIMA_STOCK;
DROP FUNCTION IF EXISTS enviar_solicitud_proveedor();
DROP TRIGGER IF EXISTS crear_solicitud_materia ON ENSAMBLE_SOLICITUD_MATERIA;
DROP FUNCTION IF EXISTS verificar_cantidad_solicitada();
DROP TRIGGER IF EXISTS enviar_solicitud_materia ON ENSAMBLE_SOLICITUD_MATERIA;
DROP FUNCTION IF EXISTS actualizar_stock_materia();
DROP TRIGGER IF EXISTS crear_detalle_solicitud_proveedor ON SOLICITUD_PROVEEDOR;
DROP FUNCTION IF EXISTS detalle_solicitud_proveedor();
DROP TRIGGER IF EXISTS cambio_estatus_ssp ON ESTATUS_SSP;
DROP FUNCTION IF EXISTS actualizar_cantidad_stock();
-------------------------------------------------------------------------------
-- 4. USUARIOS (PARTE DE EMPLEADOS)
-------------------------------------------------------------------------------
DROP TABLE IF EXISTS EQUIPO_ENCARGADO CASCADE;
DROP TABLE IF EXISTS EXPERIENCIA CASCADE;
DROP TABLE IF EXISTS PER_BEN CASCADE;
DROP TABLE IF EXISTS BENEFICIARIO CASCADE;
DROP TABLE IF EXISTS EMPLEADO_TITULO CASCADE;
DROP TABLE IF EXISTS TITULO CASCADE;
DROP TABLE IF EXISTS EMPLEADO CASCADE;


-------------------------------------------------------------------------------
-- 5. (YA CUBIERTO EN LA SECCIÓN EJECUCIÓN Y CLIENTES) 
-- (No hay tablas adicionales específicas que no estén en la sección 3 o 4)
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- 6. PROVEEDORES
-------------------------------------------------------------------------------
DROP TABLE IF EXISTS DETALLE_SLD_PROVEEDOR CASCADE;
DROP TABLE IF EXISTS SOLICITUD_PROVEEDOR CASCADE;
DROP TABLE IF EXISTS ESTATUS_SSP CASCADE;
DROP TABLE IF EXISTS PROVEEDOR CASCADE;
DROP TABLE IF EXISTS PROVEEDOR_MP_STOCK CASCADE;


-------------------------------------------------------------------------------
-- 7. CARGOS, HORARIOS, NÓMINAS
-------------------------------------------------------------------------------
DROP TABLE IF EXISTS ASISTENCIA CASCADE;
DROP TABLE IF EXISTS EMP_CARGO_HORARIO CASCADE;
DROP TABLE IF EXISTS HORARIO CASCADE;
DROP TABLE IF EXISTS EMPLEADO_CARGO CASCADE;
DROP TABLE IF EXISTS CARGO CASCADE;
DROP TABLE IF EXISTS PAGO_NOMINA CASCADE;


-------------------------------------------------------------------------------
-- 8. DATOS DE CONTACTO
-------------------------------------------------------------------------------
DROP TABLE IF EXISTS CORREO_ELECTRONICO CASCADE;
DROP TABLE IF EXISTS TELEFONO CASCADE;
DROP TABLE IF EXISTS RED_SOCIAL CASCADE;


-------------------------------------------------------------------------------
-- 9. SISTEMA DE PRIVILEGIOS Y USUARIOS
-------------------------------------------------------------------------------
DROP TABLE IF EXISTS USUARIO CASCADE;
DROP TABLE IF EXISTS PRIVILEGIO_ROL CASCADE;
DROP TABLE IF EXISTS ROL CASCADE;
DROP TABLE IF EXISTS PRIVILEGIO CASCADE;


-------------------------------------------------------------------------------
-- 10. PAGOS
-------------------------------------------------------------------------------
DROP TABLE IF EXISTS PAGO CASCADE;
DROP TABLE IF EXISTS MONEDA CASCADE;
DROP TABLE IF EXISTS METODO_PAGO CASCADE;


-------------------------------------------------------------------------------
--  FIN DROP_TABLES.SQL
-------------------------------------------------------------------------------

