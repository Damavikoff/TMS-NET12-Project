import RequestHandler from './RequestHandler'
import { ENDPOINTS, TIMEOUT } from './defaults'

import StoreFilter, { FilterCategoryItem, FilterRangeItem, Sorting } from "./StoreFilter"
import { ProductItem } from './Product'

export class Grid {
  constructor (props) {
    this.ready = false
    this.loading = false
    this.url = null
    this.list = []
    this.limit = 12
    this.count = 0
    this.page = 0
    this.loadPage = 0
    Object.assign(this, props)
  }

  async getData (url) {
    if (this.loading) return
    const timeout = setTimeout(() => { this.loading = true }, TIMEOUT)
    try {
      this.loading = true
      return RequestHandler.doGetRequest(url)
    } catch (e) {
      throw new Error(e)
    } finally {
      clearTimeout(timeout)
      this.ready = true
      this.loading = false
    }
  }

  async update () {
    if (!this.url) return
    const { count, items } = await this.getData(this.requestUrl)
    this.count = count
    this.list = [...items]
  }

  get requestUrl () {
    return `${this.url}?page=${this.loadPage}&limit=${this.limit}`
  }

  get empty () {
    return !this.list.length
  }

  get pages () {
    return Math.ceil(this.count / this.limit)
  }

  async setPage (v) {
    this.loadPage = v
    await this.update()
    this.page = v
  }
}

export default class StoreGrid extends Grid {
  constructor (props) {
    super(props)
    this.filter = null
    this.sortValues = []
    Object.assign(this, props)
    if (this.filter) this.filter.grid = this
    this.sorting = this.sortValues[0] ?? null
  }

  async update () {
    if (!this.url) return
    const { count, items } = await this.getData(this.requestUrl)
    this.count = count
    this.list = items.map(v => new ProductItem(v))
  }

  get requestUrl () {
    return super.requestUrl + (this.filter?.url ?? '') + (this.sorting?.url ?? '')
  }
}

export const STORE_GRID = new StoreGrid({
  url: ENDPOINTS.products,
  filter: new StoreFilter({
    items: {
      category: new FilterCategoryItem({
        title: 'Categories',
        name: 'category',
        values: [
          { title: 'All', value: 0, count: 206 },
          { title: 'Potter Plants', value: 1, count: 12 },
          { title: 'Seeds', value: 2, count: 65 },
          { title: 'Small Plants', value: 3, count: 39 },
          { title: 'Big Plants', value: 4, count: 23 },
          { title: 'Succulents', value: 5, count: 17 },
          { title: 'Terrariums', value: 6, count: 19 },
          { title: 'Gardening', value: 7, count: 13 },
          { title: 'Accessories', value: 5, count: 18 }
        ]
      }),
      price: new FilterRangeItem({
        title: 'Price',
        name: 'price',
        min: 200,
        max: 3000,
        prefix: '$'
      }),
      size: new FilterCategoryItem({
        title: 'Size',
        name: 'size',
        values: [
          { title: 'All', value: 0, count: 283 },
          { title: 'Small', value: 1, count: 119 },
          { title: 'Medium', value: 2, count: 86 },
          { title: 'Large', value: 3, count: 78 }
        ]
      })
    }
  }),
  sortValues: [
    new Sorting({
      name: 1,
      title: 'A-Z',
      order: Sorting.ASC
    }),
    new Sorting({
      name: 1,
      title: 'Z-A',
      order: Sorting.DESC
    }),
    new Sorting({
      name: 2,
      title: 'Highest Price',
      order: Sorting.DESC
    }),
    new Sorting({
      name: 2,
      title: 'Lowest Price',
      order: Sorting.ASC
    })
  ]
})

// STORE_GRID.list = [
//   new ProductItem({
//     title: 'Barberton Daisy',
//     price: 119,
//     preview: 'product-1.png'
//   }),
//   new ProductItem({
//     title: 'Angel Wing Begonia',
//     price: 169,
//     preview: 'product-2.png'
//   }),
//   new ProductItem({
//     title: 'African Violet',
//     price: 229,
//     discount: 13,
//     preview: 'product-3.png'
//   }),
//   new ProductItem({
//     title: 'Beach Spider Lily',
//     price: 129,
//     preview: 'product-4.png'
//   }),
//   new ProductItem({
//     title: 'Blushing Bromeliad',
//     price: 139,
//     preview: 'product-5.png'
//   }),
//   new ProductItem({
//     title: 'Aluminum Plant',
//     price: 179,
//     preview: 'product-6.png'
//   }),
//   new ProductItem({
//     title: 'Bird\'s Nest Fern',
//     price: 99,
//     preview: 'product-7.png'
//   }),
//   new ProductItem({
//     title: 'Broadleaf Lady Palm',
//     price: 59,
//     preview: 'product-8.png'
//   }),
//   new ProductItem({
//     title: 'Chinese Evergreen',
//     price: 39,
//     preview: 'product-9.png'
//   })
// ]
