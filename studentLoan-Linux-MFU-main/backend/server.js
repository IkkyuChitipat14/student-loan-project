const express = require("express");
const serveStatic = require("serve-static");
const cors = require("cors");
const path = require("path");

const corsOptions = require("./config/corsConfig");
const sessionConfig = require("./config/sessionConfig");
const { pool } = require("./config/db");

const sessionApi = require("./api/session_api");
const userAPI = require("./api/user_api");
const staffAPI = require("./api/staff_api");

// .env handling
require("dotenv").config();
console.log(`Loaded ${process.env.NODE_ENV} environment file.`);

const app = express();
app.use(express.json({ limit: "100mb" }));
app.use(express.urlencoded({ limit: "100mb", extended: true }));
app.use(cors(corsOptions));
app.use(sessionConfig());

app.use(serveStatic(__dirname + "/dist"));

app.use(
  "/uploads/loan_files",
  express.static(path.join(__dirname, "/uploads/loan_files"))
);

app.use("/session", sessionApi);
app.use("/user", userAPI);
app.use("/staff", staffAPI);

pool.getConnection((err, connection) => {
  if (err) {
    console.error("Error connecting to the database:", err);
    process.exit(1);
  }

  connection.release();
  console.log("Database connection established");

  // Start the server
  app.listen(process.env.BACKEND_PORT, process.env.BACKEND_HOSTNAME, () => {
    console.log(
      `Server running at http://${process.env.BACKEND_HOSTNAME}:${process.env.BACKEND_PORT}/`
    );
  });
});
