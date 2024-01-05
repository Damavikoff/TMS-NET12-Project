<template>
  <Modal class="fixed" @close="$emit('close')">
    <div class="raw order segment">
      <div class="lined heading">
        <i class="icofont icofont-close-line link icon" @click="$emit('close')"></i>
        <img src="@/assets/thank_you.png" alt="icon" />
        <span class="ghost secondary text">Your order has been received</span>
      </div>
      <div class="lined meta">
        <div class="item">
          <span class="secondary text">Order&nbsp;Number</span>
          <span class="bold secondary text">{{ order.number }}</span>
        </div>
        <div class="item">
          <span class="secondary text">Date</span>
          <span class="bold secondary text">{{ formatDate(order.created) }}</span>
        </div>
        <div class="item">
          <span class="secondary text">Total</span>
          <span class="bold secondary text">{{ formatCurrency(order.total) }}</span>
        </div>
        <div class="item">
          <span class="secondary text">Payment&nbsp;Method</span>
          <span class="bold secondary text">{{ order.paymentMethodName }}</span>
        </div>
      </div>
      <div class="content">
        <div class="details">
          <div class="covering scrolling">
            <div class="content">
              <table class="table">
                <thead>
                  <tr>
                    <th>Products</th>
                    <th name="quantity">Quantity</th>
                    <th name="total">Subtotal</th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="(v, k) in order.items" :key="k">
                    <td>
                      <div class="flex centered relaxed">
                        <div class="image square">
                          <div class="content">
                            <img :src="v.product.src" alt="img" />
                          </div>
                        </div>
                        <div class="description">
                          <div class="header">{{ v.product.title }}</div>
                          <span class="text secondary"><span class="ghost text">SKU: </span>{{ v.product.sku }}</span>
                        </div>
                      </div>
                    </td>
                    <td class="collapsing" name="quantity">
                      <div class="boxed round label">{{ v.size.label }}</div>
                      (x{{ v.amount }})
                    </td>
                    <td class="collapsing" name="total">
                      <span class="large bold green text">{{ formatCurrency(v.product.totalPrice * v.amount) }}</span>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
        <div class="lined total">
          <div class="flex centered">
            <span class="fluid text">Shipping</span>
            <span class="large bold text">{{ formatCurrency(order.shipping) }}</span>
          </div>
          <div class="flex centered">
            <span class="fluid bold text">Total</span>
            <span class="large bold green text">{{ formatCurrency(order.total) }}</span>
          </div>
        </div>
        <div class="message">
          <span class="secondary text">Your order is currently being processed. You will receive an order confirmation email shortly with the expected delivery date for your items.</span>
        </div>
      </div>
    </div>
  </Modal>
</template>

<script>

import Order from '../data/Order'
import Modal from './Modal.vue'

export default {
  name: 'c-order-modal',
  components: {
    Modal
  },
  emits: ['close'],
  props: {
    data: Order
  },
  data () {
    return {
      order: this.data
    }
  },
  mounted () {
    this.$store.commit('setLastOrder')
  },
  methods: {
  }
}

</script>

<style scoped lang="scss">
  .heading {
    background-color: rgba(70, 163, 88, 0.06);
    display: flex;
    flex-flow: column;
    align-items: center;
    padding: 0.8em 10em;
    padding-top: 1.8em;
    >i {
      color: var(--color-green);
      position: absolute;
      top: 12px;
      right: 12px;
      font-size: 1.5em;
    }
    >img {
      width: 4.2rem;
      margin-bottom: .6em;
    }
  }

  .meta {
    display: flex;
    padding: 1em;
    >.item {
      display: flex;
      flex-flow: column;
      gap: .2em;
      padding: 0 .7em;
      flex-grow: 1;
      &:not(:last-child) {
        border-right: 1px solid var(--color-border-secondary);
      }
    }
  }

  .order.segment {
    width: 650px;
  }

  .segment>.content {
    padding: 0 1em;
    div.details {
      .scrolling {
        max-height: 50vh;
      }
      .table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0 .6em;
        text-align: left;
        height: 0;
        thead {
          font-size: 1.2em;
          box-shadow: 0 1px 0 0 var(--color-border-secondary);
          th {
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
              width: 4em;
              border-radius: 50%;
              margin-right: .5em;
            }
            .description {
              font-size: .94em;
              .header {
                font-size: 1.2em;
                margin-bottom: .1rem;
              }
            }
            &[name="quantity"] {
              white-space: nowrap;
              width: 9rem;
              .label {
                font-size: .8em;
                margin-right: 0.3em;
              }
            }
            &[name="total"] {
              width: 8rem;
            }
          }
        }
      }
    }
    div.total {
      font-size: 1.05em;
      display: flex;
      flex-flow: column;
      gap: .7em;
      padding: .5em 0 1em 50%;
    }

    div.message {
      text-align: center;
      padding:  2em 0;
    }
  }

  .lined {
    border-bottom: 1px solid var(--color-border-secondary);
  }
</style>
