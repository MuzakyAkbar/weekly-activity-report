# Weekly Activity Report (DAR) - Openbravo Integration

Aplikasi web untuk menampilkan Weekly Activity Report (DAR) yang terhubung langsung dengan Openbravo ERP system.

## Fitur

- Login dengan Basic Authentication Openbravo
- Filter berdasarkan Project dan Date Range
- Menampilkan progress pekerjaan (This Week, Cumulative Last Week, Cumulative This Week)
- Perhitungan otomatis bobot dan progress
- Interface yang responsif dan modern

## Tech Stack

### Frontend
- Vue.js 3
- Vite
- Pinia (State Management)
- Axios (HTTP Client)
- Vue Router

### Backend
- Node.js
- Express.js
- PostgreSQL (pg)
- CORS

## Struktur Project

```
weekly-activity-report/
├── src/
│   ├── assets/
│   │   └── css/
│   │       └── main.css
│   ├── components/
│   │   ├── LoginForm.vue
│   │   ├── ReportFilter.vue
│   │   ├── ReportTable.vue
│   │   └── LoadingSpinner.vue
│   ├── services/
│   │   └── api.js
│   ├── stores/
│   │   └── report.js
│   ├── views/
│   │   └── ReportView.vue
│   ├── router/
│   │   └── index.js
│   ├── App.vue
│   └── main.js
├── server.js (Backend)
├── package.json (Frontend)
├── package-backend.json (Backend)
├── vite.config.js
├── index.html
├── .env.example
└── README.md
```

## Instalasi

### 1. Clone atau Download Project

```bash
cd weekly-activity-report
```

### 2. Install Dependencies Frontend

```bash
npm install
```

### 3. Install Dependencies Backend

```bash
npm install --prefix . express pg cors dotenv
# atau jika ingin menggunakan package-backend.json
cp package-backend.json package-server.json
```

### 4. Konfigurasi Database

Buat file `.env` di root project:

```bash
cp .env.example .env
```

Edit file `.env` dan sesuaikan dengan konfigurasi database PostgreSQL Openbravo Anda:

```env
DB_HOST=36.93.9.238
DB_PORT=5432
DB_NAME=openbravo
DB_USER=your_database_username
DB_PASSWORD=your_database_password
PORT=3001
```

## Menjalankan Aplikasi

### Opsi 1: Menjalankan secara terpisah

**Terminal 1 - Backend:**
```bash
node server.js
```

**Terminal 2 - Frontend:**
```bash
npm run dev
```

### Opsi 2: Menggunakan concurrently (Recommended)

Tambahkan script di `package.json`:

```json
{
  "scripts": {
    "dev": "vite",
    "dev:backend": "node server.js",
    "dev:all": "concurrently \"npm run dev\" \"npm run dev:backend\"",
    "build": "vite build",
    "preview": "vite preview"
  }
}
```

Install concurrently:
```bash
npm install -D concurrently
```

Jalankan semuanya:
```bash
npm run dev:all
```

## Cara Penggunaan

1. **Login**
   - Masukkan username dan password Openbravo Anda
   - Klik tombol "Login"

2. **Pilih Project**
   - Setelah login, pilih project dari dropdown
   - Sistem akan memuat daftar project yang tersedia

3. **Pilih Date Range**
   - Pilih tanggal mulai (Date From)
   - Pilih tanggal akhir (Date To)

4. **Generate Report**
   - Klik tombol "Generate Report"
   - Tunggu hingga data selesai dimuat
   - Report akan ditampilkan dalam bentuk tabel

## API Endpoints

### Backend API

- `POST /api/query/progress` - Mengambil data progress pekerjaan
- `POST /api/query/total` - Mengambil total perhitungan
- `GET /health` - Health check endpoint

### Openbravo REST API

Frontend berkomunikasi dengan:
- `GET /openbravo/org.openbravo.service.json.jsonrest/Project`
- `GET /openbravo/org.openbravo.service.json.jsonrest/Order`
- `GET /openbravo/org.openbravo.service.json.jsonrest/robprj_projectactivity`

## Konfigurasi Proxy

Vite development server sudah dikonfigurasi dengan proxy untuk menghindari CORS issues:

```javascript
server: {
  port: 3000,
  proxy: {
    '/api': {
      target: 'http://36.93.9.238:8080',
      changeOrigin: true,
      rewrite: (path) => path.replace(/^\/api/, '')
    }
  }
}
```

## Database Requirements

Pastikan database PostgreSQL Openbravo memiliki tabel-tabel berikut:
- `robprj_orab`
- `c_order`
- `c_project`
- `c_uom`
- `robprj_parealisasi`
- `robprj_projectactivity`

### Test Database Connection

Untuk memverifikasi koneksi database:

```bash
node test-connection.js
```

Script ini akan:
- Test koneksi ke database
- Verifikasi semua tabel yang diperlukan ada
- Menampilkan informasi debugging

## Troubleshooting

### Error: Connection refused
- Pastikan backend server sudah running di port 3001
- Cek konfigurasi database di file `.env`

### Error: Unauthorized
- Verifikasi username dan password Openbravo
- Pastikan user memiliki akses ke REST API

### Error: Cannot find module
- Jalankan `npm install` untuk install dependencies
- Cek apakah semua dependencies sudah terinstall

### Data tidak muncul
- Cek console browser untuk error
- Verifikasi koneksi database
- Pastikan query SQL sesuai dengan struktur database

## Development

### Frontend Development
```bash
npm run dev
```
Buka browser di `http://localhost:3000`

### Backend Development
```bash
npm run dev:backend
```
Server akan running di `http://localhost:3001`

## Build untuk Production

```bash
npm run build
```

Output akan ada di folder `dist/`

## Security Notes

- **JANGAN** commit file `.env` ke repository
- Gunakan environment variables untuk credentials
- Implementasikan proper authentication di production
- Gunakan HTTPS untuk production deployment

## Future Enhancements

- [ ] Export to Excel functionality
- [ ] Print report feature
- [ ] Chart visualization
- [ ] Multi-language support
- [ ] User management
- [ ] Report history
- [ ] Email notification

## Support

Untuk pertanyaan dan issues, silakan hubungi developer.

## License

Private - Internal Use Only
