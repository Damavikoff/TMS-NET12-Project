<template>
  <div class="toasts">
    <transition-group name="toast">
      <ToastItem v-for="v in data" :data="v" :key="v.key" />
    </transition-group>
  </div>
</template>

<script>
import Toast from '@/data/Toast'
import ToastItem from './ToastItem.vue'

export default {
  name: 'c-toast-conteiner',
  components: {
    ToastItem
  },
  props: {
    data: Array[Toast],
  }
}

</script>

<style scoped lang="scss">
  .toasts {
    z-index: 2000;
    position: fixed;
    top: .5rem;
    right: .5rem;
    bottom: 0;
    width: 0;
  }
</style>
