import { createStore } from 'vuex'

import { STORE_GRID } from '../data/StoreGrid'
import { BlogPostItem } from '../data/BlogPost'

import { ProductItem } from '../data/Product'
import User from '../data/User'

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
    lastOrder: null
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
    }
  },
  actions: {
    setInitData: ({ commit, state }, payload) => {
      const { filters, blogPosts, cart, directories, user } = payload
      commit('setDirectories', directories)
      commit('setBlogPosts', blogPosts)
      commit('setCart', cart)
      commit('setUser', user)
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
    user: state => state.user
  }
})
