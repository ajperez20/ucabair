"use client";

import { useState, useEffect } from "react";
import DataList from "@/components/DataList";
import EditModal from "@/components/EditModal";

const columns = [
  { key: "id", label: "ID" },
  {
    key: "fecha_pago",
    label: "Fecha de Pago",
    format: (value) => new Date(value).toLocaleDateString(),
  },
  {
    key: "total_pago",
    label: "Total",
    format: (value) => `$${value?.toLocaleString() || "0"}`,
  },
  { key: "empleado_nombre", label: "Empleado" },
  { key: "cargo", label: "Cargo" },
  { key: "descripcion", label: "Descripción" },
];

const defaultNomina = {
  empleado: "",
  fecha_pago: new Date().toISOString().split("T")[0],
  total_pago: "",
  descripcion: "",
};

export default function NominasPage() {
  const [nominas, setNominas] = useState([]);
  const [isLoading, setIsLoading] = useState(true);
  const [showModal, setShowModal] = useState(false);
  const [currentNomina, setCurrentNomina] = useState(null);
  const [formFields, setFormFields] = useState([]);
  const [selectedEmpleado, setSelectedEmpleado] = useState(null);

  const fetchNominas = async () => {
    try {
      const response = await fetch("/api/nominas");
      if (!response.ok) throw new Error("Error al cargar nóminas");
      const data = await response.json();
      setNominas(data);
    } catch (error) {
      console.error("Error:", error);
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => {
    fetchNominas();
  }, []);

  const getFormFields = async (isEditing) => {
    try {
      const empleadosRes = await fetch("/api/empleados");
      if (!empleadosRes.ok) throw new Error("Error al cargar empleados");
      const empleados = await empleadosRes.json();

      return [
        {
          name: "empleado",
          label: "Empleado",
          type: "select",
          required: true,
          disabled: isEditing,
          options: empleados.map((emp) => ({
            value: emp.per_id.toString(),
            label: `${emp.per_nombre} ${emp.per_apellido} - ${emp.cargo_actual || "Sin cargo"}`,
          })),
        },
        {
          name: "fecha_pago",
          label: "Fecha de Pago",
          type: "date",
          required: true,
        },
        {
          name: "total_pago",
          label: "Total a Pagar",
          type: "number",
          required: true,
          disabled: true,
        },
        {
          name: "descripcion",
          label: "Descripción",
          type: "text",
          required: true,
        },
      ];
    } catch (error) {
      console.error("Error al cargar campos:", error);
      return [];
    }
  };

  const handleFieldChange = async (name, value) => {
    setCurrentNomina((prev) => ({
      ...prev,
      [name]: value,
    }));

    if (name === "empleado" && value) {
      setSelectedEmpleado(value);

      try {
        const response = await fetch(`/api/nominas/calcular-pago/${value}`);
        if (!response.ok) throw new Error("Error al calcular pago");
        const { pago_total } = await response.json();

        setFormFields((prevFields) =>
          prevFields.map((field) => {
            if (field.name === "total_pago") {
              return {
                ...field,
                value: pago_total,
              };
            }
            if (field.name === "empleado") {
              return {
                ...field,
                value,
              };
            }
            return field;
          }),
        );

        setCurrentNomina((prev) => ({
          ...prev,
          empleado_id: value,
          total_pago: pago_total,
        }));
      } catch (error) {
        console.error("Error al calcular pago:", error);
      }
    }
  };

  const handleEdit = async (nomina) => {
    try {
      const fields = await getFormFields(!!nomina);

      if (nomina) {
        // Modo edición
        const formattedNomina = {
          ...nomina,
          empleado: nomina.empleado_id?.toString(),
          fecha_pago: new Date(nomina.fecha_pago).toISOString().split("T")[0],
        };

        setSelectedEmpleado(nomina.empleado_id?.toString());

        // Actualizar los campos con los valores actuales
        const updatedFields = fields.map((field) => {
          if (field.name === "empleado") {
            return {
              ...field,
              value: formattedNomina.empleado,
              disabled: true,
              // Encontrar la opción correcta para mostrar el nombre del empleado
              options: field.options.map((opt) => ({
                ...opt,
                selected: opt.value === formattedNomina.empleado,
              })),
            };
          }
          if (field.name === "fecha_pago") {
            return {
              ...field,
              value: formattedNomina.fecha_pago,
            };
          }
          if (field.name === "total_pago") {
            return {
              ...field,
              value: formattedNomina.total_pago,
              disabled: true,
            };
          }
          if (field.name === "descripcion") {
            return {
              ...field,
              value: formattedNomina.descripcion,
            };
          }
          return field;
        });

        setFormFields(updatedFields);
        setCurrentNomina(formattedNomina);
      } else {
        // Modo creación
        setSelectedEmpleado(null);
        setFormFields(fields);
        setCurrentNomina(defaultNomina);
      }

      setShowModal(true);
    } catch (error) {
      console.error("Error al preparar el formulario:", error);
    }
  };

  const handleSave = async (formData) => {
    try {
      if (formData.id) {
        // Modo edición: solo actualizar fecha y descripción
        const response = await fetch(`/api/nominas/${formData.id}`, {
          method: "PUT",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            fecha_pago: formData.fecha_pago,
            descripcion: formData.descripcion,
          }),
        });

        if (!response.ok) {
          const error = await response.json();
          throw new Error(error.error?.message || "Error al actualizar");
        }
      } else {
        // Validar que haya un monto a pagar
        if (!formData.total_pago || parseFloat(formData.total_pago) <= 0) {
          throw new Error("No hay monto a pagar para este empleado");
        }

        // Modo creación: registro nuevo
        const response = await fetch("/api/nominas", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            empleado_id: formData.empleado,
            fecha_pago: formData.fecha_pago,
            total_pago: formData.total_pago,
            descripcion: formData.descripcion,
            metodo_id: 1,
            moneda_id: 1,
          }),
        });

        if (!response.ok) {
          const error = await response.json();
          throw new Error(error.error?.message || "Error al guardar");
        }
      }

      setShowModal(false);
      fetchNominas();
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
        data={nominas}
        columns={columns}
        onEdit={handleEdit}
        title="Gestión de Nóminas"
      />

      <EditModal
        isOpen={showModal}
        onClose={() => {
          setShowModal(false);
          setCurrentNomina(null);
          setSelectedEmpleado(null);
        }}
        onSave={handleSave}
        data={currentNomina}
        fields={formFields}
        title={currentNomina?.id ? "Editar Nómina" : "Nueva Nómina"}
        onFieldChange={handleFieldChange}
      />
    </div>
  );
}
