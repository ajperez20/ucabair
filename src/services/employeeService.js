import pool from "../config/database";

export const employeeService = {
  getAll: async () => {
    const query = `
        WITH RECURSIVE lugar_jerarquia AS (
            SELECT
                l.lug_id,
                l.lug_nombre,
                CAST(l.lug_nombre AS VARCHAR) as lugar_completo
            FROM lugar l
            WHERE l.fk_lug_id IS NULL

            UNION ALL

            SELECT
                l.lug_id,
                l.lug_nombre,
                CAST(lj.lugar_completo || ' > ' || l.lug_nombre AS VARCHAR)
            FROM lugar l
                     INNER JOIN lugar_jerarquia lj ON l.fk_lug_id = lj.lug_id
        )
        SELECT
            e.per_id,
            e.per_dni,
            e.per_nombre,
            e.per_apellido,
            e.per_direccion,
            e.per_experiencia,
            e.per_fecha_contratacion,
            e.per_profesion,
            e.fk_lug_id,
            l.lug_nombre as lugar,
            lj.lugar_completo,
            c.car_nombre as cargo_actual,
            c.car_id as cargo_id
        FROM empleado e
                 LEFT JOIN lugar l ON e.fk_lug_id = l.lug_id
                 LEFT JOIN lugar_jerarquia lj ON l.lug_id = lj.lug_id
                 LEFT JOIN empleado_cargo ec ON e.per_id = ec.fk_per_id
            AND (ec.emc_fecha_fin IS NULL OR ec.emc_fecha_fin > CURRENT_DATE)
                 LEFT JOIN cargo c ON ec.fk_car_id = c.car_id
        ORDER BY e.per_id
    `;
    const result = await pool.query(query);
    return result.rows;
  },

  getById: async (id) => {
    const query = `
        WITH RECURSIVE lugar_jerarquia AS (
            SELECT
                l.lug_id,
                l.lug_nombre,
                CAST(l.lug_nombre AS VARCHAR) as lugar_completo
            FROM lugar l
            WHERE l.fk_lug_id IS NULL

            UNION ALL

            SELECT
                l.lug_id,
                l.lug_nombre,
                CAST(lj.lugar_completo || ' > ' || l.lug_nombre AS VARCHAR)
            FROM lugar l
                     INNER JOIN lugar_jerarquia lj ON l.fk_lug_id = lj.lug_id
        )
        SELECT
            e.per_id,
            e.per_dni,
            e.per_nombre,
            e.per_apellido,
            e.per_direccion,
            e.per_experiencia,
            e.per_fecha_contratacion,
            e.per_profesion,
            e.fk_lug_id,
            l.lug_nombre as lugar,
            lj.lugar_completo,
            c.car_nombre as cargo_actual,
            c.car_id as cargo_id
        FROM empleado e
                 LEFT JOIN lugar l ON e.fk_lug_id = l.lug_id
                 LEFT JOIN lugar_jerarquia lj ON l.lug_id = lj.lug_id
                 LEFT JOIN empleado_cargo ec ON e.per_id = ec.fk_per_id
            AND (ec.emc_fecha_fin IS NULL OR ec.emc_fecha_fin > CURRENT_DATE)
                 LEFT JOIN cargo c ON ec.fk_car_id = c.car_id
        WHERE e.per_id = $1
    `;
    const result = await pool.query(query, [id]);
    return result.rows[0];
  },

  create: async (empleado) => {
    const query = `
        INSERT INTO empleado (
            per_dni,
            per_nombre,
            per_apellido,
            per_direccion,
            per_experiencia,
            per_profesion,
            fk_lug_id
        ) VALUES ($1, $2, $3, $4, $5, $6, $7)
        RETURNING *
    `;
    const values = [
      empleado.per_dni,
      empleado.per_nombre,
      empleado.per_apellido,
      empleado.per_direccion,
      empleado.per_experiencia,
      empleado.per_profesion,
      empleado.fk_lug_id,
    ];
    const result = await pool.query(query, values);
    return result.rows[0];
  },

  update: async (id, empleado) => {
    const query = `
        UPDATE empleado SET
                            per_dni = $1,
                            per_nombre = $2,
                            per_apellido = $3,
                            per_direccion = $4,
                            per_experiencia = $5,
                            per_profesion = $6,
                            fk_lug_id = $7
        WHERE per_id = $8
        RETURNING *
    `;
    const values = [
      empleado.per_dni,
      empleado.per_nombre,
      empleado.per_apellido,
      empleado.per_direccion,
      empleado.per_experiencia,
      empleado.per_profesion,
      empleado.fk_lug_id,
      id,
    ];
    const result = await pool.query(query, values);
    return result.rows[0];
  },

  delete: async (id) => {
    const query = "DELETE FROM empleado WHERE per_id = $1";
    await pool.query(query, [id]);
    return true;
  },

  // Beneficiarios
  getBeneficiarios: async (empleadoId) => {
    const query = `
        SELECT
            b.ben_id,
            b.ben_dni,
            b.ben_nombre,
            b.ben_apellido,
            b.ben_direccion,
            pb.prb_parentezco as parentesco,
            l.lug_nombre as lugar
        FROM BENEFICIARIO b
                 JOIN PER_BEN pb ON b.ben_id = pb.fk_ben_id
                 LEFT JOIN LUGAR l ON b.fk_lug_id = l.lug_id
        WHERE pb.fk_per_id = $1
    `;
    const result = await pool.query(query, [empleadoId]);
    return result.rows;
  },

  // Experiencia
  getExperiencia: async (empleadoId) => {
    const query = `
        SELECT
            exp_id,
            exp_nombre_empresa,
            exp_fecha_inicio,
            exp_fecha_fin
        FROM EXPERIENCIA
        WHERE fk_per_id = $1
        ORDER BY exp_fecha_inicio DESC
    `;
    const result = await pool.query(query, [empleadoId]);
    return result.rows;
  },

  // Títulos
  getTitulos: async (empleadoId) => {
    const query = `
        SELECT
            t.tit_id,
            t.tit_nombre,
            t.tit_descripcion,
            et.edt_fecha_obtencion,
            et.edt_nombre_universidad
        FROM TITULO t
                 JOIN EMPLEADO_TITULO et ON t.tit_id = et.fk_tit_id
        WHERE et.fk_per_id = $1
        ORDER BY et.edt_fecha_obtencion DESC
    `;
    const result = await pool.query(query, [empleadoId]);
    return result.rows;
  },

  // Cargo y Horarios
  getCargoHorario: async (id) => {
    const query = `
      SELECT 
        ec.fk_car_id as cargo_id,
        c.car_nombre as cargo_nombre,
        ec.emc_id,
        COALESCE(
          json_agg(
            json_build_object(
              'id', h.hor_id,
              'dia', h.hor_dia,
              'hora_inicio', h.hor_hora_inicio,
              'hora_fin', h.hor_hora_fin
            )
          ) FILTER (WHERE h.hor_id IS NOT NULL),
          '[]'
        ) as horarios
      FROM EMPLEADO_CARGO ec
      LEFT JOIN CARGO c ON ec.fk_car_id = c.car_id
      LEFT JOIN EMP_CARGO_HORARIO ech ON ec.fk_per_id = ech.fk_per_id 
        AND ec.fk_car_id = ech.fk_car_id
        AND ec.emc_id = ech.fk_emc_id
      LEFT JOIN HORARIO h ON ech.fk_hor_id = h.hor_id
      WHERE ec.fk_per_id = $1 
        AND (ec.emc_fecha_fin IS NULL OR ec.emc_fecha_fin > CURRENT_DATE)
      GROUP BY ec.fk_car_id, c.car_nombre, ec.emc_id
    `;
    const result = await pool.query(query, [id]);
    return result.rows[0] || { cargo_id: null, horarios: [] };
  },

  updateCargoHorario: async (id, { cargo_id, horarios_ids }) => {
    const client = await pool.connect();
    try {
      await client.query("BEGIN");

      // 1. Finalizar cargo actual si existe
      await client.query(
        `
        UPDATE EMPLEADO_CARGO 
        SET emc_fecha_fin = CURRENT_DATE 
        WHERE fk_per_id = $1 
          AND emc_fecha_fin IS NULL
      `,
        [id],
      );

      // 2. Insertar nuevo cargo
      const cargoResult = await client.query(
        `
        INSERT INTO EMPLEADO_CARGO (
          fk_per_id, 
          fk_car_id, 
          emc_fecha_inicio,
          emc_fecha_fin
        ) VALUES ($1, $2, CURRENT_DATE, NULL)
        RETURNING emc_id
      `,
        [id, cargo_id],
      );

      const emc_id = cargoResult.rows[0].emc_id;

      // 3. Eliminar horarios anteriores
      await client.query(
        `
        DELETE FROM EMP_CARGO_HORARIO 
        WHERE fk_per_id = $1
      `,
        [id],
      );

      // 4. Insertar nuevos horarios
      for (const horario_id of horarios_ids) {
        await client.query(
          `
          INSERT INTO EMP_CARGO_HORARIO (
            fk_per_id, 
            fk_car_id, 
            fk_emc_id,
            fk_hor_id
          ) VALUES ($1, $2, $3, $4)
        `,
          [id, cargo_id, emc_id, horario_id],
        );
      }

      await client.query("COMMIT");
      return { success: true };
    } catch (error) {
      await client.query("ROLLBACK");
      throw error;
    } finally {
      client.release();
    }
  },

  // Horarios
  getHorarios: async (empleadoId) => {
    const query = `
      SELECT 
        h.hor_id as id,
        h.hor_dia as dia,
        h.hor_hora_inicio as hora_inicio,
        h.hor_hora_fin as hora_fin
      FROM HORARIO h
      JOIN EMP_CARGO_HORARIO ech ON h.hor_id = ech.fk_hor_id
      WHERE ech.fk_per_id = $1
    `;
    const result = await pool.query(query, [empleadoId]);
    return result.rows;
  },

  getHorariosDisponibles: async (id) => {
    const query = `
      SELECT 
        ech.fk_per_id,
        ech.fk_car_id,
        ech.fk_emc_id,
        ech.fk_hor_id,
        c.car_nombre,
        CURRENT_DATE as fecha,
        h.hor_dia,
        h.hor_hora_inicio,
        h.hor_hora_fin
      FROM EMPLEADO_CARGO ec
      JOIN CARGO c ON ec.fk_car_id = c.car_id
      JOIN EMP_CARGO_HORARIO ech ON ec.fk_per_id = ech.fk_per_id 
        AND ec.fk_car_id = ech.fk_car_id
        AND ec.emc_id = ech.fk_emc_id
      JOIN HORARIO h ON ech.fk_hor_id = h.hor_id
      WHERE ec.fk_per_id = $1 
        AND (ec.emc_fecha_fin IS NULL OR ec.emc_fecha_fin > CURRENT_DATE)
        AND NOT EXISTS (
          SELECT 1 
          FROM ASISTENCIA a 
          WHERE a.fk_per_id = ech.fk_per_id
            AND a.fk_car_id = ech.fk_car_id
            AND a.fk_emc_id = ech.fk_emc_id
            AND a.fk_hor_id = ech.fk_hor_id
            AND a.asi_hora_inicio::date = CURRENT_DATE
        )
      ORDER BY h.hor_hora_inicio
    `;

    const result = await pool.query(query, [id]);
    return result.rows;
  },
};
