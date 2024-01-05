import { PATH_IMAGE_PRODUCTS, PATH_IMAGE_DEFAULT } from "./defaults"
import { formatCurrency } from "./utils"
import Review from "./Review"

export class ProductItem {
  constructor (props) {
    this.id = null
    this.category = null
    this.preview = null
    this.title = null
    this.price = null
    this.discount = null
    this.sku = null
    Object.assign(this, props)
  }

  get src () {
    return this.preview ? `${PATH_IMAGE_PRODUCTS}/${this.preview}` : `${PATH_IMAGE_DEFAULT}`
  }

  get totalPrice () {
    return this.discount ? (1 - this.discount / 100) * this.price : this.price
  }

  get totalPriceLabel () {
    return formatCurrency(this.totalPrice)
  }

  get priceLabel () {
    return formatCurrency(this.price)
  }
}

export default class Product extends ProductItem {
  constructor (props) {
    super(props)
    this.category = null
    this._images = []
    this.sizes = []
    this.tags = []
    this.reviews = []
    this.related = []
    Object.assign(this, props)
    this.reviews = this.reviews.map(v => new Review(v))
    this.related = this.related.map(v => new ProductItem(v))
  }

  get images () {
    return this._images.map(v => v ? `${PATH_IMAGE_PRODUCTS}/${v}` : `${PATH_IMAGE_DEFAULT}`)
  }

  set images (v) {
    this._images = [...v]
  }

  get averageScore () {
    return Math.round(this.reviews.reduce((a, b) => a + b.score, 0) / this.reviews.length)
  }
}
