<template>
  <div class="report-view">
    <LoginForm v-if="!reportStore.authenticated" />
    
    <div v-else class="main-content">
      <header class="app-header">
        <h1>Weekly Activity Report (DAR)</h1>
        <p class="subtitle">Sistem Monitoring Progress Pekerjaan</p>
      </header>

      <div class="content-wrapper">
        <ReportFilter />
        
        <div v-if="reportStore.error" class="error-message">
          {{ reportStore.error }}
        </div>

        <!-- ── Export Bar ──────────────────────────────────────────────── -->
        <div v-if="reportStore.progressData?.length" class="export-bar">
          <span class="export-label">Export:</span>

          <button
            class="btn-export btn-pdf"
            :disabled="exporting"
            @click="handleExport('pdf')"
          >
            <span class="btn-icon">📄</span>
            PDF
            <span v-if="exporting === 'pdf'" class="btn-spinner" />
          </button>

          <button
            class="btn-export btn-excel"
            :disabled="exporting"
            @click="handleExport('excel')"
          >
            <span class="btn-icon">📊</span>
            Excel
            <span v-if="exporting === 'excel'" class="btn-spinner" />
          </button>

          <button
            class="btn-export btn-word"
            :disabled="exporting"
            @click="handleExport('word')"
          >
            <span class="btn-icon">📝</span>
            Word
            <span v-if="exporting === 'word'" class="btn-spinner" />
          </button>

          <button
            class="btn-export btn-print"
            :disabled="exporting"
            @click="handleExport('print')"
          >
            <span class="btn-icon">🖨️</span>
            Print
            <span v-if="exporting === 'print'" class="btn-spinner" />
          </button>

          <span v-if="exportError" class="export-error">{{ exportError }}</span>
        </div>

        <ReportTable />
      </div>
    </div>

    <LoadingSpinner v-if="reportStore.loading" />
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useReportStore } from '../stores/report'
import LoginForm from '../components/LoginForm.vue'
import ReportFilter from '../components/ReportFilter.vue'
import ReportTable from '../components/ReportTable.vue'
import LoadingSpinner from '../components/LoadingSpinner.vue'
import { exportToPDF, exportToExcel, exportToWord, printReport } from '../services/export'

const reportStore = useReportStore()

const exporting   = ref(null)   // 'pdf' | 'excel' | 'word' | 'print' | null
const exportError = ref('')

// Build shared args from store
const exportArgs = () => [
  reportStore.progressData,
  reportStore.totalData,
  reportStore.projectName,
  reportStore.dateFrom,
  reportStore.dateTo,
  {
    kodeProyek:   reportStore.kodeProyek   ?? '',
    namaSubProyek: reportStore.namaSubProyek ?? '',
    lokasi:       reportStore.lokasi       ?? '',
    noPO:         reportStore.noPO         ?? '',
  },
]

async function handleExport(type) {
  if (exporting.value) return
  exporting.value   = type
  exportError.value = ''
  try {
    if (type === 'pdf')   await exportToPDF(...exportArgs())
    if (type === 'excel') await exportToExcel(...exportArgs())
    if (type === 'word')  await exportToWord(...exportArgs())
    if (type === 'print') await printReport(...exportArgs())
  } catch (e) {
    console.error('Export error:', e)
    exportError.value = `Gagal export ${type.toUpperCase()}: ${e.message}`
  } finally {
    exporting.value = null
  }
}
</script>

<style scoped>
.report-view {
  min-height: 100vh;
  background: #f5f7fa;
}

.main-content {
  padding: 2rem;
  max-width: 1400px;
  margin: 0 auto;
}

.app-header {
  text-align: center;
  margin-bottom: 2rem;
}

.app-header h1 {
  color: #333;
  font-size: 2.5rem;
  margin-bottom: 0.5rem;
}

.subtitle {
  color: #666;
  font-size: 1.1rem;
}

.content-wrapper {
  margin-top: 2rem;
}

.error-message {
  background: #fee;
  color: #c00;
  padding: 1rem;
  border-radius: 4px;
  margin-bottom: 1rem;
  border-left: 4px solid #c00;
}

/* ── Export Bar ──────────────────────────────────────────────────────────── */
.export-bar {
  display: flex;
  align-items: center;
  gap: 0.6rem;
  margin-bottom: 1rem;
  padding: 0.75rem 1rem;
  background: #fff;
  border-radius: 8px;
  box-shadow: 0 1px 4px rgba(0,0,0,0.08);
}

.export-label {
  font-size: 0.85rem;
  font-weight: 600;
  color: #555;
  margin-right: 0.25rem;
}

.btn-export {
  display: inline-flex;
  align-items: center;
  gap: 0.35rem;
  padding: 0.45rem 1rem;
  border: none;
  border-radius: 6px;
  font-size: 0.85rem;
  font-weight: 600;
  cursor: pointer;
  transition: opacity 0.15s, transform 0.1s;
  color: #fff;
  white-space: nowrap;
}

.btn-export:hover:not(:disabled) { opacity: 0.88; transform: translateY(-1px); }
.btn-export:active:not(:disabled){ transform: translateY(0); }
.btn-export:disabled { opacity: 0.5; cursor: not-allowed; }

.btn-pdf   { background: #e53935; }
.btn-excel { background: #1e8e3e; }
.btn-word  { background: #1565c0; }
.btn-print { background: #546e7a; }

.btn-icon { font-size: 0.9rem; }

/* Spinner inside button */
.btn-spinner {
  display: inline-block;
  width: 12px;
  height: 12px;
  border: 2px solid rgba(255,255,255,0.4);
  border-top-color: #fff;
  border-radius: 50%;
  animation: spin 0.7s linear infinite;
  margin-left: 2px;
}
@keyframes spin { to { transform: rotate(360deg); } }

.export-error {
  font-size: 0.78rem;
  color: #c00;
  margin-left: 0.5rem;
}
</style>