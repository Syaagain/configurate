<template>
  <header class="fixed top-0 left-0 right-0 z-50 bg-black/80 backdrop-blur-md">
    <div class="container mx-auto px-6 py-4">
      <nav class="flex items-center justify-between">
        <button @click="toggleMenu" class="text-white">
          <span class="text-sm font-light uppercase tracking-wider">MENÜ</span>
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
      <div v-if="menuOpen" class="fixed inset-0 bg-black z-40 flex items-center justify-center">
        <button @click="toggleMenu" class="absolute top-6 right-6 text-white">
          <span class="material-icons text-3xl">close</span>
        </button>
        
        <nav class="vertical-menu">
          <ul>
            <li><NuxtLink to="/ueber-uns" @click="toggleMenu">Über uns</NuxtLink></li>
            <li><NuxtLink to="/sortiment" @click="toggleMenu">Sortiment</NuxtLink></li>
            <li><NuxtLink to="/showrooms" @click="toggleMenu">Showrooms</NuxtLink></li>
            <li><NuxtLink to="/projekte" @click="toggleMenu">Projekte</NuxtLink></li>
            <li><NuxtLink to="/service" @click="toggleMenu">Service</NuxtLink></li>
          </ul>
        </nav>
      </div>
    </transition>
  </header>
</template>

<script setup>
const menuOpen = ref(false)
const currentLang = ref('DE')

const toggleMenu = () => {
  menuOpen.value = !menuOpen.value
}

const toggleLang = () => {
  currentLang.value = currentLang.value === 'DE' ? 'EN' : 'DE'
}
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

.vertical-menu ul {
  list-style: none;
  margin: 0;
  padding: 0;
}

.vertical-menu li {
  margin-bottom: 2rem;
}

.vertical-menu a {
  font-weight: 300;
  color: var(--primary-white);
  text-decoration: none;
  font-size: 2rem;
  text-transform: uppercase;
  transition: opacity 0.3s;
}

.vertical-menu a:hover {
  opacity: 0.8;
}

.menu-enter-active,
.menu-leave-active {
  transition: opacity 0.3s ease;
}

.menu-enter-from,
.menu-leave-to {
  opacity: 0;
}
</style>