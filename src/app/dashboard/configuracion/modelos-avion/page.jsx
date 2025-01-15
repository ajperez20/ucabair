"use client";

import { useState, useEffect } from "react";
import DataList from "@/components/DataList";
import EditModal from "@/components/EditModal";
import CaracteristicasArrayField from "@/components/aviones/CaracteristicasArrayField";
import ProcesosArrayField from "@/components/aviones/ProcesosArrayField";
import PruebasArrayField from "@/components/aviones/PruebasArrayField";
import PiezasArrayField from "@/components/aviones/PiezasArrayField";
import {
  WrenchIcon,
  BeakerIcon,
  CubeIcon,
  ClipboardDocumentCheckIcon,
} from "@heroicons/react/24/outline";

const columns = [
  { key: "nombre", label: "Nombre" },
  { key: "descripcion", label: "Descripción" },
  { key: "tipo_nombre", label: "Tipo de Avión" },
  {
    key: "precio",
    label: "Precio",
    format: (value) => `$${value?.toLocaleString() || "0"}`,
  },
  {
    key: "cantidad_caracteristicas",
    label: "Características",
    format: (value) => value || 0,
  },
  {
    key: "cantidad_piezas",
    label: "Piezas",
    format: (value) => value || 0,
  },
  {
    key: "cantidad_procesos",
    label: "Procesos",
    format: (value) => value || 0,
  },
  {
    key: "cantidad_pruebas",
    label: "Pruebas",
    format: (value) => value || 0,
  },
];

const defaultModelo = {
  nombre: "",
  descripcion: "",
  precio: "",
  tipo_id: "",
  caracteristicas: [],
  procesos: [],
  pruebas: [],
  piezas: [],
};

const initialFormFields = [
  {
    name: "nombre",
    label: "Nombre",
    type: "text",
    required: true,
    placeholder: "Nombre del modelo",
    maxLength: 50,
  },
  {
    name: "descripcion",
    label: "Descripción",
    type: "textarea",
    required: true,
    placeholder: "Descripción detallada del modelo",
    maxLength: 255,
  },
  {
    name: "precio",
    label: "Precio",
    type: "number",
    required: true,
    placeholder: "Precio del modelo",
    min: 0,
  },
  {
    name: "tipo_id",
    label: "Tipo de Avión",
    type: "select",
    required: true,
    options: [],
  },
];

