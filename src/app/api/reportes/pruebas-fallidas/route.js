import { NextResponse } from "next/server";
import { pruebasFallidasReport } from "@/services/reports/pruebasFallidasReport";

export async function GET(request) {
  try {
    const { searchParams } = new URL(request.url);
    const anio = parseInt(searchParams.get("anio"));

    if (!anio || isNaN(anio)) {
      return NextResponse.json(
        {
          error: {
            message: "El año es requerido y debe ser un número válido",
          },
        },
        { status: 400 },
      );
    }

    const pdfBuffer = await pruebasFallidasReport.generatePDF(anio);

    return new NextResponse(pdfBuffer, {
      headers: {
        "Content-Type": "application/pdf",
        "Content-Disposition": `attachment; filename=pruebas-fallidas-${anio}.pdf`,
      },
    });
  } catch (error) {
    console.error("Error en GET /api/reportes/pruebas-fallidas:", error);
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
