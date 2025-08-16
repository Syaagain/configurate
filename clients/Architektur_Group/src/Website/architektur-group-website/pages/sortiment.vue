<template>
  <div class="sortiment-page">
    <!-- Hero Section -->
    <section class="hero" id="hero">
      <div class="hero-bg" ref="heroBg">
        <img src="https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png" alt="Hero Background">
        <div class="hero-overlay"></div>
      </div>
      <div class="hero-content" ref="heroContent">
        <div class="title-container">
          <h1 class="hero-title">SORTIMENT</h1>
        </div>
        <div class="hero-badge animate-fade-in">PREMIUM AUSWAHL</div>
      </div>
      <div class="hero-subheading" ref="heroSubheading">
        <p>Über 650 verschiedene Naturstein- und Keramik-Oberflächen auf 2500m² Showroom-Fläche</p>
      </div>
      <div class="scroll-indicator" @click="scrollToContent">
        <span class="material-icons">expand_more</span>
      </div>
    </section>

    <!-- Category Filter -->
    <section class="filter-section">
      <div class="container">
        <div class="filter-background-glow"></div>
        <div class="section-header">
          <div class="header-decoration">
            <div class="decoration-line left"></div>
            <div class="section-badge premium">
              <span class="material-icons">auto_awesome</span>
               AUSWAHL
            </div>
            <div class="decoration-line right"></div>
          </div>
          <h2 class="section-title">
            <span class="title-gradient">EXKLUSIVE KATEGORIEN</span>
          </h2>
        </div>
        <div class="filter-buttons">
          <button 
            v-for="(category, index) in categories" 
            :key="category.id"
            @click="activeCategory = category.id"
            :class="['luxury-filter-btn', { 'active': activeCategory === category.id }]"
            :style="{ animationDelay: index * 0.1 + 's' }"
          >
            <div class="btn-background">
              <div class="bg-gradient"></div>
              <div class="bg-shine"></div>
            </div>
            <div class="btn-content">
              <div class="btn-icon">
                <span class="material-icons">{{ category.icon }}</span>
              </div>
              <div class="btn-text">
                <span class="btn-name">{{ category.name }}</span>
                <span class="btn-count">{{ getProductCount(category.id) }} Produkte</span>
              </div>
            </div>
            <div class="btn-particles">
              <div v-for="n in 6" :key="n" class="filter-particle"></div>
            </div>
          </button>
        </div>
      </div>
    </section>

    <!-- Products Grid -->
    <section class="products-section">
      <div class="container">
        <div class="products-header">
          <h3 class="products-title">
            {{ activeCategory === 'alle' ? 'Kollektion' : categories.find(c => c.id === activeCategory)?.name }}
          </h3>
        </div>
        <div class="products-grid">
          <div 
            v-for="(product, index) in filteredProducts" 
            :key="product.id"
            class="luxury-product-card"
            :style="{ animationDelay: `${index * 0.1}s` }"
            @click="openProductModal(product)"
            @mouseenter="createRipple"
          >
            <div class="card-background">
              <div class="morphing-blob blob-1"></div>
              <div class="morphing-blob blob-2"></div>
              <div class="energy-waves">
                <div v-for="n in 3" :key="n" class="wave" :style="{ animationDelay: n * 0.5 + 's' }"></div>
              </div>
            </div>
            
            <div class="product-image-container">
              <img :src="product.image" :alt="product.name" class="product-image">
              <div class="product-overlay">
                <div class="product-actions">
                  <button class="action-btn view">
                    <span class="material-icons">visibility</span>
                  </button>
                </div>
              </div>
              <div class="image-glow"></div>
            </div>
            
            <div class="product-info">
              <div class="product-header">
                <h3 class="product-name">
                  <span v-for="(char, charIndex) in product.name" 
                        :key="charIndex" 
                        class="title-char" 
                        :style="{ animationDelay: charIndex * 0.05 + 's' }">
                    {{ char === ' ' ? '\u00A0' : char }}
                  </span>
                </h3>
                <span class="product-category">{{ product.category }}</span>
              </div>
              <div class="product-features">
                <span v-for="feature in product.features" :key="feature" class="feature-tag">
                  {{ feature }}
                </span>
              </div>
              <div class="product-price">
                <span class="price-label">Ab</span>
                <span class="price-value">€ {{ product.price }}</span>
                <span class="price-unit">/ m²</span>
              </div>
            </div>
            
            <div class="corner-accents">
              <div class="corner top-left"></div>
              <div class="corner top-right"></div>
              <div class="corner bottom-left"></div>
              <div class="corner bottom-right"></div>
            </div>
            
            <div class="interaction-ripples"></div>
          </div>
        </div>
      </div>
    </section>

    <!-- Product Modal -->
    <transition name="modal">
      <div v-if="selectedProduct" class="modal-overlay" @click="closeModal">
        <div class="modal-content" @click.stop>
          <div class="modal-decorations">
            <div class="decoration-circle circle-1"></div>
            <div class="decoration-circle circle-2"></div>
            <div class="decoration-circle circle-3"></div>
          </div>
          
          <button class="modal-close" @click="closeModal">
            <span class="material-icons">close</span>
          </button>
          
          <div class="modal-body">
            <div class="modal-image">
              <img :src="selectedProduct.image" :alt="selectedProduct.name">
            </div>
            <div class="modal-info">
              <div class="modal-header">
                <h2 class="modal-title">{{ selectedProduct.name }}</h2>
              </div>
              
              <p class="modal-description">{{ selectedProduct.description }}</p>
              
              <div class="modal-specs">
                <h4>Technische Daten:</h4>
                <div class="specs-grid">
                  <div class="spec-item">
                    <span class="spec-label">Herkunft</span>
                    <span class="spec-value">{{ selectedProduct.origin || 'Europa' }}</span>
                  </div>
                  <div class="spec-item">
                    <span class="spec-label">Oberflächenbehandlung</span>
                    <span class="spec-value">{{ selectedProduct.surface || 'Poliert' }}</span>
                  </div>
                  <div class="spec-item">
                    <span class="spec-label">Dicke</span>
                    <span class="spec-value">{{ selectedProduct.thickness || '20mm' }}</span>
                  </div>
                </div>
              </div>
              
              <div class="modal-actions">
                <NuxtLink to="/kontakt" class="cta-button primary">
                  <span class="material-icons">contact_mail</span>
                  ANFRAGE STELLEN
                </NuxtLink>
              </div>
            </div>
          </div>
        </div>
      </div>
    </transition>

    <!-- Device-based Maps Section -->
    <section class="maps-section">
      <!-- Desktop Map -->
      <LocationsMap v-if="!isMobile" />
      
      <!-- Mobile Map -->
      <MobilePremiumMap v-if="isMobile" />
    </section>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted, computed } from 'vue'

