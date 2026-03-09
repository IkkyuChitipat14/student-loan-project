const express = require("express");
const router = express.Router();
const multer = require("multer");
const app = express();

const { v4: uuidv4 } = require("uuid");
const { decryptData } = require("../utils/jwt_decrypt");
const fs = require("fs");
const con = require("../config/db");
const jwt = require("jsonwebtoken");
const path = require("path");
const crypto = require("crypto");
const checkSession = require("../middleware/checkSession");
const { logFormSubmission } = require("../utils/logger");

// JWT secret
const JWT_SECRET = process.env.JWT_SECRET;
const MAX_FILENAME_LENGTH = 255;

// กำหนดตัวกรองไฟล์เพื่ออนุญาตไฟล์ประเภทที่ต้องการ (เช่น .jpg, .png)
const fileFilter = (_req, file, cb) => {
  const fileTypes = /pdf/;
  const extname = fileTypes.test(path.extname(file.originalname).toLowerCase());
  const mimetype = fileTypes.test(file.mimetype);

  if (extname && mimetype) {
    return cb(null, true);
  } else {
    cb("Error: Only .pdf files are allowed!");
  }
};

const saveFile = (file, fieldName) => {
  if (!file) return null;

  const timestamp = Date.now();
  const hash = crypto.randomBytes(6).toString("hex");
  const safeFilename = `${fieldName}_${timestamp}_${hash}${path.extname(
    file.originalname
  )}`;

  if (safeFilename.length > MAX_FILENAME_LENGTH) {
    throw {
      status: 400,
      message: "The file name is too long. Please use a shorter file name.",
      error: "ENAMETOOLONG",
    };
  }

  const filePath = path.join(uploadPath, safeFilename);
  fs.writeFileSync(filePath, file.buffer || fs.readFileSync(file.tempFilePath));

  // 🔁 Normalize the *public* path before encrypting
  const publicPath = `/uploads/loan_files/${safeFilename}`;
  const encryptedPath = jwt.sign({ value: publicPath }, JWT_SECRET);

  return encryptedPath;
};

// Configure file storage with Multer
const storage = multer.memoryStorage();
const upload = multer({
  storage: storage,
  fileFilter: fileFilter,
  limits: { fileSize: 55 * 1024 * 1024 }, // ขนาดไฟล์ไม่เกิน 10MB
});

const uploadPath = path.join(__dirname, "../uploads/loan_files"); // กำหนดโฟลเดอร์เก็บไฟล์
if (!fs.existsSync(uploadPath)) fs.mkdirSync(uploadPath, { recursive: true }); // ตรวจสอบและสร้างโฟลเดอร์

router.post("/upload", upload.single("file"), (req, res) => {
  console.log("File upload request received");
  if (!req.file) {
    return res.status(400).send("No file uploaded.");
  }
  res.status(200).send({
    message: "File uploaded successfully!",
    file: req.file,
  });
});

// ------------- GET last form --------------
router.get("/get/loan/last", function (req, res) {
  const studentID = req.session.userID;
  if (!studentID) {
    return res.status(400).send("User not authenticated.");
  }
  const sql =
    "SELECT `loan_status`, `public_id`,`user_yearStudy`, `user_semesterStudy` FROM `form_response` WHERE user_studentID = ? ORDER BY `form_response`.`created_at` DESC LIMIT 1;";

  con.query(sql, [studentID], function (err, results) {
    if (err) {
      console.error(err);
      return res.status(500).send("Database server error");
    }
    if (results.length > 0) {
      res.json(results[0]);
    } else {
      res.json(null);
    }
  });
});

// ------------- GET student loan --------------
router.get("/get/loan", function (req, res) {
  const studentID = req.session.userID;
  if (!studentID) {
    return res.status(400).send("User not authenticated.");
  }
  const sql = `
      SELECT 
        DATE_FORMAT(created_at, '%d/%m/%Y') AS date,
        user_lvlStudy, user_yearStudy, user_semesterStudy, user_faculty, 
        user_fieldStudy, loan_status, loan_details, public_id 
      FROM form_response 
      WHERE user_studentID = ? 
      ORDER BY created_at DESC;
    `;

  con.query(sql, [studentID], function (err, results) {
    if (err) {
      console.error("Database Error:", err);
      return res.status(500).send("Database server error");
    }
    res.json(results);
  });
});

