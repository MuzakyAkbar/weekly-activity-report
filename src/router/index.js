import { createRouter, createWebHistory } from 'vue-router'
import ReportView from '../views/ReportView.vue'

const routes = [
  {
    path: '/',
    name: 'report',
    component: ReportView
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router