// Import Map Components
import LocationsMap from '~/components/website/locationsMap.vue'
import MobilePremiumMap from '~/components/mobile/mobileInteractiveMap.vue'

// Device Detection Composable
const useDevice = () => {
  const isMobile = ref(false)
  
  onMounted(() => {
    const checkDevice = () => {
      isMobile.value = window.innerWidth <= 768
    }
    
    checkDevice()
    window.addEventListener('resize', checkDevice)
    
    onUnmounted(() => {
      window.removeEventListener('resize', checkDevice)
    })
  })
  
  return { isMobile }
}

// Use Device Detection
const { isMobile } = useDevice()

// State refs
const activeCategory = ref('alle')
const selectedProduct = ref(null)
const scrollY = ref(0)
const ticking = ref(false)

// Refs for parallax
const heroBg = ref(null)
const heroContent = ref(null)
const heroSubheading = ref(null)

const categories = [
  { id: 'alle', name: 'Alle Produkte', icon: 'apps' },
  { id: 'marmor', name: 'Marmor', icon: 'texture' },
  { id: 'granit', name: 'Granit', icon: 'landscape' },
  { id: 'travertin', name: 'Travertin', icon: 'architecture' },
  { id: 'schiefer', name: 'Schiefer', icon: 'layers' },
  { id: 'keramik', name: 'Keramik', icon: 'ceramic' }
]

const products = [
  {
    id: 1,
    name: 'Carrara Marmor',
    category: 'Marmor',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png',
    features: ['Poliert', 'Frostsicher', 'Innen & Außen'],
    description: 'Exklusiver Carrara Marmor aus Italien. Zeitlose Eleganz für anspruchsvolle Projekte.',
    categoryId: 'marmor',
    price: 89,
    origin: 'Italien',
    surface: 'Poliert',
    thickness: '20mm'
  },
  {
    id: 2,
    name: 'Kashmir White Granit',
    category: 'Granit',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png',
    features: ['Robust', 'Hitzebeständig', 'Pflegeleicht'],
    description: 'Hochwertiger Granit mit charakteristischer weißer Grundfarbe und dunklen Einsprengseln.',
    categoryId: 'granit',
    price: 65,
    origin: 'Indien',
    surface: 'Poliert',
    thickness: '30mm'
  },
  {
    id: 3,
    name: 'Römischer Travertin',
    category: 'Travertin',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b70b0803723582ed6.png',
    features: ['Antik', 'Rutschfest', 'Mediterran'],
    description: 'Authentischer römischer Travertin für mediterrane Eleganz.',
    categoryId: 'travertin',
    price: 45,
    origin: 'Italien',
    surface: 'Getrommelt',
    thickness: '25mm'
  },
  {
    id: 4,
    name: 'Mustang Schiefer',
    category: 'Schiefer',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b097a8069ca3ac95a.png',
    features: ['Spaltrau', 'Wetterfest', 'Modern'],
    description: 'Moderner Schiefer mit natürlicher Oberflächenstruktur.',
    categoryId: 'schiefer',
    price: 55,
    origin: 'Indien',
    surface: 'Spaltrau',
    thickness: '15mm'
  },
  {
    id: 5,
    name: 'Feinsteinzeug Premium',
    category: 'Keramik',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png',
    features: ['High-Tech', 'Dünn', 'Vielseitig'],
    description: 'Innovatives Feinsteinzeug mit High-Tech Eigenschaften.',
    categoryId: 'keramik',
    price: 75,
    origin: 'Deutschland',
    surface: 'Matt',
    thickness: '6mm'
  },
  {
    id: 6,
    name: 'Nero Marquina',
    category: 'Marmor',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png',
    features: ['Schwarz', 'Luxuriös', 'Exklusiv'],
    description: 'Luxuriöser schwarzer Marmor mit weißen Adern.',
    categoryId: 'marmor',
    price: 125,
    origin: 'Spanien',
    surface: 'Hochglanz poliert',
    thickness: '30mm'
  },
]

