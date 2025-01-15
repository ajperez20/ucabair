import pool from "../config/database";

export const pruebaAvionService = {
  getAll: async () => {
    const query = `
      SELECT 
        prc_id as id,
        prc_nombre_prueba as nombre,
        prc_tiempo_estimado as tiempo_estimado
      FROM PRUEBA_CONF
      ORDER BY prc_nombre_prueba
    `;
    const result = await pool.query(query);
    return result.rows;
  },

  getByModeloId: async (modeloId) => {
    const query = `
      SELECT 
        p.prc_id as id,
        p.prc_nombre_prueba as nombre,
        p.prc_tiempo_estimado as tiempo_estimado,
        fp.fk_prc_id as prueba_id
      FROM PRUEBA_CONF p
      JOIN FASE_PRUEBA fp ON p.prc_id = fp.fk_prc_id
      WHERE fp.fk_mda_id = $1
    `;
    const result = await pool.query(query, [modeloId]);
    return result.rows;
  },

  updateModeloPruebas: async (modeloId, pruebas) => {
    const client = await pool.connect();
    try {
      await client.query("BEGIN");

      // Eliminar pruebas existentes
      await client.query("DELETE FROM FASE_PRUEBA WHERE fk_mda_id = $1", [
        modeloId,
      ]);

      // Insertar nuevas pruebas
      const insertQuery = `
        INSERT INTO FASE_PRUEBA (
          fk_mda_id,
          fk_prc_id
        ) VALUES ($1, $2, $3, $4)
      `;

      for (const prueba of pruebas) {
        await client.query(insertQuery, [
          modeloId,
          prueba.prueba_id,
          prueba.orden,
          prueba.descripcion,
        ]);
      }

      await client.query("COMMIT");
    } catch (error) {
      await client.query("ROLLBACK");
      throw error;
    } finally {
      client.release();
    }
  },
};
