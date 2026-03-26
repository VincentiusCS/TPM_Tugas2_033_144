# TPM Tugas 2 (033-144) - Flutter Authentication App 🚀

Aplikasi Flutter dengan sistem autentikasi lengkap yang terhubung ke REST API MySQL backend.

## 🎯 Fitur Utama

### 1. **Sistem Autentikasi** ✅
- Login dengan username/password (async)
- Registrasi user baru dengan email (optional)
- Validasi input (username 3+ karakter, password 4+ karakter, email format)
- Error handling & success messages
- Loading indicators
- Terhubung ke MySQL database via REST API

### 2. **Multi-Purpose Tools**
- **Cek Hari & Weton** - Javanese calendar calculation
- **Hitung Usia** - Age calculation in multiple units
- **Konversi Tahun** - Convert between calendar systems
- **Kalkulator** - Arithmetic operations
- **Operasi Bilangan** - Binary/Octal/Hexadecimal conversion
- Dan lainnya...

## 📱 Tech Stack

### Frontend
- **Framework**: Flutter 3.x
- **Language**: Dart 3.x
- **HTTP**: http package ^1.1.0
- **Architecture**: Service-based + Singleton pattern

### Backend
- **Runtime**: Node.js 18+
- **Framework**: Express.js 5.x
- **Database**: MySQL 5.7+
- **Async**: mysql2/promise
- **Validation**: Built-in email regex

## 🚀 Quick Start

