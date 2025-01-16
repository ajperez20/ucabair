"use client";

import { useState, useEffect, useCallback } from "react";
import DataList from "@/components/DataList";
import EditModal from "@/components/EditModal";

const columns = [
  {
    key: "per_dni",
    label: "DNI",
  },
  {
    key: "empleado_nombre",
    label: "Empleado",
  },
  {
    key: "cargo",
    label: "Cargo",
  },
  {
    key: "dia",
    label: "Día",
    format: (value) => {
      if (!value) return "-";
      return value.charAt(0).toUpperCase() + value.slice(1).toLowerCase();
    },
  },
  {
    key: "asi_hora_inicio",
    label: "Hora Entrada",
    format: (value) => {
      if (!value) return "-";
      return value.substring(0, 5);
    },
  },
  {
    key: "asi_hora_fin",
    label: "Hora Salida",
    format: (value) => {
      if (!value) return "-";
      return value.substring(0, 5);
    },
  },
];

const defaultAsistencia = {
  empleado: "",
  horario: "",
  asi_hora_inicio: "",
  asi_hora_fin: "",
};

const getCreateFormFields = (empleados = []) => [
  {
    name: "empleado",
    label: "Empleado",
    type: "select",
    required: true,
    options: empleados.map((emp) => ({
      value: emp.per_id.toString(),
      label: `${emp.per_nombre} ${emp.per_apellido} - ${emp.cargo_actual || "Sin cargo"}`,
    })),
  },
  {
    name: "horario",
    label: "Día y Horario",
    type: "select",
    required: true,
    options: [],
    depends_on: "empleado",
    description: "Seleccione el día y horario de trabajo",
  },
  {
    name: "asi_hora_inicio",
    label: "Hora de Entrada",
    type: "time",
    required: true,
  },
];

export default function AsistenciasPage() {
  const [asistencias, setAsistencias] = useState([]);
  const [isLoading, setIsLoading] = useState(true);
  const [showModal, setShowModal] = useState(false);
  const [currentAsistencia, setCurrentAsistencia] = useState(null);
  const [formFields, setFormFields] = useState([]);
  const [empleadoHorarios, setEmpleadoHorarios] = useState(null);

  const fetchAsistencias = useCallback(async () => {
    try {
      const response = await fetch("/api/asistencias");
      if (!response.ok) throw new Error("Error al cargar asistencias");
      const data = await response.json();

      setAsistencias(
        data.map((asistencia) => ({
          ...asistencia,
          id: asistencia.asi_id,
        })),
      );
    } catch (error) {
      console.error("Error:", error);
    } finally {
      setIsLoading(false);
    }
  }, []);

  const handleFieldChange = async (name, value) => {
    setCurrentAsistencia((prev) => ({
      ...prev,
      [name]: value,
    }));

    if (name === "empleado" && value) {
      try {
        const response = await fetch(
          `/api/empleados/${value}/horarios-disponibles`,
        );
        if (!response.ok) throw new Error("Error al cargar horarios");

        const data = await response.json();
        setEmpleadoHorarios(data);

        const horariosOptions = data.horarios.map((h) => ({
          value: JSON.stringify({
            fk_per_id: value,
            fk_car_id: data.cargo_id,
            fk_emc_id: data.emc_id,
            fk_hor_id: h.id,
          }),
          label: `${h.dia} - ${h.hora_inicio.substring(0, 5)} a ${h.hora_fin.substring(0, 5)}`,
        }));

        setFormFields((prevFields) =>
          prevFields.map((field) => {
            if (field.name === "horario") {
              return {
                ...field,
                options: horariosOptions,
              };
            }
            return field;
          }),
        );
      } catch (error) {
        console.error("Error al cargar horarios:", error);
      }
    }

    if (name === "horario" && value) {
      try {
        const horarioData = JSON.parse(value);
        const horarioSeleccionado = empleadoHorarios.horarios.find(
          (h) => h.id === horarioData.fk_hor_id,
        );

        if (horarioSeleccionado) {
          setFormFields((prevFields) =>
            prevFields.map((field) => {
              if (field.name === "asi_hora_inicio") {
                return {
                  ...field,
                  defaultValue: horarioSeleccionado.hora_inicio.substring(0, 5),
                };
              }
              return field;
            }),
          );
        }
      } catch (error) {
        console.error("Error al procesar horario:", error);
      }
    }
  };

  const handleEdit = async (asistencia) => {
    if (asistencia) {
      setFormFields([
        {
          name: "asi_hora_fin",
          label: "Hora de Salida",
          type: "time",
          required: true,
        },
      ]);
      setCurrentAsistencia(asistencia);
    } else {
      try {
        const response = await fetch("/api/empleados");
        if (!response.ok) throw new Error("Error al cargar empleados");
        const empleados = await response.json();

        setFormFields(getCreateFormFields(empleados));
        setCurrentAsistencia(defaultAsistencia);
      } catch (error) {
        console.error("Error al cargar empleados:", error);
      }
    }
    setShowModal(true);
  };

  const handleSave = async (formData) => {
    try {
      if (formData.id) {
        const response = await fetch(`/api/asistencias/${formData.id}`, {
          method: "PUT",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ asi_hora_fin: formData.asi_hora_fin }),
        });

        if (!response.ok) throw new Error("Error al registrar salida");
      } else {
        const horarioData = JSON.parse(formData.horario);
        const response = await fetch("/api/asistencias", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            ...horarioData,
            asi_hora_inicio: formData.asi_hora_inicio,
          }),
        });

        if (!response.ok) throw new Error("Error al registrar asistencia");
      }

      setShowModal(false);
      fetchAsistencias();
    } catch (error) {
      console.error("Error:", error);
      throw error;
    }
  };

  useEffect(() => {
    fetchAsistencias();
  }, [fetchAsistencias]);

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
        data={asistencias}
        columns={columns}
        onEdit={handleEdit}
        title="Control de Asistencia"
      />

      <EditModal
        isOpen={showModal}
        onClose={() => {
          setShowModal(false);
          setCurrentAsistencia(null);
          setEmpleadoHorarios(null);
        }}
        onSave={handleSave}
        data={currentAsistencia}
        fields={formFields}
        title={currentAsistencia?.id ? "Registrar Salida" : "Registrar Entrada"}
        onFieldChange={handleFieldChange}
      />
    </div>
  );
}
