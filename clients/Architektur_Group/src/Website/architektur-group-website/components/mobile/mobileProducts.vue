<template>
  <section class="mobile-products">
    <!-- Section Header -->
    <div class="section-header">
      <h2 class="section-title">
        <span class="title-line">UNSERE</span>
        <span class="title-line emphasis">KOLLEKTIONEN</span>
      </h2>
      <p class="section-subtitle">Entdecken Sie exklusive Materialien</p>
    </div>

    <!-- Filter Pills -->
    <div class="filter-container">
      <div class="filter-scroll">
        <button 
          v-for="filter in filters" 
          :key="filter.id"
          @click="activeFilter = filter.id"
          :class="['filter-pill', { active: activeFilter === filter.id }]"
        >
          <span class="pill-icon material-icons">{{ filter.icon }}</span>
          <span class="pill-text">{{ filter.name }}</span>
          <span class="pill-count">{{ filter.count }}</span>
        </button>
      </div>
    </div>

    <!-- Product Grid -->
    <div class="products-container">
      <div 
        v-for="(product, index) in filteredProducts" 
        :key="product.id"
        class="product-card"
        :style="{ animationDelay: `${index * 0.1}s` }"
        @click="selectProduct(product)"
      >
        <!-- 3D Card -->
        <div class="card-3d" :class="{ 'flipped': product.flipped }">
          <!-- Front Face -->
          <div class="card-face card-front">
            <!-- Product Image -->
            <div class="product-image-wrapper">
              <img 
                :src="product.image" 
                :alt="product.name"
                loading="lazy"
                class="product-image"
              >
              <div class="image-overlay"></div>
              
              <!-- Quick Actions -->
              <div class="quick-actions">
                <button @click.stop="toggleFavorite(product)" class="action-btn">
                  <span class="material-icons">
                    {{ product.isFavorite ? 'favorite' : 'favorite_border' }}
                  </span>
                </button>
                <button @click.stop="flipCard(product)" class="action-btn">
                  <span class="material-icons">360</span>
                </button>
                <button @click.stop="shareProduct(product)" class="action-btn">
                  <span class="material-icons">share</span>
                </button>
              </div>

              <!-- Badge -->
              <div v-if="product.badge" class="product-badge">
                <span>{{ product.badge }}</span>
              </div>
            </div>

            <!-- Product Info -->
            <div class="product-info">
              <h3 class="product-name">{{ product.name }}</h3>
              <p class="product-category">{{ product.category }}</p>
              
              <!-- Rating -->
              <div class="product-rating">
                <div class="stars">
                  <span 
                    v-for="star in 5" 
                    :key="star"
                    class="star"
                    :class="{ filled: star <= product.rating }"
                  >★</span>
                </div>
                <span class="rating-count">({{ product.reviews }})</span>
              </div>

              <!-- Price -->
              <div class="product-price">
                <span class="price-currency">€</span>
                <span class="price-value">{{ product.price }}</span>
                <span class="price-unit">/m²</span>
              </div>

              <!-- Features -->
              <div class="product-features">
                <span 
                  v-for="feature in product.features" 
                  :key="feature"
                  class="feature-tag"
                >
                  {{ feature }}
                </span>
              </div>
            </div>
          </div>

          <!-- Back Face -->
          <div class="card-face card-back">
            <div class="back-content">
              <h4>Technische Details</h4>
              <div class="specs-list">
                <div v-for="spec in product.specs" :key="spec.label" class="spec-item">
                  <span class="spec-label">{{ spec.label }}</span>
                  <span class="spec-value">{{ spec.value }}</span>
                </div>
              </div>
              
              <div class="back-actions">
                <button @click.stop="requestSample(product)" class="sample-btn">
                  <span class="material-icons">science</span>
                  Muster anfordern
                </button>
                <button @click.stop="flipCard(product)" class="flip-back-btn">
                  <span class="material-icons">flip_to_front</span>
                </button>
              </div>
            </div>
          </div>
        </div>

        <!-- AR View Button -->
        <button @click.stop="viewInAR(product)" class="ar-button">
          <span class="material-icons">view_in_ar</span>
          <span>AR Ansicht</span>
        </button>
      </div>
    </div>

    <!-- Load More -->
    <div class="load-more-container">
      <button @click="loadMore" class="load-more-btn" v-if="hasMore">
        <div class="load-more-content">
          <span v-if="!loading">Mehr laden</span>
          <div v-else class="loading-spinner"></div>
        </div>
        <div class="load-more-progress" :style="{ width: loadProgress + '%' }"></div>
      </button>
    </div>

    <!-- Product Modal -->
    <transition name="modal">
      <div v-if="selectedProduct" class="product-modal" @click="closeModal">
        <div class="modal-content" @click.stop>
          <!-- Close Button -->
          <button @click="closeModal" class="modal-close">
            <span class="material-icons">close</span>
          </button>

          <!-- Product Gallery -->
          <div class="modal-gallery">
            <div class="gallery-main">
              <img :src="selectedProduct.images[currentImageIndex]" :alt="selectedProduct.name">
              <div class="gallery-nav">
                <button @click="prevImage" class="gallery-btn prev">
                  <span class="material-icons">chevron_left</span>
                </button>
                <button @click="nextImage" class="gallery-btn next">
                  <span class="material-icons">chevron_right</span>
                </button>
              </div>
            </div>
            <div class="gallery-thumbnails">
              <img 
                v-for="(image, index) in selectedProduct.images" 
                :key="index"
                :src="image"
                @click="currentImageIndex = index"
                :class="{ active: currentImageIndex === index }"
                class="thumbnail"
              >
            </div>
          </div>

          <!-- Product Details -->
          <div class="modal-details">
            <h2>{{ selectedProduct.name }}</h2>
            <p class="modal-category">{{ selectedProduct.category }}</p>
            
            <div class="modal-price">
              <span class="price-large">€{{ selectedProduct.price }}</span>
              <span class="price-info">/m² inkl. MwSt.</span>
            </div>

            <p class="modal-description">{{ selectedProduct.description }}</p>

            <!-- Specifications -->
            <div class="modal-specs">
              <h3>Spezifikationen</h3>
              <div class="specs-grid">
                <div v-for="spec in selectedProduct.specs" :key="spec.label" class="spec-box">
                  <span class="spec-icon material-icons">{{ spec.icon }}</span>
                  <span class="spec-label">{{ spec.label }}</span>
                  <span class="spec-value">{{ spec.value }}</span>
                </div>
              </div>
            </div>

            <!-- Actions -->
            <div class="modal-actions">
              <button @click="addToCart(selectedProduct)" class="btn-primary">
                <span class="material-icons">shopping_cart</span>
                In den Warenkorb
              </button>
              <button @click="requestQuote(selectedProduct)" class="btn-secondary">
                <span class="material-icons">request_quote</span>
                Angebot anfordern
              </button>
            </div>
          </div>
        </div>
      </div>
    </transition>
  </section>
