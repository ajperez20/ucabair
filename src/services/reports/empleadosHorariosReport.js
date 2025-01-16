import { generateReportPDF } from "@/utils/pdfGenerator";
import pool from "@/config/database";

const columns = [
  {
    key: "empleado_dni",
    label: "DNI",
    width: 100,
  },
  {
    key: "empleado_nombre",
    label: "Empleado",
    width: 150,
  },
  {
    key: "cargo_actual",
    label: "Cargo",
    width: 120,
  },
  {
    key: "dia_semana",
    label: "Día",
    width: 90,
  },
  {
    key: "hora_inicio",
    label: "Entrada",
    width: 80,
  },
  {
    key: "hora_fin",
    label: "Salida",
    width: 80,
  },
  {
    key: "horas_asignadas",
    label: "Horas",
    width: 70,
    align: "right",
    format: (value) => Number(value).toFixed(1),
  },
  {
    key: "asistencias_mes",
    label: "Asistencias",
    width: 90,
    align: "right",
  },
  {
    key: "promedio_puntualidad",
    label: "Puntualidad %",
    width: 100,
    align: "right",
    format: (value) => Number(value).toFixed(2),
  },
];

export const empleadosHorariosReport = {
  getData: async () => {
    const query = `SELECT * FROM SP_REPORTE_EMPLEADOS_HORARIOS()`;
    const result = await pool.query(query);
    return result.rows;
  },

  generatePDF: async () => {
    const data = await empleadosHorariosReport.getData();

    return generateReportPDF({
      title: "Reporte de Horarios de Empleados",
      subtitle: "Distribución de horarios y cumplimiento",
      data,
      columns,
      showChart: data.length > 0,
      chartConfig: {
        valueKey: "promedio_puntualidad",
        labelKey: "empleado_nombre",
        type: "bar",
        title: "Promedio de puntualidad por empleado",
      },
      emptyMessage: "No se encontraron horarios registrados",
    });
  },
};
