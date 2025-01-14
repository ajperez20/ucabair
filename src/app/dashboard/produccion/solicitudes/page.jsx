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
  { key: "cliente", label: "Cliente" },
  { key: "tipo_cliente", label: "Tipo" },
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

export default function SolicitudesProduccionPage() {
  const [solicitudes, setSolicitudes] = useState([]);
  const [estados, setEstados] = useState([]);
  const [clientesNaturales, setClientesNaturales] = useState([]);
  const [clientesJuridicos, setClientesJuridicos] = useState([]);
  const [modelos, setModelos] = useState([]);
  const [isLoading, setIsLoading] = useState(true);
  const [showModal, setShowModal] = useState(false);
  const [selectedSolicitud, setSelectedSolicitud] = useState(null);
  const [isCreating, setIsCreating] = useState(false);

  useEffect(() => {
    Promise.all([
      fetchSolicitudes(),
      fetchEstados(),
      fetchClientes(),
      fetchModelos(),
    ]).finally(() => setIsLoading(false));
  }, []);

  const fetchSolicitudes = async () => {
    try {
      const response = await fetch("/api/solicitudes");
      const data = await response.json();
      setSolicitudes(data || []);
    } catch (error) {
      console.error("Error:", error);
      setSolicitudes([]);
    }
  };

  const fetchEstados = async () => {
    try {
      const response = await fetch("/api/estados");
      const data = await response.json();
      setEstados(data || []);
    } catch (error) {
      console.error("Error:", error);
      setEstados([]);
    }
  };

  const fetchClientes = async () => {
    try {
      const [naturalesRes, juridicosRes] = await Promise.all([
        fetch("/api/clientes/naturales"),
        fetch("/api/clientes/juridicos"),
      ]);

      if (!naturalesRes.ok || !juridicosRes.ok) {
        throw new Error("Error al obtener clientes");
      }

      const naturales = await naturalesRes.json();
      const juridicos = await juridicosRes.json();

      setClientesNaturales(
        Array.isArray(naturales)
          ? naturales.filter((c) => c && typeof c === "object" && c.ctn_id)
          : [],
      );
      setClientesJuridicos(
        Array.isArray(juridicos)
          ? juridicos.filter((c) => c && typeof c === "object" && c.cjd_id)
          : [],
      );
    } catch (error) {
      console.error("Error al cargar clientes:", error);
      setClientesNaturales([]);
      setClientesJuridicos([]);
    }
  };

  const fetchModelos = async () => {
    try {
      const response = await fetch("/api/aviones/modelos");
      const data = await response.json();
      setModelos(data || []);
    } catch (error) {
      console.error("Error al cargar modelos:", error);
      setModelos([]);
    }
  };

  const handleEdit = (solicitud) => {
    if (solicitud === null) {
      setIsCreating(true);
      setSelectedSolicitud({
        tipo_cliente: "",
        cliente_id: "",
        modelo_id: "",
        cantidad: 1,
        descripcion: "",
      });
    } else {
      setIsCreating(false);
      setSelectedSolicitud({
        id: solicitud.id,
        estado: `estado-${solicitud.estado_id}`,
      });
    }
    setShowModal(true);
  };

  const handleFieldChange = (name, value) => {
    setSelectedSolicitud((prev) => ({
      ...prev,
      [name]: value,
      ...(name === "tipo_cliente" ? { cliente_id: "" } : {}),
    }));
  };

  const getFormFields = () => {
    if (isCreating) {
      const clientesOptions = (() => {
        if (!selectedSolicitud?.tipo_cliente) return [];

        if (selectedSolicitud.tipo_cliente === "NATURAL") {
          return clientesNaturales
            .filter((c) => c && c.ctn_id)
            .map((c) => ({
              value: `natural-${c.ctn_id}`,
              label: `${c.ctn_nombre || ""} ${c.ctn_apellido || ""}`.trim(),
            }));
        }

        if (selectedSolicitud.tipo_cliente === "JURIDICO") {
          return clientesJuridicos
            .filter((c) => c && c.cjd_id)
            .map((c) => ({
              value: `juridico-${c.cjd_id}`,
              label: c.cjd_nombre || "",
            }));
        }

        return [];
      })();

      return [
        {
          name: "tipo_cliente",
          label: "Tipo de Cliente",
          type: "select",
          required: true,
          options: [
            { value: "NATURAL", label: "Natural" },
            { value: "JURIDICO", label: "Jurídico" },
          ],
        },
        {
          name: "cliente_id",
          label: "Cliente",
          type: "select",
          required: true,
          options: clientesOptions,
          disabled: !selectedSolicitud?.tipo_cliente,
        },
        {
          name: "modelo_id",
          label: "Modelo de Avión",
          type: "select",
          required: true,
          options: modelos
            .filter((m) => m && m.id)
            .map((m) => ({
              value: `modelo-${m.id}`,
              label: `${m.nombre} - $${m.precio?.toLocaleString() || "0"}`,
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
    }

    return [
      {
        name: "estado",
        label: "Estado",
        type: "select",
        required: true,
        options: estados
          .filter((estado) => estado && estado.id)
          .map((estado) => ({
            value: `estado-${estado.id}`,
            label: estado.nombre || "",
          })),
      },
    ];
  };

  const handleSave = async (formData) => {
    try {
      if (isCreating) {
        const [tipo, clienteId] = formData.cliente_id.split("-");
        const modeloId = formData.modelo_id.split("-")[1];

        const response = await fetch("/api/pedidos/solicitud", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            cliente_id: clienteId,
            tipo: formData.tipo_cliente,
            modelo_id: modeloId,
            cantidad: parseInt(formData.cantidad),
            descripcion: formData.descripcion,
          }),
        });

        if (!response.ok) {
          const error = await response.json();
          throw new Error(
            error.error?.message || "Error al crear la solicitud",
          );
        }
      } else {
        const estadoId = formData.estado.split("-")[1];

        const response = await fetch(
          `/api/solicitudes/${selectedSolicitud.id}/estado`,
          {
            method: "PUT",
            headers: {
              "Content-Type": "application/json",
            },
            body: JSON.stringify({ estadoId }),
          },
        );

        if (!response.ok) {
          const error = await response.json();
          throw new Error(
            error.error?.message || "Error al actualizar el estado",
          );
        }
      }

      await fetchSolicitudes();
      setShowModal(false);
    } catch (error) {
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
        data={solicitudes}
        columns={columns}
        onEdit={handleEdit}
        title="Solicitudes de Producción"
      />

      <EditModal
        isOpen={showModal}
        onClose={() => {
          setShowModal(false);
          setSelectedSolicitud(null);
          setIsCreating(false);
        }}
        onSave={handleSave}
        onFieldChange={handleFieldChange}
        data={selectedSolicitud}
        fields={getFormFields()}
        title={
          isCreating ? "Nueva Solicitud" : "Actualizar Estado de Solicitud"
        }
      />
    </div>
  );
}
