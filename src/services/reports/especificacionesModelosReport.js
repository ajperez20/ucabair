import { generateReportPDF } from "@/utils/pdfGenerator";
import pool from "@/config/database";

const columns = [
  {
    key: "modelo_nombre",
    label: "Modelo",
    width: 120,
  },
  {
    key: "tipo_avion",
    label: "Tipo",
    width: 100,
  },
  {
    key: "caracteristica",
    label: "Característica",
    width: 150,
  },
  {
    key: "valor",
    label: "Valor",
    width: 80,
    align: "right",
  },
  {
    key: "unidad_medida",
    label: "Unidad",
    width: 80,
  },
  {
    key: "cantidad_piezas",
    label: "Piezas",
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
];

export const especificacionesModelosReport = {
  getData: async () => {
    const query = `SELECT * FROM SP_REPORTE_ESPECIFICACIONES_MODELOS()`;
    const result = await pool.query(query);
    return result.rows;
  },

  generatePDF: async () => {
    const data = await especificacionesModelosReport.getData();

    return generateReportPDF({
      title: "Especificaciones de Modelos de Aviones",
      subtitle: "Catálogo detallado de especificaciones técnicas",
      data,
      columns,
      showChart: false,
      emptyMessage: "No se encontraron especificaciones de modelos",
    });
  },
};
