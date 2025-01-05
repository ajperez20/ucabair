import { NextResponse } from "next/server";
import { nominaService } from "@/services/nominaService";

export async function GET() {
  try {
    const nominas = await nominaService.getAll();
    return NextResponse.json(nominas);
  } catch (error) {
    return NextResponse.json(
      {
        error: {
          status: 500,
          message: "Error al obtener las nóminas",
          details: error.message,
        },
      },
      { status: 500 },
    );
  }
}

export async function POST(request) {
  try {
    const nomina = await request.json();
    const newNomina = await nominaService.create(nomina);
    return NextResponse.json(newNomina, { status: 201 });
  } catch (error) {
    return NextResponse.json(
      {
        error: {
          status: 500,
          message: "Error al crear la nómina",
          details: error.message,
        },
      },
      { status: 500 },
    );
  }
}
