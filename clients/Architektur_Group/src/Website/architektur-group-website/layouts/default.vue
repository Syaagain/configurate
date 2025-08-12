<template>
  <div class="app-wrapper">
    <!-- Desktop Header -->
    <AppHeader v-if="!isMobile" />
    <!-- Mobile Header -->
    <MobileHeader v-else />
    
    <main>
      <slot />
    </main>
    
    <!-- Desktop Footer -->
    <AppFooter v-if="!isMobile" />
    <!-- Mobile Footer -->
    <MobileFooter v-else />
  </div>
</template>

<script setup>
// Desktop Components
import AppHeader from '~/components/website/appHeader.vue'
import AppFooter from '~/components/website/appFooter.vue'

// Mobile Components
import MobileHeader from '~/components/mobile/mobileHeader.vue'
import MobileFooter from '~/components/mobile/mobileFooter.vue'

// Device Detection
import { useDevice } from '~/composables/useDevice'
const { isMobile } = useDevice()
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

/* Ensure proper spacing for mobile footer */
@media (max-width: 768px) {
  main {
    padding-bottom: 0; /* Remove any bottom padding since we now have a footer */
  }
}
</style>