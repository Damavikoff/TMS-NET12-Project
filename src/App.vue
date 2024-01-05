<template>
  <RouterView />
  <ToastContainer :data="toasts" />
</template>

<script>
  import { RouterView } from 'vue-router';
  import { mapGetters } from 'vuex';
  import ToastContainer from '@/components/ToastContainer.vue'

  export default {
    name: 'app',
    components: {
      RouterView,
      ToastContainer
    },
    computed: {
      ...mapGetters(['toasts'])
    }
  }
</script>
