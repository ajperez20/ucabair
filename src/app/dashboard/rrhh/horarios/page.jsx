"use client";

import { useState, useEffect } from "react";
import DataList from "@/components/DataList";
import EditModal from "@/components/EditModal";

const diasSemana = [
  "LUNES",
  "MARTES",
  "MIERCOLES",
  "JUEVES",
  "VIERNES",
  "SABADO",
  "DOMINGO",
];

const columns = [
  { key: "id", label: "ID" },
  { key: "dia", label: "Día" },
  {
    key: "hora_inicio",
    label: "Hora Inicio",
    format: (value) => {
      if (!value) return "";
      return new Date(`2000-01-01T${value}`).toLocaleTimeString([], {
        hour: "2-digit",
        minute: "2-digit",
      });
    },
  },
  {
    key: "hora_fin",
    label: "Hora Fin",
    format: (value) => {
      if (!value) return "";
      return new Date(`2000-01-01T${value}`).toLocaleTimeString([], {
        hour: "2-digit",
        minute: "2-digit",
      });
    },
  },
  {
    key: "cantidad_empleados",
    label: "Empleados Asignados",
    format: (value) => value || 0,
  },
];

const formFields = [
  {
    name: "dia",
    label: "Día",
    type: "select",
    required: true,
    options: diasSemana.map((dia) => ({
      value: dia,
      label: dia.charAt(0) + dia.slice(1).toLowerCase(),
    })),
  },
  {
    name: "hora_inicio",
    label: "Hora Inicio",
    type: "time",
    required: true,
  },
  {
    name: "hora_fin",
    label: "Hora Fin",
    type: "time",
    required: true,
  },
];

export default function HorariosPage() {
  const [horarios, setHorarios] = useState([]);
  const [isLoading, setIsLoading] = useState(true);
  const [showModal, setShowModal] = useState(false);
  const [selectedHorario, setSelectedHorario] = useState(null);

  useEffect(() => {
    fetchHorarios();
  }, []);

  const fetchHorarios = async () => {
    try {
      const response = await fetch("/api/horarios");
      const data = await response.json();
      setHorarios(data);
    } catch (error) {
      console.error("Error:", error);
    } finally {
      setIsLoading(false);
    }
  };

  const handleEdit = (horario) => {
    setSelectedHorario(horario);
    setShowModal(true);
  };

  const handleDelete = async (horario) => {
    if (!confirm("¿Está seguro de eliminar este horario?")) return;

    try {
      const response = await fetch(`/api/horarios/${horario.id}`, {
        method: "DELETE",
      });

      if (response.ok) {
        fetchHorarios();
      }
    } catch (error) {
      console.error("Error:", error);
    }
  };

  const handleSave = async (formData) => {
    // Validar que hora_fin sea mayor que hora_inicio
    const inicio = new Date(`2000-01-01T${formData.hora_inicio}`);
    const fin = new Date(`2000-01-01T${formData.hora_fin}`);

    if (fin <= inicio) {
      alert("La hora de fin debe ser mayor que la hora de inicio");
      return;
    }

    try {
      const url = formData.id
        ? `/api/horarios/${formData.id}`
        : "/api/horarios";
      const method = formData.id ? "PUT" : "POST";

      const response = await fetch(url, {
        method,
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(formData),
      });

      if (response.ok) {
        setShowModal(false);
        fetchHorarios();
      } else {
        const error = await response.json();
        alert(error.error?.message || "Error al guardar el horario");
      }
    } catch (error) {
      console.error("Error:", error);
      alert("Error al guardar el horario");
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
        data={horarios}
        columns={columns}
        onEdit={handleEdit}
        onDelete={handleDelete}
        title="Gestión de Horarios"
      />

      <EditModal
        isOpen={showModal}
        onClose={() => {
          setShowModal(false);
          setSelectedHorario(null);
        }}
        onSave={handleSave}
        data={selectedHorario}
        fields={formFields}
      />
    </div>
  );
}
