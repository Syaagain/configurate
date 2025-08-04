<template>
  <div v-if="showBanner" class="fixed bottom-0 left-0 right-0 z-50 bg-white border-t border-neutral-200 shadow-2xl">
    <div class="container-custom py-4">
      <div class="flex flex-col lg:flex-row items-start lg:items-center gap-4">
        <!-- Cookie Icon & Text -->
        <div class="flex items-start space-x-3 flex-1">
          <div class="w-10 h-10 bg-primary-100 rounded-lg flex items-center justify-center flex-shrink-0">
            <CookieIcon class="w-6 h-6 text-primary-600" />
          </div>
          <div class="flex-1">
            <h3 class="font-semibold text-neutral-900 mb-2">Cookie-Einstellungen</h3>
            <p class="text-sm text-neutral-600 leading-relaxed">
              Wir verwenden Cookies, um Ihnen die bestmögliche Nutzererfahrung zu bieten. 
              Einige sind für den Betrieb der Website erforderlich, andere helfen uns bei der Analyse und Verbesserung.
              <NuxtLink to="/datenschutz" class="text-primary-600 hover:text-primary-800 underline ml-1">
                Mehr erfahren
              </NuxtLink>
            </p>
          </div>
        </div>

        <!-- Buttons -->
        <div class="flex flex-col sm:flex-row gap-3 w-full lg:w-auto">
          <button
            @click="acceptAll"
            class="btn-primary px-6 py-2 text-sm whitespace-nowrap"
          >
            Alle akzeptieren
          </button>
          <button
            @click="toggleSettings"
            class="btn-secondary px-6 py-2 text-sm whitespace-nowrap"
          >
            Einstellungen
          </button>
          <button
            @click="acceptNecessary"
            class="px-6 py-2 text-sm text-neutral-600 hover:text-neutral-800 transition-colors whitespace-nowrap"
          >
            Nur erforderliche
          </button>
        </div>
      </div>

      <!-- Detailed Settings -->
      <div v-if="showSettings" class="mt-6 pt-6 border-t border-neutral-200">
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
          
          <!-- Necessary Cookies -->
          <div class="space-y-3">
            <div class="flex items-center justify-between">
              <h4 class="font-semibold text-neutral-900">Erforderlich</h4>
              <div class="w-10 h-6 bg-green-100 rounded-full flex items-center">
                <div class="w-4 h-4 bg-green-500 rounded-full ml-5"></div>
              </div>
            </div>
            <p class="text-xs text-neutral-600">
              Für den Betrieb der Website unbedingt erforderlich. Können nicht deaktiviert werden.
            </p>
            <div class="text-xs text-neutral-500">
              Session-Cookies, Sicherheit, Funktionalität
            </div>
          </div>

          <!-- Functional Cookies -->
          <div class="space-y-3">
            <div class="flex items-center justify-between">
              <h4 class="font-semibold text-neutral-900">Funktional</h4>
              <button
                @click="toggleCookieType('functional')"
                class="relative w-10 h-6 rounded-full transition-colors"
                :class="cookieSettings.functional ? 'bg-primary-600' : 'bg-neutral-300'"
              >
                <div
                  class="w-4 h-4 bg-white rounded-full transition-transform"
                  :class="cookieSettings.functional ? 'translate-x-5' : 'translate-x-1'"
                ></div>
              </button>
            </div>
            <p class="text-xs text-neutral-600">
              Verbessern die Funktionalität und ermöglichen Personalisierung.
            </p>
            <div class="text-xs text-neutral-500">
              Spracheinstellungen, Präferenzen
            </div>
          </div>

          <!-- Analytics Cookies -->
          <div class="space-y-3">
            <div class="flex items-center justify-between">
              <h4 class="font-semibold text-neutral-900">Analytisch</h4>
              <button
                @click="toggleCookieType('analytics')"
                class="relative w-10 h-6 rounded-full transition-colors"
                :class="cookieSettings.analytics ? 'bg-primary-600' : 'bg-neutral-300'"
              >
                <div
                  class="w-4 h-4 bg-white rounded-full transition-transform"
                  :class="cookieSettings.analytics ? 'translate-x-5' : 'translate-x-1'"
                ></div>
              </button>
            </div>
            <p class="text-xs text-neutral-600">
              Helfen uns zu verstehen, wie die Website genutzt wird.
            </p>
            <div class="text-xs text-neutral-500">
              Google Analytics, Hotjar, Besucherstatistiken
            </div>
          </div>

          <!-- Marketing Cookies -->
          <div class="space-y-3">
            <div class="flex items-center justify-between">
              <h4 class="font-semibold text-neutral-900">Marketing</h4>
              <button
                @click="toggleCookieType('marketing')"
                class="relative w-10 h-6 rounded-full transition-colors"
                :class="cookieSettings.marketing ? 'bg-primary-600' : 'bg-neutral-300'"
              >
                <div
                  class="w-4 h-4 bg-white rounded-full transition-transform"
                  :class="cookieSettings.marketing ? 'translate-x-5' : 'translate-x-1'"
                ></div>
              </button>
            </div>
            <p class="text-xs text-neutral-600">
              Für personalisierte Werbung und Tracking.
            </p>
            <div class="text-xs text-neutral-500">
              Google Ads, Facebook Pixel, Retargeting
            </div>
          </div>
        </div>

        <div class="flex flex-col sm:flex-row gap-3 mt-6">
          <button
            @click="saveSettings"
            class="btn-primary px-6 py-2 text-sm"
          >
            Einstellungen speichern
          </button>
          <button
            @click="toggleSettings"
            class="btn-secondary px-6 py-2 text-sm"
          >
            Schließen
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'

