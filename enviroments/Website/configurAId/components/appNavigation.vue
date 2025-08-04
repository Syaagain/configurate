<template>
  <header class="fixed w-full bg-white/95 backdrop-blur-sm border-b border-gray-200 z-50 transition-all duration-300" :class="{ 'shadow-lg': isScrolled }">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
      <div class="flex justify-between items-center py-4">
        <!-- Logo -->
        <div class="flex items-center">
          <NuxtLink to="/" class="flex items-center space-x-2 group">
            <div class="w-10 h-10 bg-primary-blue rounded-lg flex items-center justify-center group-hover:scale-110 transition-transform">
              <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z" />
              </svg>
            </div>
            <span class="text-2xl font-bold text-primary-blue group-hover:text-blue-800 transition-colors">Configuraid</span>
          </NuxtLink>
        </div>
        
        <!-- Desktop Navigation -->
        <nav class="hidden lg:flex items-center space-x-8">
          <!-- Services Dropdown -->
          <div class="relative group">
            <button class="flex items-center text-gray-700 hover:text-primary-blue transition-colors font-medium py-2">
              Leistungen
              <svg class="w-4 h-4 ml-1 transition-transform group-hover:rotate-180" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
              </svg>
            </button>
            
            <!-- Dropdown Menu -->
            <div class="absolute top-full left-0 mt-2 w-80 bg-white rounded-xl shadow-xl border border-gray-100 opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-300 transform translate-y-2 group-hover:translate-y-0">
              <div class="p-6">
                <div class="grid grid-cols-1 gap-4">
                  <NuxtLink to="/leistungen/prozessoptimierung" class="flex items-start p-3 rounded-lg hover:bg-blue-50 group/item">
                    <div class="w-10 h-10 bg-blue-100 rounded-lg flex items-center justify-center mr-4 group-hover/item:bg-primary-blue transition-colors">
                      <svg class="w-5 h-5 text-blue-600 group-hover/item:text-white transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z" />
                      </svg>
                    </div>
                    <div>
                      <div class="font-semibold text-gray-900 group-hover/item:text-primary-blue transition-colors">Prozessoptimierung</div>
                      <div class="text-sm text-gray-500 mt-1">Lean & effiziente Workflows</div>
                    </div>
                  </NuxtLink>
                  
                  <NuxtLink to="/leistungen/automatisierung" class="flex items-start p-3 rounded-lg hover:bg-green-50 group/item">
                    <div class="w-10 h-10 bg-green-100 rounded-lg flex items-center justify-center mr-4 group-hover/item:bg-success-green transition-colors">
                      <svg class="w-5 h-5 text-green-600 group-hover/item:text-white transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z" />
                      </svg>
                    </div>
                    <div>
                      <div class="font-semibold text-gray-900 group-hover/item:text-success-green transition-colors">Automatisierung</div>
                      <div class="text-sm text-gray-500 mt-1">Intelligente Workflows</div>
                    </div>
                  </NuxtLink>
                  
                  <NuxtLink to="/leistungen/webentwicklung" class="flex items-start p-3 rounded-lg hover:bg-purple-50 group/item">
                    <div class="w-10 h-10 bg-purple-100 rounded-lg flex items-center justify-center mr-4 group-hover/item:bg-purple-600 transition-colors">
                      <svg class="w-5 h-5 text-purple-600 group-hover/item:text-white transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 20l4-16m4 4l4 4-4 4M6 16l-4-4 4-4" />
                      </svg>
                    </div>
                    <div>
                      <div class="font-semibold text-gray-900 group-hover/item:text-purple-600 transition-colors">Webentwicklung</div>
                      <div class="text-sm text-gray-500 mt-1">Moderne digitale Lösungen</div>
                    </div>
                  </NuxtLink>
                  
                  <NuxtLink to="/leistungen/beratung" class="flex items-start p-3 rounded-lg hover:bg-orange-50 group/item">
                    <div class="w-10 h-10 bg-orange-100 rounded-lg flex items-center justify-center mr-4 group-hover/item:bg-orange-600 transition-colors">
                      <svg class="w-5 h-5 text-orange-600 group-hover/item:text-white transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
                      </svg>
                    </div>
                    <div>
                      <div class="font-semibold text-gray-900 group-hover/item:text-orange-600 transition-colors">Beratung</div>
                      <div class="text-sm text-gray-500 mt-1">Strategische Transformation</div>
                    </div>
                  </NuxtLink>
                </div>
                
                <div class="mt-4 pt-4 border-t border-gray-100">
                  <NuxtLink to="/leistungen" class="flex items-center text-primary-blue hover:text-blue-800 font-semibold transition-colors">
                    Alle Leistungen ansehen
                    <svg class="w-4 h-4 ml-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 8l4 4m0 0l-4 4m4-4H3" />
                    </svg>
                  </NuxtLink>
                </div>
              </div>
            </div>
          </div>

          <!-- Other Navigation Items -->
          <NuxtLink to="/referenzen" class="text-gray-700 hover:text-primary-blue transition-colors font-medium">
            Referenzen
          </NuxtLink>
          
          <NuxtLink to="/ueber-uns" class="text-gray-700 hover:text-primary-blue transition-colors font-medium">
            Über uns
          </NuxtLink>
          
          <NuxtLink to="/blog" class="text-gray-700 hover:text-primary-blue transition-colors font-medium">
            Blog
          </NuxtLink>
        </nav>

        <!-- CTA Button & Mobile Menu -->
        <div class="flex items-center space-x-4">
          <NuxtLink 
            to="/kontakt" 
            class="hidden md:inline-flex bg-primary-blue text-white px-6 py-2 rounded-lg font-semibold hover:bg-blue-800 transition-all transform hover:scale-105 shadow-lg">
            Kontakt
          </NuxtLink>

          <!-- Mobile menu button -->
          <button 
            @click="toggleMobileMenu"
            class="lg:hidden p-2 rounded-lg hover:bg-gray-100 transition-colors"
            :class="{ 'bg-gray-100': mobileMenuOpen }"
            aria-label="Toggle mobile menu">
            <svg v-if="!mobileMenuOpen" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
            </svg>
            <svg v-else class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
            </svg>
          </button>
        </div>
      </div>

      <!-- Mobile Navigation Menu -->
      <Transition
        enter-active-class="transition duration-300 ease-out"
        enter-from-class="transform -translate-y-full opacity-0"
        enter-to-class="transform translate-y-0 opacity-100"
        leave-active-class="transition duration-200 ease-in"
        leave-from-class="transform translate-y-0 opacity-100"
        leave-to-class="transform -translate-y-full opacity-0">
        <div v-if="mobileMenuOpen" class="lg:hidden bg-white border-t border-gray-200">
          <div class="px-4 pt-4 pb-6 space-y-4">
            <!-- Mobile Services -->
            <div class="space-y-3">
              <div class="font-semibold text-gray-900 text-sm uppercase tracking-wide">Leistungen</div>
              <div class="pl-4 space-y-3">
                <NuxtLink 
                  to="/leistungen/prozessoptimierung" 
                  @click="closeMobileMenu"
                  class="flex items-center text-gray-700 hover:text-primary-blue transition-colors">
                  <svg class="w-4 h-4 mr-3 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z" />
                  </svg>
                  Prozessoptimierung
                </NuxtLink>
                
                <NuxtLink 
                  to="/leistungen/automatisierung" 
                  @click="closeMobileMenu"
                  class="flex items-center text-gray-700 hover:text-success-green transition-colors">
                  <svg class="w-4 h-4 mr-3 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z" />
                  </svg>
                  Automatisierung
                </NuxtLink>
                
                <NuxtLink 
                  to="/leistungen/webentwicklung" 
                  @click="closeMobileMenu"
                  class="flex items-center text-gray-700 hover:text-purple-600 transition-colors">
                  <svg class="w-4 h-4 mr-3 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 20l4-16m4 4l4 4-4 4M6 16l-4-4 4-4" />
                  </svg>
                  Webentwicklung
                </NuxtLink>
                
                <NuxtLink 
                  to="/leistungen/beratung" 
                  @click="closeMobileMenu"
                  class="flex items-center text-gray-700 hover:text-orange-600 transition-colors">
                  <svg class="w-4 h-4 mr-3 text-orange-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
                  </svg>
                  Beratung
                </NuxtLink>
              </div>
            </div>

            <!-- Mobile Main Links -->
            <div class="border-t border-gray-200 pt-4 space-y-3">
              <NuxtLink 
                to="/referenzen" 
                @click="closeMobileMenu"
                class="block text-gray-700 hover:text-primary-blue transition-colors font-medium">
                Referenzen
              </NuxtLink>
              
              <NuxtLink 
                to="/ueber-uns" 
                @click="closeMobileMenu"
                class="block text-gray-700 hover:text-primary-blue transition-colors font-medium">
                Über uns
              </NuxtLink>
              
              <NuxtLink 
                to="/blog" 
                @click="closeMobileMenu"
                class="block text-gray-700 hover:text-primary-blue transition-colors font-medium">
                Blog
              </NuxtLink>
            </div>

            <!-- Mobile CTA -->
            <div class="border-t border-gray-200 pt-4">
              <NuxtLink 
                to="/kontakt" 
                @click="closeMobileMenu"
                class="block w-full text-center bg-primary-blue text-white px-6 py-3 rounded-lg font-semibold hover:bg-blue-800 transition-colors">
                Kontakt
              </NuxtLink>
            </div>

            <!-- Mobile Contact Info -->
            <div class="border-t border-gray-200 pt-4 space-y-2 text-sm text-gray-600">
              <div class="flex items-center">
                <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z" />
                </svg>
                <a href="tel:+4912345678901" class="hover:text-primary-blue transition-colors">
                  +49 (0) 123 456 789
                </a>
              </div>
              <div class="flex items-center">
                <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 4.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                </svg>
                <a href="mailto:info@configuraid.de" class="hover:text-primary-blue transition-colors">
                  info@configuraid.de
                </a>
              </div>
            </div>
          </div>
        </div>
      </Transition>
    </div>
  </header>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue'

