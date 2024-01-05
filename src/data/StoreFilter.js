export default class StoreFilter {
  constructor (props) {
    this.items = {}
    this.grid = null
    this.sortList = []
    Object.assign(this, props)
    if (this.items instanceof Array) {
      this.setItems(this.items)
    }
    this.sort = this.sortList[0]
  }

  setItems (values) {
    this.items = Object.fromEntries(values.map(v => [v.name, FilterItem.get(v)]))
  }

  get itemValues () {
    return Object.values(this.items)
  }

  get active () {
    return this.itemValues.some(v => v.active)
  }

  get url () {
    return this.itemValues.filter(v => v.active).reduce((a, b) => a + b.urlParam , '')
  }
}

export class FilterItem {
  static T_CATEGORY = 1
  static T_RANGE = 2

  constructor (props) {
    this.type = FilterItem.T_CATEGORY
    this.title = 'N/A'
    this.name = ''
    Object.assign(this, props)
  }

  get active () {
    return true
  }

  static get (v) {
    switch (v.type) {
      case FilterItem.T_CATEGORY:
        return new FilterCategoryItem(v)
      case FilterItem.T_RANGE:
        return new FilterRangeItem(v)
      default:
        break;
    }
  }
}

export class FilterCategoryItem extends FilterItem {
  constructor (props) {
    super(props)
    this.type = FilterItem.T_CATEGORY
    this.values = []
    this.index = 0
    Object.assign(this, props)
  }

  get urlParam () {
    const value = this.values[this.index]?.value
    return value ? `&${this.name}=${value}` : ''
  }

  get active () {
    return this.values.length > 0
  }

  setValues (values) {
    this.values = [
      { value: null, title: 'All', count: values.reduce((a, b) => a + b.count, 0) },
      ...values.map(v => {
        const { id: value, title, count } = v
        return {
          value,
          title,
          count
        }
      })
    ]
  }
}

export class FilterRangeItem extends FilterItem {
  constructor (props) {
    super(props)
    this.type = FilterItem.T_RANGE
    this.min = 0
    this.max = 0
    this.start = 0
    this.end = 0
    this.prefix = ''
    Object.assign(this, props)
    this.start = this.start || this.min
    this.end = this.end || this.max
  }

  get urlParam () {
    const { start, end, name } = this
    return `&${name}Min=${Math.round(start)}&${name}Max=${Math.round(end)}`
  }

  get active () {
    const { max, min } = this
    return max > min
  }

  get label () {
    const { prefix, start, end } = this
    return `${prefix}${Math.round(start)} - ${prefix}${Math.round(end)}`
  }
}

export class Sorting {
  static ASC = 1
  static DESC = 2

  constructor (props) {
    this.title = null
    this.name = null
    this.order = Sorting.ASC
    Object.assign(this, props)
  }

  get url () {
    return `&sortBy=${this.name}&sortOrder=${this.order}`
  }
}
