import { generateReportPDF } from "@/utils/pdfGenerator";
import pool from "@/config/database";

const columns = [
  {
    key: "proveedor_nombre",
    label: "Proveedor",
    width: 150,
  },
  {
    key: "ubicacion",
    label: "Ubicación",
    width: 150,
  },
  {
    key: "cantidad_materiales",
    label: "Materiales",
    width: 90,
    align: "right",
  },
  {
    key: "precio_promedio",
    label: "Precio Prom.",
    width: 100,
    align: "right",
    format: (value) => `$${Number(value).toLocaleString()}`,
  },
  {
    key: "anios_operacion",
    label: "Años Op.",
    width: 80,
    align: "right",
  },
  {
    key: "total_solicitudes",
    label: "Solicitudes",
    width: 90,
    align: "right",
  },
  {
    key: "total_ventas",
    label: "Total Ventas",
    width: 120,
    align: "right",
    format: (value) => `$${Number(value).toLocaleString()}`,
  },
  {
    key: "porcentaje_cumplimiento",
    label: "Cumplimiento %",
    width: 110,
    align: "right",
    format: (value) => Number(value).toFixed(2),
  },
];

export const listadoProveedoresReport = {
  getData: async () => {
    const query = `SELECT * FROM SP_REPORTE_LISTADO_PROVEEDORES()`;
    const result = await pool.query(query);
    return result.rows;
  },

  generatePDF: async () => {
    const data = await listadoProveedoresReport.getData();

    return generateReportPDF({
      title: "Listado de Proveedores",
      subtitle: "Análisis de desempeño y estadísticas",
      data,
      columns,
      showChart: data.length > 0,
      chartConfig: {
        valueKey: "total_ventas",
        labelKey: "proveedor_nombre",
        type: "bar",
        title: "Volumen de ventas por proveedor",
      },
      emptyMessage: "No se encontraron proveedores registrados",
    });
  },
};
