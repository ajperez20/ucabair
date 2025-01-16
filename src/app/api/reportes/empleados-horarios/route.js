import { NextResponse } from "next/server";
import { empleadosHorariosReport } from "@/services/reports/empleadosHorariosReport";

export async function GET() {
  try {
    const pdfBuffer = await empleadosHorariosReport.generatePDF();

    return new NextResponse(pdfBuffer, {
      headers: {
        "Content-Type": "application/pdf",
        "Content-Disposition": `attachment; filename=empleados-horarios.pdf`,
      },
    });
  } catch (error) {
    console.error("Error en GET /api/reportes/empleados-horarios:", error);
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
