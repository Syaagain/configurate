<template>
  <section class="mobile-hero">
    <!-- Video Background -->
    <div class="hero-media" :style="{ transform: `translateY(${scrollY * 0.3}px)` }">
      <video
        ref="heroVideo"
        :src="videoSrc"
        autoplay
        muted
        loop
        playsinline
        preload="auto"
        class="hero-video"
        @loadedmetadata="onVideoLoaded"
      ></video>
      
      <!-- Gradient Overlays -->
      <div class="hero-gradient-top"></div>
      <div class="hero-gradient-bottom"></div>
      <div class="hero-vignette"></div>
    </div>

    <!-- Hero Content -->
    <div class="hero-content">
      <!-- Animated Logo -->
      <div class="hero-logo" :class="{ 'visible': logoVisible }">
        <div class="logo-container">
          <div class="logo-outer">
            <div class="logo-inner">
              <span class="logo-text">AG</span>
            </div>
          </div>
          <div class="logo-particles">
            <span v-for="i in 6" :key="i" class="particle" :style="getParticleStyle(i)"></span>
          </div>
        </div>
      </div>

      <!-- Animated Title -->
      <div class="hero-title-wrapper">
        <h1 class="hero-title">
          <span 
            v-for="(word, index) in titleWords" 
            :key="index"
            class="title-word"
            :style="{ animationDelay: `${index * 0.2}s` }"
          >
            {{ word }}
          </span>
        </h1>
      </div>

      <!-- Animated Subtitle -->
      <div class="hero-subtitle-wrapper">
        <p class="hero-subtitle">
          <span class="subtitle-line">{{ subtitle }}</span>
        </p>
      </div>

      <!-- CTA Buttons -->
      <div class="hero-actions">
        <button @click="exploreCollection" class="cta-primary">
          <span class="cta-text">Kollektion entdecken</span>
          <div class="cta-shine"></div>
          <div class="cta-bg"></div>
        </button>
      </div>

      <!-- Scroll Indicator -->
      <div class="scroll-indicator" @click="scrollToContent">
        <div class="scroll-mouse">
          <div class="scroll-wheel"></div>
        </div>
        <span class="scroll-text">Scroll</span>
      </div>
    </div>

    <!-- Floating Elements -->
    <div class="floating-elements">
      <div 
        v-for="element in floatingElements" 
        :key="element.id"
        class="floating-element"
        :style="getFloatingStyle(element)"
      >
        <span class="material-icons">{{ element.icon }}</span>
      </div>
    </div>

    <!-- Stats Bar -->
    <div class="hero-stats">
      <div 
        v-for="stat in stats" 
        :key="stat.id"
        class="stat-item"
        :class="{ 'visible': statsVisible }"
      >
        <div class="stat-number" :data-target="stat.value">0</div>
        <div class="stat-label">{{ stat.label }}</div>
      </div>
    </div>
  </section>
</template>

<script setup>
import { ref, onMounted } from 'vue'

const scrollY = ref(0)
const logoVisible = ref(false)
const statsVisible = ref(false)
const videoSrc = 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/68545d9204d5bf38e7066c74.mp4'

const titleWords = ['EUROPAS', 'EXQUISITESTE', 'SELEKTION']
const subtitle = 'Erlesene Beläge für außergewöhnliche Räume'

const stats = [
  { id: 1, value: 500, label: 'Projekte' },
  { id: 2, value: 200, label: 'Materialien' },
  { id: 3, value: 25, label: 'Jahre' }
]

const floatingElements = [
  { id: 1, icon: 'diamond', speed: 0.5, offset: 20 },
  { id: 2, icon: 'architecture', speed: 0.3, offset: 60 },
  { id: 3, icon: 'star', speed: 0.4, offset: 40 },
  { id: 4, icon: 'spa', speed: 0.6, offset: 80 }
]

const getParticleStyle = (index) => {
  const angle = (index * 60) * Math.PI / 180
  const radius = 80
  return {
    transform: `translate(${Math.cos(angle) * radius}px, ${Math.sin(angle) * radius}px)`,
    animationDelay: `${index * 0.1}s`
  }
}

const getFloatingStyle = (element) => {
  return {
    '--float-speed': `${element.speed}`,
    '--float-offset': `${element.offset}%`,
    animationDelay: `${Math.random() * 5}s`
  }
}

const onVideoLoaded = () => {
  // Video loaded callback
  console.log('Video loaded')
}

const exploreCollection = () => {
  // Navigate to collection
  console.log('Explore collection')
}

const watchVideo = () => {
  // Open video modal
  console.log('Watch video')
}

const scrollToContent = () => {
  window.scrollTo({
    top: window.innerHeight,
    behavior: 'smooth'
  })
}

