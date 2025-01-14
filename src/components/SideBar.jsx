"use client";

import Link from "next/link";
import { useState, useEffect } from "react";
import { usePathname } from "next/navigation";
import {
  HomeIcon,
  UserGroupIcon,
  CubeIcon,
  CogIcon,
  BriefcaseIcon,
  TruckIcon,
  ClipboardDocumentListIcon,
  UserIcon,
  ChevronDownIcon,
} from "@heroicons/react/24/outline";

const navigationConfig = {
  ADMINISTRADOR: [
    {
      name: "Dashboard",
      href: "/dashboard",
      icon: HomeIcon,
    },
    {
      name: "RRHH",
      href: "/dashboard/rrhh",
      icon: BriefcaseIcon,
      submenu: [
        {
          name: "Empleados",
          href: "/dashboard/rrhh/empleados",
          submenu: [
            {
              name: "Cargos",
              href: "/dashboard/rrhh/cargos",
            },
            {
              name: "Horarios",
              href: "/dashboard/rrhh/horarios",
            },
          ],
        },
        {
          name: "Asistencias",
          href: "/dashboard/rrhh/asistencias",
        },
        {
          name: "Nóminas",
          href: "/dashboard/rrhh/nominas",
        },
      ],
    },
    {
      name: "Clientes",
      href: "/dashboard/clientes",
      icon: UserIcon,
      submenu: [
        {
          name: "Naturales",
          href: "/dashboard/clientes/naturales",
        },
        {
          name: "Jurídicos",
          href: "/dashboard/clientes/juridicos",
        },
      ],
    },
    {
      name: "Proveedores",
      href: "/dashboard/proveedores",
      icon: TruckIcon,
    },
    {
      name: "Usuarios",
      href: "/dashboard/usuarios",
      icon: UserGroupIcon,
      submenu: [
        {
          name: "Roles",
          href: "/dashboard/usuarios/roles",
        },
      ],
    },
    {
      name: "Configuración",
      href: "/dashboard/configuracion",
      icon: CogIcon,
      submenu: [
        {
          name: "Tipos de Avión",
          href: "/dashboard/configuracion/tipos-avion",
        },
        {
          name: "Modelos",
          href: "/dashboard/configuracion/modelos-avion",
        },
        {
          name: "Piezas",
          href: "/dashboard/configuracion/piezas",
        },
      ],
    },
    {
      name: "Producción",
      href: "/dashboard/produccion",
      icon: CubeIcon,
      submenu: [
        {
          name: "Sedes",
          href: "/dashboard/produccion/sedes",
        },
        {
          name: "Áreas y Zonas",
          href: "/dashboard/produccion/areas-zonas",
        },
        {
          name: "Solicitudes",
          href: "/dashboard/produccion/solicitudes",
        },
      ],
    },
    {
      name: "Inventario",
      href: "/dashboard/inventario",
      icon: ClipboardDocumentListIcon,
      submenu: [
        {
          name: "Stock",
          href: "/dashboard/inventario/stock",
        },
      ],
    },
    {
      name: "Reportes",
      href: "/dashboard/reportes",
      icon: ClipboardDocumentListIcon,
    },
  ],
  EMPLEADO: [
    {
      name: "Producción",
      href: "/dashboard/produccion",
      icon: CubeIcon,
    },
  ],
  PROVEEDOR: [
    {
      name: "Mis Pedidos",
      href: "/dashboard/pedidos",
      icon: ClipboardDocumentListIcon,
    },
  ],
  CLIENTE: [
    {
      name: "Pedidos",
      href: "/dashboard/pedidos",
      icon: ClipboardDocumentListIcon,
    },
  ],
};

export default function Sidebar() {
  const pathname = usePathname();
  const [openMenus, setOpenMenus] = useState({});
  const [navigation, setNavigation] = useState([]);
  const [user, setUser] = useState(null);

  useEffect(() => {
    const userData = localStorage.getItem("user");
    if (userData) {
      const parsedUser = JSON.parse(userData);
      setUser(parsedUser);
      setNavigation(navigationConfig[parsedUser.role] || []);
    }
  }, []);

  const toggleSubmenu = (name) => {
    setOpenMenus((prev) => ({
      ...prev,
      [name]: !prev[name],
    }));
  };

  const isPathActive = (href, submenu = null) => {
    if (submenu) {
      return (
        pathname === href ||
        submenu.some((item) => {
          if (item.submenu) {
            return (
              pathname === item.href ||
              item.submenu.some((nestedItem) => pathname === nestedItem.href)
            );
          }
          return pathname === item.href;
        }) ||
        pathname.startsWith(href)
      );
    }
    return pathname === href;
  };

  const renderMenuItem = (item, level = 0) => {
    const isActive = isPathActive(item.href, item.submenu);
    const isOpen = openMenus[item.name];
    const hasSubmenu = item.submenu && item.submenu.length > 0;

    return (
      <div key={item.name} className={`${level > 0 ? "ml-4" : ""}`}>
        <div className="flex items-center">
          <Link
            href={item.href}
            className={`
              flex-1 flex items-center px-4 py-2 text-sm rounded-md transition-all duration-200
              ${level === 0 ? "my-1" : "my-0.5"}
              ${
                isActive
                  ? "text-blue-600 bg-blue-50 font-medium"
                  : "text-gray-600 hover:text-gray-900 hover:bg-gray-100"
              }
            `}
          >
            {level === 0 && (
              <item.icon
                className={`h-5 w-5 mr-3 ${
                  isActive ? "text-blue-600" : "text-gray-400"
                }`}
              />
            )}
            <span className={`${level > 0 ? "text-sm" : ""}`}>{item.name}</span>
          </Link>
          {hasSubmenu && (
            <button
              onClick={() => toggleSubmenu(item.name)}
              className={`
                p-2 rounded-md mr-2 hover:bg-gray-100
                ${isActive ? "text-blue-600" : "text-gray-400"}
              `}
            >
              <ChevronDownIcon
                className={`h-4 w-4 transform transition-transform duration-200
                  ${isOpen ? "rotate-180" : ""}`}
              />
            </button>
          )}
        </div>

        {hasSubmenu && isOpen && (
          <div
            className={`
            mt-1 space-y-1 
            ${level === 0 ? "border-l border-gray-200 ml-4 pl-4" : "pl-4"}
          `}
          >
            {item.submenu.map((subItem) => renderMenuItem(subItem, level + 1))}
          </div>
        )}
      </div>
    );
  };

  return (
    <div className="fixed inset-y-0 left-0 w-64 bg-white shadow-lg">
      <div className="flex flex-col h-full">
        {/* Logo */}
        <div className="flex items-center justify-center h-16 bg-blue-600">
          <span className="text-white text-xl font-bold">UcabAir</span>
        </div>

        {/* User Info */}
        <div className="px-6 py-4 border-b border-gray-200">
          <p className="text-sm font-medium text-gray-900">
            {user?.displayName}
          </p>
          <p className="text-xs text-gray-500">{user?.role}</p>
        </div>

        {/* Navigation */}
        <nav className="flex-1 overflow-y-auto p-4">
          <div className="space-y-1">
            {navigation.map((item) => renderMenuItem(item))}
          </div>
        </nav>
      </div>
    </div>
  );
}
