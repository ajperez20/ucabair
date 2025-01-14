import { NextResponse } from "next/server";
import { solicitudService } from "@/services/solicitudService";

export async function POST(request) {
  try {
    const data = await request.json();
    const { cliente_id, tipo, modelo_id, cantidad, descripcion } = data;

    if (!cliente_id || !tipo || !modelo_id || !cantidad) {
      return NextResponse.json(
        {
          error: {
            message: "Faltan datos requeridos",
          },
        },
        { status: 400 },
      );
    }

    const result = await solicitudService.crearSolicitud({
      cliente_id,
      tipo,
      modelo_id,
      cantidad,
      descripcion,
    });

    return NextResponse.json(result);
  } catch (error) {
    console.error("Error en la creación de solicitud:", error);
    return NextResponse.json(
      {
        error: {
          message: "Error al crear la solicitud",
          details: error.message,
        },
      },
      { status: 500 },
    );
  }
}
