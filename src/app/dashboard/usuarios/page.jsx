"use client";

import { useState, useEffect, useCallback } from "react";
import DataList from "@/components/DataList";
import EditModal from "@/components/EditModal";

const columns = [
  {
    key: "usu_nombre_usuario",
    label: "Usuario",
  },
  {
    key: "usu_email",
    label: "Email",
  },
  {
    key: "rol_nombre",
    label: "Rol",
  },
  {
    key: "entidad_nombre",
    label: "Nombre",
  },
  {
    key: "tipo_usuario",
    label: "Tipo",
    format: (value) => {
      switch (value) {
        case "EMPLEADO":
          return "Empleado";
        case "CLIENTE JURIDICO":
          return "Cliente Jurídico";
        case "CLIENTE NATURAL":
          return "Cliente Natural";
        case "PROVEEDOR":
          return "Proveedor";
        default:
          return value;
      }
    },
  },
];

const defaultUsuario = {
  usu_nombre_usuario: "",
  usu_email: "",
  usu_contrasena: "",
  fk_rol_id: "",
  tipo_usuario: "",
  entidad_id: "",
};

const getEditFormFields = [
  {
    name: "usu_nombre_usuario",
    label: "Usuario",
    type: "text",
    required: true,
    placeholder: "Nombre de usuario",
    maxLength: 30,
  },
  {
    name: "usu_email",
    label: "Email",
    type: "email",
    required: true,
    placeholder: "ejemplo@ucabair.com",
    maxLength: 60,
  },
  {
    name: "usu_contrasena",
    label: "Contraseña",
    type: "password",
    required: false,
    placeholder: "Dejar en blanco para mantener la actual",
    maxLength: 30,
  },
  {
    name: "fk_rol_id",
    label: "Rol",
    type: "select",
    required: true,
    options: [],
  },
];

const getCreateFormFields = [
  {
    name: "tipo_usuario",
    label: "Tipo de Usuario",
    type: "select",
    required: true,
    options: [
      { value: "EMPLEADO", label: "Empleado" },
      { value: "CLIENTE JURIDICO", label: "Cliente Jurídico" },
      { value: "CLIENTE NATURAL", label: "Cliente Natural" },
      { value: "PROVEEDOR", label: "Proveedor" },
    ],
  },
  {
    name: "fk_rol_id",
    label: "Rol",
    type: "select",
    required: true,
    options: [],
  },
  {
    name: "entidad_id",
    label: "Asignar a",
    type: "select",
    required: true,
    options: [],
  },
  {
    name: "usu_nombre_usuario",
    label: "Usuario",
    type: "text",
    required: true,
    placeholder: "Nombre de usuario",
    maxLength: 30,
  },
  {
    name: "usu_email",
    label: "Email",
    type: "email",
    required: true,
    placeholder: "correo@ucabair.com",
    maxLength: 60,
  },
  {
    name: "usu_contrasena",
    label: "Contraseña",
    type: "password",
    required: true,
    placeholder: "Contraseña",
    maxLength: 30,
  },
];

