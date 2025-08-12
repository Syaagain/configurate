<template>
  <section id="luxus-slider" class="parallax-slider-section">
    <div class="section-header">
      <h2 class="section-title">UNSERE KOMPETENZEN</h2>
      <p class="section-subtitle">Entdecken Sie unsere vielfältigen Leistungsbereiche</p>
    </div>
    
    <div class="swiper" ref="swiperContainer">
      <div class="swiper-wrapper">
        <!-- SLIDE 1 -->
        <div class="swiper-slide">
          <div class="slide-image">
            <img src="https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png" 
                 alt="Exclusive Galabau" 
                 loading="lazy">
          </div>
          <div class="slide-content">
            <div class="slide-bg"></div>
            <div class="slide-content-inner">
              <h2>EXCLUSIVE GALABAU</h2>
              <h3>Garten- & Landschaftsbau</h3>
              <p>Von Naturstein über Planung bis zur Ausführung – Außenbereiche in Perfektion.</p>
            </div>
          </div>
        </div>
        
        <!-- SLIDE 2 -->
        <div class="swiper-slide">
          <div class="slide-image">
            <img src="https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png" 
                 alt="Premium Fliesen Design" 
                 loading="lazy">
          </div>
          <div class="slide-content">
            <div class="slide-bg"></div>
            <div class="slide-content-inner">
              <h2>PREMIUM FLIESEN DESIGN</h2>
              <h3>Verlegung auf höchstem Niveau</h3>
              <p>Edle Materialien, präzise Verlegung – für Böden, Bäder und Wände mit Stil.</p>
            </div>
          </div>
        </div>
        
        <!-- SLIDE 3 -->
        <div class="swiper-slide">
          <div class="slide-image">
            <img src="https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686576cf622e38e88f0236c5.png" 
                 alt="Exklusive Bädermanufaktur" 
                 loading="lazy">
          </div>
          <div class="slide-content">
            <div class="slide-bg"></div>
            <div class="slide-content-inner">
              <h2>EXKLUSIVE BÄDERMANUFAKTUR</h2>
              <h3>Individuelle Badträume, meisterhaft realisiert</h3>
              <p>Maßgeschneiderte Bäder mit höchsten Ansprüchen an Design und Funktion – für ein unvergleichliches Wohlfühlerlebnis.</p>
             </div>
          </div>
        </div>
        
        <!-- SLIDE 4 -->
        <div class="swiper-slide">
          <div class="slide-image">
            <img src="https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b70b0803723582ed6.png" 
                 alt="Exklusive Terrassenplatten" 
                 loading="lazy">
          </div>
          <div class="slide-content">
            <div class="slide-bg"></div>
            <div class="slide-content-inner">
              <h2>EXKLUSIVE TERRASSENPLATTEN</h2>
              <h3>Innovative Lösungen für stilvolle Außenbereiche</h3>
              <p>Langlebige Terrassenplatten in höchster Qualität – robust, elegant und individuell nach Ihren Wünschen gestaltet.</p>
            </div>
          </div>
        </div>
        
        <!-- SLIDE 5 -->
        <div class="swiper-slide">
          <div class="slide-image">
            <img src="https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b097a8069ca3ac95a.png" 
                 alt="Architektur Group Europe" 
                 loading="lazy">
          </div>
          <div class="slide-content">
            <div class="slide-bg"></div>
            <div class="slide-content-inner">
              <h2>ARCHITEKTUR GROUP EUROPE</h2>
              <h3>Spezialisiert auf Frankreich & Schweiz</h3>
              <p>Höchste Expertise und ein europaweites Netzwerk – perfekt zugeschnitten auf exklusive Projekte in Frankreich und der Schweiz.</p>
              <NuxtLink to="/europe" class="cta-btn">MEHR ERFAHREN</NuxtLink>
            </div>
          </div>
        </div>
      </div>
      
      <!-- Navigation -->
      <div class="nav-wrapper">
        <button class="nav-btn prev-btn" @click="slidePrev">zurück</button>
        <span class="nav-sep"></span>
        <button class="nav-btn next-btn" @click="slideNext">weiter</button>
      </div>
    </div>
  </section>
</template>

<script setup>
import { onMounted, onUnmounted, ref } from 'vue'

const swiperContainer = ref(null)
let swiperInstance = null

const slidePrev = () => {
  if (swiperInstance) {
    // Direkt zum vorherigen Slide ohne Swipe-Einschränkungen
    swiperInstance.slidePrev(800) // 800ms Geschwindigkeit für smooth transition
  }
}

const slideNext = () => {
  if (swiperInstance) {
    // Direkt zum nächsten Slide ohne Swipe-Einschränkungen
    swiperInstance.slideNext(800) // 800ms Geschwindigkeit für smooth transition
  }
}

