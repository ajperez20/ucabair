import { generateReportPDF } from "@/utils/pdfGenerator";
import pool from "@/config/database";

const columns = [
  {
    key: "sede_nombre",
    label: "Sede",
    width: 120,
  },
  {
    key: "mes_ingreso",
    label: "Mes",
    width: 100,
  },
  {
    key: "material_nombre",
    label: "Material",
    width: 120,
  },
  {
    key: "cantidad",
    label: "Cantidad",
    width: 80,
    align: "right",
  },
  {
    key: "unidad_medida",
    label: "Unidad",
    width: 80,
  },
  {
    key: "proveedor_nombre",
    label: "Proveedor",
    width: 120,
  },
  {
    key: "costo_unitario",
    label: "Costo Unit.",
    width: 100,
    align: "right",
    format: (value) => `$${Number(value).toLocaleString()}`,
  },
  {
    key: "costo_total",
    label: "Costo Total",
    width: 100,
    align: "right",
    format: (value) => `$${Number(value).toLocaleString()}`,
  },
  {
    key: "estado_solicitud",
    label: "Estado",
    width: 100,
  },
];

export const ingresosInventarioReport = {
  getData: async (anio) => {
    if (!anio) throw new Error("El año es requerido");

    const query = `SELECT * FROM SP_REPORTE_INGRESOS_INVENTARIO($1)`;
    const result = await pool.query(query, [anio]);
    return result.rows;
  },

  generatePDF: async (anio) => {
    const data = await ingresosInventarioReport.getData(anio);

    return generateReportPDF({
      title: "Reporte de Ingresos a Inventario",
      subtitle: `Año: ${anio}`,
      data,
      columns,
      showChart: data.length > 0,
      chartConfig: {
        valueKey: "costo_total",
        labelKey: "mes_ingreso",
        type: "bar",
        groupBy: "sede_nombre",
        title: "Costos de inventario por sede y mes",
      },
      emptyMessage: `No se encontraron ingresos a inventario para el año ${anio}`,
    });
  },
};