export default function UsuariosPage() {
  const [usuarios, setUsuarios] = useState([]);
  const [isLoading, setIsLoading] = useState(true);
  const [showModal, setShowModal] = useState(false);
  const [currentUsuario, setCurrentUsuario] = useState(null);
  const [formFields, setFormFields] = useState([]);

  const fetchUsuarios = useCallback(async () => {
    try {
      const response = await fetch("/api/usuarios");
      if (!response.ok) throw new Error("Error al cargar usuarios");
      const data = await response.json();
      setUsuarios(
        data.map((usuario) => ({
          id: usuario.usu_id,
          ...usuario,
        })),
      );
      setIsLoading(false);
    } catch (error) {
      console.error("Error:", error);
      setIsLoading(false);
    }
  }, []);

  useEffect(() => {
    fetchUsuarios();
  }, [fetchUsuarios]);

  const handleEdit = async (usuario) => {
    if (usuario) {
      try {
        // Obtener los detalles del usuario y sus roles permitidos en paralelo
        const [usuarioRes, rolesRes] = await Promise.all([
          fetch(`/api/usuarios/${usuario.id}`),
          fetch(`/api/usuarios/roles-permitidos?tipo=${usuario.tipo_usuario}`),
        ]);

        if (!usuarioRes.ok)
          throw new Error("Error al cargar detalles del usuario");
        if (!rolesRes.ok) throw new Error("Error al cargar roles");

        const [usuarioDetallado, roles] = await Promise.all([
          usuarioRes.json(),
          rolesRes.json(),
        ]);

        // Configurar campos para edición
        const editFields = getEditFormFields.map((field) => {
          if (field.name === "fk_rol_id") {
            return {
              ...field,
              options: roles.map((r) => ({
                value: r.rol_id,
                label: r.rol_nombre,
              })),
            };
          }
          return field;
        });

        setFormFields(editFields);
        setCurrentUsuario({
          id: usuarioDetallado.usu_id,
          usu_nombre_usuario: usuarioDetallado.usu_nombre_usuario,
          usu_email: usuarioDetallado.usu_email,
          usu_contrasena: "",
          fk_rol_id: usuarioDetallado.fk_rol_id,
          tipo_usuario: usuarioDetallado.tipo_usuario,
        });
      } catch (error) {
        console.error("Error:", error);
        alert("Error al cargar los detalles del usuario");
      }
      setShowModal(true);
    } else {
      setFormFields(getCreateFormFields);
      setCurrentUsuario(defaultUsuario);
      setShowModal(true);
    }
  };

  const handleFieldChange = async (name, value) => {
    if (name === "tipo_usuario" && !currentUsuario?.id) {
      try {
        const [rolesRes, entidadesRes] = await Promise.all([
          fetch(`/api/usuarios/roles-permitidos?tipo=${value}`),
          fetch(
            value === "EMPLEADO"
              ? "/api/empleados"
              : value === "CLIENTE JURIDICO"
                ? "/api/clientes/juridicos"
                : value === "CLIENTE NATURAL"
                  ? "/api/clientes/naturales"
                  : "/api/proveedores",
          ),
        ]);

        const [roles, entidades] = await Promise.all([
          rolesRes.json(),
          entidadesRes.json(),
        ]);

        // Filtrar entidades sin usuario asignado
        const entidadesDisponibles = entidades
          .filter((e) => !e.usu_id)
          .map((e) => {
            switch (value) {
              case "EMPLEADO":
                return {
                  value: e.per_id,
                  label: `${e.per_nombre} ${e.per_apellido}`,
                };
              case "CLIENTE JURIDICO":
                return {
                  value: e.cjd_id,
                  label: e.cjd_nombre,
                };
              case "CLIENTE NATURAL":
                return {
                  value: e.ctn_id,
                  label: `${e.ctn_nombre} ${e.ctn_apellido}`,
                };
              case "PROVEEDOR":
                return {
                  value: e.com_id,
                  label: e.com_nombre,
                };
              default:
                return null;
            }
          })
          .filter(Boolean);

        setFormFields((prevFields) =>
          prevFields.map((field) => {
            if (field.name === "fk_rol_id") {
              return {
                ...field,
                options: roles.map((r) => ({
                  value: r.rol_id,
                  label: r.rol_nombre,
                })),
              };
            }
            if (field.name === "entidad_id") {
              return {
                ...field,
                options: entidadesDisponibles,
              };
            }
            return field;
          }),
        );

        setCurrentUsuario((prev) => ({
          ...prev,
          [name]: value,
          fk_rol_id: "",
          entidad_id: "",
        }));
      } catch (error) {
        console.error("Error al actualizar campos:", error);
      }
    }
  };

  const handleDelete = async (usuario) => {
    if (!confirm("¿Está seguro de eliminar este usuario?")) return;

    try {
      const response = await fetch(`/api/usuarios/${usuario.id}`, {
        method: "DELETE",
      });

      if (!response.ok) {
        const error = await response.json();
        throw new Error(error.error?.message || "Error al eliminar");
      }

      fetchUsuarios();
    } catch (error) {
      console.error("Error:", error);
      alert(error.message);
    }
  };

  const handleSave = async (formData) => {
    try {
      const url = formData.id
        ? `/api/usuarios/${formData.id}`
        : "/api/usuarios";

      // Preparar los datos para enviar
      const userData = {
        usu_nombre_usuario: formData.usu_nombre_usuario,
        usu_email: formData.usu_email,
        fk_rol_id: formData.fk_rol_id,
        tipo_usuario: formData.tipo_usuario,
      };

      // Solo incluir la contraseña si se proporcionó una nueva
      if (formData.usu_contrasena) {
        userData.usu_contrasena = formData.usu_contrasena;
      }

      const response = await fetch(url, {
        method: formData.id ? "PUT" : "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(userData),
      });

      if (!response.ok) {
        const error = await response.json();
        throw new Error(error.error?.message || "Error al guardar");
      }

      setShowModal(false);
      fetchUsuarios();
    } catch (error) {
      console.error("Error:", error);
      throw error;
    }
  };

  if (isLoading) {
    return (
      <div className="flex items-center justify-center min-h-[400px]">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600"></div>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      <DataList
        data={usuarios}
        columns={columns}
        onEdit={handleEdit}
        onDelete={handleDelete}
        title="Gestión de Usuarios"
      />

      <EditModal
        isOpen={showModal}
        onClose={() => {
          setShowModal(false);
          setCurrentUsuario(null);
        }}
        onSave={handleSave}
        data={currentUsuario}
        fields={formFields}
        title={currentUsuario?.id ? "Editar Usuario" : "Nuevo Usuario"}
        onFieldChange={handleFieldChange}
      />
    </div>
  );
}