onMounted(async () => {
  // Dynamically import Swiper
  const { default: Swiper } = await import('swiper')
  const { Navigation } = await import('swiper/modules')
  
  // Import Swiper styles
  await import('swiper/css')
  await import('swiper/css/navigation')
  
  // Initialize Swiper
  swiperInstance = new Swiper(swiperContainer.value, {
    modules: [Navigation],
    slidesPerView: 1,
    centeredSlides: true,
    loop: false,
    speed: 800,
    spaceBetween: 0,
    
    // Optimierte Touch/Swipe Einstellungen für responsiveres Verhalten
    threshold: 20,          // Minimaler Swipe-Abstand (Standard: 50px)
    shortSwipes: true,      // Kurze Swipes erlauben
    longSwipes: true,       // Lange Swipes erlauben
    longSwipesRatio: 0.2,   // Verhältnis für lange Swipes (Standard: 0.5)
    longSwipesMs: 200,      // Zeit für lange Swipes (Standard: 300ms)
    followFinger: true,     // Slider folgt dem Finger
    
    // Touch-spezifische Einstellungen
    touchRatio: 1,          // Touch-Verhältnis
    touchAngle: 45,         // Touch-Winkel
    simulateTouch: true,    // Simuliert Touch für Desktop
    allowTouchMove: true,   // Touch-Bewegung erlauben
    touchMoveStopPropagation: false,
    
    // Resistance für besseres Gefühl an den Rändern
    resistance: true,
    resistanceRatio: 0.85,
    
    // NAVIGATION ENTFERNT - wir verwenden nur Custom-Handler
    // navigation: {
    //   prevEl: '.prev-btn',
    //   nextEl: '.next-btn',
    //   disabledClass: 'swiper-button-disabled',
    // },
    
    // Zusätzliche Einstellungen für optimale Navigation
    preventClicks: false,
    preventClicksPropagation: false,
    slideToClickedSlide: false,
    
    grabCursor: true,
    watchSlidesProgress: true,
    
    // Responsive Breakpoints mit angepassten Touch-Einstellungen
    breakpoints: {
      320: {
        slidesPerView: 1,
        spaceBetween: 0,
        threshold: 15,        // Noch empfindlicher auf kleinen Bildschirmen
        longSwipesRatio: 0.15,
      },
      768: {
        slidesPerView: 1,
        spaceBetween: 0,
        threshold: 20,
        longSwipesRatio: 0.2,
      },
      1024: {
        slidesPerView: 1,
        spaceBetween: 0,
        threshold: 25,
        longSwipesRatio: 0.25,
      }
    }
  })
})

onUnmounted(() => {
  if (swiperInstance) {
    swiperInstance.destroy(true, true)
  }
})
</script>

<style scoped>
.parallax-slider-section {
  position: relative;
  width: 100%;
  background: #101015;
  padding: 80px 0 40px;
  overflow: hidden;
}

.section-header {
  text-align: center;
  margin-bottom: 60px;
  padding: 0 20px;
}

.section-title {
  font-size: 3rem;
  font-weight: 300;
  color: #FAFAF8;
  margin-bottom: 1rem;
  letter-spacing: 0.05em;
}

.section-subtitle {
  font-size: 1.25rem;
  color: #999;
  font-weight: 300;
}

#luxus-slider {
  position: relative;
  width: 100vw;
  margin-left: calc(-50vw + 50%);
  overflow: hidden;
}

.swiper {
  width: 100vw;
  height: 80vh;
  min-height: 600px;
  overflow: hidden;
  padding: 0 10vw;
}

.swiper-wrapper {
  height: 100%;
  align-items: center;
}

.swiper-slide {
  width: 100%;
  max-width: 1200px;
  height: 70vh;
  min-height: 500px;
  display: flex;
  box-sizing: border-box;
  transition: all 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  border-radius: 24px;
  overflow: hidden;
  background: #181820;
  box-shadow: 0 10px 40px rgba(0, 0, 0, 0.4);
}

.swiper-slide-active {
  transform: scale(1);
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.6);
}

.swiper-slide-next,
.swiper-slide-prev {
  transform: scale(0.9);
  opacity: 0.7;
}

.slide-image {
  flex: 0 0 45%;
  height: 100%;
  overflow: hidden;
  position: relative;
}

.slide-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
  transition: transform 1.5s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

.swiper-slide-active .slide-image img {
  transform: scale(1.1);
}

