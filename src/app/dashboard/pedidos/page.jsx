"use client";

import { useState, useEffect } from "react";
import DataList from "@/components/DataList";
import EditModal from "@/components/EditModal";

const columns = [
  { key: "id", label: "Nº Solicitud" },
  {
    key: "fecha",
    label: "Fecha",
    format: (value) => new Date(value).toLocaleDateString(),
  },
  { key: "modelo", label: "Modelo" },
  { key: "cantidad", label: "Cantidad" },
  {
    key: "total",
    label: "Total",
    format: (value) => `$${value?.toLocaleString() || "0"}`,
  },
  {
    key: "estado",
    label: "Estado",
    format: (value) => {
      const statusColors = {
        Pendiente: "bg-yellow-100 text-yellow-800",
        "En proceso": "bg-blue-100 text-blue-800",
        Completado: "bg-green-100 text-green-800",
        Cancelado: "bg-red-100 text-red-800",
      };
      return (
        <span
          className={`px-2 py-1 rounded-full text-xs font-medium ${
            statusColors[value] || "bg-gray-100 text-gray-800"
          }`}
        >
          {value}
        </span>
      );
    },
  },
];

export default function PedidosPage() {
  const [pedidos, setPedidos] = useState([]);
  const [modelos, setModelos] = useState([]);
  const [isLoading, setIsLoading] = useState(true);
  const [showModal, setShowModal] = useState(false);
  const [user, setUser] = useState(null);
  const [selectedSolicitud, setSelectedSolicitud] = useState(null);

  useEffect(() => {
    const userData = localStorage.getItem("user");
    if (userData) {
      const parsedUser = JSON.parse(userData);
      setUser(parsedUser);
      if (parsedUser.id && parsedUser.role === "CLIENTE") {
        const tipo = parsedUser.clienteJuridicoId ? "JURIDICO" : "NATURAL";
        const clienteId =
          parsedUser.clienteJuridicoId || parsedUser.clienteNaturalId;
        fetchPedidos(clienteId, tipo);
      }
    }
    fetchModelos();
  }, []);

  const fetchPedidos = async (clienteId, tipo) => {
    try {
      const response = await fetch(
        `/api/pedidos/lista?clienteId=${clienteId}&tipo=${tipo}`,
      );
      if (!response.ok) throw new Error("Error al cargar pedidos");
      const data = await response.json();
      setPedidos(data || []);
    } catch (error) {
      console.error("Error:", error);
      setPedidos([]);
    } finally {
      setIsLoading(false);
    }
  };

  const fetchModelos = async () => {
    try {
      const response = await fetch("/api/aviones/modelos");
      if (!response.ok) throw new Error("Error al cargar modelos");
      const data = await response.json();
      setModelos(data || []);
    } catch (error) {
      console.error("Error:", error);
      setModelos([]);
    }
  };

  const handleSave = async (formData) => {
    try {
      if (!user) throw new Error("Usuario no autenticado");

      const tipo = user.clienteJuridicoId ? "JURIDICO" : "NATURAL";
      const clienteId = user.clienteJuridicoId || user.clienteNaturalId;

      // Extraer el ID del modelo eliminando el prefijo
      const modeloId = formData.modelo_id.split("-")[1];

      const response = await fetch("/api/pedidos/solicitud", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          modelo_id: modeloId, // Usar el ID sin prefijo
          cantidad: parseInt(formData.cantidad),
          descripcion: formData.descripcion,
          cliente_id: clienteId,
          tipo: tipo,
        }),
      });

      if (!response.ok) {
        const error = await response.json();
        throw new Error(error.error?.message || "Error al crear la solicitud");
      }

      await fetchPedidos(clienteId, tipo);
      setShowModal(false);
    } catch (error) {
      console.error("Error:", error);
      throw error;
    }
  };

  const formFields = [
    {
      name: "modelo_id",
      label: "Modelo de Avión",
      type: "select",
      required: true,
      options: modelos.map((m) => ({
        value: `modelo-${m.id}`, // Mantener el prefijo aquí
        label: `${m.nombre || ""} - $${m.precio?.toLocaleString() || "0"}`,
      })),
    },
    {
      name: "cantidad",
      label: "Cantidad",
      type: "number",
      required: true,
      min: 1,
    },
    {
      name: "descripcion",
      label: "Descripción",
      type: "textarea",
      rows: 4,
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
        data={pedidos}
        columns={columns}
        deleteAction={true}
        title="Mis Pedidos"
      />

      <EditModal
        isOpen={showModal}
        onClose={() => {
          setShowModal(false);
          setSelectedSolicitud(null);
        }}
        onSave={handleSave}
        data={selectedSolicitud}
        fields={formFields}
        title="Nueva Solicitud de Pedido"
      />
    </div>
  );
}
