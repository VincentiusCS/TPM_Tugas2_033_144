# 📊 Panduan Presentasi - TPM Tugas 2 (033-144)

## Overview Proyek

Aplikasi Flutter dengan REST API MySQL backend untuk sistem autentikasi user dengan fitur tambahan multi-purpose tools.

## 🎯 Key Points untuk Presentasi

### 1. Sistem Autentikasi (Backend)
**Fitur:**
- ✅ Login validation dengan database query
- ✅ Register dengan validasi email & username unique
- ✅ Connection pooling MySQL
- ✅ Proper error handling

**Demo:**
```
1. Jalankan: npm start (di backend folder)
2. Show output: ✓ Connected to MySQL database
3. Jelaskan: table users dengan struktur
4. Tunjukkan: default users yang ter-seed
```

**Kode Penting di `server.js`:**
```javascript
// Login endpoint dengan query ke database
app.post('/api/login', async (req, res) => {
  // Validasi username & password di database
  // Return success/error response
})

// Register dengan duplicate check & insert
app.post('/api/register', async (req, res) => {
  // Check username sudah ada
  // Validate email format
  // Insert ke database
})
```

### 2. Flutter Login Page
**Fitur:**
- ✅ Async/await handling
- ✅ Loading indicator saat request
- ✅ Error message display
- ✅ Link ke Register page

**Demo:**
```
1. Buka Flutter app
2. Login page otomatis muncul
3. Coba login dengan admin/1234
4. Show loading indicator
5. Navigate ke Home setelah sukses
```

**Kode Penting di `login_page.dart`:**
```dart
Future<void> _handleLogin() async {
  // Validasi input
  // Call authService.login()
  // Handle response
  // Navigate atau show error
}
```

### 3. Flutter Register Page
**Fitur:**
- ✅ Form validation (username, password, email)
- ✅ Password confirm check
- ✅ Optional email field
- ✅ Success message & auto-redirect

**Demo:**
```
1. Klik "Daftar di sini" dari Login page
2. Fill form dengan data baru
3. Show validation messages
4. Klik "Daftar"
5. Show success message
6. Auto-redirect ke Login page
7. Login dengan akun yang baru dibuat
```

**Validation Rules:**
```
- Username: minimum 3 karakter
- Password: minimum 4 karakter
- Email: harus format valid (jika diisi)
- Confirm password: harus match dengan password
```

### 4. Architecture Pattern
**Singleton Pattern untuk Services:**
```
AuthService → API Client → HTTP
     ↓
  User Session Management
```

**Data Flow:**
```
Flutter UI → AuthService → ApiClient → HTTP Request
                                          ↓
                                   Express Backend
                                          ↓
                                   MySQL Database
```

### 5. REST API Endpoints

**Endpoint Chart:**

| Method | Endpoint | Purpose | Status |
|--------|----------|---------|--------|
| POST | /api/login | User authentication | ✅ Working |
| POST | /api/register | New user creation | ✅ Working |
| GET | /api/health | Server health check | ✅ Working |
| GET | /api/user/:id | Get user profile | ✅ Working |

### 6. Database Schema

**Users Table Visualization:**
```
users
├── id (INT, Auto Increment) 🔑
├── username (VARCHAR, UNIQUE) 👤
├── password (VARCHAR) 🔒
├── email (VARCHAR, optional) 📧
├── created_at (TIMESTAMP)
└── updated_at (TIMESTAMP)
```

### 7. Code Quality Highlights

**✅ Best Practices Implemented:**
- Async/await untuk network calls
- Error handling dengan try-catch
- Null safety enabled
- Proper resource disposal (dispose())
- Input validation before submission
- Loading states during async operations
- User-friendly error messages

## 📱 Demo Scenario

### Scenario 1: Login Existing User
```
Time: ~2 minutes

1. Tampilkan Login page kosong
2. Enter: username = "admin"
3. Enter: password = "1234"
4. Tap "Masuk" button
5. Show loading indicator
6. Success → Navigate ke Home page
7. Tampilkan: "Logged in as admin"
```

### Scenario 2: Register New User
```
Time: ~3 minutes

1. Dari Login page, klik "Daftar di sini"
2. Tampilkan: Register page heading
3. Fill form:
   - Username: "testuser123"
   - Email: "test@example.com"
   - Password: "password123"
   - Confirm: "password123"
4. Show validation passing
5. Tap "Daftar"
6. Show: Success message (2 second delay)
7. Auto-redirect ke Login page
8. Login dengan akun baru (testuser123/password123)
9. Verify: Akun tersimpan di database
```

### Scenario 3: Validation Errors
```
Time: ~1 minute

1. Try register dengan username < 3 karakter
   → Show error: "Username minimal 3 karakter"
2. Try register dengan password < 4 karakter
   → Show error: "Password minimal 4 karakter"
3. Try register dengan password tidak match
   → Show error: "Password tidak cocok!"
4. Try register dengan email invalid
   → Show error: "Format email tidak valid!"
5. Try register dengan username existing
   → Show error: "Username sudah terdaftar"
```

## 🖥️ Backend Demo

