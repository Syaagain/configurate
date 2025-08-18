<template>
  <div class="mobile-luxury-slider">
    <swiper
      :modules="[Pagination]"
      :direction="'vertical'"
      :slides-per-view="1.1"
      :space-between="20"
      :speed="800"
      :loop="false"
      :pagination="{
        clickable: true,
        el: '.mobile-pagination'
      }"
      :touch-ratio="1"
      :threshold="10"
      :resistance="true"
      :resistance-ratio="0.3"
      :allow-touch-move="true"
      @slideChange="onSlideChange"
      @swiper="onSwiper"
      class="mobile-swiper"
    >
      <swiper-slide v-for="unit in units" :key="unit.id" class="mobile-slide">
        <div class="mobile-unit" @click="$emit('unit-click', unit)">
          <div class="mobile-unit-image-container">
            <img :src="unit.image" :alt="unit.name" class="mobile-unit-image">
            <div class="fade-overlay"></div>
            <h3 class="mobile-unit-title">{{ unit.name }}</h3>
          </div>
          <div class="mobile-unit-content">
            <p class="mobile-unit-description">{{ unit.description }}</p>
            <ul class="mobile-unit-features">
              <li v-for="(feature, idx) in unit.features" :key="idx">
                <span class="material-icons">check_circle</span>
                <span>{{ feature }}</span>
              </li>
            </ul>
            <button class="mobile-unit-btn">
              MEHR ERFAHREN
              <span class="material-icons">arrow_forward</span>
            </button>
          </div>
        </div>
      </swiper-slide>
    </swiper>

    <!-- Only pagination dots, no navigation buttons -->
    <div class="mobile-pagination-container">
      <div class="mobile-pagination"></div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue'
import { Swiper, SwiperSlide } from 'swiper/vue'
import { Pagination } from 'swiper/modules'
import 'swiper/css'
import 'swiper/css/pagination'

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

const emit = defineEmits(['unit-click', 'slider-change'])

const swiperRef = ref(null)
let startTouchY = 0
let canSlide = true // Debounce flag

const onSlideChange = (swiper) => {
  emit('slider-change', swiper)
}

const onSwiper = (swiper) => {
  swiperRef.value = swiper
}

// Expose methods for parent component to control slider
const slideNext = () => {
  if (swiperRef.value) {
    swiperRef.value.slideNext()
  }
}

const slidePrev = () => {
  if (swiperRef.value) {
    swiperRef.value.slidePrev()
  }
}

const slideTo = (index, speed = 300) => {
  if (swiperRef.value) {
    swiperRef.value.slideTo(index, speed)
  }
}

// Expose methods to parent
defineExpose({
  slideNext,
  slidePrev,
  slideTo,
  swiper: swiperRef
})

// Handle touch events for slider navigation
const handleTouchStart = (event) => {
  startTouchY = event.touches[0].clientY
}

const handleTouchMove = (event) => {
  if (!swiperRef.value) return
  const currentTouchY = event.touches[0].clientY
  const deltaY = startTouchY - currentTouchY // Positive = swipe up, Negative = swipe down
  const currentSlide = swiperRef.value.activeIndex
  const isLastSlide = currentSlide === props.units.length - 1
  const isFirstSlide = currentSlide === 0

  console.log('Touch:', { deltaY, currentSlide, totalSlides: props.units.length, isLastSlide })

  // Threshold for slide navigation
  if (Math.abs(deltaY) > 50) {
    // Apply debouncing for smooth navigation
    if (!canSlide) return
    canSlide = false
    setTimeout(() => { canSlide = true }, 500)
    
    // Handle swipe up (positive deltaY)
    if (deltaY > 0) {
      if (isLastSlide && props.nudgeToNextSection) {
        // At last slide, trigger scroll to next section instead of sliding
        console.log('At last slide, triggering nudge to next section')
        props.nudgeToNextSection()
      } else if (currentSlide < props.units.length - 1) {
        // Go to next slide
        console.log('Moving to next slide:', currentSlide + 1)
        swiperRef.value.slideNext()
      }
    }
    
    // Handle swipe down (negative deltaY)
    if (deltaY < 0 && currentSlide > 0) {
      // Go to previous slide
      console.log('Moving to previous slide:', currentSlide - 1)
      swiperRef.value.slidePrev()
    }
  }
}

onMounted(() => {
  const sliderElement = document.querySelector('.mobile-luxury-slider')
  if (sliderElement) {
    sliderElement.addEventListener('touchstart', handleTouchStart, { passive: true })
    sliderElement.addEventListener('touchmove', handleTouchMove, { passive: true })
  }
})