// ------------- GET Student loan (info page) --------------
// Also used by staff
router.get("/get/loan/data", checkSession, function (req, res) {
  const loanID = req.query.id;
  const studentID = req.session.userID;

  const sql =
    "SELECT * FROM `form_response` WHERE public_id = ? AND user_studentID = ?";

  con.query(sql, [loanID, studentID], function (err, results) {
    if (err) {
      console.error(err);
      return res.status(500).send("Database server error");
    }

    if (results.length === 0) {
      return res.status(404).send("Loan data not found");
    }

    // Extract loan data
    const loanData = results[0];

    // Decrypt only the encrypted fields
    const decryptedFields = {
      user_citizenID: decryptData(loanData.user_citizenID),
      user_phoneNumber: decryptData(loanData.user_phoneNumber),
      dad_citizenID: decryptData(loanData.dad_citizenID),
      dad_phoneNumber: decryptData(loanData.dad_phoneNumber),
      dad_email: decryptData(loanData.dad_email),
      mom_citizenID: decryptData(loanData.mom_citizenID),
      mom_phoneNumber: decryptData(loanData.mom_phoneNumber),
      mom_email: decryptData(loanData.mom_email),
      other_citizenID: decryptData(loanData.other_citizenID),
      other_phoneNumber: decryptData(loanData.other_phoneNumber),
      other_email: decryptData(loanData.other_email),
      user_username: decryptData(loanData.user_username),
      user_surname: decryptData(loanData.user_surname),
      dad_name: decryptData(loanData.dad_name),
      dad_surname: decryptData(loanData.dad_surname),
      mom_name: decryptData(loanData.mom_name),
      mom_surname: decryptData(loanData.mom_surname),
      other_name: decryptData(loanData.other_name),
      other_surname: decryptData(loanData.other_surname),
      Public_Service_File: decryptData(loanData.Public_Service_File),
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
    };

    // Merge decrypted fields with non-encrypted fields
    const responseData = {
      ...loanData, // Include all original database fields
      ...decryptedFields, // Overwrite encrypted fields with decrypted values
    };

    res.json(responseData);
  });
});

// =====================================================