const filteredProducts = computed(() => {
  if (activeCategory.value === 'alle') {
    return products
  }
  return products.filter(product => product.categoryId === activeCategory.value)
})

const getProductCount = (categoryId) => {
  if (categoryId === 'alle') return products.length
  return products.filter(product => product.categoryId === categoryId).length
}

const openProductModal = (product) => {
  selectedProduct.value = product
  document.body.style.overflow = 'hidden'
}

const closeModal = () => {
  selectedProduct.value = null
  document.body.style.overflow = 'auto'
}

const createRipple = (event) => {
  const card = event.currentTarget
  const rippleContainer = card.querySelector('.interaction-ripples')
  
  const rect = card.getBoundingClientRect()
  const x = event.clientX - rect.left
  const y = event.clientY - rect.top
  
  const ripple = document.createElement('div')
  ripple.className = 'ripple'
  ripple.style.left = x + 'px'
  ripple.style.top = y + 'px'
  
  rippleContainer.appendChild(ripple)
  
  setTimeout(() => {
    ripple.remove()
  }, 1000)
}

const scrollToContent = () => {
  const filterSection = document.querySelector('.filter-section')
  if (filterSection) {
    filterSection.scrollIntoView({ behavior: 'smooth' })
  }
}

// Parallax functions
const handleScroll = () => {
  scrollY.value = window.scrollY
}

function updateParallax() {
  if (!heroBg.value || !heroContent.value || !heroSubheading.value) return

  const scrollY = window.scrollY
  const viewportHeight = window.innerHeight
  
  const heroScrollProgress = Math.min(scrollY / (viewportHeight * 0.8), 1)
  const bgScale = 1.05 + (heroScrollProgress * 0.1)
  const bgBrightness = Math.max(0.1, 1 - (heroScrollProgress * 1.5))
  const bgOpacity = Math.max(0, 1 - (heroScrollProgress * 1.2))
  
  heroBg.value.style.filter = `brightness(${bgBrightness})`
  heroBg.value.style.opacity = bgOpacity
  
  const textTranslateY = -scrollY * 0.6
  
  heroContent.value.style.transform = `translateY(${textTranslateY}px)`
  heroSubheading.value.style.transform = `translateY(${textTranslateY}px)`
  
  const textFadeStart = 0.7
  const textOpacity = heroScrollProgress < textFadeStart ? 1 : 
    Math.max(0, 1 - ((heroScrollProgress - textFadeStart) / (1 - textFadeStart)) * 2)
  
  heroContent.value.style.opacity = textOpacity
  heroSubheading.value.style.opacity = textOpacity
  
  ticking.value = false
}

function requestTick() {
  if (!ticking.value) {
    requestAnimationFrame(updateParallax)
    ticking.value = true
  }
}

// SEO Meta
useHead({
  title: 'Premium Naturstein Sortiment | Exklusive Auswahl',
  meta: [
    {
      name: 'description',
      content: 'Über 650 verschiedene Naturstein- und Keramik-Oberflächen auf 2500m² Showroom-Fläche. Entdecken Sie unsere exklusive Premium-Auswahl.'
    },
    {
      property: 'og:title',
      content: 'Premium Naturstein Sortiment | Exklusive Auswahl'
    },
    {
      property: 'og:description',
      content: 'Über 650 verschiedene Naturstein- und Keramik-Oberflächen auf 2500m² Showroom-Fläche. Entdecken Sie unsere exklusive Premium-Auswahl.'
    }
  ]
})

onMounted(() => {
  window.addEventListener('scroll', handleScroll, { passive: true })
  window.addEventListener('scroll', requestTick, { passive: true })
  updateParallax()
})

onUnmounted(() => {
  document.body.style.overflow = 'auto'
  window.removeEventListener('scroll', handleScroll)
  window.removeEventListener('scroll', requestTick)
})
</script>

<style scoped>
@import url('https://fonts.googleapis.com/icon?family=Material+Icons');

/* CSS Variables */
:root {
  --header-height: 80px;
  --primary-gold: #a47148;
  --primary-light: #FAFAF8;
  --bg-dark: #000;
  --bg-dark-alt: #0a0a0a;
  --text-gray: #999;
  --border-color: rgba(255, 255, 255, 0.1);
}

