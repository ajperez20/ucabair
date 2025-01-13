import jsPDF from "jspdf";
import "jspdf-autotable";
import fs from "fs";
import path from "path";

export const generateReportPDF = async ({
  title,
  subtitle,
  data,
  columns,
  showChart = false,
  chartConfig = {
    valueKey: "",
    labelKey: "",
  },
  emptyMessage = "No se encontraron datos para este reporte",
}) => {
  // Crear nuevo documento PDF
  const doc = new jsPDF();

  // Leer y agregar el logo
  try {
    const logoPath = path.join(
      process.cwd(),
      "public",
      "images",
      "ucabair.png",
    );
    const logoBase64 = fs.readFileSync(logoPath, { encoding: "base64" });
    doc.addImage(`data:image/png;base64,${logoBase64}`, "PNG", 10, 10, 40, 40);
  } catch (error) {
    console.error("Error al cargar el logo:", error);
  }

  // Encabezado
  doc.setFontSize(20);
  doc.setTextColor(0, 83, 155);
  doc.text("UCABAIR", 55, 25);

  doc.setTextColor(0);
  doc.setFontSize(14);
  doc.text(title, 55, 35);

  if (subtitle) {
    doc.setFontSize(12);
    doc.text(subtitle, 55, 45);
  }

  doc.setFontSize(10);
  doc.text(`Fecha: ${new Date().toLocaleDateString("es-ES")}`, 150, 20);

  // Si no hay datos, mostrar mensaje
  if (!data || data.length === 0) {
    doc.setFontSize(12);
    doc.text(emptyMessage, doc.internal.pageSize.width / 2, 70, {
      align: "center",
    });
    return doc.output("arraybuffer");
  }

  // Tabla
  doc.autoTable({
    startY: 60,
    columns: columns.map((col) => ({
      header: col.label,
      dataKey: col.key,
    })),
    body: data,
    theme: "grid",
    styles: {
      fontSize: 8,
      cellPadding: 2,
    },
    headStyles: {
      fillColor: [0, 83, 155],
      textColor: 255,
      fontSize: 9,
      fontStyle: "bold",
    },
    alternateRowStyles: {
      fillColor: [245, 245, 245],
    },
    margin: { top: 60 },
  });

  // Gráfico
  if (showChart && chartConfig.valueKey && data.length > 0) {
    doc.addPage();

    // Título del gráfico
    doc.setFontSize(14);
    doc.text("Gráfico Comparativo", doc.internal.pageSize.width / 2, 20, {
      align: "center",
    });

    // Configuración del gráfico
    const pageWidth = doc.internal.pageSize.width;
    const margin = 20;
    const chartWidth = pageWidth - 2 * margin;
    const chartHeight = 100;
    const startY = 40;

    // Calcular valores para las barras
    const values = data.map((item) => Number(item[chartConfig.valueKey]) || 0);
    const maxValue = Math.max(...values);
    const barCount = values.length;
    const barWidth = Math.min((chartWidth / barCount) * 0.8, 15);
    const barSpacing = (chartWidth - barWidth * barCount) / (barCount + 1);

    // Dibujar barras
    values.forEach((value, index) => {
      const barHeight = (value / maxValue) * chartHeight;
      const x = margin + barSpacing + index * (barWidth + barSpacing);
      const y = startY + chartHeight - barHeight;

      // Asegurarse de que los valores son números válidos
      if (isNaN(x) || isNaN(y) || isNaN(barWidth) || isNaN(barHeight)) {
        console.error("Valores inválidos para el gráfico:", {
          x,
          y,
          barWidth,
          barHeight,
        });
        return;
      }

      // Dibujar barra
      doc.setFillColor(0, 83, 155);
      doc.rect(x, y, barWidth, barHeight, "F");

      // Valor sobre la barra
      doc.setFontSize(8);
      doc.setTextColor(0);
      doc.text(value.toString(), x + barWidth / 2, y - 2, { align: "center" });

      // Etiqueta debajo de la barra
      const label =
        data[index][chartConfig.labelKey]?.toString().substring(0, 10) || "";
      doc.text(label, x + barWidth / 2, startY + chartHeight + 10, {
        align: "center",
      });
    });
  }

  // Numeración de páginas
  const pageCount = doc.internal.getNumberOfPages();
  for (let i = 1; i <= pageCount; i++) {
    doc.setPage(i);
    doc.setFontSize(8);
    doc.text(
      `Página ${i} de ${pageCount}`,
      doc.internal.pageSize.width / 2,
      doc.internal.pageSize.height - 10,
      { align: "center" },
    );
  }

  return doc.output("arraybuffer");
};
