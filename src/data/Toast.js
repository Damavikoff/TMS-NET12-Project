import { v4 as uuidv4 } from 'uuid';

export default class Toast {
  static T_MESSAGE = 1
  static T_SUCCESS = 2
  static T_ERROR = 3

  constructor (props) {
    this.type = Toast.T_MESSAGE
    this.icon = null
    this.header = null
    this.message = null
    this.timeout = 3000
    this.closeable = true
    this.visible = true
    this.key = uuidv4()
    Object.assign(this, props)
  }

  hide () {
    this.visible = false
  }

  static message (message) {
    return new Toast({
      type: Toast.T_MESSAGE,
      header: 'Message',
      message
    })
  }

  static success (message) {
    return new Toast({
      type: Toast.T_SUCCESS,
      header: 'Success',
      message
    })
  }

  static error (message) {
    return new Toast({
      type: Toast.T_ERROR,
      header: 'Error',
      message
    })
  }
}
