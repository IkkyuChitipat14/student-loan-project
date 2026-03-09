const express = require("express");
const router = express.Router();
const con = require("../../config/db");
const { decryptData } = require("../../utils/jwt_decrypt");
const checkSession = require("../../middleware/checkSession_staff");

router.get("/get/loan/search", checkSession, function (req, res) {
  const searchCriteria = req.query;

  let baseSql = `
    SELECT DATE_FORMAT(created_at, '%d/%m/%Y') AS date, 
           DATE_FORMAT(created_at, '%H:%i') AS time,
           user_studentID, user_username, user_surname, 
           user_lvlStudy, user_yearStudy, user_semesterStudy, 
           user_faculty, user_fieldStudy, loan_status, 
           managed_by ,loan_details, public_id 
    FROM form_response 
    WHERE 1=1
  `;

  let countSql = `
    SELECT COUNT(*) AS total 
    FROM form_response 
    WHERE 1=1
  `;

  const queryParams = [];
  const countParams = [];

  const appendCondition = (sql, clause, value) => {
    sql += clause;
    queryParams.push(value);
    countParams.push(value);
    return sql;
  };

  if (searchCriteria.student_id) {
    baseSql = appendCondition(
      baseSql,
      " AND user_studentID = ?",
      searchCriteria.student_id
    );
    countSql += " AND user_studentID = ?";
  }

  if (searchCriteria.graduated_level) {
    baseSql = appendCondition(
      baseSql,
      " AND user_lvlStudy = ?",
      searchCriteria.graduated_level
    );
    countSql += " AND user_lvlStudy = ?";
  }

  if (searchCriteria.study_year) {
    baseSql = appendCondition(
      baseSql,
      " AND user_yearStudy = ?",
      searchCriteria.study_year
    );
    countSql += " AND user_yearStudy = ?";
  }

  if (searchCriteria.study_semester) {
    baseSql = appendCondition(
      baseSql,
      " AND user_semesterStudy = ?",
      searchCriteria.study_semester
    );
    countSql += " AND user_semesterStudy = ?";
  }

  if (searchCriteria.study_level) {
    baseSql = appendCondition(
      baseSql,
      " AND user_lvlStudy = ?",
      searchCriteria.study_level
    );
    countSql += " AND user_lvlStudy = ?";
  }

  if (searchCriteria.submission_date && searchCriteria.submission_date_end) {
    baseSql += " AND created_at BETWEEN ? AND ?";
    countSql += " AND created_at BETWEEN ? AND ?";
    queryParams.push(
      searchCriteria.submission_date,
      searchCriteria.submission_date_end
    );
    countParams.push(
      searchCriteria.submission_date,
      searchCriteria.submission_date_end
    );
  }

  if (searchCriteria.loan_status) {
    baseSql = appendCondition(
      baseSql,
      " AND loan_status = ?",
      searchCriteria.loan_status
    );
    countSql += " AND loan_status = ?";
  }

  // Sort
  baseSql +=
    searchCriteria.orderByDate === "true"
      ? " ORDER BY form_response.created_at DESC"
      : " ORDER BY form_response.created_at ASC";

  // No LIMIT / OFFSET anymore

  // Get total count
  con.query(countSql, countParams, function (countErr, countResult) {
    if (countErr) {
      console.error(countErr);
      return res.status(500).send("Database server error (count)");
    }

    const total = countResult[0].total;

    con.query(baseSql, queryParams, function (err, results) {
      if (err) {
        console.error(err);
        return res.status(500).send("Database server error (data)");
      }

      const filteredResults = results
        .map((row) => ({
          ...row,
          user_username: decryptData(row.user_username),
          user_surname: decryptData(row.user_surname),
        }))
        .filter((row) => {
          let matchesFirstName =
            !searchCriteria.first_name ||
            row.user_username
              .toLowerCase()
              .includes(searchCriteria.first_name.toLowerCase());

          let matchesLastName =
            !searchCriteria.last_name ||
            row.user_surname
              .toLowerCase()
              .includes(searchCriteria.last_name.toLowerCase());

          return matchesFirstName && matchesLastName;
        });

      const total = filteredResults.length; // <-- แก้ตรงนี้

      res.json({
        total,
        data: filteredResults,
      });
    });
  });
});

