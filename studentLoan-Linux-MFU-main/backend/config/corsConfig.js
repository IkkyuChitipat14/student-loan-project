const cors = require('cors');

const allowedOrigins = process.env.ALLOWED_ORIGINS || "http://localhost:1080";  

const corsOptions = {
  origin: allowedOrigins.split(','), 
  credentials: true, 
};

module.exports = corsOptions;