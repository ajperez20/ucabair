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
  {
    key: "estado",
    label: "Estado",
    format: (value, row) => {
      // Si no hay datos, retornamos guión
      if (!row || !row.dia || !row.asi_hora_inicio) return "-";

      // Si tiene hora de fin, está completado
      if (row.asi_hora_fin) return "Completado";

      // Obtener el día actual en español y en mayúsculas
      const diasSemana = {
        SUNDAY: "DOMINGO",
        MONDAY: "LUNES",
        TUESDAY: "MARTES",
        WEDNESDAY: "MIÉRCOLES",
        THURSDAY: "JUEVES",
        FRIDAY: "VIERNES",
        SATURDAY: "SÁBADO",
      };

      const diaActual =
        diasSemana[
          new Date().toLocaleString("en-US", { weekday: "uppercase" })
        ];

      // Comparar con el día de la asistencia
      return row.dia === diaActual ? "En curso" : "Incompleto";
    },
  },
];

const defaultAsistencia = {
  fk_per_id: "",
  fk_car_id: "",
  fk_emc_id: "",
  fk_hor_id: "",
  asi_hora_inicio: "",
  asi_hora_fin: "",
};

const getCreateFormFields = [
  {
    name: "empleado",
    label: "Empleado",
    type: "select",
    required: true,
    options: [],
  },
  {
    name: "horario",
    label: "Horario",
    type: "select",
    required: true,
    options: [],
    depends_on: "empleado",
  },
  {
    name: "asi_hora_inicio",
    label: "Hora de Entrada",
    type: "time",
    required: true,
  },
];

const getEditFormFields = [
  {
    name: "asi_hora_fin",
    label: "Hora de Salida",
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

  const fetchAsistencias = useCallback(async () => {
    try {
      const response = await fetch("/api/nominas/asistencias");
      if (!response.ok) throw new Error("Error al cargar asistencias");
      const data = await response.json();

      // Agregar estado directamente en el mapeo de datos
      setAsistencias(
        data.map((asistencia) => ({
          ...asistencia,
          id: asistencia.asi_id,
          estado: asistencia.asi_hora_fin
            ? "Completado"
            : asistencia.dia ===
                new Date().toLocaleString("es-ES", { weekday: "uppercase" })
              ? "En curso"
              : "Incompleto",
        })),
      );
    } catch (error) {
      console.error("Error:", error);
    } finally {
      setIsLoading(false);
    }
  }, []);

  const handleFieldChange = async (name, value) => {
    if (name === "empleado") {
      try {
        const response = await fetch(
          `/api/empleados/${value}/horarios-disponibles`,
        );
        if (!response.ok) throw new Error("Error al cargar horarios");
        const horarios = await response.json();

        setFormFields((prevFields) =>
          prevFields.map((field) => {
            if (field.name === "horario") {
              return {
                ...field,
                options: horarios.map((h) => ({
                  value: JSON.stringify({
                    fk_per_id: h.fk_per_id,
                    fk_car_id: h.fk_car_id,
                    fk_emc_id: h.fk_emc_id,
                    fk_hor_id: h.fk_hor_id,
                  }),
                  label: `${new Date(h.fecha).toLocaleDateString("es-ES")} - ${h.hor_hora_inicio.substring(0, 5)} a ${h.hor_hora_fin.substring(0, 5)} - ${h.car_nombre}`,
                })),
              };
            }
            return field;
          }),
        );
      } catch (error) {
        console.error("Error al cargar horarios:", error);
      }
    }
  };

  const handleEdit = async (asistencia) => {
    if (asistencia) {
      setFormFields(getEditFormFields);
      setCurrentAsistencia(asistencia);
    } else {
      try {
        const response = await fetch("/api/empleados");
        if (!response.ok) throw new Error("Error al cargar empleados");
        const empleados = await response.json();

        const createFields = getCreateFormFields.map((field) => {
          if (field.name === "empleado") {
            return {
              ...field,
              options: empleados.map((emp) => ({
                value: emp.per_id,
                label: `${emp.per_nombre} ${emp.per_apellido}`,
              })),
            };
          }
          return field;
        });

        setFormFields(createFields);
        setCurrentAsistencia(defaultAsistencia);
      } catch (error) {
        console.error("Error al cargar empleados:", error);
      }
    }
    setShowModal(true);
  };

  const handleSave = async (formData) => {
    if (formData.id) {
      // Registrar salida
      const response = await fetch(`/api/nominas/asistencias/${formData.id}`, {
        method: "PUT",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          asi_hora_fin: formData.asi_hora_fin,
        }),
      });

      if (!response.ok) throw new Error("Error al registrar salida");
    } else {
      // Nueva asistencia
      const horarioData = JSON.parse(formData.horario);
      const response = await fetch("/api/nominas/asistencias", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          ...horarioData,
          asi_hora_inicio: formData.asi_hora_inicio,
        }),
      });

      if (!response.ok) throw new Error("Error al registrar asistencia");
    }

    setShowModal(false);
    fetchAsistencias();
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
