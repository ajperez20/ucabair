import { NextResponse } from "next/server";
import { employeeService } from "@/services/employeeService";

export async function GET(request, { params }) {
  try {
    const horarios = await employeeService.getHorariosDisponibles(params.id);
    return NextResponse.json(horarios);
  } catch (error) {
    return NextResponse.json(
      {
        error: {
          message: "Error al obtener horarios disponibles",
          details: error.message,
        },
      },
      { status: 500 },
    );
  }
}
