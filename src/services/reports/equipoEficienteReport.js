import { generateReportPDF } from "@/utils/pdfGenerator";
import pool from "@/config/database";

const columns = [
  {
    key: "zona_nombre",
    label: "Zona",
    width: 120,
  },
  {
    key: "area_nombre",
    label: "Área",
    width: 120,
  },
  {
    key: "sede_nombre",
    label: "Sede",
    width: 120,
  },
  {
    key: "supervisor_nombre",
    label: "Supervisor",
    width: 150,
  },
  {
    key: "procesos_asignados",
    label: "Asignados",
    width: 90,
    align: "right",
  },
  {
    key: "procesos_completados",
    label: "Completados",
    width: 90,
    align: "right",
  },
  {
    key: "procesos_pendientes",
    label: "Pendientes",
    width: 90,
    align: "right",
  },
  {
    key: "porcentaje_completado",
    label: "% Completado",
    width: 100,
    align: "right",
    format: (value) => `${Number(value).toFixed(2)}%`,
  },
];

export const equipoEficienteReport = {
  getData: async (anio) => {
    if (!anio) throw new Error("El año es requerido");

    const query = `SELECT * FROM SP_REPORTE_EQUIPO_EFICIENTE($1)`;
    const result = await pool.query(query, [anio]);
    return result.rows;
  },

  generatePDF: async (anio) => {
    const data = await equipoEficienteReport.getData(anio);

    return generateReportPDF({
      title: "Reporte de Equipos más Eficientes",
      subtitle: `Año: ${anio}`,
      data,
      columns,
      showChart: data.length > 0,
      chartConfig: {
        valueKey: "porcentaje_completado",
        labelKey: "zona_nombre",
        type: "bar",
        title: "Porcentaje de completitud por zona",
      },
      emptyMessage: `No se encontraron datos de equipos para el año ${anio}`,
    });
  },
};
