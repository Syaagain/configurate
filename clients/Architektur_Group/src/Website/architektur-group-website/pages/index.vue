<template>
  <div>
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
    
    <ShowroomContact />
  </div>
</template>

<script setup>
import HeroSection from '~/components/heroSection.vue'
import ColumnAnimation from '~/components/columnAnimation.vue'
import ParallaxSlider from '~/components/parallaxSlider.vue'
import ShowroomContact from '~/components/showroomContact.vue'
</script>