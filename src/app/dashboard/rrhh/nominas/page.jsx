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
    format: (value) => `$${value.toLocaleString()}`,
  },
  { key: "empleado_nombre", label: "Empleado" },
  { key: "cargo", label: "Cargo" },
  { key: "descripcion", label: "Descripción" },
];

const formFields = [
  {
    name: "asistencia_id",
    label: "Asistencia",
    type: "select",
    required: true,
    options: [], // Se llena dinámicamente
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
  },
  {
    name: "descripcion",
    label: "Descripción",
    type: "text",
    required: true,
  },
];

export default function NominasPage() {
  const [nominas, setNominas] = useState([]);
  const [asistencias, setAsistencias] = useState([]);
  const [isLoading, setIsLoading] = useState(true);
  const [showModal, setShowModal] = useState(false);
  const [selectedNomina, setSelectedNomina] = useState(null);

  useEffect(() => {
    fetchData();
  }, []);

  const fetchData = async () => {
    try {
      const [nominasRes, asistenciasRes] = await Promise.all([
        fetch("/api/nominas"),
        fetch("/api/nominas/asistencias"),
      ]);

      const nominasData = await nominasRes.json();
      const asistenciasData = await asistenciasRes.json();

      setNominas(nominasData);
      setAsistencias(asistenciasData);
    } catch (error) {
      console.error("Error:", error);
    } finally {
      setIsLoading(false);
    }
  };

  const getFormFields = () => {
    return formFields.map((field) => {
      if (field.name === "asistencia_id") {
        return {
          ...field,
          options: asistencias.map((a) => ({
            value: a.asi_id,
            label: `${a.empleado_nombre} - ${a.cargo} - ${new Date(a.asi_hora_inicio).toLocaleString()}`,
          })),
        };
      }
      return field;
    });
  };

  const handleEdit = (nomina) => {
    setSelectedNomina(nomina);
    setShowModal(true);
  };

  const handleDelete = async (nomina) => {
    if (!confirm("¿Está seguro de eliminar esta nómina?")) return;

    try {
      const response = await fetch(`/api/nominas/${nomina.id}`, {
        method: "DELETE",
      });

      if (response.ok) {
        fetchData();
      }
    } catch (error) {
      console.error("Error:", error);
    }
  };

  const handleSave = async (formData) => {
    try {
      const url = formData.id ? `/api/nominas/${formData.id}` : "/api/nominas";
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
        fetchData();
      } else {
        const error = await response.json();
        alert(error.error?.message || "Error al guardar la nómina");
      }
    } catch (error) {
      console.error("Error:", error);
      alert("Error al guardar la nómina");
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
        onDelete={handleDelete}
        title="Gestión de Nóminas"
      />

      <EditModal
        isOpen={showModal}
        onClose={() => {
          setShowModal(false);
          setSelectedNomina(null);
        }}
        onSave={handleSave}
        data={selectedNomina}
        fields={getFormFields()}
      />
    </div>
  );
}
