"use client";

import { useState, useEffect } from "react";
import DataList from "@/components/DataList";
import EditModal from "@/components/EditModal";
import { EyeIcon } from "@heroicons/react/24/outline";

const columns = [
  { key: "id", label: "Nº Solicitud" },
  {
    key: "fecha",
    label: "Fecha",
    format: (value) => new Date(value).toLocaleDateString(),
  },
  { key: "sede_nombre", label: "Sede" },
  { key: "materia_prima_nombre", label: "Materia Prima" },
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

export default function SolicitudesProveedorPage() {
  const [solicitudes, setSolicitudes] = useState([]);
  const [isLoading, setIsLoading] = useState(true);
  const [showDetallesModal, setShowDetallesModal] = useState(false);
  const [currentSolicitud, setCurrentSolicitud] = useState(null);
  const [detalles, setDetalles] = useState([]);
  const [user, setUser] = useState(null);

  useEffect(() => {
    const userData = localStorage.getItem("user");
    if (userData) {
      const parsedUser = JSON.parse(userData);
      setUser(parsedUser);
      if (parsedUser.id && parsedUser.role === "PROVEEDOR") {
        fetchSolicitudes(parsedUser.proveedorId);
      }
    }
  }, []);

  const fetchSolicitudes = async (proveedorId) => {
    try {
      const response = await fetch(
        `/api/proveedores/solicitudes?proveedorId=${proveedorId}`,
      );
      if (!response.ok) throw new Error("Error al cargar solicitudes");
      const data = await response.json();
      setSolicitudes(data || []);
    } catch (error) {
      console.error("Error:", error);
      setSolicitudes([]);
    } finally {
      setIsLoading(false);
    }
  };

  const handleVerDetalles = async (solicitud) => {
    try {
      const response = await fetch(
        `/api/proveedores/solicitudes/${solicitud.id}/detalles`,
      );
      if (!response.ok) throw new Error("Error al cargar detalles");
      const detalles = await response.json();
      setDetalles(detalles);
      setCurrentSolicitud(solicitud);
      setShowDetallesModal(true);
    } catch (error) {
      console.error("Error:", error);
      alert("Error al cargar los detalles");
    }
  };

  const handleUpdateEstado = async (solicitud, nuevoEstado) => {
    if (
      !confirm(
        `¿Está seguro de ${nuevoEstado === "Completado" ? "aceptar" : "rechazar"} esta solicitud?`,
      )
    ) {
      return;
    }

    try {
      const response = await fetch(
        `/api/proveedores/solicitudes/${solicitud.id}/estado`,
        {
          method: "PUT",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({ estado: nuevoEstado }),
        },
      );

      if (!response.ok) {
        const error = await response.json();
        throw new Error(error.error?.message || "Error al actualizar estado");
      }

      // Actualizar la lista de solicitudes
      if (user?.proveedorId) {
        fetchSolicitudes(user.proveedorId);
      }
    } catch (error) {
      console.error("Error:", error);
      alert(error.message);
    }
  };

  const actions = [
    {
      icon: EyeIcon,
      label: "Ver detalles",
      onClick: handleVerDetalles,
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
        data={solicitudes}
        columns={columns}
        actions={actions}
        title="Solicitudes Recibidas"
      />

      <EditModal
        isOpen={showDetallesModal}
        onClose={() => {
          setShowDetallesModal(false);
          setCurrentSolicitud(null);
          setDetalles([]);
        }}
        title={`Detalles de la Solicitud #${currentSolicitud?.id || ""}`}
        hideButtons
        size="2xl"
      >
        <div className="space-y-6">
          <div className="grid grid-cols-2 gap-4">
            <div>
              <h3 className="text-sm font-medium text-gray-500">Fecha</h3>
              <p className="mt-1">
                {currentSolicitud?.fecha
                  ? new Date(currentSolicitud.fecha).toLocaleDateString()
                  : "-"}
              </p>
            </div>
            <div>
              <h3 className="text-sm font-medium text-gray-500">Estado</h3>
              <p className="mt-1">{currentSolicitud?.estado || "Pendiente"}</p>
            </div>
            <div>
              <h3 className="text-sm font-medium text-gray-500">Sede</h3>
              <p className="mt-1">{currentSolicitud?.sede_nombre || "-"}</p>
            </div>
            <div>
              <h3 className="text-sm font-medium text-gray-500">Total</h3>
              <p className="mt-1">
                ${currentSolicitud?.total?.toLocaleString() || "0"}
              </p>
            </div>
          </div>

          <div>
            <h3 className="text-sm font-medium text-gray-500 mb-2">
              Materiales Solicitados
            </h3>
            <div className="mt-2">
              <table className="min-w-full divide-y divide-gray-300">
                <thead>
                  <tr>
                    <th className="py-2 px-4 text-left text-sm font-semibold text-gray-900">
                      Material
                    </th>
                    <th className="py-2 px-4 text-left text-sm font-semibold text-gray-900">
                      Cantidad
                    </th>
                    <th className="py-2 px-4 text-left text-sm font-semibold text-gray-900">
                      Precio Unit.
                    </th>
                    <th className="py-2 px-4 text-left text-sm font-semibold text-gray-900">
                      Total
                    </th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-gray-200">
                  {detalles.map((detalle, index) => (
                    <tr key={index}>
                      <td className="py-2 px-4 text-sm text-gray-500">
                        {detalle.materia_prima_nombre}
                      </td>
                      <td className="py-2 px-4 text-sm text-gray-500">
                        {detalle.cantidad} {detalle.unidad_medida}
                      </td>
                      <td className="py-2 px-4 text-sm text-gray-500">
                        ${detalle.precio?.toLocaleString() || "0"}
                      </td>
                      <td className="py-2 px-4 text-sm text-gray-500">
                        $
                        {(
                          detalle.cantidad * detalle.precio
                        )?.toLocaleString() || "0"}
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>

          {currentSolicitud?.estado === "Pendiente" && (
            <div className="flex justify-end space-x-3 mt-6 pt-4 border-t">
              <button
                onClick={() =>
                  handleUpdateEstado(currentSolicitud, "Cancelado")
                }
                className="px-4 py-2 text-sm font-medium text-white bg-red-600 rounded-md hover:bg-red-700"
              >
                Rechazar
              </button>
              <button
                onClick={() =>
                  handleUpdateEstado(currentSolicitud, "Completado")
                }
                className="px-4 py-2 text-sm font-medium text-white bg-green-600 rounded-md hover:bg-green-700"
              >
                Aceptar
              </button>
            </div>
          )}
        </div>
      </EditModal>
    </div>
  );
}
