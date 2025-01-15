import { NextResponse } from "next/server";
import { procesosAvionService } from "@/services/procesosAvionService";

export async function GET(request, { params }) {
  try {
    const procesos = await procesosAvionService.getByModeloId(params.id);
    return NextResponse.json(procesos);
  } catch (error) {
    console.error("Error:", error);
    return NextResponse.json(
      {
        error: {
          status: 500,
          message: "Error al obtener los procesos del modelo",
          details: error.message,
        },
      },
      { status: 500 },
    );
  }
}

export async function PUT(request, { params }) {
  try {
    const data = await request.json();

    // Validar que los procesos tengan los campos requeridos
    if (!data.procesos || !Array.isArray(data.procesos)) {
      throw new Error("Datos de procesos inválidos");
    }

    for (const proceso of data.procesos) {
      if (!proceso.proceso_id) {
        throw new Error("Cada proceso debe tener un ID");
      }
    }

    await procesosAvionService.updateModeloProcesos(params.id, data.procesos);
    return NextResponse.json({ message: "Procesos actualizados exitosamente" });
  } catch (error) {
    console.error("Error:", error);
    return NextResponse.json(
      {
        error: {
          status: 500,
          message: "Error al actualizar los procesos",
          details: error.message,
        },
      },
      { status: 500 },
    );
  }
}
