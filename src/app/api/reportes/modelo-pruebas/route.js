import { NextResponse } from "next/server";
import { modeloPruebasReport } from "@/services/reports/modeloPruebasReport";

export async function GET() {
  try {
    const pdfBuffer = await modeloPruebasReport.generatePDF();

    return new NextResponse(pdfBuffer, {
      headers: {
        "Content-Type": "application/pdf",
        "Content-Disposition": `attachment; filename=modelo-pruebas.pdf`,
      },
    });
  } catch (error) {
    console.error("Error en GET /api/reportes/modelo-pruebas:", error);
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
