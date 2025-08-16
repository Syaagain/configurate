<template>
  <div>
    <!-- Desktop Version -->
    <template v-if="!isMobile">
      <HeroSection />
      
      <section class="intro-section py-20">
        <div class="container mx-auto px-6 text-center">
          <h2 class="text-5xl font-light mb-8">EXKLUSIVES NATURSTEIN DESIGN</h2>
          <p class="text-xl text-gray-300 max-w-3xl mx-auto">
            Entdecken Sie über 200 verschiedene Naturstein- und Keramik-Oberflächen –
            von edlem Marmor bis zu innovativem High-Tech Feinsteinzeug.
          </p>
        </div>
      </section>
      
      <ColumnAnimation />
      
      <section class="cta-section py-20 bg-gradient-to-r from-gray-900 to-black">
        <div class="container mx-auto px-6 text-center">
          <h2 class="text-4xl font-light mb-8">LASSEN SIE SICH INSPIRIEREN</h2>
          <NuxtLink to="/sortiment" class="inline-block px-8 py-3 border border-white text-white hover:bg-white hover:text-black transition duration-300">
            MEHR ERFAHREN
          </NuxtLink>
        </div>
      </section>
      
      <ParallaxSlider />
      
      <LocationsMap />
    </template>
    
    <!-- Mobile Version -->
    <template v-else>
      <MobileHero />
      
      <!-- Mobile Intro Section -->
      <section class="intro-section py-12">
        <div class="container mx-auto px-4 text-center">
          <h2 class="text-3xl font-light mb-6">EXKLUSIVES NATURSTEIN DESIGN</h2>
          <p class="text-base text-gray-300">
            Entdecken Sie über 200 verschiedene Naturstein- und Keramik-Oberflächen.
          </p>
        </div>
      </section>
      
      <!-- Mobile Products Showcase -->
      <MobileProducts />
      
      <!-- Mobile Gallery -->
      <MobileGallery />

      <!-- Mobile CTA Section -->
      <section class="cta-section py-12 bg-gradient-to-r from-gray-900 to-black">
        <div class="container mx-auto px-4 text-center">
          <h2 class="text-2xl font-light mb-6">LASSEN SIE SICH INSPIRIEREN</h2>
          <NuxtLink to="/sortiment" class="inline-block px-6 py-2 border border-white text-white text-sm">
            MEHR ERFAHREN
          </NuxtLink>
        </div>
      </section>
      
      <!-- Mobile Interactive Map -->
      <MobileInteractiveMap />
      
      <!-- Mobile Video Player (optional) -->
      <MobileVideoPlayer v-if="showVideo" />
      
    </template>
  </div>
</template>

<script setup>
// Desktop Components
import HeroSection from '~/components/website/heroSection.vue'
import ColumnAnimation from '~/components/website/columnAnimation.vue'
import ParallaxSlider from '~/components/website/parallaxSlider.vue'

// Mobile Components
import MobileHero from '~/components/mobile/mobileHero.vue'
import MobileProducts from '~/components/mobile/mobileProducts.vue'
import MobileGallery from '~/components/mobile/mobileGallery.vue'
import MobileInteractiveMap from '~/components/mobile/mobileInteractiveMap.vue'
import MobileContactPremium from '~/components/mobile/mobileContactPremium.vue'
import MobileVideoPlayer from '~/components/mobile/mobileVideoPlayer.vue'

// Device Detection
import { useDevice } from '~/composables/useDevice'
import LocationsMap from '~/components/website/locationsMap.vue'
const { isMobile } = useDevice()

// Optional: Control video display
const showVideo = ref(false)
</script>

<style scoped>
.contact-cta-section {
  position: relative;
  overflow: hidden;
}

.contact-cta-section::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: linear-gradient(45deg, rgba(255,255,255,0.05) 0%, transparent 50%, rgba(255,255,255,0.05) 100%);
  pointer-events: none;
}

.mobile-contact-cta {
  position: relative;
}

@media (max-width: 768px) {
  .mobile-contact-cta .container {
    padding-left: 1rem;
    padding-right: 1rem;
  }
}
</style>