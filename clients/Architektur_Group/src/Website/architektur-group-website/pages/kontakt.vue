<template>
  <div class="kontakt-page min-h-screen bg-black pt-24">
    <!-- Desktop Version -->
    <template v-if="!isMobile">
      <div class="container mx-auto px-6 py-12">
        <h1 class="text-4xl font-light text-center mb-12">KONTAKT</h1>
        <div class="max-w-2xl mx-auto">
          <p class="text-center text-gray-300 mb-12">
            Hinterlassen Sie Ihre Kontaktdaten, wir melden uns umgehend bei Ihnen.
          </p>
          <ContactForm />
        </div>
      </div>
    </template>
    
    <!-- Mobile Version -->
    <template v-else>
      <div class="container mx-auto px-4 py-8">
        <h1 class="text-3xl font-light text-center mb-8">KONTAKT</h1>
        
        <!-- Mobile Contact Premium Component -->
        <MobileContactPremium />
        
        <!-- Optional: Mobile AR View für Showroom -->
        <div class="mt-8">
          <h2 class="text-xl font-light text-center mb-4">Virtueller Showroom</h2>
          <MobileARView />
        </div>
      </div>
    </template>
  </div>
</template>

<script setup>
// Desktop Components
import ContactForm from '~/components/website/contactForm.vue'

// Mobile Components
import MobileContactPremium from '~/components/mobile/mobileContactPremium.vue'
import MobileARView from '~/components/mobile/mobileARView.vue'

// Device Detection
import { useDevice } from '~/composables/useDevice'
const { isMobile } = useDevice()
</script>