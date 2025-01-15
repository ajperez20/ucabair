import { NextResponse } from "next/server";
import { piezaModeloService } from "@/services/piezaModeloService";

export async function GET(request, { params }) {
  try {
    const piezas = await piezaModeloService.getByModeloId(params.id);
    return NextResponse.json(piezas);
  } catch (error) {
    console.error("Error:", error);
    return NextResponse.json(
      {
        error: {
          status: 500,
          message: "Error al obtener las piezas del modelo",
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

    // Validar que las piezas tengan los campos requeridos
    if (!data.piezas || !Array.isArray(data.piezas)) {
      throw new Error("Datos de piezas inválidos");
    }

    for (const pieza of data.piezas) {
      if (!pieza.pieza_id || !pieza.cantidad || !pieza.fase_id) {
        throw new Error("Cada pieza debe tener ID, cantidad y fase asignada");
      }
    }

    await piezaModeloService.updateModeloPiezas(params.id, data.piezas);
    return NextResponse.json({ message: "Piezas actualizadas exitosamente" });
  } catch (error) {
    console.error("Error:", error);
    return NextResponse.json(
      {
        error: {
          status: 500,
          message: "Error al actualizar las piezas",
          details: error.message,
        },
      },
      { status: 500 },
    );
  }
}