.sortiment-page {
  min-height: 100vh;
  background: #000;
  color: #FAFAF8;
  padding-top: 80px;
  position: relative;
  overflow-x: hidden;
}

/* Hero Section */
.hero {
  position: relative;
  height: 100vh;
  overflow: hidden;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

.hero-bg {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100vh;
  z-index: 0;
  will-change: transform, filter;
}

.hero-overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(
    to bottom,
    rgba(0,0,0,0.3) 0%,
    rgba(0,0,0,0.5) 50%,
    rgba(0,0,0,0.9) 100%
  );
  z-index: 1;
}

.hero-bg img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transform: scale(1.2);
  animation: zoomOut 3s ease-out forwards;
  transition: transform 0.3s ease;
}

.hero-content {
  position: absolute;
  top: 15%;
  left: 10%;
  z-index: 2;
  color: white;
  text-align: left;
  max-width: 1200px;
  will-change: transform;
}

.hero-badge {
  display: inline-block;
  padding: 0.8rem 2.5rem;
  background: rgba(0, 0, 0, 0.3);
  border: 3px solid var(--primary-gold);
  color: var(--primary-gold);
  font-size: 0.9rem;
  font-weight: 900;
  letter-spacing: 0.4em;
  margin-top: 1.5rem;
  clip-path: polygon(15px 0, 100% 0, calc(100% - 15px) 100%, 0 100%);
  backdrop-filter: blur(10px);
}

.hero-title {
  font-size: clamp(1.8rem, 5.5vw, 4.5rem);
  font-weight: 900;
  line-height: 1;
  opacity: 1;
  transform: translateY(0);
  color: var(--primary-light);
  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
  animation: slideUpWord 1.5s cubic-bezier(0.68, -0.55, 0.265, 1.55) forwards;
  text-align: left;
  display: flex;
  justify-content: flex-start;
  margin-bottom: 0;
}

.hero-subheading {
  position: absolute;
  bottom: 25%;
  left: 10%;
  transform: translateX(0);
  z-index: 2;
  text-align: left;
  width: 90%;
  max-width: 800px;
  will-change: transform;
}

.hero-subheading p {
  font-size: clamp(1.1rem, 1.8vw, 1.6rem);
  color: #e6e0d5;
  margin: 0;
  line-height: 1.3;
  font-weight: 300;
  opacity: 0;
  transform: translateY(30px);
  animation: slideUpFromBottom 1.8s ease-out 1.2s forwards;
  padding: 0.8rem 1.5rem;
  border-radius: 8px;
}

.scroll-indicator {
  position: absolute;
  bottom: 4rem;
  left: 50%;
  transform: translateX(-50%);
  cursor: pointer;
  animation: bounce 2s infinite;
  z-index: 10;
  color: var(--primary-gold);
  background: rgba(0, 0, 0, 0.3);
  border-radius: 50%;
  width: 60px;
  height: 60px;
  display: flex;
  align-items: center;
  justify-content: center;
  backdrop-filter: blur(10px);
  border: 2px solid rgba(164, 113, 72, 0.3);
  transition: all 0.3s ease;
}

.scroll-indicator:hover {
  background: rgba(164, 113, 72, 0.2);
  border-color: var(--primary-gold);
  transform: translateX(-50%) scale(1.1);
}

.scroll-indicator .material-icons {
  font-size: 2.5rem;
  color: var(--primary-gold);
  text-shadow: 0 0 20px rgba(164, 113, 72, 0.5);
}

/* Maps Section */
.maps-section {
  position: relative;
  z-index: 1;
}

/* Animations */
@keyframes zoomOut {
  0% {
    transform: scale(1.2);
    filter: blur(2px);
  }
  100% {
    transform: scale(1);
    filter: blur(0px);
  }
}

@keyframes slideUpFromBottom {
  0% {
    opacity: 0;
    transform: translateY(30px);
  }
  100% {
    opacity: 1;
    transform: translateY(0);
  }
}

@keyframes slideUpWord {
  0% {
    opacity: 0;
    transform: translateY(50px);
  }
  100% {
    opacity: 1;
    transform: translateY(0);
  }
}

@keyframes bounce {
  0%, 100% { transform: translateX(-50%) translateY(0); }
  50% { transform: translateX(-50%) translateY(10px); }
}

.animate-fade-in {
  animation: fadeIn 1s ease-out;
}

@keyframes fadeIn {
  from { opacity: 0; }
  to { opacity: 1; }
}

/* Filter Section */
.filter-section {
  padding: 6rem 0;
  background: 
    radial-gradient(circle at 25% 25%, rgba(164, 113, 72, 0.15) 0%, transparent 60%),
    radial-gradient(circle at 75% 75%, rgba(255, 215, 0, 0.08) 0%, transparent 50%),
    linear-gradient(135deg, #0a0a0a 0%, #1a1a1a 50%, #0f0f0f 100%);
  position: relative;
}

.filter-section::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: 
    url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23a47148' fill-opacity='0.03'%3E%3Cpolygon points='30,0 60,30 30,60 0,30'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
  animation: patternShift 20s linear infinite;
}

