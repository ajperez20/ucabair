import { NextResponse } from "next/server";
import { nominaService } from "@/services/nominaService";

export async function GET() {
  try {
    const asistencias = await nominaService.getAsistencias();
    return NextResponse.json(asistencias);
  } catch (error) {
    return NextResponse.json(
      {
        error: {
          status: 500,
          message: "Error al obtener las asistencias",
          details: error.message,
        },
      },
      { status: 500 },
    );
  }
}
