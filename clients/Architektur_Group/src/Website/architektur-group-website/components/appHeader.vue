<template>
  <header class="fixed top-0 left-0 right-0 z-[80] bg-black/80 backdrop-blur-md transition-transform duration-300" :class="{ '-translate-y-full': !headerVisible }">
    <div class="container mx-auto px-6 py-4">
      <nav class="flex items-center justify-between">
        <button @click="toggleMenu" class="menu-item-title text-white z-[90] relative" :class="{ 'menu-open': menuOpen, 'menu-closing': menuClosing }">
          <span class="text-sm font-light uppercase tracking-wider transition-opacity duration-300" :class="{ 'opacity-0': menuOpen }">MENÜ</span>
          <div class="menu-icon">
            <span class="menu-x-icon opacity-0 transition-all duration-300 text-4xl" :class="{ 'opacity-100': menuOpen }">×</span>
          </div>
        </button>
        
        <NuxtLink to="/" class="absolute left-1/2 transform -translate-x-1/2">
          <div class="logo-wrapper">
            <div class="logo-shield">
              <span class="logo-text">AG</span>
            </div>
          </div>
        </NuxtLink>
        
        <div class="flex items-center gap-6">
          <div class="language-selector">
            <button @click="toggleLang" class="flex items-center gap-1 text-white">
              <span>{{ currentLang }}</span>
              <span class="material-icons text-sm">expand_more</span>
            </button>
          </div>
          
          <a href="tel:+498171386870" class="text-white hover:text-gray-300 transition">
            +49 8171 / 3868770
          </a>
          
          <NuxtLink to="/kontakt" class="text-white uppercase tracking-wider hover:text-gray-300 transition">
            KONTAKT
          </NuxtLink>
        </div>
      </nav>
    </div>
    
    <!-- Fullscreen Menu -->
    <transition name="menu">
      <div v-if="menuOpen" id="menu-overlay" class="fixed inset-0 bg-black z-[60] flex min-h-screen">
        <!-- Left Column - Main Navigation -->
        <div class="w-full md:w-1/2 flex items-center justify-center">
          <nav class="vertical-menu">
            <ul class="flex flex-col items-center justify-center">
              <li><NuxtLink to="/ueber-uns" @click="closeMenu" class="submenu-item">Über uns</NuxtLink></li>
              <li><NuxtLink to="/sortiment" @click="closeMenu" class="submenu-item">Sortiment</NuxtLink></li>
              <li><NuxtLink to="/showrooms" @click="closeMenu" class="submenu-item">Showrooms</NuxtLink></li>
              <li><NuxtLink to="/projekte" @click="closeMenu" class="submenu-item">Projekte</NuxtLink></li>
              <li><NuxtLink to="/service" @click="closeMenu" class="submenu-item">Service</NuxtLink></li>
            </ul>
          </nav>
        </div>
        
        <!-- Right Column - Additional Info (Desktop only) -->
        <div class="hidden md:flex md:w-1/2 flex-col items-center justify-center space-y-12 text-white">
          <!-- Contact Information -->
          <div class="text-center space-y-4">
            <h3 class="text-lg font-light uppercase tracking-wider text-gray-300">Kontakt</h3>
            <div class="space-y-2">
              <a href="tel:+498171386870" class="block text-xl hover:text-yellow-400 transition">
                +49 8171 / 3868770
              </a>
              <a href="mailto:info@architektur-group.de" class="block text-lg hover:text-yellow-400 transition">
                info@architektur-group.de
              </a>
            </div>
          </div>
          
          <!-- Address -->
          <div class="text-center space-y-2">
            <h3 class="text-lg font-light uppercase tracking-wider text-gray-300">Adresse</h3>
            <div class="text-lg leading-relaxed">
              <p>Musterstraße 123</p>
              <p>82319 Starnberg</p>
              <p>Deutschland</p>
            </div>
          </div>
          
          <!-- Language Selector -->
          <div class="text-center">
            <h3 class="text-lg font-light uppercase tracking-wider text-gray-300 mb-4">Sprache</h3>
            <button @click="toggleLang" class="flex items-center gap-2 text-xl hover:text-yellow-400 transition mx-auto">
              <span>{{ currentLang }}</span>
              <span class="material-icons">language</span>
            </button>
          </div>
          
          <!-- Social Links -->
          <div class="text-center">
            <h3 class="text-lg font-light uppercase tracking-wider text-gray-300 mb-4">Social</h3>
            <div class="flex justify-center">
              <a href="#" class="text-2xl hover:text-yellow-400 transition">
                <span class="material-icons">facebook</span>
              </a>
              <a href="#" class="text-2xl hover:text-yellow-400 transition">
                <span class="material-icons">instagram</span>
              </a>
              <a href="#" class="text-2xl hover:text-yellow-400 transition">
                <span class="material-icons">linkedin</span>
              </a>
            </div>
          </div>
        </div>
      </div>
    </transition>
  </header>
</template>

