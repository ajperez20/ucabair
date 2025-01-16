import { NextResponse } from "next/server";
import { estatusPiezasReport } from "@/services/reports/estatusPiezasReport";

export async function GET() {
  try {
    const pdfBuffer = await estatusPiezasReport.generatePDF();

    return new NextResponse(pdfBuffer, {
      headers: {
        "Content-Type": "application/pdf",
        "Content-Disposition": `attachment; filename=estatus-piezas-${new Date().toISOString().split("T")[0]}.pdf`,
      },
    });
  } catch (error) {
    console.error("Error en GET /api/reportes/estatus-piezas:", error);
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
