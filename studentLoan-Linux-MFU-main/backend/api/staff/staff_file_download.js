const express = require("express");
const router = express.Router();
const fs = require("fs");
const path = require("path");
const ExcelJS = require("exceljs");
const PDFDocument = require("pdfkit");
const checkSession = require("../../middleware/checkSession_staff");

// Excel
router.post("/download-excel", checkSession, async (req, res) => {
  try {
    const data = req.body.data;

    if (!Array.isArray(data) || data.length === 0) {
      return res.status(400).send("No data provided");
    }

    const workbook = new ExcelJS.Workbook();
    const worksheet = workbook.addWorksheet("Sheet 1");

    // Extract columns from the first object keys
    const columns = Object.keys(data[0]).map((key) => ({
      header: key,
      key: key,
      width: 25,
    }));

    worksheet.columns = columns;

    // Style header row: bold + yellow fill
    worksheet.getRow(1).eachCell((cell) => {
      cell.font = { bold: true };
      cell.fill = {
        type: "pattern",
        pattern: "solid",
        fgColor: { argb: "FFFF00" }, // Yellow
      };
    });

    // Add all rows at once
    data.forEach((row) => worksheet.addRow(row));

    res.setHeader(
      "Content-Type",
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    );
    res.setHeader("Content-Disposition", "attachment; filename=data.xlsx");

    await workbook.xlsx.write(res);
    res.end();
  } catch (error) {
    console.error("Error generating Excel:", error);
    res.status(500).send("Internal server error");
  }
});

// PDF
router.post("/download-pdf", async (req, res) => {
  try {
    const data = req.body.data;

    if (!Array.isArray(data) || data.length === 0) {
      return res.status(400).send("No data provided");
    }

    const doc = new PDFDocument({
      margin: 30,
      size: "A4",
      layout: "landscape",
    });

    const thaiFontPath = path.join(
      __dirname,
      "../../assets/fonts/THSarabunNew.ttf"
    );
    doc.registerFont("ThaiFont", thaiFontPath);

    res.setHeader("Content-Type", "application/pdf");
    res.setHeader("Content-Disposition", "attachment; filename=data.pdf");

    doc.pipe(res);

    // Set base styles function
    function setBaseStyles() {
      doc.font("ThaiFont").fontSize(12).lineWidth(0.5).strokeColor("black");
    }

    // Table constants
    const cellPadding = 5;
    const headerHeight = 30;

    // Get headers and initial layout size
    const headers = Object.keys(data[0]);

    function getLayoutSizes() {
      const pageWidth =
        doc.page.width - doc.page.margins.left - doc.page.margins.right;
      const pageHeight =
        doc.page.height - doc.page.margins.top - doc.page.margins.bottom;
      const colWidth = pageWidth / headers.length;
      return { pageWidth, pageHeight, colWidth };
    }

    function drawCell(x, y, width, height, text) {
      doc.rect(x, y, width, height).stroke();
      doc.text(text, x + cellPadding, y + cellPadding / 2, {
        width: width - cellPadding * 2,
        height: height - cellPadding,
      });
    }

    function drawHeader(currentY, colWidth) {
      headers.forEach((header, i) => {
        const x = doc.page.margins.left + i * colWidth;

        // Draw yellow background
        doc
          .rect(x, currentY, colWidth, headerHeight)
          .fillColor("#FFFF99") // light yellow
          .fill();

        // Draw border
        doc
          .rect(x, currentY, colWidth, headerHeight)
          .strokeColor("black")
          .stroke();

        // Write bold text (simulate bold by increasing font size slightly or re-register a bold font)
        doc
          .fillColor("black") // reset text color
          .font("ThaiFont")
          .fontSize(13) // slightly larger or use .font("ThaiFont-Bold") if you have a bold version
          .text(header, x + cellPadding, currentY + cellPadding / 2, {
            width: colWidth - cellPadding * 2,
            height: headerHeight - cellPadding,
          });
      });

      return currentY + headerHeight;
    }

    // Initial styles and layout
    setBaseStyles();
    let { colWidth, pageHeight } = getLayoutSizes();
    let currentY = doc.page.margins.top;

    // Draw first page header
    currentY = drawHeader(currentY, colWidth);

    for (const row of data) {
      // Ensure layout values are current
      ({ colWidth, pageHeight } = getLayoutSizes());

      // Estimate row height
      const texts = headers.map((key) => String(row[key] ?? ""));
      let maxHeight = 0;
      texts.forEach((text) => {
        const height = doc.heightOfString(text, {
          width: colWidth - cellPadding * 2,
        });
        if (height > maxHeight) maxHeight = height;
      });
      maxHeight += cellPadding;

      // Check if new page needed
      if (currentY + maxHeight > doc.page.height - doc.page.margins.bottom) {
        doc.addPage({ size: "A4", layout: "landscape", margin: 30 });
        setBaseStyles(); // reapply font and line
        ({ colWidth, pageHeight } = getLayoutSizes()); // recalc layout sizes
        currentY = doc.page.margins.top;
        currentY = drawHeader(currentY, colWidth); // redraw header
      }

      // Draw each cell
      headers.forEach((key, i) => {
        const x = doc.page.margins.left + i * colWidth;
        drawCell(x, currentY, colWidth, maxHeight, String(row[key] ?? ""));
      });

      currentY += maxHeight;
    }

    doc.end();
  } catch (error) {
    console.error("PDF generation error:", error);
    res.status(500).send("Internal Server Error");
  }
});

module.exports = router;
