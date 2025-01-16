import { generateReportPDF } from "@/utils/pdfGenerator";
import pool from "@/config/database";

const columns = [
  {
    key: "tipo_ala",
    label: "Tipo de Ala",
    width: 120,
  },
  {
    key: "modelos_avion",
    label: "Modelos",
    width: 150,
  },
  {
    key: "cantidad_total_usada",
    label: "Cantidad",
    width: 80,
    align: "right",
  },
  {
    key: "caracteristicas_principales",
    label: "Características",
    width: 200,
  },
  {
    key: "material_principal",
    label: "Material",
    width: 100,
  },
  {
    key: "costo_promedio",
    label: "Costo Prom.",
    width: 100,
    align: "right",
    format: (value) => `$${Number(value).toLocaleString()}`,
  },
  {
    key: "porcentaje_uso",
    label: "Uso %",
    width: 80,
    align: "right",
    format: (value) => Number(value).toFixed(2),
  },
];

export const tiposAlasReport = {
  getData: async () => {
    const query = `SELECT * FROM SP_REPORTE_TIPOS_ALAS_USADOS()`;
    const result = await pool.query(query);
    return result.rows;
  },

  generatePDF: async () => {
    const data = await tiposAlasReport.getData();

    return generateReportPDF({
      title: "Reporte de Tipos de Alas más Usados",
      subtitle: "Análisis de preferencias y características",
      data,
      columns,
      showChart: data.length > 0,
      chartConfig: {
        valueKey: "porcentaje_uso",
        labelKey: "tipo_ala",
        type: "pie",
        title: "Distribución de uso por tipo de ala",
      },
      emptyMessage: "No se encontraron datos de tipos de alas",
    });
  },
};
