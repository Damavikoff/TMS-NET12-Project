<template>
  <div class="vertical flex centered h-screen justify-center">
    <div class="wrap">
      <div class="icon header">
        <i class="icofont icofont-skull-face"></i>
        <div class="content">
          Something went wrong
          <div class="normal-case sub header">We apologize for the inconvenience. An error occurred while processing your request. Please try again later, or contact our support team for further assistance. Thank you for your understanding.</div>
        </div>
      </div>
      <div class="flex" v-if="errorData">
        <div class="error">
          <div class="content h-full">
            <div class="scrolling h-full">{{ errorData }}</div>
          </div>
        </div>
      </div>
      <span class="link green text" @click="$router.push('/')"><i class="icofont icofont-long-arrow-left"></i>Go to Main Page</span>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'error-view',
  data () {
    return {
      errorData: null
    }
  },
  created () {
    this.errorData = this.error
    this.$store.commit('setError')
  },
  computed: {
    ...mapGetters(['error'])
  }
}

</script>

<style scoped lang="scss">
  .header {
    margin: .3em 0;
  }
  .wrap {
    max-width: 800px;
  }
  .link.text {
    font-size: 1.1em;
    font-weight: 500;
  }
  .error {
    margin-top: .4em;
    border-left: 4px solid #d93333;
    padding: 1em;
    font-weight: 500;
    color: #d93333;
    background-color: #fff9f9;
    width: 100%;
    margin-bottom: 1em;
    word-break: break-word;
    line-height: 1.2;
    max-height: 400px;
  }
</style>
