import DateFormatter from '../data/DateFormatter'
import { formatCurrency } from '../data/utils'

export default {
  methods: {
    handleStateError (e) {
      this.$store.commit('setError', e)
      this.$router.push('/error')
    },
    formatDate (v, f = 'dd-mm-yyyy hh:mi') {
      return DateFormatter.format(v, f)
    },
    formatCurrency (v) {
      return formatCurrency(v)
    }
  }
}
