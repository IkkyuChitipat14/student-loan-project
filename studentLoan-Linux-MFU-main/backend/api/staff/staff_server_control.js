const express = require("express");
const router = express.Router();
const con = require("../../config/db");
const cron = require("node-cron");
const moment = require("moment");
const moment_timezone = require("moment-timezone"); // make sure you're using moment-timezone

const checkSession = require("../../middleware/checkSession_staff");

router.get("/get/system_status", checkSession, (_req, res) => {
  const sql =
    "SELECT server_status, open_date, close_date, study_year, study_semester,updated_at FROM Server ORDER BY updated_at DESC LIMIT 1";
  con.query(sql, (err, results) => {
    if (err) {
      console.error("Database error:", err);
      return res.status(500).json({ error: "Database error" });
    }

    let systemStatus = results[0].server_status;
    let autoOpenDate = results[0].open_date;
    let autoCloseDate = results[0].close_date;
    let study_year = results[0].study_year;
    let study_semester = results[0].study_semester;

    res.json({
      status: systemStatus,
      autoOpenDate,
      autoCloseDate,
      study_year,
      study_semester,
    });
  });
});

router.post("/update/system_status", checkSession, (req, res) => {
  const { status } = req.body;

  if (!["open", "close"].includes(status)) {
    return res.status(400).json({ error: "Invalid status value" });
  }

  const sql =
    "UPDATE Server SET server_status = ?, open_date = Null, close_date = Null, updated_at = NOW() WHERE 1=1";
  con.query(sql, [status], (err, result) => {
    if (err) {
      console.error("Database error:", err);
      return res.status(500).json({ error: "Database error" });
    }

    res.json({ message: `System status updated to ${status}` });
  });
});

router.post("/update/system_auto", checkSession, (req, res) => {
  const { startDate, endDate, studyYear, studySemester } = req.body;

  if (!startDate || !endDate) {
    return res.status(400).json({ error: "Invalid dates" });
  }

  const sql =
    "UPDATE Server SET open_date = ?, close_date = ?, study_year = ?, study_semester = ?,updated_at = NOW() WHERE 1=1";
  con.query(
    sql,
    [startDate, endDate, studyYear, studySemester],
    (err, _result) => {
      if (err) {
        console.error("Database error:", err);
        return res.status(500).json({ error: "Database error" });
      }
      res.json({
        message: `System scheduled to open: ${startDate} - ${endDate}`,
      });
    }
  );
});

// For editLoan system

router.get("/get/system_status/editLoan", checkSession, (_req, res) => {
  const sql =
    "SELECT server_status, open_date, close_date, study_year, study_semester,updated_at FROM Server_editLoan ORDER BY updated_at DESC LIMIT 1";
  con.query(sql, (err, results) => {
    if (err) {
      console.error("Database error:", err);
      return res.status(500).json({ error: "Database error" });
    }

    let systemStatus = results[0].server_status;
    let autoOpenDate = results[0].open_date;
    let autoCloseDate = results[0].close_date;
    let study_year = results[0].study_year;
    let study_semester = results[0].study_semester;

    res.json({
      status: systemStatus,
      autoOpenDate,
      autoCloseDate,
      study_year,
      study_semester,
    });
  });
});

router.post("/update/system_status/editLoan", checkSession, (req, res) => {
  const { status } = req.body;

  if (!["open", "close"].includes(status)) {
    return res.status(400).json({ error: "Invalid status value" });
  }

  const sql =
    "UPDATE Server_editLoan SET server_status = ?, open_date = Null, close_date = Null, updated_at = NOW() WHERE 1=1";
  con.query(sql, [status], (err, result) => {
    if (err) {
      console.error("Database error:", err);
      return res.status(500).json({ error: "Database error" });
    }

    res.json({ message: `System status updated to ${status}` });
  });
});

router.post("/update/system_auto/editLoan", checkSession, (req, res) => {
  const { startDate, endDate, studyYear, studySemester } = req.body;

  if (!startDate || !endDate) {
    return res.status(400).json({ error: "Invalid dates" });
  }

  const sql =
    "UPDATE Server_editLoan SET open_date = ?, close_date = ?, study_year = ?, study_semester = ?,updated_at = NOW() WHERE 1=1";
  con.query(
    sql,
    [startDate, endDate, studyYear, studySemester],
    (err, _result) => {
      if (err) {
        console.error("Database error:", err);
        return res.status(500).json({ error: "Database error" });
      }
      res.json({
        message: `System scheduled to open: ${startDate} - ${endDate}`,
      });
    }
  );
});