// Custom Cookie Icon (simplified)
const CookieIcon = {
  template: `
    <svg viewBox="0 0 24 24" fill="currentColor">
      <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-1 14H9v-2h2v2zm0-4H9V8h2v4zm4 4h-2v-2h2v2zm0-4h-2V8h2v4z"/>
    </svg>
  `
}

// State
const showBanner = ref(false)
const showSettings = ref(false)

const cookieSettings = reactive({
  necessary: true, // Always true, cannot be disabled
  functional: false,
  analytics: false,
  marketing: false
})

// Methods
const toggleSettings = () => {
  showSettings.value = !showSettings.value
}

const toggleCookieType = (type) => {
  if (type !== 'necessary') {
    cookieSettings[type] = !cookieSettings[type]
  }
}

const acceptAll = () => {
  cookieSettings.functional = true
  cookieSettings.analytics = true
  cookieSettings.marketing = true
  saveSettings()
}

const acceptNecessary = () => {
  cookieSettings.functional = false
  cookieSettings.analytics = false
  cookieSettings.marketing = false
  saveSettings()
}

const saveSettings = () => {
  // Save settings to localStorage
  const settings = {
    necessary: true,
    functional: cookieSettings.functional,
    analytics: cookieSettings.analytics,
    marketing: cookieSettings.marketing,
    timestamp: Date.now()
  }
  
  localStorage.setItem('configuraid_cookie_settings', JSON.stringify(settings))
  
  // Apply settings (in a real implementation, you would initialize/disable tracking scripts here)
  applyCookieSettings(settings)
  
  showBanner.value = false
  showSettings.value = false
}

const applyCookieSettings = (settings) => {
  // In a real implementation, you would:
  // - Initialize Google Analytics if analytics is true
  // - Initialize marketing pixels if marketing is true
  // - Set functional cookies if functional is true
  
  console.log('Cookie settings applied:', settings)
  
  // Example: Google Analytics
  if (settings.analytics && typeof gtag !== 'undefined') {
    gtag('consent', 'update', {
      'analytics_storage': 'granted'
    })
  }
  
  // Example: Marketing cookies
  if (settings.marketing) {
    // Initialize marketing tracking
  }
}

const loadSavedSettings = () => {
  try {
    const saved = localStorage.getItem('configuraid_cookie_settings')
    if (saved) {
      const settings = JSON.parse(saved)
      
      // Check if settings are older than 6 months
      const sixMonthsAgo = Date.now() - (6 * 30 * 24 * 60 * 60 * 1000)
      if (settings.timestamp && settings.timestamp > sixMonthsAgo) {
        // Apply saved settings
        cookieSettings.functional = settings.functional
        cookieSettings.analytics = settings.analytics
        cookieSettings.marketing = settings.marketing
        
        applyCookieSettings(settings)
        return true // Settings loaded
      }
    }
  } catch (error) {
    console.error('Error loading cookie settings:', error)
  }
  
  return false // No valid settings found
}

// Lifecycle
onMounted(() => {
  // Check if user has already made a choice
  const hasSettings = loadSavedSettings()
  
  // Show banner if no valid settings found
  if (!hasSettings) {
    // Delay showing banner slightly for better UX
    setTimeout(() => {
      showBanner.value = true
    }, 1000)
  }
})

// Expose method to show banner again (for settings page)
const showCookieBanner = () => {
  showBanner.value = true
}

defineExpose({
  showCookieBanner
})
</script>