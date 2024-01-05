import './assets/main.scss'
import '@icon/icofont/icofont.css'

import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import mixin from './mixin'
import directives from './directives'

const app = createApp(App)

app.use(router)
app.use(store)
app.mixin(mixin)
app.use(directives)
app.mount('#app')