.slide-content {
  flex: 0 0 55%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  padding: 0 4vw;
  position: relative;
  overflow: hidden;
  background: linear-gradient(135deg, #1a1a1a 0%, #0a0a0a 100%);
}

.slide-bg {
  position: absolute;
  inset: 0;
  z-index: 0;
  background: linear-gradient(135deg, rgba(164, 113, 72, 0.1) 0%, transparent 100%);
  pointer-events: none;
}

.slide-content-inner {
  position: relative;
  z-index: 1;
  padding: 2vw;
}

.slide-content h2 {
  font-size: 2.5rem;
  font-weight: 600;
  margin: 0 0 0.5rem;
  color: #FAFAF8;
  letter-spacing: 0.02em;
}

.slide-content h3 {
  font-size: 1.5rem;
  font-weight: 300;
  margin: 0 0 1rem;
  color: #a47148;
  opacity: 0.9;
}

.slide-content p {
  font-size: 1.125rem;
  line-height: 1.6;
  font-weight: 300;
  margin: 0 0 2rem;
  max-width: 40ch;
  color: #ccc;
}

.cta-btn {
  display: inline-block;
  padding: 12px 32px;
  font-size: 14px;
  font-weight: 500;
  letter-spacing: 0.1em;
  border: 2px solid #FAFAF8;
  border-radius: 4px;
  background: transparent;
  color: #FAFAF8;
  text-transform: uppercase;
  text-decoration: none;
  transition: all 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  position: relative;
  overflow: hidden;
}

.cta-btn::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: #FAFAF8;
  transition: left 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  z-index: -1;
}

.cta-btn:hover {
  color: #000;
  transform: translateY(-2px);
  box-shadow: 0 10px 20px rgba(164, 113, 72, 0.3);
}

.cta-btn:hover::before {
  left: 0;
}

.nav-wrapper {
  position: absolute;
  bottom: 40px;
  left: 50%;
  transform: translateX(-50%);
  display: flex;
  align-items: center;
  z-index: 10;
  gap: 20px;
}

.nav-btn {
  font-family: 'Inter', sans-serif;
  font-size: 16px;
  font-weight: 400;
  background: transparent;
  border: none;
  color: #FAFAF8;
  cursor: pointer;
  text-transform: none;
  padding: 8px 16px;
  transition: all 0.3s;
  outline: none;
  position: relative;
}

.nav-btn::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 50%;
  width: 0;
  height: 2px;
  background: #a47148;
  transform: translateX(-50%);
  transition: width 0.3s;
}

.nav-btn:hover {
  color: #a47148;
}

.nav-btn:hover::after {
  width: 100%;
}

.nav-sep {
  width: 60px;
  height: 1px;
  background: linear-gradient(90deg, transparent, #FAFAF8, transparent);
  opacity: 0.5;
}

/* Responsive */
@media (max-width: 1024px) {
  .swiper {
    padding: 0 7.5vw;
  }
  
  .slide-content h2 {
    font-size: 2rem;
  }
  
  .slide-content h3 {
    font-size: 1.25rem;
  }
}

@media (max-width: 768px) {
  .parallax-slider-section {
    padding: 60px 0 20px;
  }
  
  .section-title {
    font-size: 2rem;
  }
  
  .section-subtitle {
    font-size: 1rem;
  }
  
  .swiper {
    height: auto;
    min-height: unset;
    padding: 0 5vw;
  }
  
  .swiper-slide {
    height: 60vh;
    min-height: 400px;
    flex-direction: column;
  }
  
  .slide-image,
  .slide-content {
    flex: none;
    width: 100%;
  }
  
  .slide-image {
    height: 50%;
  }
  
  .slide-content {
    height: 50%;
    padding: 20px;
  }
  
  .slide-content h2 {
    font-size: 1.5rem;
  }
  
  .slide-content h3 {
    font-size: 1.125rem;
    margin-bottom: 0.5rem;
  }
  
  .slide-content p {
    font-size: 1rem;
    margin-bottom: 1.5rem;
  }
  
  .cta-btn {
    padding: 10px 24px;
    font-size: 12px;
  }
  
  .nav-wrapper {
    bottom: 20px;
    gap: 10px;
  }
  
  .nav-btn {
    font-size: 14px;
    padding: 6px 12px;
  }
  
  .nav-sep {
    width: 40px;
  }
}

@media (max-width: 480px) {
  .swiper {
    padding: 0 2.5vw;
  }
  
  .swiper-slide {
    height: 70vh;
    min-height: 350px;
  }
  
  .slide-content-inner {
    padding: 1rem;
  }
  
  .slide-content h2 {
    font-size: 1.25rem;
  }
  
  .slide-content h3 {
    font-size: 1rem;
  }
  
  .slide-content p {
    font-size: 0.875rem;
    margin-bottom: 1rem;
  }
}
</style>