-- migrations/018_SP_REPORTES.sql

-- =========================================================
-- Procedimiento almacenado para obtener los 10 clientes con más compras en un año
-- =========================================================
DROP FUNCTION IF EXISTS SP_TOP_10_CLIENTES;

CREATE OR REPLACE FUNCTION SP_TOP_10_CLIENTES(
    IN p_anio INTEGER
)
    RETURNS TABLE
            (
                cliente_tipo           TEXT,
                cliente_id             INTEGER,
                cliente_identificacion TEXT,
                cliente_nombre         TEXT,
                cantidad_compras       BIGINT,
                total_compras          NUMERIC
            )
AS
$$
BEGIN
    RETURN QUERY
        -- Clientes Naturales
        (SELECT 'NATURAL'::TEXT                                 as cliente_tipo,
                cn.ctn_id                                       as cliente_id,
                cn.ctn_dni::TEXT                                as cliente_identificacion,
                (cn.ctn_nombre || ' ' || cn.ctn_apellido)::TEXT as cliente_nombre,
                COUNT(sc.sct_id)                                as cantidad_compras,
                COALESCE(SUM(sc.sct_total), 0)::NUMERIC         as total_compras
         FROM cliente_natural cn
                  LEFT JOIN solicitud_cliente sc ON cn.ctn_id = sc.fk_ctn_id
             AND EXTRACT(YEAR FROM sc.sct_fecha) = p_anio
         GROUP BY cn.ctn_id, cn.ctn_dni, cn.ctn_nombre, cn.ctn_apellido)

        UNION ALL

        -- Clientes Jurídicos
        (SELECT 'JURIDICO'::TEXT                        as cliente_tipo,
                cj.cjd_id                               as cliente_id,
                cj.cjd_rif::TEXT                        as cliente_identificacion,
                cj.cjd_nombre::TEXT                     as cliente_nombre,
                COUNT(sc.sct_id)                        as cantidad_compras,
                COALESCE(SUM(sc.sct_total), 0)::NUMERIC as total_compras
         FROM cliente_juridico cj
                  LEFT JOIN solicitud_cliente sc ON cj.cjd_id = sc.fk_cjd_id
             AND EXTRACT(YEAR FROM sc.sct_fecha) = p_anio
         GROUP BY cj.cjd_id, cj.cjd_rif, cj.cjd_nombre)

        ORDER BY total_compras DESC, cantidad_compras DESC
        LIMIT 10;
END;
$$ LANGUAGE plpgsql; 