cron.schedule("* * * * *", () => {
  console.log(
    "[CRON] Running scheduled check at:",
    moment_timezone().tz("Asia/Bangkok").format("YYYY-MM-DD HH:mm:ss")
  );

  const today = moment_timezone.tz("Asia/Bangkok").startOf("day");

  const serverSql = `SELECT server_status, open_date, close_date FROM Server LIMIT 1`;
  const serverSql_editLoan = `SELECT server_status, open_date, close_date FROM Server_editLoan LIMIT 1`;

  con.query(serverSql, (err, results) => {
    if (err) {
      console.error("[CRON] Database error (main query):", err);
      return;
    }

    if (results.length === 0) {
      console.warn("[CRON] No Server data found.");
      return;
    }

    const server = results[0];
    const openDate = moment_timezone
      .tz(server.open_date, "Asia/Bangkok")
      .startOf("day");
    const closeDate = moment_timezone
      .tz(server.close_date, "Asia/Bangkok")
      .startOf("day");

    console.log(`[CRON] Submition Status: ${server.server_status}`);
    console.log(
      `[CRON] Submition Dates: Open = ${openDate.format(
        "YYYY-MM-DD"
      )}, Close = ${closeDate.format("YYYY-MM-DD")}`
    );
    console.log(`[CRON] Today: ${today.format("YYYY-MM-DD")}`);

    // === ALWAYS close if past the close date ===
    if (today.isSameOrAfter(closeDate) && server.server_status !== "close") {
      console.log("[CRON] Closing server (past close date)");

      const closeSql = `
        UPDATE Server 
        SET server_status = 'close', updated_at = NOW();
      `;
      con.query(closeSql, (err) => {
        if (err) console.error("[CRON] Error updating to close:", err);
        else console.log("[CRON] Server status updated to 'close'");
      });

      // === Only open if it's within the valid range (between open and close) ===
    } else if (
      server.server_status === "close" &&
      today.isSameOrAfter(openDate) &&
      today.isBefore(closeDate)
    ) {
      console.log("[CRON] Opening server (within open-close range)");

      const openSql = `
        UPDATE Server 
        SET server_status = 'open', updated_at = NOW();
      `;
      con.query(openSql, (err) => {
        if (err) console.error("[CRON] Error updating to open:", err);
        else console.log("[CRON] Server status updated to 'open'");
      });
    } else {
      console.log("[CRON] No change to server status.");
    }
  });

  con.query(serverSql_editLoan, (err, results) => {
    if (err) {
      console.error("[CRON_editLoan] Database error (main query):", err);
      return;
    }

    if (results.length === 0) {
      console.warn("[CRON_editLoan] No Server data found.");
      return;
    }

    const server = results[0];
    const id = server.id;
    const openDate = moment_timezone
      .tz(server.open_date, "Asia/Bangkok")
      .startOf("day");
    const closeDate = moment_timezone
      .tz(server.close_date, "Asia/Bangkok")
      .startOf("day");

    console.log(`[CRON_editLoan] Submition Status: ${server.server_status}`);
    console.log(
      `[CRON_editLoan] Submition Dates: Open = ${openDate.format(
        "YYYY-MM-DD"
      )}, Close = ${closeDate.format("YYYY-MM-DD")}`
    );
    console.log(`[CRON_editLoan] Today: ${today.format("YYYY-MM-DD")}`);

    // === ALWAYS close if past the close date ===
    if (today.isSameOrAfter(closeDate) && server.server_status !== "close") {
      console.log("[CRON_editLoan] Closing server (past close date)");

      const closeSql = `
        UPDATE Server_editLoan
        SET server_status = 'close', updated_at = NOW();
      `;
      con.query(closeSql, (err) => {
        if (err) console.error("[CRON_editLoan] Error updating to close:", err);
        else console.log("[CRON_editLoan] Server status updated to 'close'");
      });

      // === Only open if it's within the valid range (between open and close) ===
    } else if (
      server.server_status === "close" &&
      today.isSameOrAfter(openDate) &&
      today.isBefore(closeDate)
    ) {
      console.log("[CRON_editLoan] Opening server (within open-close range)");

      const openSql = `
        UPDATE Server_editLoan
        SET server_status = 'open', updated_at = NOW();
      `;
      con.query(openSql, (err) => {
        if (err) console.error("[CRON_editLoan] Error updating to open:", err);
        else console.log("[CRON_editLoan] Server status updated to 'open'");
      });
    } else {
      console.log("[CRON_editLoan] No change to server status.");
    }
  });
});

module.exports = router;
