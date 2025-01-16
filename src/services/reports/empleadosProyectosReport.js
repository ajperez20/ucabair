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
    key: "cargo",
    label: "Cargo",
    width: 120,
  },
  {
    key: "zona_asignada",
    label: "Zona",
    width: 120,
  },
  {
    key: "sede_actual",
    label: "Sede",
    width: 120,
  },
  {
    key: "proyectos_activos",
    label: "Proyectos",
    width: 90,
    align: "right",
  },
  {
    key: "procesos_completados",
    label: "Completados",
    width: 100,
    align: "right",
  },
  {
    key: "piezas_procesadas",
    label: "Piezas",
    width: 80,
    align: "right",
  },
  {
    key: "eficiencia_promedio",
    label: "Eficiencia %",
    width: 100,
    align: "right",
    format: (value) => Number(value).toFixed(2),
  },
];

export const empleadosProyectosReport = {
  getData: async () => {
    const query = `SELECT * FROM SP_REPORTE_EMPLEADOS_PROYECTOS()`;
    const result = await pool.query(query);
    return result.rows;
  },

  generatePDF: async () => {
    const data = await empleadosProyectosReport.getData();

    return generateReportPDF({
      title: "Reporte de Empleados en Proyectos",
      subtitle: "Asignaciones y rendimiento",
      data,
      columns,
      showChart: data.length > 0,
      chartConfig: {
        valueKey: "eficiencia_promedio",
        labelKey: "empleado_nombre",
        type: "bar",
        title: "Eficiencia por empleado",
      },
      emptyMessage: "No se encontraron asignaciones de proyectos",
    });
  },
};
