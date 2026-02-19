<template>
  <div v-if="reportStore.progressData.length > 0" class="report-container">
    <div class="report-header">
      <h2>Weekly Activity Report (DAR)</h2>
      <div class="export-buttons">
        <button @click="handleExportExcel" class="btn-export excel">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M14.5 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V7.5L14.5 2z"/>
            <polyline points="14 2 14 8 20 8"/>
          </svg>
          Export Excel
        </button>
        <button @click="handleExportPDF" class="btn-export pdf">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M14.5 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V7.5L14.5 2z"/>
            <polyline points="14 2 14 8 20 8"/>
            <path d="M10 12h4"/>
            <path d="M10 16h4"/>
          </svg>
          Export PDF
        </button>
        <button @click="handlePrint" class="btn-export print">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <polyline points="6 9 6 2 18 2 18 9"/>
            <path d="M6 18H4a2 2 0 0 1-2-2v-5a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v5a2 2 0 0 1-2 2h-2"/>
            <rect x="6" y="14" width="12" height="8"/>
          </svg>
          Print
        </button>
      </div>
    </div>

    <div class="table-wrapper">
      <table class="report-table">
        <thead>
          <tr>
            <th rowspan="2">No</th>
            <th rowspan="2">Pekerjaan</th>
            <th rowspan="2">Satuan</th>
            <th rowspan="2">BOQ</th>
            <th rowspan="2">Bobot</th>
            <th colspan="3">Progress (%)</th>
          </tr>
          <tr>
            <th>This Week</th>
            <th>Cum. Last Week</th>
            <th>Cum. This Week</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="row in reportStore.progressData" :key="row.no">
            <td class="text-center">{{ row.no }}</td>
            <td>{{ row.col2 }}</td>
            <td class="text-center">{{ row.satuan }}</td>
            <td class="text-right">{{ row.boq }}</td>
            <td class="text-right">{{ row.bobot }}</td>
            <td class="text-right progress-cell">{{ row.thisweek }}</td>
            <td class="text-right progress-cell">{{ row.cumlastweek }}</td>
            <td class="text-right progress-cell">{{ row.cumthisweek }}</td>
          </tr>
        </tbody>
        <tfoot v-if="reportStore.totalData">
          <tr class="total-row">
            <td colspan="4" class="text-right"><strong>TOTAL</strong></td>
            <td class="text-right"><strong>{{ reportStore.totalData.totalbobot }}</strong></td>
            <td class="text-right"><strong>{{ reportStore.totalData.totalthisweek }}</strong></td>
            <td class="text-right"><strong>{{ reportStore.totalData.totalcumlastweek }}</strong></td>
            <td class="text-right"><strong>{{ reportStore.totalData.totalcumthisweek }}</strong></td>
          </tr>
        </tfoot>
      </table>
    </div>
  </div>
  
  <div v-else-if="!reportStore.loading" class="no-data">
    <p>Silakan pilih project dan tanggal untuk menampilkan report</p>
  </div>
</template>

<script setup>
import { computed } from 'vue'
import { useReportStore } from '../stores/report'
import { exportToExcel, exportToPDF, printReport } from '../services/export'

const reportStore = useReportStore()

const selectedProjectName = computed(() => {
  if (!reportStore.selectedProject) return ''
  const project = reportStore.projects.find(p => p.id === reportStore.selectedProject)
  return project ? project.name : ''
})

const handleExportExcel = () => {
  if (!reportStore.progressData.length || !reportStore.totalData) {
    alert('Tidak ada data untuk di-export')
    return
  }
  
  exportToExcel(
    reportStore.progressData,
    reportStore.totalData,
    selectedProjectName.value,
    reportStore.dateFrom,
    reportStore.dateTo
  )
}

const handleExportPDF = () => {
  if (!reportStore.progressData.length || !reportStore.totalData) {
    alert('Tidak ada data untuk di-export')
    return
  }
  
  exportToPDF(
    reportStore.progressData,
    reportStore.totalData,
    selectedProjectName.value,
    reportStore.dateFrom,
    reportStore.dateTo
  )
}

const handlePrint = () => {
  if (!reportStore.progressData.length || !reportStore.totalData) {
    alert('Tidak ada data untuk di-print')
    return
  }
  
  printReport(
    reportStore.progressData,
    reportStore.totalData,
    selectedProjectName.value,
    reportStore.dateFrom,
    reportStore.dateTo
  )
}
</script>

<style scoped>
.report-container {
  background: white;
  padding: 1.5rem;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.report-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1.5rem;
  flex-wrap: wrap;
  gap: 1rem;
}

.report-header h2 {
  color: #333;
  margin: 0;
}

.export-buttons {
  display: flex;
  gap: 0.5rem;
  flex-wrap: wrap;
}

.btn-export {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.5rem 1rem;
  color: white;
  border: none;
  border-radius: 4px;
  font-weight: 600;
  font-size: 0.9rem;
  cursor: pointer;
  transition: all 0.3s;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.btn-export:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
}

.btn-export:active {
  transform: translateY(0);
}

.btn-export.excel {
  background: #10b981;
}

.btn-export.excel:hover {
  background: #059669;
}

.btn-export.pdf {
  background: #ef4444;
}

.btn-export.pdf:hover {
  background: #dc2626;
}

.btn-export.print {
  background: #667eea;
}

.btn-export.print:hover {
  background: #5568d3;
}

.btn-export svg {
  width: 16px;
  height: 16px;
}

.table-wrapper {
  overflow-x: auto;
}

.report-table {
  width: 100%;
  border-collapse: collapse;
  font-size: 0.9rem;
}

.report-table th,
.report-table td {
  padding: 0.75rem;
  border: 1px solid #ddd;
}

.report-table thead th {
  background: #667eea;
  color: white;
  font-weight: 600;
  text-align: center;
  position: sticky;
  top: 0;
  z-index: 10;
}

.report-table tbody tr:nth-child(even) {
  background: #f9fafb;
}

.report-table tbody tr:hover {
  background: #f3f4f6;
}

.text-center {
  text-align: center;
}

.text-right {
  text-align: right;
}

.progress-cell {
  color: #059669;
  font-weight: 500;
}

.total-row {
  background: #f3f4f6 !important;
  font-weight: 600;
}

.total-row td {
  border-top: 2px solid #667eea;
}

.no-data {
  background: white;
  padding: 3rem;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  text-align: center;
}

.no-data p {
  color: #666;
  font-size: 1.1rem;
}

@media (max-width: 768px) {
  .report-header {
    flex-direction: column;
    align-items: stretch;
  }
  
  .export-buttons {
    justify-content: stretch;
  }
  
  .btn-export {
    flex: 1;
    justify-content: center;
  }
}
</style>