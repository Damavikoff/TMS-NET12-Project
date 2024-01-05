<template>
  <div class="pagination">
    <div class="boxed button" v-for="n in count" :key="n" :class="{ green: currentPage === n, basic: currentPage !== n }" @click="setPage(n)">{{ n }}</div>
  </div>
</template>

<script>

export default {
  name: 'c-pagination',
  emits: ['update'],
  props: {
    count: Number,
    page: Number
  },
  computed: {
    currentPage () {
      return this.page + 1
    }
  },
  methods: {
    setPage (v) {
      this.$emit('update', v - 1)
    }
  }
}

</script>

<style scoped lang="scss">
  .pagination {
    border-top: 1px solid var(--color-border-secondary);
    padding-top: 1em;
    display: flex;
    gap: .7em;
    &.right {
      justify-content: end;
    }
    >.button {
      &.basic {
        font-weight: 400;
        box-shadow: inset 0 0 0 1px var(--color-border-secondary);
      }
    }
  }
</style>
