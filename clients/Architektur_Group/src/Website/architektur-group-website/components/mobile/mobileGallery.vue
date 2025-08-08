<template>
  <div class="mobile-gallery-3d">
    <!-- Gallery Header -->
    <div class="gallery-header">
      <h2 class="gallery-title">
        <span class="title-gradient">PROJEKT</span>
        <span class="title-bold">GALERIE</span>
      </h2>
      <p class="gallery-subtitle">Swipe für mehr Inspirationen</p>
    </div>

    <!-- Filter Tabs -->
    <div class="filter-tabs">
      <div class="tabs-scroll">
        <button 
          v-for="category in categories" 
          :key="category.id"
          @click="activeCategory = category.id"
          :class="['tab-btn', { active: activeCategory === category.id }]"
        >
          <span class="tab-icon material-icons">{{ category.icon }}</span>
          <span class="tab-text">{{ category.name }}</span>
          <div class="tab-indicator"></div>
        </button>
      </div>
    </div>

    <!-- 3D Gallery Slider -->
    <div class="gallery-container">
      <div 
        class="gallery-slider"
        @touchstart="handleTouchStart"
        @touchmove="handleTouchMove"
        @touchend="handleTouchEnd"
        @mousedown="handleMouseDown"
        @mousemove="handleMouseMove"
        @mouseup="handleMouseUp"
      >
        <div 
          class="gallery-track"
          :style="{ 
            transform: `translateX(${translateX}px) rotateY(${rotateY}deg)`,
            transition: isDragging ? 'none' : 'all 0.5s cubic-bezier(0.4, 0, 0.2, 1)'
          }"
        >
          <div 
            v-for="(item, index) in currentGalleryItems" 
            :key="item.id"
            :class="['gallery-item', { 
              active: index === currentIndex,
              prev: index === currentIndex - 1,
              next: index === currentIndex + 1
            }]"
            :style="getItemStyle(index)"
            @click="selectItem(index)"
          >
            <!-- Image Container -->
            <div class="item-image-container">
              <img 
                :src="item.image" 
                :alt="item.title"
                loading="lazy"
                class="item-image"
              >
              
              <!-- Parallax Overlay -->
              <div class="parallax-overlay" :style="{ transform: `translateY(${parallaxOffset}px)` }">
                <div class="overlay-gradient"></div>
              </div>

              <!-- Item Badge -->
              <div class="item-badge">
                <span class="badge-text">{{ item.category }}</span>
              </div>

              <!-- Like Button -->
              <button 
                @click.stop="toggleLike(item)"
                :class="['like-btn', { liked: item.isLiked }]"
              >
                <span class="material-icons">{{ item.isLiked ? 'favorite' : 'favorite_border' }}</span>
                <div class="like-ripple"></div>
              </button>
            </div>

            <!-- Item Content -->
            <div class="item-content">
              <h3 class="item-title">{{ item.title }}</h3>
              <p class="item-location">
                <span class="material-icons">location_on</span>
                {{ item.location }}
              </p>
              
              <!-- Stats -->
              <div class="item-stats">
                <div class="stat">
                  <span class="stat-icon material-icons">square_foot</span>
                  <span class="stat-value">{{ item.area }}m²</span>
                </div>
                <div class="stat">
                  <span class="stat-icon material-icons">euro</span>
                  <span class="stat-value">{{ item.budget }}k</span>
                </div>
                <div class="stat">
                  <span class="stat-icon material-icons">schedule</span>
                  <span class="stat-value">{{ item.duration }}</span>
                </div>
              </div>

              <!-- Action Button -->
              <button @click.stop="openDetail(item)" class="item-action">
                <span>Details ansehen</span>
                <span class="material-icons">arrow_forward</span>
              </button>
            </div>

            <!-- 3D Tilt Effect -->
            <div class="tilt-effect"></div>
          </div>
        </div>

        <!-- Navigation Dots -->
        <div class="nav-dots">
          <button 
            v-for="(item, index) in currentGalleryItems" 
            :key="index"
            @click="goToSlide(index)"
            :class="['dot', { active: index === currentIndex }]"
          >
            <div class="dot-fill"></div>
          </button>
        </div>

        <!-- Swipe Hint -->
        <div v-if="showSwipeHint" class="swipe-hint">
          <div class="swipe-hand">
            <span class="material-icons">swipe</span>
          </div>
          <p>Wischen Sie für mehr</p>
        </div>
      </div>

      <!-- AR View Button -->
      <button @click="openARView" class="ar-fab">
        <span class="material-icons">view_in_ar</span>
        <span class="ar-text">360° Ansicht</span>
        <div class="ar-pulse"></div>
      </button>
    </div>

    <!-- View Toggle -->
    <button @click="toggleView" class="view-toggle">
      <span class="material-icons">{{ isGridView ? 'view_carousel' : 'grid_view' }}</span>
      <span>{{ isGridView ? 'Slider' : 'Grid' }}</span>
    </button>

    <!-- Grid Gallery -->
    <transition name="grid-transition">
      <div v-if="isGridView" class="gallery-grid">
        <div 
          v-for="(item, index) in currentGalleryItems" 
          :key="item.id"
          class="grid-item"
          :style="{ animationDelay: `${index * 0.05}s` }"
          @click="openLightbox(item, index)"
        >
          <div class="grid-image">
            <img :src="item.thumbnail" :alt="item.title">
            <div class="grid-overlay">
              <span class="material-icons">zoom_in</span>
            </div>
          </div>
        </div>
      </div>
    </transition>

    <!-- Lightbox -->
    <transition name="lightbox">
      <div v-if="lightboxItem" class="lightbox" @click="closeLightbox">
        <div class="lightbox-content" @click.stop>
          <!-- Close Button -->
          <button @click="closeLightbox" class="lightbox-close">
            <span class="material-icons">close</span>
          </button>

          <!-- Image Viewer -->
          <div 
            class="lightbox-viewer"
            @touchstart="handleLightboxTouchStart"
            @touchmove="handleLightboxTouchMove"
            @touchend="handleLightboxTouchEnd"
          >
            <img 
              :src="lightboxItem.image" 
              :alt="lightboxItem.title"
              :style="{ 
                transform: `scale(${zoomLevel}) translate(${panX}px, ${panY}px)`,
                transition: isPanning ? 'none' : 'transform 0.3s ease'
              }"
              class="lightbox-image"
            >

            <!-- Zoom Controls -->
            <div class="zoom-controls">
              <button @click="zoomOut" class="zoom-btn">
                <span class="material-icons">zoom_out</span>
              </button>
              <span class="zoom-level">{{ Math.round(zoomLevel * 100) }}%</span>
              <button @click="zoomIn" class="zoom-btn">
                <span class="material-icons">zoom_in</span>
              </button>
            </div>
          </div>

          <!-- Image Info -->
          <div class="lightbox-info">
            <h3>{{ lightboxItem.title }}</h3>
            <p>{{ lightboxItem.description }}</p>
            
            <div class="lightbox-details">
              <div class="detail-item">
                <span class="material-icons">calendar_today</span>
                <span>{{ lightboxItem.date }}</span>
              </div>
              <div class="detail-item">
                <span class="material-icons">person</span>
                <span>{{ lightboxItem.architect }}</span>
              </div>
            </div>

            <!-- Share Options -->
            <div class="share-options">
              <button @click="shareImage" class="share-btn">
                <span class="material-icons">share</span>
              </button>
              <button @click="downloadImage" class="share-btn">
                <span class="material-icons">download</span>
              </button>
              <button @click="toggleFullscreen" class="share-btn">
                <span class="material-icons">fullscreen</span>
              </button>
            </div>
          </div>

          <!-- Navigation -->
          <button @click="prevImage" class="lightbox-nav prev">
            <span class="material-icons">chevron_left</span>
          </button>
          <button @click="nextImage" class="lightbox-nav next">
            <span class="material-icons">chevron_right</span>
          </button>
        </div>
      </div>
    </transition>

    <!-- Detail Modal -->
    <transition name="detail-modal">
      <div v-if="detailItem" class="detail-modal">
        <div class="modal-header">
          <button @click="closeDetail" class="modal-back">
            <span class="material-icons">arrow_back</span>
          </button>
          <h2>Projektdetails</h2>
          <button @click="shareProject" class="modal-share">
            <span class="material-icons">share</span>
          </button>
        </div>

        <div class="modal-content">
          <!-- Hero Image -->
          <div class="detail-hero">
            <img :src="detailItem.image" :alt="detailItem.title">
            <div class="hero-gradient"></div>
            <div class="hero-info">
              <h1>{{ detailItem.title }}</h1>
              <p>{{ detailItem.location }}</p>
            </div>
          </div>

          <!-- Project Info -->
          <div class="detail-info">
            <div class="info-section">
              <h3>Projektbeschreibung</h3>
              <p>{{ detailItem.fullDescription }}</p>
            </div>

            <div class="info-section">
              <h3>Verwendete Materialien</h3>
              <div class="material-list">
                <div v-for="material in detailItem.materials" :key="material" class="material-item">
                  <span class="material-icon material-icons">check_circle</span>
                  <span>{{ material }}</span>
                </div>
              </div>
            </div>

            <div class="info-section">
              <h3>Projektdaten</h3>
              <div class="data-grid">
                <div class="data-item">
                  <span class="data-label">Fläche</span>
                  <span class="data-value">{{ detailItem.area }}m²</span>
                </div>
                <div class="data-item">
                  <span class="data-label">Budget</span>
                  <span class="data-value">€{{ detailItem.budget }}k</span>
                </div>
                <div class="data-item">
                  <span class="data-label">Dauer</span>
                  <span class="data-value">{{ detailItem.duration }}</span>
                </div>
                <div class="data-item">
                  <span class="data-label">Jahr</span>
                  <span class="data-value">{{ detailItem.year }}</span>
                </div>
              </div>
            </div>

            <!-- Gallery -->
            <div class="info-section">
              <h3>Weitere Bilder</h3>
              <div class="detail-gallery">
                <img 
                  v-for="(img, index) in detailItem.gallery" 
                  :key="index"
                  :src="img"
                  @click="openLightboxAt(index)"
                  class="gallery-thumb"
                >
              </div>
            </div>

            <!-- CTA -->
            <div class="detail-cta">
              <button @click="requestSimilar" class="cta-btn primary">
                <span class="material-icons">architecture</span>
                Ähnliches Projekt anfragen
              </button>
              <button @click="contactUs" class="cta-btn secondary">
                <span class="material-icons">mail</span>
                Kontakt aufnehmen
              </button>
            </div>
          </div>
        </div>
      </div>
    </transition>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'