// =================== UserPage_loan ===================
// ------------- POST sent form --------------
router.post(
  "/loan/submit_form",
  checkSession,
  upload.fields([
    { name: "Public_Service_File", maxCount: 1 },
    { name: "dad_file", maxCount: 1 },
    { name: "mom_file", maxCount: 1 },
    { name: "Marital_status_of_parents_file", maxCount: 1 },
    { name: "other_file", maxCount: 1 },
    { name: "dad_death_certificate_file", maxCount: 1 },
    { name: "mom_death_certificate_file", maxCount: 1 },
    { name: "dad_family_status_certificate_file", maxCount: 1 },
    { name: "mom_family_status_certificate_file", maxCount: 1 },
    { name: "other_NonParent_Custody_Certificate_file", maxCount: 1 },
  ]),
  (req, res) => {
    try {
      // Function to encrypt data using JWT
      const encryptData = (data) => {
        if (!data) return null;
        return jwt.sign({ value: data }, JWT_SECRET, { expiresIn: "100y" }); // Long expiry since we store it
      };

      const user_studentID = req.session.userID;
      if (!user_studentID) {
        return res.status(400).send("User not authenticated.");
      }

      const {
        user_lvlStudy,
        user_yearStudy,
        user_semesterStudy,
        user_faculty,
        user_fieldStudy,
        user_loanType,
        user_gpax,
        user_username,
        user_surname,
        user_old,
        user_phoneNumber,
        user_citizenID,
        user_graduateLvl,
        user_job,
        user_job_income,
        Public_Service_Number,
        dad_status,
        dad_citizenID,
        dad_name,
        dad_surname,
        dad_phoneNumber,
        dad_email,
        dad_job,
        dad_income,
        mom_status,
        mom_citizenID,
        mom_name,
        mom_surname,
        mom_phoneNumber,
        mom_email,
        mom_job,
        mom_income,
        Marital_status_of_parents,
        rightful_guardian,
        other_citizenID,
        other_name,
        other_surname,
        other_phoneNumber,
        other_email,
        other_job,
        other_income,
        other_relationship,
      } = req.body;

      // Generate UUID for public_id
      const public_id = uuidv4();

      // Encrypt sensitive data
      const encryptedData = {
        user_citizenID: encryptData(user_citizenID),
        user_phoneNumber: encryptData(user_phoneNumber),
        dad_citizenID: encryptData(dad_citizenID),
        dad_phoneNumber: encryptData(dad_phoneNumber),
        dad_email: encryptData(dad_email),
        mom_citizenID: encryptData(mom_citizenID),
        mom_phoneNumber: encryptData(mom_phoneNumber),
        mom_email: encryptData(mom_email),
        other_citizenID: encryptData(other_citizenID),
        other_phoneNumber: encryptData(other_phoneNumber),
        other_email: encryptData(other_email),
        user_username: encryptData(user_username),
        user_surname: encryptData(user_surname),
        dad_name: encryptData(dad_name),
        dad_surname: encryptData(dad_surname),
        mom_name: encryptData(mom_name),
        mom_surname: encryptData(mom_surname),
        other_name: encryptData(other_name),
        other_surname: encryptData(other_surname),
      };

      // Convert arrays to JSON strings
      const dailyFee = JSON.stringify(req.body.dailyFee || []);
      const loanPurpose = JSON.stringify(req.body.loanPurpose || []);

      // Encrypt and save file paths
      const Public_Service_File = saveFile(
        req.files?.Public_Service_File?.[0],
        "Public_Service_File"
      );
      const dad_file = saveFile(req.files?.dad_file?.[0], "dad_file");
      const mom_file = saveFile(req.files?.mom_file?.[0], "mom_file");
      const Marital_status_of_parents_file = saveFile(
        req.files?.Marital_status_of_parents_file?.[0],
        "Marital_status_of_parents_file"
      );
      const other_file = saveFile(req.files?.other_file?.[0], "other_file");
      const dad_death_certificate_file = saveFile(
        req.files?.dad_death_certificate_file?.[0],
        "dad_death_certificate_file"
      );
      const mom_death_certificate_file = saveFile(
        req.files?.mom_death_certificate_file?.[0],
        "mom_death_certificate_file"
      );

      const dad_family_status_certificate_file = saveFile(
        req.files?.dad_family_status_certificate_file?.[0],
        "dad_family_status_certificate_file"
      );

      const mom_family_status_certificate_file = saveFile(
        req.files?.mom_family_status_certificate_file?.[0],
        "mom_family_status_certificate_file"
      );

      const other_NonParent_Custody_Certificate_file = saveFile(
        req.files?.other_NonParent_Custody_Certificate_file?.[0],
        "other_NonParent_Custody_Certificate_file"
      );

      // SQL INSERT
      const sql = `
            INSERT INTO form_response (
              public_id, user_lvlStudy, user_yearStudy, user_semesterStudy, user_faculty, user_fieldStudy, user_loanType,
              user_studentID, user_gpax, user_username, user_surname, user_old, user_phoneNumber, user_citizenID,
              user_graduateLvl, occupation, income, daily_expenses_options, loan_purposes_options, Public_Service_Number,
              dad_status, dad_citizenID, dad_name, dad_surname, dad_phoneNumber, dad_email, dad_job, dad_income,
              mom_status, mom_citizenID, mom_name, mom_surname, mom_phoneNumber,
              mom_email, mom_job, mom_income, Marital_status_of_parents, rightful_guardian, other_citizenID, other_name, other_surname, 
              other_phoneNumber, other_email, other_job, other_income, other_relationship, loan_status, Public_Service_File, 
              dad_file, mom_file, Marital_status_of_parents_file, other_file, dad_death_certificate_file, mom_death_certificate_file, dad_family_status_certificate_file, mom_family_status_certificate_file, other_NonParent_Custody_Certificate_file
            ) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);
          `;

      // Insert encrypted values into the database
      const values = [
        public_id, // UUID instead of encryption
        user_lvlStudy,
        user_yearStudy,
        user_semesterStudy,
        user_faculty,
        user_fieldStudy,
        user_loanType,
        user_studentID,
        user_gpax,
        encryptedData.user_username,
        encryptedData.user_surname,
        user_old,
        encryptedData.user_phoneNumber,
        encryptedData.user_citizenID,
        user_graduateLvl,
        user_job,
        user_job_income,
        dailyFee,
        loanPurpose,
        Public_Service_Number,
        dad_status,
        encryptedData.dad_citizenID,
        encryptedData.dad_name,
        encryptedData.dad_surname,
        encryptedData.dad_phoneNumber,
        encryptedData.dad_email,
        dad_job,
        dad_income,
        mom_status,
        encryptedData.mom_citizenID,
        encryptedData.mom_name,
        encryptedData.mom_surname,
        encryptedData.mom_phoneNumber,
        encryptedData.mom_email,
        mom_job,
        mom_income,
        Marital_status_of_parents,
        rightful_guardian,
        encryptedData.other_citizenID,
        encryptedData.other_name,
        encryptedData.other_surname,
        encryptedData.other_phoneNumber,
        encryptedData.other_email,
        other_job,
        other_income,
        other_relationship,
        "อยู่ระหว่างดำเนินการ", // Default loan status
        Public_Service_File,
        dad_file,
        mom_file,
        Marital_status_of_parents_file,
        other_file,
        dad_death_certificate_file,
        mom_death_certificate_file,
        dad_family_status_certificate_file,
        mom_family_status_certificate_file,
        other_NonParent_Custody_Certificate_file,
      ];

      con.query(sql, values, (err, result) => {
        if (err) {
          logFormSubmission({
            status: "fail",
            userID: user_studentID,
            message: "Database error during form submission",
            extra: err,
          });
          return res
            .status(500)
            .json({ message: "Failed to save data", error: err });
        }

        logFormSubmission({
          status: "success",
          userID: user_studentID,
          message: "Form submitted successfully",
          extra: { public_id },
        });

        res.json({ message: "ส่งคำขอกู้เรียบร้อย", public_id, result });
      });
    } catch (error) {
      logFormSubmission({
        status: "fail",
        userID: user_studentID,
        message: "Unhandled server error",
        extra: error.message,
      });
      res
        .status(500)
        .json({ message: "An error occurred", error: error.message });
    }
  }
);

