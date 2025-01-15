import pool from "../config/database";

export const piezaModeloService = {
  getByModeloId: async (modeloId) => {
    const query = `
      SELECT 
        ac.fk_mec_id as pieza_id,
        ac.ctm_cantidad_piezas as cantidad,
        ac.fk_epv_id as fase_id,
        mp.mec_nombre_pieza as nombre_pieza,
        p.epv_nombre_proceso as nombre_fase
      FROM AVION_COMPONENTE ac
      JOIN MODELO_PIEZA_CONF mp ON ac.fk_mec_id = mp.mec_id
      JOIN PROCESO_ENSAMBLE_AVION_CONF p ON ac.fk_epv_id = p.epv_id
      WHERE ac.fk_mda_id = $1
      ORDER BY p.epv_nombre_proceso, mp.mec_nombre_pieza
    `;
    const result = await pool.query(query, [modeloId]);
    return result.rows;
  },

  updateModeloPiezas: async (modeloId, piezas) => {
    const client = await pool.connect();
    try {
      await client.query("BEGIN");

      // Eliminar piezas existentes
      await client.query("DELETE FROM AVION_COMPONENTE WHERE fk_mda_id = $1", [
        modeloId,
      ]);

      // Insertar nuevas piezas
      const insertQuery = `
        INSERT INTO AVION_COMPONENTE (
          fk_mda_id,
          fk_mec_id,
          fk_epv_id,
          ctm_cantidad_piezas
        ) VALUES ($1, $2, $3, $4)
      `;

      for (const pieza of piezas) {
        await client.query(insertQuery, [
          modeloId,
          pieza.pieza_id,
          pieza.fase_id,
          pieza.cantidad,
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
