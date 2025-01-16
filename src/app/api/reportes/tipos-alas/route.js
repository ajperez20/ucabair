import { NextResponse } from "next/server";
import { tiposAlasReport } from "@/services/reports/tiposAlasReport";

export async function GET() {
  try {
    const pdfBuffer = await tiposAlasReport.generatePDF();

    return new NextResponse(pdfBuffer, {
      headers: {
        "Content-Type": "application/pdf",
        "Content-Disposition": `attachment; filename=tipos-alas.pdf`,
      },
    });
  } catch (error) {
    console.error("Error en GET /api/reportes/tipos-alas:", error);
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
