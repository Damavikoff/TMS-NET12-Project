<template>
  <div class="link wrap">
    <i class="icofont icofont-cart-alt"></i>
    <span class="absolute bold label" v-if="count">{{ count }}</span>
  </div>
</template>

<script>

export default {
  name: 'cart-toggle',
  props: {
    count: {
      type: Number,
      default: 0
    }
  }
}
</script>

<style scoped lang="scss">
  .wrap {
    >.label {
      font-size: 0.54em;
      top: -0.3em;
      color: white;
      left: 1.1em;
      background-color: var(--color-green);
      padding: 0.1em 0.4em;
      border-radius: 2em;
    }
  }
</style>
