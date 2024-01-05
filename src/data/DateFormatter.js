export default class DateFormatter {
  static #weekDays = [
    { short: 'Sun', long: 'Sunday' },
    { short: 'Mon', long: 'Monday' },
    { short: 'Tue', long: 'Tuesday' },
    { short: 'Wed', long: 'Wednesday ' },
    { short: 'Thu', long: 'Thursday' },
    { short: 'Fri', long: 'Friday' },
    { short: 'Sat', long: 'Saturday' }
  ]

  static #months = [
    { short: 'Jan', long: 'January' },
    { short: 'Feb', long: 'February' },
    { short: 'Mar', long: 'March' },
    { short: 'Apr', long: 'April' },
    { short: 'May', long: 'May' },
    { short: 'Jun', long: 'June' },
    { short: 'Jul', long: 'July' },
    { short: 'Aug', long: 'August' },
    { short: 'Sep', long: 'September' },
    { short: 'Oct', long: 'October' },
    { short: 'Nov', long: 'November' },
    { short: 'Dec', long: 'December' }
  ]

  static format (date, format = 'dd-mm-yyyy') {
    if (!date) return null
    let currDate = typeof date === 'number' ? new Date(date * 1000) : date
    currDate = typeof date === 'string' ? new Date(date) : currDate
    const hours = currDate.getHours().toString().padStart(2, 0)
    const minutes = currDate.getMinutes().toString().padStart(2, 0)
    const day = currDate.getDate()
    const dayPadded = day.toString().padStart(2, 0)
    const weekDay = currDate.getDay()
    const weekDayShort = this.#weekDays[weekDay].short
    const weekDayLong = this.#weekDays[weekDay].long
    const month = currDate.getMonth()
    const monthPadded = (month + 1).toString().padStart(2, 0)
    const monthShort = this.#months[month].short
    const monthLong = this.#months[month].long
    const year = currDate.getFullYear()

    return format.replace(/hh/g, hours)
      .replace(/mi/g, minutes)
      .replace(/dd/g, dayPadded)
      .replace(/d/g, day)
      .replace(/ww/g, weekDayLong)
      .replace(/w/g, weekDayShort)
      .replace(/mmm/g, monthLong)
      .replace(/mm/g, monthPadded)
      .replace(/m/g, monthShort)
      .replace(/yyyy/g, year)
  }
}
