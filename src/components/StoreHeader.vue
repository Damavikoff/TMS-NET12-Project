<template>
  <header class="flex centered">
    <div class="larger logo bolder icon header">
      <img src="@/assets/logo.png" alt="logo">GREENSHOP
    </div>
    <div class="fluid text-center">
      <div class="medium menu">
        <RouterLink class="relative" to="/">Catalog</RouterLink>
        <RouterLink class="relative" to="/delivery">Sheeping &amp; Delivery</RouterLink>
        <RouterLink class="relative" to="/blogs">Blogs</RouterLink>
        <RouterLink class="relative" to="/about">About Us</RouterLink>
      </div>
    </div>
    <SearchInput class="cursor-pointer" v-model="search" />
    <CartToggle class="bigger" :count="cart.length" @click="$router.push('/cart')" />
    <div class="profile" v-if="user" @click="$router.push('/profile')">
      <img :src="user.avatar" alt="user" />
      <div class="medium header">{{ user.fullName }}</div>
    </div>
    <button class="green wide button" @click="$emit('showLogin')" v-else>
      <i class="icofont icofont-login"></i>Login
    </button>
  </header>
</template>

<script>
import { mapGetters } from 'vuex'

import { RouterLink } from 'vue-router'
import SearchInput from './SearchInput.vue'
import CartToggle from './CartToggle.vue'

export default {
  name: 'store-header',
  components: {
    RouterLink,
    SearchInput,
    CartToggle
  },
  props: {
  },
  emits: ['showLogin'],
  data () {
    return {
      search: ''
    }
  },
  computed: {
    ...mapGetters(['cart', 'user'])
  }
}

</script>

<style scoped lang="scss">
  header {
    padding: 1rem 0;
    gap: 1.2rem;
    border-bottom: 1px solid var(--color-border-main);

    >.logo.header {
      color: var(--color-green);
    }
    .menu {
      margin-left: 2rem;
      display: inline-flex;
      align-items: center;
      gap: 3rem;
      >a {
        &.router-link-exact-active {
          font-weight: 600;
          &::before {
            content: '';
            position: absolute;
            width: 100%;
            border-bottom: 4px solid var(--color-green);
            bottom: -1.54rem;
          }
        }
      }
    }
  }

  .profile {
    cursor: pointer;
    padding: .5em;
    margin: -.5em 0;
    border-radius: .2em;
    font-size: 1.2em;
    display: flex;
    align-items: center;
    gap: 0.7rem;
    background-color: #fcfcfc;
    img {
      height: 1.6em;
    }
    &:hover {
      background-color: #f7f7f7;
    }
    transition: all .4s ease;
    >.header {
      font-size: 1em;
    }
  }
</style>