</template>

<script setup>
import { ref, reactive, computed } from 'vue'

const activeFilter = ref('alle')
const selectedProduct = ref(null)
const currentImageIndex = ref(0)
const loading = ref(false)
const hasMore = ref(true)
const loadProgress = ref(0)

const filters = [
  { id: 'alle', name: 'Alle', icon: 'apps', count: 24 },
  { id: 'marmor', name: 'Marmor', icon: 'diamond', count: 8 },
  { id: 'granit', name: 'Granit', icon: 'landscape', count: 6 },
  { id: 'keramik', name: 'Keramik', icon: 'texture', count: 10 }
]

const products = reactive([
  {
    id: 1,
    name: 'Carrara Marmor Elite',
    category: 'Marmor',
    categoryId: 'marmor',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png',
    images: [
      'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png',
      'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png',
      'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b70b0803723582ed6.png'
    ],
    price: 185,
    rating: 5,
    reviews: 47,
    badge: 'Premium',
    isFavorite: false,
    flipped: false,
    features: ['Poliert', 'Frostsicher', 'Luxus'],
    description: 'Exklusiver Carrara Marmor aus den besten italienischen Steinbrüchen. Zeitlose Eleganz für anspruchsvolle Projekte.',
    specs: [
      { label: 'Format', value: '60x120cm', icon: 'straighten' },
      { label: 'Stärke', value: '20mm', icon: 'height' },
      { label: 'Oberfläche', value: 'Poliert', icon: 'texture' },
      { label: 'Rutschfest', value: 'R9', icon: 'security' },
      { label: 'Frostbeständig', value: 'Ja', icon: 'ac_unit' },
      { label: 'Herkunft', value: 'Italien', icon: 'place' }
    ]
  },
  {
    id: 2,
    name: 'Kashmir White Granit',
    category: 'Granit',
    categoryId: 'granit',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png',
    images: [
      'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png',
      'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b70b0803723582ed6.png'
    ],
    price: 145,
    rating: 4,
    reviews: 32,
    badge: 'Bestseller',
    isFavorite: false,
    flipped: false,
    features: ['Robust', 'Pflegeleicht', 'Elegant'],
    description: 'Hochwertiger Granit mit charakteristischer weißer Grundfarbe und eleganten dunklen Einsprengseln.',
    specs: [
      { label: 'Format', value: '40x40cm', icon: 'straighten' },
      { label: 'Stärke', value: '30mm', icon: 'height' },
      { label: 'Oberfläche', value: 'Geflammt', icon: 'texture' },
      { label: 'Rutschfest', value: 'R11', icon: 'security' },
      { label: 'Säurefest', value: 'Ja', icon: 'science' },
      { label: 'Herkunft', value: 'Indien', icon: 'place' }
    ]
  },
  {
    id: 3,
    name: 'Premium Feinsteinzeug',
    category: 'Keramik',
    categoryId: 'keramik',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b70b0803723582ed6.png',
    images: [
      'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b70b0803723582ed6.png'
    ],
    price: 95,
    rating: 5,
    reviews: 61,
    badge: 'Neu',
    isFavorite: true,
    flipped: false,
    features: ['Modern', 'Vielseitig', 'Dünn'],
    description: 'Innovatives Feinsteinzeug mit außergewöhnlicher Optik und hervorragenden technischen Eigenschaften.',
    specs: [
      { label: 'Format', value: '120x120cm', icon: 'straighten' },
      { label: 'Stärke', value: '6mm', icon: 'height' },
      { label: 'Oberfläche', value: 'Matt', icon: 'texture' },
      { label: 'Rutschfest', value: 'R10', icon: 'security' },
      { label: 'Wasseraufnahme', value: '<0.5%', icon: 'water_drop' },
      { label: 'Herkunft', value: 'Deutschland', icon: 'place' }
    ]
  }
])

