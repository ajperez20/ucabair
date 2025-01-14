import { NextResponse } from "next/server";
import { estatusService } from "@/services/estatusService";

export async function GET(request, { params }) {
  try {
    const estado = await estatusService.getEstadoById(params.id);

    if (!estado) {
      return NextResponse.json(
        { error: { message: "Estado no encontrado" } },
        { status: 404 },
      );
    }

    return NextResponse.json(estado);
  } catch (error) {
    console.error("Error:", error);
    return NextResponse.json(
      {
        error: {
          message: "Error al obtener el estado",
          details: error.message,
        },
      },
      { status: 500 },
    );
  }
}
