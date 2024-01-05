<template>
  <div class="toast" :class="className" :style="{ height }">
    <div class="content">
      <div class="flex relaxed">
        <div class="fluid icon header" v-if="data.header">
          <i class="icofont" :class="data.icon" v-if="data.icon"></i>{{ data.header }}
        </div>
        <i class="link icofont icofont-close" v-if="data.closeable" @click="data.hide()"></i>
      </div>
      <div class="description">{{ data.message }}</div>
    </div>
  </div>
</template>

<script>
import Toast from '@/data/Toast'

export default {
  name: 'c-toast-item',
  props: {
    data: Toast,
  },
  data () {
    return {
      height: 'auto',
      toast: this.data
    }
  },
  mounted () {
    this.height = `${this.$el.offsetHeight}px`
    if (this.data.timeout) {
      setTimeout(() => {
        this.toast.visible = false
      }, this.toast.timeout)
    }
  },
  computed: {
    className () {
      return {
        [Toast.T_MESSAGE]: 'message',
        [Toast.T_SUCCESS]: 'success',
        [Toast.T_ERROR]: 'error'
      }[this.data.type]
    }
  }
}

</script>

<style scoped lang="scss">
  .toast {
    width: 450px;
    transform: translateX(-100%);
    border-radius: 3px;
    background: var(--color-lightgrey);
    box-shadow: inset 0 0 0 1px #ebebeb;
    margin-bottom: .5rem;
    >.content {
      padding: 1em;
    }
    .header {
      font-size: 1.2em;
    }
    .description {
      margin-top: .3rem;
      color: var(--color-font-secondary);
    }
    i.link {
      font-size: 1.2em;
    }
    &.message {
      .header {
        color: rgb(89 165 103);
      }
      // background-color: #f2f2ff;
    }
    &.success {
      .header {
        color: rgb(90 153 199);
      }
      // background-color: #f2fff2;
    }
    &.error {
      .header {
        color: rgb(205 105 105);
      }
      // background-color: #fff2f2;
    }
  }
</style>
