<template>
  <div class="modal" @mousedown="hide">
    <div class="content">
      <slot/>
    </div>
  </div>
</template>

<script>

export default {
  name: 'c-modal',
  emits: ['close'],
  mounted () {
    setTimeout(() => {
      this.$el.classList.add('visible')
    }, 50)
  },
  methods: {
    hide (e) {
      if (e.target === this.$el) {
        this.$emit('close')
      }
    }
  }
}

</script>

<style scoped lang="scss">
  .modal {
    z-index: 1000;
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    display: flex;
    align-items: center;
    justify-content: center;
    background-color: rgba(10, 13, 18, 0.25);
    &.fixed {
      position: fixed;
    }
    >.content {
      transition: .4s all ease;
      opacity: 0;
      transform: scale(.8);
      transform-origin: center;
    }
    &.visible {
      >.content {
        opacity: 1;
        transform: scale(1);
      }
    }
  }
</style>
