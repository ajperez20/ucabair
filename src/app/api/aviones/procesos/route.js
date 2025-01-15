import { NextResponse } from "next/server";
import { procesosAvionService } from "@/services/procesosAvionService";

export async function GET() {
  try {
    const procesos = await procesosAvionService.getAll();
    return NextResponse.json(procesos);
  } catch (error) {
    console.error("Error:", error);
    return NextResponse.json(
      {
        error: {
          status: 500,
          message: "Error al obtener los procesos",
          details: error.message,
        },
      },
      { status: 500 },
    );
  }
}
