import { useState, useEffect } from "react";

export function useStockStats() {
  const [stats, setStats] = useState({});
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchStats = async () => {
      try {
        const response = await fetch("/api/stats/inventario");
        if (!response.ok)
          throw new Error("Error al cargar estadísticas de stock");
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
