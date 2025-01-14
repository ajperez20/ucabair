import { NextResponse } from "next/server";
import { estatusService } from "@/services/estatusService";

export async function GET() {
  try {
    const estados = await estatusService.getAllEstados();
    return NextResponse.json(estados);
  } catch (error) {
    console.error("Error:", error);
    return NextResponse.json(
      {
        error: {
          message: "Error al obtener los estados",
          details: error.message,
        },
      },
      { status: 500 },
    );
  }
}