const filteredProducts = computed(() => {
  if (activeFilter.value === 'alle') {
    return products
  }
  return products.filter(p => p.categoryId === activeFilter.value)
})

const selectProduct = (product) => {
  selectedProduct.value = product
  currentImageIndex.value = 0
  document.body.style.overflow = 'hidden'
}

const closeModal = () => {
  selectedProduct.value = null
  document.body.style.overflow = 'auto'
}

const flipCard = (product) => {
  product.flipped = !product.flipped
  // Haptic feedback
  if (navigator.vibrate) navigator.vibrate(10)
}

const toggleFavorite = (product) => {
  product.isFavorite = !product.isFavorite
  // Animation feedback
  if (navigator.vibrate) navigator.vibrate([10, 10, 10])
}

const shareProduct = async (product) => {
  if (navigator.share) {
    try {
      await navigator.share({
        title: product.name,
        text: `Entdecken Sie ${product.name} bei Architektur Group`,
        url: window.location.href
      })
    } catch (err) {
      console.log('Share cancelled')
    }
  }
}

const viewInAR = (product) => {
  console.log('View in AR:', product.name)
  // AR implementation would go here
}

const requestSample = (product) => {
  console.log('Request sample:', product.name)
}

const loadMore = async () => {
  loading.value = true
  
  // Simulate loading
  for (let i = 0; i <= 100; i += 10) {
    loadProgress.value = i
    await new Promise(resolve => setTimeout(resolve, 50))
  }
  
  // Add more products...
  loading.value = false
  loadProgress.value = 0
}

const prevImage = () => {
  if (currentImageIndex.value > 0) {
    currentImageIndex.value--
  } else {
    currentImageIndex.value = selectedProduct.value.images.length - 1
  }
}

const nextImage = () => {
  if (currentImageIndex.value < selectedProduct.value.images.length - 1) {
    currentImageIndex.value++
  } else {
    currentImageIndex.value = 0
  }
}

const addToCart = (product) => {
  console.log('Add to cart:', product.name)
}

const requestQuote = (product) => {
  console.log('Request quote:', product.name)
}
</script>

<style scoped>
.mobile-products {
  padding: 2rem 1rem;
  background: #000;
  min-height: 100vh;
}

