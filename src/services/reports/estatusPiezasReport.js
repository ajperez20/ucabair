import { generateReportPDF } from "@/utils/pdfGenerator";
import pool from "@/config/database";

const columns = [
  {
    key: "pieza_nombre",
    label: "Pieza",
    width: 120,
  },
  {
    key: "numero_serial",
    label: "Serial",
    width: 90,
  },
  {
    key: "tipo_pieza",
    label: "Tipo",
    width: 100,
  },
  {
    key: "estado",
    label: "Estado",
    width: 80,
    format: (value) => {
      const colors = {
        Agotado: "#e74c3c",
        "Stock Crítico": "#f1c40f",
        Disponible: "#2ecc71",
      };
      return { text: value, color: colors[value] || "#000000" };
    },
  },
  {
    key: "ubicacion_sede",
    label: "Sede",
    width: 120,
  },
  {
    key: "cantidad_disponible",
    label: "Stock",
    width: 60,
    align: "right",
  },
  {
    key: "pruebas_aprobadas",
    label: "Pruebas",
    width: 70,
    align: "right",
    format: (value, row) => `${value}/${row.pruebas_realizadas}`,
  },
  {
    key: "proceso_actual",
    label: "Proceso Actual",
    width: 140,
  },
  {
    key: "estado_proceso",
    label: "Estado",
    width: 80,
    format: (value) => {
      const colors = {
        "No iniciado": "#95a5a6",
        "En Proceso": "#3498db",
        Completado: "#2ecc71",
      };
      return { text: value, color: colors[value] || "#000000" };
    },
  },
];

export const estatusPiezasReport = {
  getData: async () => {
    const query = `SELECT * FROM SP_REPORTE_ESTATUS_PIEZAS()`;
    const result = await pool.query(query);
    return result.rows;
  },

  generatePDF: async () => {
    const data = await estatusPiezasReport.getData();

    // Estadísticas para el gráfico
    const stats = data.reduce((acc, curr) => {
      const estado = curr.estado_proceso;
      acc[estado] = (acc[estado] || 0) + 1;
      return acc;
    }, {});

    return generateReportPDF({
      title: "Estado de Fabricación de Piezas",
      subtitle: `Reporte generado el ${new Date().toLocaleDateString()}`,
      data,
      columns,
      showChart: data.length > 0,
      chartConfig: {
        type: "pie",
        data: Object.entries(stats).map(([estado, cantidad]) => ({
          label: estado,
          value: cantidad,
        })),
        valueKey: "value",
        labelKey: "label",
        title: "Distribución de Estados de Procesos",
      },
      emptyMessage: "No se encontraron piezas registradas en el sistema",
      // Añadir resumen estadístico
      summary: {
        title: "Resumen General",
        items: [
          {
            label: "Total Piezas",
            value: data.length,
          },
          {
            label: "En Proceso",
            value: data.filter((d) => d.estado_proceso === "En Proceso").length,
          },
          {
            label: "Stock Crítico",
            value: data.filter((d) => d.estado === "Stock Crítico").length,
          },
          {
            label: "Pruebas Pendientes",
            value: data.filter(
              (d) => d.pruebas_realizadas > d.pruebas_aprobadas,
            ).length,
          },
        ],
      },
    });
  },
};
