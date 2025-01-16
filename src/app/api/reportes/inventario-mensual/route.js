import { NextResponse } from "next/server";
import { inventarioMensualReport } from "@/services/reports/inventarioMensualReport";

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

    const pdfBuffer = await inventarioMensualReport.generatePDF(anio);

    return new NextResponse(pdfBuffer, {
      headers: {
        "Content-Type": "application/pdf",
        "Content-Disposition": `attachment; filename=inventario-mensual-${anio}.pdf`,
      },
    });
  } catch (error) {
    console.error("Error en GET /api/reportes/inventario-mensual:", error);
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