### Prerequisites
- Flutter 3.x+ ([Download](https://flutter.dev/))
- Node.js 18+ ([Download](https://nodejs.org/))
- MySQL 5.7+ ([Download](https://www.mysql.com/))

### 1️⃣ Setup MySQL Database

```bash
# Buka MySQL Client/Workbench dan jalankan:
CREATE DATABASE tpm_app CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

### 2️⃣ Setup & Run Backend

```bash
cd backend

# Copy konfigurasi
cp .env.example .env

# Edit .env dengan MySQL credentials Anda:
# [Lihat .env.example untuk lebih detail]

# Install dependencies & start
npm install
npm start
```

**Expected Output:**
```
🚀 Backend berjalan di http://localhost:3000
📊 Database: MySQL
✓ Connected to MySQL database
✓ Users table ready
✓ Default users seeded
```

### 3️⃣ Run Flutter App

```bash
flutter pub get
flutter run
```

## 📚 API Endpoints

### POST /api/login
**Authenticate user**
```bash
curl -X POST http://localhost:3000/api/login \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"1234"}'
```

**Response (200):**
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

### POST /api/register
**Create new user account**
```bash
curl -X POST http://localhost:3000/api/register \
  -H "Content-Type: application/json" \
  -d '{"username":"newuser","password":"pass123","email":"user@email.com"}'
```

**Response (201):**
```json
{
  "success": true,
  "message": "Registrasi berhasil. Silakan login."
}
```

### GET /api/health
**Server health check**
```json
{ "status": "OK" }
```

### GET /api/user/:id
**Get user profile info**
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

## 🔐 Default Test Users

Ready-to-use accounts untuk testing:

| Username | Password | Email | Role |
|----------|----------|-------|------|
| admin | 1234 | admin@app.com | Admin |
| wahyu | 033 | wahyu@app.com | User |
| vincent | 144 | vincent@app.com | User |

## 📁 Project Structure

```
.
├── backend/                          # Node.js REST API Server
│   ├── server.js                    # Express routes & middleware
│   ├── database.js                  # MySQL connection pool
│   ├── package.json                 # Dependencies
│   ├── .env.example                 # Environment template
│   └── README.md                    # Backend documentation
│
├── lib/                              # Flutter Source Code
│   ├── main.dart                    # App entry point + AppColors
│   ├── pages/
│   │   ├── login_page.dart          # 🔐 Login UI (NEW)
│   │   ├── register_page.dart       # 📝 Registration UI (NEW)
│   │   ├── home_page.dart           # Menu of features
│   │   ├── weton_hari_page.dart
│   │   ├── usia_page.dart
│   │   ├── year_converter_page.dart
│   │   ├── arithmetic_page.dart
│   │   └── ... (other features)
│   ├── services/
│   │   ├── auth_service.dart        # Authentication logic (UPDATED)
│   │   ├── api_client.dart          # HTTP REST client (NEW)
│   │   ├── calculator_service.dart
│   │   └── ... (other services)
│   ├── models/
│   │   ├── user.dart                # User model
│   │   └── ... (other models)
│   └── widgets/
│       └── app_widgets.dart         # Reusable UI components
│
├── pubspec.yaml                      # Flutter dependencies
├── README.md                         # Project documentation
├── SETUP_MYSQL.md                   # Database setup guide
└── .gitignore
```

## ⚙️ Configuration

### Backend Configuration
**File: `backend/.env`**
```env
# MySQL Connection
DB_HOST=localhost           # MySQL server host
DB_USER=root               # MySQL username
DB_PASSWORD=               # MySQL password (leave empty if none)
DB_NAME=tpm_app            # Database name
PORT=3000                  # Server port
```

### Frontend Configuration
**File: `lib/services/api_client.dart`**

Default:
```dart
static const String _baseUrl = 'http://localhost:3000/api';
```

Untuk emulator Android (ganti jika perlu):
```dart
static const String _baseUrl = 'http://10.0.2.2:3000/api';
```

Untuk device fisik:
```dart
static const String _baseUrl = 'http://192.168.x.x:3000/api';
```

## 🧪 Testing Guide

### ✅ Test Login
```
1. Open app → Login page dipilih secara otomatis
2. Input: admin / 1234
3. Tap "Masuk"
4. Should navigate ke Home page
```

### ✅ Test Register
```
1. Tap "Daftar di sini" di Login page
2. Isi form:
   - Username: testuser (min 3 karakter)
   - Email: test@email.com (optional)
   - Password: test123 (min 4 karakter)
   - Confirm: test123 (must match)
3. Tap "Daftar"
4. Success → Auto-redirect ke Login page
5. Login dengan akun yang baru dibuat
```

### ✅ Test Multiple Users
```
1. Register beberapa user dengan username berbeda
2. Logout & login dengan user lain
3. Verify data ter-persist di MySQL database
```

## 🐛 Troubleshooting

### "Koneksi gagal" Error
```
✓ Pastikan backend berjalan: npm start
✓ Periksa port 3000 tidak terpakai
✓ Untuk device fisik: gunakan IP address, bukan localhost
✓ Firewall tidak memblokir port 3000
```

### "Cannot connect to MySQL"
```
✓ MySQL server harus running
✓ Verify credentials di .env file
✓ Database 'tpm_app' sudah dibuat
✓ Check credentials: DB_USER, DB_PASSWORD
```

### "Username sudah terdaftar"
```
✓ Username harus unik di database
✓ Coba gunakan username berbeda
✓ Atau login dengan akun yang sudah ada
```

### "Email tidak valid"
```
✓ Format: user@domain.com
✓ Email field optional (boleh dikosongkan)
✓ Jika diisi, harus format email yang valid
```

## 🗂️ Database Schema

### Table: users
```sql
CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(100) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  email VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

**Indexes:**
- PRIMARY KEY: `id`
- UNIQUE: `username`
- TIMESTAMPS: `created_at`, `updated_at`

## 🎨 UI/UX Features

✅ Material Design 3
✅ Responsive layout
✅ Consistent color scheme
✅ Loading indicators (CircularProgressIndicator)
✅ Clear error messages (red cards)
✅ Success messages (green cards)
✅ Password visibility toggle
✅ Input validation with helper text
✅ Graceful error handling
✅ Navigation between pages

## 💻 Code Quality

- ✅ **Async/Await**: Proper async handling dengan Future
- ✅ **Error Handling**: Try-catch blocks di semua API calls
- ✅ **Null Safety**: Enabled di Flutter project
- ✅ **Naming Conventions**: Consistent snake_case & camelCase
- ✅ **Documentation**: Comments di semua methods
- ✅ **Architecture**: Service-based dengan Singleton pattern
- ✅ **Encapsulation**: Private fields dengan getters
- ✅ **Resource Management**: Proper dispose() untuk controllers

## 📈 Project Statistics

| Metric | Count |
|--------|-------|
| Backend Files | 3 (server.js, database.js, package.json) |
| Flutter Pages | 10+ (Login, Register, + Features) |
| Services | 8+ (Auth, API, Calculator, Calendar, etc) |
| Models | 8+ (User, MenuItems, Results, etc) |
| API Endpoints | 4 (Login, Register, Health, GetUser) |
| Default Users | 3 (admin, wahyu, vincent) |

## 🚀 Production Checklist

- [ ] Implement JWT authentication
- [ ] Add password hashing (bcrypt)
- [ ] Use HTTPS instead of HTTP
- [ ] Add rate limiting untuk login/register
- [ ] Implement refresh tokens
- [ ] Add database backups
- [ ] Monitor server logs
- [ ] Setup error tracking (Sentry)
- [ ] Environment-based configuration
- [ ] Add request/response logging

## 📝 Notes

- Database otomatis di-create saat backend start pertama kali
- Default users otomatis di-seed ke database
- Backend menggunakan connection pooling untuk performance
- Flutter app menggunakan Singleton pattern untuk service sharing

## 👥 Members

- **Group ID**: 033-144
- **Class**: Semester 8 - TPM (Teknologi dan Pemrograman Mobile)

## 📅 Timeline

- **26-03-2026**: Features Tambahan (Calendar, Age, Year Converter)
- **27-03-2026**: REST API + MySQL Authentication + Registration Feature
- **27-03-2026**: Code Cleanup & Documentation

---

**Version**: 1.0.0
**Last Updated**: 27 Maret 2026
**Status**: ✅ Ready for Presentation
