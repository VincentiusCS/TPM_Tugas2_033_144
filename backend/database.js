const mysql = require('mysql2/promise');

// Konfigurasi koneksi MySQL
const dbConfig = {
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || '',
  database: process.env.DB_NAME || 'tpm_app',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
  enableKeepAlive: true,
  keepAliveInitialDelayMs: 0
};

// Buat connection pool
const pool = mysql.createPool(dbConfig);

// Fungsi untuk initialize database
async function initDatabase() {
  let connection;
  try {
    // Test koneksi
    connection = await pool.getConnection();
    console.log('✓ Connected to MySQL database');

    // Buat table users jika belum ada
    await connection.query(`
      CREATE TABLE IF NOT EXISTS users (
        id INT AUTO_INCREMENT PRIMARY KEY,
        username VARCHAR(100) UNIQUE NOT NULL,
        password VARCHAR(255) NOT NULL,
        email VARCHAR(100),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
      )
    `);
    console.log('✓ Users table ready');

    // Seed default users
    await seedDefaultUsers(connection);

    connection.release();
  } catch (error) {
    console.error('Database initialization error:', error.message);
    process.exit(1);
  }
}

// Seed default users
async function seedDefaultUsers(connection) {
  try {
    const defaultUsers = [
      { username: 'admin', password: '1234', email: 'admin@app.com' },
      { username: 'wahyu', password: '033', email: 'wahyu@app.com' },
      { username: 'vincent', password: '144', email: 'vincent@app.com' }
    ];

    for (const user of defaultUsers) {
      try {
        await connection.query(
          'INSERT IGNORE INTO users (username, password, email) VALUES (?, ?, ?)',
          [user.username, user.password, user.email]
        );
      } catch (error) {
        if (!error.message.includes('Duplicate')) {
          throw error;
        }
      }
    }
    console.log('✓ Default users seeded');
  } catch (error) {
    console.error('Error seeding users:', error.message);
  }
}

module.exports = { pool, initDatabase };
