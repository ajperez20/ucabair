import pool from "../config/database";

export const nominaService = {
  getAll: async () => {
    const query = `
        SELECT
            pn.pnn_id as id,
            pn.pnn_fecha_pago as fecha_pago,
            pn.pnn_total_pago as total_pago,
            pn.pnn_descripcion as descripcion,
            e.per_id as empleado_id,
            e.per_dni as empleado_dni,
            e.per_nombre || ' ' || e.per_apellido as empleado_nombre,
            c.car_nombre as cargo
        FROM PAGO_NOMINA pn
                 JOIN EMPLEADO e ON pn.fk_per_id = e.per_id
                 JOIN EMPLEADO_CARGO ec ON e.per_id = ec.fk_per_id
            AND (ec.emc_fecha_fin IS NULL OR ec.emc_fecha_fin > CURRENT_DATE)
                 JOIN CARGO c ON ec.fk_car_id = c.car_id
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
            e.per_id as empleado_id,
            e.per_dni as empleado_dni,
            e.per_nombre || ' ' || e.per_apellido as empleado_nombre,
            c.car_nombre as cargo
        FROM PAGO_NOMINA pn
                 JOIN EMPLEADO e ON pn.fk_per_id = e.per_id
                 JOIN EMPLEADO_CARGO ec ON e.per_id = ec.fk_per_id
            AND (ec.emc_fecha_fin IS NULL OR ec.emc_fecha_fin > CURRENT_DATE)
                 JOIN CARGO c ON ec.fk_car_id = c.car_id
        WHERE pn.pnn_id = $1
    `;
    const result = await pool.query(query, [id]);
    return result.rows[0];
  },

  calcularPago: async (empleadoId) => {
    try {
      const result = await pool.query(
        "SELECT * FROM calcular_pago_empleado($1)",
        [empleadoId],
      );
      return result.rows[0];
    } catch (error) {
      throw new Error(`Error al calcular pago: ${error.message}`);
    }
  },

  registrarPago: async (nomina) => {
    const client = await pool.connect();
    try {
      await client.query("BEGIN");

      const result = await client.query(
        `SELECT registrar_pago_nomina($1, $2, $3, $4, $5, $6) as success`,
        [
          nomina.fecha_pago,
          nomina.total_pago,
          nomina.descripcion,
          nomina.empleado_id,
          nomina.metodo_id || 1,
          nomina.moneda_id || 1,
        ],
      );

      if (!result.rows[0].success) {
        throw new Error("Error al registrar el pago de nómina");
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

  update: async (id, nomina) => {
    const query = `
      UPDATE PAGO_NOMINA SET
        pnn_fecha_pago = $1,
        pnn_descripcion = $2
      WHERE pnn_id = $3
      RETURNING 
        pnn_id as id,
        pnn_fecha_pago as fecha_pago,
        pnn_total_pago as total_pago,
        pnn_descripcion as descripcion
    `;
    const values = [nomina.fecha_pago, nomina.descripcion, id];
    const result = await pool.query(query, values);

    if (result.rows.length === 0) {
      throw new Error("Nómina no encontrada");
    }

    return result.rows[0];
  },

  delete: async (id) => {
    const client = await pool.connect();
    try {
      await client.query("BEGIN");

      // Primero, obtener el empleado_id de la nómina
      const getNominaQuery = `
        SELECT fk_per_id FROM PAGO_NOMINA WHERE pnn_id = $1
      `;
      const nominaResult = await client.query(getNominaQuery, [id]);

      if (nominaResult.rows.length === 0) {
        throw new Error("Nómina no encontrada");
      }

      const empleadoId = nominaResult.rows[0].fk_per_id;

      // Eliminar el pago asociado
      await client.query("DELETE FROM PAGO WHERE fk_pnn_id = $1", [id]);

      // Eliminar la nómina
      await client.query("DELETE FROM PAGO_NOMINA WHERE pnn_id = $1", [id]);

      // Desmarcar las asistencias como pagadas
      await client.query(
        `
        UPDATE ASISTENCIA 
        SET asi_pagada = FALSE
        WHERE fk_per_id = $1 
        AND asi_pagada = TRUE
      `,
        [empleadoId],
      );

      await client.query("COMMIT");
      return true;
    } catch (error) {
      await client.query("ROLLBACK");
      throw error;
    } finally {
      client.release();
    }
  },

  // Métodos auxiliares para obtener información adicional
  getMetodosPago: async () => {
    const query = `
        SELECT
            met_id as id,
            tipo_metodo as nombre
        FROM METODO_PAGO
        ORDER BY tipo_metodo
    `;
    const result = await pool.query(query);
    return result.rows;
  },

  getMonedas: async () => {
    const query = `
        SELECT
            mon_id as id,
            mon_tipo as tipo,
            mon_valor_cambio as valor_cambio
        FROM MONEDA
        WHERE mon_fecha_fin IS NULL
           OR mon_fecha_fin > CURRENT_DATE
        ORDER BY mon_tipo
    `;
    const result = await pool.query(query);
    return result.rows;
  },
};
