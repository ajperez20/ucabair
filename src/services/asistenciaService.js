import pool from "../config/database";

export const asistenciaService = {
  getAsistencias: async () => {
    const query = `
        SELECT
            a.asi_id,
            e.per_dni,
            e.per_nombre || ' ' || e.per_apellido as empleado_nombre,
            c.car_nombre as cargo,
            h.hor_dia as dia,
            a.asi_hora_inicio,
            a.asi_hora_fin,
            a.asi_pagada
        FROM ASISTENCIA a
                 JOIN EMP_CARGO_HORARIO ech ON a.fk_per_id = ech.fk_per_id
            AND a.fk_car_id = ech.fk_car_id
            AND a.fk_emc_id = ech.fk_emc_id
            AND a.fk_hor_id = ech.fk_hor_id
                 JOIN EMPLEADO e ON ech.fk_per_id = e.per_id
                 JOIN CARGO c ON ech.fk_car_id = c.car_id
                 JOIN HORARIO h ON ech.fk_hor_id = h.hor_id
        ORDER BY a.asi_hora_inicio DESC
    `;
    const result = await pool.query(query);
    return result.rows;
  },

  getAsistenciasSinPagar: async () => {
    const query = `
        SELECT
            a.asi_id,
            e.per_dni,
            e.per_nombre || ' ' || e.per_apellido as empleado_nombre,
            c.car_nombre as cargo,
            h.hor_dia as dia,
            a.asi_hora_inicio,
            a.asi_hora_fin,
            a.asi_pagada
        FROM ASISTENCIA a
                 JOIN EMP_CARGO_HORARIO ech ON a.fk_per_id = ech.fk_per_id
            AND a.fk_car_id = ech.fk_car_id
            AND a.fk_emc_id = ech.fk_emc_id
            AND a.fk_hor_id = ech.fk_hor_id
                 JOIN EMPLEADO e ON ech.fk_per_id = e.per_id
                 JOIN CARGO c ON ech.fk_car_id = c.car_id
                 JOIN HORARIO h ON ech.fk_hor_id = h.hor_id
        WHERE a.asi_pagada = FALSE
          AND a.asi_hora_fin IS NOT NULL
        ORDER BY a.asi_hora_inicio DESC
    `;
    const result = await pool.query(query);
    return result.rows;
  },

  createAsistencia: async (asistencia) => {
    const query = `
        INSERT INTO ASISTENCIA (
            asi_hora_inicio,
            fk_per_id,
            fk_car_id,
            fk_emc_id,
            fk_hor_id,
            asi_pagada
        )
        VALUES ($1, $2, $3, $4, $5, FALSE)
        RETURNING asi_id
    `;

    const values = [
      asistencia.asi_hora_inicio,
      asistencia.fk_per_id,
      asistencia.fk_car_id,
      asistencia.fk_emc_id,
      asistencia.fk_hor_id,
    ];

    const result = await pool.query(query, values);
    return await asistenciaService.getAsistenciaById(result.rows[0].asi_id);
  },

  updateAsistencia: async (id, asistencia) => {
    const query = `
        UPDATE ASISTENCIA
        SET asi_hora_fin = $1
        WHERE asi_id = $2
        RETURNING asi_id
    `;

    const values = [asistencia.asi_hora_fin, id];
    const result = await pool.query(query, values);
    return await asistenciaService.getAsistenciaById(result.rows[0].asi_id);
  },

  getAsistenciaById: async (id) => {
    const query = `
      SELECT 
        a.asi_id,
        e.per_dni,
        e.per_nombre || ' ' || e.per_apellido as empleado_nombre,
        c.car_nombre as cargo,
        h.hor_dia as dia,
        a.asi_hora_inicio,
        a.asi_hora_fin,
        a.asi_pagada,
        a.fk_per_id,
        a.fk_car_id,
        a.fk_emc_id,
        a.fk_hor_id
      FROM ASISTENCIA a
      JOIN EMP_CARGO_HORARIO ech ON a.fk_per_id = ech.fk_per_id 
        AND a.fk_car_id = ech.fk_car_id 
        AND a.fk_emc_id = ech.fk_emc_id 
        AND a.fk_hor_id = ech.fk_hor_id
      JOIN EMPLEADO e ON ech.fk_per_id = e.per_id
      JOIN CARGO c ON ech.fk_car_id = c.car_id
      JOIN HORARIO h ON ech.fk_hor_id = h.hor_id
      WHERE a.asi_id = $1
    `;

    const result = await pool.query(query, [id]);
    return result.rows[0];
  },

  getAsistenciasPorEmpleado: async (empleadoId) => {
    const query = `
      SELECT 
        a.asi_id,
        e.per_dni,
        e.per_nombre || ' ' || e.per_apellido as empleado_nombre,
        c.car_nombre as cargo,
        h.hor_dia as dia,
        a.asi_hora_inicio,
        a.asi_hora_fin,
        a.asi_pagada
      FROM ASISTENCIA a
      JOIN EMP_CARGO_HORARIO ech ON a.fk_per_id = ech.fk_per_id 
        AND a.fk_car_id = ech.fk_car_id 
        AND a.fk_emc_id = ech.fk_emc_id 
        AND a.fk_hor_id = ech.fk_hor_id
      JOIN EMPLEADO e ON ech.fk_per_id = e.per_id
      JOIN CARGO c ON ech.fk_car_id = c.car_id
      JOIN HORARIO h ON ech.fk_hor_id = h.hor_id
      WHERE a.fk_per_id = $1
      ORDER BY a.asi_hora_inicio DESC
    `;

    const result = await pool.query(query, [empleadoId]);
    return result.rows;
  },

  marcarComoPagada: async (empleadoId) => {
    const query = `
      UPDATE ASISTENCIA
      SET asi_pagada = TRUE
      WHERE fk_per_id = $1
        AND asi_pagada = FALSE
        AND asi_hora_fin IS NOT NULL
      RETURNING asi_id
    `;

    const result = await pool.query(query, [empleadoId]);
    return result.rows;
  },

  desmarcarComoPagada: async (empleadoId) => {
    const query = `
      UPDATE ASISTENCIA
      SET asi_pagada = FALSE
      WHERE fk_per_id = $1
        AND asi_pagada = TRUE
      RETURNING asi_id
    `;

    const result = await pool.query(query, [empleadoId]);
    return result.rows;
  },
};
