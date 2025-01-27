import { generateReportPDF } from "@/utils/pdfGenerator";
import pool from "@/config/database";

const columns = [
  {
    key: "modelo_avion",
    label: "Modelo",
    width: 120,
  },
  {
    key: "nombre_prueba",
    label: "Prueba",
    width: 150,
  },
  {
    key: "total_pruebas",
    label: "Total",
    width: 80,
    align: "right",
  },
  {
    key: "pruebas_exitosas",
    label: "Exitosas",
    width: 80,
    align: "right",
  },
  {
    key: "porcentaje_exito",
    label: "% Éxito",
    width: 90,
    align: "right",
    format: (value) => `${Number(value).toFixed(2)}%`,
  },
  {
    key: "estado_general",
    label: "Estado",
    width: 120,
  },
  {
    key: "observaciones",
    label: "Observaciones",
    width: 200,
  },
];

export const modeloPruebasReport = {
  getData: async () => {
    const query = `SELECT * FROM SP_REPORTE_MODELO_PRUEBAS()`;
    const result = await pool.query(query);
    return result.rows;
  },

  generatePDF: async () => {
    const data = await modeloPruebasReport.getData();

    return generateReportPDF({
      title: "Reporte de Pruebas por Modelo",
      subtitle: "Análisis de resultados y eficiencia",
      data,
      columns,
      showChart: data.length > 0,
      chartConfig: {
        valueKey: "porcentaje_exito",
        labelKey: "nombre_prueba",
        type: "bar",
        groupBy: "modelo_avion",
        title: "Porcentaje de éxito por prueba y modelo",
      },
      emptyMessage: "No se encontraron pruebas registradas",
    });
  },
};
