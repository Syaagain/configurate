<template>
  <div class="min-h-screen flex flex-col">
    <AppHeader />
    <main class="flex-grow">
      <slot />
    </main>
    <AppFooter />
    <CookieBanner />
  </div>
</template>

<script setup>
// Layout für die gesamte Website
</script>