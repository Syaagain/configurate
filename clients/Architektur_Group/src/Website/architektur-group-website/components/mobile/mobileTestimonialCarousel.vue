<template>
  <div class="mobile-testimonial-carousel">
    <!-- Header -->
    <div class="carousel-header">
      <h2 class="carousel-title">Kundenstimmen</h2>
      <p class="carousel-subtitle">Was unsere Kunden über uns sagen</p>
    </div>
<!-- Main Carousel -->
<div 
  class="carousel-container"
  @touchstart="handleTouchStart"
  @touchmove="handleTouchMove"
  @touchend="handleTouchEnd"
>
  <div 
    class="carousel-track"
    :style="{ 
      transform: `translateX(${translateX}px) scale(${scale})`,
      transition: isDragging ? 'none' : 'all 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94)'
    }"
  >
    <div
      v-for="(testimonial, index) in testimonials"
      :key="testimonial.id"
      :class="['testimonial-card', { 
        active: currentIndex === index,
        prev: currentIndex - 1 === index,
        next: currentIndex + 1 === index
      }]"
      :style="getCardStyle(index)"
    >
      <!-- Rating Stars -->
      <div class="rating-container">
        <div class="stars">
          <span 
            v-for="star in 5" 
            :key="star"
            class="star"
            :class="{ filled: star <= testimonial.rating }"
          >
            ★
          </span>
        </div>
        <span class="rating-text">{{ testimonial.rating }}.0</span>
      </div>

      <!-- Quote -->
      <blockquote class="testimonial-quote">
        <span class="quote-mark">"</span>
        {{ testimonial.quote }}
        <span class="quote-mark">"</span>
      </blockquote>

      <!-- Project Info -->
      <div v-if="testimonial.project" class="project-info">
        <div class="project-image">
          <img :src="testimonial.project.image" :alt="testimonial.project.name">
          <div class="project-overlay">
            <span class="material-icons">visibility</span>
          </div>
        </div>
        <div class="project-details">
          <h4>{{ testimonial.project.name }}</h4>
          <p>{{ testimonial.project.type }}</p>
        </div>
      </div>

      <!-- Author -->
      <div class="testimonial-author">
        <div class="author-avatar">
          <img :src="testimonial.avatar" :alt="testimonial.name">
          <div class="avatar-ring"></div>
        </div>
        <div class="author-info">
          <h4 class="author-name">{{ testimonial.name }}</h4>
          <p class="author-title">{{ testimonial.title }}</p>
          <p class="author-location">
            <span class="material-icons">location_on</span>
            {{ testimonial.location }}
          </p>
        </div>
      </div>

      <!-- Verification Badge -->
      <div v-if="testimonial.verified" class="verification-badge">
        <span class="material-icons">verified</span>
        Verifizierter Kunde
      </div>
    </div>
  </div>
</div>

<!-- Navigation Dots -->
<div class="navigation-dots">
  <button
    v-for="(testimonial, index) in testimonials"
    :key="index"
    @click="goToSlide(index)"
    :class="['dot', { active: currentIndex === index }]"
    :aria-label="`Go to testimonial ${index + 1}`"
  >
    <span class="dot-progress" v-if="currentIndex === index && autoPlay"></span>
  </button>
</div>

<!-- Navigation Buttons -->
<div class="navigation-buttons">
  <button @click="prevSlide" class="nav-btn prev" :disabled="currentIndex === 0">
    <span class="material-icons">chevron_left</span>
  </button>
  <button @click="nextSlide" class="nav-btn next" :disabled="currentIndex === testimonials.length - 1">
    <span class="material-icons">chevron_right</span>
  </button>
</div>

<!-- Stats Bar -->
<div class="stats-bar">
  <div class="stat-item">
    <div class="stat-number">{{ totalProjects }}</div>
    <div class="stat-label">Projekte</div>
  </div>
  <div class="stat-item">
    <div class="stat-number">{{ averageRating }}</div>
    <div class="stat-label">⭐ Bewertung</div>
  </div>
  <div class="stat-item">
    <div class="stat-number">{{ satisfactionRate }}%</div>
    <div class="stat-label">Zufriedenheit</div>
  </div>
</div>

<!-- Share Button -->
<button @click="shareTestimonial" class="share-button">
  <span class="material-icons">share</span>
  Teilen
