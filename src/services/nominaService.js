import pool from "../config/database";

export const nominaService = {
  getAll: async () => {
    const query = `
      SELECT 
        pn.pnn_id as id,
        pn.pnn_fecha_pago as fecha_pago,
        pn.pnn_total_pago as total_pago,
        pn.pnn_descripcion as descripcion,
        e.per_dni as empleado_dni,
        e.per_nombre || ' ' || e.per_apellido as empleado_nombre,
        c.car_nombre as cargo,
        a.asi_hora_inicio as hora_inicio,
        a.asi_hora_fin as hora_fin
      FROM PAGO_NOMINA pn
      JOIN ASISTENCIA a ON pn.fk_asi = a.asi_id
      JOIN EMP_CARGO_HORARIO ech ON a.fk_per_id = ech.fk_per_id 
        AND a.fk_car_id = ech.fk_car_id 
        AND a.fk_emc_id = ech.fk_emc_id 
        AND a.fk_hor_id = ech.fk_hor_id
      JOIN EMPLEADO e ON ech.fk_per_id = e.per_id
      JOIN CARGO c ON ech.fk_car_id = c.car_id
      ORDER BY pn.pnn_fecha_pago DESC
    `;
    const result = await pool.query(query);
    return result.rows;
  },

  getById: async (id) => {
    const query = `
      SELECT 
        pn.pnn_id as id,
        pn.pnn_fecha_pago as fecha_pago,
        pn.pnn_total_pago as total_pago,
        pn.pnn_descripcion as descripcion,
        e.per_dni as empleado_dni,
        e.per_nombre || ' ' || e.per_apellido as empleado_nombre,
        c.car_nombre as cargo,
        a.asi_hora_inicio as hora_inicio,
        a.asi_hora_fin as hora_fin
      FROM PAGO_NOMINA pn
      JOIN ASISTENCIA a ON pn.fk_asi = a.asi_id
      JOIN EMP_CARGO_HORARIO ech ON a.fk_per_id = ech.fk_per_id 
        AND a.fk_car_id = ech.fk_car_id 
        AND a.fk_emc_id = ech.fk_emc_id 
        AND a.fk_hor_id = ech.fk_hor_id
      JOIN EMPLEADO e ON ech.fk_per_id = e.per_id
      JOIN CARGO c ON ech.fk_car_id = c.car_id
      WHERE pn.pnn_id = $1
    `;
    const result = await pool.query(query, [id]);
    return result.rows[0];
  },

  getAsistencias: async () => {
    const query = `
      SELECT 
        a.asi_id,
        e.per_dni,
        e.per_nombre || ' ' || e.per_apellido as empleado_nombre,
        c.car_nombre as cargo,
        h.hor_dia as dia,
        a.asi_hora_inicio,
        a.asi_hora_fin
      FROM ASISTENCIA a
      JOIN EMP_CARGO_HORARIO ech ON a.fk_per_id = ech.fk_per_id 
        AND a.fk_car_id = ech.fk_car_id 
        AND a.fk_emc_id = ech.fk_emc_id 
        AND a.fk_hor_id = ech.fk_hor_id
      JOIN EMPLEADO e ON ech.fk_per_id = e.per_id
      JOIN CARGO c ON ech.fk_car_id = c.car_id
      JOIN HORARIO h ON ech.fk_hor_id = h.hor_id
      WHERE a.asi_id NOT IN (SELECT fk_asi FROM PAGO_NOMINA)
      ORDER BY a.asi_hora_inicio DESC
    `;
    const result = await pool.query(query);
    return result.rows;
  },

  create: async (nomina) => {
    const query = `
      INSERT INTO PAGO_NOMINA (
        pnn_fecha_pago,
        pnn_total_pago,
        pnn_descripcion,
        fk_asi
      ) VALUES ($1, $2, $3, $4)
      RETURNING 
        pnn_id as id,
        pnn_fecha_pago as fecha_pago,
        pnn_total_pago as total_pago,
        pnn_descripcion as descripcion
    `;
    const values = [
      nomina.fecha_pago,
      nomina.total_pago,
      nomina.descripcion,
      nomina.asistencia_id,
    ];
    const result = await pool.query(query, values);
    return result.rows[0];
  },

  update: async (id, nomina) => {
    const query = `
      UPDATE PAGO_NOMINA SET
        pnn_fecha_pago = $1,
        pnn_total_pago = $2,
        pnn_descripcion = $3
      WHERE pnn_id = $4
      RETURNING 
        pnn_id as id,
        pnn_fecha_pago as fecha_pago,
        pnn_total_pago as total_pago,
        pnn_descripcion as descripcion
    `;
    const values = [
      nomina.fecha_pago,
      nomina.total_pago,
      nomina.descripcion,
      id,
    ];
    const result = await pool.query(query, values);
    return result.rows[0];
  },

  delete: async (id) => {
    const query = "DELETE FROM PAGO_NOMINA WHERE pnn_id = $1";
    await pool.query(query, [id]);
    return true;
  },
};
