import pool from "../config/database";

export const horarioService = {
  getAll: async () => {
    const query = `
        SELECT h.hor_id                      as id,
               h.hor_dia                     as dia,
               h.hor_hora_inicio             as hora_inicio,
               h.hor_hora_fin                as hora_fin,
               COUNT(DISTINCT ech.fk_per_id) as cantidad_empleados
        FROM HORARIO h
                 LEFT JOIN EMP_CARGO_HORARIO ech ON h.hor_id = ech.fk_hor_id
        GROUP BY h.hor_id, h.hor_dia, h.hor_hora_inicio, h.hor_hora_fin
        ORDER BY CASE
                     WHEN UPPER(h.hor_dia) = 'LUNES' THEN 1
                     WHEN UPPER(h.hor_dia) = 'MARTES' THEN 2
                     WHEN UPPER(h.hor_dia) = 'MIERCOLES' THEN 3
                     WHEN UPPER(h.hor_dia) = 'JUEVES' THEN 4
                     WHEN UPPER(h.hor_dia) = 'VIERNES' THEN 5
                     WHEN UPPER(h.hor_dia) = 'SABADO' THEN 6
                     WHEN UPPER(h.hor_dia) = 'DOMINGO' THEN 7
                     END,
                 h.hor_hora_inicio
    `;
    const result = await pool.query(query);
    return result.rows;
  },

  getById: async (id) => {
    const query = `
        SELECT h.hor_id                      as id,
               h.hor_dia                     as dia,
               h.hor_hora_inicio             as hora_inicio,
               h.hor_hora_fin                as hora_fin,
               COUNT(DISTINCT ech.fk_per_id) as cantidad_empleados
        FROM HORARIO h
                 LEFT JOIN EMP_CARGO_HORARIO ech ON h.hor_id = ech.fk_hor_id
        WHERE h.hor_id = $1
        GROUP BY h.hor_id, h.hor_dia, h.hor_hora_inicio, h.hor_hora_fin
    `;
    const result = await pool.query(query, [id]);
    return result.rows[0];
  },

  create: async (horario) => {
    const query = `
        INSERT INTO HORARIO (hor_dia,
                             hor_hora_inicio,
                             hor_hora_fin)
        VALUES ($1, $2, $3)
        RETURNING
            hor_id as id,
            hor_dia as dia,
            hor_hora_inicio as hora_inicio,
            hor_hora_fin as hora_fin
    `;
    const values = [
      horario.dia.toUpperCase(),
      horario.hora_inicio,
      horario.hora_fin,
    ];
    const result = await pool.query(query, values);
    return result.rows[0];
  },

  update: async (id, horario) => {
    const query = `
        UPDATE HORARIO
        SET hor_dia         = $1,
            hor_hora_inicio = $2,
            hor_hora_fin    = $3
        WHERE hor_id = $4
        RETURNING
            hor_id as id,
            hor_dia as dia,
            hor_hora_inicio as hora_inicio,
            hor_hora_fin as hora_fin
    `;
    const values = [
      horario.dia.toUpperCase(),
      horario.hora_inicio,
      horario.hora_fin,
      id,
    ];
    const result = await pool.query(query, values);
    return result.rows[0];
  },

  delete: async (id) => {
    const query = "DELETE FROM HORARIO WHERE hor_id = $1";
    await pool.query(query, [id]);
    return true;
  },
};
