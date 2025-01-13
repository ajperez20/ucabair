"use client";

import { useState } from "react";
import {
  ShoppingCartIcon,
  CubeIcon,
  ClockIcon,
  CurrencyDollarIcon,
  ClipboardDocumentListIcon,
  StarIcon,
  UsersIcon,
  PaperAirplaneIcon,
  DocumentDuplicateIcon,
  ExclamationTriangleIcon,
  ArchiveBoxIcon,
  ChartBarIcon,
  BuildingOfficeIcon,
  ShieldCheckIcon,
} from "@heroicons/react/24/outline";

const reports = [
  {
    id: "compras-clientes",
    title: "Compras de Clientes",
    description: "Reporte detallado de compras realizadas por clientes",
    icon: ShoppingCartIcon,
    color: "blue",
    requiresYear: true,
  },
  {
    id: "fabricacion-avion",
    title: "Fabricación de Avión",
    description:
      "Proceso completo de fabricación incluyendo materiales y pruebas",
    icon: CubeIcon,
    color: "indigo",
    requiresYear: false,
  },
  {
    id: "registro-asistencias",
    title: "Registro de Asistencias",
    description: "Registro detallado de asistencias de empleados",
    icon: ClockIcon,
    color: "green",
    requiresYear: true,
  },
  {
    id: "calculo-nomina",
    title: "Cálculo de Nómina",
    description: "Cálculo detallado de nómina incluyendo horas extra",
    icon: CurrencyDollarIcon,
    color: "yellow",
    requiresYear: true,
  },
  {
    id: "estatus-fabricacion",
    title: "Estatus de Fabricación",
    description: "Estado y ubicación actual de cada pieza",
    icon: ClipboardDocumentListIcon,
    color: "red",
    requiresYear: false,
  },
  {
    id: "top-10-clientes",
    title: "Top 10 Clientes",
    description: "Mejores clientes por cantidad de compras anuales",
    icon: StarIcon,
    color: "purple",
    requiresYear: true,
    endpoint: "mejores-clientes",
  },
  {
    id: "equipo-eficiente",
    title: "Equipo más Eficiente",
    description: "Ranking de equipos según cumplimiento de plazos",
    icon: UsersIcon,
    color: "pink",
    requiresYear: true,
  },
  {
    id: "tipos-alas",
    title: "Tipos de Alas",
    description: "Análisis de tipos de alas más utilizados",
    icon: PaperAirplaneIcon,
    color: "sky",
    requiresYear: true,
  },
  {
    id: "especificaciones-modelo",
    title: "Especificaciones de Modelo",
    description: "Especificaciones técnicas detalladas de modelos",
    icon: DocumentDuplicateIcon,
    color: "emerald",
    requiresYear: false,
  },
  {
    id: "pruebas-calidad",
    title: "Pruebas de Calidad",
    description: "Productos que no cumplieron estándares de calidad",
    icon: ExclamationTriangleIcon,
    color: "amber",
    requiresYear: true,
  },
  {
    id: "inventario-mensual",
    title: "Inventario Mensual",
    description: "Reporte detallado del inventario por mes",
    icon: ArchiveBoxIcon,
    color: "lime",
    requiresYear: true,
  },
  {
    id: "aviones-rentables",
    title: "Aviones más Rentables",
    description: "Análisis de rentabilidad por cumplimiento de fechas",
    icon: ChartBarIcon,
    color: "cyan",
    requiresYear: true,
  },
  {
    id: "produccion-sede",
    title: "Producción por Sede",
    description: "Promedio de producción mensual por sede",
    icon: BuildingOfficeIcon,
    color: "teal",
    requiresYear: true,
  },
  {
    id: "permisos-bd",
    title: "Permisos Base de Datos",
    description: "Gestión y control de permisos en la base de datos",
    icon: ShieldCheckIcon,
    color: "gray",
    requiresYear: false,
  },
];

