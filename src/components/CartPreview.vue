<template>
  <Loader v-if="!ready" class="fixed ghost" />
  <nav class="navigation">
    <RouterLink to="/" custom v-slot="{ navigate }">
      <span @click="navigate" class="bold link text">Catalog</span>
    </RouterLink>
    / <span class="text">Cart</span>
  </nav>
  <div class="grid">
    <div class="empty" v-if="!cart.length">
      <div class="pointed fluid icon header">
        <i class="icofont icofont-shopping-cart"></i>
        <div class="content">Your Cart Is Empty
          <div class="sub header">Feel free to browse our products and add items to your cart to make a purchase. Happy shopping!</div>
        </div>
      </div>
    </div>
    <table class="table" v-else>
      <thead>
        <tr>
          <th>Products</th>
          <th class="text-center" name="size">Size</th>
          <th name="price">Price</th>
          <th name="quantity">Quantity</th>
          <th name="total">Total</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(v, k) in cart" :key="k">
          <td>
            <div class="flex centered relaxed">
              <div class="image square">
                <div class="content">
                  <img :src="v.product.src" alt="img" />
                </div>
              </div>
              <div class="description">
                <div class="link header" @click="$router.push(`/catalog/${v.product.id}`)">{{ v.product.title }}</div>
                <span class="text secondary"><span class="ghost text">SKU: </span>{{ v.product.sku }}</span>
              </div>
            </div>
          </td>
          <td class="collapsing text-center">
            <div class="boxed round label">{{ v.size.label }}</div>
          </td>
          <td class="collapsing" name="price">
            <span class="bold secondary text">{{ v.product.totalPriceLabel }}</span>
          </td>
          <td class="collapsing" name="quantity">
            <div class="flex centered widely relaxed">
              <div class="boxed round icon green button" @click="addAmount(v, Math.max(1, v.amount - 1))">
                <i class="icofont icofont-minus"></i>
              </div>
              <span class="text-center label">{{ v.amount }}</span>
              <div class="boxed round icon green button" @click="addAmount(v, v.amount + 1)">
                <i class="icofont icofont-plus"></i>
              </div>
            </div>
          </td>
          <td>
            <span class="bold green text">{{ formatCurrency(v.product.totalPrice * v.amount) }}</span>
          </td>
          <td class="collapsing">
            <i class="icofont icofont-close-circled link" @click="remove(v)"></i>
          </td>
        </tr>
      </tbody>
    </table>
    <div class="total">
      <div class="header">Cart Total</div>
      <div class="item">
        <span class="label text">Coupon Apply</span>
        <div class="action input">
          <input type="text" placeholder="Enter coupon code here..." />
          <div class="green button">Apply</div>
        </div>
      </div>
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
      <div class="item">
        <div class="flex centered relaxed">
          <span class="label fluid bold text">Total</span>
          <span class="bold green price text">{{ formatCurrency(subTotal ? subTotal + 16 : 0) }}</span>
        </div>
      </div>
      <div class="green fluid text-center button" :class="{ disabled: !cart.length }" @click="proceed">Proceed To Checkout</div>
      <div class="flex justify-center">
        <span class="green link text" @click="$router.push('/')">Continue Shopping</span>
      </div>
    </div>
  </div>
</template>

<script>
  import { RouterLink } from 'vue-router'
  import { mapGetters } from 'vuex'
  import { formatCurrency } from '../data/utils'
  import { ENDPOINTS } from '../data/defaults'
  import RequestHandler from '../data/RequestHandler'

  import Loader from './Loader.vue'

  export default {
    name: 'cart-preview',
    components: {
      RouterLink,
      Loader
    },
    props: {
    },
    emits: ['switch'],
    data () {
      return {
        ready: true
      }
    },
    async created () {
    },
    methods: {
      proceed () {
        if (!this.cart.length) return
        this.$emit('switch')
      },
      async addAmount (i, amount) {
        try {
          const { product: p, size: s } = i
          await RequestHandler.doPostRequest(`${ENDPOINTS.cart}?append=false`, { product: p.id, size: s.id, amount })
          i.amount = amount
        } catch (e) {
          this.handleStateError(e)
        }
      },
      async remove (v) {        
        try {
          await RequestHandler.doDeleteRequest(`${ENDPOINTS.cart}/${v.product.id}/${v.size.id}`)
          this.$store.commit('setCart', this.cart.filter(e => e !== v))
        } catch (e) {
          this.handleStateError(e)
        }
      },
      formatCurrency (v) {
        return formatCurrency(v)
      }
    },
    computed: {
      ...mapGetters(['cart']),
      subTotal () {
        return this.cart.reduce((a, b) => a + b.amount * b.product.totalPrice, 0)
      }
    }
  }
</script>

<style scoped lang="scss">
  .grid {
    display: grid;
    grid-template: 1fr / 1fr 370px;
    gap: 3rem;
    >.empty {
      height: 100%;
      font-size: .9em;
      >.header {
        max-width: 40rem;
      }
    }
    .table {
      border-collapse: separate;
      border-spacing: 0 .6em;
      text-align: left;
      height: 0;
      thead {
        font-size: 1.2em;
        box-shadow: 0 1px 0 0 var(--color-border-secondary);
        th {
          padding-top: 0;
          &[name="price"] {
            width: 8rem;
          }
          &[name="size"] {
            width: 6rem;
          }
          &[name="quantity"] {
            width: 9rem;
          }
          &[name="total"] {
            width: 8rem;
          }
        }
      }
      tbody {
        td {
          background-color: var(--color-lightgrey);
          margin: .5em 0;
          .image {
            width: 4.4em;
            border-radius: 50%;
            margin-right: .5em;
          }
          .description {
            font-size: .94rem;
            .header {
              font-size: 1.2em;
              margin-bottom: .1rem;
            }
          }
          &[name="quantity"] {
            .flex {
              font-size: .82em;
              >.label {
                font-size: 1.1em;
                min-width: 1.2rem;
              }
            }
          }
          >i {
            font-size: 1.5em;
            color: var(--color-font-secondary);
          }
        }
      }
    }
    .total {
      padding-top: .6em;
      >.header {
        font-size: 1.2em;
        padding-bottom: .7em;
        box-shadow: 0 1px 0 0 var(--color-border-secondary);
      }
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
