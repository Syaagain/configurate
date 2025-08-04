<template>
  <div class="min-h-screen flex flex-col bg-neutral-50">
    <!-- Header -->
    <header class="bg-white shadow-sm">
      <div class="container-custom py-4">
        <NuxtLink to="/" class="flex items-center space-x-3">
          <div class="w-10 h-10 bg-gradient-to-br from-primary-900 to-primary-600 rounded-lg flex items-center justify-center">
            <span class="text-white font-bold text-xl">C</span>
          </div>
          <span class="text-2xl font-bold gradient-text">Configuraid</span>
        </NuxtLink>
      </div>
    </header>

    <!-- Main Content -->
    <main class="flex-grow flex items-center justify-center px-4">
      <div class="max-w-2xl mx-auto text-center">
        
        <!-- Error Code -->
        <div class="mb-8">
          <div class="text-8xl md:text-9xl font-bold gradient-text mb-4">
            {{ error.statusCode || '404' }}
          </div>
          <h1 class="text-2xl md:text-4xl font-bold text-neutral-900 mb-4">
            {{ getErrorTitle() }}
          </h1>
          <p class="text-lg text-neutral-600 leading-relaxed">
            {{ getErrorMessage() }}
          </p>
        </div>

        <!-- Illustration -->
        <div class="mb-8">
          <div class="relative max-w-md mx-auto">
            <!-- Animated gear illustration -->
            <div class="bg-white rounded-2xl p-8 shadow-lg border border-neutral-200">
              <div class="relative">
                <!-- Main gear -->
                <div class="w-24 h-24 mx-auto mb-4 relative">
                  <div class="absolute inset-0 border-8 border-primary-200 rounded-full animate-spin" style="animation-duration: 3s;"></div>
                  <div class="absolute inset-2 border-4 border-primary-400 rounded-full animate-spin" style="animation-duration: 2s; animation-direction: reverse;"></div>
                  <div class="absolute inset-4 bg-primary-600 rounded-full flex items-center justify-center">
                    <ExclamationTriangleIcon class="w-6 h-6 text-white" />
                  </div>
                </div>
                
                <!-- Small gears -->
                <div class="absolute top-2 right-8">
                  <div class="w-8 h-8 border-4 border-success-400 rounded-full animate-spin" style="animation-duration: 1.5s;"></div>
                </div>
                <div class="absolute bottom-2 left-8">
                  <div class="w-6 h-6 border-3 border-orange-400 rounded-full animate-spin" style="animation-duration: 2.5s; animation-direction: reverse;"></div>
                </div>
              </div>
              
              <div class="text-neutral-600 text-sm mt-4">
                Hier läuft etwas nicht rund...
              </div>
            </div>
          </div>
        </div>

        <!-- Action Buttons -->
        <div class="space-y-4">
          <div class="flex flex-col sm:flex-row gap-4 justify-center">
            <NuxtLink to="/" class="btn-primary px-8 py-3">
              <HomeIcon class="w-5 h-5 mr-2" />
              Zur Startseite
            </NuxtLink>
            <button @click="goBack" class="btn-secondary px-8 py-3">
              <ArrowLeftIcon class="w-5 h-5 mr-2" />
              Zurück
            </button>
          </div>
          
          <div class="text-sm text-neutral-500">
            oder versuchen Sie es mit einer unserer beliebten Seiten:
          </div>
        </div>

        <!-- Popular Pages -->
        <div class="mt-8">
          <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
            <NuxtLink to="/leistungen/prozessoptimierung" class="p-4 bg-white rounded-lg shadow-sm hover:shadow-md transition-shadow border border-neutral-200 group">
              <ChartBarIcon class="w-6 h-6 text-primary-600 mx-auto mb-2 group-hover:scale-110 transition-transform" />
              <div class="text-sm font-medium text-neutral-900 group-hover:text-primary-600 transition-colors">
                Prozessoptimierung
              </div>
            </NuxtLink>
            
            <NuxtLink to="/leistungen/automatisierung" class="p-4 bg-white rounded-lg shadow-sm hover:shadow-md transition-shadow border border-neutral-200 group">
              <CogIcon class="w-6 h-6 text-success-600 mx-auto mb-2 group-hover:scale-110 transition-transform" />
              <div class="text-sm font-medium text-neutral-900 group-hover:text-success-600 transition-colors">
                Automatisierung
              </div>
            </NuxtLink>
            
            <NuxtLink to="/referenzen" class="p-4 bg-white rounded-lg shadow-sm hover:shadow-md transition-shadow border border-neutral-200 group">
              <StarIcon class="w-6 h-6 text-yellow-600 mx-auto mb-2 group-hover:scale-110 transition-transform" />
              <div class="text-sm font-medium text-neutral-900 group-hover:text-yellow-600 transition-colors">
                Referenzen
              </div>
            </NuxtLink>
            
            <NuxtLink to="/kontakt" class="p-4 bg-white rounded-lg shadow-sm hover:shadow-md transition-shadow border border-neutral-200 group">
              <PhoneIcon class="w-6 h-6 text-blue-600 mx-auto mb-2 group-hover:scale-110 transition-transform" />
              <div class="text-sm font-medium text-neutral-900 group-hover:text-blue-600 transition-colors">
                Kontakt
              </div>
            </NuxtLink>
          </div>
        </div>

        <!-- Search Box -->
        <div class="mt-8 max-w-md mx-auto">
          <div class="relative">
            <input
              v-model="searchQuery"
              @keyup.enter="performSearch"
              type="text"
              placeholder="Suchen Sie nach Inhalten..."
              class="w-full px-4 py-3 pl-12 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500"
            >
            <MagnifyingGlassIcon class="absolute left-4 top-1/2 transform -translate-y-1/2 w-5 h-5 text-neutral-400" />
            <button
              @click="performSearch"
              class="absolute right-2 top-1/2 transform -translate-y-1/2 btn-primary text-sm px-4 py-1"
            >
              Suchen
            </button>
          </div>
        </div>
      </div>
    </main>

    <!-- Footer -->
    <footer class="bg-white border-t border-neutral-200 py-8">
      <div class="container-custom">
        <div class="flex flex-col md:flex-row justify-between items-center text-sm text-neutral-600">
          <div>
            © {{ new Date().getFullYear() }} Configuraid GmbH. Alle Rechte vorbehalten.
          </div>
          <div class="flex space-x-6 mt-4 md:mt-0">
            <NuxtLink to="/impressum" class="hover:text-primary-600 transition-colors">
              Impressum
            </NuxtLink>
            <NuxtLink to="/datenschutz" class="hover:text-primary-600 transition-colors">
              Datenschutz
            </NuxtLink>
            <NuxtLink to="/kontakt" class="hover:text-primary-600 transition-colors">
              Hilfe
            </NuxtLink>
          </div>
        </div>
      </div>
    </footer>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import {
  ExclamationTriangleIcon,
  HomeIcon,
  ArrowLeftIcon,
  ChartBarIcon,
  CogIcon,
  StarIcon,
  PhoneIcon,
  MagnifyingGlassIcon
} from '@heroicons/vue/24/outline'