/* Section Header */
.section-header {
  text-align: center;
  margin-bottom: 3rem;
}

.section-title {
  margin-bottom: 0.5rem;
}

.title-line {
  display: block;
  font-size: 2rem;
  font-weight: 300;
  color: #FAFAF8;
  line-height: 1.2;
}

.title-line.emphasis {
  font-size: 2.5rem;
  font-weight: 600;
  background: linear-gradient(135deg, #FAFAF8 0%, #a47148 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.section-subtitle {
  font-size: 1rem;
  color: #999;
  font-weight: 300;
}

/* Filter Pills */
.filter-container {
  margin-bottom: 2rem;
  overflow: hidden;
}

.filter-scroll {
  display: flex;
  gap: 0.75rem;
  overflow-x: auto;
  padding: 0.5rem 0;
  -webkit-overflow-scrolling: touch;
  scrollbar-width: none;
}

.filter-scroll::-webkit-scrollbar {
  display: none;
}

.filter-pill {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.75rem 1.25rem;
  background: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 25px;
  color: #999;
  font-size: 0.875rem;
  white-space: nowrap;
  cursor: pointer;
  transition: all 0.3s ease;
  flex-shrink: 0;
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
}

.filter-pill.active {
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  border-color: transparent;
  color: #000;
  transform: scale(1.05);
}

.pill-icon {
  font-size: 18px;
}

.pill-count {
  padding: 0.125rem 0.5rem;
  background: rgba(0, 0, 0, 0.2);
  border-radius: 10px;
  font-size: 0.75rem;
  font-weight: 600;
}

.filter-pill.active .pill-count {
  background: rgba(0, 0, 0, 0.3);
}

/* Product Grid */
.products-container {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 1.5rem;
  margin-bottom: 3rem;
}

/* 3D Product Card */
.product-card {
  position: relative;
  opacity: 0;
  animation: cardFadeIn 0.6s cubic-bezier(0.4, 0, 0.2, 1) forwards;
  cursor: pointer;
  perspective: 1000px;
}

@keyframes cardFadeIn {
  to {
    opacity: 1;
  }
}

.card-3d {
  position: relative;
  width: 100%;
  height: 450px;
  transform-style: preserve-3d;
  transition: transform 0.6s cubic-bezier(0.4, 0, 0.2, 1);
}

.card-3d.flipped {
  transform: rotateY(180deg);
}

.card-face {
  position: absolute;
  width: 100%;
  height: 100%;
  backface-visibility: hidden;
  background: rgba(255, 255, 255, 0.03);
  border-radius: 20px;
  overflow: hidden;
  border: 1px solid rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
}

.card-back {
  transform: rotateY(180deg);
  padding: 1.5rem;
  display: flex;
  flex-direction: column;
}

/* Product Image */
.product-image-wrapper {
  position: relative;
  height: 200px;
  overflow: hidden;
  background: linear-gradient(135deg, #1a1a1a, #0a0a0a);
}

.product-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.6s cubic-bezier(0.4, 0, 0.2, 1);
}

.product-card:hover .product-image {
  transform: scale(1.1);
}

.image-overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(180deg, transparent 50%, rgba(0,0,0,0.6) 100%);
  opacity: 0;
  transition: opacity 0.3s ease;
}

.product-card:hover .image-overlay {
  opacity: 1;
}

/* Quick Actions */
.quick-actions {
  position: absolute;
  top: 1rem;
  right: 1rem;
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
  opacity: 0;
  transform: translateX(20px);
  transition: all 0.3s ease;
}

.product-card:hover .quick-actions {
  opacity: 1;
  transform: translateX(0);
}

.action-btn {
  width: 36px;
  height: 36px;
  background: rgba(0, 0, 0, 0.7);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #FAFAF8;
  cursor: pointer;
  transition: all 0.3s ease;
}

.action-btn:active {
  transform: scale(0.9);
  background: #a47148;
  color: #000;
}

