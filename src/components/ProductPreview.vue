<template>
  <Loader v-if="!ready || !product" class="fixed" />
  <template v-else-if="product">
    <div class="product">
      <nav class="navigation">
        <RouterLink to="/" custom v-slot="{ navigate }">
          <span @click="navigate" class="bold link text">Catalog</span>
        </RouterLink>
        / <span class="text">{{ product.title }}</span>
      </nav>
      <section class="main">
        <ImagePreview :data="productImages" />
        <div class="content">
          <div class="flex relaxed centered">
            <div class="fluid header">{{ product.title }}</div>
            <div class="flex centered relaxed score" v-if="product.reviews.length">
              <Stars class="larger" :modelValue="product.averageScore" />
              <span class="secondary text">{{ product.reviews.length }} Customer Reviews</span>
            </div>
          </div>
          <div class="flex centered meta">
            <div class="price flex centered fluid">
              <span class="green bold text">{{ product.totalPriceLabel }}</span>
              <span class="bold discount" v-if="product.discount">{{ product.discount }}% OFF</span>
            </div>
          </div>
          <div class="divider"></div>
          <div class="description">
            <div class="title">Short Description:</div>
            <div class="text-justify content">
              <span class="ghost text">{{ product.shortDescription }}</span>
            </div>
          </div>
          <div class="description" v-if="product.sizes.length">
            <div class="title">Size:</div>
            <div class="flex relaxed centered content">
              <div class="boxed round link label" :class="{ green: size === v }" v-for="(v, k) in product.sizes" :key="k" @click="size = v">{{ v.label }}</div>
            </div>
          </div>
          <div class="relaxed description">
            <div class="flex centered widely relaxed content">
              <div class="flex centered counter">
                <div class="boxed round icon green button" @click="count = Math.max(1, count - 1)">
                  <i class="icofont icofont-minus"></i>
                </div>
                <span class="text-center label">{{ count }}</span>
                <div class="boxed round icon green button" @click="count++">
                  <i class="icofont icofont-plus"></i>
                </div>
              </div>
              <div class="green capitalize button" @click="addToCart(true)">Buy Now</div>
              <div class="green capitalize basic button" @click="addToCart()">Add To Cart</div>
            </div>
          </div>
          <div class="description">
            <p><span class="ghost text"><span class="secondary text">SKU: </span>{{ product.sku }}</span></p>
            <p><span class="ghost text"><span class="secondary text">Category: </span>{{ product.category.title }}</span></p>
            <p><span class="ghost text"><span class="secondary text">Tags: </span>{{ tags }}</span></p>
          </div>
          <div class="flex centered relaxed description">
            <span class="bold text">Share this product:</span>
            <div class="flex centered relaxed">
              <i class="icofont link icofont-facebook"></i>
              <i class="icofont link icofont-linkedin"></i>
              <i class="icofont link icofont-twitter"></i>
              <i class="icofont link icofont-instagram"></i>
            </div>
          </div>
        </div>
      </section>
      <section class="extra">
        <div class="medium lined horizontal menu">
          <div class="link item" :class="{ active: activeTab === tabs.TAB_DESCRIPTION }" @click="setTab(tabs.TAB_DESCRIPTION)">Product Description</div>
          <div class="link item" :class="{ active: activeTab === tabs.TAB_REVIEWS }" @click="setTab(tabs.TAB_REVIEWS)">Reviews ({{ product.reviews.length }})</div>
        </div>
        <div class="content">
          <div class="description" v-if="activeTab === tabs.TAB_DESCRIPTION">
            <p v-for="(v, k) in descriptionLines" :key="k">
              <span class="ghost secondary text">{{ v }}</span>
            </p>
          </div>
          <div class="reviews" v-if="activeTab === tabs.TAB_REVIEWS">
            <div class="list" v-if="product.reviews.length">
              <UserReview v-for="(v, k) in product.reviews" :key="k" :data="v" />
            </div>
            <div class="feedback">
              <div class="header">Leave As Feedback</div>
              <div class="form">
                <div class="required name field" v-if="!user">
                  <label>Your Name</label>
                  <input type="text" placeholder="..." v-model="review.name" />
                </div>
                <div class="field">
                  <textarea rows="10" placeholder="Put your thoughts here..." v-model="review.description"></textarea>
                </div>
                <div class="field flex centered justify-end widely relaxed">
                  <Stars class="large" v-model="review.score" editable />
                  <div class="green wide button" :class="{ disabled: !isAbleSendReview }" @click="sendReview">Submit</div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
      <section class="related" v-if="product.related.length">
        <div class="green header">Related Products</div>
        <div class="divider"></div>
        <div class="grid">
          <ProductCard class="basic compact" :data="v" v-for="v in product.related" :key="v.id" @click="openCard(v)" />
        </div>
      </section>
    </div>
  </template>
</template>

<script>
import { RouterLink } from 'vue-router'
import { mapGetters } from 'vuex'

