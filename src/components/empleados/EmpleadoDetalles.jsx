"use client";

import { useState, useEffect } from "react";
import { Tab } from "@headlessui/react";

function classNames(...classes) {
  return classes.filter(Boolean).join(" ");
}

export default function EmpleadoDetalles({ empleado, onClose }) {
  const [beneficiarios, setBeneficiarios] = useState([]);
  const [experiencia, setExperiencia] = useState([]);
  const [titulos, setTitulos] = useState([]);
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    if (empleado?.per_id) {
      fetchDetalles();
    }
  }, [empleado]);

  const fetchDetalles = async () => {
    try {
      const [beneficiariosRes, experienciaRes, titulosRes] = await Promise.all([
        fetch(`/api/empleados/${empleado.per_id}/beneficiarios`),
        fetch(`/api/empleados/${empleado.per_id}/experiencia`),
        fetch(`/api/empleados/${empleado.per_id}/titulos`),
      ]);

      const [beneficiariosData, experienciaData, titulosData] =
        await Promise.all([
          beneficiariosRes.json(),
          experienciaRes.json(),
          titulosRes.json(),
        ]);

      setBeneficiarios(beneficiariosData);
      setExperiencia(experienciaData);
      setTitulos(titulosData);
    } catch (error) {
      console.error("Error:", error);
    } finally {
      setIsLoading(false);
    }
  };

  if (isLoading) {
    return (
      <div className="flex justify-center py-8">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600"></div>
      </div>
    );
  }

  return (
    <div className="min-h-[400px]">
      <Tab.Group>
        <Tab.List className="flex space-x-1 rounded-xl bg-blue-900/20 p-1">
          <Tab
            className={({ selected }) =>
              classNames(
                "w-full rounded-lg py-2.5 text-sm font-medium leading-5",
                "ring-white ring-opacity-60 ring-offset-2 focus:outline-none focus:ring-2",
                selected
                  ? "bg-white shadow text-blue-700"
                  : "text-gray-700 hover:bg-white/[0.12] hover:text-blue-600",
              )
            }
          >
            Beneficiarios ({beneficiarios.length})
          </Tab>
          <Tab
            className={({ selected }) =>
              classNames(
                "w-full rounded-lg py-2.5 text-sm font-medium leading-5",
                "ring-white ring-opacity-60 ring-offset-2 focus:outline-none focus:ring-2",
                selected
                  ? "bg-white shadow text-blue-700"
                  : "text-gray-700 hover:bg-white/[0.12] hover:text-blue-600",
              )
            }
          >
            Experiencia ({experiencia.length})
          </Tab>
          <Tab
            className={({ selected }) =>
              classNames(
                "w-full rounded-lg py-2.5 text-sm font-medium leading-5",
                "ring-white ring-opacity-60 ring-offset-2 focus:outline-none focus:ring-2",
                selected
                  ? "bg-white shadow text-blue-700"
                  : "text-gray-700 hover:bg-white/[0.12] hover:text-blue-600",
              )
            }
          >
            Títulos ({titulos.length})
          </Tab>
        </Tab.List>
        <Tab.Panels className="mt-4">
          <Tab.Panel>
            {beneficiarios.length > 0 ? (
              <div className="overflow-x-auto">
                <table className="min-w-full divide-y divide-gray-200">
                  <thead>
                    <tr>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                        DNI
                      </th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                        Nombre
                      </th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                        Parentesco
                      </th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-gray-200">
                    {beneficiarios.map((beneficiario) => (
                      <tr key={beneficiario.ben_id}>
                        <td className="px-6 py-4 whitespace-nowrap">
                          {beneficiario.ben_dni}
                        </td>
                        <td className="px-6 py-4 whitespace-nowrap">
                          {beneficiario.ben_nombre} {beneficiario.ben_apellido}
                        </td>
                        <td className="px-6 py-4 whitespace-nowrap">
                          {beneficiario.parentesco}
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            ) : (
              <p className="text-center text-gray-500 py-4">
                No hay beneficiarios registrados
              </p>
            )}
          </Tab.Panel>
          <Tab.Panel>
            {experiencia.length > 0 ? (
              <div className="overflow-x-auto">
                <table className="min-w-full divide-y divide-gray-200">
                  <thead>
                    <tr>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                        Empresa
                      </th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                        Fecha Inicio
                      </th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                        Fecha Fin
                      </th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-gray-200">
                    {experiencia.map((exp) => (
                      <tr key={exp.exp_id}>
                        <td className="px-6 py-4 whitespace-nowrap">
                          {exp.exp_nombre_empresa}
                        </td>
                        <td className="px-6 py-4 whitespace-nowrap">
                          {new Date(exp.exp_fecha_inicio).toLocaleDateString()}
                        </td>
                        <td className="px-6 py-4 whitespace-nowrap">
                          {new Date(exp.exp_fecha_fin).toLocaleDateString()}
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            ) : (
              <p className="text-center text-gray-500 py-4">
                No hay experiencia registrada
              </p>
            )}
          </Tab.Panel>
          <Tab.Panel>
            {titulos.length > 0 ? (
              <div className="overflow-x-auto">
                <table className="min-w-full divide-y divide-gray-200">
                  <thead>
                    <tr>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                        Título
                      </th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                        Universidad
                      </th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                        Fecha
                      </th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-gray-200">
                    {titulos.map((titulo) => (
                      <tr key={titulo.tit_id}>
                        <td className="px-6 py-4 whitespace-nowrap">
                          {titulo.tit_nombre}
                        </td>
                        <td className="px-6 py-4 whitespace-nowrap">
                          {titulo.edt_nombre_universidad}
                        </td>
                        <td className="px-6 py-4 whitespace-nowrap">
                          {new Date(
                            titulo.edt_fecha_obtencion,
                          ).toLocaleDateString()}
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            ) : (
              <p className="text-center text-gray-500 py-4">
                No hay títulos registrados
              </p>
            )}
          </Tab.Panel>
        </Tab.Panels>
      </Tab.Group>
    </div>
  );
}
