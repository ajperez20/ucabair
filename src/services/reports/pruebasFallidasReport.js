import { generateReportPDF } from "@/utils/pdfGenerator";
import pool from "@/config/database";

const columns = [
  {
    key: "prueba_nombre",
    label: "Prueba",
    width: 150,
  },
  {
    key: "pieza_nombre",
    label: "Pieza",
    width: 120,
  },
  {
    key: "fecha_prueba",
    label: "Fecha",
    width: 100,
    format: (value) => new Date(value).toLocaleDateString(),
  },
  {
    key: "zona_nombre",
    label: "Zona",
    width: 100,
  },
  {
    key: "sede_nombre",
    label: "Sede",
    width: 120,
  },
  {
    key: "dias_transcurridos",
    label: "Días",
    width: 80,
    align: "right",
  },
  {
    key: "observaciones",
    label: "Observaciones",
    width: 200,
  },
];

export const pruebasFallidasReport = {
  getData: async (anio) => {
    if (!anio) throw new Error("El año es requerido");

    const query = `SELECT * FROM SP_REPORTE_PRUEBAS_FALLIDAS($1)`;
    const result = await pool.query(query, [anio]);
    return result.rows;
  },

  generatePDF: async (anio) => {
    const data = await pruebasFallidasReport.getData(anio);

    return generateReportPDF({
      title: "Reporte de Pruebas Fallidas",
      subtitle: `Año: ${anio}`,
      data,
      columns,
      showChart: data.length > 0,
      chartConfig: {
        valueKey: "dias_transcurridos",
        labelKey: "prueba_nombre",
        type: "bar",
        title: "Días transcurridos por prueba fallida",
      },
      emptyMessage: `No se encontraron pruebas fallidas para el año ${anio}`,
    });
  },
};
