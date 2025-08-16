<template>
  <header class="mobile-header">
    <!-- Fixed Top Bar -->
    <div class="top-bar" :class="{ 'scrolled': isScrolled }">
      <div class="header-content">
        <!-- Logo -->
        <div class="logo-wrapper" @click="navigateToHome">
          <div class="logo-shield">
            <span class="logo-text">AG</span>
          </div>
          <div class="logo-ripple"></div>
        </div>

        <!-- Center Title (Dynamic) -->
        <div class="page-title">
          <transition name="title-fade" mode="out-in">
            <span :key="currentPageTitle">{{ currentPageTitle }}</span>
          </transition>
        </div>

        <!-- Menu Trigger -->
        <button 
          @click="toggleMenu" 
          class="menu-trigger"
          :class="{ 'active': menuOpen }"
        >
          <div class="hamburger">
            <span></span>
            <span></span>
            <span></span>
          </div>
        </button>
      </div>
    </div>

    <!-- Fullscreen Luxury Menu -->
    <transition name="menu-reveal">
      <div v-if="menuOpen" class="luxury-menu">
        <div class="menu-bg-pattern"></div>
        <div class="menu-gradient"></div>
        
        <!-- Menu Content -->
        <div class="menu-content">
          <!-- Navigation Links -->
          <nav class="menu-nav">
            <div 
              v-for="(item, index) in menuItems" 
              :key="item.id"
              class="menu-item"
              :style="{ animationDelay: `${index * 0.1}s` }"
              @click="navigateToPage(item.route)"
            >
              <div class="menu-item-bg"></div>
              <div class="menu-item-content">
                <div class="menu-icon">
                  <span class="material-icons">{{ item.icon }}</span>
                </div>
                <div class="menu-text">
                  <h3>{{ item.title }}</h3>
                  <p>{{ item.subtitle }}</p>
                </div>
                <div class="menu-arrow">
                  <span class="material-icons">arrow_forward_ios</span>
                </div>
              </div>
              <div class="menu-item-shine"></div>
            </div>
          </nav>

          <!-- Quick Actions -->
          <div class="quick-actions">
            <button class="action-btn" @click="openWhatsApp">
              <span class="material-icons">chat</span>
              <span>WhatsApp</span>
            </button>
            <button class="action-btn" @click="navigateToContact">
              <span class="material-icons">contact_mail</span>
              <span>Kontakt</span>
            </button>
          </div>

          <!-- Social Links -->
          <div class="menu-social">
            <a href="https://www.facebook.com/your-page" target="_blank" class="social-link">
              <span class="material-icons">facebook</span>
            </a>
            <a href="https://www.instagram.com/your-account" target="_blank" class="social-link">
              <span class="material-icons">camera_alt</span>
            </a>
            <a href="https://www.youtube.com/your-channel" target="_blank" class="social-link">
              <span class="material-icons">play_arrow</span>
            </a>
          </div>

          <!-- Language Switcher -->
          <div class="language-switch">
            <button 
              v-for="lang in languages" 
              :key="lang"
              @click="switchLanguage(lang)"
              :class="['lang-btn', { active: currentLang === lang }]"
            >
              {{ lang }}
            </button>
          </div>
        </div>

        <!-- Close Button -->
        <button @click="closeMenu" class="menu-close">
          <span class="material-icons">close</span>
        </button>
      </div>
    </transition>
  </header>
</template>

<script setup>
import { ref, onMounted, onUnmounted, watch } from 'vue'
import { useRouter, useRoute } from 'vue-router'

// Nuxt.js Router
const router = useRouter()
const route = useRoute()

// Reactive state
const menuOpen = ref(false)
const isScrolled = ref(false)
const currentPageTitle = ref('Architektur Group')
const currentLang = ref('DE')

const menuItems = [
  {
    id: 1,
    title: 'Startseite',
    subtitle: 'Zurück zur Hauptseite',
    icon: 'home',
    route: '/'
  },
  {
    id: 2,
    title: 'Über uns',
    subtitle: 'Unsere Geschichte & Vision',
    icon: 'business',
    route: '/ueber-uns'
  },
  {
    id: 3,
    title: 'Sortiment',
    subtitle: '200+ Premium Materialien',
    icon: 'inventory',
    route: '/sortiment'
  },
  {
    id: 4,
    title: 'Kontakt',
    subtitle: 'Nehmen Sie Kontakt auf',
    icon: 'contact_mail',
    route: '/kontakt'
  }
]

