import { NextResponse } from "next/server";
import { authService } from "@/services/authService";

export async function POST(request) {
  try {
    const { email, password } = await request.json();
    const user = await authService.login(email, password);

    if (user) {
      // Formatear la respuesta incluyendo toda la información necesaria
      const userData = {
        id: user.usu_id,
        username: user.usu_nombre_usuario,
        email: user.usu_email,
        role: user.rol_nombre,
        roleDescription: user.rol_descripcion,
        privileges: user.privilegios,
        displayName: user.nombre_completo,
        // Información del cliente
        clienteJuridicoId: user.cliente_juridico_id,
        clienteNaturalId: user.cliente_natural_id,
        tipoCliente: user.tipo_cliente,
        // Información del proveedor
        proveedorId: user.proveedor_id,
        proveedorDatos: user.proveedor_datos,
      };

      return NextResponse.json({
        success: true,
        user: userData,
      });
    }

    return NextResponse.json(
      { success: false, message: "Credenciales inválidas" },
      { status: 401 },
    );
  } catch (error) {
    console.error("Error en login:", error);
    return NextResponse.json(
      {
        success: false,
        message: "Error en el servidor",
        details: error.message,
      },
      { status: 500 },
    );
  }
}