const currentIndex = ref(0)
const activeCategory = ref('all')
const isDragging = ref(false)
const startX = ref(0)
const startY = ref(0)
const translateX = ref(0)
const rotateY = ref(0)
const parallaxOffset = ref(0)
const showSwipeHint = ref(true)
const isGridView = ref(false)
const lightboxItem = ref(null)
const lightboxIndex = ref(0)
const detailItem = ref(null)
const zoomLevel = ref(1)
const panX = ref(0)
const panY = ref(0)
const isPanning = ref(false)

const categories = [
  { id: 'all', name: 'Alle', icon: 'apps' },
  { id: 'bathroom', name: 'Bäder', icon: 'bathtub' },
  { id: 'garden', name: 'Gärten', icon: 'park' },
  { id: 'terrace', name: 'Terrassen', icon: 'deck' },
  { id: 'indoor', name: 'Innen', icon: 'home' }
]

const galleryItems = [
  {
    id: 1,
    title: 'Luxusbad Starnberg',
    location: 'Starnberg, Bayern',
    category: 'Bäder',
    categoryId: 'bathroom',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686576cf622e38e88f0236c5.png',
    thumbnail: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686576cf622e38e88f0236c5.png',
    area: 45,
    budget: 85,
    duration: '6 Wochen',
    year: 2024,
    date: 'März 2024',
    architect: 'AG Design Team',
    isLiked: false,
    description: 'Exklusives Masterbad mit freistehender Wanne und Walk-In Dusche',
    fullDescription: 'Dieses luxuriöse Badezimmer vereint modernste Technik mit zeitlosem Design. Die freistehende Badewanne aus Mineralguss bildet das Zentrum des Raumes, während die großzügige Walk-In Dusche mit Regendusche und Seitenbrausen für ultimativen Komfort sorgt.',
    materials: ['Carrara Marmor', 'Teakholz', 'Mineralguss', 'Edelstahl gebürstet'],
    gallery: [
      'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686576cf622e38e88f0236c5.png',
      'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png',
      'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png'
    ]
  },
  {
    id: 2,
    title: 'Mediterraner Garten',
    location: 'München, Bayern',
    category: 'Gärten',
    categoryId: 'garden',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png',
    thumbnail: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png',
    area: 320,
    budget: 120,
    duration: '8 Wochen',
    year: 2024,
    date: 'Mai 2024',
    architect: 'AG Landscape',
    isLiked: true,
    description: 'Traumgarten mit Pool und mediterranen Pflanzen',
    fullDescription: 'Ein mediterraner Traumgarten mit großzügigem Pool, der von Olivenbäumen und Lavendel umgeben ist. Die Natursteinmauern und Terrakotta-Elemente schaffen eine authentische südländische Atmosphäre.',
    materials: ['Travertin', 'Terrakotta', 'Cortenstahl', 'Naturstein'],
    gallery: [
      'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png',
      'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b70b0803723582ed6.png'
    ]
  },
  {
    id: 3,
    title: 'Design Terrasse',
    location: 'Düsseldorf, NRW',
    category: 'Terrassen',
    categoryId: 'terrace',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b70b0803723582ed6.png',
    thumbnail: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b70b0803723582ed6.png',
    area: 85,
    budget: 45,
    duration: '3 Wochen',
    year: 2023,
    date: 'September 2023',
    architect: 'AG Outdoor',
    isLiked: false,
    description: 'Moderne Dachterrasse mit Outdoor-Küche',
    fullDescription: 'Diese exklusive Dachterrasse bietet einen atemberaubenden Blick über die Stadt. Mit integrierter Outdoor-Küche, gemütlicher Lounge und pflegeleichten Pflanzen ist sie die perfekte Erweiterung des Wohnraums.',
    materials: ['WPC Dielen', 'Edelstahl', 'Glas', 'LED Beleuchtung'],
    gallery: [
      'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b70b0803723582ed6.png',
      'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b097a8069ca3ac95a.png'
    ]
  }
]

