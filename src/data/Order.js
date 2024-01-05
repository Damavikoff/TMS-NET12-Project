import { ProductItem } from "./Product"

export default class Order {
  static STATE_CREATED = 1
  static STATE_PREPARING = 2
  static STATE_DELIVERED = 3
  static STATE_CANCELLED = 4

  static PAYMENT_CARD = 1
  static PAYMENT_BANK = 2
  static PAYMENT_CASH = 3

  static PAYMENT_METHODS = {
    [Order.PAYMENT_CARD]: 'Bank Card',
    [Order.PAYMENT_BANK]: 'Direct Bank Transfer',
    [Order.PAYMENT_CASH]: 'Cash On Delivery',
  }

  static STATES = {
    [Order.STATE_CREATED]: 'Created',
    [Order.STATE_PREPARING]: 'Preparing',
    [Order.STATE_DELIVERED]: 'Delivered',
    [Order.STATE_CANCELLED]: 'Cancelled',
  }

  static #STATE_COLORS = {
    [Order.STATE_CREATED]: '#3c93e4',
    [Order.STATE_PREPARING]: '#9762f3',
    [Order.STATE_DELIVERED]: '#24c56a',
    [Order.STATE_CANCELLED]: '#df4545'
  }

  constructor (props) {
    this.id = null
    this.state = Order.STATE_CREATED,
    this.number = null
    this.total = null
    this.shipping = null
    this.paymentMethod = Order.PAYMENT_BANK
    this.description = null
    this.created = null
    this.updated = null
    this.items = []
    this.userInfo = {
      firstName: null,
      lastName: null,
      email: null,
      phone: null
    }
    this.address = {
      city: null,
      zip: null,
      address: null
    }
    Object.assign(this, props)
    this.items = this.items.map(v => { return { ...v, product: new ProductItem(v.product) }})
  }

  get paymentMethodName () {
    return Order.PAYMENT_METHODS[this.paymentMethod]
  }

  get stateName () {
    return Order.STATES[this.state]
  }

  get stateColor () {
    return Order.#STATE_COLORS[this.state]
  }
}

export class OrderInfo {
  constructor(props) {
    this.firstName = null
    this.lastName = null
    this.city = null
    this.address = null
    this.email = null
    this.phone = null
    this.description = null
    this.paymentMethod = Order.PAYMENT_CARD
    Object.assign(this, props)
  }
}
