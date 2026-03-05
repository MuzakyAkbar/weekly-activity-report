import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import path from 'path'

export default defineConfig({
  base: '/activity-report/',
  plugins: [vue()],
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src')
    }
  },
  server: {
    port: 3000,
    proxy: {
      // 1. Query backend Node — HARUS di atas, lebih spesifik
      '/api/query': {
        target: 'http://localhost:3001',
        changeOrigin: true,
      },
      // 2. Openbravo — lebih umum, taruh di bawah
      '/api/openbravo': {
        target: 'http://36.93.9.238:8080',
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/api\/openbravo/, '/openbravo')
      }
    }
  }
})