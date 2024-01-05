<template>
  <div class="secondary segment vertical flex filter">
    <div class="item" v-for="(v, k) in filter.itemValues" :key="k">
      <div class="capitalize large header">{{ v.title }}</div>
      <div class="content">
        <div class="values" v-if="v.type === types.category">
          <div class="vertical flex values">
            <div class="centered flex link value" :class="{ active: j === v.index }" v-for="(i, j) in v.values" :key="j" @click="setFilterValue(v, j)">
              <span class="fluid text">{{ i.title }}</span>
              <span class="small text">({{ i.count }})</span>
            </div>
          </div>
        </div>
        <template v-else-if="v.type === types.range">
          <RangeSlider :start="v.start" :end="v.end" :min="v.min" :max="v.max" @update:end="x => { v.end = x }" @update:start="x => { v.start = x }" />
          <span class="label">{{ v.title }}:&nbsp;<span class="bold green text">{{ v.label }}</span></span>
        </template>
      </div>
    </div>
    <div class="text-right">
      <button class="green wide button" @click="filterGrid"><i class="icofont icofont-filter"></i>Filter</button>
    </div>
  </div>
</template>

<script>
import StoreFilter, { FilterItem } from '@/data/StoreFilter'
import RangeSlider from './RangeSlider.vue'
import { mapGetters } from 'vuex';

export default {
  name: 'product-filter',
  components: {
    RangeSlider
  },
  props: {
    data: StoreFilter
  },
  data () {
    return {
      filter: this.data
    }
  },
  emits: ['filter'],
  computed: {
    types () {
      return {
        category: FilterItem.T_CATEGORY,
        range: FilterItem.T_RANGE
      }
    },
    ...mapGetters(['grid'])
  },
  methods: {
    filterGrid () {
      this.grid.page = 0
      this.grid.update()
    },
    setFilterValue (item, index) {
      item.index = index
      this.$emit('filter')
    }
  }
}

</script>

<style scoped lang="scss">
  .filter {
    padding: 1em;
    min-width: 300px;
    gap: 2em;
    .item {
      >.header {
        margin-bottom: 1em;
      }
      >.content {
        padding-left: .5em;
        >.label {
          display: inline-block;
          margin-top: 1em;
          font-size: .94em;
        }
      }
      .values {
        gap: 1rem;
        font-weight: 500;
        >.value {
          &.active {
            color: var(--color-green);
          }
        }
      }
    }
  }
</style>
