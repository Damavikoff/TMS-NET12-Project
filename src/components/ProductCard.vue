<template>
  <div class="secondary segment card">
    <div class="image">
      <img :src="item.src" alt="image">
    </div>
    <div class="content">
      <div class="title">{{ item.title }}</div>
      <div class="description">
        <span class="green bold text price">{{ item.totalPriceLabel }}</span>
        <span class="secondary text initial-price" v-if="item.discount">{{ item.priceLabel }}</span>
      </div>
    </div>
  </div>
</template>

<script>
import { ProductItem } from '../data/Product'

export default {
  name: 'product-card',
  components: {
  },
  props: {
    data: ProductItem
  },
  data () {
    return {
      item: this.data
    }
  },
  computed: {
  },
  methods: {
  }
}

</script>

<style scoped lang="scss">
  .card {
    overflow: visible;
    border-radius: .2rem;
    padding: .5em;
    cursor: pointer;
    >.image {
      height: 20em;
    }
    &.compact {
      >.image {
        height: 17em;
      }
    }
    >.content {
      padding: .5em;
      >.title {
        margin-bottom: .5em;
      }
      >.description {
        font-size: 1.1em;
        >.price {
          margin-right: .5em;
        }
        >.initial-price {
          text-decoration: line-through;
          opacity: 0.9;
        }
      }
    }
    transition: box-shadow .4s ease;
    &:not(.basic) {
      &::before {
        content: '';
        position: absolute;
        width: 0;
        height: 2px;
        background-color: var(--color-green);
        top: -2px;
        left: 50%;
        transform: translateX(-50%);
        transition: width .4s ease;
      }
    }
    &:hover {
      box-shadow: 0 4px 10px -3px rgba(0, 0, 0, .25);
      &.basic {
        box-shadow: 0 1px 10px -2px rgba(0, 0, 0, 0.25);
      }
      &::before {
        width: 100%;
      }
    }
  }
</style>
