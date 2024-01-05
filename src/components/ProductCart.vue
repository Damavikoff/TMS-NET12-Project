<template>
    <section class="cart">
      <CartPreview v-if="tab === tabs.TAB_PREVIEW" @switch="tab = tabs.TAB_CHECKOUT" />
      <CartCheckout v-else-if="tab === tabs.TAB_CHECKOUT" @switch="tab = tabs.TAB_PREVIEW" :data="shippingInfo" />
    </section>
</template>

<script>
  import CartPreview from './CartPreview.vue'
  import CartCheckout from './CartCheckout.vue'
  import { OrderInfo } from '../data/Order'

  const TAB_PREVIEW = 1
  const TAB_CHECKOUT = 2

  export default {
    name: 'product-cart',
    components: {
      CartPreview,
      CartCheckout
    },
    props: {
    },
    emits: [],
    data () {
      return {
        tab: TAB_PREVIEW,
        tabs: {
          TAB_PREVIEW,
          TAB_CHECKOUT
        },
        shippingInfo: new OrderInfo()
      }
    },
    async created () {
    },
    methods: {
    },
    computed: {
    }
  }
</script>

<style scoped lang="scss">
  .cart {
    margin-bottom: 1rem;
    flex-grow: 1;
  }
</style>
