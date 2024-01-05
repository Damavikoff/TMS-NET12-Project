export const sleep = (ms) => {
  return new Promise(resolve => setTimeout(resolve, ms))
}

export const animate = ({timing, callback, duration}) => {

  let start = performance.now();

  return new Promise(resolve => {
    requestAnimationFrame(function animate (time) {
      let timeFraction = (time - start) / duration
      if (timeFraction > 1) {
        timeFraction = 1
        resolve()
      }
  
      let progress = timing(timeFraction)
      callback(progress)
  
      if (timeFraction < 1) {
        requestAnimationFrame(animate);
      }
    })
  })
}

export const formatCurrency = (v) => {
  return new Intl.NumberFormat('en-US', {
    style: 'currency',
    currency: 'USD',
  }).format(v)
}