import Review from '../data/Review'
import { ENDPOINTS, TIMEOUT } from '../data/defaults'
import RequestHandler from '../data/RequestHandler'
import Product from '../data/Product'
import Loader from './Loader.vue'
import ImagePreview from './imagepreview.vue'
import UserReview from './UserReview.vue'
import Stars from './Stars.vue'
import ProductCard from './ProductCard.vue'

export default {
  name: 'product-preview',
  components: {
    Loader,
    ImagePreview,
    RouterLink,
    Stars,
    UserReview,
    ProductCard
  },
  props: {
  },
  emits: [],
  data () {

    const TAB_DESCRIPTION = 1
    const TAB_REVIEWS = 2

    return {
      ready: true,
      product: null,
      size: null,
      count: 1,
      tabs: {
        TAB_DESCRIPTION,
        TAB_REVIEWS
      },
      activeTab: TAB_DESCRIPTION,
      review: new Review({ score: 5 })
    }
  },
  async created () {
    await this.load()
  },
  methods: {
    async addToCart (redirect = false) {
      if (redirect && this.cart.some(v => v.size === this.size.id && v.product.id === this.product.id)) {
        this.$router.push('/cart')
        return
      }
      try {
        const item = { product: this.product.id, amount: this.count, size: this.size.id }
        const data = await RequestHandler.doPostRequest(ENDPOINTS.cart, item)
        this.count = 1
        this.$store.commit('setCart', data)
        if (redirect) {
          this.$router.push('/cart')
        }
      } catch (e) {
        this.handleStateError(e)
      } finally {
        this.ready = true
      }
    },
    async sendReview () {
      if (!this.isAbleSendReview) return
      try {
        const data = await RequestHandler.doPostRequest(ENDPOINTS.feedback.replace('{id}', this.product.id), this.review)
        this.product.reviews.unshift(new Review(data))
        this.review.clear()
      } catch (e) {
        this.handleStateError(e)
      } finally {
        this.ready = true
      }
    },
    setTab (tab) {
      this.activeTab = tab
    },
    async load () {
      const timeout = setTimeout(() => this.ready = false , TIMEOUT)
      try {
        const id = this.$route.params.id
        const data = await RequestHandler.doGetRequest(`${ENDPOINTS.products}/${id}`)
        this.product = new Product(data)
        this.size = this.product.sizes[0] ?? null
      } catch (e) {
        this.handleStateError(e)
      } finally {
        this.ready = true
        clearTimeout(timeout)
      }
    },
    async openCard (v) {
      await this.$router.push(`${ENDPOINTS.product}/${v.id}`)
    }
  },
  computed: {
    ...mapGetters(['cart', 'user']),
    isReviewFormFulfilled () {
      const { name, description } = this.reviewForm
      return (this.user || name) && description
    },
    productImages () {
      return this.product?.images ?? []
    },
    tags () {
      return this.product.tags.map(v => v.title).join(', ')
    },
    descriptionLines () {
      return this.product.description.split(/\r?\n/)
    },
    isAbleSendReview () {
      const { description, name } = this.review
      return description?.trim() && (name?.trim() || this.user)
    }
  }
}

</script>

<style scoped lang="scss">
  .product {
    margin-bottom: 1.1rem;
    .main {
      display: grid;
      grid-template: 1fr / 1fr 1fr;
      gap: 2rem;
      margin-bottom: 2em;
      .meta {
        margin: 1em 0;
        margin-top: .7em;
        .price {
          font-size: 1.4em;
          >span {
            margin-right: .6em;
          }
        }
      }
      .divider {
        border-color: var(--color-lightgreen);
        margin: 0;
      }
    }
    .reviews {
      .list {
        padding-top: .5rem;
        padding-left: .6rem;
        border-bottom: 1px solid rgba(60, 60, 60, .1);
        padding-bottom: 2em;
      }
      .feedback {
        >.header {
          margin: .7em 0 .7em 0;
        }
        .form {
          width: 50%;
          .button {
            width: 7em;
            text-align: center;
          }
        }
      }
    }
    .related {
      margin: 1rem 0;
      margin-top: 3em;
      >.divider {
        margin-top: .7em;
      }
      >.header {
        font-size: 1.22em;
      }
      >.grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(14em, 1fr));
        gap: 1.2em;
      }
    }
    .discount {
      color: white;
      background: #d0534d;
      font-size: 0.75em;
      border-radius: 2px;
      padding: 0.14rem 0.4rem;
    }

    .description {
      font-size: 1.1em;
      margin-top: 1em;
      >.title {
        font-weight: 600;
        margin-bottom: .5em;
      }
      >.content {
        .text {
          color: var(--color-font-secondary);
          line-height: 1.5;
        }
      }
      &.relaxed {
        margin: 1.5em 0;
      }
      >p {
        margin: .5em 0;
      }
    }
  }
  
  .icofont-plus {
    font-size: .85em;
  }

  .counter {
    >.label {
      width: 3.4em;
    }
  }

  .capitalize.button {
    width: 7.8em;
    text-align: center;
  }

  p {
    line-height: 1.4;
  }
</style>
