import pool from "../config/database";
import { caracteristicasAvionService } from "./caracteristicasAvionService";

export const modeloAvionService = {
  getAll: async () => {
    const query = `
        SELECT
            mac.mda_id as id,
            mac.mda_nombre as nombre,
            mac.mda_descripcion as descripcion,
            mac.mda_precio as precio,
            ta.tiv_id as tipo_id,
            ta.tiv_nombre as tipo_nombre,
            COUNT(DISTINCT ac.fk_epv_id) as cantidad_procesos,
            COUNT(DISTINCT fp.fk_prc_id) as cantidad_pruebas,
            COUNT(DISTINCT mnc.fk_pvv_id) as cantidad_caracteristicas
        FROM modelo_avion_conf mac
                 LEFT JOIN tipo_avion ta ON mac.fk_tiv_id = ta.tiv_id
                 LEFT JOIN fase_ensamble_avion_conf ac ON mac.mda_id = ac.fk_mda_id
                 LEFT JOIN fase_prueba fp ON mac.mda_id = fp.fk_mda_id
                 LEFT JOIN modelo_avion_caracteristica mnc ON mac.mda_id = mnc.fk_mda_id
        GROUP BY
            mac.mda_id,
            mac.mda_nombre,
            mac.mda_descripcion,
            mac.mda_precio,
            ta.tiv_id,
            ta.tiv_nombre
        ORDER BY mac.mda_nombre
    `;

    const result = await pool.query(query);
    return result.rows;
  },

  getById: async (id) => {
    // Obtener el modelo y sus características en paralelo
    const [modeloResult, caracteristicas] = await Promise.all([
      pool.query(
        `
          SELECT 
            mac.mda_id as id,
            mac.mda_nombre as nombre,
            mac.mda_descripcion as descripcion,
            mac.mda_precio as precio,
            mac.fk_tiv_id as tipo_id,
            ta.tiv_nombre as tipo_nombre
          FROM modelo_avion_conf mac
          LEFT JOIN tipo_avion ta ON mac.fk_tiv_id = ta.tiv_id
          WHERE mac.mda_id = $1
        `,
        [id],
      ),
      caracteristicasAvionService.getByModeloId(id),
    ]);

    const modelo = modeloResult.rows[0];
    if (!modelo) return null;

    return {
      ...modelo,
      caracteristicas,
    };
  },

  create: async (modelo) => {
    const client = await pool.connect();

    try {
      await client.query("BEGIN");

      // Insertar el modelo
      const modeloQuery = `
          INSERT INTO modelo_avion_conf (
              mda_nombre,
              mda_descripcion,
              mda_precio,
              fk_tiv_id
          )
          VALUES ($1, $2, $3, $4)
          RETURNING
              mda_id as id,
              mda_nombre as nombre,
              mda_descripcion as descripcion,
              mda_precio as precio,
              fk_tiv_id as tipo_id
      `;

      const modeloValues = [
        modelo.nombre,
        modelo.descripcion,
        modelo.precio,
        modelo.tipo_id,
      ];

      const modeloResult = await client.query(modeloQuery, modeloValues);
      const nuevoModelo = modeloResult.rows[0];

      // Si hay características, insertarlas
      if (modelo.caracteristicas && modelo.caracteristicas.length > 0) {
        const caracteristicasQuery = `
            INSERT INTO modelo_avion_caracteristica (
                fk_mda_id,
                fk_pvv_id,
                mnc_unidad_medida,
                mnc_valor
            )
            VALUES ($1, $2, $3, $4)
        `;

        for (const caract of modelo.caracteristicas) {
          await client.query(caracteristicasQuery, [
            nuevoModelo.id,
            caract.caracteristica_id,
            caract.unidad_medida,
            caract.valor,
          ]);
        }
      }

      await client.query("COMMIT");
      return nuevoModelo;
    } catch (error) {
      await client.query("ROLLBACK");
      throw error;
    } finally {
      client.release();
    }
  },

  update: async (id, modelo) => {
    const client = await pool.connect();

    try {
      await client.query("BEGIN");

      // Actualizar el modelo
      const modeloQuery = `
          UPDATE modelo_avion_conf
          SET
              mda_nombre = $1,
              mda_descripcion = $2,
              mda_precio = $3,
              fk_tiv_id = $4
          WHERE mda_id = $5
          RETURNING
              mda_id as id,
              mda_nombre as nombre,
              mda_descripcion as descripcion,
              mda_precio as precio,
              fk_tiv_id as tipo_id
      `;

      const modeloValues = [
        modelo.nombre,
        modelo.descripcion,
        modelo.precio,
        modelo.tipo_id,
        id,
      ];

      const modeloResult = await client.query(modeloQuery, modeloValues);
      const modeloActualizado = modeloResult.rows[0];

      // Si hay características, actualizar
      if (modelo.caracteristicas) {
        // Eliminar características existentes
        await client.query(
          "DELETE FROM modelo_avion_caracteristica WHERE fk_mda_id = $1",
          [id],
        );

        // Insertar nuevas características
        const caracteristicasQuery = `
            INSERT INTO modelo_avion_caracteristica (
                fk_mda_id,
                fk_pvv_id,
                mnc_unidad_medida,
                mnc_valor
            )
            VALUES ($1, $2, $3, $4)
        `;

        for (const caract of modelo.caracteristicas) {
          await client.query(caracteristicasQuery, [
            id,
            caract.caracteristica_id,
            caract.unidad_medida,
            caract.valor,
          ]);
        }
      }

      await client.query("COMMIT");
      return modeloActualizado;
    } catch (error) {
      await client.query("ROLLBACK");
      throw error;
    } finally {
      client.release();
    }
  },

  delete: async (id) => {
    const query =
      "DELETE FROM modelo_avion_conf WHERE mda_id = $1 RETURNING mda_id as id";
    const result = await pool.query(query, [id]);
    return result.rows[0];
  },
};
