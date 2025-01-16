import { generateReportPDF } from "@/utils/pdfGenerator";
import pool from "@/config/database";

const columns = [
  {
    key: "modelo_avion",
    label: "Modelo",
    width: 120,
  },
  {
    key: "tipo_avion",
    label: "Tipo",
    width: 100,
  },
  {
    key: "cantidad_producida",
    label: "Cantidad",
    width: 80,
    align: "right",
  },
  {
    key: "cumplimiento_tiempo",
    label: "Cumplimiento %",
    width: 100,
    align: "right",
    format: (value) => Number(value).toFixed(2),
  },
  {
    key: "costo_estimado",
    label: "Costo Est.",
    width: 100,
    align: "right",
    format: (value) => `$${Number(value).toLocaleString()}`,
  },
  {
    key: "costo_real",
    label: "Costo Real",
    width: 100,
    align: "right",
    format: (value) => `$${Number(value).toLocaleString()}`,
  },
  {
    key: "margen_rentabilidad",
    label: "Margen %",
    width: 90,
    align: "right",
    format: (value) => Number(value).toFixed(2),
  },
  {
    key: "indice_eficiencia",
    label: "Eficiencia",
    width: 90,
    align: "right",
    format: (value) => Number(value).toFixed(2),
  },
];

export const rentabilidadCumplimientoReport = {
  getData: async (anio) => {
    if (!anio) throw new Error("El año es requerido");

    const query = `SELECT * FROM SP_REPORTE_RENTABILIDAD_CUMPLIMIENTO($1)`;
    const result = await pool.query(query, [anio]);
    return result.rows;
  },

  generatePDF: async (anio) => {
    const data = await rentabilidadCumplimientoReport.getData(anio);

    return generateReportPDF({
      title: "Reporte de Rentabilidad por Cumplimiento",
      subtitle: `Año: ${anio}`,
      data,
      columns,
      showChart: data.length > 0,
      chartConfig: {
        valueKey: "indice_eficiencia",
        labelKey: "modelo_avion",
        type: "bar",
        title: "Índice de eficiencia por modelo",
      },
      emptyMessage: `No se encontraron datos de producción para el año ${anio}`,
    });
  },
};
