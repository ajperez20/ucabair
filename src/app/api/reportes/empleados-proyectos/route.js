import { NextResponse } from "next/server";
import { empleadosProyectosReport } from "@/services/reports/empleadosProyectosReport";

export async function GET() {
  try {
    const pdfBuffer = await empleadosProyectosReport.generatePDF();

    return new NextResponse(pdfBuffer, {
      headers: {
        "Content-Type": "application/pdf",
        "Content-Disposition": `attachment; filename=empleados-proyectos.pdf`,
      },
    });
  } catch (error) {
    console.error("Error en GET /api/reportes/empleados-proyectos:", error);
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
