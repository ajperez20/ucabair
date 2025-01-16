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
    key: "precio_base",
    label: "Precio Base",
    width: 100,
    align: "right",
    format: (value) => `$${Number(value).toLocaleString()}`,
  },
  {
    key: "costos_materiales",
    label: "Costos",
    width: 100,
    align: "right",
    format: (value) => `$${Number(value).toLocaleString()}`,
  },
  {
    key: "ingreso_total",
    label: "Ingreso Total",
    width: 120,
    align: "right",
    format: (value) => `$${Number(value).toLocaleString()}`,
  },
  {
    key: "margen_rentabilidad",
    label: "Margen %",
    width: 90,
    align: "right",
    format: (value) => `${Number(value).toFixed(2)}%`,
  },
  {
    key: "estado_rentabilidad",
    label: "Estado",
    width: 100,
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
      title: "Reporte de Rentabilidad por Modelo",
      subtitle: `Año: ${anio}`,
      data,
      columns,
      showChart: data.length > 0,
      chartConfig: {
        valueKey: "margen_rentabilidad",
        labelKey: "modelo_avion",
        type: "bar",
        title: "Margen de rentabilidad por modelo",
      },
      emptyMessage: `No se encontraron datos de producción para el año ${anio}`,
    });
  },
};
