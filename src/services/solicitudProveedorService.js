import pool from "@/config/database";

export const solicitudProveedorService = {
  // Obtener todas las solicitudes (vista de admin)
  getAllSolicitudes: async () => {
    const query = `
      SELECT
        sp.spr_id as id,
        sp.spr_fecha as fecha,
        sp.spr_total as total,
        sp.spr_descripcion as descripcion,
        c.com_nombre as proveedor_nombre,
        s.sed_nombre as sede_nombre,
        mp.rpm_nombre as materia_prima_nombre,
        COALESCE(
          (SELECT est_tipo_estatus
           FROM ESTATUS e
           INNER JOIN ESTATUS_SSP essp ON e.est_id = essp.fk_est_id
           WHERE essp.fk_spr_id = sp.spr_id
           ORDER BY essp.ups_fecha_inicio DESC
           LIMIT 1
          ),
          'Pendiente'
        ) as estado
      FROM SOLICITUD_PROVEEDOR sp
      INNER JOIN PROVEEDOR c ON sp.fk_com_id = c.com_id
      INNER JOIN SEDE_PLANTA s ON sp.fk_sed_id = s.sed_id
      INNER JOIN MATERIA_PRIMA mp ON sp.fk_rpm_id = mp.rpm_id
      ORDER BY sp.spr_fecha DESC
    `;
    const result = await pool.query(query);
    return result.rows;
  },

  // Obtener solicitudes por proveedor
  getSolicitudesByProveedor: async (proveedorId) => {
    const query = `
      SELECT 
        sp.spr_id as id,
        sp.spr_fecha as fecha,
        sp.spr_total as total,
        sp.spr_descripcion as descripcion,
        s.sed_nombre as sede_nombre,
        mp.rpm_nombre as materia_prima_nombre,
        COALESCE(
          (SELECT est_tipo_estatus 
           FROM ESTATUS e 
           INNER JOIN ESTATUS_SSP essp ON e.est_id = essp.fk_est_id 
           WHERE essp.fk_spr_id = sp.spr_id 
           ORDER BY essp.ups_fecha_inicio DESC 
           LIMIT 1
          ),
          'Pendiente'
        ) as estado
      FROM SOLICITUD_PROVEEDOR sp
      INNER JOIN SEDE_PLANTA s ON sp.fk_sed_id = s.sed_id
      INNER JOIN MATERIA_PRIMA mp ON sp.fk_rpm_id = mp.rpm_id
      WHERE sp.fk_com_id = $1
      ORDER BY sp.spr_fecha DESC
    `;
    const result = await pool.query(query, [proveedorId]);
    return result.rows;
  },
  // Obtener detalles de una solicitud
  getSolicitudDetalles: async (solicitudId) => {
    const query = `
      SELECT 
        dsp.dsp_cantidad as cantidad,
        dsp.dsp_unidad_medida as unidad_medida,
        mtp.mtp_precio as precio,
        mp.rpm_nombre as materia_prima_nombre
      FROM DETALLE_SLD_PROVEEDOR dsp
      INNER JOIN PROVEEDOR_MP_STOCK mtp ON dsp.fk_mtp_id = mtp.mtp_id
      INNER JOIN MATERIA_PRIMA mp ON mtp.fk_rpm_id = mp.rpm_id
      WHERE dsp.fk_spr_id = $1
    `;
    const result = await pool.query(query, [solicitudId]);
    return result.rows;
  },

  // Actualizar estado de una solicitud
  updateEstadoSolicitud: async (solicitudId, estadoId) => {
    const query = `
      INSERT INTO ESTATUS_SSP (
        ups_fecha_inicio,
        fk_spr_id,
        fk_est_id
      ) VALUES (
        CURRENT_TIMESTAMP,
        $1,
        $2
      )
    `;
    await pool.query(query, [solicitudId, estadoId]);
  },
};