// ------------- POST submit Loan secondSemester --------------
router.post(
  "/loan/submit_form/secondSemester",
  checkSession,
  function (req, res) {
    const formID = req.body.public_id;
    const public_id = uuidv4();
    if (!public_id) {
      return res.status(400).send("Public ID not founded.");
    }
    const sql = `INSERT INTO form_response (user_lvlStudy, user_yearStudy, user_semesterStudy, user_faculty, user_fieldStudy, user_studentID, user_gpax, user_loanType, user_username, user_surname, user_old, user_phoneNumber, user_citizenID, user_graduateLvl, daily_expenses_options, occupation, income, loan_purposes_options, Public_Service_Number, Public_Service_File, dad_status, dad_citizenID, dad_name, dad_surname, dad_phoneNumber, dad_email, dad_job, dad_income, dad_file, dad_death_certificate_file, dad_family_status_certificate_file, mom_status, mom_citizenID, mom_name, mom_surname, mom_phoneNumber, mom_email, mom_job, mom_income, mom_file, mom_death_certificate_file, mom_family_status_certificate_file, Marital_status_of_parents, Marital_status_of_parents_file, other_status, other_citizenID, other_name, other_surname, other_phoneNumber, other_email, other_job, other_income, other_file, other_NonParent_Custody_Certificate_file, other_relationship, rightful_guardian, loan_status, public_id) SELECT user_lvlStudy, user_yearStudy, '2' AS user_semesterStudy, user_faculty, user_fieldStudy, user_studentID, user_gpax, user_loanType, user_username, user_surname, user_old, user_phoneNumber, user_citizenID, user_graduateLvl, daily_expenses_options, occupation, income, loan_purposes_options, Public_Service_Number, Public_Service_File, dad_status, dad_citizenID, dad_name, dad_surname, dad_phoneNumber, dad_email, dad_job, dad_income, dad_file, dad_death_certificate_file, dad_family_status_certificate_file, mom_status, mom_citizenID, mom_name, mom_surname, mom_phoneNumber, mom_email, mom_job, mom_income, mom_file, mom_death_certificate_file, mom_family_status_certificate_file, Marital_status_of_parents, Marital_status_of_parents_file, other_status, other_citizenID, other_name, other_surname, other_phoneNumber, other_email, other_job, other_income, other_file, other_NonParent_Custody_Certificate_file, other_relationship, rightful_guardian, 'อยู่ระหว่างดำเนินการ' AS loan_status,  ? AS public_id FROM form_response WHERE public_id = ?;
`;

    con.query(sql, [public_id, formID], function (err, _results) {
      if (err) {
        console.error(err);
        return res.status(500).send("Database server error");
      }
      res.json({ message: "สำเร็จ" }); // Success message
    });
  }
);