@keyframes patternShift {
  0% { transform: translateX(0) translateY(0); }
  100% { transform: translateX(-60px) translateY(-60px); }
}

.container {
  max-width: 1400px;
  margin: 0 auto;
  padding: 0 2rem;
  position: relative;
  z-index: 2;
}

.filter-background-glow {
  position: absolute;
  inset: -20px;
  background: radial-gradient(ellipse, rgba(164, 113, 72, 0.1), transparent);
  filter: blur(30px);
  opacity: 0.7;
}

.section-header {
  text-align: center;
  margin-bottom: 4rem;
}

.header-decoration {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 2rem;
  margin-bottom: 2rem;
}

.decoration-line {
  width: 100px;
  height: 1px;
  background: linear-gradient(90deg, transparent, #a47148);
}

.decoration-line.left {
  background: linear-gradient(90deg, transparent, #a47148);
}

.decoration-line.right {
  background: linear-gradient(90deg, #a47148, transparent);
}

.section-badge.premium {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.75rem 1.5rem;
  background: linear-gradient(135deg, rgba(164, 113, 72, 0.2), rgba(255, 255, 255, 0.05));
  border: 1px solid rgba(164, 113, 72, 0.3);
  border-radius: 50px;
  backdrop-filter: blur(20px);
  animation: badgeGlow 3s ease-in-out infinite;
  font-size: 0.75rem;
  letter-spacing: 0.1em;
  font-weight: 600;
  color: #a47148;
}

@keyframes badgeGlow {
  0%, 100% { box-shadow: 0 0 0 rgba(164, 113, 72, 0.5); }
  50% { box-shadow: 0 0 30px rgba(164, 113, 72, 0.4); }
}

.section-title {
  font-size: 2.5rem;
  font-weight: 300;
  margin-bottom: 1rem;
}

.title-gradient {
  background: linear-gradient(135deg, #FAFAF8 0%, #a47148 50%, #FAFAF8 100%);
  background-size: 200% 100%;
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  animation: titleShimmer 4s ease-in-out infinite;
}

@keyframes titleShimmer {
  0%, 100% { background-position: 200% 0; }
  50% { background-position: -200% 0; }
}

.filter-buttons {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 1.5rem;
}

.luxury-filter-btn {
  position: relative;
  background: transparent;
  border: none;
  cursor: pointer;
  overflow: hidden;
  border-radius: 20px;
  transition: all 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  animation: filterBtnIn 0.8s ease-out backwards;
}

@keyframes filterBtnIn {
  from {
    opacity: 0;
    transform: translateY(30px) scale(0.9);
  }
  to {
    opacity: 1;
    transform: translateY(0) scale(1);
  }
}

.btn-background {
  position: absolute;
  inset: 0;
  border-radius: 20px;
}

.bg-gradient {
  position: absolute;
  inset: 0;
  background: linear-gradient(135deg, 
    rgba(255, 255, 255, 0.05) 0%, 
    rgba(255, 255, 255, 0.02) 100%);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 20px;
  transition: all 0.6s ease;
}

.luxury-filter-btn.active .bg-gradient {
  background: linear-gradient(135deg, 
    rgba(164, 113, 72, 0.3) 0%, 
    rgba(164, 113, 72, 0.1) 100%);
  border-color: #a47148;
  box-shadow: 
    0 10px 30px rgba(164, 113, 72, 0.3),
    inset 0 0 50px rgba(164, 113, 72, 0.1);
}

.bg-shine {
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.1), transparent);
  transition: left 0.6s ease;
  border-radius: 20px;
}

.luxury-filter-btn:hover .bg-shine {
  left: 100%;
}

.btn-content {
  position: relative;
  z-index: 2;
  display: flex;
  align-items: center;
  gap: 1rem;
  padding: 1.5rem;
  text-align: left;
}

.btn-icon {
  width: 50px;
  height: 50px;
  background: linear-gradient(135deg, rgba(164, 113, 72, 0.2), rgba(255, 255, 255, 0.1));
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.6s ease;
  flex-shrink: 0;
}

.btn-icon .material-icons {
  color: #a47148;
  font-size: 1.5rem;
  transition: all 0.6s ease;
}

.luxury-filter-btn.active .btn-icon {
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  transform: scale(1.1);
}

.luxury-filter-btn.active .btn-icon .material-icons {
  color: #000;
}

.btn-text {
  display: flex;
  flex-direction: column;
  gap: 0.25rem;
}

.btn-name {
  font-size: 1rem;
  font-weight: 500;
  color: #FAFAF8;
  transition: color 0.3s ease;
}

.btn-count {
  font-size: 0.8rem;
  color: #999;
  transition: color 0.3s ease;
}

.luxury-filter-btn.active .btn-name {
  color: #a47148;
}

.luxury-filter-btn.active .btn-count {
  color: #a47148;
}

.btn-particles {
  position: absolute;
  inset: 0;
  overflow: hidden;
  border-radius: 20px;
  pointer-events: none;
}

.filter-particle {
  position: absolute;
  width: 3px;
  height: 3px;
  background: #a47148;
  border-radius: 50%;
  opacity: 0;
  animation: filterParticleFloat 3s ease-out infinite;
}

.filter-particle:nth-child(1) { top: 20%; left: 20%; animation-delay: 0s; }
.filter-particle:nth-child(2) { top: 40%; left: 80%; animation-delay: 0.5s; }
.filter-particle:nth-child(3) { top: 70%; left: 30%; animation-delay: 1s; }
.filter-particle:nth-child(4) { top: 80%; left: 70%; animation-delay: 1.5s; }
.filter-particle:nth-child(5) { top: 30%; left: 50%; animation-delay: 2s; }
.filter-particle:nth-child(6) { top: 60%; left: 10%; animation-delay: 2.5s; }

@keyframes filterParticleFloat {
  0%, 100% {
    opacity: 0;
    transform: translateY(0) scale(0);
  }
  50% {
    opacity: 1;
    transform: translateY(-20px) scale(1);
  }
}

.luxury-filter-btn.active .filter-particle {
  animation-duration: 2s;
  background: #FAFAF8;
}

.luxury-filter-btn:hover {
  transform: translateY(-5px) scale(1.02);
}

/* Products Section */
.products-section {
  padding: 6rem 0;
  background: linear-gradient(135deg, #0a0a0a 0%, #1a1a1a 50%, #0f0f0f 100%);
}

.products-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 4rem;
  padding: 0 1rem;
}

.products-title {
  font-size: 2rem;
  font-weight: 400;
  background: linear-gradient(135deg, #FAFAF8 0%, #a47148 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.products-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(380px, 1fr));
  gap: 3rem;
  padding: 2rem 0;
}

.luxury-product-card {
  position: relative;
  min-height: 550px;
  border-radius: 24px;
  overflow: hidden;
  cursor: pointer;
  transition: all 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  opacity: 0;
  transform: translateY(100px) rotateX(-15deg) scale(0.8);
  animation: luxuryCardReveal 1.2s cubic-bezier(0.25, 0.46, 0.45, 0.94) forwards;
  border: 1px solid rgba(255, 255, 255, 0.1);
  background: linear-gradient(135deg, rgba(255, 255, 255, 0.05) 0%, rgba(255, 255, 255, 0.02) 100%);
  backdrop-filter: blur(10px);
}

@keyframes luxuryCardReveal {
  to {
    opacity: 1;
    transform: translateY(0) rotateX(0) scale(1);
  }
}

.luxury-product-card:hover {
  transform: translateY(-20px) rotateX(3deg) scale(1.03);
  box-shadow: 
    0 40px 80px rgba(164, 113, 72, 0.4),
    0 0 0 1px rgba(164, 113, 72, 0.3),
    inset 0 0 50px rgba(164, 113, 72, 0.1);
}

.card-background {
  position: absolute;
  inset: 0;
  overflow: hidden;
  border-radius: 24px;
}

.morphing-blob {
  position: absolute;
  border-radius: 50%;
  filter: blur(40px);
  animation: blobMorph 8s ease-in-out infinite;
  opacity: 0.3;
}

.blob-1 {
  width: 200px;
  height: 200px;
  background: radial-gradient(circle, rgba(164, 113, 72, 0.8), transparent);
  top: 20%;
  left: 10%;
}

.blob-2 {
  width: 150px;
  height: 150px;
  background: radial-gradient(circle, rgba(255, 215, 0, 0.6), transparent);
  bottom: 20%;
  right: 15%;
  animation-delay: -4s;
}

@keyframes blobMorph {
  0%, 100% {
    transform: scale(1) rotate(0deg);
    border-radius: 50%;
  }
  25% {
    transform: scale(1.2) rotate(90deg);
    border-radius: 30% 70% 70% 30% / 30% 30% 70% 70%;
  }
  50% {
    transform: scale(0.8) rotate(180deg);
    border-radius: 70% 30% 30% 70% / 70% 70% 30% 30%;
  }
  75% {
    transform: scale(1.1) rotate(270deg);
    border-radius: 40% 60% 60% 40% / 60% 40% 60% 40%;
  }
}

.energy-waves {
  position: absolute;
  inset: 0;
  overflow: hidden;
}

.wave {
  position: absolute;
  top: 50%;
  left: 50%;
  width: 20px;
  height: 20px;
  border: 2px solid rgba(164, 113, 72, 0.3);
  border-radius: 50%;
  transform: translate(-50%, -50%);
  animation: waveExpand 3s ease-out infinite;
}

@keyframes waveExpand {
  0% {
    width: 20px;
    height: 20px;
    opacity: 1;
  }
  100% {
    width: 600px;
    height: 600px;
    opacity: 0;
  }
}

.product-image-container {
  position: relative;
  height: 280px;
  overflow: hidden;
  z-index: 2;
}

.product-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.8s ease;
}

.luxury-product-card:hover .product-image {
  transform: scale(1.1);
}

.product-overlay {
  position: absolute;
  inset: 0;
  background: rgba(0, 0, 0, 0.7);
  display: flex;
  align-items: center;
  justify-content: center;
  opacity: 0;
  transition: opacity 0.4s ease;
}

.luxury-product-card:hover .product-overlay {
  opacity: 1;
}

.product-actions {
  display: flex;
  gap: 1rem;
}

.action-btn {
  width: 50px;
  height: 50px;
  background: rgba(255, 255, 255, 0.2);
  border: none;
  border-radius: 50%;
  color: #FAFAF8;
  cursor: pointer;
  transition: all 0.3s ease;
  backdrop-filter: blur(10px);
  display: flex;
  align-items: center;
  justify-content: center;
}

.action-btn:hover {
  background: #a47148;
  transform: scale(1.1);
}

.image-glow {
  position: absolute;
  inset: -2px;
  background: linear-gradient(45deg, transparent, rgba(164, 113, 72, 0.3), transparent);
  border-radius: 24px;
  opacity: 0;
  transition: opacity 0.6s ease;
  z-index: 1;
}

.luxury-product-card:hover .image-glow {
  opacity: 1;
}

.product-info {
  position: relative;
  z-index: 3;
  padding: 2rem;
  background: rgba(0, 0, 0, 0.4);
  backdrop-filter: blur(20px);
}

.product-header {
  margin-bottom: 1.5rem;
}

.product-name {
  font-size: 1.5rem;
  font-weight: 500;
  margin-bottom: 0.5rem;
  color: #FAFAF8;
  overflow: hidden;
}

.title-char {
  display: inline-block;
  opacity: 0;
  transform: translateY(20px) rotateX(-90deg);
  animation: charReveal 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94) forwards;
}

@keyframes charReveal {
  to {
    opacity: 1;
    transform: translateY(0) rotateX(0);
  }
}

.product-category {
  font-size: 0.875rem;
  color: #a47148;
  text-transform: uppercase;
  letter-spacing: 0.1em;
  font-weight: 500;
}

.product-features {
  display: flex;
  gap: 0.5rem;
  flex-wrap: wrap;
  margin-bottom: 1.5rem;
}

.feature-tag {
  padding: 0.25rem 0.75rem;
  background: rgba(164, 113, 72, 0.2);
  color: #a47148;
  font-size: 0.75rem;
  border-radius: 15px;
  border: 1px solid rgba(164, 113, 72, 0.3);
  font-weight: 500;
}

.product-price {
  display: flex;
  align-items: baseline;
  gap: 0.5rem;
  font-weight: 600;
}

.price-label {
  font-size: 0.875rem;
  color: #ccc;
}

.price-value {
  font-size: 1.25rem;
  color: #a47148;
}

.price-unit {
  font-size: 0.875rem;
  color: #ccc;
}

.corner-accents {
  position: absolute;
  inset: 0;
  pointer-events: none;
  border-radius: 24px;
  z-index: 4;
}

.corner {
  position: absolute;
  width: 20px;
  height: 20px;
  border: 2px solid #a47148;
  opacity: 0;
  transition: all 0.6s ease;
}

.corner.top-left {
  top: 15px;
  left: 15px;
  border-right: none;
  border-bottom: none;
}

.corner.top-right {
  top: 15px;
  right: 15px;
  border-left: none;
  border-bottom: none;
}

.corner.bottom-left {
  bottom: 15px;
  left: 15px;
  border-right: none;
  border-top: none;
}

.corner.bottom-right {
  bottom: 15px;
  right: 15px;
  border-left: none;
  border-top: none;
}

.luxury-product-card:hover .corner {
  opacity: 1;
  transform: scale(1.2);
}

.interaction-ripples {
  position: absolute;
  inset: 0;
  pointer-events: none;
  border-radius: 24px;
  overflow: hidden;
  z-index: 5;
}

.ripple {
  position: absolute;
  border-radius: 50%;
  background: radial-gradient(circle, rgba(164, 113, 72, 0.3), transparent);
  animation: rippleExpand 1s ease-out;
  pointer-events: none;
}

@keyframes rippleExpand {
  from {
    width: 0;
    height: 0;
    opacity: 1;
  }
  to {
    width: 300px;
    height: 300px;
    opacity: 0;
  }
}

/* Modal */
.modal-overlay {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.95);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
  backdrop-filter: blur(20px);
}

