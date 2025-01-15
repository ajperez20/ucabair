import { useState, useEffect } from "react";

export function useSolicitudesStats() {
  const [stats, setStats] = useState({});
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchStats = async () => {
      try {
        const response = await fetch("/api/stats/solicitudes");
        if (!response.ok)
          throw new Error("Error al cargar estadísticas de solicitudes");
        const data = await response.json();
        setStats(data);
      } catch (error) {
        console.error("Error:", error);
        setError(error.message);
      } finally {
        setIsLoading(false);
      }
    };

    fetchStats();
  }, []);

  return {
    ...stats,
    isLoading,
    error,
  };
}
