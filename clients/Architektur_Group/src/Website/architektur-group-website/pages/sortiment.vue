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
      </div>
      <div class="hero-content">
        <div class="hero-text">
          <h1 class="hero-title">EXKLUSIVES SORTIMENT</h1>
          <p class="hero-subtitle">Über 200 verschiedene Naturstein- und Keramik-Oberflächen</p>
        </div>
      </div>
    </section>

    <!-- Category Filter -->
    <section class="filter-section">
      <div class="container">
        <div class="filter-buttons">
          <button 
            v-for="category in categories" 
            :key="category.id"
            @click="activeCategory = category.id"
            :class="['filter-btn', { 'active': activeCategory === category.id }]"
          >
            {{ category.name }}
          </button>
        </div>
      </div>
    </section>

    <!-- Products Grid -->
    <section class="products-section">
      <div class="container">
        <div class="products-grid">
          <div 
            v-for="(product, index) in filteredProducts" 
            :key="product.id"
            class="product-card"
            :style="{ animationDelay: `${index * 0.1}s` }"
            @click="openProductModal(product)"
          >
            <div class="product-image-container">
              <img :src="product.image" :alt="product.name" class="product-image">
              <div class="product-overlay">
                <div class="product-actions">
                  <button class="action-btn">
                    <span class="material-icons">visibility</span>
                  </button>
                  <button class="action-btn">
                    <span class="material-icons">favorite_border</span>
                  </button>
                </div>
              </div>
            </div>
            <div class="product-info">
              <h3 class="product-name">{{ product.name }}</h3>
              <p class="product-category">{{ product.category }}</p>
              <div class="product-features">
                <span v-for="feature in product.features" :key="feature" class="feature-tag">
                  {{ feature }}
                </span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Product Modal -->
    <transition name="modal">
      <div v-if="selectedProduct" class="modal-overlay" @click="closeModal">
        <div class="modal-content" @click.stop>
          <button class="modal-close" @click="closeModal">
            <span class="material-icons">close</span>
          </button>
          <div class="modal-body">
            <div class="modal-image">
              <img :src="selectedProduct.image" :alt="selectedProduct.name">
            </div>
            <div class="modal-info">
              <h2 class="modal-title">{{ selectedProduct.name }}</h2>
              <p class="modal-category">{{ selectedProduct.category }}</p>
              <p class="modal-description">{{ selectedProduct.description }}</p>
              <div class="modal-features">
                <h4>Eigenschaften:</h4>
                <ul>
                  <li v-for="feature in selectedProduct.features" :key="feature">{{ feature }}</li>
                </ul>
              </div>
              <div class="modal-actions">
                <NuxtLink to="/kontakt" class="cta-button">ANFRAGE STELLEN</NuxtLink>
                <button class="secondary-button">MEHR INFORMATIONEN</button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </transition>

    <!-- CTA Section -->
    <section class="cta-section">
      <div class="container">
        <div class="cta-content">
          <h2 class="cta-title">INDIVIDUELLE BERATUNG</h2>
          <p class="cta-text">Lassen Sie sich von unseren Experten beraten und finden Sie das perfekte Material für Ihr Projekt.</p>
          <NuxtLink to="/kontakt" class="cta-button">BERATUNG VEREINBAREN</NuxtLink>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
const activeCategory = ref('alle')
const selectedProduct = ref(null)

const categories = [
  { id: 'alle', name: 'Alle Produkte' },
  { id: 'marmor', name: 'Marmor' },
  { id: 'granit', name: 'Granit' },
  { id: 'travertin', name: 'Travertin' },
  { id: 'schiefer', name: 'Schiefer' },
  { id: 'keramik', name: 'Keramik' }
]

