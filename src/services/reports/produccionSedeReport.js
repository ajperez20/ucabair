import { generateReportPDF } from "@/utils/pdfGenerator";
import pool from "@/config/database";

const columns = [
  {
    key: "sede_nombre",
    label: "Sede",
    width: 120,
  },
  {
    key: "mes",
    label: "Mes",
    width: 100,
  },
  {
    key: "aviones_producidos",
    label: "Aviones",
    width: 80,
    align: "right",
  },
  {
    key: "piezas_fabricadas",
    label: "Piezas",
    width: 80,
    align: "right",
  },
  {
    key: "pruebas_realizadas",
    label: "Pruebas",
    width: 80,
    align: "right",
  },
  {
    key: "tiempo_promedio_produccion",
    label: "T. Promedio (días)",
    width: 100,
    align: "right",
    format: (value) => Number(value).toFixed(2),
  },
  {
    key: "eficiencia_produccion",
    label: "Eficiencia %",
    width: 90,
    align: "right",
    format: (value) => Number(value).toFixed(2),
  },
  {
    key: "empleados_activos",
    label: "Empleados",
    width: 90,
    align: "right",
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
        valueKey: "aviones_producidos",
        labelKey: "mes",
        type: "line",
        groupBy: "sede_nombre",
        title: "Producción mensual por sede",
      },
      emptyMessage: `No se encontraron datos de producción para el año ${anio}`,
    });
  },
};
