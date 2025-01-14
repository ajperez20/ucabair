import { NextResponse } from "next/server";
import { solicitudService } from "@/services/solicitudService";

export async function GET() {
  try {
    const solicitudes = await solicitudService.obtenerTodasSolicitudes();
    return NextResponse.json(solicitudes);
  } catch (error) {
    return NextResponse.json(
      {
        error: {
          message: "Error al obtener las solicitudes",
          details: error.message,
        },
      },
      { status: 500 },
    );
  }
}
