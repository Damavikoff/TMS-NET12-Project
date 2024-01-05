import User from "./User"
import DateFormatter from "./DateFormatter"
import { DEFAULT_IMAGE_USER, PATH_IMAGE_USERS } from "./defaults"

export default class Review {
  constructor (props) {
    this.id = null
    this.user = null
    this._name = null
    this.description = null
    this.score = null
    this._created = null
    Object.assign(this, props)
    if (this.user) {
      const { lastName, firstName } = this.user
      this.user = new User({ ...this.user, info: { lastName, firstName } })
    }
  }

  clear () {
    this.name = null
    this.description = null
  }

  set name (v) {
    this._name = v
  }

  get name () {
    return this.user ? this.user.fullName : this._name
  }

  set created (v) {
    this._created = v instanceof Date ? v : new Date(v)
  }

  get created () {
    return DateFormatter.format(this._created, 'dd-mm-yyyy hh:mi')
  }

  get image () {
    if (this.user) return this.user.avatar
    return `${PATH_IMAGE_USERS}/${DEFAULT_IMAGE_USER}`
  }

  get author () {
    return this.user?.fullName || this.name
  }
}
