import { NextResponse } from "next/server";
import { solicitudProveedorService } from "@/services/solicitudProveedorService";

export async function GET(request, { params }) {
  try {
    const detalles = await solicitudProveedorService.getSolicitudDetalles(
      params.id,
    );
    return NextResponse.json(detalles);
  } catch (error) {
    console.error("Error:", error);
    return NextResponse.json(
      {
        error: {
          message: "Error al obtener los detalles de la solicitud",
          details: error.message,
        },
      },
      { status: 500 },
    );
  }
}