const products = [
  {
    id: 1,
    name: 'Carrara Marmor',
    category: 'Marmor',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png',
    features: ['Poliert', 'Frostsicher', 'Innen & Außen'],
    description: 'Exklusiver Carrara Marmor aus Italien. Zeitlose Eleganz für anspruchsvolle Projekte.',
    categoryId: 'marmor'
  },
  {
    id: 2,
    name: 'Kashmir White Granit',
    category: 'Granit',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png',
    features: ['Robust', 'Hitzebeständig', 'Pflegeleicht'],
    description: 'Hochwertiger Granit mit charakteristischer weißer Grundfarbe und dunklen Einsprengseln.',
    categoryId: 'granit'
  },
  {
    id: 3,
    name: 'Römischer Travertin',
    category: 'Travertin',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b70b0803723582ed6.png',
    features: ['Antik', 'Rutschfest', 'Mediterran'],
    description: 'Authentischer römischer Travertin für mediterrane Eleganz.',
    categoryId: 'travertin'
  },
  {
    id: 4,
    name: 'Mustang Schiefer',
    category: 'Schiefer',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b097a8069ca3ac95a.png',
    features: ['Spaltrau', 'Wetterfest', 'Modern'],
    description: 'Moderner Schiefer mit natürlicher Oberflächenstruktur.',
    categoryId: 'schiefer'
  },
  {
    id: 5,
    name: 'Feinsteinzeug Premium',
    category: 'Keramik',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png',
    features: ['High-Tech', 'Dünn', 'Vielseitig'],
    description: 'Innovatives Feinsteinzeug mit High-Tech Eigenschaften.',
    categoryId: 'keramik'
  },
  {
    id: 6,
    name: 'Nero Marquina',
    category: 'Marmor',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png',
    features: ['Schwarz', 'Luxuriös', 'Exklusiv'],
    description: 'Luxuriöser schwarzer Marmor mit weißen Adern.',
    categoryId: 'marmor'
  }
]

const filteredProducts = computed(() => {
  if (activeCategory.value === 'alle') {
    return products
  }
  return products.filter(product => product.categoryId === activeCategory.value)
})

const openProductModal = (product) => {
  selectedProduct.value = product
  document.body.style.overflow = 'hidden'
}

const closeModal = () => {
  selectedProduct.value = null
  document.body.style.overflow = 'auto'
}

onUnmounted(() => {
  document.body.style.overflow = 'auto'
})
</script>

<style scoped>
.sortiment-page {
  min-height: 100vh;
  background: #000;
  color: #FAFAF8;
  padding-top: 80px;
}

/* Hero Section */
.hero-section {
  position: relative;
  height: 60vh;
  overflow: hidden;
}

.hero-background {
  position: relative;
  width: 100%;
  height: 100%;
}

.hero-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.hero-overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(45deg, rgba(0,0,0,0.7), rgba(164, 113, 72, 0.3));
  z-index: 1;
}

.hero-content {
  position: absolute;
  inset: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 2;
}

.hero-text {
  text-align: center;
  animation: heroFadeIn 1.5s ease-out;
}

.hero-title {
  font-size: clamp(2.5rem, 5vw, 4rem);
  font-weight: 300;
  letter-spacing: 0.05em;
  margin-bottom: 1rem;
  background: linear-gradient(135deg, #FAFAF8 0%, #a47148 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.hero-subtitle {
  font-size: 1.5rem;
  font-weight: 300;
  opacity: 0.9;
}

/* Filter Section */
.filter-section {
  padding: 3rem 0;
  background: rgba(16, 16, 21, 0.9);
}

.container {
  max-width: 1400px;
  margin: 0 auto;
  padding: 0 2rem;
}

.filter-buttons {
  display: flex;
  justify-content: center;
  gap: 2rem;
  flex-wrap: wrap;
}

.filter-btn {
  padding: 0.75rem 2rem;
  background: transparent;
  border: 2px solid rgba(255, 255, 255, 0.2);
  color: #FAFAF8;
  font-size: 1rem;
  font-weight: 300;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  border-radius: 50px;
  cursor: pointer;
  transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  position: relative;
  overflow: hidden;
}

.filter-btn::before {
  content: '';
  position: absolute;
  inset: 0;
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  transform: translateX(-100%);
  transition: transform 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  z-index: -1;
}

.filter-btn:hover,
.filter-btn.active {
  border-color: #a47148;
  color: #000;
}

.filter-btn:hover::before,
.filter-btn.active::before {
  transform: translateX(0);
}

/* Products Section */
.products-section {
  padding: 5rem 0;
}

.products-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
  gap: 3rem;
  padding: 2rem 0;
}

.product-card {
  background: rgba(255, 255, 255, 0.05);
  border-radius: 20px;
  overflow: hidden;
  cursor: pointer;
  transition: all 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  animation: cardFadeIn 0.8s ease-out forwards;
  opacity: 0;
  transform: translateY(30px);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.product-card:hover {
  transform: translateY(-10px);
  box-shadow: 0 20px 40px rgba(164, 113, 72, 0.2);
  background: rgba(255, 255, 255, 0.08);
}

.product-image-container {
  position: relative;
  height: 250px;
  overflow: hidden;
}

.product-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.6s ease;
}

.product-card:hover .product-image {
  transform: scale(1.1);
}

.product-overlay {
  position: absolute;
  inset: 0;
  background: rgba(0, 0, 0, 0.6);
  display: flex;
  align-items: center;
  justify-content: center;
  opacity: 0;
  transition: opacity 0.4s ease;
}