export default function ModelosAvionPage() {
  const [modelos, setModelos] = useState([]);
  const [isLoading, setIsLoading] = useState(true);
  const [showModal, setShowModal] = useState(false);
  const [showCaracteristicasModal, setShowCaracteristicasModal] =
    useState(false);
  const [showProcesosModal, setShowProcesosModal] = useState(false);
  const [showPruebasModal, setShowPruebasModal] = useState(false);
  const [showPiezasModal, setShowPiezasModal] = useState(false);
  const [currentModelo, setCurrentModelo] = useState(null);
  const [formFields, setFormFields] = useState(initialFormFields);

  const [caracteristicasFields, setCaracteristicasFields] = useState([
    {
      name: "caracteristicas",
      label: "Características",
      type: "caracteristicasArray",
      options: [],
      description: "Agregue las características del modelo",
    },
  ]);

  const [procesosFields, setProcesosFields] = useState([
    {
      name: "procesos",
      label: "Procesos de Ensamblaje",
      type: "procesosArray",
      options: [],
      description: "Seleccione los procesos necesarios",
    },
  ]);

  const [pruebasFields, setPruebasFields] = useState([
    {
      name: "pruebas",
      label: "Pruebas",
      type: "pruebasArray",
      options: [],
      description: "Seleccione las pruebas requeridas",
    },
  ]);

  const [piezasFields, setPiezasFields] = useState([
    {
      name: "piezas",
      label: "Piezas",
      type: "piezasArray",
      options: [],
      description: "Seleccione las piezas necesarias y sus cantidades",
    },
  ]);

  useEffect(() => {
    fetchModelos();
    fetchDependencies();
  }, []);

  const fetchModelos = async () => {
    try {
      const response = await fetch("/api/aviones/modelos");
      if (!response.ok) throw new Error("Error al cargar modelos");
      const data = await response.json();
      setModelos(data);
    } catch (error) {
      console.error("Error:", error);
    } finally {
      setIsLoading(false);
    }
  };

  const fetchDependencies = async () => {
    try {
      const [tiposRes, caracteristicasRes, procesosRes, pruebasRes, piezasRes] =
        await Promise.all([
          fetch("/api/aviones"),
          fetch("/api/aviones/caracteristicas"),
          fetch("/api/aviones/procesos"),
          fetch("/api/aviones/pruebas"),
          fetch("/api/piezas"),
        ]);

      const [tipos, caracteristicas, procesos, pruebas, piezas] =
        await Promise.all([
          tiposRes.json(),
          caracteristicasRes.json(),
          procesosRes.json(),
          pruebasRes.json(),
          piezasRes.json(),
        ]);

      setFormFields((prevFields) =>
        prevFields.map((field) => {
          if (field.name === "tipo_id") {
            return {
              ...field,
              options: tipos.map((tipo) => ({
                value: tipo.id,
                label: tipo.nombre,
              })),
            };
          }
          return field;
        }),
      );

      setCaracteristicasFields((prev) => [
        {
          ...prev[0],
          options: caracteristicas.map((c) => ({
            value: c.id,
            label: c.nombre,
          })),
        },
      ]);

      setProcesosFields((prev) => [
        {
          ...prev[0],
          options: procesos.map((p) => ({
            id: p.id,
            nombre: p.nombre,
            tiempo_estimado: p.tiempo_estimado,
            descripcion: p.descripcion,
          })),
        },
      ]);

      setPruebasFields((prev) => [
        {
          ...prev[0],
          options: pruebas.map((p) => ({
            id: p.id,
            nombre: p.nombre,
            tiempo_estimado: p.tiempo_estimado,
          })),
        },
      ]);

      setPiezasFields((prev) => [
        {
          ...prev[0],
          options: piezas.map((p) => ({
            id: p.id,
            nombre: p.nombre,
            descripcion: p.descripcion,
          })),
        },
      ]);
    } catch (error) {
      console.error("Error:", error);
    }
  };

  const handleEdit = async (modelo) => {
    if (modelo) {
      try {
        const response = await fetch(`/api/aviones/modelos/${modelo.id}`);
        if (!response.ok)
          throw new Error("Error al cargar detalles del modelo");
        const modeloDetallado = await response.json();

        setCurrentModelo({
          id: modeloDetallado.id,
          nombre: modeloDetallado.nombre,
          descripcion: modeloDetallado.descripcion,
          precio: modeloDetallado.precio,
          tipo_id: modeloDetallado.tipo_id,
        });
      } catch (error) {
        console.error("Error:", error);
        alert("Error al cargar los detalles del modelo");
        return;
      }
    } else {
      setCurrentModelo(defaultModelo);
    }
    setShowModal(true);
  };

  const handleDelete = async (modelo) => {
    if (!confirm("¿Está seguro de eliminar este modelo?")) return;

    try {
      const response = await fetch(`/api/aviones/modelos/${modelo.id}`, {
        method: "DELETE",
      });

      if (!response.ok) {
        const error = await response.json();
        throw new Error(error.error?.message || "Error al eliminar");
      }

      fetchModelos();
    } catch (error) {
      console.error("Error:", error);
      alert(error.message);
    }
  };

  const handleCaracteristicas = async (modelo) => {
    try {
      const response = await fetch(
        `/api/aviones/modelos/${modelo.id}/caracteristicas`,
      );
      if (!response.ok) throw new Error("Error al cargar características");
      const caracteristicas = await response.json();

      setCurrentModelo({
        ...modelo,
        caracteristicas: caracteristicas.map((c) => ({
          caracteristica_id: c.id.toString(),
          unidad_medida: c.unidad_medida,
          valor: c.valor?.toString(),
        })),
      });
      setShowCaracteristicasModal(true);
    } catch (error) {
      console.error("Error:", error);
      alert("Error al cargar las características");
    }
  };

  const handleProcesos = async (modelo) => {
    try {
      const response = await fetch(
        `/api/aviones/modelos/${modelo.id}/procesos`,
      );
      if (!response.ok) throw new Error("Error al cargar procesos");
      const procesos = await response.json();

      setCurrentModelo({
        ...modelo,
        procesos: procesos.map((p) => ({
          id: p.id,
          proceso_id: p.id.toString(),
          nombre: p.nombre,
          tiempo_estimado: p.tiempo_estimado,
          descripcion: p.descripcion,
        })),
      });
      setShowProcesosModal(true);
    } catch (error) {
      console.error("Error:", error);
      alert("Error al cargar los procesos");
    }
  };

  const handlePruebas = async (modelo) => {
    try {
      const response = await fetch(`/api/aviones/modelos/${modelo.id}/pruebas`);
      if (!response.ok) throw new Error("Error al cargar pruebas");
      const pruebas = await response.json();

      setCurrentModelo({
        ...modelo,
        pruebas: pruebas.map((p) => ({
          id: p.id,
          prueba_id: p.id.toString(),
          nombre: p.nombre,
          tiempo_estimado: p.tiempo_estimado,
        })),
      });
      setShowPruebasModal(true);
    } catch (error) {
      console.error("Error:", error);
      alert("Error al cargar las pruebas");
    }
  };

  const handlePiezas = async (modelo) => {
    try {
      const response = await fetch(`/api/aviones/modelos/${modelo.id}/piezas`);
      if (!response.ok) throw new Error("Error al cargar piezas");
      const piezas = await response.json();

      setCurrentModelo({
        ...modelo,
        piezas: piezas.map((p) => ({
          id: p.id,
          pieza_id: p.id.toString(),
          nombre: p.nombre,
          cantidad: p.cantidad?.toString() || "1",
          descripcion: p.descripcion,
        })),
      });
      setShowPiezasModal(true);
    } catch (error) {
      console.error("Error:", error);
      alert("Error al cargar las piezas");
    }
  };

  const handleSave = async (formData) => {
    try {
      const url = formData.id
        ? `/api/aviones/modelos/${formData.id}`
        : "/api/aviones/modelos";

      const response = await fetch(url, {
        method: formData.id ? "PUT" : "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(formData),
      });

      if (!response.ok) {
        const error = await response.json();
        throw new Error(error.error?.message || "Error al guardar");
      }

      setShowModal(false);
      fetchModelos();
    } catch (error) {
      console.error("Error:", error);
      throw error;
    }
  };

  const handleSaveCaracteristicas = async (formData) => {
    try {
      const response = await fetch(
        `/api/aviones/modelos/${formData.id}/caracteristicas`,
        {
          method: "PUT",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({ caracteristicas: formData.caracteristicas }),
        },
      );

      if (!response.ok) {
        const error = await response.json();
        throw new Error(
          error.error?.message || "Error al guardar características",
        );
      }

      setShowCaracteristicasModal(false);
      fetchModelos();
    } catch (error) {
      console.error("Error:", error);
      throw error;
    }
  };

  const handleSaveProcesos = async (formData) => {
    try {
      const procesosToSave = formData.procesos.map((p) => ({
        proceso_id: parseInt(p.proceso_id || p.id),
        tiempo_estimado: p.tiempo_estimado,
        descripcion: p.descripcion,
      }));

      const response = await fetch(
        `/api/aviones/modelos/${formData.id}/procesos`,
        {
          method: "PUT",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({ procesos: procesosToSave }),
        },
      );

      if (!response.ok) {
        const error = await response.json();
        throw new Error(error.error?.message || "Error al guardar procesos");
      }

      setShowProcesosModal(false);
      fetchModelos();
    } catch (error) {
      console.error("Error:", error);
      throw error;
    }
  };

  const handleSavePruebas = async (formData) => {
    try {
      const pruebasToSave = formData.pruebas.map((p) => ({
        prueba_id: parseInt(p.prueba_id || p.id),
        tiempo_estimado: p.tiempo_estimado,
      }));

      const response = await fetch(
        `/api/aviones/modelos/${formData.id}/pruebas`,
        {
          method: "PUT",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({ pruebas: pruebasToSave }),
        },
      );

      if (!response.ok) {
        const error = await response.json();
        throw new Error(error.error?.message || "Error al guardar pruebas");
      }

      setShowPruebasModal(false);
      fetchModelos();
    } catch (error) {
      console.error("Error:", error);
      throw error;
    }
  };

  const handleSavePiezas = async (formData) => {
    try {
      const piezasToSave = formData.piezas.map((p) => ({
        pieza_id: parseInt(p.pieza_id || p.id),
        cantidad: parseInt(p.cantidad) || 1,
        descripcion: p.descripcion,
      }));

      const response = await fetch(
        `/api/aviones/modelos/${formData.id}/piezas`,
        {
          method: "PUT",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({ piezas: piezasToSave }),
        },
      );

      if (!response.ok) {
        const error = await response.json();
        throw new Error(error.error?.message || "Error al guardar piezas");
      }

      setShowPiezasModal(false);
      fetchModelos();
    } catch (error) {
      console.error("Error:", error);
      throw error;
    }
  };

  const actions = [
    {
      icon: ClipboardDocumentCheckIcon,
      label: "Características",
      onClick: handleCaracteristicas,
      key: "caracteristicas",
    },
    {
      icon: CubeIcon,
      label: "Piezas",
      onClick: handlePiezas,
      key: "piezas",
    },
    {
      icon: WrenchIcon,
      label: "Procesos",
      onClick: handleProcesos,
      key: "procesos",
    },
    {
      icon: BeakerIcon,
      label: "Pruebas",
      onClick: handlePruebas,
      key: "pruebas",
    },
  ];

  const renderCustomField = (field, value, onChange) => {
    switch (field.type) {
      case "caracteristicasArray":
        return (
          <CaracteristicasArrayField
            value={value}
            onChange={onChange}
            options={field.options}
          />
        );
      case "procesosArray":
        return (
          <ProcesosArrayField
            value={value}
            onChange={onChange}
            options={field.options}
          />
        );
      case "pruebasArray":
        return (
          <PruebasArrayField
            value={value}
            onChange={onChange}
            options={field.options}
          />
        );
      case "piezasArray":
        return (
          <PiezasArrayField
            value={value}
            onChange={onChange}
            options={field.options}
          />
        );
      default:
        return null;
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
        data={modelos}
        columns={columns}
        onEdit={handleEdit}
        onDelete={handleDelete}
        actions={actions}
        title="Modelos de Avión"
      />

      {/* Modal para datos básicos */}
      <EditModal
        isOpen={showModal}
        onClose={() => {
          setShowModal(false);
          setCurrentModelo(null);
        }}
        onSave={handleSave}
        data={currentModelo}
        fields={formFields}
        title={currentModelo?.id ? "Editar Modelo" : "Nuevo Modelo"}
      />

      {/* Modal para características */}
      <EditModal
        isOpen={showCaracteristicasModal}
        onClose={() => {
          setShowCaracteristicasModal(false);
          setCurrentModelo(null);
        }}
        onSave={handleSaveCaracteristicas}
        data={currentModelo}
        fields={caracteristicasFields}
        title={`Características - ${currentModelo?.nombre || ""}`}
        renderCustomField={renderCustomField}
      />

      {/* Modal para procesos */}
      <EditModal
        isOpen={showProcesosModal}
        onClose={() => {
          setShowProcesosModal(false);
          setCurrentModelo(null);
        }}
        onSave={handleSaveProcesos}
        data={currentModelo}
        fields={procesosFields}
        title={`Procesos - ${currentModelo?.nombre || ""}`}
        renderCustomField={renderCustomField}
      />

      {/* Modal para pruebas */}
      <EditModal
        isOpen={showPruebasModal}
        onClose={() => {
          setShowPruebasModal(false);
          setCurrentModelo(null);
        }}
        onSave={handleSavePruebas}
        data={currentModelo}
        fields={pruebasFields}
        title={`Pruebas - ${currentModelo?.nombre || ""}`}
        renderCustomField={renderCustomField}
      />

      {/* Modal para piezas */}
      <EditModal
        isOpen={showPiezasModal}
        onClose={() => {
          setShowPiezasModal(false);
          setCurrentModelo(null);
        }}
        onSave={handleSavePiezas}
        data={currentModelo}
        fields={piezasFields}
        title={`Piezas - ${currentModelo?.nombre || ""}`}
        renderCustomField={renderCustomField}
      />
    </div>
  );
}
