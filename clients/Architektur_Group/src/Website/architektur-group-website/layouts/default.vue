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
    <!-- Mobile Bottom Sheet für Navigation -->
    <MobileBottomSheet v-else />
  </div>
</template>

<script setup>
// Desktop Components
import AppHeader from '~/components/website/appHeader.vue'
import AppFooter from '~/components/website/appFooter.vue'

// Mobile Components
import MobileHeader from '~/components/mobile/mobileHeader.vue'
import MobileBottomSheet from '~/components/mobile/mobileBottomSheet.vue'

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
</style>