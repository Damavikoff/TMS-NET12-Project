<template>
  <main>
    <section>
      <Slider :data="slides" />
    </section>
    <section class="flex">
      <div class="wrap">
        <ProductFilter :data="grid.filter" />
      </div>
      <ProductGrid :data="grid" />
    </section>
    <section>
      <BlogPostsPanel :data="blogPosts" />
    </section>
  </main>
</template>

<script>
import { mapGetters } from 'vuex';
import { SLIDES } from '../data/SlideItem';
import Slider from '../components/Slider.vue';
import ProductFilter from '../components/ProductFilter.vue';
import BlogPostsPanel from '../components/BlogPostsPanel.vue';
import ProductGrid from '../components/ProductGrid.vue';

export default {
  name: 'shop-view',
  components: {
    Slider,
    ProductFilter,
    BlogPostsPanel,
    ProductGrid
  },
  props: {
  },
  data () {
    return {
      slides: SLIDES
    }
  },
  emits: [],
  computed: {
    ...mapGetters(['grid', 'blogPosts'])
  },
  methods: {
  }
}

</script>

<style scoped lang="scss">
  section {
    margin: 1rem 0;
  }
</style>