### Setup Verification
```bash
# 1. Show MySQL database created
mysql> SHOW DATABASES;
# Output: tpm_app database visible

# 2. Show users table structure
mysql> DESCRIBE tpm_app.users;
# Output: Table dengan 6 columns

# 3. Show default users
mysql> SELECT * FROM tpm_app.users;
# Output: 3 default users
```

### API Testing dengan CURL
```bash
# Test Login
curl -X POST http://localhost:3000/api/login \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"1234"}'

# Test Register
curl -X POST http://localhost:3000/api/register \
  -H "Content-Type: application/json" \
  -d '{"username":"newuser","password":"pass123","email":"new@email.com"}'

# Test Health
curl http://localhost:3000/api/health
```

## 🎨 UI/UX Points to Highlight

1. **Material Design 3** - Modern, clean interface
2. **Loading States** - Shows feedback during operations
3. **Error Messages** - Clear, user-friendly messages
4. **Form Validation** - Real-time helper text
5. **Password Visibility** - Toggle untuk ease of use
6. **Navigation** - Smooth transitions between pages
7. **Color Consistency** - Professional blue theme

## 📊 Statistics to Mention

- **Backend**: 3 files (server.js, database.js, package.json)
- **Database**: 1 table (users) dengan 6 columns
- **API Endpoints**: 4 endpoints (login, register, health, getUser)
- **Frontend Pages**: 10+ pages (login, register, + features)
- **Default Users**: 3 test accounts ready to use
- **Code Lines**: ~800 lines (backend) + ~1000 lines (flutter)

## 🎓 Learning Outcomes Demonstrated

1. **REST API Design** - Proper HTTP methods & status codes
2. **Database Design** - Normalized schema dengan unique constraints
3. **Async Programming** - Future & async/await in Dart
4. **Error Handling** - Try-catch & user-friendly messages
5. **OOP Concepts** - Singleton pattern, encapsulation
6. **Form Validation** - Client & server-side validation
7. **Security Basics** - Password handling, email validation

## 💡 Tips for Presenting

1. **Start dengan Overview** - Explain sistem autentikasi terlebih dahulu
2. **Demo Login dulu** - Lebih sederhana, audience sekaligus familiar
3. **Demo Register setelah** - Lebih kompleks, validation banyak
4. **Show Database** - Bukti data tersimpan & persistent
5. **Highlight Code** - Tunjukkan error handling & async patterns
6. **Mention Best Practices** - Explain why certain patterns digunakan
7. **End with Features** - Tampilkan fitur tambahan (calculator, weton, dll)

## ⏱️ Timing Guide

| Bagian | Time |
|--------|------|
| Introduction & Overview | 2 min |
| Architecture Explanation | 2 min |
| Backend Demo | 2 min |
| Login Demo | 2 min |
| Register Demo | 3 min |
| Database Query | 1 min |
| Code Walkthrough | 3 min |
| Other Features | 2 min |
| Q&A | 3 min |
| **Total** | **~20 minutes** |

## 🔑 Key Files to Highlight

**Backend:**
- ✅ `backend/server.js` - REST endpoints
- ✅ `backend/database.js` - MySQL connection
- ✅ `backend/.env.example` - Configuration

**Frontend:**
- ✅ `lib/pages/login_page.dart` - Login UI & logic
- ✅ `lib/pages/register_page.dart` - Register UI & logic
- ✅ `lib/services/auth_service.dart` - Business logic
- ✅ `lib/services/api_client.dart` - HTTP client

## ❓ Expected Questions & Answers

**Q: Kenapa pakai REST API?**
A: REST adalah standard untuk komunikasi client-server, mudah di-test, scalable, dan industry practice.

**Q: Bagaimana handle security?**
A: Implemented input validation, email regex, unique username constraint, proper error handling. Di production, tambah JWT & password hashing.

**Q: Database apakah yang digunakan?**
A: MySQL dengan connection pooling untuk efficiency. Schema normalized dengan proper indexes.

**Q: Bagaimana async handling di Flutter?**
A: Gunakan Future & async/await, dengan proper error handling dan null checks sebelum setState().

**Q: Apa itu Singleton Pattern?**
A: Ensure hanya satu instance service di seluruh app. Efisien untuk shared resources seperti database connection & current user session.

## 📝 Presentation Checklist

- [ ] Backend server running (`npm start`)
- [ ] MySQL database setup & populated
- [ ] Flutter app installed di emulator/device
- [ ] Test credentials ready (admin/1234, dll)
- [ ] Demo scenarios prepared & tested
- [ ] Screen capture/recording ready (as backup)
- [ ] Code review done
- [ ] Documentation up to date
- [ ] Laptop/projector working
- [ ] Backup power supply available

## 🎯 Final Notes

**Fokus pada:**
1. **Demonstrasi functionality** - Tunjukkan app works properly
2. **Explain architecture** - Help audience understand design decisions
3. **Code quality** - Show professional development practices
4. **Problem solving** - Explain challenges & solutions
5. **Passion & clarity** - Present dengan confidence & enthusiasm

**Jangan:**
- ❌ Terburu-buru dalam penjelasan
- ❌ Show error messages saat demo (test dulu)
- ❌ Dive too deep into code syntax
- ❌ Forget to mention team members

**Good luck! 🚀**
