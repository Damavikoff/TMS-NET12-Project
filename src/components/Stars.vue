<template>
  <div class="stars" :class="{ editable }">
    <i class="icofont icofont-star" v-for="n in count" :key="n" :class="{ active: n <= value }" @mouseenter="setHover(n)" @mouseleave="setHover(null)" @mousedown="setValue(n)"></i>
  </div>
</template>

<script>

export default {
  name: 'c-stars',
  components: {
  },
  props: {
    modelValue: Number,
    editable: Boolean,
    count: {
      type: Number,
      default: 5
    }
  },
  emits: ['update:modelValue'],
  data () {
    return {
      hoverValue: null
    }
  },
  methods: {
    setHover(v) {
      if (!this.editable) return
      this.hoverValue = v
    },
    setValue (v) {
      if (!this.editable) return
      this.$emit('update:modelValue', v)
    }
  },
  computed: {
    value () {
      return this.hoverValue || Math.round(this.modelValue)
    }
  }
}

</script>

<style scoped lang="scss">
  .stars {
    &.editable {
      cursor: pointer;
    }
    >i {
      padding: 0 1px;
      color: rgba(70, 70, 70, .2);
      &.active {
        color: rgba(255, 172, 12, .8);
      }
    }
  }
</style>
