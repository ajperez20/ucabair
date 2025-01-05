import { NextResponse } from "next/server";
import { employeeService } from "@/services/employeeService";

export async function GET(request, { params }) {
  try {
    const data = await employeeService.getCargoHorario(params.id);
    return NextResponse.json(data);
  } catch (error) {
    return NextResponse.json(
      {
        error: {
          message: "Error al obtener cargo y horarios",
          details: error.message,
        },
      },
      { status: 500 },
    );
  }
}

export async function PUT(request, { params }) {
  try {
    const body = await request.json();
    const data = await employeeService.updateCargoHorario(params.id, body);
    return NextResponse.json(data);
  } catch (error) {
    return NextResponse.json(
      {
        error: {
          message: "Error al actualizar cargo y horarios",
          details: error.message,
        },
      },
      { status: 500 },
    );
  }
}
