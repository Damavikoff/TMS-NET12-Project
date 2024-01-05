<template>
  <div class="product-preview segment">
    <div class="images">
      <div class="expanded absolute scrolling basic">
        <div class="content">
          <div class="cursor-pointer square image" v-for="(v, k) in images" :key="k" :class="{ active: index === k }" @click="index = k">
            <div class="content">
              <img :src="v" alt="item" />
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="preview">
      <div class="square image" v-if="activeImage">
        <div class="content">
          <img :src="v" alt="item" v-for="(v, k) in images" :key="k" :class="{ active: v === activeImage }" />
        </div>
      </div>
    </div>
  </div>
</template>

<script>

export default {
  name: 'c-image-preview',
  components: {
  },
  props: {
    data: Array
  },
  data () {
    return {
      images: this.data,
      index: 0
    }
  },
  methods: {
  },
  computed: {
    activeImage () {
      return this.images[this.index]
    }
  }
}

</script>

<style scoped lang="scss">
  .product-preview {
    display: grid;
    grid-template: 1fr / 80px 1fr;
    gap: 1rem;
    border-radius: 0;
    .images {
      .content {
        display: flex;
        flex-flow: column;
        gap: .5rem;
      }
      .image {
        padding: 2px;
        border: 2px solid transparent;
        &:hover {
          border-color: var(--color-border-secondary);
        }
        &.active {
          border-color: var(--color-green);
        }
      }
    }
    .preview {
      img {
        opacity: 0;
        transition: all .5s ease;
        &.active {
          opacity: 1;
        }
      }
    }
    img, .image {
      border-radius: .2rem;
    }
  }
</style>
