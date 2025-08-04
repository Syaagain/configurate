<template>
  <header class="bg-white shadow-lg sticky top-0 z-50 transition-all duration-300" :class="{ 'bg-white/95 backdrop-blur-md': isScrolled }">
    <nav class="container-custom">
      <div class="flex justify-between items-center py-4">
        <!-- Logo -->
        <NuxtLink to="/" class="flex items-center space-x-3">
          <div class="w-10 h-10 bg-gradient-to-br from-primary-900 to-primary-600 rounded-lg flex items-center justify-center">
            <span class="text-white font-bold text-xl">C</span>
          </div>
          <span class="text-2xl font-bold gradient-text">Configuraid</span>
        </NuxtLink>

        <!-- Desktop Navigation -->
        <div class="hidden lg:flex items-center space-x-8">
          <div class="relative" @mouseenter="openDropdown('leistungen')" @mouseleave="scheduleCloseDropdown">
            <button class="text-neutral-700 hover:text-primary-900 font-medium transition-colors flex items-center space-x-1">
              <span>Leistungen</span>
              <ChevronDownIcon class="w-4 h-4" />
            </button>
            
            <!-- Dropdown Leistungen -->
            <div v-show="showDropdown === 'leistungen'" 
                 @mouseenter="cancelCloseDropdown"
                 @mouseleave="scheduleCloseDropdown"
                 class="absolute top-full left-0 mt-2 w-64 bg-white rounded-xl shadow-2xl border border-neutral-100 py-4 z-50">
              <NuxtLink to="/leistungen/prozessoptimierung" @click="closeDropdown" class="block px-6 py-3 text-neutral-700 hover:text-primary-900 hover:bg-neutral-50 transition-colors">
                <div class="font-medium">Prozessoptimierung</div>
                <div class="text-sm text-neutral-500">Workflows analysieren & optimieren</div>
              </NuxtLink>
              <NuxtLink to="/leistungen/automatisierung" @click="closeDropdown" class="block px-6 py-3 text-neutral-700 hover:text-primary-900 hover:bg-neutral-50 transition-colors">
                <div class="font-medium">Automatisierung</div>
                <div class="text-sm text-neutral-500">Digitale Transformation</div>
              </NuxtLink>
              <NuxtLink to="/leistungen/webentwicklung" @click="closeDropdown" class="block px-6 py-3 text-neutral-700 hover:text-primary-900 hover:bg-neutral-50 transition-colors">
                <div class="font-medium">Webentwicklung</div>
                <div class="text-sm text-neutral-500">Maßgeschneiderte Lösungen</div>
              </NuxtLink>
              <NuxtLink to="/leistungen/beratung" @click="closeDropdown" class="block px-6 py-3 text-neutral-700 hover:text-primary-900 hover:bg-neutral-50 transition-colors">
                <div class="font-medium">Beratung</div>
                <div class="text-sm text-neutral-500">Strategische Beratung</div>
              </NuxtLink>
            </div>
          </div>

          <NuxtLink to="/loesungen" class="text-neutral-700 hover:text-primary-900 font-medium transition-colors">
            Lösungen
          </NuxtLink>
          <NuxtLink to="/referenzen" class="text-neutral-700 hover:text-primary-900 font-medium transition-colors">
            Referenzen
          </NuxtLink>
          <NuxtLink to="/ueber-uns" class="text-neutral-700 hover:text-primary-900 font-medium transition-colors">
            Über uns
          </NuxtLink>
          <NuxtLink to="/blog" class="text-neutral-700 hover:text-primary-900 font-medium transition-colors">
            Blog
          </NuxtLink>
        </div>

        <!-- CTA Button -->
        <div class="hidden lg:block">
          <NuxtLink to="/kontakt" class="btn-primary">
            Kostenlose Erstberatung
          </NuxtLink>
        </div>

        <!-- Mobile Menu Button -->
        <button @click="mobileMenuOpen = !mobileMenuOpen" class="lg:hidden p-2 rounded-lg hover:bg-neutral-100">
          <Bars3Icon v-if="!mobileMenuOpen" class="w-6 h-6" />
          <XMarkIcon v-else class="w-6 h-6" />
        </button>
      </div>

      <!-- Mobile Navigation -->
      <div v-show="mobileMenuOpen" class="lg:hidden border-t border-neutral-100 py-4">
        <div class="space-y-4">
          <div>
            <button @click="mobileDropdown = mobileDropdown === 'leistungen' ? null : 'leistungen'" 
                    class="flex items-center justify-between w-full text-left text-neutral-700 font-medium py-2">
              <span>Leistungen</span>
              <ChevronDownIcon class="w-4 h-4 transition-transform" :class="{ 'rotate-180': mobileDropdown === 'leistungen' }" />
            </button>
            
            <div v-show="mobileDropdown === 'leistungen'" class="pl-4 space-y-2 mt-2">
              <NuxtLink to="/leistungen/prozessoptimierung" class="block py-2 text-neutral-600 hover:text-primary-900">
                Prozessoptimierung
              </NuxtLink>
              <NuxtLink to="/leistungen/automatisierung" class="block py-2 text-neutral-600 hover:text-primary-900">
                Automatisierung
              </NuxtLink>
              <NuxtLink to="/leistungen/webentwicklung" class="block py-2 text-neutral-600 hover:text-primary-900">
                Webentwicklung
              </NuxtLink>
              <NuxtLink to="/leistungen/beratung" class="block py-2 text-neutral-600 hover:text-primary-900">
                Beratung
              </NuxtLink>
            </div>
          </div>
          
          <NuxtLink to="/loesungen" class="block py-2 text-neutral-700 font-medium">Lösungen</NuxtLink>
          <NuxtLink to="/referenzen" class="block py-2 text-neutral-700 font-medium">Referenzen</NuxtLink>
          <NuxtLink to="/ueber-uns" class="block py-2 text-neutral-700 font-medium">Über uns</NuxtLink>
          <NuxtLink to="/blog" class="block py-2 text-neutral-700 font-medium">Blog</NuxtLink>
          
          <div class="pt-4 border-t border-neutral-100">
            <NuxtLink to="/kontakt" class="btn-primary w-full text-center">
              Kostenlose Erstberatung
            </NuxtLink>
          </div>
        </div>
      </div>
    </nav>
  </header>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue'