const languages = ['DE', 'EN', 'FR']

// Page title mapping
const pageTitles = {
  '/': 'Architektur Group',
  '/ueber-uns': 'Über uns',
  '/sortiment': 'Sortiment',
  '/kontakt': 'Kontakt'
}

// Navigation functions
const navigateToHome = async () => {
  closeMenu()
  try {
    await router.push('/')
  } catch (error) {
    console.error('Navigation error:', error)
  }
}

const navigateToPage = async (routePath) => {
  closeMenu()
  
  // Haptic feedback
  if (navigator.vibrate) {
    navigator.vibrate(20)
  }
  
  try {
    await router.push(routePath)
  } catch (error) {
    console.error('Navigation error:', error)
    // Fallback: use window.location if router fails
    window.location.href = routePath
  }
}

const navigateToContact = async () => {
  closeMenu()
  
  if (navigator.vibrate) {
    navigator.vibrate(30)
  }
  
  try {
    await router.push('/kontakt')
  } catch (error) {
    window.location.href = '/kontakt'
  }
}

// Menu controls
const toggleMenu = () => {
  menuOpen.value = !menuOpen.value
  
  // Prevent body scroll when menu is open
  if (process.client) {
    document.body.style.overflow = menuOpen.value ? 'hidden' : 'auto'
  }
  
  // Haptic feedback for mobile
  if (navigator.vibrate) {
    navigator.vibrate(menuOpen.value ? 30 : 10)
  }
}

const closeMenu = () => {
  menuOpen.value = false
  
  if (process.client) {
    document.body.style.overflow = 'auto'
  }
}

// Quick actions
const callUs = () => {
  closeMenu()
  
  if (navigator.vibrate) {
    navigator.vibrate(50)
  }
  
  window.location.href = 'tel:+4981713868770'
}

const openWhatsApp = () => {
  closeMenu()
  
  if (navigator.vibrate) {
    navigator.vibrate(30)
  }
  
  window.open('https://wa.me/4981713868770', '_blank')
}

const shareApp = async () => {
  closeMenu()
  
  if (navigator.vibrate) {
    navigator.vibrate(20)
  }
  
  if (navigator.share) {
    try {
      await navigator.share({
        title: 'Architektur Group',
        text: 'Exklusive Naturstein & Design Solutions',
        url: window.location.href
      })
    } catch (error) {
      console.log('Share cancelled or failed:', error)
    }
  } else {
    // Fallback: Copy URL to clipboard
    try {
      await navigator.clipboard.writeText(window.location.href)
      alert('Link wurde in die Zwischenablage kopiert!')
    } catch (error) {
      console.error('Could not copy text:', error)
    }
  }
}

const switchLanguage = (lang) => {
  currentLang.value = lang
  
  if (navigator.vibrate) {
    navigator.vibrate(10)
  }
  
  // Here you would implement actual language switching logic
  console.log('Switch language to:', lang)
  
  // Example: emit event or use i18n
  // emit('language-changed', lang)
  
  closeMenu()
}

// Update page title based on current route
const updatePageTitle = () => {
  const currentPath = route.path
  currentPageTitle.value = pageTitles[currentPath] || 'Architektur Group'
}

// Watchers and lifecycle
watch(() => route.path, () => {
  updatePageTitle()
  closeMenu() // Close menu when route changes
})

onMounted(() => {
  let lastScroll = 0
  
  // Update page title on mount
  updatePageTitle()
  
  // Scroll detection
  const handleScroll = () => {
    const currentScroll = window.scrollY
    isScrolled.value = currentScroll > 20
    lastScroll = currentScroll
  }
  
  // Keyboard event listener for ESC key
  const handleKeydown = (event) => {
    if (event.key === 'Escape' && menuOpen.value) {
      closeMenu()
    }
  }
  
  // Add event listeners
  window.addEventListener('scroll', handleScroll)
  document.addEventListener('keydown', handleKeydown)
  
  // Cleanup function will be handled by onUnmounted
  return () => {
    window.removeEventListener('scroll', handleScroll)
    document.removeEventListener('keydown', handleKeydown)
  }
})

onUnmounted(() => {
  // Ensure body scroll is restored
  if (process.client) {
    document.body.style.overflow = 'auto'
  }
})

