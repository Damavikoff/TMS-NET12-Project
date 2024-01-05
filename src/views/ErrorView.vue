<template>
  <div class="error vertical flex centered">
    <div class="icon header">
      <i class="icofont icofont-skull-face"></i>
      <div class="content">
        Something went wrong
        <div class="normal-case sub header">We apologize for the inconvenience. An error occurred while processing your request. Please try again later, or contact our support team for further assistance. Thank you for your understanding.</div>
      </div>
    </div>
    <div class="text center">
      <div class="green button">Go to Main Page</div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'error-view'
}

</script>

<style scoped lang="scss">
  .error {
    margin: 0 auto;
    width: 60%;
    min-width: 900px;
    min-height: 100vh;
    justify-content: center;
  }
</style>
