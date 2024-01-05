import { PATH_IMAGE } from './defaults'

export default class SlideItem {
  constructor (props) {
    this.title = null
    this.description = null
    this.actions = []
    this.image = null
    this.marks = []
    Object.assign(this, props)
  }

  get src () {
    if (!this.image) return null
    return `${PATH_IMAGE}/${this.image}`
  }

  get text () {
    return this.title.split(' ').map((v, i) => this.marks.includes(i) ? `<span class="green text">${v}</span>` : v).join(' ')
  }
}

export const SLIDES = [
  new SlideItem({
    title: 'Create a serene oasis with elegant houseplants',
    description: 'Elevate your living space with our selection of elegant houseplants. From classic favorites like the peace lily to exotic varieties such as the fiddle leaf fig, we have the perfect plant to suit your style. Enhance the ambiance of your home and experience the calming effects of nature\'s beauty.',
    actions: ['Explore Collection'],
    image: 'slide-11.png',
    marks: [3]
  }),
  new SlideItem({
    title: 'Transform your space with vibrant succulents',
    description: 'Bring nature indoors with our collection of stunning succulents. These low-maintenance plants are perfect for any space, whether you\'re a seasoned plant lover or just starting out. Explore our wide variety of shapes, colors, and sizes and add a touch of greenery to your home or office.',
    actions: ['Shop Now'],
    image: 'slide-10.png',
    marks: [5]
  }),
  new SlideItem({
    title: 'Brighten up your garden with colorful flower seeds',
    description: 'Unleash your creativity in the garden with our wide range of stunning flower seeds. From vibrant sunflowers to delicate roses, our selection has something for every gardener. Discover endless possibilities to enhance your outdoor space and create a colorful symphony of blooms.',
    actions: ['Get Planting Tips'],
    image: 'slide-12.png',
    marks: [5]
  })
]
