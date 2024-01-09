<template>
  <div class="vertical flex centered h-full justify-center">
    <div class="vertical flex items-center wrap">
      <div class="icon header">
        <i class="icofont icofont-sad"></i>
        <div class="content">
          Not Found
          <div class="normal-case sub header">Are you lost? You are not welcome here, traveler. Push the button until it's not too late.</div>
        </div>
      </div>
      <div class="green button" @click="$router.push('/')">Go to Main Page</div>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'not-found-view'
  }
</script>

<style scoped lang="scss">
  .wrap {
    max-width: 800px;
  }
  .button {
    margin-top: 1.2em;
  }
</style>