.modal-content {
  background: linear-gradient(135deg, #1a1a1a 0%, #0a0a0a 100%);
  border-radius: 24px;
  max-width: 1000px;
  width: 90%;
  max-height: 90vh;
  overflow-y: auto;
  position: relative;
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.modal-decorations {
  position: absolute;
  inset: 0;
  pointer-events: none;
  z-index: 1;
}

.decoration-circle {
  position: absolute;
  border-radius: 50%;
  border: 1px solid rgba(164, 113, 72, 0.3);
  animation: decorationFloat 6s ease-in-out infinite;
}

.circle-1 {
  width: 100px;
  height: 100px;
  top: 20%;
  left: 10%;
}

.circle-2 {
  width: 60px;
  height: 60px;
  top: 60%;
  right: 15%;
  animation-delay: -2s;
}

.circle-3 {
  width: 80px;
  height: 80px;
  bottom: 20%;
  left: 20%;
  animation-delay: -4s;
}

@keyframes decorationFloat {
  0%, 100% { transform: translateY(0) rotate(0deg); }
  50% { transform: translateY(-20px) rotate(180deg); }
}

.modal-close {
  position: absolute;
  top: 1rem;
  right: 1rem;
  background: rgba(255, 255, 255, 0.1);
  border: none;
  border-radius: 50%;
  width: 50px;
  height: 50px;
  color: #FAFAF8;
  cursor: pointer;
  z-index: 10;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  justify-content: center;
}

.modal-close:hover {
  background: rgba(255, 255, 255, 0.2);
  transform: rotate(90deg) scale(1.1);
}

.modal-body {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 3rem;
  position: relative;
  z-index: 2;
}

.modal-image {
  position: relative;
  padding: 2rem;
}

.modal-image img {
  width: 100%;
  height: 450px;
  object-fit: cover;
  border-radius: 16px;
}

.modal-info {
  padding: 2rem;
  display: flex;
  flex-direction: column;
  gap: 2rem;
}

.modal-header {
  padding-bottom: 1rem;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.modal-title {
  font-size: 2.5rem;
  font-weight: 400;
  margin-bottom: 1rem;
  background: linear-gradient(135deg, #FAFAF8 0%, #a47148 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  line-height: 1.2;
}

.modal-description {
  font-size: 1.1rem;
  line-height: 1.8;
  color: #ccc;
}

.modal-specs h4 {
  font-size: 1.25rem;
  margin-bottom: 1rem;
  color: #FAFAF8;
}

.specs-grid {
  display: grid;
  gap: 1rem;
}

.spec-item {
  display: flex;
  justify-content: space-between;
  padding: 0.75rem 0;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.spec-label {
  color: #ccc;
  font-weight: 500;
}

.spec-value {
  color: #a47148;
  font-weight: 600;
}

.modal-actions {
  display: flex;
  gap: 1rem;
  margin-top: auto;
}

/* Buttons */
.cta-button {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  padding: 1rem 2rem;
  font-size: 1rem;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  border-radius: 50px;
  text-decoration: none;
  cursor: pointer;
  transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  position: relative;
  overflow: hidden;
  border: none;
}

.cta-button.primary {
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  color: #000;
}

.cta-button:hover {
  transform: translateY(-3px);
  box-shadow: 0 15px 30px rgba(164, 113, 72, 0.4);
}

/* Modal Transitions */
.modal-enter-active,
.modal-leave-active {
  transition: opacity 0.4s ease;
}

.modal-enter-from,
.modal-leave-to {
  opacity: 0;
}

.modal-enter-active .modal-content,
.modal-leave-active .modal-content {
  transition: transform 0.4s ease;
}

.modal-enter-from .modal-content,
.modal-leave-to .modal-content {
  transform: scale(0.8) rotateX(-15deg);
}

/* Responsive */
@media (max-width: 768px) {
  .hero-title {
    font-size: clamp(1.5rem, 5vw, 3rem);
  }
  
  .hero-subheading {
    bottom: 30%;
  }
  
  .hero-subheading p {
    font-size: clamp(1rem, 2.5vw, 1.4rem);
    padding: 0.6rem 1rem;
  }
  
  .scroll-indicator {
    bottom: 6rem;
    width: 50px;
    height: 50px;
  }
  
  .scroll-indicator .material-icons {
    font-size: 2rem;
  }
  
  .products-grid {
    grid-template-columns: 1fr;
    gap: 2rem;
  }
  
  .modal-body {
    grid-template-columns: 1fr;
    gap: 2rem;
  }
  
  .modal-image img {
    height: 300px;
  }
  
  .filter-buttons {
    grid-template-columns: 1fr;
    gap: 1rem;
  }
  
  .products-header {
    flex-direction: column;
    gap: 1rem;
    text-align: center;
  }
}

@media (max-width: 480px) {
  .container {
    padding: 0 1rem;
  }
  
  .hero-content {
    left: 5%;
    top: 12%;
  }
  
  .hero-subheading {
    left: 5%;
    width: 85%;
    bottom: 35%;
  }
  
  .hero-badge {
    padding: 0.6rem 2rem;
    font-size: 0.8rem;
    margin-top: 1rem;
  }
  
  .scroll-indicator {
    bottom: 8rem;
  }
  
  .section-title {
    font-size: 2rem;
  }
  
  .modal-content {
    width: 95%;
    margin: 1rem;
  }
  
  .modal-info {
    padding: 1.5rem;
  }
  
  .modal-actions {
    flex-direction: column;
  }
}
</style>