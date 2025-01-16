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
    key: "nombre_pieza",
    label: "Pieza",
    width: 120,
  },
  {
    key: "tipo_pieza",
    label: "Tipo Pieza",
    width: 100,
  },
  {
    key: "cantidad_requerida",
    label: "Cantidad",
    width: 80,
    align: "right",
  },
  {
    key: "materiales_requeridos",
    label: "Materiales",
    width: 200,
  },
  {
    key: "cantidad_procesos",
    label: "Procesos",
    width: 80,
    align: "right",
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
      subtitle: "Especificaciones y requerimientos",
      data,
      columns,
      showChart: data.length > 0,
      chartConfig: {
        valueKey: "cantidad_requerida",
        labelKey: "nombre_pieza",
        type: "bar",
        groupBy: "modelo_avion",
        title: "Cantidad de piezas requeridas por modelo",
      },
      emptyMessage: "No se encontraron piezas registradas",
    });
  },
};