const currentGalleryItems = computed(() => {
  if (activeCategory.value === 'all') {
    return galleryItems
  }
  return galleryItems.filter(item => item.categoryId === activeCategory.value)
})

const getItemStyle = (index) => {
  const offset = index - currentIndex.value
  const absOffset = Math.abs(offset)
  const sign = Math.sign(offset)
  
  // 3D carousel positioning
  const translateZ = absOffset === 0 ? 0 : -100 * absOffset
  const translateXOffset = sign * 80 * absOffset
  const rotateYOffset = sign * -25 * (absOffset > 1 ? 1 : absOffset)
  const scale = 1 - (absOffset * 0.15)
  const opacity = absOffset > 1 ? 0 : 1 - (absOffset * 0.3)
  
  return {
    transform: `translateX(${translateXOffset}%) translateZ(${translateZ}px) rotateY(${rotateYOffset}deg) scale(${scale})`,
    opacity,
    zIndex: 10 - absOffset
  }
}

// Touch handling
const handleTouchStart = (e) => {
  isDragging.value = true
  startX.value = e.touches[0].clientX
  showSwipeHint.value = false
  vibrate(10)
}

const handleTouchMove = (e) => {
  if (!isDragging.value) return
  
  const deltaX = e.touches[0].clientX - startX.value
  translateX.value = deltaX
  rotateY.value = deltaX * 0.1
  parallaxOffset.value = deltaX * 0.05
}

