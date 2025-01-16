import { generateReportPDF } from "@/utils/pdfGenerator";
import pool from "@/config/database";

const columns = [
  {
    key: "tipo_ala",
    label: "Tipo de Ala",
    width: 120,
  },
  {
    key: "modelos_avion",
    label: "Modelos",
    width: 200,
  },
  {
    key: "cantidad_usada",
    label: "Cantidad",
    width: 80,
    align: "right",
  },
  {
    key: "material_principal",
    label: "Material",
    width: 120,
  },
  {
    key: "descripcion_tipo",
    label: "Descripción",
    width: 200,
  },
];

export const tiposAlasReport = {
  getData: async () => {
    const query = `SELECT * FROM SP_REPORTE_TIPOS_ALAS_USADOS()`;
    const result = await pool.query(query);
    return result.rows;
  },

  generatePDF: async () => {
    const data = await tiposAlasReport.getData();

    return generateReportPDF({
      title: "Reporte de Tipos de Alas",
      subtitle: "Análisis de uso en modelos de aviones",
      data,
      columns,
      showChart: data.length > 0,
      chartConfig: {
        valueKey: "cantidad_usada",
        labelKey: "tipo_ala",
        type: "pie",
        title: "Distribución de tipos de alas",
      },
      emptyMessage: "No se encontraron datos de tipos de alas",
    });
  },
};