</button>
  </div>
</template>
<script setup>
import { ref, computed, onMounted, onUnmounted } from 'vue'

const props = defineProps({
  autoPlay: {
    type: Boolean,
    default: true
  },
  interval: {
    type: Number,
    default: 5000
  }
})

// Data
const testimonials = ref([
  {
    id: 1,
    name: 'Familie Müller',
    title: 'Privatkunde',
    location: 'München',
    avatar: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686576cf622e38e88f0236c5.png',
    quote: 'Die Qualität der Arbeit und die Beratung waren außergewöhnlich. Unser Badezimmer ist jetzt ein echter Wohlfühlort.',
    rating: 5,
    verified: true,
    project: {
      name: 'Luxus-Badezimmer',
      type: 'Komplettumbau',
      image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png'
    }
  },
  {
    id: 2,
    name: 'Dr. Schmidt',
    title: 'Geschäftskunde',
    location: 'Starnberg',
    avatar: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png',
    quote: 'Professionelle Abwicklung von A bis Z. Die Terrasse ist ein Meisterwerk geworden.',
    rating: 5,
    verified: true,
    project: {
      name: 'Terrassengestaltung',
      type: 'Naturstein Premium',
      image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b70b0803723582ed6.png'
    }
  },
  {
    id: 3,
    name: 'Hotel Bayerischer Hof',
    title: 'Gewerblicher Kunde',
    location: 'München',
    avatar: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b097a8069ca3ac95a.png',
    quote: 'Herausragende Handwerkskunst für unsere Lobby-Renovierung. Absolut empfehlenswert!',
    rating: 5,
    verified: true,
    project: {
      name: 'Hotel Lobby',
      type: 'Marmor Installation',
      image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686576cf622e38e88f0236c5.png'
    }
  }
])

// State
const currentIndex = ref(0)
const translateX = ref(0)
const scale = ref(1)
const isDragging = ref(false)
const startX = ref(0)
const currentX = ref(0)

// Computed
const totalProjects = computed(() => testimonials.value.length * 167)
const averageRating = computed(() => {
  const sum = testimonials.value.reduce((acc, t) => acc + t.rating, 0)
  return (sum / testimonials.value.length).toFixed(1)
})
const satisfactionRate = computed(() => 98)

// Touch handling
const handleTouchStart = (e) => {
  isDragging.value = true
  startX.value = e.touches[0].clientX
  currentX.value = startX.value
}

const handleTouchMove = (e) => {
  if (!isDragging.value) return
  
  currentX.value = e.touches[0].clientX
  const diff = currentX.value - startX.value
  
  // Calculate translation with resistance at edges
  const resistance = 0.3
  const maxTranslate = window.innerWidth * 0.8
  
  if ((currentIndex.value === 0 && diff > 0) || 
      (currentIndex.value === testimonials.value.length - 1 && diff < 0)) {
    translateX.value = diff * resistance
  } else {
    translateX.value = diff
  }
  
  // Scale effect while dragging
  scale.value = 1 - Math.abs(diff) / 1000
}

const handleTouchEnd = () => {
  isDragging.value = false
  
  const threshold = 50
  const diff = currentX.value - startX.value
  
  if (Math.abs(diff) > threshold) {
    if (diff > 0 && currentIndex.value > 0) {
      prevSlide()
    } else if (diff < 0 && currentIndex.value < testimonials.value.length - 1) {
      nextSlide()
    } else {
      resetPosition()
    }
  } else {
    resetPosition()
  }
}

const resetPosition = () => {
  translateX.value = 0
  scale.value = 1
}

const goToSlide = (index) => {
  currentIndex.value = index
  resetPosition()
  
  // Haptic feedback
  if (navigator.vibrate) {
    navigator.vibrate(50)
  }
}

const prevSlide = () => {
  if (currentIndex.value > 0) {
    currentIndex.value--
    resetPosition()
  }
}

const nextSlide = () => {
  if (currentIndex.value < testimonials.value.length - 1) {
    currentIndex.value++
    resetPosition()
  }
}

const getCardStyle = (index) => {
  const offset = index - currentIndex.value
  const baseTranslate = offset * 320
  const opacity = Math.abs(offset) > 1 ? 0 : 1 - Math.abs(offset) * 0.3
  const scale = Math.abs(offset) > 1 ? 0.8 : 1 - Math.abs(offset) * 0.1
  
  return {
    transform: `translateX(${baseTranslate}px) scale(${scale})`,
    opacity,
    zIndex: testimonials.value.length - Math.abs(offset)
  }
}

