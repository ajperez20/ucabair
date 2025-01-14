import { NextResponse } from "next/server";
import { solicitudService } from "@/services/solicitudService";

export async function GET(request) {
  try {
    const { searchParams } = new URL(request.url);
    const clienteId = searchParams.get("clienteId");
    const tipo = searchParams.get("tipo");

    if (!clienteId || !tipo) {
      return NextResponse.json(
        {
          error: {
            message: "Cliente ID y tipo son requeridos",
          },
        },
        { status: 400 },
      );
    }

    const pedidos = await solicitudService.obtenerSolicitudesPorCliente(
      clienteId,
      tipo,
    );
    return NextResponse.json(pedidos);
  } catch (error) {
    console.error("Error:", error);
    return NextResponse.json(
      {
        error: {
          message: "Error al obtener los pedidos",
          details: error.message,
        },
      },
      { status: 500 },
    );
  }
}
