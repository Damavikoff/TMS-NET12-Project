<template>
  <template v-if="ready">
    <StoreHeader @showLogin="isLoginModalVisible = true" />
    <RouterView :key="$route.path" />
    <StoreFooter />
  </template>
  <Loader v-if="busy || !ready" class="fixed"/>
  <transition-group name="fade">
    <OrderModal :data="lastOrder" @close="isOrderModalVisible = false" v-if="isOrderModalVisible" />
    <LoginModal @close="isLoginModalVisible = false" v-if="isLoginModalVisible" />
  </transition-group>
</template>

<script>
import { RouterView } from 'vue-router'
import { mapGetters } from 'vuex'

import { ENDPOINTS } from '@/data/defaults'
import RequestHandler from '@/data/RequestHandler'

import StoreHeader from '@/components/StoreHeader.vue'
import StoreFooter from '@/components/StoreFooter.vue'
import Loader from '@/components/Loader.vue'
import OrderModal from '../components/OrderModal.vue'
import LoginModal from '../components/LoginModal.vue'

export default {
  name: 'main-view',
  components: {
    Loader,
    RouterView,
    StoreHeader,
    StoreFooter,
    OrderModal,
    LoginModal
  },
  data () {
    return {
      isOrderModalVisible: false,
      isLoginModalVisible: false
    }
  },
  created () {
    this.setInitData()
  },
  updated () {
    if (this.lastOrder) {
      this.isOrderModalVisible = true
    }
  },
  methods: {
    async setInitData () {
      try {
        const data = await RequestHandler.doGetRequest(`${ENDPOINTS.init}`)
        this.$store.dispatch('setInitData', data)
        this.$store.commit('setReady')
      } catch (e) {
        this.$store.commit('setError', e)
        this.$router.push('/error')
      }
    }
  },
  computed: {
    ...mapGetters(['ready', 'busy', 'lastOrder'])
  }
}

</script>
