<template>
  <div class="luxury-slider">
    <!-- Desktop/Tablet Slider -->
    <div v-show="!isMobile" class="slider-desktop">
      <swiper
        :modules="[Navigation, Parallax]"
        :slides-per-view="'auto'"
        :centered-slides="false"
        :loop="true"
        :speed="2000"
        :parallax="true"
        :space-between="0"
        :navigation="{
          prevEl: '.prev-btn',
          nextEl: '.next-btn'
        }"
        :watch-slides-progress="true"
        class="swiper"
      >
        <swiper-slide v-for="unit in props.units" :key="unit.id" class="swiper-slide">
          <div class="slide-image">
            <img :src="unit.image" :alt="unit.name">
          </div>
          <div class="slide-content">
            <div class="slide-bg"></div>
            <div class="slide-content-inner">
              <h2 class="slide-title">{{ unit.name }}</h2>
              <h3 class="slide-subtitle">{{ unit.description }}</h3>
              <ul class="unit-features">
                <li v-for="feature in unit.features" :key="feature">
                  {{ feature }}
                </li>
              </ul>
              <button class="cta-btn" @click="$emit('unit-click', unit)">
                MEHR ERFAHREN
              </button>
            </div>
          </div>
        </swiper-slide>
      </swiper>

      <div class="nav-wrapper">
        <button class="nav-btn prev-btn">zurück</button>
        <span class="nav-sep"></span>
        <button class="nav-btn next-btn">weiter</button>
      </div>
    </div>

    <!-- Mobile Slider -->
    <MobileLuxurySlider 
      v-show="isMobile" 
      :units="props.units" 
      :scroll-direction="props.scrollDirection"
      :nudge-to-next-section="props.nudgeToNextSection"
      @unit-click="$emit('unit-click', $event)"
      @slider-change="$emit('slider-change', $event)"
    />
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue'
import { Swiper, SwiperSlide } from 'swiper/vue'
import { Navigation, Parallax } from 'swiper/modules'
import MobileLuxurySlider from '~/components/mobile/mobileLuxurySlider.vue'
import 'swiper/css'

const props = defineProps({
  units: {
    type: Array,
    required: true
  },
  scrollDirection: {
    type: String,
    default: 'down'
  },
  nudgeToNextSection: {
    type: Function,
    default: null
  }
})

defineEmits(['unit-click', 'slider-change'])

// Mobile detection - start with false to prevent hydration mismatch
const isMobile = ref(false)

const checkMobile = () => {
  if (process.client) {
    isMobile.value = window.innerWidth <= 768
  }
}

onMounted(() => {
  checkMobile()
  window.addEventListener('resize', checkMobile)
})

onUnmounted(() => {
  if (process.client) {
    window.removeEventListener('resize', checkMobile)
  }
})
</script>

<style scoped>
.luxury-slider {
  position: relative;
  width: 100vw;
  height: 90vh;
  overflow: visible;
  margin-left: calc(-50vw + 50%);
  margin-right: calc(-50vw + 50%);
  margin-top: 120px; /* Increased top margin */
}

.swiper {
  width: 100vw;  /* Changed from 100% to 100vw */
  height: 90vh;
  overflow: visible;
  padding: 0;  /* Removed padding */
}

.swiper-wrapper {
  height: 100%;
}

.swiper-slide {
  width: 80vw;  /* Fixed width for slides */
  height: 90vh;
  display: flex;
  box-sizing: border-box;
  transition: all 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  border-radius: 24px;
  overflow: hidden;
  background: none;
  opacity: 0.4;
  transform-origin: left center;
  margin-right: -25vw; /* Changed to pull slides closer with consistent spacing */
}

/* Full opacity for active slide */
.swiper-slide-active {
  opacity: 1;
  .slide-image {
    transform: scale(1);

  }
}

/* Updated slide-image transitions */
.slide-image {
  flex: 0 0 45%;
  height: 100%;
  overflow: hidden;
  will-change: transform;
  transform-origin: left center;
  transition: transform 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

.slide-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
}

