import { NextResponse } from "next/server";
import { horarioService } from "@/services/horarioService";

export async function GET(request, { params }) {
  try {
    const horario = await horarioService.getById(params.id);
    return NextResponse.json(horario);
  } catch (error) {
    console.log(error);
    return NextResponse.json(
      {
        error: {
          status: 500,
          message: "Error al obtener el horario",
          details: error.message,
        },
      },
      { status: 500 },
    );
  }
}

export async function PUT(request, { params }) {
  try {
    const horario = await request.json();
    const updatedHorario = await horarioService.update(params.id, horario);
    return NextResponse.json(updatedHorario);
  } catch (error) {
    console.log(error);
    return NextResponse.json(
      {
        error: {
          status: 500,
          message: "Error al actualizar el horario",
          details: error.message,
        },
      },
      { status: 500 },
    );
  }
}

export async function DELETE(request, { params }) {
  try {
    await horarioService.delete(params.id);
    return NextResponse.json({ message: "Horario eliminado correctamente" });
  } catch (error) {
    console.log(error);
    return NextResponse.json(
      {
        error: {
          status: 500,
          message: "Error al eliminar el horario",
          details: error.message,
        },
      },
      { status: 500 },
    );
  }
}
