import { generateReportPDF } from "@/utils/pdfGenerator";
import pool from "@/config/database";

const columns = [
  {
    key: "zona_nombre",
    label: "Zona",
    width: 100,
  },
  {
    key: "area_nombre",
    label: "Área",
    width: 100,
  },
  {
    key: "sede_nombre",
    label: "Sede",
    width: 100,
  },
  {
    key: "supervisor_nombre",
    label: "Supervisor",
    width: 150,
  },
  {
    key: "total_procesos",
    label: "Total Procesos",
    width: 80,
    align: "right",
  },
  {
    key: "procesos_a_tiempo",
    label: "A Tiempo",
    width: 70,
    align: "right",
  },
  {
    key: "procesos_retrasados",
    label: "Retrasados",
    width: 70,
    align: "right",
  },
  {
    key: "promedio_retraso",
    label: "Prom. Retraso (días)",
    width: 80,
    align: "right",
    format: (value) => Number(value).toFixed(1),
  },
  {
    key: "porcentaje_eficiencia",
    label: "Eficiencia",
    width: 70,
    align: "right",
    format: (value) => `${Number(value).toFixed(1)}%`,
  },
  {
    key: "ranking",
    label: "Ranking",
    width: 60,
    align: "center",
    format: (value) => `#${value}`,
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
      title: "Ranking de Equipos por Eficiencia",
      subtitle: `Año ${anio}`,
      data,
      columns,
      showChart: data.length > 0,
      chartConfig: {
        type: "bar",
        data: data.map((row) => ({
          label: `${row.zona_nombre} (${row.sede_nombre})`,
          value: row.porcentaje_eficiencia,
        })),
        valueKey: "value",
        labelKey: "label",
        title: "Porcentaje de Eficiencia por Equipo",
        yAxisLabel: "Eficiencia (%)",
        xAxisLabel: "Equipos",
      },
      summary: {
        title: "Resumen de Eficiencia",
        items: [
          {
            label: "Equipos Evaluados",
            value: data.length,
          },
          {
            label: "Mejor Eficiencia",
            value: `${Math.max(...data.map((d) => d.porcentaje_eficiencia))}%`,
          },
          {
            label: "Promedio de Eficiencia",
            value: `${(data.reduce((acc, curr) => acc + curr.porcentaje_eficiencia, 0) / data.length).toFixed(1)}%`,
          },
          {
            label: "Total Procesos",
            value: data.reduce((acc, curr) => acc + curr.total_procesos, 0),
          },
        ],
      },
      emptyMessage: `No se encontraron datos de equipos para el año ${anio}`,
    });
  },
};
