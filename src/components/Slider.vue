<template>
  <div class="secondary slider segment">
    <div class="h-full container" :style="style" :class="{ inactive }" ref="container">
      <div class="slide" v-for="(v, k) in frames" :key="k">
        <div class="flex content">
          <div class="bolder uppercase header">
            <div class="content" v-html="v.text"></div>
          </div>
          <div class="large description">{{ v.description }}</div>
          <div class="actions">
            <button class="large green button" v-for="(a, i) in v.actions" :key="i">{{ a }}</button>
          </div>
        </div>
        <div class="image" :style="{ '--image': `url('${v.src}')` }" v-if="v.image"></div>
      </div>
    </div>
    <div class="dots">
      <span class="dot" v-for="(v, k) in data.length" :key="k" :class="{ active: index === k }" @click="setFrame(k)"></span>
    </div>
  </div>
</template>

<script>
import SlideItem from '../data/SlideItem';
import { animate } from '../data/utils'

export default {
  name: 'main-slider',
  props: {
    data: Array[SlideItem]
  },
  data () {
    return {
      index: 0,
      duration: 400,
      running: false,
      inactive: false,
      left: 0
    }
  },
  mounted () {
    setInterval(this.shift, 8000)
  },
  methods: {
    shift () {
      this.setFrame(this.index === this.data.length - 1 ? 0 : this.index + 1)
    },
    async setFrame (i) {
      if (this.running) return
      this.toggleState()
      const shifted = !i && this.index === this.data.length - 1
      const diff = (shifted ? 1 : i - this.index) * 100
      const target = this.left + diff
      this.index = i
      await animate({
        timing: this.inOutQuad,
        callback: (v) => {
          this.left = target - (diff * (1 -v))
        },
        duration: 1000
      })
      if (shifted) {
        this.left = 0
      }
      this.toggleState()
    },
    toggleState () {
      this.running = !this.running
    },
    inOutQuad (n) {
      n *= 2
      if (n < 1) return 0.5 * n * n
      return - 0.5 * (--n * (n - 2) - 1)
    }
  },
  computed: {
    frames () {
      return [...this.data, this.data[0]]
    },
    style () {
      return {
        left: `-${this.left}%`
      }
    },
    animation () {
      return [
        { left: `-${this.left}%` }
      ]
    }
  }
}
</script>

<style scoped lang="scss">
  .slider {
    min-height: 400px;
    background-color: var(--color-lightgrey);
    overflow: hidden;
    >.container {
      display: flex;
      max-width: 100%;
    }
    >.dots {
      margin: -1em 0 1em 0;
      display: flex;
      gap: .5em;
      justify-content: center;
      >.dot {
        cursor: pointer;
        width: 8px;
        height: 8px;
        border-radius: 50%;
        background-color: rgba(70, 163, 88, 0.3);
        &.active {
          background-color: var(--color-green);
        }
      }
    }
    .slide {
      width: 100%;
      padding: 2em;
      display: grid;
      grid-template: 1fr / 60% 40%;
      flex-shrink: 0;
      >.image {
        background-image: var(--image);
        background-origin: border-box;
        background-repeat: no-repeat;
        background-position-y: center;
        background-position-x: right;
        background-size: contain;
        margin: 2.4em;
      }
      >.content {
        flex-direction: column;
        justify-content: center;
        .header {
          font-size: 3.8em;
          line-height: 1;
        }
        .description {
          margin-top: 1em;
          color: var(--color-font-secondary);
        }
        .actions {
          margin-top: 2em;
        }
      }
    }
  }
</style>
