import { NextResponse } from "next/server";
import { asistenciaService } from "@/services/asistenciaService";

export async function GET() {
  try {
    const asistencias = await asistenciaService.getAsistencias();
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

export async function POST(request) {
  try {
    const data = await request.json();
    const asistencia = await asistenciaService.createAsistencia(data);
    return NextResponse.json(asistencia, { status: 201 });
  } catch (error) {
    return NextResponse.json(
      {
        error: {
          status: 500,
          message: "Error al crear la asistencia",
          details: error.message,
        },
      },
      { status: 500 },
    );
  }
}
