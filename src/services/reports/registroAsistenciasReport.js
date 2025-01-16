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
    width: 150,
  },
  {
    key: "cargo",
    label: "Cargo",
    width: 120,
  },
  {
    key: "mes",
    label: "Mes",
    width: 80,
  },
  {
    key: "dias_trabajados",
    label: "Días",
    width: 50,
    align: "right",
  },
  {
    key: "horas_regulares",
    label: "H. Regulares",
    width: 70,
    align: "right",
    format: (value) => Number(value).toFixed(1),
  },
  {
    key: "horas_extras",
    label: "H. Extras",
    width: 60,
    align: "right",
    format: (value) => Number(value).toFixed(1),
  },
  {
    key: "asistencias_completadas",
    label: "Completadas",
    width: 70,
    align: "right",
  },
  {
    key: "asistencias_pendientes",
    label: "Pendientes",
    width: 70,
    align: "right",
  },
  {
    key: "porcentaje_asistencia",
    label: "% Asistencia",
    width: 70,
    align: "right",
    format: (value) => `${Number(value).toFixed(1)}%`,
  },
];

export const registroAsistenciasReport = {
  getData: async (anio) => {
    if (!anio) throw new Error("El año es requerido");

    const query = `SELECT * FROM SP_REPORTE_ASISTENCIAS($1)`;
    const result = await pool.query(query, [anio]);
    return result.rows;
  },

  generatePDF: async (anio) => {
    const data = await registroAsistenciasReport.getData(anio);

    return generateReportPDF({
      title: "Registro de Asistencias",
      subtitle: `Año: ${anio}`,
      data,
      columns,
      showChart: data.length > 0,
      chartConfig: {
        type: "line",
        valueKey: "porcentaje_asistencia",
        labelKey: "mes",
        groupBy: "mes",
        title: "Porcentaje de Asistencia por Mes",
      },
      emptyMessage: `No se encontraron registros de asistencias para el año ${anio}`,
    });
  },
};
