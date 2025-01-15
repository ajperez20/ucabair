"use client";

import { useState } from "react";
import { PlusIcon, TrashIcon } from "@heroicons/react/24/outline";

export default function PiezasArrayField({
  value = [],
  onChange,
  options,
  error,
}) {
  const [piezas, setPiezas] = useState(value);

  const handleAdd = () => {
    const newPiezas = [
      ...piezas,
      { pieza_id: "", cantidad: "1", descripcion: "" },
    ];
    setPiezas(newPiezas);
    onChange(newPiezas);
  };

  const handleRemove = (index) => {
    const newPiezas = piezas.filter((_, i) => i !== index);
    setPiezas(newPiezas);
    onChange(newPiezas);
  };

  const handleChange = (index, field, value) => {
    const newPiezas = [...piezas];
    newPiezas[index][field] = value;
    setPiezas(newPiezas);
    onChange(newPiezas);
  };

  return (
    <div className="space-y-4">
      {piezas.map((pieza, index) => (
        <div key={index} className="flex gap-4 items-start">
          <div className="flex-1 space-y-4">
            <select
              value={pieza.pieza_id || pieza.id}
              onChange={(e) => {
                const selectedPieza = options.find(
                  (opt) => opt.id.toString() === e.target.value,
                );
                handleChange(index, "pieza_id", e.target.value);
                if (selectedPieza) {
                  handleChange(index, "nombre", selectedPieza.nombre);
                  handleChange(index, "descripcion", selectedPieza.descripcion);
                }
              }}
              className="mt-1 block w-full rounded-md border border-gray-300 py-2 px-3 shadow-sm focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500 sm:text-sm"
            >
              <option value="">Seleccione una pieza</option>
              {options.map((opt) => (
                <option key={opt.id} value={opt.id}>
                  {opt.nombre}
                </option>
              ))}
            </select>
            <div className="flex gap-4">
              <input
                type="number"
                value={pieza.cantidad}
                onChange={(e) =>
                  handleChange(index, "cantidad", e.target.value)
                }
                placeholder="Cantidad"
                min="1"
                className="mt-1 block w-32 rounded-md border border-gray-300 py-2 px-3 shadow-sm focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500 sm:text-sm"
              />
              <div className="flex-1">
                <span className="text-sm text-gray-500">Descripción:</span>
                <p className="mt-1">{pieza.descripcion}</p>
              </div>
            </div>
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
        Agregar Pieza
      </button>
      {error && <p className="mt-2 text-sm text-red-600">{error}</p>}
    </div>
  );
}
