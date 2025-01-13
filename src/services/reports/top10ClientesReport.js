import { generateReportPDF } from "@/utils/pdfGenerator";
import pool from "@/config/database";

const columns = [
  {
    key: "cliente_tipo",
    label: "Tipo",
    width: 70,
  },
  {
    key: "cliente_identificacion",
    label: "Identificación",
    width: 100,
  },
  {
    key: "cliente_nombre",
    label: "Nombre",
    width: 200,
  },
  {
    key: "cantidad_compras",
    label: "Cant. Compras",
    width: 80,
    align: "right",
    format: (value) => value.toString(),
  },
  {
    key: "total_compras",
    label: "Total ($)",
    width: 80,
    align: "right",
    format: (value) => Number(value).toFixed(2),
  },
];

export const top10ClientesReport = {
  getData: async (anio) => {
    if (!anio) throw new Error("El año es requerido");

    const query = `SELECT * FROM SP_TOP_10_CLIENTES($1)`;
    const result = await pool.query(query, [anio]);
    return result.rows;
  },

  generatePDF: async (anio) => {
    const data = await top10ClientesReport.getData(anio);

    return generateReportPDF({
      title: "Top 10 Clientes",
      subtitle: `Año: ${anio}`,
      data,
      columns,
      showChart: data.length > 0, // Solo mostrar gráfico si hay datos
      chartConfig: {
        valueKey: "cantidad_compras",
        labelKey: "cliente_nombre",
      },
      emptyMessage: `No se encontraron datos de clientes para el año ${anio}`,
    });
  },
};