import { ChevronDownIcon, Bars3Icon, XMarkIcon } from '@heroicons/vue/24/outline'

const showDropdown = ref(null)
const mobileMenuOpen = ref(false)
const mobileDropdown = ref(null)
const isScrolled = ref(false)

// Dropdown timer for delayed closing
let closeTimer = null

const openDropdown = (dropdown) => {
  // Cancel any pending close timer
  if (closeTimer) {
    clearTimeout(closeTimer)
    closeTimer = null
  }
  showDropdown.value = dropdown
}

const scheduleCloseDropdown = () => {
  // Close dropdown after a short delay
  closeTimer = setTimeout(() => {
    showDropdown.value = null
    closeTimer = null
  }, 150) // 150ms delay
}

const cancelCloseDropdown = () => {
  // Cancel the close timer when mouse enters dropdown
  if (closeTimer) {
    clearTimeout(closeTimer)
    closeTimer = null
  }
}

const closeDropdown = () => {
  // Immediately close dropdown (used for click events)
  if (closeTimer) {
    clearTimeout(closeTimer)
    closeTimer = null
  }
  showDropdown.value = null
}

const handleScroll = () => {
  isScrolled.value = window.scrollY > 50
}

onMounted(() => {
  window.addEventListener('scroll', handleScroll)
})

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll)
  // Clean up timer on unmount
  if (closeTimer) {
    clearTimeout(closeTimer)
  }
})
</script>