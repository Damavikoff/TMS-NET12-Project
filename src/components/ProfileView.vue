<template>
  <main>
    <div class="menu">
      <div class="header">My Account</div>
      <div class="item" v-for="(v, k) in visibleMenuItems" :key="k" @click="activeTabType = v.type" :class="{ active: v === activeItem }" >
        <i class="icofont" :class="v.icon"></i>{{ v.title }}
      </div>
      <template v-if="isAdmin">
        <div class="divider"></div>
        <div class="item" @click="activeTabType = TAB_ADMIN"><i class="icofont icofont-support"></i>Administration</div>
      </template>
      <div class="divider"></div>
      <div class="green item" @click="logOut">
        <i class="icofont icofont-exclamation-circle"></i>Logout
      </div>
    </div>
    <transition name="fade" mode="out-in">
      <div class="content" :key="activeTabType">
        <div class="header">{{ activeItem.title }}</div>
        <div class="segment" v-if="activeItem.type === TAB_DETAILS">
          <div class="form">
            <div class="fields">
              <div class="required field">
                <label>First Name</label>
                <input type="text" placeholder="..." v-model="userData.info.firstName" />
              </div>
              <div class="field">
                <label>Last Name</label>
                <input type="text" placeholder="..." v-model="userData.info.lastName" />
              </div>
            </div>
            <div class="fields">
              <div class="required field">
                <label>Email</label>
                <input type="text" placeholder="example@gmail.com" v-model="userData.info.email" />
              </div>
              <div class="required field">
                <label>Phone Number</label>
                <input type="text" placeholder="+375(29)..." v-model="userData.info.phone" />
              </div>
            </div>
            <div class="fields">
              <div class="field">
                <div class="fields">
                  <div class="field">
                    <label>City</label>
                    <Dropdown v-model="userData.address.city" :list="cities" />
                  </div>
                  <div class="field" name="zip">
                    <label>Zip</label>
                    <input type="text" placeholder="..." v-model="userData.address.zip" />
                  </div>
                </div>
              </div>
              <div class="required field">
                <label>Address</label>
                <input type="text" placeholder="..." v-model="userData.address.street" />
              </div>
            </div>
          </div>
          <div class="flex widely relaxed centered justify-end">
            <span class="red text" v-if="userInfoError"><i class="icofont icofont-exclamation-circle"></i>{{ userInfoError }}</span>
            <div class="green wide button" :class="{ disabled: userInfoError }" @click="saveUserInfo"><i class="icofont icofont-save"></i>Save Changes</div>
          </div>
        </div>
        <div class="grow flex justify-center segment" v-else-if="activeItem.type === TAB_ORDERS">
          <div class="w-full orders secondary segment" v-if="userOrders.length">
            <div class="h-full scrolling">
              <table class="basic w-full table">
                <tbody>
                  <tr v-for="(v, k) in userOrders" :key="k">
                    <td class="collapsing">
                      <span class="small whitespace-nowrap secondary text">{{ formatDate(v.created) }}</span>
                    </td>
                    <td>
                      <span class="fluid bold text"># {{ v.number }}</span>
                    </td>
                    <td class="collapsing">
                      <span class="small secondary text">(x{{ v.items.length }})</span>
                    </td>
                    <td class="collapsing">
                      <span class="medium bold green text">{{ formatCurrency(v.total) }}</span>
                    </td>
                    <td class="collapsing">
                      <div class="label" :style="{ background: v.stateColor }">{{ v.stateName }}</div>
                    </td>
                    <td class="collapsing">
                      <i class="large icofont icofont-search-1 link icon" @click="activeUserModal = v"></i>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
          <div class="grow flex justify-center segment" v-else>
            <div class="icon huge header">
              <i class="icofont icofont-search-2"></i>
              <div class="content">Not Found
                <div class="sub header">You have no orders yet.</div>
              </div>
            </div>
          </div>
        </div>
        <div class="grow flex justify-center segment" v-else-if="activeItem.type === TAB_ADMIN">
          <div class="w-full orders secondary segment" v-if="overallOrders.length">
            <div class="h-full scrolling">
              <table class="basic w-full selectable table">
                <tbody>
                  <tr v-for="(v, k) in overallOrders" :key="k" @click="activeOrder = v">
                    <td class="collapsing">
                      <div class="label" :style="{ background: v.stateColor }">{{ v.stateName }}</div>
                    </td>
                    <td>
                      <span class="fluid bold text"># {{ v.number }}</span>
                    </td>
                    <td class="collapsing">
                      <div class="flex relaxed centered">
                        <img :src="v.user.avatar" alt="user" />
                        <span class="nowrap text">{{ v.user.fullName }}</span>
                      </div>
                    </td>
                    <td class="collapsing">
                      <span class="nowrap small secondary text">{{ `${v.address.cityTitle}, ${v.address.street}` }}</span>
                    </td>
                    <td class="collapsing">
                      <span class="small secondary text">{{ v.user.info.phone }}</span>
                    </td>
                    <td class="collapsing">
                      <span class="medium bold green text">{{ formatCurrency(v.total) }}</span>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
          <div class="grow flex justify-center segment" v-else>
            <div class="icon huge header">
              <i class="icofont icofont-search-2"></i>
              <div class="content">Not Found
                <div class="sub header">There are no any orders.</div>
              </div>
            </div>
          </div>
        </div>
        <div class="grow flex justify-center segment" v-else>
          <div class="icon huge header">
            <i class="icofont icofont-confounded"></i>
            <div class="content">Not Implemented
              <div class="sub header">Out of initial goals.</div>
            </div>
          </div>
        </div>
      </div>
    </transition>
    <transition name="fade" mode="out-in">
      <OrderDetailsModal :data="activeOrder" v-if="activeOrder" @close="activeOrder = null" :controllable="isAdmin" @state="setState" />
    </transition>
    <transition name="fade" mode="out-in">
      <OrderDetailsModal :data="activeUserOrder" v-if="activeUserOrder" @close="activeUserOrder = null" />
    </transition>
  </main>
