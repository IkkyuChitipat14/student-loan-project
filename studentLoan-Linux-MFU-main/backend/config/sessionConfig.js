const session = require('express-session');
require('dotenv').config(); 

const sessionConfig = () => {
  return session({
    secret: process.env.SESSION_SECRET || 'default-secret', 
    resave: false,
    saveUninitialized: false,
    cookie: {
      secure: true, 
      httpOnly: true,
      maxAge: 15 * 60 * 1000, // Session expiration time (15 minutes)
    },
    rolling: true,
  });
};

module.exports = sessionConfig;
