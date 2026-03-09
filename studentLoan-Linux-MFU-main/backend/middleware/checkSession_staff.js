// checkSession.js
const allowedUsers = require("../config/staff"); // adjust path as needed

function checkSession(req, res, next) {
  if (req.session && req.session.userID) {
    if (allowedUsers.includes(req.session.userID)) {
      next(); // user is logged in and authorized
    } else {
      res.status(403).json({ error: "Forbidden. User not authorized." });
    }
  } else {
    res.status(401).json({ error: "Unauthorized. Please login." });
  }
}

module.exports = checkSession;
