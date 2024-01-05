<template>
  <div class="products" ref="main">
    <div class="h-full content">
      <Loader v-if="!grid.ready || grid.loading"/>
      <template v-if="!grid.empty">
        <div class="shift" ref="shift"></div>
        <div class="sorting">
          <span class="text">Sort by:</span>
          <Dropdown class="inline" :modelValue="sorting" :list="sortValues" @update:modelValue="setSorting" />
        </div>
        <div class="grid" ref="grid">
          <ProductCard :data="v" v-for="v in grid.list" :key="v.id" @click="openCard(v)" />
        </div>
        <GridPagination class="right" :count="grid.pages" :page="grid.page" v-if="grid.pages > 1" @update="setGridPage" />
      </template>
      <div class="pointed icon header" v-else-if="grid.ready && grid.empty">
        <i class="icofont icofont-search-stock"></i>
        <div class="content">No Results
          <div class="sub header">There are no items matching your search criteria</div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import StoreGrid from '@/data/StoreGrid.js'
import { ENDPOINTS } from '@/data/defaults'
import router from '../router'

import GridPagination from './GridPagination.vue'
import Loader from './Loader.vue'
import ProductCard from './ProductCard.vue'
import Dropdown from './Dropdown.vue'

export default {
  name: 'product-grid',
  components: {
    Loader,
    ProductCard,
    Dropdown,
    GridPagination
  },
  props: {
    data: StoreGrid
  },
  data () {
    return {
      grid: this.data
    }
  },
  created () {
    this.updateGrid()
  },
  emits: [],
  methods: {
    async setSorting (v) {
      this.grid.sorting = this.sortValues.find(e => e.value === v)?.data ?? null
      await this.grid.update()
    },
    updateGrid () {
      if (this.grid.ready) return
      try {
        this.grid.update()
      } catch (e) {
        this.handleStateError(e)
      }
    },
    openCard (v) {
      router.push(`${ENDPOINTS.product}/${v.id}`)
    },
    async setGridPage (v) {
      await this.grid.setPage(v)
      this.$refs.shift.scrollIntoView({ behavior: 'smooth' });
    }
  },
  computed: {
    sorting () {
      if (!this.grid.sorting) return null
      const { name, order } = this.grid.sorting
      return `${name}${order}`
    },
    sortValues () {
      return this.grid.sortValues.map(v => {
        const { name, order, title } = v
        return {
          value: `${name}${order}`,
          name: title,
          data: v
        }
      })
    }
  }
}

</script>

<style scoped lang="scss">
  .products {
    padding-left: 1.2rem;
    padding-bottom: 2rem;
    width: 100%;
    >.content {
      min-height: 500px;
      >.shift {
        transform: translateY(-20px);
      }
      >.grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
        gap: 1.8rem;
      }
      >.sorting {
        display: flex;
        justify-content: right;
        align-items: center;
        padding-bottom: 1em;
        >.text {
          padding-right: .2em;
        }
        >.dropdown {
          border-bottom: 2px solid rgba(200, 200, 200, .2);
        }
      }
      >.pagination {
        font-size: 1.1em;
        margin-top: 2rem;
      }
    }
  }
</style>