const handleTouchEnd = () => {
  if (!isDragging.value) return
  
  const threshold = 50
  if (Math.abs(translateX.value) > threshold) {
    if (translateX.value > 0 && currentIndex.value > 0) {
      currentIndex.value--
    } else if (translateX.value < 0 && currentIndex.value < currentGalleryItems.value.length - 1) {
      currentIndex.value++
    }
    vibrate(20)
  }
  
  resetPosition()
}

// Mouse handling for desktop
const handleMouseDown = (e) => {
  isDragging.value = true
  startX.value = e.clientX
}

const handleMouseMove = (e) => {
  if (!isDragging.value) return
  
  const deltaX = e.clientX - startX.value
  translateX.value = deltaX
  rotateY.value = deltaX * 0.1
  parallaxOffset.value = deltaX * 0.05
}

const handleMouseUp = () => {
  if (!isDragging.value) return
  
  const threshold = 50
  if (Math.abs(translateX.value) > threshold) {
    if (translateX.value > 0 && currentIndex.value > 0) {
      currentIndex.value--
    } else if (translateX.value < 0 && currentIndex.value < currentGalleryItems.value.length - 1) {
      currentIndex.value++
    }
  }
  
  resetPosition()
}

// Lightbox touch handling
const handleLightboxTouchStart = (e) => {
  if (e.touches.length === 2) {
    // Pinch zoom start
    const touch1 = e.touches[0]
    const touch2 = e.touches[1]
    const distance = Math.hypot(
      touch2.clientX - touch1.clientX,
      touch2.clientY - touch1.clientY
    )
    // Store initial distance for pinch zoom
  } else {
    isPanning.value = true
    startX.value = e.touches[0].clientX
    startY.value = e.touches[0].clientY
  }
}

const handleLightboxTouchMove = (e) => {
  if (e.touches.length === 2) {
    // Pinch zoom
    e.preventDefault()
    const touch1 = e.touches[0]
    const touch2 = e.touches[1]
    const distance = Math.hypot(
      touch2.clientX - touch1.clientX,
      touch2.clientY - touch1.clientY
    )
    // Calculate zoom based on distance change
  } else if (isPanning.value && zoomLevel.value > 1) {
    const deltaX = e.touches[0].clientX - startX.value
    const deltaY = e.touches[0].clientY - startY.value
    panX.value = deltaX
    panY.value = deltaY
  }
}

const handleLightboxTouchEnd = () => {
  isPanning.value = false
}

const resetPosition = () => {
  isDragging.value = false
  translateX.value = 0
  rotateY.value = 0
  parallaxOffset.value = 0
}

const selectItem = (index) => {
  if (index === currentIndex.value) {
    openDetail(currentGalleryItems.value[index])
  } else {
    currentIndex.value = index
    vibrate(20)
  }
}

const goToSlide = (index) => {
  currentIndex.value = index
  vibrate(20)
}

const toggleLike = (item) => {
  item.isLiked = !item.isLiked
  vibrate([10, 10, 10])
}

const toggleView = () => {
  isGridView.value = !isGridView.value
  vibrate(20)
}

const openLightbox = (item, index) => {
  lightboxItem.value = item
  lightboxIndex.value = index
  document.body.style.overflow = 'hidden'
  vibrate(20)
}

const closeLightbox = () => {
  lightboxItem.value = null
  zoomLevel.value = 1
  panX.value = 0
  panY.value = 0
  document.body.style.overflow = 'auto'
}

const openDetail = (item) => {
  detailItem.value = item
  document.body.style.overflow = 'hidden'
  vibrate(30)
}

const closeDetail = () => {
  detailItem.value = null
  document.body.style.overflow = 'auto'
}

const zoomIn = () => {
  if (zoomLevel.value < 3) {
    zoomLevel.value += 0.5
    vibrate(10)
  }
}

const zoomOut = () => {
  if (zoomLevel.value > 1) {
    zoomLevel.value -= 0.5
    if (zoomLevel.value === 1) {
      panX.value = 0
      panY.value = 0
    }
    vibrate(10)
  }
}

