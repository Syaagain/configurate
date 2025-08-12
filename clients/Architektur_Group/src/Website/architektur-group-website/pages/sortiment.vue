<template>
  <div class="sortiment-page">
    <!-- Hero Section -->
    <section class="hero-section">
      <div class="hero-background">
        <div class="hero-overlay"></div>
        <img 
          src="https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png" 
          alt="Sortiment"
          class="hero-image"
        >
        <div class="hero-particles">
          <div v-for="n in 12" :key="n" class="floating-particle" :style="{ 
            left: Math.random() * 100 + '%',
            animationDelay: Math.random() * 4 + 's',
            animationDuration: (3 + Math.random() * 2) + 's'
          }"></div>
        </div>
      </div>
      <div class="hero-content">
        <div class="hero-text">
          <h1 class="hero-title">
            <span v-for="(word, index) in heroWords" 
                  :key="index" 
                  class="title-word" 
                  :style="{ animationDelay: index * 0.3 + 's' }">
              {{ word }}
            </span>
          </h1>
          <p class="hero-subtitle">Über 200 verschiedene Naturstein- und Keramik-Oberflächen</p>
          <div class="hero-stats">
            <div class="stat-item">
              <span class="stat-number">650+</span>
              <span class="stat-label">Natursteinsorten</span>
            </div>
            <div class="stat-divider"></div>
            <div class="stat-item">
              <span class="stat-number">2500m²</span>
              <span class="stat-label">Showroom-Fläche</span>
            </div>
          </div>
        </div>
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
              PREMIUM AUSWAHL
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
            {{ activeCategory === 'alle' ? 'Gesamte Kollektion' : categories.find(c => c.id === activeCategory)?.name }}
          </h3>
          <div class="products-count">{{ filteredProducts.length }} Produkte</div>
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
                  <button class="action-btn favorite">
                    <span class="material-icons">favorite_border</span>
                  </button>
                  <button class="action-btn share">
                    <span class="material-icons">share</span>
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
              <div class="image-overlay-effects">
                <div class="shimmer-effect"></div>
              </div>
            </div>
            <div class="modal-info">
              <div class="modal-header">
                <span class="modal-badge">{{ selectedProduct.category }}</span>
                <h2 class="modal-title">{{ selectedProduct.name }}</h2>
                <div class="modal-rating">
                  <div class="stars">
                    <span v-for="n in 5" :key="n" class="material-icons star">star</span>
                  </div>
                  <span class="rating-text">Premium Qualität</span>
                </div>
              </div>
              
              <p class="modal-description">{{ selectedProduct.description }}</p>
              
              <div class="modal-features">
                <h4>Eigenschaften:</h4>
                <div class="features-grid">
                  <div v-for="feature in selectedProduct.features" :key="feature" class="feature-item">
                    <span class="material-icons">check_circle</span>
                    <span>{{ feature }}</span>
                  </div>
                </div>
              </div>
              
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
                <button class="secondary-button">
                  <span class="material-icons">info</span>
                  MEHR INFORMATIONEN
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </transition>

    <!-- Showroom CTA -->
    <section class="showroom-cta">
      <div class="container">
        <div class="section-header center">
          <div class="header-decoration">
            <div class="decoration-line left"></div>
            <div class="section-badge premium">
              <span class="material-icons">location_on</span>
              SHOWROOMS
            </div>
            <div class="decoration-line right"></div>
          </div>
          <h2 class="section-title">
            <span class="title-gradient">BESUCHEN SIE UNS</span>
          </h2>
        </div>
        
        <div class="cta-grid">
          <div class="cta-card munich">
            <div class="card-background">
              <img src="https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686576cf622e38e88f0236c5.png" alt="München">
              <div class="card-overlay"></div>
            </div>
            <div class="card-content">
              <span class="location-badge">SHOWROOM</span>
              <h3>MÜNCHEN / STARNBERG</h3>
              <p>Lassen Sie sich in unserem Showroom im Großraum München inspirieren!</p>
              <div class="card-features">
                <span><span class="material-icons">square_foot</span> 2.500 m² Showroom</span>
                <span><span class="material-icons">inventory</span> 650+ Natursteinsorten</span>
              </div>
              <a href="/kontakt" class="card-btn">
                TERMIN VEREINBAREN
                <span class="material-icons">calendar_today</span>
              </a>
            </div>
          </div>
          
          <div class="cta-card dusseldorf">
            <div class="card-background">
              <img src="https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png" alt="Düsseldorf">
              <div class="card-overlay"></div>
            </div>
            <div class="card-content">
              <span class="location-badge">SHOWROOM</span>
              <h3>DÜSSELDORF / NEUSS</h3>
              <p>Besuchen Sie Europas größte Auswahl an Premium Natursteinen!</p>
              <div class="card-features">
                <span><span class="material-icons">visibility</span> 1.500 m² Showroom</span>
                <span><span class="material-icons">local_shipping</span> Europaweite Lieferung</span>
              </div>
              <a href="/kontakt" class="card-btn">
                TERMIN VEREINBAREN
                <span class="material-icons">calendar_today</span>
              </a>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
