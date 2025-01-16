import { NextResponse } from "next/server";
import { nominaService } from "@/services/nominaService";

export async function PUT(request, { params }) {
  try {
    const { id } = params;
    const data = await request.json();

    // Validar que solo se envíen los campos permitidos para edición
    const nominaActualizada = await nominaService.update(id, {
      fecha_pago: data.fecha_pago,
      descripcion: data.descripcion,
    });

    if (!nominaActualizada) {
      return NextResponse.json(
        {
          error: {
            message: "Nómina no encontrada",
          },
        },
        { status: 404 },
      );
    }

    return NextResponse.json(nominaActualizada);
  } catch (error) {
    console.error("Error al actualizar nómina:", error);
    return NextResponse.json(
      {
        error: {
          message: "Error al actualizar nómina",
          details: error.message,
        },
      },
      { status: 500 },
    );
  }
}

export async function GET(request, { params }) {
  try {
    const { id } = params;
    const nomina = await nominaService.getById(id);

    if (!nomina) {
      return NextResponse.json(
        {
          error: {
            message: "Nómina no encontrada",
          },
        },
        { status: 404 },
      );
    }

    return NextResponse.json(nomina);
  } catch (error) {
    return NextResponse.json(
      {
        error: {
          message: "Error al obtener nómina",
          details: error.message,
        },
      },
      { status: 500 },
    );
  }
}

export async function DELETE(request, { params }) {
  try {
    const { id } = params;
    await nominaService.delete(id);
    return NextResponse.json({ message: "Nómina eliminada exitosamente" });
  } catch (error) {
    return NextResponse.json(
      {
        error: {
          message: "Error al eliminar nómina",
          details: error.message,
        },
      },
      { status: 500 },
    );
  }
}