</template>

<script>
import { mapGetters } from 'vuex';

import Dropdown from './Dropdown.vue';
import User from '../data/User';
import RequestHandler from '../data/RequestHandler'
import { ENDPOINTS } from '../data/defaults'
import OrderDetailsModal from '@/components/OrderDetailsModal.vue'

const TAB_DETAILS = 1
const TAB_ORDERS = 2
const TAB_WISHLIST = 3
const TAB_SUPPORT = 4
const TAB_REPORTS = 5
const TAB_ADMIN = 6

export default {
  name: 'profile-view',
  components: {
    Dropdown,
    OrderDetailsModal
  },
  props: {
  },
  data () {
    return {
      userData: null,
      activeTabType: TAB_DETAILS,
      activeOrder: null,
      activeUserModal: null,
      TAB_DETAILS,
      TAB_ORDERS,
      TAB_WISHLIST,
      TAB_SUPPORT,
      TAB_REPORTS,
      TAB_ADMIN
    }
  },
  created () {
    const { info, address } = this.user
    this.userData = new User({ ...this.user, info: { ...info }, address: { ...address } })
  },
  emits: [],
  methods: {
    async logOut () {
      await RequestHandler.doPostRequest(`${ENDPOINTS.auth}/logout`)
      this.$router.push('/')
      this.$store.commit('setUser')
    },
    async saveUserInfo () {
      if (this.userInfoError) return
      try {
        await RequestHandler.doPostRequest(ENDPOINTS.user, this.userData)
        this.$store.commit('setUser', this.userData)
      } catch (e) {
        this.handleStateError(e)
      }
    },
    async setState (state) {
      if (!this.activeOrder) return
      try {
        const { id } = this.activeOrder
        await RequestHandler.doPostRequest(`${ENDPOINTS.orders}/state/${id}/${state}`);
        this.activeOrder.state = state
        const order = this.userOrders.find(v => v.id === id)
        if (order) {
          order.state = state
        }
        this.activeOrder = null
      } catch (e) {
        this.handleStateError(e)
      }
    }
  },
  computed: {
    ...mapGetters(['directories', 'user', 'orders']),
    cities () {
      return this.directories.cities.map(v => {
        const { title: name, id: value } = v
        return { name, value }
      })
    },
    menuItems () {
      const items = [
        { title: 'Account Details', icon: 'icofont-search-user', type: TAB_DETAILS },
        { title: 'Orders', icon: 'icofont-cart-alt', type: TAB_ORDERS },
        { title: 'Wishlist', icon: 'icofont-heart', type: TAB_WISHLIST },
        { title: 'Reports', icon: 'icofont-chart-pie', type: TAB_REPORTS },
        { title: 'Support', icon: 'icofont-exclamation-circle', type: TAB_SUPPORT },
        { title: 'Administration', icon: 'icofont-support', type: TAB_ADMIN }
      ]
      return items
    },
    visibleMenuItems () {
      return this.menuItems.filter(v => v.type !== TAB_ADMIN)
    },
    activeItem () {
      return this.menuItems.find(v => v.type === this.activeTabType)
    },
    userInfoError () {
      if (!this.userData.info.firstName) return 'Set Your Name'
      if (!this.userData.info.email) return 'Set Your Email'
      if (!/^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|.(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/.test(this.userData.info.email)) return 'Invalid Email Format'
      if (!this.userData.info.phone) return 'Set Your Phone'
      if (!this.userData.address.street) return 'Set Your Address'
      return null 
    },
    isAdmin () {
      return this.user?.role === User.ROLE_ADMIN
    },
    userOrders () {
      if (!this.user) return []
      return this.user.orders
    },
    overallOrders () {
      if (!this.isAdmin) return []
      return this.orders
    }
  }
}

</script>

<style scoped lang="scss">
  main {
    flex-grow: 1;
    padding: 3rem 0 1rem;
    display: grid;
    grid-template: 1fr / 200px 1fr;
    gap: 7rem;
    >.content {
      display: flex;
      flex-flow: column;
      >.header {
        margin-bottom: 1.2rem;
      }
      padding: 0 1em;
    }
  }
  .menu {
    display: inline-block;
    >.header {
      margin-bottom: 1em;
    }
    .item {
      cursor: pointer;
      opacity: .9;
      padding: .5em 1.3em;
      margin: 1em 0;
      color: var(--color-font-secondary);
      >i {
        font-size: 1.2em;
        vertical-align: middle;
        margin-right: .7em;
      }
      &:hover {
        opacity: 1;
      }
      &.active {
        color: var(--color-green);
        box-shadow: inset 5px 0 0 0 var(--color-green);
        font-weight: 500;
        background-color: white;
      }
      &.green {
        font-weight: 500;
        color: var(--color-green);
      }
    }
    >.divider {
      margin: .6em 0;
    }
  }

  .form {
    .fields {
      margin-bottom: 1em;
    }
    .field {
      padding: 0 1em;
      &[name=zip] {
        padding-left: 0;
        width: 150px;
      }
    }
  }

  .orders.segment {
    padding: .5em;
    border-radius: .4em;
    margin: -1em 0;
    max-height: 600px;
    table {
      td {
        >.label {
          border: none;
          color: white;
          padding: 0.4em 0.6em;
          font-size: .82em;
          width: 100px;
          text-align: center;
          font-weight: 500;
          border-radius: .2em;
        }
        img {
          height: 1.3em;
          display: inline-block;
          max-width: none;
        }
      }
    }
  }
</style>
