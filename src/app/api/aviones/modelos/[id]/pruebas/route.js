import { NextResponse } from "next/server";
import { pruebaAvionService } from "@/services/pruebaAvionService";

export async function GET(request, { params }) {
  try {
    const pruebas = await pruebaAvionService.getByModeloId(params.id);
    return NextResponse.json(pruebas);
  } catch (error) {
    console.error("Error:", error);
    return NextResponse.json(
      {
        error: {
          status: 500,
          message: "Error al obtener las pruebas del modelo",
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

    // Validar que las pruebas tengan los campos requeridos
    if (!data.pruebas || !Array.isArray(data.pruebas)) {
      throw new Error("Datos de pruebas inválidos");
    }

    for (const prueba of data.pruebas) {
      if (!prueba.prueba_id || !prueba.orden) {
        throw new Error("Cada prueba debe tener un ID y un orden");
      }
    }

    await pruebaAvionService.updateModeloPruebas(params.id, data.pruebas);
    return NextResponse.json({ message: "Pruebas actualizadas exitosamente" });
  } catch (error) {
    console.error("Error:", error);
    return NextResponse.json(
      {
        error: {
          status: 500,
          message: "Error al actualizar las pruebas",
          details: error.message,
        },
      },
      { status: 500 },
    );
  }
}
