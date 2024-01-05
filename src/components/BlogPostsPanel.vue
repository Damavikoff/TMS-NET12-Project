<template>
  <div class="blog-posts">
    <div class="capitalize text-center header">
      <div class="content">
        Our Blog Posts
        <div class="normal-case sub header">Stay <span class="green bold text">green</span> and informed: unveiling the latest plant news and essential care tips</div>
      </div>
    </div>
    <div class="flex widely relaxed">
      <div class="item segment" v-for="(i, k) in data" :key="k">
        <div class="image">
          <img :src="i.src" alt="image" />
        </div>
        <span class="green date text"><i class="icofont icofont-clock-time"></i>{{ i.date }}</span>
        <div class="larger header">{{ i.title }}</div>
        <div class="description">{{ i.description }}</div>
        <div class="extra">
          <span class="bold link text">Read More<i class="larger right icofont icofont-long-arrow-right"></i></span>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { BlogPostItem } from '../data/BlogPost'

export default {
  name: 'blog-post-panel',
  props: {
    data: Array[BlogPostItem]
  }
}

</script>

<style scoped lang="scss">
  .blog-posts {
    margin-top: 3em;
    >.header {
      font-size: 2em;
      margin-bottom: 1.5rem;
    }
    >.flex {
      gap: 2em;
      .item {
        width: 100%;
        >.image {
          height: 250px;
          border-radius: .3em;
        }
        >.date {
          display: inline-block;
          font-size: .9em;
          font-weight: 500;
          margin: .5em 0;
        }
        >.description {
          margin-top: .5rem;
          color: var(--color-font-secondary);
        }
        >.extra {
          margin-top: .5em;
          >.link {
            &:hover {
              color: var(--color-green);
            }
          }
        }
      }
    }
  }
</style>
