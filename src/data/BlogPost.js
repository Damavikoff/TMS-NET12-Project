import { PATH_IMAGE_BLOG_POSTS, PATH_IMAGE_DEFAULT } from "./defaults"
import DateFormatter from "./DateFormatter"

export class BlogPostItem {
  constructor (props) {
    this.id = null
    this.title = null
    this.description = null
    this.created = null
    this.image = null
    Object.assign(this, props)
    this.created = this.created instanceof Date ? this.created : new Date(this.created)
  }

  get src () {
    return this.image ? `${PATH_IMAGE_BLOG_POSTS}/${this.image}` : `${PATH_IMAGE_DEFAULT}`
  }

  get date () {
    return DateFormatter.format(this.created, 'dd-mm-yyyy hh:mi')
  }
}

export const BLOG_POSTS = [
  new BlogPostItem({
    title: 'The Ultimate Guide to Indoor Gardening: Tips & Tricks for Thriving Plants',
    description: 'Discover the secrets to creating a flourishing indoor garden. From choosing the right plants and containers to mastering watering techniques and ensuring proper sunlight, this guide will help you transform your home into a green oasis',
    image: 'post-1.png',
    created: new Date('11/15/2023 15:32')
  }),
  new BlogPostItem({
    title: '10 Low-Maintenance Houseplants for Busy People',
    description: 'Don\'t let a hectic schedule deter you from enjoying the beauty of plants. Explore our curated list of low-maintenance houseplants that will thrive even if you forget to water them occasionally. Bring nature indoors without adding any additional stress to your life.',
    image: 'post-2.jpg',
    created: new Date('11/07/2023 11:40')
  }),
  new BlogPostItem({
    title: 'Unleashing the Power of Plants: How Greenery Boosts Mental Health',
    description: 'Did you know that being around plants can have a significant positive impact on your mental health? In this article, we\'ll delve into the fascinating world of horticultural therapy and explore the various ways in which plants can improve your well-being and reduce stress.',
    image: 'post-3.jpg',
    created: new Date('11/04/2023 16:14')
  }),
  new BlogPostItem({
    title: 'From Seed to Harvest: A Beginner\'s Guide to Growing Your Own Vegetable Garden',
    description: 'Have you always dreamt of growing your own fresh vegetables but didn\'t know where to start? Look no further! This comprehensive guide will teach you everything you need to know, from preparing the soil and selecting the right vegetables to understanding when and how to harvest your crops. Get ready to savor the delicious rewards of your hard work.',
    image: 'post-4.jpg',
    created: new Date('10/29/2023 09:48')
  })
]
