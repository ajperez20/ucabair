import { NextResponse } from "next/server";
import { caracteristicasAvionService } from "@/services/caracteristicasAvionService";

export async function GET(request, { params }) {
  try {
    const caracteristicas = await caracteristicasAvionService.getByModeloId(
      params.id,
    );
    return NextResponse.json(caracteristicas);
  } catch (error) {
    console.error("Error:", error);
    return NextResponse.json(
      {
        error: {
          status: 500,
          message: "Error al obtener las características del modelo",
          details: error.message,
        },
      },
      { status: 500 },
    );
  }
}
