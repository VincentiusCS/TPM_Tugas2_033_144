# 🚀 Quick Start Guide

**Get the app running in 5 minutes!**

## Step 1: MySQL Setup (2 min)

```bash
# Open MySQL client and run:
CREATE DATABASE tpm_app CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

## Step 2: Backend Setup (1 min)

```bash
cd backend

# Copy config template
cp .env.example .env

# Edit .env with your MySQL password (if needed)
# DB_PASSWORD=your_password

# Install & start
npm install
npm start
```

**Expected output:**
```
✓ Connected to MySQL database
✓ Users table ready
✓ Default users seeded
🚀 Backend berjalan di http://localhost:3000
```

## Step 3: Flutter Setup (2 min)

```bash
# Terminal baru, dari project root:
flutter pub get
flutter run
```

## ✅ Done! Test It

**Login Page should appear:**
1. Try: `admin` / `1234`
2. Click "Masuk" → should go to Home page
3. Click "Daftar di sini" → Register page
4. Fill form & click "Daftar" → auto-redirect to Login
5. Login dengan akun baru

---

## 📞 Quick Fixes

### "Koneksi gagal"
Make sure backend is running: `npm start`

### "Cannot connect to MySQL"
- MySQL server must be running
- Check credentials in `backend/.env`
- Database `tpm_app` must exist

### "Port 3000 already in use"
Change PORT in `backend/.env` and edit `lib/services/api_client.dart`

### "Device can't connect to backend"
If using physical device, change in `lib/services/api_client.dart`:
```dart
// Replace localhost with your IP
static const String _baseUrl = 'http://192.168.x.x:3000/api';
```

---

## 📱 Default Test Accounts

Just login with these:
- `admin` / `1234`
- `wahyu` / `033`
- `vincent` / `144`

Or register a new account in the app!

---

**For detailed docs:** see `README.md`
**For presentation help:** see `PRESENTATION_GUIDE.md`
**For setup details:** see `SETUP_MYSQL.md`
