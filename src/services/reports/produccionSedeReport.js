import { generateReportPDF } from "@/utils/pdfGenerator";
import pool from "@/config/database";

const columns = [
  {
    key: "sede_nombre",
    label: "Sede",
    width: 120,
  },
  {
    key: "total_aviones",
    label: "Aviones",
    width: 90,
    align: "right",
  },
  {
    key: "total_piezas",
    label: "Piezas",
    width: 90,
    align: "right",
  },
  {
    key: "total_pruebas",
    label: "Pruebas",
    width: 90,
    align: "right",
  },
  {
    key: "empleados_activos",
    label: "Empleados",
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

export const produccionSedeReport = {
  getData: async (anio) => {
    if (!anio) throw new Error("El año es requerido");

    const query = `SELECT * FROM SP_REPORTE_PRODUCCION_SEDE($1)`;
    const result = await pool.query(query, [anio]);
    return result.rows;
  },

  generatePDF: async (anio) => {
    const data = await produccionSedeReport.getData(anio);

    return generateReportPDF({
      title: "Reporte de Producción por Sede",
      subtitle: `Año: ${anio}`,
      data,
      columns,
      showChart: data.length > 0,
      chartConfig: {
        valueKey: "porcentaje_completado",
        labelKey: "sede_nombre",
        type: "bar",
        title: "Porcentaje de completitud por sede",
      },
      emptyMessage: `No se encontraron datos de producción para el año ${anio}`,
    });
  },
};
