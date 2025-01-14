import pool from "../config/database";

export const estatusService = {
  getAllEstados: async () => {
    const query = `
        SELECT
            est_id as id,
            est_tipo_estatus as nombre,
            est_descripcion as descripcion
        FROM ESTATUS
        WHERE est_tipo_estatus IN ('Pendiente', 'En proceso', 'Completado', 'Cancelado')
        ORDER BY
            CASE
                WHEN est_tipo_estatus = 'Pendiente' THEN 1
                WHEN est_tipo_estatus = 'En proceso' THEN 2
                WHEN est_tipo_estatus = 'Completado' THEN 3
                WHEN est_tipo_estatus = 'Cancelado' THEN 4
                ELSE 5
                END
    `;

    const result = await pool.query(query);
    return result.rows;
  },

  getEstadoById: async (id) => {
    const query = `
        SELECT
            est_id as id,
            est_tipo_estatus as nombre,
            est_descripcion as descripcion
        FROM ESTATUS
        WHERE est_id = $1
    `;

    const result = await pool.query(query, [id]);
    return result.rows[0];
  },
};