// Handle browser back button when menu is open
if (process.client) {
  window.addEventListener('popstate', () => {
    if (menuOpen.value) {
      closeMenu()
    }
  })
}
</script>

<style scoped>
.mobile-header {
  --header-height: 60px;
}

/* Top Bar */
.top-bar {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  height: var(--header-height);
  background: rgba(0, 0, 0, 0.9);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  z-index: 1000;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.top-bar.scrolled {
  background: rgba(0, 0, 0, 0.95);
  box-shadow: 0 4px 30px rgba(0, 0, 0, 0.5);
}

.header-content {
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 100%;
  padding: 0 1rem;
}

/* Logo */
.logo-wrapper {
  position: relative;
  width: 40px;
  height: 40px;
  cursor: pointer;
  tap-highlight-color: transparent;
}

.logo-shield {
  width: 100%;
  height: 100%;
  background: linear-gradient(135deg, #a47148 0%, #FAFAF8 100%);
  clip-path: polygon(50% 0%, 100% 25%, 100% 75%, 50% 100%, 0% 75%, 0% 25%);
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative;
  animation: logoFloat 3s ease-in-out infinite;
}

@keyframes logoFloat {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(-3px); }
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
  font-size: 14px;
  color: #FAFAF8;
}

.logo-ripple {
  position: absolute;
  inset: -10px;
  border: 1px solid #a47148;
  clip-path: polygon(50% 0%, 100% 25%, 100% 75%, 50% 100%, 0% 75%, 0% 25%);
  opacity: 0;
  animation: ripple 2s ease-out infinite;
}

@keyframes ripple {
  0% {
    transform: scale(0.8);
    opacity: 1;
  }
  100% {
    transform: scale(1.3);
    opacity: 0;
  }
}

/* Page Title */
.page-title {
  flex: 1;
  text-align: center;
  color: #FAFAF8;
  font-size: 1rem;
  font-weight: 400;
  letter-spacing: 0.05em;
  text-transform: uppercase;
}

.title-fade-enter-active,
.title-fade-leave-active {
  transition: all 0.3s ease;
}

.title-fade-enter-from {
  opacity: 0;
  transform: translateY(-10px);
}

.title-fade-leave-to {
  opacity: 0;
  transform: translateY(10px);
}

/* Menu Trigger */
.menu-trigger {
  width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: transparent;
  border: none;
  cursor: pointer;
  tap-highlight-color: transparent;
  position: relative;
}

.hamburger {
  width: 24px;
  height: 18px;
  position: relative;
}

.hamburger span {
  position: absolute;
  left: 0;
  width: 100%;
  height: 2px;
  background: #FAFAF8;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.hamburger span:nth-child(1) {
  top: 0;
}

.hamburger span:nth-child(2) {
  top: 50%;
  transform: translateY(-50%);
}

.hamburger span:nth-child(3) {
  bottom: 0;
}

.menu-trigger.active .hamburger span:nth-child(1) {
  transform: rotate(45deg) translate(5px, 5px);
}

.menu-trigger.active .hamburger span:nth-child(2) {
  opacity: 0;
  transform: translateX(10px);
}

.menu-trigger.active .hamburger span:nth-child(3) {
  transform: rotate(-45deg) translate(7px, -6px);
}

/* Luxury Menu */
.luxury-menu {
  position: fixed;
  inset: 0;
  z-index: 999;
  background: #000;
  overflow-y: auto;
  -webkit-overflow-scrolling: touch;
}

.menu-bg-pattern {
  position: absolute;
  inset: 0;
  background-image: 
    repeating-linear-gradient(45deg, transparent, transparent 35px, rgba(164, 113, 72, 0.03) 35px, rgba(164, 113, 72, 0.03) 70px);
  animation: patternMove 20s linear infinite;
}

@keyframes patternMove {
  0% { transform: translateX(0) translateY(0); }
  100% { transform: translateX(70px) translateY(70px); }
}

.menu-gradient {
  position: absolute;
  inset: 0;
  background: radial-gradient(circle at 30% 50%, rgba(164, 113, 72, 0.1) 0%, transparent 50%);
}

.menu-content {
  position: relative;
  z-index: 1;
  padding: calc(var(--header-height) + 2rem) 1.5rem 2rem;
  min-height: 100vh;
}

/* Menu Navigation */
.menu-nav {
  margin-bottom: 2rem;
}

.menu-item {
  position: relative;
  margin-bottom: 1rem;
  animation: slideInLeft 0.6s cubic-bezier(0.4, 0, 0.2, 1) both;
  cursor: pointer;
  tap-highlight-color: transparent;
}

@keyframes slideInLeft {
  from {
    opacity: 0;
    transform: translateX(-30px);
  }
  to {
    opacity: 1;
    transform: translateX(0);
  }
}

.menu-item-bg {
  position: absolute;
  inset: 0;
  background: rgba(255, 255, 255, 0.03);
  border-radius: 20px;
  transition: all 0.3s ease;
}

.menu-item:active .menu-item-bg {
  background: rgba(255, 255, 255, 0.08);
  transform: scale(0.98);
}

.menu-item-content {
  position: relative;
  display: flex;
  align-items: center;
  gap: 1rem;
  padding: 1.25rem 1rem;
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 20px;
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  transition: all 0.3s ease;
}

.menu-icon {
  width: 50px;
  height: 50px;
  background: linear-gradient(135deg, rgba(164, 113, 72, 0.2), rgba(250, 250, 248, 0.1));
  border-radius: 15px;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}

.menu-icon .material-icons {
  font-size: 24px;
  color: #a47148;
}

.menu-text {
  flex: 1;
}

.menu-text h3 {
  font-size: 1.125rem;
  font-weight: 500;
  color: #FAFAF8;
  margin-bottom: 0.25rem;
}

.menu-text p {
  font-size: 0.875rem;
  color: #999;
}

.menu-arrow {
  color: #666;
}

.menu-item-shine {
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.1), transparent);
  transition: left 0.5s ease;
  border-radius: 20px;
  pointer-events: none;
}

