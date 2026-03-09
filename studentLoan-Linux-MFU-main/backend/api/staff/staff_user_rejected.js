const express = require("express");
const router = express.Router();
const con = require("../../config/db");

const checkSession = require("../../middleware/checkSession_staff");

// ------------- Patch userreject Loan --------------
router.patch("/reject/update/user", checkSession, function (req, res) {
  const { studentID, value } = req.body;

  if (!studentID) {
    return res.status(400).send("Not found studentID");
  }

  if (!value) {
    return res.status(400).send("Not found value");
  }

  const sql = `
   UPDATE user_reject_toloan urt JOIN Server s ON urt.user_studyYear = s.study_year SET urt.want_to_loan = ? WHERE urt.student_id = ?;
  `;

  con.query(sql, [value, studentID], function (err, _results) {
    if (err) {
      console.error(err);
      return res.status(500).send("Database server error");
    }
    res.json({ message: "สำเร็จ" });
  });
});

// routes/staff.js (or wherever your route is defined)
router.get("/reject/search/user", checkSession, function (req, res) {
  const { studentID, studyYear, wantToLoan } = req.query;

  let sql = `
    SELECT urt.student_id, urt.user_studyYear, urt.want_to_loan
    FROM user_reject_toloan urt
    JOIN Server s ON urt.user_studyYear = s.study_year
    WHERE 1 = 1
  `;
  const queryParams = [];

  if (studentID && studentID !== "null" && studentID !== "") {
    sql += " AND urt.student_id = ?";
    queryParams.push(studentID);
  }

  if (studyYear && studyYear !== "null" && studyYear !== "") {
    sql += " AND urt.user_studyYear = ?";
    queryParams.push(studyYear);
  }

  if (wantToLoan === "yes" || wantToLoan === "no") {
    sql += " AND urt.want_to_loan = ?";
    queryParams.push(wantToLoan);
  }

  con.query(sql, queryParams, function (err, results) {
    if (err) {
      console.error("Database error:", err);
      return res.status(500).send("Database server error");
    }
    res.json(results);
  });
});

module.exports = router;
