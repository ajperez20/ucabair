import { useState } from "react";
import { PlusIcon, TrashIcon } from "@heroicons/react/24/outline";

export default function ProcesosArrayField({
  value = [],
  onChange,
  options,
  error,
}) {
  const [procesos, setProcesos] = useState(value);

  const formatTiempoEstimado = (tiempo) => {
    if (!tiempo) return "";
    const { days = 0, hours = 0, minutes = 0 } = tiempo;
    return `${days}d ${hours}h ${minutes}m`.trim();
  };

  const handleAdd = () => {
    const newProcesos = [
      ...procesos,
      { proceso_id: "", tiempo_estimado: "", descripcion: "" },
    ];
    setProcesos(newProcesos);
    onChange(newProcesos);
  };

  const handleRemove = (index) => {
    const newProcesos = procesos.filter((_, i) => i !== index);
    setProcesos(newProcesos);
    onChange(newProcesos);
  };

  const handleChange = (index, field, value) => {
    const newProcesos = [...procesos];
    newProcesos[index][field] = value;
    setProcesos(newProcesos);
    onChange(newProcesos);
  };

  return (
    <div className="space-y-4">
      {procesos.map((proceso, index) => (
        <div key={index} className="flex gap-4 items-start">
          <div className="flex-1 space-y-4">
            <select
              value={proceso.proceso_id || proceso.id}
              onChange={(e) => {
                const selectedProceso = options.find(
                  (opt) => opt.id.toString() === e.target.value,
                );
                handleChange(index, "proceso_id", e.target.value);
                if (selectedProceso) {
                  handleChange(index, "nombre", selectedProceso.nombre);
                  handleChange(
                    index,
                    "tiempo_estimado",
                    selectedProceso.tiempo_estimado,
                  );
                  handleChange(
                    index,
                    "descripcion",
                    selectedProceso.descripcion,
                  );
                }
              }}
              className="mt-1 block w-full rounded-md border border-gray-300 py-2 px-3 shadow-sm focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500 sm:text-sm"
            >
              <option value="">Seleccione un proceso</option>
              {options.map((opt) => (
                <option key={opt.id} value={opt.id}>
                  {opt.nombre} - {formatTiempoEstimado(opt.tiempo_estimado)}
                </option>
              ))}
            </select>
            <div className="flex gap-4">
              <div className="flex-1">
                <span className="text-sm text-gray-500">Descripción:</span>
                <p className="mt-1">{proceso.descripcion}</p>
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
        Agregar Proceso
      </button>
      {error && <p className="mt-2 text-sm text-red-600">{error}</p>}
    </div>
  );
}
