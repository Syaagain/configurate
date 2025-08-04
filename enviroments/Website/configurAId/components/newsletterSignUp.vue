<template>
  <div class="bg-primary-50 border border-primary-200 rounded-2xl p-8">
    <div class="max-w-md mx-auto text-center">
      <div class="w-16 h-16 bg-primary-600 rounded-full flex items-center justify-center mx-auto mb-6">
        <EnvelopeIcon class="w-8 h-8 text-white" />
      </div>
      
      <h3 class="text-2xl font-bold mb-4 text-primary-900">
        Newsletter abonnieren
      </h3>
      
      <p class="text-primary-700 mb-6 leading-relaxed">
        Erhalten Sie regelmäßig Insights zu Prozessoptimierung, neue Artikel 
        und exklusive Tipps direkt in Ihr Postfach.
      </p>
      
      <form @submit.prevent="subscribeNewsletter" class="space-y-4">
        <div class="flex flex-col sm:flex-row gap-3">
          <input
            v-model="email"
            type="email"
            required
            placeholder="Ihre E-Mail-Adresse"
            class="flex-1 px-4 py-3 border border-primary-200 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 bg-white"
            :disabled="isLoading"
          >
          <button
            type="submit"
            :disabled="isLoading || !email"
            class="btn-primary px-6 py-3 whitespace-nowrap disabled:opacity-50 disabled:cursor-not-allowed"
          >
            <span v-if="!isLoading">Abonnieren</span>
            <span v-else class="flex items-center">
              <LoadingSpinner class="w-4 h-4 mr-2" />
              Lädt...
            </span>
          </button>
        </div>
        
        <!-- Success Message -->
        <div v-if="showSuccess" class="p-4 bg-success-50 border border-success-200 rounded-lg">
          <div class="flex items-center">
            <CheckCircleIcon class="w-5 h-5 text-success-600 mr-2" />
            <p class="text-success-800 text-sm">
              Vielen Dank! Bitte bestätigen Sie Ihre Anmeldung über den Link in Ihrer E-Mail.
            </p>
          </div>
        </div>
        
        <!-- Error Message -->
        <div v-if="showError" class="p-4 bg-red-50 border border-red-200 rounded-lg">
          <div class="flex items-center">
            <ExclamationTriangleIcon class="w-5 h-5 text-red-600 mr-2" />
            <p class="text-red-800 text-sm">
              {{ errorMessage }}
            </p>
          </div>
        </div>
        
        <p class="text-xs text-primary-600 leading-relaxed">
          Mit der Anmeldung stimmen Sie unserer 
          <NuxtLink to="/datenschutz" class="underline hover:no-underline">
            Datenschutzerklärung
          </NuxtLink> zu. 
          Sie können sich jederzeit wieder abmelden.
        </p>
      </form>
      
      <!-- Benefits -->
      <div class="mt-8 grid grid-cols-1 sm:grid-cols-3 gap-4 text-sm">
        <div class="flex items-center space-x-2">
          <CalendarIcon class="w-4 h-4 text-primary-600 flex-shrink-0" />
          <span class="text-primary-700">2x pro Monat</span>
        </div>
        <div class="flex items-center space-x-2">
          <BookOpenIcon class="w-4 h-4 text-primary-600 flex-shrink-0" />
          <span class="text-primary-700">Exklusive Inhalte</span>
        </div>
        <div class="flex items-center space-x-2">
          <XCircleIcon class="w-4 h-4 text-primary-600 flex-shrink-0" />
          <span class="text-primary-700">Jederzeit kündbar</span>
        </div>
      </div>
      
      <!-- Social Proof -->
      <div class="mt-6 pt-6 border-t border-primary-200">
        <div class="flex items-center justify-center space-x-4 text-sm text-primary-600">
          <div class="flex items-center space-x-2">
            <UserGroupIcon class="w-4 h-4" />
            <span>{{ subscriberCount }}+ Abonnenten</span>
          </div>
          <div class="w-1 h-1 bg-primary-400 rounded-full"></div>
          <div class="flex items-center space-x-2">
            <StarIcon class="w-4 h-4" />
            <span>4.9/5 Sterne</span>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import {
  EnvelopeIcon,
  CheckCircleIcon,
  ExclamationTriangleIcon,
  CalendarIcon,
  BookOpenIcon,
  XCircleIcon,
  UserGroupIcon,
  StarIcon
} from '@heroicons/vue/24/outline'

// Props
const props = defineProps({
  size: {
    type: String,
    default: 'default' // 'compact', 'default', 'large'
  },
  theme: {
    type: String,
    default: 'primary' // 'primary', 'neutral', 'success'
  }
})

// State
const email = ref('')
const isLoading = ref(false)
const showSuccess = ref(false)
const showError = ref(false)
const errorMessage = ref('')

// Computed
const subscriberCount = computed(() => {
  // In a real app, this would come from your newsletter service API
  return '1,250'
})

// Loading Spinner Component
const LoadingSpinner = {
  template: `
    <svg class="animate-spin" fill="none" viewBox="0 0 24 24">
      <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
      <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
    </svg>
  `
}

// Methods
const subscribeNewsletter = async () => {
  if (!email.value || isLoading.value) return
  
  isLoading.value = true
  showSuccess.value = false
  showError.value = false
  errorMessage.value = ''
  
  try {
    // Validate email format
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
    if (!emailRegex.test(email.value)) {
      throw new Error('Bitte geben Sie eine gültige E-Mail-Adresse ein.')
    }
    
    // In a real implementation, you would call your newsletter API
    // const response = await $fetch('/api/newsletter', {
    //   method: 'POST',
    //   body: { email: email.value }
    // })
    
    // Simulate API call
    await new Promise(resolve => setTimeout(resolve, 1500))
    
    // Simulate success (90% success rate for demo)
    if (Math.random() > 0.1) {
      showSuccess.value = true
      email.value = ''
      
      // Track newsletter signup (Google Analytics, etc.)
      if (typeof gtag !== 'undefined') {
        gtag('event', 'newsletter_signup', {
          event_category: 'engagement',
          event_label: 'newsletter_form'
        })
      }
      
      // Auto-hide success message after 5 seconds
      setTimeout(() => {
        showSuccess.value = false
      }, 5000)
      
    } else {
      // Simulate error
      throw new Error('Diese E-Mail-Adresse ist bereits registriert.')
    }
    
  } catch (error) {
    showError.value = true
    errorMessage.value = error.message || 'Ein Fehler ist aufgetreten. Bitte versuchen Sie es später erneut.'
    
    // Auto-hide error message after 5 seconds
    setTimeout(() => {
      showError.value = false
    }, 5000)
    
  } finally {
    isLoading.value = false
  }
}

// Emit events for parent components
const emit = defineEmits(['subscribe-success', 'subscribe-error'])

// Watch for success/error to emit events
watch(showSuccess, (newValue) => {
  if (newValue) {
    emit('subscribe-success', email.value)
  }
})

watch(showError, (newValue) => {
  if (newValue) {
    emit('subscribe-error', errorMessage.value)
  }
})
</script>

<style scoped>
/* Custom animations */
@keyframes spin {
  to { transform: rotate(360deg); }
}

.animate-spin {
  animation: spin 1s linear infinite;
}

/* Theme variations could be added here */
.newsletter-compact {
  /* Styles for compact variant */
}

.newsletter-large {
  /* Styles for large variant */
}
</style>