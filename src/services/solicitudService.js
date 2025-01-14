import pool from "../config/database";

export const solicitudService = {
  crearSolicitud: async (solicitud) => {
    const { cliente_id, tipo, modelo_id, cantidad, descripcion } = solicitud;

    const query = `
        SELECT * FROM registrar_solicitud($1, $2, $3, $4, $5)
    `;

    const result = await pool.query(query, [
      cliente_id,
      tipo,
      modelo_id,
      cantidad,
      descripcion,
    ]);

    return result.rows[0];
  },
  // Obtener todas las solicitudes (para administrador)
  obtenerTodasSolicitudes: async () => {
    const query = `
        SELECT
            s.sct_id as id,
            s.sct_fecha as fecha,
            s.sct_total as total,
            s.sct_observacion as descripcion,
            m.mda_nombre as modelo,
            d.ddc_cantidad_aviones as cantidad,
            e.est_id as estado_id,
            e.est_tipo_estatus as estado,
            COALESCE(cn.ctn_nombre || ' ' || cn.ctn_apellido,
                     cj.cjd_nombre) as cliente,
            CASE
                WHEN cn.ctn_id IS NOT NULL THEN 'Natural'
                ELSE 'Jurídico'
                END as tipo_cliente
        FROM SOLICITUD_CLIENTE s
                 JOIN DETALLE_SLD_CLIENTE d ON s.sct_id = d.fk_sct_id
                 JOIN MODELO_AVION_CONF m ON d.fk_mda_id = m.mda_id
                 LEFT JOIN CLIENTE_NATURAL cn ON s.fk_ctn_id = cn.ctn_id
                 LEFT JOIN CLIENTE_JURIDICO cj ON s.fk_cjd_id = cj.cjd_id
                 JOIN LATERAL (
            SELECT e.est_id, e.est_tipo_estatus
            FROM ESTATUS_SCAV sc
                     JOIN ESTATUS e ON sc.fk_est_id = e.est_id
            WHERE sc.fk_sct_id = s.sct_id
            ORDER BY sc.scv_fecha_inicio DESC
            LIMIT 1
            ) e ON true
        ORDER BY s.sct_fecha DESC
    `;

    const result = await pool.query(query);
    return result.rows;
  },

  obtenerSolicitudesPorCliente: async (clienteId, tipo) => {
    const query = `
      SELECT 
        s.sct_id as id,
        s.sct_fecha as fecha,
        s.sct_total as total,
        s.sct_observacion as descripcion,
        m.mda_nombre as modelo,
        d.ddc_cantidad_aviones as cantidad,
        e.est_tipo_estatus as estado
      FROM SOLICITUD_CLIENTE s
      JOIN DETALLE_SLD_CLIENTE d ON s.sct_id = d.fk_sct_id
      JOIN MODELO_AVION_CONF m ON d.fk_mda_id = m.mda_id
      JOIN LATERAL (
        SELECT e.est_id, e.est_tipo_estatus
        FROM ESTATUS_SCAV sc
        JOIN ESTATUS e ON sc.fk_est_id = e.est_id
        WHERE sc.fk_sct_id = s.sct_id
        ORDER BY sc.scv_fecha_inicio DESC
        LIMIT 1
      ) e ON true
      WHERE ${tipo === "JURIDICO" ? "s.fk_cjd_id" : "s.fk_ctn_id"} = $1
      ORDER BY s.sct_fecha DESC
    `;

    const result = await pool.query(query, [clienteId]);
    return result.rows;
  },

  actualizarEstado: async (solicitudId, estadoId) => {
    // Primero, actualizamos la fecha_fin del estado actual
    const updateCurrentQuery = `
        UPDATE ESTATUS_SCAV
        SET scv_fecha_fin = CURRENT_DATE
        WHERE fk_sct_id = $1
          AND scv_fecha_fin IS NULL;
    `;

    // Luego, insertamos el nuevo estado
    const insertNewQuery = `
      INSERT INTO ESTATUS_SCAV (
        scv_fecha_inicio,
        fk_sct_id,
        fk_est_id
      )
      VALUES (CURRENT_DATE, $1, $2)
      RETURNING *;
    `;

    try {
      // Iniciamos una transacción
      await pool.query("BEGIN");

      // Actualizamos el estado actual
      await pool.query(updateCurrentQuery, [solicitudId]);

      // Insertamos el nuevo estado
      const result = await pool.query(insertNewQuery, [solicitudId, estadoId]);

      // Confirmamos la transacción
      await pool.query("COMMIT");

      return result.rows[0];
    } catch (error) {
      // Si hay error, revertimos la transacción
      await pool.query("ROLLBACK");
      throw error;
    }
  },

  obtenerEstadoActual: async (solicitudId) => {
    const query = `
        SELECT
            e.est_id as id,
            e.est_tipo_estatus as nombre,
            e.est_descripcion as descripcion,
            sc.scv_fecha_inicio as fecha_inicio
        FROM ESTATUS_SCAV sc
                 JOIN ESTATUS e ON sc.fk_est_id = e.est_id
        WHERE sc.fk_sct_id = $1
          AND sc.scv_fecha_fin IS NULL;
    `;

    const result = await pool.query(query, [solicitudId]);
    return result.rows[0];
  },
};
