<template>
  <Modal class="fixed" @close="$emit('close')">
    <div class="auth segment">
      <i class="icofont icofont-close-line link icon" @click="$emit('close')"></i>
      <div class="heading">
        <div class="flex centered">
          <span class="link text" v-for="(m, k) in [MODE_LOGIN, MODE_REGISTER]" :key="k" :class="{ green: mode === m }" @click="setMode(m)">{{ m === MODE_LOGIN ? 'Login' : 'Register' }}</span>
        </div>
      </div>
      <div class="content">
        <div class="login" v-if="mode === MODE_LOGIN">
          <span class="block text-center text">Enter your name and password to login.</span>
          <div class="form">
            <div class="field">
              <input type="text" placeholder="login..." v-model.trim="login" />
            </div>
            <div class="field">
              <div class="icon password input">
                <input :type="isPasswordVisible ? 'text' : 'password'" placeholder="..." v-model.trim="password" />
                <i class="icofont link icon" :class="{ 'icofont-eye-blocked': !isPasswordVisible, 'icofont-eye': isPasswordVisible }" @mouseenter="isPasswordVisible = true" @mouseleave="isPasswordVisible = false"></i>
              </div>
              <span class="block text-right green link text">Forgot your password?</span>
            </div>
          </div>
          <div class="green fluid text-center button" :class="{ disabled: !isAbleToLogin }" @click="authenticate">Login</div>
        </div>
        <div class="register" v-else>
          <span class="block text-center text">Enter your email and password to register.</span>
          <div class="form">name
            <div class="field">
              <input type="text" placeholder="username..." v-model.trim="login" />
            </div>
            <div class="field">
              <input type="text" placeholder="somebody@example.com" v-model.trim="email" />
              <i class="icofont icofont-exclamation-circle link notify icon" v-if="!isEmailValid" title="Invalid email format" />
            </div>
            <div class="field">
              <div class="icon password input">
                <input :type="isPasswordVisible ? 'text' : 'password'" placeholder="..." v-model.trim="password" />
                <i class="icofont link icon" :class="{ 'icofont-eye-blocked': !isPasswordVisible, 'icofont-eye': isPasswordVisible }" @mouseenter="isPasswordVisible = true" @mouseleave="isPasswordVisible = false"></i>
              </div>
            </div>
            <div class="field">
              <div class="icon password input">
                <input :type="isConfirmPasswordVisible ? 'text' : 'password'" placeholder="..." v-model.trim="confirmPassword" />
                <i class="icofont link icon" :class="{ 'icofont-eye-blocked': !isConfirmPasswordVisible, 'icofont-eye': isConfirmPasswordVisible }" @mouseenter="isConfirmPasswordVisible = true" @mouseleave="isConfirmPasswordVisible = false"></i>
              </div>
              <i class="icofont icofont-exclamation-circle link notify icon" v-if="!isPasswordConfirmed" title="Inserted values don't match!" />
            </div>
          </div>
          <div class="green fluid text-center button" :class="{ disabled: !isAbleToRegister }" @click="register">Register</div>
        </div>
        <div class="text divider">Or continue with</div>
        <div class="basic fluid text-center button"><img src="@/assets/google_ico.png" alt="google" />Login with Google</div>
        <div class="basic fluid text-center button"><img src="@/assets/facebook_ico.png" alt="facebook" />Login with Facebook</div>
      </div>
    </div>
  </Modal>
</template>

<script>

import Modal from './Modal.vue'
import Toast from '../data/Toast'
import RequestHandler from '../data/RequestHandler'
import { ENDPOINTS } from '../data/defaults'

const MODE_LOGIN = 1
const MODE_REGISTER = 2

export default {
  name: 'c-login-modal',
  components: {
    Modal
  },
  emits: ['close'],
  data () {
    return {
      email: null,
      login: null,
      password: null,
      confirmPassword: null,
      isPasswordVisible: false,
      isConfirmPasswordVisible: false,
      mode: MODE_LOGIN,
      MODE_LOGIN,
      MODE_REGISTER
    }
  },
  methods: {
    setMode (v) {
      this.password = null
      this.confirmPassword = null
      this.email = null
      this.mode = v
    },
    async authenticate () {
      if (!this.isAbleToLogin) return
      try {
        const data = await RequestHandler.doPostRequest(`${ENDPOINTS.auth}/login`, { login: this.login, password: this.password })
        this.$store.commit('setUser', data)
        this.$emit('close')
      } catch (e) {
        this.$store.commit('addToast', Toast.error(e))
      }
    },
    async register () {
      if (!this.isAbleToRegister) return
      try {
        const data = await RequestHandler.doPostRequest(`${ENDPOINTS.auth}/register`, { login: this.login, email: this.email, password: this.password })
        this.$store.commit('setUser', data)
        this.$emit('close')
      } catch (e) {
        this.$store.commit('addToast', Toast.error(e))
      }
    }
  },
  computed: {
    isAbleToLogin () {
      return this.login && this.password
    },
    isAbleToRegister () {
      return this.login && this.email && this.password && this.password === this.confirmPassword && this.isEmailValid
    },
    isEmailValid () {
      return !this.email || /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|.(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/.test(this.email)
    },
    isPasswordConfirmed () {
      return !this.password || !this.confirmPassword || this.password === this.confirmPassword
    }
  }
}

</script>

<style scoped lang="scss">
  .heading {
    display: flex;
    flex-flow: column;
    align-items: center;
    padding: 0 2em;
    >.flex {
      font-size: 1.4em;
      >.text {
        padding: 0 1em;
        font-weight: 500;
        &:not(:first-child) {
          border-left: 1px solid #878787;
        }
      }
    }
  }

  .segment >.content {
    width: 510px;
    padding: 0 5.4em;
    margin-top: 2.5em;
  }

  .auth.segment {
    max-width: 600px;
    padding: 2.5em 0;
    >i {
      color: var(--color-green);
      position: absolute;
      top: 12px;
      right: 12px;
      font-size: 1.5em;
    }
    box-shadow: 0 7px 0 0 var(--color-green);
  }

  .lined {
    border-bottom: 1px solid var(--color-border-secondary);
  }

  .form {
    input {
      &:focus {
        border-color: var(--color-green);
      }
    }
    .field {
      >.text {
        font-size: .92em;
        margin-top: .5em;
        margin-left: auto;
      }
      &:not(:last-child) {
        margin-bottom: 1.2em;
      }
    }
    margin-top: 1em;
    margin-bottom: 1.5em;
  }

  .divider {
    margin: 1.4em 0;
    padding: 0 .4em;
  }

  .button {
    padding: .9em;
    +.button {
      margin-top: 1em;
    }
  }

  .input.password {
    i {
      font-size: 1.5em;
      right: 0.44em;
      color: #626262;
      &.icofont-eye {
        margin-top: 1px;
      }
    }
    input {
      padding-right: 2.6em;
    }
  }
</style>
