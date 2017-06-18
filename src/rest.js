
export const baseURL = 'https://moecoop-api.arukascloud.io'

export function restCall(method, url, callback) {
  const xhr = new XMLHttpRequest()
  xhr.onreadystatechange = function() {
    callback(xhr)
  }
  xhr.respenseType = 'json'
  xhr.open(method, url, true)
  xhr.send()
}