const prevImage = () => {
  if (lightboxIndex.value > 0) {
    lightboxIndex.value--
    lightboxItem.value = currentGalleryItems.value[lightboxIndex.value]
    vibrate(20)
  }
}

const nextImage = () => {
  if (lightboxIndex.value < currentGalleryItems.value.length - 1) {
    lightboxIndex.value++
    lightboxItem.value = currentGalleryItems.value[lightboxIndex.value]
    vibrate(20)
  }
}

const openARView = () => {
  console.log('Open AR View')
  vibrate(30)
}

const shareImage = async () => {
  if (navigator.share && lightboxItem.value) {
    try {
      await navigator.share({
        title: lightboxItem.value.title,
        text: lightboxItem.value.description,
        url: window.location.href
      })
    } catch (err) {
      console.log('Share cancelled')
    }
  }
}

const downloadImage = () => {
  console.log('Download image')
  vibrate(20)
}

const toggleFullscreen = () => {
  if (!document.fullscreenElement) {
    document.documentElement.requestFullscreen()
  } else {
    document.exitFullscreen()
  }
  vibrate(20)
}

const shareProject = async () => {
  if (navigator.share && detailItem.value) {
    try {
      await navigator.share({
        title: detailItem.value.title,
        text: detailItem.value.description,
        url: window.location.href
      })
    } catch (err) {
      console.log('Share cancelled')
    }
  }
}

const requestSimilar = () => {
  console.log('Request similar project')
  vibrate(30)
}

const contactUs = () => {
  console.log('Contact us')
  vibrate(30)
}

const openLightboxAt = (index) => {
  // Open lightbox at specific gallery image
  console.log('Open lightbox at', index)
  vibrate(20)
}

const vibrate = (pattern) => {
  if (navigator.vibrate) {
    navigator.vibrate(pattern)
  }
}

// Auto-rotate effect
onMounted(() => {
  // Hide swipe hint after first interaction
  setTimeout(() => {
    if (showSwipeHint.value) {
      showSwipeHint.value = false
    }
  }, 5000)
})
</script>

<style scoped>
.mobile-gallery-3d {
  min-height: 100vh;
  background: #000;
  color: #FAFAF8;
  padding: 1rem;
  overflow-x: hidden;
}

/* Gallery Header */
.gallery-header {
  text-align: center;
  margin-bottom: 2rem;
  padding-top: 1rem;
}

.gallery-title {
  font-size: 2.5rem;
  margin-bottom: 0.5rem;
  line-height: 1.2;
}

.title-gradient {
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  font-weight: 300;
}

.title-bold {
  display: block;
  font-weight: 700;
  color: #FAFAF8;
}

.gallery-subtitle {
  font-size: 1rem;
  color: #999;
  font-weight: 300;
}

/* Filter Tabs */
.filter-tabs {
  margin-bottom: 2rem;
  overflow: hidden;
}

.tabs-scroll {
  display: flex;
  gap: 1rem;
  overflow-x: auto;
  padding: 0.5rem 0;
  -webkit-overflow-scrolling: touch;
  scrollbar-width: none;
}

.tabs-scroll::-webkit-scrollbar {
  display: none;
}

.tab-btn {
  position: relative;
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.75rem 1.5rem;
  background: rgba(255, 255, 255, 0.03);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 25px;
  color: #666;
  white-space: nowrap;
  cursor: pointer;
  transition: all 0.3s ease;
  flex-shrink: 0;
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
}

.tab-btn.active {
  background: rgba(164, 113, 72, 0.1);
  border-color: #a47148;
  color: #a47148;
}

.tab-icon {
  font-size: 18px;
}