const activeCategory = ref('alle')
const selectedProduct = ref(null)

const heroWords = ['EXKLUSIVES', 'SORTIMENT']

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
  {
    id: 7,
    name: 'Jura Gelb',
    category: 'Kalkstein',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b70b0803723582ed6.png',
    features: ['Regional', 'Nachhaltig', 'Klassisch'],
    description: 'Regionaler Jura Kalkstein in warmer gelber Färbung.',
    categoryId: 'travertin',
    price: 38,
    origin: 'Deutschland',
    surface: 'Gesägt',
    thickness: '40mm'
  },
  {
    id: 8,
    name: 'Basalt Anthrazit',
    category: 'Basalt',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b097a8069ca3ac95a.png',
    features: ['Vulkanisch', 'Extrem Hart', 'Zeitlos'],
    description: 'Vulkanischer Basalt in elegantem Anthrazit.',
    categoryId: 'schiefer',
    price: 68,
    origin: 'Deutschland',
    surface: 'Geflammt',
    thickness: '30mm'
  }
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

onUnmounted(() => {
  document.body.style.overflow = 'auto'
})
</script>

<style scoped>
@import url('https://fonts.googleapis.com/icon?family=Material+Icons');

.sortiment-page {
  min-height: 100vh;
  background: #000;
  color: #FAFAF8;
  padding-top: 80px;
  position: relative;
  overflow-x: hidden;
}

/* Hero Section */
.hero-section {
  position: relative;
  height: 80vh;
  overflow: hidden;
  display: flex;
  align-items: center;
  justify-content: center;
}

.hero-background {
  position: absolute;
  inset: 0;
}

.hero-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.hero-overlay {
  position: absolute;
  inset: 0;
  background: 
    radial-gradient(circle at 30% 30%, rgba(164, 113, 72, 0.3) 0%, transparent 60%),
    linear-gradient(45deg, rgba(0,0,0,0.8), rgba(164, 113, 72, 0.2));
  z-index: 1;
}

.hero-particles {
  position: absolute;
  inset: 0;
  overflow: hidden;
  z-index: 1;
}

