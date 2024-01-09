export default class RequestHandler {
  static #T_GET = 'get'
  static #T_POST = 'post'
  static #T_DELETE = 'delete'

  static #doRequest = async (method, url, body = null, isUrlEncoded = false) => {
    const headers = new Headers()
    const params = {
      method,
      headers,
      body
    }
    if (method === 'post' && body && !(body instanceof FormData)) {
      if (isUrlEncoded) {
        params.headers.append('Content-Type', 'application/x-www-form-urlencoded; charset=utf-8')
        params.body = new URLSearchParams(params.body).toString().replace(/&?\w+=null/g, '').replace(/^&/, '')
      } else {
        params.headers.append('Content-Type', 'application/json; charset=utf-8')
        params.body = JSON.stringify(params.body)
      }
    }
    const r = await fetch(url, params)
    if (!r.ok) {
      const e = await r.text()
      // if (r.status === 401) window.location.reload()
      throw new Error(e || r?.statusMessage || r?.statusText || r?.status)
    }
    if (r.headers.get('Content-Disposition')?.includes('attachment')) return r.blob()
    if (r.headers.get('Content-Type')?.includes('json')) return r.json()
    return r.text()
  }

  static doGetRequest = (url) => {
    return RequestHandler.#doRequest(RequestHandler.#T_GET, url)
  }

  static doDeleteRequest (url) {
    return RequestHandler.#doRequest(RequestHandler.#T_DELETE, url)
  }

  static doPostRequest (url, body, isUrlEncoded) {
    return RequestHandler.#doRequest(RequestHandler.#T_POST, url, body, isUrlEncoded)
  }
}