.tab-indicator {
  position: absolute;
  bottom: 0;
  left: 10%;
  right: 10%;
  height: 2px;
  background: linear-gradient(90deg, transparent, #a47148, transparent);
  opacity: 0;
  transition: opacity 0.3s ease;
}

.tab-btn.active .tab-indicator {
  opacity: 1;
}

/* Gallery Container */
.gallery-container {
  position: relative;
  margin-bottom: 3rem;
}

.gallery-slider {
  position: relative;
  height: 500px;
  perspective: 1000px;
  overflow: hidden;
}

.gallery-track {
  position: relative;
  height: 100%;
  transform-style: preserve-3d;
  will-change: transform;
}

/* Gallery Items */
.gallery-item {
  position: absolute;
  width: 85%;
  height: 100%;
  left: 7.5%;
  top: 0;
  transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
  transform-style: preserve-3d;
  cursor: grab;
  user-select: none;
}

.gallery-item:active {
  cursor: grabbing;
}

.item-image-container {
  position: relative;
  height: 60%;
  border-radius: 20px 20px 0 0;
  overflow: hidden;
  background: linear-gradient(135deg, #1a1a1a, #0a0a0a);
}

.item-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.6s cubic-bezier(0.4, 0, 0.2, 1);
}

.gallery-item.active .item-image {
  transform: scale(1.05);
}

.parallax-overlay {
  position: absolute;
  inset: 0;
  pointer-events: none;
  will-change: transform;
}

.overlay-gradient {
  height: 100%;
  background: linear-gradient(180deg, transparent 50%, rgba(0,0,0,0.8) 100%);
}

/* Item Badge */
.item-badge {
  position: absolute;
  top: 1rem;
  left: 1rem;
  padding: 0.5rem 1rem;
  background: rgba(0, 0, 0, 0.8);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  border-radius: 20px;
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.badge-text {
  font-size: 0.75rem;
  color: #a47148;
  font-weight: 500;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

/* Like Button */
.like-btn {
  position: absolute;
  top: 1rem;
  right: 1rem;
  width: 44px;
  height: 44px;
  background: rgba(0, 0, 0, 0.8);
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

.like-btn.liked {
  background: rgba(231, 76, 60, 0.2);
  border-color: #e74c3c;
}

.like-btn.liked .material-icons {
  color: #e74c3c;
}

.like-btn:active {
  transform: scale(0.9);
}

.like-ripple {
  position: absolute;
  inset: -4px;
  border: 2px solid #e74c3c;
  border-radius: 50%;
  opacity: 0;
}

.like-btn.liked .like-ripple {
  animation: likeRipple 0.6s ease-out;
}

@keyframes likeRipple {
  0% {
    transform: scale(1);
    opacity: 1;
  }
  100% {
    transform: scale(1.5);
    opacity: 0;
  }
}

/* Item Content */
.item-content {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  padding: 1.5rem;
  background: rgba(0, 0, 0, 0.95);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border-radius: 0 0 20px 20px;
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-top: none;
}

.item-title {
  font-size: 1.25rem;
  font-weight: 500;
  color: #FAFAF8;
  margin-bottom: 0.5rem;
}

.item-location {
  display: flex;
  align-items: center;
  gap: 0.25rem;
  font-size: 0.875rem;
  color: #999;
  margin-bottom: 1rem;
}

.item-location .material-icons {
  font-size: 16px;
  color: #a47148;
}

/* Item Stats */
.item-stats {
  display: flex;
  gap: 1.5rem;
  margin-bottom: 1rem;
}

.stat {
  display: flex;
  align-items: center;
  gap: 0.25rem;
}

.stat-icon {
  font-size: 16px;
  color: #666;
}

.stat-value {
  font-size: 0.875rem;
  color: #FAFAF8;
  font-weight: 500;
}

/* Item Action */
.item-action {
  width: 100%;
  padding: 0.75rem;
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  border: none;
  border-radius: 12px;
  color: #000;
  font-size: 0.875rem;
  font-weight: 500;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  cursor: pointer;
  transition: all 0.3s ease;
}

.item-action:active {
  transform: scale(0.95);
}

/* 3D Tilt Effect */
.tilt-effect {
  position: absolute;
  inset: 0;
  background: linear-gradient(135deg, transparent, rgba(255,255,255,0.05));
  opacity: 0;
  transition: opacity 0.3s ease;
  pointer-events: none;
  border-radius: 20px;
}

.gallery-item.active .tilt-effect {
  opacity: 1;
}

/* Navigation Dots */
.nav-dots {
  position: absolute;
  bottom: -2rem;
  left: 50%;
  transform: translateX(-50%);
  display: flex;
  gap: 0.5rem;
  padding: 0.5rem 1rem;
  background: rgba(0, 0, 0, 0.8);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  border-radius: 20px;
}

.dot {
  position: relative;
  width: 8px;
  height: 8px;
  background: rgba(255, 255, 255, 0.2);
  border: none;
  border-radius: 50%;
  cursor: pointer;
  transition: all 0.3s ease;
  overflow: hidden;
}

.dot.active {
  width: 24px;
  background: rgba(164, 113, 72, 0.3);
}

.dot-fill {
  position: absolute;
  inset: 0;
  background: #a47148;
  border-radius: 50%;
  transform: scale(0);
  transition: transform 0.3s ease;
}

.dot.active .dot-fill {
  transform: scale(1);
}

/* Swipe Hint */
.swipe-hint {
  position: absolute;
  bottom: 50%;
  left: 50%;
  transform: translate(-50%, 50%);
  text-align: center;
  pointer-events: none;
  animation: swipeHint 2s ease-in-out infinite;
}

@keyframes swipeHint {
  0%, 100% { opacity: 0.5; }
  50% { opacity: 1; }
}

.swipe-hand {
  font-size: 48px;
  color: rgba(255, 255, 255, 0.3);
  animation: swipeMove 2s ease-in-out infinite;
}

@keyframes swipeMove {
  0%, 100% { transform: translateX(0); }
  50% { transform: translateX(-20px); }
}

.swipe-hint p {
  font-size: 0.875rem;
  color: rgba(255, 255, 255, 0.5);
  margin-top: 0.5rem;
}

/* AR FAB */
.ar-fab {
  position: absolute;
  top: 1rem;
  right: 1rem;
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.75rem 1.25rem;
  background: rgba(0, 0, 0, 0.8);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 25px;
  color: #FAFAF8;
  font-size: 0.875rem;
  cursor: pointer;
  z-index: 10;
}

.ar-fab:active {
  transform: scale(0.95);
  background: rgba(164, 113, 72, 0.2);
}

.ar-pulse {
  position: absolute;
  inset: -4px;
  border: 1px solid #a47148;
  border-radius: 25px;
  animation: arPulse 2s ease-out infinite;
}

@keyframes arPulse {
  0% {
    transform: scale(1);
    opacity: 1;
  }
  100% {
    transform: scale(1.1);
    opacity: 0;
  }
}

/* View Toggle */
.view-toggle {
  position: fixed;
  bottom: 2rem;
  right: 1rem;
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.75rem 1.25rem;
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  border: none;
  border-radius: 25px;
  color: #000;
  font-size: 0.875rem;
  font-weight: 500;
  cursor: pointer;
  z-index: 10;
  box-shadow: 0 4px 20px rgba(164, 113, 72, 0.4);
}

.view-toggle:active {
  transform: scale(0.95);
}

/* Grid View */
.gallery-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 1rem;
  padding: 1rem 0;
}

.grid-item {
  position: relative;
  aspect-ratio: 1;
  border-radius: 12px;
  overflow: hidden;
  cursor: pointer;
  animation: gridItemFadeIn 0.5s ease-out forwards;
  opacity: 0;
  transform: scale(0.9);
}

@keyframes gridItemFadeIn {
  to {
    opacity: 1;
    transform: scale(1);
  }
}

.grid-image {
  position: relative;
  width: 100%;
  height: 100%;
}

.grid-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.3s ease;
}

.grid-item:active img {
  transform: scale(0.95);
}

.grid-overlay {
  position: absolute;
  inset: 0;
  background: rgba(0, 0, 0, 0.7);
  display: flex;
  align-items: center;
  justify-content: center;
  opacity: 0;
  transition: opacity 0.3s ease;
}

.grid-item:hover .grid-overlay {
  opacity: 1;
}

.grid-overlay .material-icons {
  font-size: 32px;
  color: #FAFAF8;
}

/* Lightbox */
.lightbox {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.98);
  z-index: 9999;
  display: flex;
  flex-direction: column;
}

.lightbox-content {
  position: relative;
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
}

.lightbox-close {
  position: absolute;
  top: 1rem;
  right: 1rem;
  width: 44px;
  height: 44px;
  background: rgba(255, 255, 255, 0.1);
  border: none;
  border-radius: 50%;
  color: #FAFAF8;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  z-index: 10;
}

.lightbox-viewer {
  flex: 1;
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
}

.lightbox-image {
  max-width: 100%;
  max-height: 100%;
  object-fit: contain;
  will-change: transform;
  touch-action: none;
}

/* Zoom Controls */
.zoom-controls {
  position: absolute;
  bottom: 2rem;
  left: 50%;
  transform: translateX(-50%);
  display: flex;
  align-items: center;
  gap: 1rem;
  padding: 0.75rem 1.5rem;
  background: rgba(0, 0, 0, 0.8);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 25px;
}

.zoom-btn {
  width: 36px;
  height: 36px;
  background: rgba(255, 255, 255, 0.1);
  border: none;
  border-radius: 50%;
  color: #FAFAF8;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
}

.zoom-btn:active {
  background: rgba(164, 113, 72, 0.2);
}

.zoom-level {
  font-size: 0.875rem;
  color: #FAFAF8;
  min-width: 50px;
  text-align: center;
}

/* Lightbox Info */
.lightbox-info {
  padding: 1.5rem;
  background: rgba(0, 0, 0, 0.95);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border-top: 1px solid rgba(255, 255, 255, 0.1);
}

.lightbox-info h3 {
  font-size: 1.25rem;
  font-weight: 500;
  color: #FAFAF8;
  margin-bottom: 0.5rem;
}

.lightbox-info p {
  font-size: 0.875rem;
  color: #999;
  margin-bottom: 1rem;
}

.lightbox-details {
  display: flex;
  gap: 1.5rem;
  margin-bottom: 1rem;
}

.detail-item {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  font-size: 0.875rem;
  color: #666;
}

.detail-item .material-icons {
  font-size: 18px;
  color: #a47148;
}

/* Share Options */
.share-options {
  display: flex;
  gap: 1rem;
}

.share-btn {
  width: 44px;
  height: 44px;
  background: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 50%;
  color: #FAFAF8;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.3s ease;
}

.share-btn:active {
  background: rgba(164, 113, 72, 0.2);
  transform: scale(0.9);
}

/* Lightbox Navigation */
.lightbox-nav {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  width: 44px;
  height: 44px;
  background: rgba(0, 0, 0, 0.8);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 50%;
  color: #FAFAF8;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
}

.lightbox-nav.prev {
  left: 1rem;
}

.lightbox-nav.next {
  right: 1rem;
}

.lightbox-nav:active {
  transform: translateY(-50%) scale(0.9);
}

/* Detail Modal */
.detail-modal {
  position: fixed;
  inset: 0;
  background: #000;
  z-index: 9998;
  overflow-y: auto;
  -webkit-overflow-scrolling: touch;
}

.modal-header {
  position: sticky;
  top: 0;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 1rem;
  background: rgba(0, 0, 0, 0.95);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
  z-index: 10;
}

.modal-back,
.modal-share {
  width: 44px;
  height: 44px;
  background: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 50%;
  color: #FAFAF8;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
}

.modal-header h2 {
  font-size: 1.125rem;
  font-weight: 500;
  color: #FAFAF8;
}

/* Detail Hero */
.detail-hero {
  position: relative;
  height: 300px;
  overflow: hidden;
}

.detail-hero img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.hero-gradient {
  position: absolute;
  inset: 0;
  background: linear-gradient(180deg, transparent 40%, rgba(0,0,0,0.9) 100%);
}

.hero-info {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  padding: 2rem 1.5rem;
}

.hero-info h1 {
  font-size: 2rem;
  font-weight: 600;
  color: #FAFAF8;
  margin-bottom: 0.5rem;
}

.hero-info p {
  font-size: 1rem;
  color: #a47148;
}

/* Detail Info */
.detail-info {
  padding: 1.5rem;
}

.info-section {
  margin-bottom: 2.5rem;
}

.info-section h3 {
  font-size: 1.25rem;
  font-weight: 500;
  color: #FAFAF8;
  margin-bottom: 1rem;
}

.info-section p {
  font-size: 1rem;
  line-height: 1.6;
  color: #ccc;
}

/* Material List */
.material-list {
  display: grid;
  gap: 0.75rem;
}

.material-item {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  padding: 0.75rem;
  background: rgba(255, 255, 255, 0.03);
  border-radius: 12px;
  font-size: 0.875rem;
  color: #FAFAF8;
}

.material-icon {
  font-size: 20px;
  color: #a47148;
}

/* Data Grid */
.data-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 1rem;
}

