import { generateReportPDF } from "@/utils/pdfGenerator";
import pool from "@/config/database";

const columns = [
  {
    key: "mes",
    label: "Mes",
    width: 100,
  },
  {
    key: "proveedor_nombre",
    label: "Proveedor",
    width: 150,
  },
  {
    key: "solicitud_id",
    label: "Solicitud #",
    width: 90,
    align: "right",
  },
  {
    key: "fecha_pago",
    label: "Fecha",
    width: 100,
    format: (value) => new Date(value).toLocaleDateString(),
  },
  {
    key: "monto_pagado",
    label: "Monto",
    width: 120,
    align: "right",
    format: (value) => `$${Number(value).toLocaleString()}`,
  },
  {
    key: "metodo_pago",
    label: "Método",
    width: 120,
  },
  {
    key: "moneda",
    label: "Moneda",
    width: 80,
  },
  {
    key: "tasa_cambio",
    label: "Tasa",
    width: 80,
    align: "right",
    format: (value) => Number(value).toFixed(2),
  },
  {
    key: "estado_pago",
    label: "Estado",
    width: 100,
  },
];

export const pagosProveedoresReport = {
  getData: async (anio) => {
    if (!anio) throw new Error("El año es requerido");

    const query = `SELECT * FROM SP_REPORTE_PAGOS_PROVEEDORES($1)`;
    const result = await pool.query(query, [anio]);
    return result.rows;
  },

  generatePDF: async (anio) => {
    const data = await pagosProveedoresReport.getData(anio);

    return generateReportPDF({
      title: "Reporte de Pagos a Proveedores",
      subtitle: `Año: ${anio}`,
      data,
      columns,
      showChart: data.length > 0,
      chartConfig: {
        valueKey: "monto_pagado",
        labelKey: "mes",
        type: "bar",
        groupBy: "proveedor_nombre",
        title: "Pagos mensuales por proveedor",
      },
      emptyMessage: `No se encontraron pagos a proveedores para el año ${anio}`,
    });
  },
};
