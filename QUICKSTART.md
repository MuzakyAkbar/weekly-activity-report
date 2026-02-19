# Quick Start Guide

## 🚀 Mulai Cepat dalam 3 Langkah

### 1️⃣ Install Dependencies
```bash
npm install
```

### 2️⃣ Setup Database
Edit file `.env`:
```env
DB_HOST=36.93.9.238
DB_PORT=5432
DB_NAME=openbravo
DB_USER=your_username
DB_PASSWORD=your_password
```

### 3️⃣ Run
```bash
npm run dev:all
```

Buka browser: **http://localhost:3000**

---

## 📋 Cara Penggunaan

1. **Login** dengan username & password Openbravo
2. **Pilih Project** dari dropdown
3. **Pilih Tanggal** (Date From & Date To)
4. Klik **Generate Report**
5. Lihat hasilnya! 🎉

---

## ⚙️ Alternative: Run Separately

**Terminal 1:**
```bash
node server.js
```

**Terminal 2:**
```bash
npm run dev
```

---

## 🔧 Default Ports

- Frontend: `http://localhost:3000`
- Backend: `http://localhost:3001`

---

## 📞 Need Help?

Lihat `INSTALL.md` untuk panduan instalasi lengkap atau `README.md` untuk dokumentasi detail.
