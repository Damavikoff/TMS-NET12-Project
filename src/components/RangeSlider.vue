<template>
  <div class="range">
    <div class="selection" :style="style">
      <div class="dot left" @mousedown.prevent="setDraggable($event, handleLeftSide)"></div>
      <div class="dot right" @mousedown.prevent="setDraggable($event, handleRightSide)"></div>
    </div>
  </div>
</template>

<script>

export default {
  name: 'range-slider',
  props: {
    min: Number,
    max: Number,
    start: Number,
    end: Number
  },
  emits: ['update:start', 'update:end'],
  data () {
    return {
      isActive: false,
      handler: null,
      x: 0,
      shift: 0
    }
  },
  mounted () {
    document.addEventListener('mousemove', this.onMouseMove)
    document.addEventListener('mouseup', this.disable)
  },
  beforeUnmount () {
    document.removeEventListener('mousemove', this.onMouseMove)
    document.removeEventListener('mouseup', this.disable)
  },
  methods: {
    disable () {
      this.isActive = false
    },
    setDraggable (e, handler) {
      this.handler = handler
      this.isActive = true
      this.x = e.clientX
      this.shift = 0
    },
    handleLeftSide (e, v) {
      if (this.min === this.start && v < 0 || this.start === this.end && v > 0) {
        this.shift += v
        return
      }
      if (this.getShift(v)) return
      this.$emit('update:start', v > 0 ? Math.min(this.end, this.start + v) : Math.max(this.start + v, this.min))
    },
    handleRightSide (e, v) {
      if (this.max === this.end && v > 0 || this.end === this.start && v < 0) {
        this.shift += v
        return
      }
      if (this.getShift(v)) return
      this.$emit('update:end', v > 0 ? Math.min(this.max, this.end + v) : Math.max(this.end + v, this.start))
    },
    onMouseMove (e) {
      if (!this.isActive || !this.handler) return
      const x = e.clientX
      const relation = (x - this.x) / this.$el.offsetWidth
      const v = relation * this.range
      this.handler(e, v)
      this.x = x
    },
    getShift (v) {
      if (!this.shift || !v) return
      const s = Math.sign(this.shift)
      this.shift = s * Math.max(s * (this.shift + v), 0)
      return this.shift
    }
  },
  computed: {
    style () {
      return {
        width: `${(this.innerRange) * 100 / this.range}%`,
        left: `${(this.start - this.min) * 100 / this.range}%`
      }
    },
    range () {
      return this.max - this.min
    },
    innerRange () {
      return this.end - this.start
    }
  }
}

</script>

<style scoped lang="scss">
  .range {
    margin: 0 1.2rem;
    &::before {
      content: '';
      display: block;
      border-bottom: 4px solid var(--color-green);
      opacity: .2;
    }
    >.selection {
      width: 70px;
      position: absolute;
      top: 0;
      height: 4px;
      background-color: var(--color-green);
      >.dot {
        cursor: pointer;
        position: absolute;
        height: 1.2rem;
        width: 1.2rem;
        border-radius: 50%;
        background-color: var(--color-green);
        border: 3px solid white;
        top: 50%;
        &.left {
          left: 0;
          transform: translate(-100%, -50%);
        }
        &.right {
          right: 0;
          transform: translate(100%, -50%);
        }
      }
    }
  }
</style>
