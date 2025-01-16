import { generateReportPDF } from "@/utils/pdfGenerator";
import pool from "@/config/database";

const columns = [
  {
    key: "modelo_avion",
    label: "Modelo",
    width: 120,
  },
  {
    key: "pieza_nombre",
    label: "Pieza",
    width: 120,
  },
  {
    key: "tipo_pieza",
    label: "Tipo",
    width: 100,
  },
  {
    key: "cantidad_requerida",
    label: "Cantidad",
    width: 80,
    align: "right",
  },
  {
    key: "caracteristicas",
    label: "Características",
    width: 200,
  },
  {
    key: "materiales_necesarios",
    label: "Materiales",
    width: 200,
  },
  {
    key: "tiempo_estimado_fabricacion",
    label: "T. Estimado",
    width: 100,
  },
  {
    key: "costo_estimado",
    label: "Costo Est.",
    width: 100,
    align: "right",
    format: (value) => `$${Number(value).toLocaleString()}`,
  },
];

export const modeloPiezasReport = {
  getData: async () => {
    const query = `SELECT * FROM SP_REPORTE_MODELO_PIEZAS()`;
    const result = await pool.query(query);
    return result.rows;
  },

  generatePDF: async () => {
    const data = await modeloPiezasReport.getData();

    return generateReportPDF({
      title: "Catálogo de Piezas por Modelo",
      subtitle: "Especificaciones técnicas y requerimientos",
      data,
      columns,
      showChart: data.length > 0,
      chartConfig: {
        valueKey: "cantidad_requerida",
        labelKey: "pieza_nombre",
        type: "bar",
        groupBy: "modelo_avion",
        title: "Cantidad de piezas por modelo",
      },
      emptyMessage: "No se encontraron piezas registradas",
    });
  },
};
