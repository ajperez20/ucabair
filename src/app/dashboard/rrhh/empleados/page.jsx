"use client";

import { useState, useEffect } from "react";
import DataList from "@/components/DataList";
import EditModal from "@/components/EditModal";
import EmpleadoDetalles from "@/components/empleados/EmpleadoDetalles";
import EmpleadoCargoHorario from "@/components/empleados/EmpleadoCargoHorario";
import { locationUtils } from "@/utils/locationUtils";
import { EyeIcon, ClockIcon } from "@heroicons/react/24/outline";

const columns = [
  { key: "per_dni", label: "DNI" },
  { key: "per_nombre", label: "Nombre" },
  { key: "per_apellido", label: "Apellido" },
  { key: "per_direccion", label: "Dirección" },
  { key: "per_profesion", label: "Profesión" },
  {
    key: "per_experiencia",
    label: "Experiencia",
    format: (value) => `${value} años`,
  },
  {
    key: "per_fecha_contratacion",
    label: "Fecha Contratación",
    format: (value) => new Date(value).toLocaleDateString(),
  },
  {
    key: "lugar_completo",
    label: "Lugar",
  },
  {
    key: "cargo_actual",
    label: "Cargo Actual",
  },
];

const initialFormFields = [
  {
    name: "per_dni",
    label: "DNI",
    type: "text",
    required: true,
    placeholder: "Ingrese el DNI",
    description: "Número de identificación del empleado (V123456789)",
  },
  {
    name: "per_nombre",
    label: "Nombre",
    type: "text",
    required: true,
    placeholder: "Ingrese el nombre",
  },
  {
    name: "per_apellido",
    label: "Apellido",
    type: "text",
    required: true,
    placeholder: "Ingrese el apellido",
  },
  {
    name: "per_direccion",
    label: "Dirección",
    type: "text",
    required: true,
    placeholder: "Ingrese la dirección completa",
  },
  {
    name: "per_experiencia",
    label: "Experiencia",
    type: "number",
    required: true,
    placeholder: "Años de experiencia",
    min: 0,
    description: "Años de experiencia en el campo",
  },
  {
    name: "per_profesion",
    label: "Profesión",
    type: "text",
    required: true,
    placeholder: "Ingrese la profesión",
  },
  {
    name: "fk_lug_id",
    label: "Lugar",
    type: "select",
    required: true,
    description: "Seleccione la ubicación del empleado",
    options: [],
  },
];

export default function EmpleadosPage() {
  const [empleados, setEmpleados] = useState([]);
  const [isLoading, setIsLoading] = useState(true);
  const [showModal, setShowModal] = useState(false);
  const [showDetails, setShowDetails] = useState(false);
  const [showCargoHorario, setShowCargoHorario] = useState(false);
  const [selectedEmpleado, setSelectedEmpleado] = useState(null);
  const [formFields, setFormFields] = useState(initialFormFields);

  useEffect(() => {
    fetchEmpleados();
    fetchLugares();
  }, []);

  const fetchEmpleados = async () => {
    try {
      const response = await fetch("/api/empleados");
      if (!response.ok) throw new Error("Error al cargar empleados");
      const data = await response.json();
      setEmpleados(data);
    } catch (error) {
      console.error("Error:", error);
    } finally {
      setIsLoading(false);
    }
  };

  const fetchLugares = async () => {
    try {
      const lugares = await locationUtils.fetchLugares();
      setFormFields((fields) =>
        locationUtils.updateFormFieldsWithLocations(fields, lugares),
      );
    } catch (error) {
      console.error("Error:", error);
    }
  };

  const handleEdit = (empleado) => {
    if (empleado) {
      const formattedEmpleado = {
        per_id: empleado.per_id,
        per_dni: empleado.per_dni,
        per_nombre: empleado.per_nombre,
        per_apellido: empleado.per_apellido,
        per_direccion: empleado.per_direccion,
        per_experiencia: empleado.per_experiencia,
        per_profesion: empleado.per_profesion,
        fk_lug_id: empleado.fk_lug_id,
      };
      setSelectedEmpleado(formattedEmpleado);
    } else {
      setSelectedEmpleado(null);
    }
    setShowModal(true);
  };

  const handleView = (empleado) => {
    setSelectedEmpleado(empleado);
    setShowDetails(true);
  };

  const handleCargoHorario = (empleado) => {
    if (!empleado) {
      console.error("No hay empleado seleccionado");
      return;
    }
    setSelectedEmpleado(empleado);
    setShowCargoHorario(true);
  };

  const handleDelete = async (empleado) => {
    if (!confirm("¿Está seguro de eliminar este empleado?")) return;

    try {
      const response = await fetch(`/api/empleados/${empleado.per_id}`, {
        method: "DELETE",
      });

      if (!response.ok) {
        const error = await response.json();
        throw new Error(error.error?.message || "Error al eliminar empleado");
      }

      fetchEmpleados();
    } catch (error) {
      console.error("Error:", error);
      alert(error.message);
    }
  };

  const handleSave = async (formData) => {
    try {
      const url = formData.per_id
        ? `/api/empleados/${formData.per_id}`
        : "/api/empleados";

      const method = formData.per_id ? "PUT" : "POST";

      const response = await fetch(url, {
        method,
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(formData),
      });

      if (!response.ok) {
        const error = await response.json();
        throw new Error(error.error?.message || "Error al guardar empleado");
      }

      setShowModal(false);
      fetchEmpleados();
    } catch (error) {
      console.error("Error:", error);
      alert(error.message);
    }
  };

  const actions = [
    {
      label: "Ver detalles",
      onClick: handleView,
      icon: EyeIcon,
    },
    {
      label: "Cargo y Horario",
      onClick: handleCargoHorario,
      icon: ClockIcon,
    },
  ];

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
        data={empleados}
        columns={columns}
        onEdit={handleEdit}
        onDelete={handleDelete}
        actions={actions}
        title="Gestión de Empleados"
      />

      {/* Modal de Edición/Creación */}
      <EditModal
        isOpen={showModal}
        onClose={() => {
          setShowModal(false);
          setSelectedEmpleado(null);
        }}
        onSave={handleSave}
        data={selectedEmpleado}
        fields={formFields}
        title={selectedEmpleado ? "Editar Empleado" : "Nuevo Empleado"}
      />

      {/* Modal de Detalles */}
      <EditModal
        isOpen={showDetails}
        onClose={() => {
          setShowDetails(false);
          setSelectedEmpleado(null);
        }}
        title={`Detalles del Empleado: ${selectedEmpleado?.per_nombre} ${selectedEmpleado?.per_apellido}`}
        size="2xl"
        hideButtons
      >
        <EmpleadoDetalles
          empleado={selectedEmpleado}
          onClose={() => {
            setShowDetails(false);
            setSelectedEmpleado(null);
          }}
        />
      </EditModal>

      {/* Modal de Cargo y Horario */}
      <EditModal
        isOpen={showCargoHorario}
        onClose={() => {
          setShowCargoHorario(false);
          setSelectedEmpleado(null);
        }}
        title="Gestionar Cargo y Horario"
        hideButtons
      >
        {selectedEmpleado && (
          <EmpleadoCargoHorario
            empleado={selectedEmpleado}
            onClose={() => {
              setShowCargoHorario(false);
              setSelectedEmpleado(null);
            }}
            onSave={() => {
              setShowCargoHorario(false);
              setSelectedEmpleado(null);
              fetchEmpleados();
            }}
          />
        )}
      </EditModal>
    </div>
  );
}
