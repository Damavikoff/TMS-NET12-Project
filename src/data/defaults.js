export const HOST = 'http://localhost:5026'
export const HOST_RELATIVE = ''

export const PATH_IMAGE = '/images'
export const PATH_IMAGE_DEFAULT = `${PATH_IMAGE}/default_preview.png`
export const PATH_IMAGE_BLOG_POSTS = `${PATH_IMAGE}/blog_posts`
export const PATH_IMAGE_PRODUCTS = `${PATH_IMAGE}/products`
export const PATH_IMAGE_USERS = `${PATH_IMAGE}/users`
export const DEFAULT_IMAGE_USER = `default.png`
export const TIMEOUT = 400

export const ENDPOINTS = {
  init: `${HOST}/init`,
  products: `${HOST}/products`,
  feedback: `${HOST}/products/{id}/feedback`,
  product: `${HOST_RELATIVE}/catalog`,
  cart: `${HOST}/cart`,
  orders: `${HOST}/orders`,
  auth: `${HOST}/auth`,
  user: `${HOST}/user`
}
