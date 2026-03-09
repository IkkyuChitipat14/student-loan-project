const fs = require("fs");
const path = require("path");

const logDir = path.join(__dirname, "../logs");
const logPath = path.join(logDir, "form_submission.log");

// Ensure the directory exists
if (!fs.existsSync(logDir)) {
  fs.mkdirSync(logDir, { recursive: true });
}

function logFormSubmission({ status, userID, message, extra = null }) {
  const timestamp = new Date().toISOString();
  const logEntry = `[${timestamp}] [${status.toUpperCase()}] User: ${userID || 'Unknown'} - ${message}${extra ? ' - ' + JSON.stringify(extra) : ''}\n`;

  fs.appendFile(logPath, logEntry, (err) => {
    if (err) console.error("Logging failed:", err);
  });
}

module.exports = { logFormSubmission };