const shareTestimonial = async () => {
  const testimonial = testimonials.value[currentIndex.value]
  
  if (navigator.share) {
    try {
      await navigator.share({
        title: 'Kundenbewertung',
        text: `"${testimonial.quote}" - ${testimonial.name}`,
        url: window.location.href
      })
    } catch (error) {
      console.log('Share failed:', error)
    }
  }
}

// Auto-play
let autoPlayInterval = null

const startAutoPlay = () => {
  if (props.autoPlay) {
    autoPlayInterval = setInterval(() => {
      if (currentIndex.value < testimonials.value.length - 1) {
        nextSlide()
      } else {
        currentIndex.value = 0
      }
    }, props.interval)
  }
}

const stopAutoPlay = () => {
  if (autoPlayInterval) {
    clearInterval(autoPlayInterval)
  }
}

onMounted(() => {
  startAutoPlay()
})

onUnmounted(() => {
  stopAutoPlay()
})
</script>
<style scoped>
.mobile-testimonial-carousel {
  position: relative;
  width: 100%;
  padding: 40px 0;
  background: linear-gradient(135deg, #0a0a0a 0%, #1a1a1a 100%);
  overflow: hidden;
}

/* Header */
.carousel-header {
  text-align: center;
  margin-bottom: 40px;
  padding: 0 20px;
}

.carousel-title {
  font-size: 2rem;
  font-weight: 300;
  color: #FAFAF8;
  margin: 0 0 8px;
  background: linear-gradient(135deg, #FAFAF8 0%, #a47148 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.carousel-subtitle {
  font-size: 1rem;
  color: #999;
}

/* Carousel Container */
.carousel-container {
  position: relative;
  width: 100%;
  height: 500px;
  margin-bottom: 40px;
  touch-action: pan-y;
}

.carousel-track {
  position: absolute;
  top: 0;
  left: 50%;
  transform-origin: center;
  display: flex;
  align-items: center;
  height: 100%;
}

/* Testimonial Card */
.testimonial-card {
  position: absolute;
  width: 300px;
  background: linear-gradient(135deg, rgba(26, 26, 26, 0.95) 0%, rgba(10, 10, 10, 0.95) 100%);
  backdrop-filter: blur(20px);
  border-radius: 24px;
  padding: 30px;
  margin-left: -150px;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
  border: 1px solid rgba(255, 255, 255, 0.1);
  transition: all 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

.testimonial-card.active {
  transform: scale(1.05);
  box-shadow: 0 25px 80px rgba(164, 113, 72, 0.3);
}

/* Rating */
.rating-container {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 20px;
}

.stars {
  display: flex;
  gap: 2px;
}

.star {
  font-size: 18px;
  color: #333;
  transition: color 0.3s ease;
}

.star.filled {
  color: #FFD700;
  text-shadow: 0 0 10px rgba(255, 215, 0, 0.5);
}

.rating-text {
  font-size: 0.875rem;
  color: #a47148;
  font-weight: 500;
}

/* Quote */
.testimonial-quote {
  font-size: 1rem;
  line-height: 1.6;
  color: #FAFAF8;
  margin: 0 0 20px;
  position: relative;
}

.quote-mark {
  font-size: 2rem;
  color: #a47148;
  opacity: 0.5;
  position: absolute;
}

.quote-mark:first-child {
  top: -10px;
  left: -10px;
}

.quote-mark:last-child {
  bottom: -20px;
  right: -10px;
}

/* Project Info */
.project-info {
  display: flex;
  gap: 12px;
  padding: 12px;
  background: rgba(255, 255, 255, 0.05);
  border-radius: 12px;
  margin-bottom: 20px;
}

.project-image {
  position: relative;
  width: 60px;
  height: 60px;
  border-radius: 8px;
  overflow: hidden;
  flex-shrink: 0;
}

.project-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.project-overlay {
  position: absolute;
  inset: 0;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  opacity: 0;
  transition: opacity 0.3s ease;
}

.project-info:hover .project-overlay {
  opacity: 1;
}

.project-overlay .material-icons {
  color: white;
  font-size: 24px;
}

.project-details h4 {
  font-size: 0.875rem;
  font-weight: 500;
  color: #FAFAF8;
  margin: 0 0 4px;
}

.project-details p {
  font-size: 0.75rem;
  color: #a47148;
  margin: 0;
}

/* Author */
.testimonial-author {
  display: flex;
  align-items: center;
  gap: 16px;
  margin-bottom: 16px;
}

.author-avatar {
  position: relative;
  width: 56px;
  height: 56px;
  flex-shrink: 0;
}

.author-avatar img {
  width: 100%;
  height: 100%;
  border-radius: 50%;
  object-fit: cover;
  border: 3px solid rgba(164, 113, 72, 0.3);
}

.avatar-ring {
  position: absolute;
  inset: -4px;
  border: 2px solid rgba(164, 113, 72, 0.2);
  border-radius: 50%;
  animation: ring-pulse 3s ease-in-out infinite;
}

@keyframes ring-pulse {
  0%, 100% { transform: scale(1); opacity: 1; }
  50% { transform: scale(1.1); opacity: 0.5; }
}

.author-info {
  flex: 1;
}

.author-name {
  font-size: 1rem;
  font-weight: 500;
  color: #FAFAF8;
  margin: 0 0 2px;
}

.author-title {
  font-size: 0.813rem;
  color: #a47148;
  margin: 0 0 4px;
}

.author-location {
  display: flex;
  align-items: center;
  gap: 4px;
  font-size: 0.75rem;
  color: #999;
  margin: 0;
}

.author-location .material-icons {
  font-size: 14px;
}

/* Verification Badge */
.verification-badge {
  display: flex;
  align-items: center;
  gap: 6px;
  padding: 6px 12px;
  background: linear-gradient(135deg, rgba(164, 113, 72, 0.2), rgba(250, 250, 248, 0.2));
  border: 1px solid rgba(164, 113, 72, 0.3);
  border-radius: 20px;
  font-size: 0.75rem;
  color: #a47148;
}

.verification-badge .material-icons {
  font-size: 16px;
}

/* Navigation Dots */
.navigation-dots {
  display: flex;
  justify-content: center;
  gap: 8px;
  margin-bottom: 24px;
}

.dot {
  position: relative;
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.2);
  border: none;
  cursor: pointer;
  transition: all 0.3s ease;
  overflow: hidden;
}

.dot.active {
  width: 32px;
  border-radius: 4px;
  background: rgba(164, 113, 72, 0.3);
}

.dot-progress {
  position: absolute;
  top: 0;
  left: 0;
  height: 100%;
  background: #a47148;
  animation: progress 5s linear;
}

@keyframes progress {
  from { width: 0%; }
  to { width: 100%; }
}

/* Navigation Buttons */
.navigation-buttons {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  width: 100%;
  display: flex;
  justify-content: space-between;
  padding: 0 20px;
  pointer-events: none;
}

.nav-btn {
  width: 48px;
  height: 48px;
  border-radius: 50%;
  background: rgba(0, 0, 0, 0.7);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.1);
  color: #FAFAF8;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.3s ease;
  pointer-events: auto;
}

.nav-btn:disabled {
  opacity: 0.3;
  cursor: not-allowed;
}

.nav-btn:not(:disabled):active {
  transform: scale(0.9);
  background: rgba(164, 113, 72, 0.3);
}

/* Stats Bar */
.stats-bar {
  display: flex;
  justify-content: space-around;
  padding: 24px 20px;
  background: rgba(255, 255, 255, 0.05);
  backdrop-filter: blur(10px);
  margin: 0 20px 24px;
  border-radius: 16px;
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.stat-item {
  text-align: center;
}

.stat-number {
  font-size: 1.5rem;
  font-weight: 600;
  color: #a47148;
  margin-bottom: 4px;
}

.stat-label {
  font-size: 0.75rem;
  color: #999;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

/* Share Button */
.share-button {
  position: absolute;
  top: 20px;
  right: 20px;
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 10px 20px;
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 50px;
  color: #FAFAF8;
  font-size: 0.875rem;
  cursor: pointer;
  transition: all 0.3s ease;
}

.share-button:active {
  transform: scale(0.95);
  background: rgba(164, 113, 72, 0.3);
}
</style>