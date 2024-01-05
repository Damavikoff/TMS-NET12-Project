const register = {
  updated: (el, binding) => {
    const { arg } = binding
    const { value } = el
    if (arg === 'lower') {
      el.value = value.toLowerCase()
    } else {
      el.value = value.toUpperCase()
    }
    el.dispatchEvent(new Event('input', { bubbles: true }))
  }
}

const numeric = {
  updated: (el, _binding) => {
    el.value = el.value.replace('.', '*dot*').replace(/\./g, '').replace('*dot*', '.').replace(/[^\d|.]+/g, '')
    el.dispatchEvent(new Event('input', { bubbles: true }))
  }
}

export default {
  install (Vue) {
    Vue.directive('register', register)
    Vue.directive('numeric', numeric)
  }
}
