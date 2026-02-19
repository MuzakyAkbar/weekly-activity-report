# Panduan Instalasi - Weekly Activity Report

## Prasyarat

- Node.js (versi 16 atau lebih tinggi) - [Download di sini](https://nodejs.org/)
- PostgreSQL database dengan Openbravo
- Akses ke Openbravo REST API

## Langkah Instalasi

### 1. Download Project

Download atau extract project ini ke folder yang diinginkan.

### 2. Install Dependencies

Pilih salah satu cara berikut:

#### Cara A: Menggunakan Setup Script (Recommended)

**Windows:**
```cmd
setup.bat
```

**Linux/Mac:**
```bash
chmod +x setup.sh
./setup.sh
```

#### Cara B: Manual

```bash
npm install
```

### 3. Konfigurasi Database

1. Copy file `.env.example` menjadi `.env`:
   ```bash
   cp .env.example .env
   ```

2. Edit file `.env` dengan konfigurasi database Anda:
   ```env
   DB_HOST=36.93.9.238
   DB_PORT=5432
   DB_NAME=openbravo
   DB_USER=username_database_anda
   DB_PASSWORD=password_database_anda
   PORT=3001
   ```

### 4. Jalankan Aplikasi

#### Opsi 1: Menjalankan Semuanya Sekaligus (Recommended)

```bash
npm run dev:all
```

Aplikasi akan berjalan di:
- Frontend: http://localhost:3000
- Backend: http://localhost:3001

#### Opsi 2: Menjalankan Terpisah

**Terminal 1 - Backend:**
```bash
npm run dev:backend
```

**Terminal 2 - Frontend:**
```bash
npm run dev
```

## Verifikasi Instalasi

1. Buka browser dan akses `http://localhost:3000`
2. Halaman login Openbravo akan muncul
3. Masukkan username dan password Openbravo Anda
4. Jika berhasil, Anda akan melihat form filter report

## Troubleshooting

### Error: "Cannot find module"
Solusi: Jalankan `npm install` lagi

### Error: "Connection refused" 
Solusi: 
- Pastikan PostgreSQL database running
- Cek konfigurasi di file `.env`
- Pastikan backend server sudah running

### Error: "Unauthorized"
Solusi:
- Periksa username dan password Openbravo
- Pastikan user memiliki akses REST API

### Port sudah digunakan
Solusi:
- Ubah port di `vite.config.js` (untuk frontend)
- Ubah PORT di `.env` (untuk backend)

## Build untuk Production

```bash
npm run build
```

File hasil build akan ada di folder `dist/`

## Bantuan Lebih Lanjut

Baca file `README.md` untuk dokumentasi lengkap.
