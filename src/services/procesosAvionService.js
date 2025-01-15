import pool from "../config/database";

export const procesosAvionService = {
  getAll: async () => {
    const query = `
      SELECT 
        epv_id as id,
        epv_nombre_proceso as nombre,
        epv_tiempo_estimado as tiempo_estimado,
        epv_descripcion as descripcion
      FROM PROCESO_ENSAMBLE_AVION_CONF
      ORDER BY epv_nombre_proceso
    `;
    const result = await pool.query(query);
    return result.rows;
  },

  getByModeloId: async (modeloId) => {
    const query = `
      SELECT 
        p.epv_id as id,
        p.epv_nombre_proceso as nombre,
        p.epv_tiempo_estimado as tiempo_estimado,
        p.epv_descripcion as descripcion,
        f.fk_epv_id as proceso_id
      FROM PROCESO_ENSAMBLE_AVION_CONF p
      JOIN FASE_ENSAMBLE_AVION_CONF f ON p.epv_id = f.fk_epv_id
      WHERE f.fk_mda_id = $1
    `;
    const result = await pool.query(query, [modeloId]);
    return result.rows;
  },

  updateModeloProcesos: async (modeloId, procesos) => {
    const client = await pool.connect();
    try {
      await client.query("BEGIN");

      // Eliminar procesos existentes
      await client.query(
        "DELETE FROM FASE_ENSAMBLE_AVION_CONF WHERE fk_mda_id = $1",
        [modeloId],
      );

      // Insertar nuevos procesos
      const insertQuery = `
        INSERT INTO FASE_ENSAMBLE_AVION_CONF (
          fk_mda_id,
          fk_epv_id
        ) VALUES ($1, $2, $3)
      `;

      for (const proceso of procesos) {
        await client.query(insertQuery, [
          modeloId,
          proceso.proceso_id,
          proceso.orden,
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
