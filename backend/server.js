const express = require('express');
const cors = require('cors');
const { pool, initDatabase } = require('./database');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());

// Initialize database
initDatabase();

// Routes

// Login endpoint
app.post('/api/login', async (req, res) => {
  const { username, password } = req.body;

  if (!username || !password) {
    return res.status(400).json({
      success: false,
      message: 'Username dan password diperlukan'
    });
  }

  let connection;
  try {
    connection = await pool.getConnection();
    const [rows] = await connection.query(
      'SELECT id, username, email FROM users WHERE username = ? AND password = ?',
      [username, password]
    );

    if (rows.length > 0) {
      return res.status(200).json({
        success: true,
        message: 'Login berhasil',
        user: {
          id: rows[0].id,
          username: rows[0].username,
          email: rows[0].email
        }
      });
    } else {
      return res.status(401).json({
        success: false,
        message: 'Username atau password salah'
      });
    }
  } catch (error) {
    console.error('Login error:', error);
    return res.status(500).json({
      success: false,
      message: 'Error server'
    });
  } finally {
    if (connection) connection.release();
  }
});

// Register endpoint
app.post('/api/register', async (req, res) => {
  const { username, password, email } = req.body;

  // Validasi input
  if (!username || !password) {
    return res.status(400).json({
      success: false,
      message: 'Username dan password diperlukan'
    });
  }

  if (password.length < 4) {
    return res.status(400).json({
      success: false,
      message: 'Password minimal 4 karakter'
    });
  }

  if (email && !isValidEmail(email)) {
    return res.status(400).json({
      success: false,
      message: 'Email tidak valid'
    });
  }

  let connection;
  try {
    connection = await pool.getConnection();

    // Check username sudah ada
    const [existingUser] = await connection.query(
      'SELECT id FROM users WHERE username = ?',
      [username]
    );

    if (existingUser.length > 0) {
      return res.status(409).json({
        success: false,
        message: 'Username sudah terdaftar'
      });
    }

    // Insert user baru
    await connection.query(
      'INSERT INTO users (username, password, email) VALUES (?, ?, ?)',
      [username, password, email || null]
    );

    return res.status(201).json({
      success: true,
      message: 'Registrasi berhasil. Silakan login.'
    });
  } catch (error) {
    console.error('Register error:', error);
    return res.status(500).json({
      success: false,
      message: 'Error server'
    });
  } finally {
    if (connection) connection.release();
  }
});

// Get user profile (contoh endpoint tambahan)
app.get('/api/user/:id', async (req, res) => {
  const { id } = req.params;

  let connection;
  try {
    connection = await pool.getConnection();
    const [rows] = await connection.query(
      'SELECT id, username, email, created_at FROM users WHERE id = ?',
      [id]
    );

    if (rows.length > 0) {
      return res.status(200).json({
        success: true,
        user: rows[0]
      });
    } else {
      return res.status(404).json({
        success: false,
        message: 'User tidak ditemukan'
      });
    }
  } catch (error) {
    console.error('Get user error:', error);
    return res.status(500).json({
      success: false,
      message: 'Error server'
    });
  } finally {
    if (connection) connection.release();
  }
});

// Health check
app.get('/api/health', (req, res) => {
  res.json({ status: 'OK' });
});

// Helper function untuk validasi email
function isValidEmail(email) {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return emailRegex.test(email);
}

// Start server
app.listen(PORT, () => {
  console.log(`\n🚀 Backend berjalan di http://localhost:${PORT}`);
  console.log(`📊 Database: MySQL\n`);
});

// Graceful shutdown
process.on('SIGINT', () => {
  console.log('\n⏹️  Shutting down...');
  pool.end(() => {
    console.log('✓ Database connection closed');
    process.exit(0);
  });
});
