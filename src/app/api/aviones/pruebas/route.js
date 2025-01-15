import { NextResponse } from "next/server";
import { pruebaAvionService } from "@/services/pruebaAvionService";

export async function GET() {
  try {
    const pruebas = await pruebaAvionService.getAll();
    return NextResponse.json(pruebas);
  } catch (error) {
    console.error("Error:", error);
    return NextResponse.json(
      {
        error: {
          status: 500,
          message: "Error al obtener las pruebas",
          details: error.message,
        },
      },
      { status: 500 },
    );
  }
}