// API edit form
router.post(
  "/loan/edit_form",
  checkSession,
  upload.fields([
    { name: "Public_Service_File", maxCount: 1 },
    { name: "dad_file", maxCount: 1 },
    { name: "mom_file", maxCount: 1 },
    { name: "Marital_status_of_parents_file", maxCount: 1 },
    { name: "other_file", maxCount: 1 },
    { name: "dad_death_certificate_file", maxCount: 1 },
    { name: "mom_death_certificate_file", maxCount: 1 },
    { name: "dad_family_status_certificate_file", maxCount: 1 },
    { name: "mom_family_status_certificate_file", maxCount: 1 },
    { name: "other_NonParent_Custody_Certificate_file", maxCount: 1 },
  ]),
  (req, res) => {
    try {
      const encryptData = (data) => {
        if (!data) return null;
        return jwt.sign({ value: data }, JWT_SECRET, { expiresIn: "100y" });
      };

      const user_studentID = req.session.userID;
      if (!user_studentID) {
        return res.status(400).send("User not authenticated.");
      }

      const {
        public_id, // Get public_id from form
        user_lvlStudy,
        user_yearStudy,
        user_semesterStudy,
        user_faculty,
        user_fieldStudy,
        user_loanType,
        user_gpax,
        user_username,
        user_surname,
        user_old,
        user_phoneNumber,
        user_citizenID,
        user_graduateLvl,
        user_job,
        user_job_income,
        Public_Service_Number,
        dad_status,
        dad_citizenID,
        dad_name,
        dad_surname,
        dad_phoneNumber,
        dad_email,
        dad_job,
        dad_income,
        mom_status,
        mom_citizenID,
        mom_name,
        mom_surname,
        mom_phoneNumber,
        mom_email,
        mom_job,
        mom_income,
        Marital_status_of_parents,
        rightful_guardian,
        other_citizenID,
        other_name,
        other_surname,
        other_phoneNumber,
        other_email,
        other_job,
        other_income,
        other_relationship,
      } = req.body;

      const dailyFee = JSON.stringify(req.body.dailyFee || []);
      const loanPurpose = JSON.stringify(req.body.loanPurpose || []);

      // Encrypt sensitive data
      const encryptedData = {
        user_citizenID: encryptData(user_citizenID),
        user_phoneNumber: encryptData(user_phoneNumber),
        dad_citizenID: encryptData(dad_citizenID),
        dad_phoneNumber: encryptData(dad_phoneNumber),
        dad_email: encryptData(dad_email),
        mom_citizenID: encryptData(mom_citizenID),
        mom_phoneNumber: encryptData(mom_phoneNumber),
        mom_email: encryptData(mom_email),
        other_citizenID: encryptData(other_citizenID),
        other_phoneNumber: encryptData(other_phoneNumber),
        other_email: encryptData(other_email),
        user_username: encryptData(user_username),
        user_surname: encryptData(user_surname),
        dad_name: encryptData(dad_name),
        dad_surname: encryptData(dad_surname),
        mom_name: encryptData(mom_name),
        mom_surname: encryptData(mom_surname),
        other_name: encryptData(other_name),
        other_surname: encryptData(other_surname),
      };

      // 1. Get current file paths from DB
      const getOldFilesSQL = `SELECT * FROM form_response WHERE public_id = ? LIMIT 1`;
      con.query(getOldFilesSQL, [public_id], (err, result) => {
        if (err || result.length === 0) {
          console.error("Failed to fetch existing form:", err);
          return res
            .status(500)
            .json({ message: "Form not found", error: err });
        }

        const oldData = result[0];

        const getUpdatedFilePath = (fieldName) => {
          const file = req.files?.[fieldName]?.[0];
          const oldFile = req.body[`${fieldName}_Old`];

          if (file) {
            return saveFile(file, fieldName); // New file uploaded
          } else if (oldFile) {
            return encryptData(oldFile); // Use old file path if provided
          }

          return null; // No file at all
        };

        const updatedValues = [
          user_lvlStudy,
          user_yearStudy,
          user_semesterStudy,
          user_faculty,
          user_fieldStudy,
          user_loanType,
          user_studentID,
          user_gpax,
          encryptedData.user_username,
          encryptedData.user_surname,
          user_old,
          encryptedData.user_phoneNumber,
          encryptedData.user_citizenID,
          user_graduateLvl,
          user_job,
          user_job_income,
          dailyFee,
          loanPurpose,
          Public_Service_Number,
          dad_status,
          encryptedData.dad_citizenID,
          encryptedData.dad_name,
          encryptedData.dad_surname,
          encryptedData.dad_phoneNumber,
          encryptedData.dad_email,
          dad_job,
          dad_income,
          mom_status,
          encryptedData.mom_citizenID,
          encryptedData.mom_name,
          encryptedData.mom_surname,
          encryptedData.mom_phoneNumber,
          encryptedData.mom_email,
          mom_job,
          mom_income,
          Marital_status_of_parents,
          rightful_guardian,
          encryptedData.other_citizenID,
          encryptedData.other_name,
          encryptedData.other_surname,
          encryptedData.other_phoneNumber,
          encryptedData.other_email,
          other_job,
          other_income,
          other_relationship,
          // File fields, null if not uploaded
          getUpdatedFilePath("Public_Service_File"),
          getUpdatedFilePath("dad_file"),
          getUpdatedFilePath("mom_file"),
          getUpdatedFilePath("Marital_status_of_parents_file"),
          getUpdatedFilePath("other_file"),
          getUpdatedFilePath("dad_death_certificate_file"),
          getUpdatedFilePath("mom_death_certificate_file"),
          getUpdatedFilePath("dad_family_status_certificate_file"),
          getUpdatedFilePath("mom_family_status_certificate_file"),
          getUpdatedFilePath("other_NonParent_Custody_Certificate_file"),
          public_id, // WHERE condition
        ];

        const updateSQL = `
          UPDATE form_response SET
            user_lvlStudy=?, user_yearStudy=?, user_semesterStudy=?, user_faculty=?, user_fieldStudy=?, user_loanType=?,
            user_studentID=?, user_gpax=?, user_username=?, user_surname=?, user_old=?, user_phoneNumber=?, user_citizenID=?,
            user_graduateLvl=?, occupation=?, income=?, daily_expenses_options=?, loan_purposes_options=?, Public_Service_Number=?,
            dad_status=?, dad_citizenID=?, dad_name=?, dad_surname=?, dad_phoneNumber=?, dad_email=?, dad_job=?, dad_income=?,
            mom_status=?, mom_citizenID=?, mom_name=?, mom_surname=?, mom_phoneNumber=?, mom_email=?, mom_job=?, mom_income=?,
            Marital_status_of_parents=?, rightful_guardian=?, other_citizenID=?, other_name=?, other_surname=?,
            other_phoneNumber=?, other_email=?, other_job=?, other_income=?, other_relationship=?,
            Public_Service_File=?, dad_file=?, mom_file=?, Marital_status_of_parents_file=?, other_file=?, dad_death_certificate_file=?, mom_death_certificate_file=?, dad_family_status_certificate_file=?, mom_family_status_certificate_file=?, created_at = NOW(), loan_status = "อยู่ระหว่างดำเนินการ", other_NonParent_Custody_Certificate_file=?
          WHERE public_id = ?`;

        con.query(updateSQL, updatedValues, (err, updateResult) => {
          if (err) {
            console.error("Update Error:", err);
            return res
              .status(500)
              .json({ message: "Failed to update", error: err });
          }
          res.json({
            message: "อัปเดตคำขอกู้เรียบร้อย",
            public_id,
            result: updateResult,
          });
        });
      });
    } catch (error) {
      console.error("Unhandled Error:", error.message);
      res
        .status(500)
        .json({ message: "An error occurred", error: error.message });
    }
  }
);