.data-item {
  padding: 1rem;
  background: rgba(255, 255, 255, 0.03);
  border-radius: 12px;
  text-align: center;
}

.data-label {
  display: block;
  font-size: 0.75rem;
  color: #666;
  margin-bottom: 0.5rem;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.data-value {
  display: block;
  font-size: 1.25rem;
  font-weight: 500;
  color: #a47148;
}

/* Detail Gallery */
.detail-gallery {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 0.5rem;
}

.gallery-thumb {
  aspect-ratio: 1;
  border-radius: 8px;
  overflow: hidden;
  cursor: pointer;
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.3s ease;
}

.gallery-thumb:active {
  transform: scale(0.95);
}

/* Detail CTA */
.detail-cta {
  display: flex;
  flex-direction: column;
  gap: 1rem;
  margin-top: 3rem;
}

.cta-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  padding: 1rem;
  border-radius: 16px;
  font-size: 0.875rem;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.3s ease;
  border: none;
}

.cta-btn.primary {
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  color: #000;
}

.cta-btn.secondary {
  background: transparent;
  border: 2px solid rgba(255, 255, 255, 0.2);
  color: #FAFAF8;
}

.cta-btn:active {
  transform: scale(0.95);
}

/* Transitions */
.grid-transition-enter-active,
.grid-transition-leave-active {
  transition: all 0.3s ease;
}

