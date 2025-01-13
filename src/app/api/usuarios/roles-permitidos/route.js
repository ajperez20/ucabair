import { NextResponse } from "next/server";
import { rolService } from "@/services/rolService";

export async function GET(request) {
  try {
    const { searchParams } = new URL(request.url);
    const tipo = searchParams.get("tipo");

    if (!tipo) {
      return NextResponse.json(
        { error: "Tipo de usuario requerido" },
        { status: 400 },
      );
    }

    // Obtener todos los roles
    const roles = await rolService.getAll();

    // Filtrar según el tipo de usuario
    let rolesPermitidos;
    switch (tipo) {
      case "EMPLEADO":
        rolesPermitidos = roles.filter((rol) =>
          ["EMPLEADO", "ADMINISTRADOR"].includes(rol.rol_nombre),
        );
        break;
      case "CLIENTE JURIDICO":
      case "CLIENTE NATURAL":
        rolesPermitidos = roles.filter((rol) => rol.rol_nombre === "CLIENTE");
        break;
      case "PROVEEDOR":
        rolesPermitidos = roles.filter((rol) => rol.rol_nombre === "PROVEEDOR");
        break;
      default:
        return NextResponse.json(
          { error: "Tipo de usuario no válido" },
          { status: 400 },
        );
    }

    return NextResponse.json(rolesPermitidos);
  } catch (error) {
    console.error("Error en GET /api/usuarios/roles-permitidos:", error);
    return NextResponse.json(
      {
        error: {
          message: "Error al obtener roles permitidos",
          details: error.message,
        },
      },
      { status: 500 },
    );
  }
}