// ------------- GET education_level --------------
router.get("/loan/get/education_level", function (_req, res) {
  const sql = "SELECT * FROM `education_level`;";
  con.query(sql, function (err, results) {
    if (err) {
      console.error(err);
      return res.status(500).send("Database server error");
    }
    res.json(results);
  });
});

// ------------- GET faculty --------------
router.get("/loan/get/faculty", function (_req, res) {
  const sql = "SELECT * FROM `faculty`;";
  con.query(sql, function (err, results) {
    if (err) {
      console.error(err);
      return res.status(500).send("Database server error");
    }
    res.json(results);
  });
});

// ------------- GET Field of study --------------
router.get("/loan/get/fieldofstudy", function (req, res) {
  const faculty = req.query.faculty; // Extract query parameters
  const sql =
    "SELECT `Field_of_study` FROM `field_of_study` WHERE `Faculty` = ?";
  con.query(sql, faculty, function (err, results) {
    if (err) {
      console.error(err);
      return res.status(500).send("Database server error");
    }
    res.json(results);
  });
});

// ------------- GET Graduated Level --------------
router.get("/loan/get/graduatedLevel", function (req, res) {
  const sql = "SELECT * FROM `graduated_level` ";
  con.query(sql, function (err, results) {
    if (err) {
      console.error(err);
      return res.status(500).send("Database server error");
    }
    res.json(results);
  });
});

