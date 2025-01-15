import pool from "@/config/database";

export const useSolicitudesStatsService = {
  getStats: async () => {
    const client = await pool.connect();
    try {
      // Comenzar transacción
      await client.query("BEGIN");

      // Obtener estadísticas de solicitudes de clientes
      const clientesQuery = `
        SELECT 
          COUNT(*) as total,
          COUNT(*) FILTER (WHERE est_tipo_estatus = 'Pendiente') as pendientes,
          COUNT(*) FILTER (WHERE est_tipo_estatus = 'En proceso') as en_proceso,
          COUNT(*) FILTER (WHERE est_tipo_estatus = 'Completado') as completadas,
          COUNT(*) FILTER (WHERE sct_fecha >= CURRENT_DATE - INTERVAL '7 days') as nuevas
        FROM SOLICITUD_CLIENTE sc
        LEFT JOIN ESTATUS_SCAV escav ON sc.sct_id = escav.fk_sct_id
        LEFT JOIN ESTATUS e ON escav.fk_est_id = e.est_id;
      `;

      // Obtener estadísticas de solicitudes a proveedores
      const proveedoresQuery = `
        SELECT 
          COUNT(*) as total,
          COUNT(*) FILTER (WHERE est_tipo_estatus = 'Pendiente') as pendientes,
          COUNT(*) FILTER (WHERE est_tipo_estatus = 'En proceso') as en_proceso,
          COUNT(*) FILTER (WHERE est_tipo_estatus = 'Completado') as completadas,
          COUNT(*) FILTER (WHERE spr_fecha >= CURRENT_DATE - INTERVAL '7 days') as nuevas
        FROM SOLICITUD_PROVEEDOR sp
        LEFT JOIN ESTATUS_SSP essp ON sp.spr_id = essp.fk_spr_id
        LEFT JOIN ESTATUS e ON essp.fk_est_id = e.est_id;
      `;

      const [clientesResult, proveedoresResult] = await Promise.all([
        client.query(clientesQuery),
        client.query(proveedoresQuery),
      ]);

      // Commit transacción
      await client.query("COMMIT");

      const clientes = clientesResult.rows[0];
      const proveedores = proveedoresResult.rows[0];

      return {
        total: parseInt(clientes.total) + parseInt(proveedores.total),
        nuevas: parseInt(clientes.nuevas) + parseInt(proveedores.nuevas),
        clientes: {
          total: parseInt(clientes.total),
          pendientes: parseInt(clientes.pendientes),
          en_proceso: parseInt(clientes.en_proceso),
          completadas: parseInt(clientes.completadas),
          nuevas: parseInt(clientes.nuevas),
        },
        proveedores: {
          total: parseInt(proveedores.total),
          pendientes: parseInt(proveedores.pendientes),
          en_proceso: parseInt(proveedores.en_proceso),
          completadas: parseInt(proveedores.completadas),
          nuevas: parseInt(proveedores.nuevas),
        },
      };
    } catch (error) {
      await client.query("ROLLBACK");
      throw error;
    } finally {
      client.release();
    }
  },
};
