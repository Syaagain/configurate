<template>
  <div class="app-wrapper">
    <AppHeader />
    <main>
      <slot />
    </main>
    <AppFooter />
  </div>
</template>

<script setup>
import AppHeader from '~/components/appHeader.vue'
import AppFooter from '~/components/appFooter.vue'
</script>

<style scoped>
.app-wrapper {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

main {
  flex: 1;
}
</style>