<template>
  <div class="dropdown" :class="{ active }" tabindex="0" @focus="active = true" @blur="active = false">
    <div class="content flex centered">
      <span class="fluid text">{{ text }}</span>
      <i class="icofont icofont-simple-down link m-0"></i>
    </div>
    <div class="menu">
      <div class="item" v-for="(v , k) in list" :key="k" @click="setValue(v)">{{ v.name }}</div>
    </div>
  </div>
</template>

<script>

export default {
  name: 'cart-toggle',
  props: {
    modelValue: undefined,
    list: Array
  },
  emits: ['update:modelValue'],
  data () {
    return {
      active: false
    }
  },
  created () {
    if (this.list.length && !this.value) {
      this.$emit('update:modelValue', this.list[0].value)
    }
  },
  methods: {
    setValue (v) {
      this.$emit('update:modelValue', v.value)
      this.$el.blur()
    }
  },
  computed: {
    value () {
      return this.list.find(v => String(v.value ?? '') === String(this.modelValue))
    },
    text () {
      return this.value?.name ?? ''
    }
  }
}
</script>

<style scoped lang="scss">
  .dropdown {
    cursor: pointer;
    display: block;
    border: 1px solid var(--color-border-secondary);
    outline: none;
    color: var(--color-font-secondary);
    padding: 0.7em 1em;
    border-radius: 4px;
    &.inline {
      display: inline-block;
      padding: .2em .4em;
      color: inherit;
      border-radius: 0;
      border: none;
      >.content {
        >i {
          right: 0;
        }
      }
      >.menu {
        margin-top: 9px;
        border-radius: .2rem;
        box-shadow: 0 1px 7px 2px rgba(60, 60, 60, 0.1);
      }
    }
    >.content {
      >.text {
        min-width: 10em;
        min-height: 1em;
      }
      >i {
        position: absolute;
        right: -0.4em;
        top: 50%;
        transform: translateY(-50%);
        margin-top: 1px;
      }
    }
    >.menu {
      position: absolute;
      top: 100%;
      left: 0;
      width: 100%;
      z-index: 1000;
      background: white;
      transition: all .2s ease;
      transform-origin: top;
      transform: scaleY(0);
      padding: .4em;
      border-radius: 4px;
      margin-top: 0;
      border-top-left-radius: 0;
      border-top-right-radius: 0;
      box-shadow: 0 0 0 1px rgb(231, 231, 231);
      color: var(--color-font-main);
      opacity: 0;
      >.item {
        cursor: pointer;
        padding: .7em 1em;
        &:hover {
          background-color: rgba(110, 110, 110, .03);
        }
      }
    }
    &.active {
      >.menu {
        transform: scaleY(1);
        opacity: 1;
      }
    }
  }
</style>
