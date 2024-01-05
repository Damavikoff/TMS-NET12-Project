import { createRouter, createWebHistory } from 'vue-router'
import ErrorView from '../views/ErrorView.vue'
import MainView from '../views/MainView.vue'
import NotFoundView from '../views/NotFoundView.vue'
import ShopView from '../components/ShopView.vue'
import ProductPreview from '../components/ProductPreview.vue'
import ProductCart from '../components/ProductCart.vue'
import ProfileView from '../components/ProfileView.vue'
import store from '../store'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/error',
      name: 'error',
      component: ErrorView
    },
    {
      path: '/404',
      name: 'not-found',
      component: NotFoundView
    },
    {
      path: '/',
      name: 'main',
      component: MainView,
      children: [
        {
          path: '',
          name: 'shop',
          component: ShopView
        },
        {
          path: 'catalog/:id([0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})',
          name: 'product',
          component: ProductPreview
        },
        {
          path: 'cart',
          name: 'cart',
          component: ProductCart
        },
        {
          path: 'profile',
          name: 'profile',
          component: ProfileView,
          beforeEnter: () => {
            if (!store.getters['user']) {
              router.push('/')
              return false
            }
          }
        },
        {
          path: 'about',
          name: 'about',
          // route level code-splitting
          // this generates a separate chunk (About.[hash].js) for this route
          // which is lazy-loaded when the route is visited.
          component: () => import('../views/AboutView.vue')
        }
      ]
    },
    {
      path: '/:pathMatch(.*)*',
      name: 'notFound',
      component: NotFoundView
      // [0-9a-f]{8}(-[0-9a-f]{4}){3}-[0-9a-f]{12}
    }
  ]
})

export default router