// ------------- GET Daily expenses options --------------
router.get("/loan/get/dailyExpensesOptions", function (req, res) {
  const sql =
    "SELECT * FROM `daily_expenses_options` ORDER BY `daily_expenses_options`.`sub_category` ASC";
  con.query(sql, function (err, results) {
    if (err) {
      console.error(err);
      return res.status(500).send("Database server error");
    }
    res.json(results);
  });
});

// ------------- GET Loan purposes option --------------
router.get("/loan/get/loanPurposesOption", function (req, res) {
  const sql = "SELECT * FROM `loan_purposes_options`;";
  con.query(sql, function (err, results) {
    if (err) {
      console.error(err);
      return res.status(500).send("Database server error");
    }
    res.json(results);
  });
});
// ------------- GET Server status --------------
// also used by user Navbar
router.get("/loan/server/status", function (req, res) {
  const sql =
    "SELECT `server_status`, `study_year`, `study_semester` FROM `Server`";
  con.query(sql, function (err, results) {
    if (err) {
      console.error(err);
      return res.status(500).send("Database server error");
    }
    res.json(results[0]);
  });
});
// ------------- GET Server_editLoan status --------------
router.get("/loan/server/editLoan/status", function (req, res) {
  const sql =
    "SELECT `server_status`, `study_year`, `study_semester` FROM `Server_editLoan`";
  con.query(sql, function (err, results) {
    if (err) {
      console.error(err);
      return res.status(500).send("Database server error");
    }
    res.json(results[0]);
  });
});
// ------------- POST reject Loan --------------
router.post("/reject/toLoan", function (req, res) {
  const want_to_loan = req.body.want_to_loan;
  let wantToLoan = want_to_loan === false ? "no" : "yes";

  const studentID = req.session.userID;
  if (!studentID) {
    return res.status(400).send("User not authenticated.");
  }

  // Step 1: Check if a record already exists
  const checkSql = `SELECT urt.* FROM user_reject_toloan urt JOIN Server s ON urt.user_studyYear = s.study_year WHERE urt.student_id = ? ORDER BY urt.id DESC LIMIT 1;`;

  con.query(checkSql, [studentID], function (err, results) {
    if (err) {
      console.error(err);
      return res.status(500).send("Database server error");
    }

    if (results.length > 0) {
      return res.status(200).json({ message: "found" });
    }

    // Step 2: If no existing record, insert new one
    const insertSql = `
      INSERT INTO user_reject_toloan (student_id, user_studyYear, want_to_loan)
      SELECT ?, study_year, ? FROM Server;
    `;

    con.query(
      insertSql,
      [studentID, wantToLoan],
      function (err, insertResults) {
        if (err) {
          console.error(err);
          return res.status(500).send("Database server error");
        }
        res.json({ message: "สำเร็จ" }); // Success message
      }
    );
  });
});

// ------------- GET reject Loan --------------
router.get("/reject/toLoan/check", function (req, res) {
  const studentID = req.session.userID;
  if (!studentID) {
    return res.status(400).send("User not authenticated.");
  }

  const sql =
    "SELECT urt.student_id, urt.user_studyYear, urt.want_to_loan FROM user_reject_toloan urt JOIN Server s ON urt.user_studyYear = s.study_year WHERE urt.student_id = ? ORDER BY urt.id DESC LIMIT 1;";

  con.query(sql, [studentID], function (err, results) {
    if (err) {
      console.error(err);
      return res.status(500).send("Database server error");
    }
    if (results == "") {
      return res.json({ message: "not found" });
    }
    if (results[0].want_to_loan == "no") {
      res.json({ loaning: false });
    } else {
      res.json({ loaning: true });
    }
  });
});

// Export the router to use in server.js
module.exports = router;