.floating-particle {
  position: absolute;
  width: 4px;
  height: 4px;
  background: radial-gradient(circle, #a47148, transparent);
  border-radius: 50%;
  animation: floatParticle 4s ease-in-out infinite;
}

@keyframes floatParticle {
  0%, 100% {
    transform: translateY(100px) translateX(0) scale(0);
    opacity: 0;
  }
  10% {
    opacity: 1;
    transform: translateY(80px) translateX(10px) scale(1);
  }
  90% {
    opacity: 1;
    transform: translateY(-50px) translateX(-10px) scale(0.5);
  }
  100% {
    opacity: 0;
  }
}

.hero-content {
  position: relative;
  z-index: 2;
  text-align: center;
  max-width: 1000px;
  padding: 0 2rem;
}

.hero-badge {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.75rem 2rem;
  background: linear-gradient(135deg, rgba(164, 113, 72, 0.3), rgba(255, 255, 255, 0.1));
  border: 1px solid rgba(164, 113, 72, 0.5);
  border-radius: 50px;
  backdrop-filter: blur(20px);
  font-size: 0.875rem;
  font-weight: 600;
  letter-spacing: 0.1em;
  color: #a47148;
  margin-bottom: 2rem;
  animation: badgeGlow 3s ease-in-out infinite;
}

@keyframes badgeGlow {
  0%, 100% { box-shadow: 0 0 0 rgba(164, 113, 72, 0.5); }
  50% { box-shadow: 0 0 30px rgba(164, 113, 72, 0.4); }
}

.hero-title {
  font-size: clamp(3rem, 8vw, 6rem);
  font-weight: 300;
  letter-spacing: 0.02em;
  margin-bottom: 2rem;
  line-height: 1.1;
}

.title-word {
  display: inline-block;
  margin-right: 2rem;
  opacity: 0;
  transform: translateY(50px) rotateX(-90deg);
  animation: titleWordReveal 1.2s cubic-bezier(0.25, 0.46, 0.45, 0.94) forwards;
  background: linear-gradient(135deg, #FAFAF8 0%, #a47148 50%, #FAFAF8 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-size: 200% 100%;
  animation: titleWordReveal 1.2s cubic-bezier(0.25, 0.46, 0.45, 0.94) forwards,
             shimmerEffect 3s ease-in-out infinite 1.5s;
}

@keyframes titleWordReveal {
  to {
    opacity: 1;
    transform: translateY(0) rotateX(0);
  }
}

@keyframes shimmerEffect {
  0%, 100% { background-position: 200% 0; }
  50% { background-position: -200% 0; }
}

.hero-subtitle {
  font-size: 1.5rem;
  font-weight: 300;
  opacity: 0.9;
  margin-bottom: 3rem;
  animation: fadeInUp 1s ease-out 1s backwards;
}

.hero-stats {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 3rem;
  animation: fadeInUp 1s ease-out 1.2s backwards;
}

.stat-item {
  text-align: center;
}

.stat-number {
  display: block;
  font-size: 2.5rem;
  font-weight: 600;
  color: #a47148;
  line-height: 1;
}

.stat-label {
  font-size: 0.875rem;
  color: #ccc;
  text-transform: uppercase;
  letter-spacing: 0.1em;
}

.stat-divider {
  width: 1px;
  height: 60px;
  background: linear-gradient(to bottom, transparent, #a47148, transparent);
}

@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
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

.section-header.center {
  text-align: center;
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

.products-count {
  padding: 0.5rem 1.5rem;
  background: rgba(164, 113, 72, 0.2);
  border: 1px solid rgba(164, 113, 72, 0.3);
  border-radius: 25px;
  color: #a47148;
  font-size: 0.875rem;
  font-weight: 500;
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

.image-overlay-effects {
  position: absolute;
  inset: 2rem;
  border-radius: 16px;
  overflow: hidden;
}

.shimmer-effect {
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
  animation: shimmer 3s ease-in-out infinite;
}

@keyframes shimmer {
  0% { left: -100%; }
  100% { left: 100%; }
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

.modal-badge {
  display: inline-block;
  padding: 0.5rem 1rem;
  background: rgba(164, 113, 72, 0.2);
  color: #a47148;
  border-radius: 20px;
  font-size: 0.75rem;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.1em;
  margin-bottom: 1rem;
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

.modal-rating {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.stars {
  display: flex;
  gap: 0.25rem;
}

.star {
  color: #a47148;
  font-size: 1.25rem;
}

.rating-text {
  color: #ccc;
  font-size: 0.875rem;
}

.modal-description {
  font-size: 1.1rem;
  line-height: 1.8;
  color: #ccc;
}

.modal-features h4,
.modal-specs h4 {
  font-size: 1.25rem;
  margin-bottom: 1rem;
  color: #FAFAF8;
}

.features-grid {
  display: grid;
  gap: 0.75rem;
}

.feature-item {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  color: #ccc;
}

.feature-item .material-icons {
  color: #a47148;
  font-size: 1.25rem;
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
.cta-button,
.secondary-button {
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

.secondary-button {
  background: transparent;
  color: #FAFAF8;
  border: 2px solid #FAFAF8;
}

.cta-button:hover {
  transform: translateY(-3px);
  box-shadow: 0 15px 30px rgba(164, 113, 72, 0.4);
}

.secondary-button:hover {
  background: #FAFAF8;
  color: #000;
}

/* Showroom CTA */
.showroom-cta {
  padding: 8rem 0;
  background: 
    radial-gradient(circle at 30% 20%, rgba(164, 113, 72, 0.08) 0%, transparent 60%),
    radial-gradient(circle at 70% 80%, rgba(164, 113, 72, 0.05) 0%, transparent 50%),
    linear-gradient(135deg, #0a0a0a 0%, #1a1a1a 50%, #0f0f0f 100%);
  position: relative;
}

.cta-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(500px, 1fr));
  gap: 3rem;
  margin-top: 4rem;
}

.cta-card {
  position: relative;
  height: 500px;
  border-radius: 24px;
  overflow: hidden;
  transition: all 0.6s ease;
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.cta-card:hover {
  transform: translateY(-10px) scale(1.02);
  box-shadow: 0 30px 60px rgba(164, 113, 72, 0.3);
}

.card-background {
  position: absolute;
  inset: 0;
}

.card-background img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.6s ease;
}

.cta-card:hover .card-background img {
  transform: scale(1.1);
}

.card-overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(45deg, rgba(0,0,0,0.8), rgba(164, 113, 72, 0.3));
}

.card-content {
  position: relative;
  z-index: 2;
  height: 100%;
  padding: 3rem;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  color: #FAFAF8;
}

.location-badge {
  display: inline-block;
  padding: 0.5rem 1rem;
  background: rgba(164, 113, 72, 0.8);
  color: #FAFAF8;
  border-radius: 20px;
  font-size: 0.75rem;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.1em;
  width: fit-content;
  margin-bottom: 1rem;
}

.card-content h3 {
  font-size: 2rem;
  font-weight: 400;
  margin-bottom: 1rem;
  background: linear-gradient(135deg, #FAFAF8 0%, #a47148 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.card-content p {
  font-size: 1.1rem;
  line-height: 1.6;
  margin-bottom: 2rem;
  opacity: 0.9;
}

.card-features {
  display: flex;
  flex-direction: column;
  gap: 1rem;
  margin-bottom: 2rem;
}

.card-features span {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  font-size: 0.95rem;
  opacity: 0.8;
}

.card-features .material-icons {
  color: #a47148;
  font-size: 1.25rem;
}

.card-btn {
  display: inline-flex;
  align-items: center;
  gap: 0.75rem;
  padding: 1rem 2rem;
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  color: #000;
  text-decoration: none;
  border-radius: 50px;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  transition: all 0.4s ease;
  width: fit-content;
}

.card-btn:hover {
  transform: translateY(-3px);
  box-shadow: 0 15px 30px rgba(164, 113, 72, 0.5);
}

/* Final CTA Section */
.final-cta-section {
  padding: 8rem 0;
  background: linear-gradient(135deg, #1a1a1a 0%, #0a0a0a 100%);
  text-align: center;
}

.cta-content {
  max-width: 800px;
  margin: 0 auto;
}

.cta-icon {
  width: 80px;
  height: 80px;
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 2rem;
  animation: iconFloat 3s ease-in-out infinite;
}

@keyframes iconFloat {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(-10px); }
}

.cta-icon .material-icons {
  font-size: 2.5rem;
  color: #000;
}

.final-cta-section .cta-title {
  font-size: 3rem;
  font-weight: 300;
  margin-bottom: 2rem;
  background: linear-gradient(135deg, #FAFAF8 0%, #a47148 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.final-cta-section .cta-text {
  font-size: 1.25rem;
  line-height: 1.6;
  margin-bottom: 3rem;
  color: #ccc;
}

.cta-buttons {
  display: flex;
  gap: 1.5rem;
  justify-content: center;
  flex-wrap: wrap;
}

.cta-button.secondary {
  background: transparent;
  color: #FAFAF8;
  border: 2px solid #FAFAF8;
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
  
  .cta-grid {
    grid-template-columns: 1fr;
    gap: 2rem;
  }
  
  .hero-title {
    font-size: 3rem;
  }
  
  .hero-stats {
    flex-direction: column;
    gap: 2rem;
  }
  
  .stat-divider {
    width: 60px;
    height: 1px;
    margin: 0 auto;
  }
  
  .products-header {
    flex-direction: column;
    gap: 1rem;
    text-align: center;
  }
  
  .cta-buttons {
    flex-direction: column;
    align-items: center;
  }
}

@media (max-width: 480px) {
  .container {
    padding: 0 1rem;
  }
  
  .hero-title {
    font-size: 2.5rem;
  }
  
  .section-title {
    font-size: 2rem;
  }
  
  .final-cta-section .cta-title {
    font-size: 2.5rem;
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