const animateStats = () => {
  const statNumbers = document.querySelectorAll('.stat-number')
  statNumbers.forEach(stat => {
    const target = parseInt(stat.dataset.target)
    const duration = 2000
    const increment = target / (duration / 16)
    let current = 0
    
    const updateNumber = () => {
      current += increment
      if (current < target) {
        stat.textContent = Math.floor(current)
        requestAnimationFrame(updateNumber)
      } else {
        stat.textContent = target + '+'
      }
    }
    updateNumber()
  })
}

onMounted(() => {
  // Trigger animations
  setTimeout(() => {
    logoVisible.value = true
  }, 500)
  
  // Parallax scroll
  const handleScroll = () => {
    scrollY.value = window.scrollY
  }
  window.addEventListener('scroll', handleScroll)
  
  // Stats animation on intersection
  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting && !statsVisible.value) {
        statsVisible.value = true
        animateStats()
      }
    })
  }, { threshold: 0.5 })
  
  const statsElement = document.querySelector('.hero-stats')
  if (statsElement) observer.observe(statsElement)
})
</script>

<style scoped>
.mobile-hero {
  position: relative;
  width: 100%;
  height: 100vh;
  min-height: 600px;
  overflow: hidden;
  background: #000;
}

/* Video Background */
.hero-media {
  position: absolute;
  inset: -10%;
  width: 120%;
  height: 120%;
  will-change: transform;
}

