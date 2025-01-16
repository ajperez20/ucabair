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
    const data = await request.json();
    const nomina = await nominaService.registrarPago(data);
    return NextResponse.json(nomina, { status: 201 });
  } catch (error) {
    return NextResponse.json(
      {
        error: {
          message: "Error al crear nómina",
          details: error.message,
        },
      },
      { status: 500 },
    );
  }
}