.slide-content {
  flex: 0 0 55%;
  padding: 4rem;
  position: relative;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.slide-bg {
  position: absolute;
  inset: 0;
  background:#000000;
  backdrop-filter: blur(10px);
}

.slide-content-inner {
  position: relative;
  z-index: 1;
  max-width: 600px;
}

.slide-title {
  font-size: 3rem;
  font-weight: 300;
  margin-bottom: 1rem;
  color: #FAFAF8;
  line-height: 1.2;
}

.slide-subtitle {
  font-size: 1.5rem;
  font-weight: 300;
  margin-bottom: 1.5rem;
  color: #a47148;
}

.slide-description {
  font-size: 1.1rem;
  line-height: 1.6;
  color: #ccc;
  margin-bottom: 2rem;
  max-width: 500px;
}

.nav-wrapper {
  position: absolute;
  bottom: 56px;
  left: calc(40vw + 4vw + 2vw);
  display: flex;
  align-items: center;
  z-index: 10;
}

.nav-btn {
  font-family: 'Inter', sans-serif;
  font-size: 17px;
  font-weight: 400;
  background: transparent;
  border: none;
  color: #e3e3e3;
  cursor: pointer;
  text-transform: none;
  padding: 0;
  margin: 0 30px 0 0;
  transition: color 0.3s;
}

.nav-btn:last-child {
  margin: 0 0 0 30px;
}

.nav-sep {
  width: 56px;
  height: 1px;
  background: #e3e3e3;
  opacity: 0.82;
  margin: 0;
  border-radius: 1px;
  display: inline-block;
}

/* Hide previous slides */
.swiper-slide-prev,
.swiper-slide-duplicate-prev {
  opacity: 0;
  visibility: hidden;
  pointer-events: none;
}

@media (max-width: 900px) {
  .swiper-slide {
    width: 93vw;
    margin-right: -30vw; /* Adjusted for mobile */
    height: 70vh;
  }

  .swiper-slide-next {
    transform: translateX(30vw); /* Matched to mobile margin */
  }

  .slide-content {
    padding: 2rem;
  }

  .slide-title {
    font-size: 2rem;
  }

  .slide-subtitle {
    font-size: 1.25rem;
  }

  .slide-description {
    font-size: 1rem;
  }

  .nav-wrapper {
    left: 50%;
    transform: translateX(-50%);
  }
}

/* Additional styles for loop effect */
.swiper-slide-next .slide-image,
.swiper-slide-duplicate-next .slide-image {
  transform: scale(0.33);
}

/* Next slide styling - combined effects */
.swiper-slide-next {
  opacity: 0.3;
  position: relative;
  transform: translateX(25vw); /* Changed to match margin-right offset */
  .slide-image {
    transform: scale(0.33); 
  }
}

/* Mobile specific styles for the main container */
@media (max-width: 768px) {
  .luxury-slider {
    height: 60vh;
    margin-top: 2rem; /* Reduced from 120px to 2rem for mobile */
  }
}
</style>

<style>
h3 {
  font-size: 1.4rem;
  font-weight: 300;
  margin-bottom: 1.5rem;
  color: #999;
}

.unit-features {
  list-style: none;
  padding: 0;
  margin-bottom: 2rem;
}

.unit-features li {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  padding: 0.5rem 0;
  color: #ccc;
}

.unit-features li .material-icons {
  color: #a47148;
}

.cta-btn {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  padding: 1rem 2rem;
  background: transparent;
  border: 1px solid #FAFAF8;
  color: #FAFAF8;
  font-size: 0.95rem;
  letter-spacing: 0.05em;
  cursor: pointer;
  transition: all 0.3s ease;
  border-radius: 4px;
}

.cta-btn:hover {
  background: #FAFAF8;
  color: #000;
  transform: translateY(-8px);
}

.nav-wrapper {
  position: absolute;
  bottom: 56px;
  left: calc(40vw + 4vw + 2vw);
  display: flex;
  align-items: center;
  z-index: 10;
}

.nav-btn {
  font-family: 'Inter', sans-serif;
  font-size: 17px;
  font-weight: 400;
  background: transparent;
  border: none;
  color: #e3e3e3;
  cursor: pointer;
  text-transform: none;
  padding: 0;
  margin: 0 30px 0 0;
  transition: color 0.3s;
}

.nav-btn:last-child {
  margin: 0 0 0 30px;
}

.nav-sep {
  width: 56px;
  height: 1px;
  background: #e3e3e3;
  opacity: 0.82;
  margin: 0;
  border-radius: 1px;
  display: inline-block;
}

@media (max-width: 900px) {
  .swiper-slide {
    width: 93vw;
    margin-right: -30vw; /* Adjusted for mobile */
    height: 70vh;
  }

  .slide-content {
    padding: 0 2vw;
  }

  .nav-wrapper {
    left: 50%;
    transform: translateX(-50%);
  }
}
</style>