.hero-video {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.hero-gradient-top {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 30%;
  background: linear-gradient(180deg, rgba(0,0,0,0.8) 0%, transparent 100%);
  z-index: 1;
}

.hero-gradient-bottom {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  height: 50%;
  background: linear-gradient(0deg, rgba(0,0,0,0.9) 0%, transparent 100%);
  z-index: 1;
}

.hero-vignette {
  position: absolute;
  inset: 0;
  background: radial-gradient(circle at center, transparent 40%, rgba(0,0,0,0.4) 100%);
  z-index: 1;
}

/* Hero Content */
.hero-content {
  position: relative;
  z-index: 2;
  height: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 2rem;
  text-align: center;
}

/* Animated Logo */
.hero-logo {
  margin-bottom: 2rem;
  opacity: 0;
  transform: scale(0.8);
  transition: all 1s cubic-bezier(0.4, 0, 0.2, 1);
}

.hero-logo.visible {
  opacity: 1;
  transform: scale(1);
}

.logo-container {
  position: relative;
  width: 120px;
  height: 120px;
}

.logo-outer {
  width: 100%;
  height: 100%;
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  clip-path: polygon(50% 0%, 100% 25%, 100% 75%, 50% 100%, 0% 75%, 0% 25%);
  display: flex;
  align-items: center;
  justify-content: center;
  animation: logoRotate 20s linear infinite;
}

@keyframes logoRotate {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}

.logo-inner {
  width: calc(100% - 6px);
  height: calc(100% - 6px);
  background: #000;
  clip-path: polygon(50% 0%, 100% 25%, 100% 75%, 50% 100%, 0% 75%, 0% 25%);
  display: flex;
  align-items: center;
  justify-content: center;
}

.logo-text {
  font-size: 2rem;
  font-weight: 700;
  color: #FAFAF8;
  letter-spacing: 0.1em;
}

.logo-particles {
  position: absolute;
  inset: 0;
  pointer-events: none;
}

.particle {
  position: absolute;
  width: 4px;
  height: 4px;
  background: #a47148;
  border-radius: 50%;
  top: 50%;
  left: 50%;
  animation: particleFloat 3s ease-in-out infinite;
}

@keyframes particleFloat {
  0%, 100% {
    opacity: 0;
    transform: translate(-50%, -50%) scale(0);
  }
  50% {
    opacity: 1;
    transform: translate(var(--x, 0), var(--y, 0)) scale(1);
  }
}

/* Animated Title */
.hero-title-wrapper {
  margin-bottom: 1rem;
  overflow: hidden;
}

.hero-title {
  font-size: clamp(2.5rem, 8vw, 4rem);
  font-weight: 700;
  line-height: 1.1;
  margin: 0;
}

.title-word {
  display: inline-block;
  opacity: 0;
  transform: translateY(50px);
  animation: wordReveal 1s cubic-bezier(0.4, 0, 0.2, 1) forwards;
  background: linear-gradient(135deg, #FAFAF8 0%, #a47148 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  margin: 0 0.25rem;
}

@keyframes wordReveal {
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* Animated Subtitle */
.hero-subtitle-wrapper {
  margin-bottom: 3rem;
  overflow: hidden;
}

.hero-subtitle {
  font-size: clamp(1rem, 3vw, 1.25rem);
  font-weight: 300;
  color: #ccc;
  opacity: 0;
  animation: fadeInUp 1s 0.8s cubic-bezier(0.4, 0, 0.2, 1) forwards;
}

@keyframes fadeInUp {
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* CTA Buttons */
.hero-actions {
  display: flex;
  flex-direction: column;
  gap: 1rem;
  margin-bottom: 3rem;
  width: 100%;
  max-width: 300px;
}

.cta-primary {
  position: relative;
  padding: 1.25rem 2rem;
  background: transparent;
  border: 2px solid #a47148;
  color: #FAFAF8;
  font-size: 1rem;
  font-weight: 500;
  text-transform: uppercase;
  letter-spacing: 0.1em;
  border-radius: 50px;
  overflow: hidden;
  cursor: pointer;
  transition: all 0.3s ease;
}

.cta-bg {
  position: absolute;
  inset: 0;
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  transform: translateY(100%);
  transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  z-index: -1;
}

.cta-primary:active .cta-bg {
  transform: translateY(0);
}

.cta-primary:active {
  color: #000;
  transform: scale(0.98);
}

.cta-shine {
  position: absolute;
  top: -50%;
  left: -50%;
  width: 200%;
  height: 200%;
  background: linear-gradient(45deg, transparent, rgba(255,255,255,0.3), transparent);
  transform: rotate(45deg) translateX(-100%);
  transition: transform 0.6s ease;
}

.cta-primary:hover .cta-shine {
  transform: rotate(45deg) translateX(100%);
}

.cta-secondary {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  padding: 1rem 2rem;
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  color: #FAFAF8;
  font-size: 0.875rem;
  font-weight: 500;
  border-radius: 50px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.cta-secondary:active {
  transform: scale(0.95);
  background: rgba(255, 255, 255, 0.15);
}

/* Scroll Indicator */
.scroll-indicator {
  position: absolute;
  bottom: 2rem;
  left: 50%;
  transform: translateX(-50%);
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.5rem;
  cursor: pointer;
  animation: bounce 2s ease-in-out infinite;
}

@keyframes bounce {
  0%, 100% { transform: translateX(-50%) translateY(0); }
  50% { transform: translateX(-50%) translateY(-10px); }
}

.scroll-mouse {
  width: 24px;
  height: 36px;
  border: 2px solid rgba(255, 255, 255, 0.5);
  border-radius: 12px;
  position: relative;
}

.scroll-wheel {
  width: 3px;
  height: 8px;
  background: #a47148;
  border-radius: 2px;
  position: absolute;
  top: 8px;
  left: 50%;
  transform: translateX(-50%);
  animation: scrollWheel 1.5s ease-in-out infinite;
}

@keyframes scrollWheel {
  0% { transform: translateX(-50%) translateY(0); opacity: 1; }
  100% { transform: translateX(-50%) translateY(12px); opacity: 0; }
}

.scroll-text {
  font-size: 0.75rem;
  color: rgba(255, 255, 255, 0.5);
  text-transform: uppercase;
  letter-spacing: 0.1em;
}

/* Floating Elements */
.floating-elements {
  position: absolute;
  inset: 0;
  pointer-events: none;
  overflow: hidden;
}

.floating-element {
  position: absolute;
  color: rgba(164, 113, 72, 0.2);
  font-size: 2rem;
  animation: float 10s ease-in-out infinite;
  top: var(--float-offset);
  left: var(--float-offset);
}

@keyframes float {
  0%, 100% {
    transform: translate(0, 0) rotate(0deg);
  }
  33% {
    transform: translate(30px, -30px) rotate(120deg);
  }
  66% {
    transform: translate(-20px, 20px) rotate(240deg);
  }
}

/* Stats Bar */
.hero-stats {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  display: flex;
  background: rgba(0, 0, 0, 0.8);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border-top: 1px solid rgba(255, 255, 255, 0.1);
  padding: 1.5rem 0;
  z-index: 3;
}

.stat-item {
  flex: 1;
  text-align: center;
  opacity: 0;
  transform: translateY(20px);
  transition: all 0.6s cubic-bezier(0.4, 0, 0.2, 1);
}

.stat-item.visible {
  opacity: 1;
  transform: translateY(0);
}

.stat-number {
  font-size: 1.5rem;
  font-weight: 700;
  color: #a47148;
  margin-bottom: 0.25rem;
}

.stat-label {
  font-size: 0.75rem;
  color: #999;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

/* Responsive */
@media (min-width: 768px) {
  .hero-actions {
    flex-direction: row;
    max-width: 400px;
  }
  
  .hero-title {
    font-size: 3.5rem;
  }
}

/* Performance optimization */
@media (prefers-reduced-motion: reduce) {
  .logo-outer,
  .particle,
  .floating-element,
  .scroll-wheel {
    animation: none;
  }
}
</style>