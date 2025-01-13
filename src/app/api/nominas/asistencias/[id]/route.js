import { NextResponse } from "next/server";
import { nominaService } from "@/services/nominaService";

export async function PUT(request, { params }) {
  try {
    const { id } = params;
    const data = await request.json();

    const asistenciaActualizada = await nominaService.updateAsistencia(
      id,
      data,
    );

    if (!asistenciaActualizada) {
      return NextResponse.json(
        { error: "Asistencia no encontrada" },
        { status: 404 },
      );
    }

    return NextResponse.json(asistenciaActualizada);
  } catch (error) {
    console.error("Error en PUT /api/nominas/asistencias/[id]:", error);
    return NextResponse.json(
      {
        error: {
          message: "Error al actualizar la asistencia",
          details: error.message,
        },
      },
      { status: 500 },
    );
  }
}
