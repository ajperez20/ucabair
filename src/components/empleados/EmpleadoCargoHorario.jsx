import { useState, useEffect } from "react";

export default function EmpleadoCargoHorario({ empleado, onClose, onSave }) {
  const [cargos, setCargos] = useState([]);
  const [horarios, setHorarios] = useState([]);
  const [selectedCargo, setSelectedCargo] = useState("");
  const [selectedHorarios, setSelectedHorarios] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (empleado?.per_id) {
      fetchData();
    }
  }, [empleado]);

  const fetchData = async () => {
    try {
      setLoading(true);
      const [cargosRes, horariosRes, empleadoDataRes] = await Promise.all([
        fetch("/api/cargos"),
        fetch("/api/horarios"),
        fetch(`/api/empleados/${empleado.per_id}/cargo-horario`),
      ]);

      if (!cargosRes.ok || !horariosRes.ok || !empleadoDataRes.ok) {
        throw new Error("Error al cargar los datos");
      }

      const [cargosData, horariosData, empleadoData] = await Promise.all([
        cargosRes.json(),
        horariosRes.json(),
        empleadoDataRes.json(),
      ]);

      setCargos(cargosData);
      setHorarios(horariosData);
      setSelectedCargo(empleadoData.cargo_id || "");
      setSelectedHorarios(empleadoData.horarios?.map((h) => h.id) || []);
    } catch (error) {
      console.error("Error:", error);
    } finally {
      setLoading(false);
    }
  };

  if (!empleado) {
    return null;
  }

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const response = await fetch(
        `/api/empleados/${empleado.per_id}/cargo-horario`,
        {
          method: "PUT",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            cargo_id: selectedCargo,
            horarios_ids: selectedHorarios,
          }),
        },
      );

      if (!response.ok) throw new Error("Error al actualizar");

      onSave();
    } catch (error) {
      console.error("Error:", error);
      alert("Error al guardar los cambios");
    }
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-[200px]">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600"></div>
      </div>
    );
  }

  return (
    <form onSubmit={handleSubmit} className="space-y-6">
      <div>
        <label className="block text-sm font-medium text-gray-700">Cargo</label>
        <select
          value={selectedCargo}
          onChange={(e) => setSelectedCargo(e.target.value)}
          className="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500 sm:text-sm"
          required
        >
          <option value="">Seleccione un cargo</option>
          {cargos.map((cargo) => (
            <option key={cargo.id} value={cargo.id}>
              {cargo.nombre}
            </option>
          ))}
        </select>
      </div>

      <div>
        <label className="block text-sm font-medium text-gray-700">
          Horarios
        </label>
        <div className="mt-2 space-y-2">
          {horarios.map((horario) => (
            <label key={horario.id} className="flex items-center">
              <input
                type="checkbox"
                checked={selectedHorarios.includes(horario.id)}
                onChange={(e) => {
                  if (e.target.checked) {
                    setSelectedHorarios([...selectedHorarios, horario.id]);
                  } else {
                    setSelectedHorarios(
                      selectedHorarios.filter((id) => id !== horario.id),
                    );
                  }
                }}
                className="rounded border-gray-300 text-blue-600 focus:ring-blue-500"
              />
              <span className="ml-2 text-sm text-gray-600">
                {horario.dia} - {horario.hora_inicio} a {horario.hora_fin}
              </span>
            </label>
          ))}
        </div>
      </div>

      <div className="flex justify-end space-x-3 pt-4">
        <button
          type="button"
          onClick={onClose}
          className="px-4 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-md hover:bg-gray-50"
        >
          Cancelar
        </button>
        <button
          type="submit"
          className="px-4 py-2 text-sm font-medium text-white bg-blue-600 border border-transparent rounded-md hover:bg-blue-700"
        >
          Guardar
        </button>
      </div>
    </form>
  );
}
