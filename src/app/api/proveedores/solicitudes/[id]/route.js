import { NextResponse } from "next/server";
import { solicitudProveedorService } from "@/services/solicitudProveedorService";

export async function GET(request, { params }) {
  try {
    const solicitud = await solicitudProveedorService.getSolicitudById(
      params.id,
    );
    if (!solicitud) {
      return NextResponse.json(
        { error: { message: "Solicitud no encontrada" } },
        { status: 404 },
      );
    }
    return NextResponse.json(solicitud);
  } catch (error) {
    console.error("Error:", error);
    return NextResponse.json(
      {
        error: {
          message: "Error al obtener la solicitud",
          details: error.message,
        },
      },
      { status: 500 },
    );
  }
}