function decryptLoanData(loanData) {
  const decryptedFields = {
    user_citizenID: decryptData(loanData.user_citizenID),
    user_citizenID_file: decryptData(loanData.user_citizenID_file),
    user_phoneNumber: decryptData(loanData.user_phoneNumber),
    fan_citizenID: decryptData(loanData.fan_citizenID),
    fan_citizenID_file: decryptData(loanData.fan_citizenID_file),
    fan_phoneNumber: decryptData(loanData.fan_phoneNumber),
    fan_email: decryptData(loanData.fan_email),
    dad_citizenID: decryptData(loanData.dad_citizenID),
    dad_citizenID_file: decryptData(loanData.dad_citizenID_file),
    dad_phoneNumber: decryptData(loanData.dad_phoneNumber),
    dad_email: decryptData(loanData.dad_email),
    mom_citizenID: decryptData(loanData.mom_citizenID),
    mom_citizenID_file: decryptData(loanData.mom_citizenID_file),
    mom_phoneNumber: decryptData(loanData.mom_phoneNumber),
    mom_email: decryptData(loanData.mom_email),
    other_citizenID: decryptData(loanData.other_citizenID),
    other_citizenID_file: decryptData(loanData.other_citizenID_file),
    other_phoneNumber: decryptData(loanData.other_phoneNumber),
    other_email: decryptData(loanData.other_email),
    user_username: decryptData(loanData.user_username),
    user_surname: decryptData(loanData.user_surname),
    fan_name: decryptData(loanData.fan_name),
    fan_surname: decryptData(loanData.fan_surname),
    dad_name: decryptData(loanData.dad_name),
    dad_surname: decryptData(loanData.dad_surname),
    mom_name: decryptData(loanData.mom_name),
    mom_surname: decryptData(loanData.mom_surname),
    other_name: decryptData(loanData.other_name),
    other_surname: decryptData(loanData.other_surname),
    user_gpax_file: decryptData(loanData.user_gpax_file),
    user_transcript_file: decryptData(loanData.user_transcript_file),
    user_studentCertificate_file: decryptData(
      loanData.user_studentCertificate_file
    ),
    user_courseCertificate_file: decryptData(
      loanData.user_courseCertificate_file
    ),
    Public_Service_File: decryptData(loanData.Public_Service_File),
    income_file: decryptData(loanData.income_file),
    fan_income_file: decryptData(loanData.fan_income_file),
    fan_file: decryptData(loanData.fan_file),
    dad_file: decryptData(loanData.dad_file),
    mom_file: decryptData(loanData.mom_file),
    Marital_status_of_parents_file: decryptData(
      loanData.Marital_status_of_parents_file
    ),
    other_file: decryptData(loanData.other_file),
    dad_death_certificate_file: decryptData(
      loanData.dad_death_certificate_file
    ),
    mom_death_certificate_file: decryptData(
      loanData.mom_death_certificate_file
    ),
    dad_family_status_certificate_file: decryptData(
      loanData.dad_family_status_certificate_file
    ),
    mom_family_status_certificate_file: decryptData(
      loanData.mom_family_status_certificate_file
    ),
    other_NonParent_Custody_Certificate_file: decryptData(
      loanData.other_NonParent_Custody_Certificate_file
    ),
    user_imageFile: decryptData(loanData.user_imageFile),
  };

  return {
    ...loanData,
    ...decryptedFields,
  };
}

router.get("/get/loan/data", checkSession, function (req, res) {
  const loanID = req.query.id;
  const sql = "SELECT * FROM `form_response` WHERE public_id = ?";

  con.query(sql, [loanID], function (err, results) {
    if (err) {
      console.error(err);
      return res.status(500).send("Database server error");
    }

    if (results.length === 0) {
      return res.status(404).send("Loan data not found");
    }

    const responseData = decryptLoanData(results[0]);
    res.json(responseData);
  });
});

router.post("/get/loan/data/bulk", checkSession, function (req, res) {
  const ids = req.body.ids;

  if (!Array.isArray(ids) || ids.length === 0) {
    return res.status(400).json({ message: "Invalid or empty ID array" });
  }

  const placeholders = ids.map(() => "?").join(", ");
  const sql = `SELECT * FROM form_response WHERE public_id IN (${placeholders})`;

  con.query(sql, ids, function (err, results) {
    if (err) {
      console.error("Database error:", err);
      return res.status(500).json({ message: "Database server error" });
    }

    if (!results.length) {
      return res.status(404).json({ message: "No loan records found" });
    }

    const decryptedResults = results.map(decryptLoanData);
    res.json(decryptedResults);
  });
});

module.exports = router;
