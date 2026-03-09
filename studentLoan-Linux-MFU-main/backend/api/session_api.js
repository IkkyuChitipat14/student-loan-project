const express = require("express");
const router = express.Router();
const staffEmails = require("../config/staff");
const { OAuth2Client } = require("google-auth-library");
const client = new OAuth2Client(process.env.GOOGLE_CLIENT_ID);

router.get("/get/session", (req, res) => {
  if (req.session.userID) {
    res.json({
      userID: req.session.userID,
      role: req.session.role,
      timeOut: req.session.cookie.maxAge,
    });
  } else {
    res.status(401).json({ error: "No session found" });
  }
});

router.post("/reset/session", (req, res) => {
  if (req.session.userID) {
    req.session.cookie.maxAge = 15 * 60 * 1000; // 15 minutes
    res.json({ success: true });
  } else {
    res.status(401).json({ error: "Not logged in" });
  }
});

router.get("/logout", (req, res) => {
  req.session.destroy((err) => {
    if (err) {
      return res.status(500).send("Error logging out");
    }
    // Clear session cookie properly
    res.clearCookie("connect.sid", { path: "/" });
    res.json("Logged out successfully");
  });
});

router.post("/login/save/session", async function (req, res) {
  const { token } = req.body;
  if (!token) {
    return res.status(400).json({ error: "Token is required" });
  }

  try {
    // Verify token with Google
    const ticket = await client.verifyIdToken({
      idToken: token,
      audience: process.env.GOOGLE_CLIENT_ID,
    });

    const payload = ticket.getPayload();
    const email = payload.email;

    const Staff = staffEmails;
    let role = Staff.includes(email) ? "staff" : "user";

    let ID = null;
    if (role === "user") {
      const match = email.match(/^(\d+)(?=@)/);
      ID = match?.[1];
      req.session.userID = ID;
      req.session.role = role;
    } else {
      ID = email;
      req.session.cookie.maxAge = 7 * 24 * 60 * 60 * 1000; // 1 week
      req.session.userID = ID;
      req.session.role = role;
    }

    return res.json({ message: "เข้าสู่ระบบสำเร็จ!", role: role });

  } catch (error) {
    console.error("Token verification failed:", error);
    return res.status(401).json({ error: "Unauthorized" });
  }
});

module.exports = router;
