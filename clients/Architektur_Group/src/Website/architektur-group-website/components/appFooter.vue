<template>
  <footer class="bg-black py-12 border-t border-gray-800">
    <div class="container mx-auto px-6">
      <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
        <div>
          <h3 class="text-lg font-light mb-4 uppercase">Folge uns</h3>
          <SocialIcons />
        </div>
        
        <div>
          <h3 class="text-lg font-light mb-4 uppercase">Showroom Düsseldorf</h3>
          <a href="tel:+4921314501055" class="text-gray-400 hover:text-white transition">
            +49 2131 4501055
          </a>
        </div>
        
        <div>
          <h3 class="text-lg font-light mb-4 uppercase">Showroom Starnberg</h3>
          <a href="tel:+4981713868770" class="text-gray-400 hover:text-white transition">
            +49 8171 3868770
          </a>
        </div>
        
        <div>
          <h3 class="text-lg font-light mb-4 uppercase">Newsletter</h3>
          <form @submit.prevent="subscribeNewsletter" class="flex gap-2">
            <input 
              type="email" 
              placeholder="E-Mail Adresse"
              v-model="email"
              class="bg-transparent border-b border-gray-600 px-2 py-1 flex-1 focus:outline-none focus:border-white transition"
            >
            <button type="submit" class="text-white hover:text-gray-300 transition">
              <span class="material-icons">arrow_forward</span>
            </button>
          </form>
        </div>
      </div>
      
      <div class="mt-12 pt-8 border-t border-gray-800 text-center text-gray-500 text-sm">
        <p>&copy; 2025 Architektur Group. Alle Rechte vorbehalten.</p>
      </div>
    </div>
  </footer>
</template>

<script setup>
import SocialIcons from '~/components/socialIcons.vue'

const email = ref('')

const subscribeNewsletter = () => {
  console.log('Newsletter subscription:', email.value)
  email.value = ''
}
</script>