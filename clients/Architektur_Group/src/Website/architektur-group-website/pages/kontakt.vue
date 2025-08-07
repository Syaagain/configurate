<template>
  <div class="kontakt-page min-h-screen bg-black pt-24">
    <div class="container mx-auto px-6 py-12">
      <h1 class="text-4xl font-light text-center mb-12">KONTAKT</h1>
      
      <div class="max-w-2xl mx-auto">
        <p class="text-center text-gray-300 mb-12">
          Hinterlassen Sie Ihre Kontaktdaten, wir melden uns umgehend bei Ihnen.
        </p>
        
        <ContactForm />
      </div>
    </div>
  </div>
</template>

<script setup>
import ContactForm from '~/components/contactForm.vue'
</script>