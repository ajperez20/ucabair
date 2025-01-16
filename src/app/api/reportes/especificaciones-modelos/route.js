import { NextResponse } from "next/server";
import { especificacionesModelosReport } from "@/services/reports/especificacionesModelosReport";

export async function GET() {
  try {
    const pdfBuffer = await especificacionesModelosReport.generatePDF();

    return new NextResponse(pdfBuffer, {
      headers: {
        "Content-Type": "application/pdf",
        "Content-Disposition": `attachment; filename=especificaciones-modelos.pdf`,
      },
    });
  } catch (error) {
    console.error(
      "Error en GET /api/reportes/especificaciones-modelos:",
      error,
    );
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
