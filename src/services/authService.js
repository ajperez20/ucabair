import pool from "../config/database";

export const authService = {
  login: async (email, password) => {
    const query = `
        SELECT
            u.usu_id,
            u.usu_nombre_usuario,
            u.usu_email,
            r.rol_nombre,
            r.rol_descripcion,
            array_agg(DISTINCT p.pri_accion) as privilegios,
            COALESCE(e.per_nombre, cj.cjd_nombre, cn.ctn_nombre, com.com_nombre) as nombre_completo,
            -- Agregar IDs de cliente
            cj.cjd_id as cliente_juridico_id,
            cn.ctn_id as cliente_natural_id,
            -- Determinar tipo de cliente
            CASE
                WHEN cj.cjd_id IS NOT NULL THEN 'JURIDICO'
                WHEN cn.ctn_id IS NOT NULL THEN 'NATURAL'
                ELSE NULL
                END as tipo_cliente
        FROM usuario u
                 JOIN rol r ON u.fk_rol_id = r.rol_id
                 LEFT JOIN privilegio_rol pr ON r.rol_id = pr.fk_rol_id
                 LEFT JOIN privilegio p ON pr.fk_pri_id = p.pri_id
                 LEFT JOIN empleado e ON u.fk_per_id = e.per_id
                 LEFT JOIN cliente_juridico cj ON u.fk_cjd_id = cj.cjd_id
                 LEFT JOIN cliente_natural cn ON u.fk_ctn_id = cn.ctn_id
                 LEFT JOIN proveedor com ON u.fk_com_id = com.com_id
        WHERE u.usu_email = $1
          AND u.usu_contrasena = $2
        GROUP BY
            u.usu_id,
            u.usu_nombre_usuario,
            u.usu_email,
            r.rol_nombre,
            r.rol_descripcion,
            e.per_nombre,
            cj.cjd_id,
            cj.cjd_nombre,
            cn.ctn_id,
            cn.ctn_nombre,
            com.com_nombre
    `;
    const result = await pool.query(query, [email, password]);
    return result.rows[0];
  },

  getUserPrivileges: async (userId) => {
    const query = `
        SELECT DISTINCT p.pri_accion
        FROM usuario u
                 JOIN rol r ON u.fk_rol_id = r.rol_id
                 JOIN privilegio_rol pr ON r.rol_id = pr.fk_rol_id
                 JOIN privilegio p ON pr.fk_pri_id = p.pri_id
        WHERE u.usu_id = $1
    `;
    const result = await pool.query(query, [userId]);
    return result.rows.map((row) => row.pri_accion);
  },
};
