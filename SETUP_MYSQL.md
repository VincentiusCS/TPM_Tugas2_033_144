# SETUP GUIDE - MySQL & Registration

## 1. MySQL Setup

### Step 1: Install MySQL
Download dan install dari https://www.mysql.com/downloads/

### Step 2: Buat Database
Buka MySQL Command Client atau MySQL Workbench, jalankan:
```sql
CREATE DATABASE tpm_app CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

### Step 3: Configure Backend
1. Copy `backend/.env.example` ke `backend/.env`
2. Edit `.env` dengan MySQL credentials:
```env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_password
DB_NAME=tpm_app
PORT=3000
```

## 2. Jalankan Backend

```bash
cd backend
npm install  # jika belum di-install
npm start
```

Output:
```
🚀 Backend berjalan di http://localhost:3000
📊 Database: MySQL
```

## 3. Jalankan Flutter App

Buka Flutter emulator/device dan run app dengan USB debugging/emulator.

## 4. Test Registrasi & Login

### Login Tab:
- Klik "Daftar di sini" → RegisterPage
- Atau login dengan default users:
  - admin / 1234
  - wahyu / 033
  - vincent / 144

### Register Tab:
- Isi: Username (3+ chars), Email (optional), Password (4+ chars)
- Tekan "Daftar"
- Sukses → Redirect ke Login page
- Login dengan akun yang baru dibuat

## File Structure

```
backend/
├── server.js          # Express server + routes
├── database.js        # MySQL connection & schema
├── .env.example       # Config template
├── .env               # Config actual (gitignored)
├── package.json       # Dependencies
└── README.md          # Backend docs

lib/
├── pages/
│   ├── login_page.dart      # Updated dengan register link
│   └── register_page.dart   # NEW - Registration UI
├── services/
│   ├── auth_service.dart    # Now async, supports register
│   └── api_client.dart      # HTTP client
└── ...
```

## What's New (27-03-2026)

✅ MySQL Database (replace SQLite)
✅ Full Registration Page with Email field
✅ Input Validation (username, password, email)
✅ Success/Error Messages
✅ Navigation between Login/Register pages
✅ Async login/register with loading states
