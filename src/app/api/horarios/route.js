import { NextResponse } from "next/server";
import { horarioService } from "@/services/horarioService";

export async function GET() {
  try {
    const horarios = await horarioService.getAll();
    return NextResponse.json(horarios);
  } catch (error) {
    console.log(error);
    return NextResponse.json(
      {
        error: {
          status: 500,
          message: "Error al obtener los horarios",
          details: error.message,
        },
      },
      { status: 500 },
    );
  }
}

export async function POST(request) {
  try {
    const horario = await request.json();
    const newHorario = await horarioService.create(horario);
    return NextResponse.json(newHorario, { status: 201 });
  } catch (error) {
    console.log(error);
    return NextResponse.json(
      {
        error: {
          status: 500,
          message: "Error al crear el horario",
          details: error.message,
        },
      },
      { status: 500 },
    );
  }
}
