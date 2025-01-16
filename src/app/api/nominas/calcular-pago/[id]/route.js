import { NextResponse } from "next/server";
import { nominaService } from "@/services/nominaService";

export async function GET(request, { params }) {
  try {
    const { id } = params;
    const resultado = await nominaService.calcularPago(id);
    return NextResponse.json(resultado);
  } catch (error) {
    return NextResponse.json(
      {
        error: {
          message: "Error al calcular pago",
          details: error.message,
        },
      },
      { status: 500 },
    );
  }
}
