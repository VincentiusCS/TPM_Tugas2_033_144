# REST API Backend Setup - MySQL Edition

Backend server untuk autentikasi menggunakan Node.js + Express + MySQL.

## Prerequisites

- Node.js 18+ (https://nodejs.org)
- npm (bundled dengan Node.js)
- MySQL Server 5.7+ (https://www.mysql.com/downloads/)

## Setup MySQL

### 1. Buat Database
Buka MySQL client atau MySQL Workbench dan jalankan:

```sql
CREATE DATABASE tpm_app CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

### 2. Konfigurasi Koneksi
Salin file `.env.example` menjadi `.env`:

```bash
cp .env.example .env
```

Edit `.env` dengan credential MySQL Anda:
```env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_password
DB_NAME=tpm_app
PORT=3000
```

## Installation & Running

1. Install dependencies:
```bash
npm install
```

2. Jalankan server:
```bash
npm start
```

Server akan berjalan di `http://localhost:3000`

### Tabel users otomatis dibuat dengan struktur:
```
- id (INT, Auto Increment, Primary Key)
- username (VARCHAR, UNIQUE)
- password (VARCHAR)
- email (VARCHAR, Optional)
- created_at (TIMESTAMP)
- updated_at (TIMESTAMP)
```

### Default Users:
- admin / 1234 (admin@app.com)
- wahyu / 033 (wahyu@app.com)
- vincent / 144 (vincent@app.com)

## API Endpoints

### POST /api/login
Login dengan username dan password.

**Request:**
```json
{
  "username": "admin",
  "password": "1234"
}
```

**Success Response (200):**
```json
{
  "success": true,
  "message": "Login berhasil",
  "user": {
    "id": 1,
    "username": "admin",
    "email": "admin@app.com"
  }
}
```

**Error Response (401):**
```json
{
  "success": false,
  "message": "Username atau password salah"
}
```

### POST /api/register
Register user baru.

**Request:**
```json
{
  "username": "newuser",
  "password": "password123",
  "email": "user@example.com"
}
```

**Success Response (201):**
```json
{
  "success": true,
  "message": "Registrasi berhasil. Silakan login."
}
```

**Error Responses:**
- 400: Validasi gagal (minimal 4 karakter password, email invalid, dsb)
- 409: Username sudah terdaftar

### GET /api/user/:id
Dapatkan info user (untuk future expansion).

**Response (200):**
```json
{
  "success": true,
  "user": {
    "id": 1,
    "username": "admin",
    "email": "admin@app.com",
    "created_at": "2026-03-27T10:30:00"
  }
}
```

### GET /api/health
Health check.

**Response (200):**
```json
{
  "status": "OK"
}
```

## Troubleshooting

### "Cannot connect to MySQL"
- Pastikan MySQL server berjalan
- Verify DB_HOST, DB_USER, DB_PASSWORD di `.env`
- MySQL default port adalah 3306

### "Database tpm_app does not exist"
- Jalankan `CREATE DATABASE tpm_app;` di MySQL client

### "Error: ER_BAD_DB_ERROR"
- Buat database terlebih dahulu sebelum menjalankan server

## Environment Variables

Copy `.env.example` ke `.env` dan sesuaikan:

```env
DB_HOST=localhost        # MySQL host
DB_USER=root             # MySQL username
DB_PASSWORD=             # MySQL password (kosong jika none)
DB_NAME=tpm_app          # Database name
PORT=3000                # Server port
```