.grid-transition-enter-from {
  opacity: 0;
  transform: translateY(20px);
}

.grid-transition-leave-to {
  opacity: 0;
  transform: translateY(-20px);
}

.lightbox-enter-active,
.lightbox-leave-active {
  transition: opacity 0.3s ease;
}

.lightbox-enter-from,
.lightbox-leave-to {
  opacity: 0;
}

.lightbox-enter-active .lightbox-content,
.lightbox-leave-active .lightbox-content {
  transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.lightbox-enter-from .lightbox-content {
  transform: scale(0.9);
}

.lightbox-leave-to .lightbox-content {
  transform: scale(1.1);
}

.detail-modal-enter-active,
.detail-modal-leave-active {
  transition: transform 0.4s cubic-bezier(0.4, 0, 0.2, 1);
}

.detail-modal-enter-from {
  transform: translateY(100%);
}

.detail-modal-leave-to {
  transform: translateY(100%);
}

/* Responsive */
@media (min-width: 768px) {
  .gallery-grid {
    grid-template-columns: repeat(3, 1fr);
  }
  
  .data-grid {
    grid-template-columns: repeat(4, 1fr);
  }
}

@media (max-width: 360px) {
  .gallery-item {
    width: 90%;
    left: 5%;
  }
  
  .item-stats {
    gap: 0.75rem;
  }
  
  .stat-value {
    font-size: 0.75rem;
  }
}

/* iOS specific fixes */
@supports (-webkit-touch-callout: none) {
  .gallery-slider,
  .lightbox-viewer {
    -webkit-transform: translateZ(0);
  }
}
</style>