import { NextResponse } from "next/server";
import { listadoProveedoresReport } from "@/services/reports/listadoProveedoresReport";

export async function GET() {
  try {
    const pdfBuffer = await listadoProveedoresReport.generatePDF();

    return new NextResponse(pdfBuffer, {
      headers: {
        "Content-Type": "application/pdf",
        "Content-Disposition": `attachment; filename=listado-proveedores.pdf`,
      },
    });
  } catch (error) {
    console.error("Error en GET /api/reportes/listado-proveedores:", error);
    return NextResponse.json(
      {
        error: {
          message: "Error al generar el reporte",
          details: error.message,
        },
      },
      { status: 500 },
    );
  }
}
