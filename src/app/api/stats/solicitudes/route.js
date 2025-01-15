import { NextResponse } from "next/server";
import { useSolicitudesStatsService } from "@/services/stats/useSolicitudesStatsService";

export async function GET() {
  try {
    const stats = await useSolicitudesStatsService.getStats();
    return NextResponse.json(stats);
  } catch (error) {
    console.error("Error:", error);
    return NextResponse.json(
      {
        error: {
          message: "Error al obtener estadísticas de solicitudes",
          details: error.message,
        },
      },
      { status: 500 },
    );
  }
}
