import { createStore } from 'vuex'

import { STORE_GRID } from '../data/StoreGrid'
import { BlogPostItem } from '../data/BlogPost'

import { ProductItem } from '../data/Product'
import User from '../data/User'
import Order from '../data/Order'

export default createStore({
  state: {
    busy: false,
    ready: false,
    slides: [],
    grid: STORE_GRID,
    blogPosts: [],
    directories: [],
    error: null,
    toasts: [],
    user: null,
    cart: [],
    lastOrder: null,
    administration: {
      orders: []
    }
  },
  mutations: {
    setBusy: (state, payload = true) => {
      state.busy = payload
    },
    setReady: (state, payload = true) => {
      state.ready = payload
    },
    setDirectories: (state, payload = {}) => {
      state.directories = payload
    },
    setBlogPosts: (state, payload = []) => {
      state.blogPosts = payload.map(v => new BlogPostItem(v))
    },
    setError: (state, payload = null) => {
      state.error = payload
    },
    addToast: (state, payload) => {
      if (!payload) return
      state.toasts = [...state.toasts, payload].filter(v => v.visible)
    },
    setCart: (state, payload) => {
      state.cart = (payload ?? []).map(v => { return { ...v, product: new ProductItem(v.product) }})
    },
    setLastOrder: (state, payload = null) => {
      state.lastOrder = payload
    },
    setUser: (state, payload) => {
      state.user = payload ? new User(payload) : null
    },
    setAdminInfo: (state, payload) => {
      Object.assign(state.administration, payload)
      const { orders } = state.administration
      state.administration.orders = orders.map(v => new Order(v))
    }
  },
  actions: {
    setInitData: ({ commit, state }, payload) => {
      const { filters, blogPosts, cart, directories, user, administration } = payload
      commit('setDirectories', directories)
      commit('setBlogPosts', blogPosts)
      commit('setCart', cart)
      commit('setUser', user)
      commit('setAdminInfo', administration)
      state.grid.filter.setItems(filters)
    }
  },
  modules: {
  },
  getters: {
    ready: state => state.ready,
    busy: state => state.busy,
    grid: state => state.grid,
    directories: state => state.directories,
    blogPosts: state => state.blogPosts,
    toasts: state => state.toasts.filter(v => v.visible),
    cart: state => state.cart,
    lastOrder: state => state.lastOrder,
    user: state => state.user,
    error: state => state.error,
    orders: state => state.administration.orders
  }
})