export default function ReportesPage() {
  const [isLoading, setIsLoading] = useState({});

  const handleDownload = async (report) => {
    try {
      setIsLoading((prev) => ({ ...prev, [report.id]: true }));

      // Usar el endpoint específico si existe, sino usar el ID
      const endpoint = report.endpoint || report.id;
      let url = `/api/reportes/${endpoint}`;

      if (report.requiresYear) {
        const currentYear = new Date().getFullYear();
        const year = prompt("Ingrese el año:", currentYear);

        if (!year) {
          setIsLoading((prev) => ({ ...prev, [report.id]: false }));
          return;
        }

        const yearNum = parseInt(year);
        if (isNaN(yearNum) || yearNum < 2000 || yearNum > 2100) {
          alert("Por favor ingrese un año válido entre 2000 y 2100");
          setIsLoading((prev) => ({ ...prev, [report.id]: false }));
          return;
        }

        url += `?anio=${yearNum}`;
      }

      const response = await fetch(url);

      if (!response.ok) {
        const errorData = await response.json().catch(() => ({
          error: { message: "Error desconocido al generar el reporte" },
        }));
        throw new Error(
          errorData.error?.message || "Error al generar el reporte",
        );
      }

      // Verificar el tipo de contenido
      const contentType = response.headers.get("content-type");
      if (!contentType || !contentType.includes("application/pdf")) {
        throw new Error("El servidor no devolvió un PDF válido");
      }

      const blob = await response.blob();
      const downloadUrl = window.URL.createObjectURL(blob);
      const a = document.createElement("a");
      a.href = downloadUrl;
      a.download = `reporte-${report.id}-${new Date().toISOString().split("T")[0]}.pdf`;
      document.body.appendChild(a);
      a.click();
      window.URL.revokeObjectURL(downloadUrl);
      document.body.removeChild(a);
    } catch (error) {
      console.error("Error al descargar reporte:", error);
      alert(error.message);
    } finally {
      setIsLoading((prev) => ({ ...prev, [report.id]: false }));
    }
  };

  return (
    <div className="space-y-6 p-6">
      <div className="border-b border-gray-200 pb-4">
        <h1 className="text-2xl font-semibold text-gray-900">Reportes</h1>
        <p className="mt-2 text-sm text-gray-600">
          Generación y descarga de reportes del sistema
        </p>
      </div>

      <div className="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-3">
        {reports.map((report) => (
          <div
            key={report.id}
            className="bg-white rounded-lg shadow hover:shadow-md transition-shadow"
          >
            <div className="p-6">
              <div className="flex items-center">
                <div className={`p-3 rounded-lg bg-${report.color}-100`}>
                  <report.icon className={`h-6 w-6 text-${report.color}-600`} />
                </div>
                <div className="ml-4 flex-1">
                  <h3 className="text-lg font-medium text-gray-900">
                    {report.title}
                  </h3>
                  <p className="mt-1 text-sm text-gray-500">
                    {report.description}
                  </p>
                </div>
              </div>

              <div className="mt-6">
                <button
                  onClick={() => handleDownload(report)}
                  disabled={isLoading[report.id]}
                  className="w-full inline-flex justify-center items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 disabled:opacity-50 disabled:cursor-not-allowed"
                >
                  {isLoading[report.id] ? (
                    <>
                      <svg
                        className="animate-spin -ml-1 mr-3 h-5 w-5 text-white"
                        xmlns="http://www.w3.org/2000/svg"
                        fill="none"
                        viewBox="0 0 24 24"
                      >
                        <circle
                          className="opacity-25"
                          cx="12"
                          cy="12"
                          r="10"
                          stroke="currentColor"
                          strokeWidth="4"
                        />
                        <path
                          className="opacity-75"
                          fill="currentColor"
                          d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
                        />
                      </svg>
                      Generando...
                    </>
                  ) : (
                    "Descargar PDF"
                  )}
                </button>
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
