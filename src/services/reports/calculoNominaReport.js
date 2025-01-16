import { generateReportPDF } from "@/utils/pdfGenerator";
import pool from "@/config/database";

const columns = [
  {
    key: "empleado_dni",
    label: "DNI",
    width: 80,
  },
  {
    key: "empleado_nombre",
    label: "Empleado",
    width: 200,
  },
  {
    key: "cargo",
    label: "Cargo",
    width: 150,
  },
  {
    key: "total_horas_trabajadas",
    label: "Horas Trabajadas",
    width: 100,
    align: "right",
    format: (value) => Number(value).toFixed(2),
  },
  {
    key: "total_horas_extras",
    label: "Horas Extras",
    width: 80,
    align: "right",
    format: (value) => Number(value).toFixed(2),
  },
  {
    key: "total_pagado",
    label: "Total Pagado",
    width: 100,
    align: "right",
    format: (value) => `$${Number(value).toLocaleString()}`,
  },
  {
    key: "mes",
    label: "Mes",
    width: 100,
  },
];

export const calculoNominaReport = {
  getData: async (anio) => {
    if (!anio) throw new Error("El año es requerido");

    const query = `SELECT * FROM SP_REPORTE_NOMINA($1)`;
    const result = await pool.query(query, [anio]);
    return result.rows;
  },

  generatePDF: async (anio) => {
    const data = await calculoNominaReport.getData(anio);

    return generateReportPDF({
      title: "Reporte de Nómina",
      subtitle: `Año: ${anio}`,
      data,
      columns,
      showChart: data.length > 0,
      chartConfig: {
        valueKey: "total_pagado",
        labelKey: "mes",
        type: "bar", // Puedes usar 'bar' para gráfico de barras
        groupBy: "mes", // Agrupar por mes
      },
      emptyMessage: `No se encontraron datos de nómina para el año ${anio}`,
    });
  },
};
