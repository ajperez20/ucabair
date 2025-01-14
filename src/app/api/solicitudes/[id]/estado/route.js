import { NextResponse } from "next/server";
import { solicitudService } from "@/services/solicitudService";

export async function PUT(request, { params }) {
  try {
    const { estadoId } = await request.json();

    // Validamos que el estadoId sea válido
    if (!estadoId) {
      return NextResponse.json(
        { error: { message: "Estado no válido" } },
        { status: 400 },
      );
    }

    // Actualizamos el estado
    const resultado = await solicitudService.actualizarEstado(
      params.id,
      estadoId,
    );

    return NextResponse.json({
      message: "Estado actualizado correctamente",
      data: resultado,
    });
  } catch (error) {
    console.error("Error al actualizar estado:", error);
    return NextResponse.json(
      {
        error: {
          message: "Error al actualizar el estado",
          details: error.message,
        },
      },
      { status: 500 },
    );
  }
}
