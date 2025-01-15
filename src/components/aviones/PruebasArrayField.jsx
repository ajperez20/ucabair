"use client";

import { useState } from "react";
import { PlusIcon, TrashIcon } from "@heroicons/react/24/outline";

export default function PruebasArrayField({
  value = [],
  onChange,
  options,
  error,
}) {
  const [pruebas, setPruebas] = useState(value);

  const formatTiempoEstimado = (tiempo) => {
    if (!tiempo) return "";
    const { hours = 0, minutes = 0 } = tiempo;
    return `${hours}h ${minutes}m`.trim();
  };

  const handleAdd = () => {
    const newPruebas = [
      ...pruebas,
      { prueba_id: "", tiempo_estimado: "", descripcion: "" },
    ];
    setPruebas(newPruebas);
    onChange(newPruebas);
  };

  const handleRemove = (index) => {
    const newPruebas = pruebas.filter((_, i) => i !== index);
    setPruebas(newPruebas);
    onChange(newPruebas);
  };

  const handleChange = (index, field, value) => {
    const newPruebas = [...pruebas];
    newPruebas[index][field] = value;
    setPruebas(newPruebas);
    onChange(newPruebas);
  };

  return (
    <div className="space-y-4">
      {pruebas.map((prueba, index) => (
        <div key={index} className="flex gap-4 items-start">
          <div className="flex-1 space-y-4">
            <select
              value={prueba.prueba_id || prueba.id}
              onChange={(e) => {
                const selectedPrueba = options.find(
                  (opt) => opt.id.toString() === e.target.value,
                );
                handleChange(index, "prueba_id", e.target.value);
                if (selectedPrueba) {
                  handleChange(index, "nombre", selectedPrueba.nombre);
                  handleChange(
                    index,
                    "tiempo_estimado",
                    selectedPrueba.tiempo_estimado,
                  );
                }
              }}
              className="mt-1 block w-full rounded-md border border-gray-300 py-2 px-3 shadow-sm focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500 sm:text-sm"
            >
              <option value="">Seleccione una prueba</option>
              {options.map((opt) => (
                <option key={opt.id} value={opt.id}>
                  {opt.nombre} - {formatTiempoEstimado(opt.tiempo_estimado)}
                </option>
              ))}
            </select>
          </div>
          <button
            type="button"
            onClick={() => handleRemove(index)}
            className="mt-1 p-2 text-red-600 hover:text-red-800"
          >
            <TrashIcon className="h-5 w-5" />
          </button>
        </div>
      ))}
      <button
        type="button"
        onClick={handleAdd}
        className="mt-2 inline-flex items-center px-3 py-2 border border-gray-300 shadow-sm text-sm leading-4 font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
      >
        <PlusIcon className="h-4 w-4 mr-2" />
        Agregar Prueba
      </button>
      {error && <p className="mt-2 text-sm text-red-600">{error}</p>}
    </div>
  );
}