<script setup>
const menuOpen = ref(false)
const menuClosing = ref(false)
const currentLang = ref('DE')
const headerVisible = ref(true)
const lastScrollY = ref(0)

const toggleMenu = () => {
  if (menuOpen.value) {
    closeMenu()
  } else {
    openMenu()
  }
}

const openMenu = () => {
  menuOpen.value = true
  menuClosing.value = false
  document.body.classList.add('overlay-open')
}

const closeMenu = () => {
  menuClosing.value = true
  setTimeout(() => {
    menuOpen.value = false
    menuClosing.value = false
    document.body.classList.remove('overlay-open')
  }, 300)
}

const toggleLang = () => {
  currentLang.value = currentLang.value === 'DE' ? 'EN' : 'DE'
}

const handleScroll = () => {
  const currentScrollY = window.scrollY
  
  // Immer sichtbar wenn:
  // 1. Ganz oben (< 100px)
  // 2. Menü ist offen
  // 3. Hochscrollen
  if (currentScrollY < 100 || menuOpen.value || currentScrollY < lastScrollY.value) {
    headerVisible.value = true
  } else if (currentScrollY > lastScrollY.value && currentScrollY > 100) {
    // Ausblenden beim Runterscrollen (aber nicht wenn Menü offen)
    headerVisible.value = false
  }
  
  lastScrollY.value = currentScrollY
}

// Scroll-Listener hinzufügen
onMounted(() => {
  window.addEventListener('scroll', handleScroll, { passive: true })
})

// Clean up on unmount
onUnmounted(() => {
  document.body.classList.remove('overlay-open')
  window.removeEventListener('scroll', handleScroll)
})

// Sicherstellen dass Header sichtbar ist wenn Menü öffnet
watch(menuOpen, (newValue) => {
  if (newValue) {
    headerVisible.value = true
  }
})
</script>

<style scoped>
.logo-wrapper {
  position: relative;
  width: 60px;
  height: 60px;
}

.logo-shield {
  width: 100%;
  height: 100%;
  background: linear-gradient(135deg, var(--primary-gold) 0%, var(--primary-white) 100%);
  clip-path: polygon(50% 0%, 100% 25%, 100% 75%, 50% 100%, 0% 75%, 0% 25%);
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative;
}

.logo-shield::before {
  content: '';
  position: absolute;
  inset: 2px;
  background: black;
  clip-path: polygon(50% 0%, 100% 25%, 100% 75%, 50% 100%, 0% 75%, 0% 25%);
}

.logo-text {
  position: relative;
  z-index: 1;
  font-weight: 700;
  font-size: 18px;
  color: var(--primary-white);
}

/* ============== MENU OVERLAY ============== */
#menu-overlay {
  background: rgba(0, 0, 0, 0.95);
  backdrop-filter: blur(10px);
}

#menu-overlay ul {
  list-style: none;
  margin: 0;
  padding: 0;
  text-align: center;
}

.submenu-item {
  font-family: "Inter", sans-serif;
  font-size: clamp(1.5rem, 4vw, 3rem);
  color: #F5F0EB;
  padding: 0.4em 1.6em;
  transform: translateY(10px);
  transition: transform 0.25s ease, color 0.25s ease;
  white-space: nowrap;
  cursor: pointer;
  text-decoration: none;
  display: block;
  text-transform: uppercase;
  font-weight: 300;
  letter-spacing: 0.1em;
}

.submenu-item:hover {
  transform: translateY(0);
  color: var(--primary-gold);
}

/* Grey-out every other item only while one is hovered */
#menu-overlay:has(.submenu-item:hover) .submenu-item:not(:hover) {
  color: #B0B0B0;
}

/* ============== MENU TRIGGER ICON (MENÜ → ✕) ============== */
.menu-item-title {
  position: relative;
  display: inline-flex;
  align-items: center;
  cursor: pointer;
  color: white;
  font-family: 'Inter', sans-serif;
}

.menu-icon {
  position: relative;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 24px;
  height: 14px;
  margin-left: 8px;
}

.menu-x-icon {
  font-size: 24px;
  font-weight: 400;
  line-height: 1;
  transition: all 0.3s ease;
}

/* ============== MENU TRANSITIONS ============== */
.menu-enter-active,
.menu-leave-active {
  transition: opacity 0.3s ease;
}

.menu-enter-from,
.menu-leave-to {
  opacity: 0;
}

/* ============== MOBILE OPTIMIZATIONS ============== */
@media (max-width: 768px) {
  #menu-overlay ul {
    text-align: center;
  }
  
  .submenu-item {
    font-size: clamp(1.25rem, 5.5vw, 2rem);
    padding: 0.6em 0;
  }
}

@media (max-width: 480px) {
  .submenu-item {
    font-size: clamp(1.25rem, 5.5vw, 1.75rem);
    padding: 0.8em 0;
  }
}
</style>

<style>
/* Prevent body scrolling when overlay open */
body.overlay-open {
  overflow: hidden;
}
</style>