/* Product Badge */
.product-badge {
  position: absolute;
  top: 1rem;
  left: 1rem;
  padding: 0.25rem 0.75rem;
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  color: #000;
  font-size: 0.75rem;
  font-weight: 600;
  border-radius: 20px;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

/* Product Info */
.product-info {
  padding: 1.25rem;
}

.product-name {
  font-size: 1.125rem;
  font-weight: 500;
  color: #FAFAF8;
  margin-bottom: 0.25rem;
}

.product-category {
  font-size: 0.875rem;
  color: #a47148;
  margin-bottom: 0.75rem;
}

/* Rating */
.product-rating {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  margin-bottom: 0.75rem;
}

.stars {
  display: flex;
  gap: 0.125rem;
}

.star {
  color: rgba(255, 255, 255, 0.2);
  font-size: 0.875rem;
  transition: color 0.2s ease;
}

.star.filled {
  color: #a47148;
}

.rating-count {
  font-size: 0.75rem;
  color: #666;
}

/* Price */
.product-price {
  display: flex;
  align-items: baseline;
  margin-bottom: 1rem;
}

.price-currency {
  font-size: 0.875rem;
  color: #999;
  margin-right: 0.125rem;
}

.price-value {
  font-size: 1.5rem;
  font-weight: 600;
  color: #FAFAF8;
}

.price-unit {
  font-size: 0.875rem;
  color: #666;
  margin-left: 0.25rem;
}

/* Features */
.product-features {
  display: flex;
  gap: 0.5rem;
  flex-wrap: wrap;
}

.feature-tag {
  padding: 0.25rem 0.5rem;
  background: rgba(164, 113, 72, 0.1);
  border: 1px solid rgba(164, 113, 72, 0.3);
  color: #a47148;
  font-size: 0.75rem;
  border-radius: 10px;
}

/* Back Face Content */
.back-content {
  height: 100%;
  display: flex;
  flex-direction: column;
}

.back-content h4 {
  font-size: 1.25rem;
  color: #FAFAF8;
  margin-bottom: 1.5rem;
  text-align: center;
}

.specs-list {
  flex: 1;
  display: grid;
  gap: 0.75rem;
}

.spec-item {
  display: flex;
  justify-content: space-between;
  padding: 0.5rem 0;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.spec-label {
  color: #999;
  font-size: 0.875rem;
}

.spec-value {
  color: #FAFAF8;
  font-weight: 500;
  font-size: 0.875rem;
}

.back-actions {
  display: flex;
  gap: 1rem;
  margin-top: 1.5rem;
}

.sample-btn,
.flip-back-btn {
  flex: 1;
  padding: 0.75rem;
  background: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 12px;
  color: #FAFAF8;
  font-size: 0.875rem;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  cursor: pointer;
  transition: all 0.3s ease;
}

.sample-btn:active {
  background: #a47148;
  color: #000;
  transform: scale(0.95);
}

/* AR Button */
.ar-button {
  position: absolute;
  bottom: 1rem;
  left: 50%;
  transform: translateX(-50%);
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.5rem 1rem;
  background: rgba(0, 0, 0, 0.8);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 20px;
  color: #FAFAF8;
  font-size: 0.75rem;
  cursor: pointer;
  opacity: 0;
  transition: all 0.3s ease;
}

.product-card:hover .ar-button {
  opacity: 1;
  bottom: 1.5rem;
}

.ar-button:active {
  transform: translateX(-50%) scale(0.95);
  background: #a47148;
  color: #000;
}

/* Load More */
.load-more-container {
  display: flex;
  justify-content: center;
  margin-top: 3rem;
}

.load-more-btn {
  position: relative;
  width: 200px;
  padding: 1rem 2rem;
  background: rgba(255, 255, 255, 0.05);
  border: 2px solid rgba(255, 255, 255, 0.2);
  border-radius: 50px;
  color: #FAFAF8;
  font-size: 0.875rem;
  font-weight: 500;
  cursor: pointer;
  overflow: hidden;
  transition: all 0.3s ease;
}

.load-more-btn:active {
  transform: scale(0.95);
}

.load-more-content {
  position: relative;
  z-index: 2;
}

.loading-spinner {
  width: 20px;
  height: 20px;
  border: 2px solid rgba(255, 255, 255, 0.3);
  border-top-color: #a47148;
  border-radius: 50%;
  animation: spin 0.8s linear infinite;
  margin: 0 auto;
}

@keyframes spin {
  to { transform: rotate(360deg); }
}

.load-more-progress {
  position: absolute;
  bottom: 0;
  left: 0;
  height: 3px;
  background: linear-gradient(90deg, #a47148, #FAFAF8);
  transition: width 0.3s ease;
}

/* Product Modal */
.product-modal {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.95);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  z-index: 9999;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 1rem;
  overflow-y: auto;
}

.modal-content {
  background: linear-gradient(135deg, #1a1a1a, #0a0a0a);
  border-radius: 20px;
  max-width: 500px;
  width: 100%;
  max-height: 90vh;
  overflow-y: auto;
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.modal-close {
  position: sticky;
  top: 1rem;
  right: 1rem;
  float: right;
  width: 40px;
  height: 40px;
  background: rgba(255, 255, 255, 0.1);
  border: none;
  border-radius: 50%;
  color: #FAFAF8;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  z-index: 10;
  margin: 1rem;
}

/* Gallery */
.modal-gallery {
  margin-bottom: 2rem;
}

.gallery-main {
  position: relative;
  height: 300px;
  background: #000;
}

.gallery-main img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.gallery-nav {
  position: absolute;
  inset: 0;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0 1rem;
  pointer-events: none;
}

.gallery-btn {
  width: 40px;
  height: 40px;
  background: rgba(0, 0, 0, 0.5);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 50%;
  color: #FAFAF8;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  pointer-events: all;
}

.gallery-thumbnails {
  display: flex;
  gap: 0.5rem;
  padding: 1rem;
  overflow-x: auto;
  background: rgba(0, 0, 0, 0.5);
}

.thumbnail {
  width: 60px;
  height: 60px;
  object-fit: cover;
  border-radius: 8px;
  cursor: pointer;
  opacity: 0.5;
  transition: all 0.3s ease;
  flex-shrink: 0;
}

.thumbnail.active {
  opacity: 1;
  border: 2px solid #a47148;
}

/* Modal Details */
.modal-details {
  padding: 1.5rem;
}

.modal-details h2 {
  font-size: 1.5rem;
  color: #FAFAF8;
  margin-bottom: 0.5rem;
}

.modal-category {
  color: #a47148;
  font-size: 0.875rem;
  margin-bottom: 1rem;
}

.modal-price {
  margin-bottom: 1.5rem;
}

.price-large {
  font-size: 2rem;
  font-weight: 600;
  color: #FAFAF8;
}

.price-info {
  color: #999;
  font-size: 0.875rem;
  margin-left: 0.5rem;
}

.modal-description {
  font-size: 1rem;
  line-height: 1.6;
  color: #ccc;
  margin-bottom: 2rem;
}

/* Modal Specs */
.modal-specs {
  margin-bottom: 2rem;
}

.modal-specs h3 {
  font-size: 1.125rem;
  color: #FAFAF8;
  margin-bottom: 1rem;
}

.specs-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 1rem;
}

.spec-box {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 1rem;
  background: rgba(255, 255, 255, 0.05);
  border-radius: 12px;
  text-align: center;
}

.spec-icon {
  font-size: 24px;
  color: #a47148;
  margin-bottom: 0.5rem;
}

.spec-box .spec-label {
  font-size: 0.75rem;
  color: #999;
  margin-bottom: 0.25rem;
}

.spec-box .spec-value {
  font-size: 0.875rem;
  color: #FAFAF8;
  font-weight: 500;
}

/* Modal Actions */
.modal-actions {
  display: flex;
  gap: 1rem;
  padding: 0 1.5rem 1.5rem;
}

.btn-primary,
.btn-secondary {
  flex: 1;
  padding: 1rem;
  border-radius: 12px;
  font-size: 0.875rem;
  font-weight: 500;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  cursor: pointer;
  transition: all 0.3s ease;
  border: none;
}

.btn-primary {
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  color: #000;
}

.btn-secondary {
  background: transparent;
  border: 2px solid rgba(255, 255, 255, 0.2);
  color: #FAFAF8;
}

.btn-primary:active,
.btn-secondary:active {
  transform: scale(0.95);
}

/* Modal Animation */
.modal-enter-active,
.modal-leave-active {
  transition: opacity 0.3s ease;
}

.modal-enter-from,
.modal-leave-to {
  opacity: 0;
}

.modal-enter-active .modal-content,
.modal-leave-active .modal-content {
  transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.modal-enter-from .modal-content {
  transform: scale(0.9) translateY(20px);
}

.modal-leave-to .modal-content {
  transform: scale(0.9) translateY(20px);
}

/* Responsive */
@media (max-width: 480px) {
  .products-container {
    grid-template-columns: 1fr;
  }
  
  .specs-grid {
    grid-template-columns: 1fr;
  }
}
</style>