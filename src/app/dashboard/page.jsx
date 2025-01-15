"use client";

import { useState, useEffect } from "react";
import { useEmpleadosStats } from "@/hooks/useEmpleadosStats";
import { useClientesStats } from "@/hooks/useClientesStats";
import { useInventarioStats } from "@/hooks/useInventarioStats";
import { useSolicitudesStats } from "@/hooks/useSolicitudesStats";
import { useAvionesStats } from "@/hooks/useAvionesStats";
import {
  UsersIcon,
  UserGroupIcon,
  CubeIcon,
  PaperAirplaneIcon,
  WrenchIcon,
  BuildingOfficeIcon,
  ChartBarIcon,
  ArrowTrendingUpIcon,
  ClipboardDocumentListIcon,
  DocumentCheckIcon,
  ShoppingCartIcon,
  TruckIcon,
} from "@heroicons/react/24/outline";
import { XCircleIcon } from "@heroicons/react/16/solid";
import Link from "next/link";

export default function DashboardPage() {
  const [userRole, setUserRole] = useState(null);
  const empleadosStats = useEmpleadosStats();
  const clientesStats = useClientesStats();
  const avionesStats = useAvionesStats();
  const { materiaPrima, isLoading: isInventarioLoading } = useInventarioStats();
  const solicitudesStats = useSolicitudesStats();

  useEffect(() => {
    const userData = localStorage.getItem("user");
    if (userData) {
      const { role } = JSON.parse(userData);
      setUserRole(role);
    }
  }, []);

  const statsConfig = {
    ADMINISTRADOR: [
      {
        title: "Empleados",
        total: empleadosStats.general?.total || 0,
        nuevos: empleadosStats.general?.nuevos || 0,
        icon: UsersIcon,
        color: "blue",
        href: "/dashboard/rrhh/empleados",
        loading: empleadosStats.isLoading,
      },
      {
        title: "Clientes",
        total: clientesStats.totalClientes || 0,
        nuevos: clientesStats.nuevosClientes || 0,
        icon: UserGroupIcon,
        color: "indigo",
        href: "/dashboard/clientes",
        loading: clientesStats.isLoading,
      },
      {
        title: "Inventario",
        total: materiaPrima?.total || 0,
        icon: CubeIcon,
        color: "yellow",
        href: "/dashboard/inventario",
        loading: isInventarioLoading,
        details: [
          {
            label: "Crítico",
            value: materiaPrima?.stockCritico || 0,
            color: "text-red-600",
          },
          {
            label: "Bajo",
            value: materiaPrima?.stockBajo || 0,
            color: "text-yellow-600",
          },
          {
            label: "Normal",
            value: materiaPrima?.stockNormal || 0,
            color: "text-green-600",
          },
        ],
      },
      {
        title: "Solicitudes",
        total: solicitudesStats.total || 0,
        nuevos: solicitudesStats.nuevas || 0,
        icon: ClipboardDocumentListIcon,
        color: "green",
        href: "/dashboard/produccion/solicitudes",
        loading: solicitudesStats.isLoading,
        details: [
          {
            label: "Clientes",
            value: solicitudesStats.clientes?.total || 0,
          },
          {
            label: "Proveedores",
            value: solicitudesStats.proveedores?.total || 0,
          },
        ],
      },
    ],
    EMPLEADO: [
      {
        title: "Mis Tareas",
        total: empleadosStats.misTareas?.total || 0,
        icon: ClipboardDocumentListIcon,
        color: "blue",
        href: "/dashboard/tareas",
        loading: empleadosStats.isLoading,
        details: [
          {
            label: "Pendientes",
            value: empleadosStats.misTareas?.pendientes || 0,
          },
          {
            label: "En Proceso",
            value: empleadosStats.misTareas?.enProceso || 0,
          },
          {
            label: "Completadas",
            value: empleadosStats.misTareas?.completadas || 0,
          },
        ],
      },
      {
        title: "Aviones Asignados",
        total: avionesStats.misAviones?.total || 0,
        icon: PaperAirplaneIcon,
        color: "green",
        href: "/dashboard/produccion",
        loading: avionesStats.isLoading,
        details: [
          {
            label: "En Ensamblaje",
            value: avionesStats.misAviones?.enEnsamblaje || 0,
          },
          {
            label: "En Pruebas",
            value: avionesStats.misAviones?.enPruebas || 0,
          },
        ],
      },
    ],
    CLIENTE: [
      {
        title: "Mis Pedidos",
        total: clientesStats.misPedidos?.total || 0,
        icon: ShoppingCartIcon,
        color: "blue",
        href: "/dashboard/pedidos",
        loading: clientesStats.isLoading,
        details: [
          {
            label: "En Proceso",
            value: clientesStats.misPedidos?.enProceso || 0,
          },
          {
            label: "Completados",
            value: clientesStats.misPedidos?.completados || 0,
          },
          {
            label: "Pendientes de Pago",
            value: clientesStats.misPedidos?.pendientesPago || 0,
          },
        ],
      },
      {
        title: "Mis Aviones",
        total: avionesStats.avionesCliente?.total || 0,
        icon: PaperAirplaneIcon,
        color: "green",
        href: "/dashboard/mis-aviones",
        loading: avionesStats.isLoading,
        details: [
          {
            label: "En Producción",
            value: avionesStats.avionesCliente?.enProduccion || 0,
          },
          {
            label: "Entregados",
            value: avionesStats.avionesCliente?.entregados || 0,
          },
        ],
      },
    ],
    PROVEEDOR: [],
  };

  const quickAccessConfig = {
    ADMINISTRADOR: [
      {
        name: "Producción",
        description: "Gestión de ensamblaje y pruebas",
        href: "/dashboard/produccion",
        icon: WrenchIcon,
        color: "blue",
      },
      {
        name: "Configuración",
        description: "Configuración de modelos y piezas",
        href: "/dashboard/configuracion",
        icon: CubeIcon,
        color: "indigo",
      },
      {
        name: "Sedes",
        description: "Gestión de plantas y áreas",
        href: "/dashboard/produccion/sedes",
        icon: BuildingOfficeIcon,
        color: "purple",
      },
      {
        name: "Reportes",
        description: "Informes y estadísticas",
        href: "/dashboard/reportes",
        icon: ChartBarIcon,
        color: "green",
      },
    ],
    EMPLEADO: [
      {
        name: "Mis Tareas",
        description: "Ver tareas asignadas",
        href: "/dashboard/tareas",
        icon: ClipboardDocumentListIcon,
        color: "blue",
      },
      {
        name: "Producción",
        description: "Gestión de ensamblaje",
        href: "/dashboard/produccion",
        icon: WrenchIcon,
        color: "indigo",
      },
      {
        name: "Reportes Diarios",
        description: "Registro de actividades",
        href: "/dashboard/reportes/diarios",
        icon: DocumentCheckIcon,
        color: "green",
      },
    ],
    CLIENTE: [
      {
        name: "Nuevo Pedido",
        description: "Solicitar nuevo avión",
        href: "/dashboard/pedidos/nuevo",
        icon: ShoppingCartIcon,
        color: "blue",
      },
      {
        name: "Mis Aviones",
        description: "Estado de mis aviones",
        href: "/dashboard/mis-aviones",
        icon: PaperAirplaneIcon,
        color: "indigo",
      },
      {
        name: "Pagos",
        description: "Gestión de pagos",
        href: "/dashboard/pagos",
        icon: DocumentCheckIcon,
        color: "green",
      },
    ],
    PROVEEDOR: [
      {
        name: "Solicitudes Pendientes",
        description: "Ver nuevas solicitudes",
        href: "/dashboard/solicitudes",
        icon: ClipboardDocumentListIcon,
        color: "blue",
      },
      {
        name: "Entregas",
        description: "Gestionar entregas",
        href: "/dashboard/entregas",
        icon: TruckIcon,
        color: "indigo",
      },
      {
        name: "Facturación",
        description: "Gestión de cobros",
        href: "/dashboard/facturacion",
        icon: DocumentCheckIcon,
        color: "green",
      },
    ],
  };

  if (
    !userRole ||
    empleadosStats.isLoading ||
    clientesStats.isLoading ||
    isInventarioLoading ||
    solicitudesStats.isLoading
  ) {
    return (
      <div className="flex items-center justify-center min-h-[400px]">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600"></div>
      </div>
    );
  }

  const currentStats = statsConfig[userRole] || [];
  const currentQuickAccess = quickAccessConfig[userRole] || [];

  return (
    <div className="space-y-6 p-6">
      <div className="border-b border-gray-200 pb-4">
        <h1 className="text-2xl font-semibold text-gray-900">Dashboard</h1>
        <p className="mt-2 text-sm text-gray-600">
          {userRole === "ADMINISTRADOR"
            ? "Vista general del sistema"
            : userRole === "EMPLEADO"
              ? "Panel de control de producción"
              : userRole === "CLIENTE"
                ? "Estado de mis pedidos"
                : "Gestión de solicitudes"}
        </p>
      </div>

      <div className="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-4">
        {currentStats.map((stat) => (
          <Link
            key={stat.title}
            href={stat.href}
            className="block bg-white rounded-lg shadow hover:shadow-md transition-shadow"
          >
            <div className="p-6">
              <div className="flex items-center">
                <div className={`p-3 rounded-lg bg-${stat.color}-100`}>
                  <stat.icon className={`h-6 w-6 text-${stat.color}-600`} />
                </div>
                <div className="ml-4">
                  <h2 className="text-lg font-medium text-gray-900">
                    {stat.title}
                  </h2>
                </div>
              </div>

              <div className="mt-4">
                <div className="text-3xl font-semibold text-gray-900">
                  {stat.total}
                </div>
                {stat.nuevos !== undefined && (
                  <div className="flex items-center mt-2">
                    <ArrowTrendingUpIcon className="h-4 w-4 text-green-500 mr-1" />
                    <span className="text-sm text-green-600">
                      {stat.nuevos} nuevos
                    </span>
                  </div>
                )}
              </div>

              {stat.details && (
                <div className="mt-4 pt-4 border-t border-gray-100">
                  {stat.details.map((detail) => (
                    <div
                      key={detail.label}
                      className="flex justify-between items-center mt-2"
                    >
                      <span className="text-sm text-gray-500">
                        {detail.label}
                      </span>
                      <span
                        className={`text-sm font-medium ${detail.color || "text-gray-900"}`}
                      >
                        {detail.value}
                      </span>
                    </div>
                  ))}
                </div>
              )}

              {stat.modelStats && stat.modelStats.length > 0 && (
                <div className="mt-4 pt-4 border-t border-gray-100">
                  <h3 className="text-sm font-medium text-gray-900 mb-2">
                    Por Modelo
                  </h3>
                  {stat.modelStats.map((model) => (
                    <div
                      key={model.label}
                      className="flex justify-between items-center mt-2"
                    >
                      <span className="text-sm text-gray-500">
                        {model.label}
                      </span>
                      <span className="text-sm font-medium text-gray-900">
                        {model.value}
                      </span>
                    </div>
                  ))}
                </div>
              )}
            </div>
          </Link>
        ))}
      </div>

      <div className="mt-8">
        <h2 className="text-lg font-medium text-gray-900 mb-4">
          Acceso Rápido
        </h2>
        <div className="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-4">
          {currentQuickAccess.map((item) => (
            <Link
              key={item.name}
              href={item.href}
              className="block bg-white rounded-lg shadow hover:shadow-md transition-shadow p-6"
            >
              <div className="flex items-center">
                <div className={`p-3 rounded-lg bg-${item.color}-100`}>
                  <item.icon className={`h-6 w-6 text-${item.color}-600`} />
                </div>
                <div className="ml-4">
                  <h3 className="text-lg font-medium text-gray-900">
                    {item.name}
                  </h3>
                  <p className="mt-1 text-sm text-gray-500">
                    {item.description}
                  </p>
                </div>
              </div>
            </Link>
          ))}
        </div>
      </div>

      {[
        empleadosStats,
        clientesStats,
        isInventarioLoading,
        solicitudesStats,
      ].map((stats, index) => {
        if (stats.error) {
          return (
            <div
              key={index}
              className="bg-red-50 border border-red-200 rounded-md p-4"
            >
              <div className="flex">
                <XCircleIcon
                  className="h-5 w-5 text-red-400"
                  aria-hidden="true"
                />
                <div className="ml-3">
                  <h3 className="text-sm font-medium text-red-800">
                    Error al cargar estadísticas
                  </h3>
                  <div className="mt-2 text-sm text-red-700">{stats.error}</div>
                </div>
              </div>
            </div>
          );
        }
        return null;
      })}
    </div>
  );
}
