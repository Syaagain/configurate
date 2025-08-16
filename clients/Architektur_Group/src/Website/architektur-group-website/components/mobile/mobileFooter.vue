<template>
  <footer class="bg-black border-t border-gray-800">
    <!-- Social Media Section -->
    <div class="px-6 py-8 border-b border-gray-800">
      <div class="text-center mb-6">
        <h3 class="text-xl font-light uppercase tracking-wider text-white mb-4">
          Folge uns
        </h3>
        <SocialIcons />
      </div>
    </div>

    <!-- Newsletter Section -->
    <div class="px-6 py-8 border-t border-gray-800">
      <div class="text-center mb-6">
        <h3 class="text-xl font-light uppercase tracking-wider text-white mb-4">
          Newsletter
        </h3>
        <p class="text-gray-400 text-sm mb-6">
          Erhalten Sie exklusive Einblicke und Updates
        </p>
      </div>
      
      <form @submit.prevent="subscribeNewsletter" class="space-y-4">
        <div class="relative">
          <input 
            type="email" 
            placeholder="Ihre E-Mail Adresse"
            v-model="email"
            class="w-full bg-transparent border-b-2 border-gray-600 px-3 py-4 text-white placeholder-gray-500 focus:outline-none focus:border-white transition-colors duration-300"
            required
          >
        </div>
        
        <button 
          type="submit" 
          class="w-full bg-white text-black py-4 px-6 font-light uppercase tracking-wider hover:bg-gray-200 transition-all duration-300 transform hover:scale-[1.02] active:scale-[0.98]"
        >
          <span class="flex items-center justify-center gap-2">
            Abonnieren
            <span class="material-icons text-lg">arrow_forward</span>
          </span>
        </button>
      </form>
    </div>

    <!-- Copyright -->
    <div class="px-6 py-6 border-t border-gray-800 bg-gray-900">
      <p class="text-center text-gray-500 text-sm leading-relaxed">
        &copy; 2025 Architektur Group<br>
        <span class="text-xs">Alle Rechte vorbehalten</span>
      </p>
    </div>
  </footer>
</template>

<script setup>
import SocialIcons from '~/components/website/socialIcons.vue'

const email = ref('')

const subscribeNewsletter = () => {
  console.log('Newsletter subscription:', email.value)
  // Hier können Sie die Newsletter-Anmeldung implementieren
  
  // Success feedback (optional)
  // showToast('Erfolgreich angemeldet!')
  
  email.value = ''
}
</script>

<style scoped>
/* Custom focus styles */
input:focus {
  box-shadow: 0 4px 12px rgba(255, 255, 255, 0.1);
}

/* Smooth transitions for all interactive elements */
* {
  transition: all 0.3s ease;
}

/* Custom button press effect */
button:active {
  transform: translateY(1px);
}

/* Enhanced mobile touch targets */
a, button, input {
  min-height: 48px;
}
</style>