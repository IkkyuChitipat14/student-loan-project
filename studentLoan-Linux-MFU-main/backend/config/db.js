const mysql = require('mysql2');
const util = require('util');

const dbConfig = {
  host: process.env.DB_HOST || 'mysql',
  user: process.env.DB_USER || 'myuser',
  password: process.env.DB_PASSWORD || 'mypassword',
  database: process.env.MYSQL_DATABASE || 'Student_loan',
  port: parseInt(process.env.DB_PORT) || 3306,
};

// Create a connection pool
const pool = mysql.createPool(dbConfig);

// Convert pool query to use promises
const query = util.promisify(pool.query).bind(pool);

// Test connection
pool.getConnection((err, connection) => {
  if (err) {
    console.error('Database connection failed:', err);
    return;
  }
  console.log('Successfully connected to database');
  connection.release(); // Release the connection back to the pool
});

module.exports = {
  query,
  pool
};