.product-card:hover .product-overlay {
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
}

.action-btn:hover {
  background: #a47148;
  transform: scale(1.1);
}

.product-info {
  padding: 2rem;
}

.product-name {
  font-size: 1.5rem;
  font-weight: 400;
  margin-bottom: 0.5rem;
  background: linear-gradient(135deg, #FAFAF8 0%, #a47148 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.product-category {
  font-size: 1rem;
  color: #999;
  margin-bottom: 1rem;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.product-features {
  display: flex;
  gap: 0.5rem;
  flex-wrap: wrap;
}

.feature-tag {
  padding: 0.25rem 0.75rem;
  background: rgba(164, 113, 72, 0.2);
  color: #a47148;
  font-size: 0.875rem;
  border-radius: 15px;
  border: 1px solid rgba(164, 113, 72, 0.3);
}

/* Modal */
.modal-overlay {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.9);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
  backdrop-filter: blur(10px);
}

.modal-content {
  background: linear-gradient(135deg, #1a1a1a 0%, #0a0a0a 100%);
  border-radius: 20px;
  max-width: 900px;
  width: 90%;
  max-height: 90vh;
  overflow-y: auto;
  position: relative;
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.modal-close {
  position: absolute;
  top: 1rem;
  right: 1rem;
  background: rgba(255, 255, 255, 0.1);
  border: none;
  border-radius: 50%;
  width: 40px;
  height: 40px;
  color: #FAFAF8;
  cursor: pointer;
  z-index: 1;
  transition: all 0.3s ease;
}

.modal-close:hover {
  background: rgba(255, 255, 255, 0.2);
  transform: rotate(90deg);
}

.modal-body {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 2rem;
}

.modal-image img {
  width: 100%;
  height: 400px;
  object-fit: cover;
  border-radius: 10px;
}

.modal-info {
  padding: 2rem;
}

.modal-title {
  font-size: 2rem;
  font-weight: 400;
  margin-bottom: 1rem;
  background: linear-gradient(135deg, #FAFAF8 0%, #a47148 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.modal-category {
  font-size: 1rem;
  color: #a47148;
  text-transform: uppercase;
  letter-spacing: 0.1em;
  margin-bottom: 1rem;
}

.modal-description {
  font-size: 1.1rem;
  line-height: 1.6;
  margin-bottom: 2rem;
  color: #ccc;
}

.modal-features h4 {
  font-size: 1.2rem;
  margin-bottom: 1rem;
  color: #FAFAF8;
}

.modal-features ul {
  list-style: none;
  padding: 0;
  margin-bottom: 2rem;
}

.modal-features li {
  padding: 0.5rem 0;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
  color: #ccc;
}

.modal-actions {
  display: flex;
  gap: 1rem;
}

/* CTA Section */
.cta-section {
  padding: 5rem 0;
  background: linear-gradient(135deg, #1a1a1a 0%, #0a0a0a 100%);
}

.cta-content {
  text-align: center;
  max-width: 800px;
  margin: 0 auto;
}

.cta-title {
  font-size: 3rem;
  font-weight: 300;
  margin-bottom: 2rem;
  background: linear-gradient(135deg, #FAFAF8 0%, #a47148 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.cta-text {
  font-size: 1.25rem;
  line-height: 1.6;
  margin-bottom: 3rem;
  color: #ccc;
}

/* Buttons */
.cta-button,
.secondary-button {
  display: inline-block;
  padding: 1rem 2.5rem;
  font-size: 1rem;
  font-weight: 500;
  text-transform: uppercase;
  letter-spacing: 0.1em;
  border-radius: 50px;
  text-decoration: none;
  cursor: pointer;
  transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  position: relative;
  overflow: hidden;
}

.cta-button {
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  color: #000;
  border: none;
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

/* Animations */
@keyframes heroFadeIn {
  from {
    opacity: 0;
    transform: translateY(30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

@keyframes cardFadeIn {
  to {
    opacity: 1;
    transform: translateY(0);
  }
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
  transform: scale(0.8);
}

/* Responsive */
@media (max-width: 768px) {
  .products-grid {
    grid-template-columns: 1fr;
    gap: 2rem;
  }
  
  .modal-body {
    grid-template-columns: 1fr;
  }
  
  .modal-image img {
    height: 250px;
  }
  
  .filter-buttons {
    gap: 1rem;
  }
  
  .filter-btn {
    padding: 0.5rem 1.5rem;
    font-size: 0.875rem;
  }
  
  .hero-title {
    font-size: 2.5rem;
  }
  
  .hero-subtitle {
    font-size: 1.2rem;
  }
}
</style>