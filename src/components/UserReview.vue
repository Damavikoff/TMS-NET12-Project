<template>
  <div class="review">
    <div class="square image" :class="{ rounded: data.user?.image, fitted: !data.user?.image }">
      <div class="content">
        <img :src="data.image" alt="img" />
      </div>
    </div>
    <div class="content">
      <div class="flex centered widely relaxed">
        <div class="header">{{ data.author }}</div>
      </div>
      <div class="flex centered relaxed meta">
        <span class="secondary ghost text">{{ data.created }}</span>
        <Stars :modelValue="data.score" />
      </div>
      <div class="description">
        <span class="secondary text">{{ data.description }}</span>
      </div>
    </div>
  </div>
</template>

<script>
import Review from '@/data/Review'
import Stars from './Stars.vue'

export default {
  name: 'c-user-review',
  components: {
    Stars
  },
  props: {
    data: Review,
  }
}

</script>

<style scoped lang="scss">
  .review {
    display: flex;
    gap: 1rem;
    padding: 1rem 0;
    &:not(:last-child) {
      border-bottom: 1px solid rgba(60, 60, 60, .1);
    }
    .header {
      font-size: 1.13em;
    }
    .meta {
      font-size: .87em;
      margin-top: .1em;
      padding-left: .2em;
      .stars {
        font-size: 1.1em;
      }
    }
    .description {
      display: inline-block;
      padding: 0.5em 0.7em;
      background: rgba(140, 140, 140, .07);
      border-radius: 0.6rem;
      margin-top: 0.5rem;
      white-space: pre-line;
      line-height: 1.34;
    }
    .image {
      width: 2.7em;
    }
  }
</style>
