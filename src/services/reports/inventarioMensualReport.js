import { generateReportPDF } from "@/utils/pdfGenerator";
import pool from "@/config/database";

const columns = [
  {
    key: "sede_nombre",
    label: "Sede",
    width: 120,
  },
  {
    key: "mes",
    label: "Mes",
    width: 100,
  },
  {
    key: "pieza_nombre",
    label: "Pieza",
    width: 150,
  },
  {
    key: "stock_inicial",
    label: "Stock Inicial",
    width: 90,
    align: "right",
  },
  {
    key: "entradas",
    label: "Entradas",
    width: 90,
    align: "right",
  },
  {
    key: "salidas",
    label: "Salidas",
    width: 90,
    align: "right",
  },
  {
    key: "stock_final",
    label: "Stock Final",
    width: 90,
    align: "right",
  },
  {
    key: "valor_total",
    label: "Valor Total",
    width: 100,
    align: "right",
    format: (value) => `$${Number(value).toLocaleString()}`,
  },
];

export const inventarioMensualReport = {
  getData: async (anio) => {
    if (!anio) throw new Error("El año es requerido");

    const query = `SELECT * FROM SP_REPORTE_INVENTARIO_MENSUAL($1)`;
    const result = await pool.query(query, [anio]);
    return result.rows;
  },

  generatePDF: async (anio) => {
    const data = await inventarioMensualReport.getData(anio);

    return generateReportPDF({
      title: "Reporte de Inventario Mensual",
      subtitle: `Año: ${anio}`,
      data,
      columns,
      showChart: data.length > 0,
      chartConfig: {
        valueKey: "stock_final",
        labelKey: "mes",
        type: "line",
        groupBy: "sede_nombre",
        title: "Evolución del inventario por sede",
      },
      emptyMessage: `No se encontraron datos de inventario para el año ${anio}`,
    });
  },
};
