<template>
  <div class="search icon input" @mousedown.stop="focus" :class="{ active: focused || hovered }" @mouseenter="hover" @mouseleave="hover(false)">
    <input type="text" :placeholder="placeholder" v-model.lazy="value" @blur="focus(false)" />
    <i class="link icofont icofont-search-1"></i>
  </div>
</template>

<script>

export default {
  name: 'search-input',
  props: {
    modelValue: String,
    placeholder: {
      type: String,
      default: '...'
    }
  },
  emits: ['update:modelValue'],
  data () {
    return {
      hovered: false,
      focused: false
    }
  },
  computed: {
    value: {
      get () {
        return this.modelValue
      },
      set (value) {
        this.$emit('update:modelValue', value)
      }
    }
  },
  methods: {
    focus (value = true) {
      this.focused = value
    },
    hover (value = true) {
      this.hovered = value
    }
  }
}

</script>

<style scoped lang="scss">
  .input {
    >input {
      padding: .6em 1em;
      width: 16em;
      opacity: 1;
      transition: all .4s ease;
    }
    &:not(.active) {
      border-color: transparent;
      >input {
        opacity: 0;
        width: 0;
      }
    }
  }
</style>