onUnmounted(() => {
  const sliderElement = document.querySelector('.mobile-luxury-slider')
  if (sliderElement) {
    sliderElement.removeEventListener('touchstart', handleTouchStart)
    sliderElement.removeEventListener('touchmove', handleTouchMove)
    
  }
})
</script>

<style scoped>
.mobile-luxury-slider {
  width: 100%;
  height: 60vh;
  margin-top: 2rem;
  position: relative;
  overflow: hidden; /* Hide overflow to create clean preview effect */
}

.mobile-swiper {
  width: 100%;
  height: 100%;
}

.mobile-slide {
  height: auto;
  display: flex;
  align-items: top;
  justify-content: center;
  opacity: 1;
  transition: opacity 0.5s ease-in-out;
}

/* Next slide preview with reduced opacity */
.mobile-slide:not(.swiper-slide-active) {
  opacity: 0.6;
}

.mobile-slide.swiper-slide-active {
  opacity: 1;
}

.mobile-unit {
  width: 100%;
  background: rgba(255, 255, 255, 0.03);
  border-radius: 20px;
  overflow: hidden;
  border: 1px solid rgba(255, 255, 255, 0.1);
  cursor: pointer;
  transition: all 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  transform: translateY(20px);
  opacity: 0.8;
}

/* Active slide animation */
.swiper-slide-active .mobile-unit {
  transform: translateY(0);
  opacity: 1;
}

.mobile-unit:hover {
  transform: translateY(-10px);
  box-shadow: 0 20px 40px rgba(164, 113, 72, 0.3);
}

.mobile-unit-image-container {
  position: relative;
  height: 250px;
  overflow: hidden;
}

.mobile-unit-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.fade-overlay {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  height: 60%;
  background: linear-gradient(to bottom, transparent, rgba(0, 0, 0, 0.9));
  pointer-events: none;
}

.mobile-unit-title {
  position: absolute;
  bottom: 1.5rem;
  left: 1.5rem;
  right: 1.5rem;
  color: #FAFAF8;
  font-size: 1.8rem;
  font-weight: 400;
  z-index: 2;
  margin: 0;
  text-shadow: 0 2px 10px rgba(0, 0, 0, 0.5);
  transform: translateY(30px);
  opacity: 0;
  transition: all 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94) 0.2s;
}

.mobile-unit-content {
  padding: 1.5rem;
  transform: translateY(30px);
  opacity: 0;
  transition: all 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94) 0.4s;
}

/* Active slide content animation */
.swiper-slide-active .mobile-unit-title {
  transform: translateY(0);
  opacity: 1;
}

.swiper-slide-active .mobile-unit-content {
  transform: translateY(0);
  opacity: 1;
}

.mobile-unit-description {
  color: #ccc;
  font-size: 1rem;
  line-height: 1.6;
  margin-bottom: 1.5rem;
}

.mobile-unit-features {
  list-style: none;
  padding: 0;
  margin-bottom: 2rem;
}

.mobile-unit-features li {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  margin-bottom: 0.75rem;
  color: #ccc;
}

.mobile-unit-features .material-icons {
  color: #a47148;
  font-size: 1.25rem;
}

.mobile-unit-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  width: 100%;
  padding: 1rem;
  background: transparent;
  border: 1px solid #a47148;
  color: #a47148;
  font-size: 0.9rem;
  font-weight: 500;
  letter-spacing: 0.1em;
  border-radius: 4px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.mobile-unit-btn:hover {
  background: #a47148;
  color: #000;
}

/* Pagination container */
.mobile-pagination-container {
  position: absolute;
  right: 1rem;
  top: 50%;
  transform: translateY(-50%);
  z-index: 10;
}

.mobile-pagination {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

/* Custom pagination styling */
:deep(.swiper-pagination-bullet) {
  width: 12px;
  height: 12px;
  background: rgba(164, 113, 72, 0.3);
  opacity: 1;
  margin: 6px 0;
  border-radius: 50%;
  transition: all 0.3s ease;
  cursor: pointer;
}

:deep(.swiper-pagination-bullet-active) {
  background: #a47148;
  transform: scale(1.5);
  box-shadow: 0 0 10px rgba(164, 113, 72, 0.5);
}

:deep(.swiper-pagination-bullet:hover) {
  background: rgba(164, 113, 72, 0.6);
  transform: scale(1.2);
}

/* Even smaller screens adjustments */
@media (max-width: 480px) {
  .mobile-luxury-slider {
    height: 60vh;
  }
  
  .mobile-unit-title {
    font-size: 1.5rem;
  }
  
  .mobile-unit-image-container {
    height: 200px;
  }
  
  .mobile-pagination-container {
    right: 0.5rem;
  }
  
  :deep(.swiper-pagination-bullet) {
    width: 10px;
    height: 10px;
    margin: 4px 0;
  }
}
</style>
