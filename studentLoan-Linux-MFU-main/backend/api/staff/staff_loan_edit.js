const express = require("express");
const router = express.Router();
const con = require("../../config/db");
const checkSession = require("../../middleware/checkSession_staff");

router.patch("/loan/edit/status/bulk", checkSession, function (req, res) {
  const updates = req.body; // [{ ID, newStatus, reason }]
  const managed_by = req.session.userID;

  const allowedStatuses = [
    "อยู่ระหว่างดำเนินการ",
    "ผ่านการตรวจสอบคุณสมบัติ",
    "อยู่ระหว่างตรวจสอบคุณสมบัติผู้กู้ยืม",
    "รอผลการพิจารณาจากกองทุน กยศ.",
    "ตีกลับเพื่อแก้เอกสาร",
    "อนุมัติ",
    "ไม่อนุมัติ",
  ];

  if (!Array.isArray(updates)) {
    return res.status(400).send("Invalid input format. Expecting an array.");
  }

  const successMap = {}; // { "status": count }
  const failures = [];

  const promises = updates.map(({ ID, newStatus, reason = "" }) => {
    if (!allowedStatuses.includes(newStatus)) {
      failures.push({ ID, newStatus, reason: "Invalid status" });
      return Promise.resolve();
    }

    const sql =
      "UPDATE form_response SET loan_status = ?, loan_details = ?, managed_by = ? WHERE public_id = ?";
    return new Promise((resolve) => {
      con.query(sql, [newStatus, reason, managed_by, ID], function (err) {
        if (err) {
          failures.push({ ID, newStatus, reason: "DB error" });
        } else {
          if (!successMap[newStatus]) successMap[newStatus] = 0;
          successMap[newStatus]++;
        }
        resolve();
      });
    });
  });

  Promise.all(promises).then(() => {
    const summary = Object.entries(successMap).map(([status, count]) => ({
      status,
      changed: count,
    }));

    res.json({
      message: "Bulk status update completed.",
      summary,
      failures,
    });
  });
});

router.patch("/loan/edit/income", checkSession, function (req, res) {
  const loanID = req.body.ID;
  const whose_loan = req.body.whose_loan;
  const income = req.body.income;
  const allowedColumns = ["dad_income", "mom_income", "student_income"];
  if (!allowedColumns.includes(whose_loan)) {
    return res.status(400).send("Invalid income field");
  }

  const sql = `UPDATE form_response SET ${whose_loan} = ? WHERE public_id = ?`;
  con.query(sql, [income, loanID], function (err, _results) {
    if (err) {
      console.error(err);
      return res.status(500).send("Database server error");
    }
    res.json("แก้ไขสำเร็จ");
  });
});

router.patch(
  "/loan/edit/public_service_hour",
  checkSession,
  function (req, res) {
    const loanID = req.body.ID;
    const public_service_hour = req.body.public_service_hour;

    if (!loanID || !public_service_hour) {
      return res.status(400).send("Missing required fields");
    }

    const sql = `UPDATE form_response SET Public_Service_Number = ? WHERE public_id = ?`;
    con.query(sql, [public_service_hour, loanID], function (err, _results) {
      if (err) {
        console.error(err);
        return res.status(500).send("Database server error");
      }
      res.json("แก้ไขชั่วโมงจิตสาธารณะสำเร็จ");
    });
  }
);

router.patch("/loan/edit/gpax", checkSession, function (req, res) {
  const loanID = req.body.ID;
  const gpax = req.body.gpax;

  if (!loanID || !gpax) {
    return res.status(400).send("Missing required fields");
  }

  const sql = `UPDATE form_response SET user_gpax = ? WHERE public_id = ?`;
  con.query(sql, [gpax, loanID], function (err, _results) {
    if (err) {
      console.error(err);
      return res.status(500).send("Database server error");
    }
    res.json("แก้ไขGPAXสำเร็จ");
  });
});

router.delete("/delete/loan", checkSession, (req, res) => {
  const public_id = req.query.public_id;
  const sql = "DELETE FROM `form_response` WHERE `public_id` = ?";
  con.query(sql, [public_id], (err, _results) => {
    if (err) {
      console.error("Database error:", err);
      return res.status(500).json({ error: "Database error" });
    }
    res.json({ message: "ลบข้อมูลสำเร็จ" });
  });
});

module.exports = router;