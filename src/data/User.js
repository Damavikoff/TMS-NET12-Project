import { PATH_IMAGE_USERS, DEFAULT_IMAGE_USER } from './defaults'
import Order from './Order'

export default class User {

  static ROLE_USER = 1
  static ROLE_ADMIN = 2

  constructor (props) {
    this.id = null
    this.login = null
    this.image = null
    this.role = User.ROLE_USER
    this.info = {
      firstName: null,
      lastName: null,
      email: null,
      phone: null
    }
    this.address = {
      city: null,
      zip: null,
      street: null
    }
    Object.assign(this, props)
    this.orders = (this.orders ?? []).map(v => new Order(v))
  }

  get avatar () {
    return `${PATH_IMAGE_USERS}/${this.image ?? DEFAULT_IMAGE_USER}`
  }

  get fullName () {
    const { lastName, firstName } = this.info
    if (!firstName) return this.login
    if (!lastName) return firstName
    return `${firstName.slice(0, 1)}. ${lastName}`.trim()
  }
}
