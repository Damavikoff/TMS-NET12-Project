<template>
  <div class="absolute w-full h-full flex centered loader">
    <i class="icofont icofont-spinner-alt-6"></i>
  </div>
</template>

<script>

export default {
  name: 'c-loader'
}

</script>

<style scoped lang="scss">
  .loader {
    z-index: 1000;
    justify-content: center;
    font-size: 7rem;
    >i {
      animation: rotate 1.4s infinite linear;
      opacity: .7;
    }
    background-color: white;
    &.ghost {
      background-color: rgba(255, 255, 255, .3);
    }
    &.fixed {
      position: fixed;
      top: 0;
      left: 0;
      width: 100vw;
      height: 100vh;
      z-index: 10;
    }
  }

  @keyframes rotate {
    100% {
      transform: rotate(360deg);
    }
  }
</style>
