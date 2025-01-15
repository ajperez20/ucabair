import { NextResponse } from "next/server";
import { solicitudProveedorService } from "@/services/solicitudProveedorService";

export async function GET(request) {
  try {
    const { searchParams } = new URL(request.url);
    const proveedorId = searchParams.get("proveedorId");

    // Si no hay proveedorId, obtener todas las solicitudes (vista admin)
    const solicitudes = proveedorId
      ? await solicitudProveedorService.getSolicitudesByProveedor(proveedorId)
      : await solicitudProveedorService.getAllSolicitudes();

    return NextResponse.json(solicitudes);
  } catch (error) {
    console.error("Error:", error);
    return NextResponse.json(
      {
        error: {
          message: "Error al obtener las solicitudes",
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
    const nuevaSolicitud =
      await solicitudProveedorService.createSolicitud(data);
    return NextResponse.json(nuevaSolicitud, { status: 201 });
  } catch (error) {
    console.error("Error:", error);
    return NextResponse.json(
      {
        error: {
          message: "Error al crear la solicitud",
          details: error.message,
        },
      },
      { status: 500 },
    );
  }
}