// Props
const props = defineProps({
  error: {
    type: Object,
    default: () => ({})
  }
})

// State
const searchQuery = ref('')

// Methods
const getErrorTitle = () => {
  const statusCode = props.error.statusCode
  
  switch (statusCode) {
    case 404:
      return 'Seite nicht gefunden'
    case 500:
      return 'Interner Serverfehler'
    case 403:
      return 'Zugriff verweigert'
    default:
      return 'Etwas ist schiefgelaufen'
  }
}

const getErrorMessage = () => {
  const statusCode = props.error.statusCode
  
  switch (statusCode) {
    case 404:
      return 'Die gesuchte Seite existiert nicht oder wurde verschoben. Keine Sorge, wir helfen Ihnen dabei, das Richtige zu finden!'
    case 500:
      return 'Unser Server hat gerade technische Schwierigkeiten. Wir arbeiten bereits an einer Lösung. Versuchen Sie es in ein paar Minuten erneut.'
    case 403:
      return 'Sie haben keine Berechtigung, diese Seite zu besuchen. Falls Sie der Meinung sind, dass dies ein Fehler ist, kontaktieren Sie uns gerne.'
    default:
      return 'Es ist ein unerwarteter Fehler aufgetreten. Wir entschuldigen uns für die Unannehmlichkeiten.'
  }
}

const goBack = () => {
  if (typeof window !== 'undefined' && window.history.length > 1) {
    window.history.back()
  } else {
    navigateTo('/')
  }
}

const performSearch = () => {
  if (searchQuery.value.trim()) {
    // In a real implementation, you would integrate with your search system
    // For now, we'll redirect to a search results page or the blog
    navigateTo(`/blog?q=${encodeURIComponent(searchQuery.value)}`)
  }
}

// SEO
useHead({
  title: `${getErrorTitle()} - Configuraid`,
  meta: [
    { name: 'description', content: getErrorMessage() },
    { name: 'robots', content: 'noindex, nofollow' }
  ]
})

// Custom status code handling
const statusCode = props.error.statusCode
if (statusCode && typeof setResponseStatus === 'function') {
  setResponseStatus(statusCode)
}
</script>

<style scoped>
/* Custom animations for the gears */
@keyframes spin {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}

.animate-spin {
  animation: spin linear infinite;
}

/* Gradient text effect */
.gradient-text {
  background: linear-gradient(135deg, #1e3a8a 0%, #2563eb 50%, #3b82f6 100%);
  background-clip: text;
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}
</style>