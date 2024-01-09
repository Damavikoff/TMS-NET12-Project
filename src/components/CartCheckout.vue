<template>
  <Loader v-if="!ready" class="fixed ghost" />
  <nav class="navigation">
    <RouterLink to="/" custom v-slot="{ navigate }">
      <span @click="navigate" class="bold link text">Catalog</span>
    </RouterLink>
    / <span class="bold text link" @click="$emit('switch')">Cart</span>
    / <span class="text">Checkout</span>
  </nav>
  <div class="grid">
    <div class="fitted column">
      <div class="header">Billing Address</div>
      <div class="form">
        <div class="fields">
          <div class="required field">
            <label>First Name</label>
            <input type="text" placeholder="..." v-model.trim="orderInfo.firstName" />
          </div>
          <div class="required field">
            <label>Last Name</label>
            <input type="text" placeholder="..." v-model.trim="orderInfo.lastName" />
          </div>
        </div>
        <div class="fields">
          <div class="field">
            <label>Town / City</label>
            <Dropdown v-model="orderInfo.city" :list="cities" />
          </div>
          <div class="required field">
            <label>Street Address</label>
            <input type="text" placeholder="..." v-model.trim="orderInfo.address" />
          </div>
        </div>
        <div class="fields">
          <div class="required field">
            <label>Email</label>
            <input type="text" placeholder="..." v-model.trim="orderInfo.email" />
          </div>
          <div class="required field">
            <label>Phone</label>
            <input type="text" placeholder="+375..." v-model.trim="orderInfo.phone" />
          </div>
        </div>
        <div class="field">
          <label>Order Notes</label>
          <textarea rows="5" v-model="orderInfo.description"></textarea>
        </div>
      </div>
    </div>
    <div class="fitted column total">
      <div class="header">Your Order</div>
      <div class="divider"></div>
      <div class="item">
        <div class="flex centered relaxed">
          <span class="label fluid text">Subtotal</span>
          <span class="bold price text">{{ formatCurrency(subTotal) }}</span>
        </div>
      </div>
      <div class="item">
        <div class="flex centered relaxed">
          <span class="label fluid text">Coupon Discount</span>
          <span class="text">(-) 00.00</span>
        </div>
      </div>
      <div class="item">
        <div class="flex centered relaxed">
          <span class="label fluid text">Shipping</span>
          <span class="bold text">{{ formatCurrency(16) }}</span>
        </div>
        <div class="right green link text">View Shipping Charge</div>
      </div>
      <div class="divider"></div>
      <div class="item">
        <div class="flex centered relaxed">
          <span class="label fluid bold text">Total</span>
          <span class="bold green price text">{{ formatCurrency(subTotal ? subTotal + 16 : 0) }}</span>
        </div>
      </div>
      <div class="vertical flex item">
        <div class="header">Payment Method</div>
        <div class="selection basic button" @click="orderInfo.paymentMethod = paymentTypes.card" :class="{ active: orderInfo.paymentMethod === paymentTypes.card }">
          <img src="@/assets/payment.png" alt="payment" />
        </div>
        <div class="selection basic button" @click="orderInfo.paymentMethod = paymentTypes.bank" :class="{ active: orderInfo.paymentMethod === paymentTypes.bank }">Direct Bank Transfer</div>
        <div class="selection basic button" @click="orderInfo.paymentMethod = paymentTypes.cash" :class="{ active: orderInfo.paymentMethod === paymentTypes.cash }">Cash On Delivery</div>
      </div>
      <div class="green fluid text-center button" :class="{ disabled: !isOrderValid }" @click="sendOrder">Place Order</div>
    </div>
  </div>
</template>

<script>
  import { RouterLink } from 'vue-router'
  import Loader from './Loader.vue'
  import Dropdown from './Dropdown.vue'
  import { formatCurrency } from '../data/utils'
  import { ENDPOINTS } from '../data/defaults'
  import RequestHandler from '../data/RequestHandler'
  import Order, { OrderInfo } from '../data/Order'
  import { mapGetters } from 'vuex'

  export default {
    name: 'cart-preview',
    components: {
      RouterLink,
      Loader,
      Dropdown
    },
    props: {
      data: OrderInfo
    },
    emits: ['switch'],
    data () {
      return {
        ready: true,
        orderInfo: this.data
      }
    },
    created () {
      if (this.user) {
        const { lastName, firstName, email, phone } =  this.user.info
        Object.assign(this.orderInfo, { lastName, firstName, email, phone })
        if (this.user.address) {
          const { street: address, city } = this.user.address
          Object.assign(this.orderInfo, { address, city })
        }
      }
    },
    methods: {
      async sendOrder () {
        if (!this.isOrderValid) return
        const data = await RequestHandler.doPostRequest(ENDPOINTS.orders, this.orderInfo)
        const order = new Order(data)
        this.$store.commit('setLastOrder', order)
        this.$store.commit('setCart', [])
        if (this.user) {
          this.user.orders.unshift(order)
        }
        this.$router.push('/')
      },
      formatCurrency (v) {
        return formatCurrency(v)
      }
    },
    computed: {
      ...mapGetters(['cart', 'directories', 'user']),
      subTotal () {
        return this.cart.reduce((a, b) => a + b.amount * b.product.totalPrice, 0)
      },
      cities () {
        return this.directories.cities.map(v => { return { name: v.title, value: v.id } })
      },
      paymentTypes () {
        return {
          card: Order.PAYMENT_CARD,
          bank: Order.PAYMENT_BANK,
          cash: Order.PAYMENT_CASH
        }
      },
      isOrderValid () {
        const { firstName, lastName, address, email, phone } = this.orderInfo
        return this.cart.length && firstName && lastName && address && email && phone
      }
    }
  }
</script>

<style scoped lang="scss">
.selection.button {
  width: 100%;
  line-height: 1;
  font-weight: 400;
  padding: 1em 1.4em;
  padding-left: 3em;
  >img {
    height: 1.6em;
    margin: -0.3em 0;
  }
  &::before {
    content: '';
    position: absolute;
    width: 1em;
    height: 1em;
    border-radius: 50%;
    border: 3px solid white;
    box-shadow: 0 0 0 1px var(--color-green);
    left: 1em;
    top: 50%;
    transform: translateY(-50%);
  }
  &.active {
    box-shadow: inset 0 0 0 1px var(--color-green);
    &::before {
      background-color: var(--color-green);
    }
  }
  +.button {
    margin-top: .5em;
  }
}
.grid {
    padding-top: .5em;
    display: grid;
    grid-template: 1fr / 1fr 370px;
    gap: 6rem;
    >.column {
      .header {
        font-size: 1.2em;
        margin-bottom: .7em;
      }
    }
    .form {
      display: flex;
      flex-flow: column;
      gap: 1.1em;
    }
    .total {
      .item {
        margin: 1.3rem 0;
        .text {
          &.price {
            font-weight: 500;
            font-size: 1.14em;
            &.bold {
              font-weight: 600;
            }
          }
          &.label {
            font-size: 1em;
          }
          &.right {
            font-size: .85em;
            text-align: right;
            margin-top: .3em;
            margin-bottom: 1.5em;
          }
        }
        >.action.input {
          font-size: .94em;
          margin-top: 0.5rem;
        }
      }
      >.button {
        margin-bottom: 1rem;
      }
    }
  }
</style>
