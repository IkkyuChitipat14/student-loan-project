require('dotenv').config({
  path: process.env.NODE_ENV === 'production' ? './production.env' : './dev.env'
});
const jwt = require('jsonwebtoken');
const JWT_SECRET = process.env.JWT_SECRET;

const decryptData = (token) => {
  if (!token) return null;
  try {
    const decoded = jwt.verify(token, JWT_SECRET);
    return decoded.value; // Extract the original value
  } catch (error) {
    console.error("JWT Decryption Error:", error.message);
    return null; // Return null if decryption fails
  }
};

module.exports = { decryptData };