const mobileMenuOpen = ref(false)
const isScrolled = ref(false)

const toggleMobileMenu = () => {
  mobileMenuOpen.value = !mobileMenuOpen.value
}

const closeMobileMenu = () => {
  mobileMenuOpen.value = false
}

// Handle scroll for header effects
const handleScroll = () => {
  isScrolled.value = window.scrollY > 10
}

// Close mobile menu when clicking outside
const handleClickOutside = (event) => {
  if (mobileMenuOpen.value && !event.target.closest('header')) {
    closeMobileMenu()
  }
}

// Close mobile menu on route change
const router = useRouter()
router.afterEach(() => {
  closeMobileMenu()
})

onMounted(() => {
  window.addEventListener('scroll', handleScroll)
  document.addEventListener('click', handleClickOutside)
})

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll)
  document.removeEventListener('click', handleClickOutside)
})

// Close mobile menu when pressing escape
const handleKeydown = (event) => {
  if (event.key === 'Escape' && mobileMenuOpen.value) {
    closeMobileMenu()
  }
}

onMounted(() => {
  document.addEventListener('keydown', handleKeydown)
})

onUnmounted(() => {
  document.removeEventListener('keydown', handleKeydown)
})
</script>

<style scoped>
.text-primary-blue {
  color: var(--primary-blue);
}

.bg-primary-blue {
  background-color: var(--primary-blue);
}

.text-success-green {
  color: var(--success-green);
}

.bg-success-green {
  background-color: var(--success-green);
}

.hover\:text-primary-blue:hover {
  color: var(--primary-blue);
}

.hover\:text-success-green:hover {
  color: var(--success-green);
}

.hover\:bg-blue-800:hover {
  background-color: #1e40af;
}

/* Smooth dropdown animation */
.group:hover .group-hover\:opacity-100 {
  transition-delay: 150ms;
}

/* Custom scrollbar for mobile menu if needed */
@media (max-height: 600px) {
  .lg\:hidden {
    max-height: 70vh;
    overflow-y: auto;
  }
}
</style>