.menu-item:hover .menu-item-shine {
  left: 100%;
}

/* Quick Actions */
.quick-actions {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 1rem;
  margin-bottom: 2rem;
}

.action-btn {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.5rem;
  padding: 1rem;
  background: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 15px;
  color: #FAFAF8;
  font-size: 0.75rem;
  cursor: pointer;
  transition: all 0.3s ease;
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
}

.action-btn:active {
  transform: scale(0.95);
  background: rgba(164, 113, 72, 0.2);
}

.action-btn .material-icons {
  font-size: 24px;
  color: #a47148;
}

/* Social Links */
.menu-social {
  display: flex;
  justify-content: center;
  gap: 1.5rem;
  margin-bottom: 2rem;
}

.social-link {
  width: 44px;
  height: 44px;
  background: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #FAFAF8;
  transition: all 0.3s ease;
  text-decoration: none;
}

.social-link:active {
  transform: scale(0.9);
  background: rgba(164, 113, 72, 0.2);
}

/* Language Switch */
.language-switch {
  display: flex;
  justify-content: center;
  gap: 0.5rem;
  padding: 0.5rem;
  background: rgba(255, 255, 255, 0.05);
  border-radius: 25px;
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.lang-btn {
  padding: 0.5rem 1rem;
  background: transparent;
  border: none;
  color: #999;
  font-size: 0.875rem;
  font-weight: 500;
  border-radius: 20px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.lang-btn.active {
  background: #a47148;
  color: #000;
}

/* Menu Close */
.menu-close {
  position: fixed;
  top: 10px;
  right: 10px;
  width: 40px;
  height: 40px;
  background: rgba(255, 255, 255, 0.1);
  border: none;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #FAFAF8;
  cursor: pointer;
  z-index: 1001;
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
}

/* Menu Reveal Animation */
.menu-reveal-enter-active {
  animation: menuReveal 0.5s cubic-bezier(0.4, 0, 0.2, 1);
}

.menu-reveal-leave-active {
  animation: menuReveal 0.4s cubic-bezier(0.4, 0, 0.2, 1) reverse;
}

@keyframes menuReveal {
  from {
    opacity: 0;
    transform: translateY(100%);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* Responsive adjustments */
@media (max-width: 360px) {
  .page-title {
    font-size: 0.875rem;
  }
  
  .menu-text h3 {
    font-size: 1rem;
  }
  
  .quick-actions {
    grid-template-columns: 1fr 1fr;
    gap: 0.75rem;
  }
  
  .action-btn {
    padding: 0.75rem 0.5rem;
    font-size: 0.7rem;
  }
}

/* iOS specific fixes */
@supports (-webkit-touch-callout: none) {
  .top-bar,
  .luxury-menu {
    -webkit-transform: translateZ(0);
  }
}
</style>