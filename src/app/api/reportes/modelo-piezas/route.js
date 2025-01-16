import { NextResponse } from "next/server";
import { modeloPiezasReport } from "@/services/reports/modeloPiezasReport";

export async function GET() {
  try {
    const pdfBuffer = await modeloPiezasReport.generatePDF();

    return new NextResponse(pdfBuffer, {
      headers: {
        "Content-Type": "application/pdf",
        "Content-Disposition": `attachment; filename=modelo-piezas.pdf`,
      },
    });
  } catch (error) {
    console.error("Error en GET /api/reportes/modelo-piezas:", error);
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
