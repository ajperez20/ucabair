import pool from "../config/database";

export const usuarioService = {
  getAll: async () => {
    const query = `
        SELECT
            u.usu_id,
            u.usu_nombre_usuario,
            u.usu_email,
            r.rol_nombre,
            r.rol_descripcion,
            COALESCE(
                    e.per_nombre || ' ' || e.per_apellido,
                    cj.cjd_nombre,
                    cn.ctn_nombre || ' ' || cn.ctn_apellido,
                    p.com_nombre
            ) as entidad_nombre,
            CASE
                WHEN u.fk_per_id IS NOT NULL THEN 'EMPLEADO'
                WHEN u.fk_cjd_id IS NOT NULL THEN 'CLIENTE JURIDICO'
                WHEN u.fk_ctn_id IS NOT NULL THEN 'CLIENTE NATURAL'
                WHEN u.fk_com_id IS NOT NULL THEN 'PROVEEDOR'
                END as tipo_usuario
        FROM usuario u
                 LEFT JOIN rol r ON u.fk_rol_id = r.rol_id
                 LEFT JOIN empleado e ON u.fk_per_id = e.per_id
                 LEFT JOIN cliente_juridico cj ON u.fk_cjd_id = cj.cjd_id
                 LEFT JOIN cliente_natural cn ON u.fk_ctn_id = cn.ctn_id
                 LEFT JOIN proveedor p ON u.fk_com_id = p.com_id
        ORDER BY u.usu_nombre_usuario
    `;

    const result = await pool.query(query);
    return result.rows;
  },

  getById: async (id) => {
    const query = `
        SELECT
            u.usu_id,
            u.usu_nombre_usuario,
            u.usu_email,
            u.fk_rol_id,
            CASE
                WHEN u.fk_per_id IS NOT NULL THEN 'EMPLEADO'
                WHEN u.fk_cjd_id IS NOT NULL THEN 'CLIENTE JURIDICO'
                WHEN u.fk_ctn_id IS NOT NULL THEN 'CLIENTE NATURAL'
                WHEN u.fk_com_id IS NOT NULL THEN 'PROVEEDOR'
                END as tipo_usuario,
            COALESCE(u.fk_per_id, u.fk_cjd_id, u.fk_ctn_id, u.fk_com_id) as entidad_id
        FROM usuario u
        WHERE u.usu_id = $1
    `;

    const result = await pool.query(query, [id]);
    return result.rows[0];
  },

  create: async (usuario) => {
    const client = await pool.connect();
    await client.query("BEGIN");

    const insertQuery = `
      INSERT INTO usuario (
        usu_nombre_usuario,
        usu_contrasena,
        usu_email,
        fk_rol_id,
        fk_per_id,
        fk_cjd_id,
        fk_ctn_id,
        fk_com_id
      )
      VALUES (
        $1, $2, $3, $4,
        ${usuario.tipo_usuario === "EMPLEADO" ? "$5" : "NULL"},
        ${usuario.tipo_usuario === "CLIENTE JURIDICO" ? "$5" : "NULL"},
        ${usuario.tipo_usuario === "CLIENTE NATURAL" ? "$5" : "NULL"},
        ${usuario.tipo_usuario === "PROVEEDOR" ? "$5" : "NULL"}
      )
      RETURNING *
    `;

    const insertValues = [
      usuario.usu_nombre_usuario,
      usuario.usu_contrasena,
      usuario.usu_email,
      usuario.fk_rol_id,
      usuario.entidad_id,
    ];

    const result = await client.query(insertQuery, insertValues);
    await client.query("COMMIT");
    client.release();

    return result.rows[0];
  },

  update: async (id, usuario) => {
    const client = await pool.connect();
    await client.query("BEGIN");

    const updateQuery = `
      UPDATE usuario 
      SET 
        usu_nombre_usuario = $1,
        usu_email = $2,
        fk_rol_id = $3
        ${usuario.usu_contrasena ? ", usu_contrasena = $4" : ""}
      WHERE usu_id = ${usuario.usu_contrasena ? "$5" : "$4"}
      RETURNING *
    `;

    const updateValues = [
      usuario.usu_nombre_usuario,
      usuario.usu_email,
      usuario.fk_rol_id,
    ];

    if (usuario.usu_contrasena) {
      updateValues.push(usuario.usu_contrasena);
    }
    updateValues.push(id);

    const result = await client.query(updateQuery, updateValues);
    await client.query("COMMIT");
    client.release();

    return result.rows[0];
  },

  delete: async (id) => {
    const query = "DELETE FROM usuario WHERE usu_id = $1 RETURNING *";
    const result = await pool.query(query, [id]);
    return result.rows[0];
  },
};
