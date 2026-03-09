function checkSession(req, res, next) {
  if (req.session && req.session.userID) {
    next(); // continue to the real route
  } else {
    res.status(401).json({ error: "Unauthorized. Please login." });
  }
}

module.exports = checkSession;