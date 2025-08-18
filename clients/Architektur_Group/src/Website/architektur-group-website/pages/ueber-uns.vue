<template>
  <div class="about-page">
    <!-- Hero Section -->
    <section class="hero" id="hero">
      <div class="hero-bg" ref="heroBg">
        <img src="https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png" alt="Hero Background">
        <div class="hero-overlay"></div>
      </div>
      <div class="hero-content" ref="heroContent">
        <div class="title-container">
          <h1 class="hero-title">ÜBER UNS</h1>
        </div>
        <div class="hero-badge animate-fade-in">SEIT 1957</div>
      </div>
      <div class="hero-subheading" ref="heroSubheading">
        <p>Europas exklusivste Auswahl an Premium Natursteinen und Design-Verlegung</p>
      </div>
      <div class="scroll-indicator" @click="scrollToContent">
        <span class="material-icons">expand_more</span>
      </div>
    </section>

    <!-- Company Story Section -->
    <section class="story-section" ref="storySection">
      <div class="container">
        <div class="story-grid">
          <div class="story-content">
            <span class="hero-badge animate-on-scroll">UNSERE GESCHICHTE</span>
            <h2 class="section-title story-title animate-on-scroll-delayed">
              <span class="gradient-text title-line-1" data-text="3 GENERATIONEN">3 GENERATIONEN</span>
              <span class="title-line-2" data-text="HANDWERKSKUNST">HANDWERKSKUNST</span>
            </h2>
            <p class="story-text animate-on-scroll-delayed">
              Die Architektur Group, als langjährig familiengeführte Marke und Unternehmensgruppe, 
              repräsentiert Europas exklusivste Auswahl an Wand- und Bodenbelägen, Treppen, 
              Waschtischen und vielem mehr aus hochwertigen Natursteinen wie Edelmarmor, 
              Onyx sowie Keramik / High-Tech Feinsteinzeug und großformatigen Platten.
            </p>
            <p class="story-text">
              Durch die zur Unternehmensgruppe zugehörige Premium Fliesen Design GmbH als 
              Meister-Fachbetrieb seit 1957 in 3. Generation werden ebenfalls die fachgerechte 
              Design-Verlegung für Boden- und Wandbeläge im Innen- und Außenbereich in 
              durchgehend fugenloser Optik angeboten.
            </p>
            
            <!-- Timeline -->
            <div class="timeline">
              <div class="timeline-line">
                <div class="timeline-progress" :style="{ height: `${timelineProgress}%` }"></div>
              </div>
              <div 
                v-for="(item, index) in timeline" 
                :key="index"
                class="timeline-step"
                :class="{ active: visibleTimeline.includes(index) }"
                :data-index="index"
              >
                <div class="step-marker">
                  <div class="timeline-dot"></div>
                  <div class="marker-pulse"></div>
                </div>
                <div class="timeline-content">
                  <div class="timeline-year">{{ item.year }}</div>
                  <h4>{{ item.title }}</h4>
                  <p>{{ item.description }}</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Business Units Section -->
    <section class="units-section" ref="unitsSection" :class="{ 'nudge-out': isNudging }">
      <div class="container">
        <div class="section-header">
          <span class="hero-badge animate-on-scroll">UNTERNEHMENSGRUPPE</span>
          <h2 class="section-title animate-on-scroll-delayed" data-text="ALLES AUS EINER HAND">ALLES AUS EINER HAND</h2>
          <p class="section-subtitle animate-on-scroll-delayed">
            Unser Leistungsangebot für Neubauten und Generalsanierungen
          </p>
        </div>
        
        <ClientOnly>
          <LuxurySlider 
            ref="luxurySliderRef"
            :units="businessUnits"
            :scroll-direction="scrollDirection"
            :nudge-to-next-section="nudgeToNextSection"
            @unit-click="openUnitModal"
          />
          <template #fallback>
            <div class="slider-loading">
              <div class="loading-spinner"></div>
              <p>Lade Inhalte...</p>
            </div>
          </template>
        </ClientOnly>
      </div>
    </section>

    <!-- Interactive Locations Map -->
    <section class="locations-section" ref="locationsSection" :class="{ 'nudge-in': isNudging }">
      <div class="container">
        <div class="section-header">
          <span class="hero-badge location-text-1" :class="{ 'fade-in-individually': isNudging }">INTERNATIONAL</span>
          <h2 class="section-title location-text-2" :class="{ 'fade-in-individually': isNudging }" data-text="UNSERE STANDORTE">UNSERE STANDORTE</h2>
          <p class="section-subtitle location-text-3" :class="{ 'fade-in-individually': isNudging }">Präsenz in ganz Europa für beste Erreichbarkeit</p>
        </div>
        
        <div class="map-container location-text-4" :class="{ 'fade-in-individually': isNudging }">
          <ClientOnly>
            <!-- Desktop Map -->
            <LocationsMap v-if="!isMobile" />
            <!-- Mobile Map -->
            <MobileInteractiveMap v-else />
            <template #fallback>
              <div class="map-loading">
                <div class="loading-spinner"></div>
                <p>Lade Karte...</p>
              </div>
            </template>
          </ClientOnly>
        </div>
      </div>
    </section>

    <!-- Team Section -->
    <section class="team-section">
      <div class="container">
        <div class="section-header">
          <span class="hero-badge animate-on-scroll">UNSER TEAM</span>
          <h2 class="section-title animate-on-scroll-delayed" data-text="EXPERTEN MIT LEIDENSCHAFT">EXPERTEN MIT LEIDENSCHAFT</h2>
          <p class="section-subtitle animate-on-scroll-delayed">
            Speziell geschulte Innenarchitekten und Designer stehen Ihnen zur Seite
          </p>
        </div>
        
        <div class="team-showcase animate-on-scroll-slow">
          <div class="showcase-main">
            <div class="main-image animate-on-scroll">
              <img src="https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686576cf622e38e88f0236c5.png" alt="Team">
              <div class="image-overlay"></div>
            </div>
            <div class="main-content animate-on-scroll-delayed">
              <h3>Gemeinsam für Ihre Vision</h3>
              <p>
                Unser Team aus erfahrenen Handwerkern, Designern und Beratern arbeitet 
                Hand in Hand, um Ihre Wohnträume zu verwirklichen. Mit über 67 Jahren 
                Erfahrung und der Expertise aus drei Generationen.
              </p>
              <div class="team-stats">
                <div class="stat">
                  <span class="stat-number">50+</span>
                  <span class="stat-label">Mitarbeiter</span>
                </div>
                <div class="stat">
                  <span class="stat-number">15</span>
                  <span class="stat-label">Designer</span>
                </div>
                <div class="stat">
                  <span class="stat-number">30+</span>
                  <span class="stat-label">Handwerker</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- CTA Section -->
    <section class="cta-section">
      <div class="cta-background">
        <div class="animated-gradient"></div>
      </div>
      <div class="container">
        <div class="cta-content">
          <h2 class="cta-title">
            BEREIT FÜR IHR <br> TRAUMPROJEKT?
          </h2>
          <p class="cta-subtitle">
            Lassen Sie uns gemeinsam Ihre Vision verwirklichen
          </p>
          <div class="cta-buttons">
            <NuxtLink to="/kontakt" class="cta-btn primary">
              BERATUNG VEREINBAREN
              <span class="material-icons">arrow_forward</span>
            </NuxtLink>
            <NuxtLink to="/sortiment" class="cta-btn secondary">
              SORTIMENT ENTDECKEN
              <span class="material-icons">visibility</span>
            </NuxtLink>
          </div>
          
          <!-- Contact Quick Info -->
          <div class="quick-contact">
            <div class="contact-item">
              <span class="material-icons">phone</span>
              <span>+49 8171 / 3868770</span>
            </div>
            <div class="contact-item">
              <span class="material-icons">email</span>
              <span>kontakt@group-ag.de</span>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Modals -->
    <transition name="modal">
      <div v-if="showUnitModal" class="modal-overlay" @click="closeModals">
        <div class="modal-content" @click.stop>
          <button class="modal-close" @click="closeModals">
            <span class="material-icons">close</span>
          </button>
          
          <!-- Image Carousel - Full Width at Top -->
          <div class="modal-carousel" v-if="selectedUnit">
            <div class="carousel-container">
              <div 
                class="carousel-track"
                :style="{ transform: `translateX(-${currentCarouselIndex * 100}%)` }"
              >
                <div 
                  v-for="(image, index) in selectedUnit.carouselImages" 
                  :key="index"
                  class="carousel-slide"
                >
                  <img :src="image" :alt="`${selectedUnit.name} Image ${index + 1}`">
                </div>
              </div>
              
              <!-- Carousel Indicators -->
              <div class="carousel-indicators">
                <button 
                  v-for="(image, index) in selectedUnit.carouselImages" 
                  :key="index"
                  :class="['carousel-dot', { active: currentCarouselIndex === index }]"
                  @click="goToCarouselSlide(index)"
                ></button>
              </div>
            </div>
          </div>
          
          <div class="modal-body" v-if="selectedUnit">
            <div class="modal-header">
              <p class="modal-subtitle">{{ selectedUnit.description }}</p>
            </div>
            
            <!-- Full Description -->
            <div class="modal-description">
              <h3>Über diesen Service</h3>
              <p>{{ selectedUnit.fullDescription }}</p>
            </div>
            
            <div class="modal-features">
              <h3>Unsere Leistungen im Detail</h3>
              <div class="features-grid">
                <div v-for="feature in selectedUnit.features" :key="feature" class="feature-card">
                  <span class="material-icons">done</span>
                  <p>{{ feature }}</p>
                </div>
              </div>
            </div>
            
            <div class="modal-cta">
              <div class="cta-highlight">
                <h3>Interessiert an unserem {{ selectedUnit.name }} Service?</h3>
                <p>Lassen Sie uns gemeinsam Ihr Projekt realisieren</p>
              </div>
              <div class="modal-buttons">
                <NuxtLink to="/kontakt" class="modal-btn primary">
                  <span class="btn-icon material-icons">phone</span>
                  BERATUNG ANFRAGEN
                  <span class="material-icons">arrow_forward</span>
                </NuxtLink>
                <button @click="closeModals" class="modal-btn secondary">
                  SCHLIESSEN
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </transition>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, onUnmounted, computed } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import LuxurySlider from '~/components/website/LuxurySlider.vue'
import LocationsMap from '~/components/website/locationsMap.vue'
import MobileInteractiveMap from '~/components/mobile/mobileInteractiveMap.vue'

// Fix imports and page meta
definePageMeta({
  layout: 'default'
})

const router = useRouter()
const route = useRoute()

// State refs
const scrollY = ref(0)
const selectedLocation = ref(null)
const visibleTimeline = ref([])
const showUnitModal = ref(false)
const selectedUnit = ref(null)
const scrollDirection = ref('down') // Track scroll direction ('up' or 'down')
const currentSlideIndex = ref(0)
const totalSlides = ref(4) // Based on businessUnits length
const isMobile = ref(false)
const isNudging = ref(false) // New state for nudge animation
const isSmoothScrolling = ref(false) // State for smooth scroll animation

// Carousel state
const currentCarouselIndex = ref(0)
let carouselInterval = null

// Intersection Observer für Scroll-Animationen
let scrollAnimationObserver = null

// Refs for parallax
const heroBg = ref(null)
const heroContent = ref(null)
const heroSubheading = ref(null)
const luxurySliderRef = ref(null)
const unitsSection = ref(null)
const locationsSection = ref(null)
const ticking = ref(false)

// Timeline Data
const timeline = [
  {
    year: '1957',
    title: 'Gründung',
    description: 'Meister-Fachbetrieb Premium Fliesen Design GmbH gegründet'
  },
  {
    year: '1990',
    title: 'Expansion',
    description: 'Erweiterung um Natursteinhandel und europaweite Lieferung'
  },
  {
    year: '2010',
    title: 'Innovation',
    description: 'Einführung der patentierten High-Tech Fuge'
  },
  {
    year: '2020',
    title: 'Galabau',
    description: 'Gründung der Exclusive Galabau für Außengestaltung'
  },
  {
    year: 'Heute',
    title: '3. Generation',
    description: 'Über 2500 Natursteinsorten und vollumfängliche Handwerksleistungen'
  }
]

// Business Units
const businessUnits = [
  {
    id: 1,
    name: 'Premium Fliesen Design',
    icon: 'layers',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686576cf622e38e88f0236c5.png',
    description: 'Meister-Fachbetrieb seit 1957 in 3. Generation',
    fullDescription: 'Als Meister-Fachbetrieb mit über 65 Jahren Erfahrung führen wir Premium-Verlegungen von Natursteinen, Keramik und High-Tech Feinsteinzeug aus. Unsere Spezialität liegt in der fugenlosen Design-Verlegung, die höchste handwerkliche Präzision erfordert. Von exklusiven Edelmarmor-Böden bis hin zu großformatigen Wandverkleidungen – wir setzen Ihre Visionen mit perfekter Ausführung um.',
    carouselImages: [
      'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=800&q=80',
      'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=800&q=80',
      'https://images.unsplash.com/photo-1615873968403-89e068629265?w=800&q=80',
      'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=800&q=80'
    ],
    features: [
      'Fugenlose Design-Verlegung',
      'Innen- und Außenbereich',
      'Europaweite Montage'
    ]
  },
  {
    id: 2,
    name: 'Exclusive Bädermanufaktur',
    icon: 'bathtub',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png',
    description: 'Vollumfängliche Badezimmergestaltungen',
    fullDescription: 'Unsere Bädermanufaktur erschafft Wellnessoasen der Extraklasse. Von luxuriösen Walk-In Duschen mit rahmenloser Verglasung bis hin zu maßgefertigten Waschtischen aus edelstem Naturstein. Jedes Badezimmer wird individuell geplant und mit höchster Präzision ausgeführt. Wir kombinieren moderne Technik mit zeitlosem Design für ultimativen Komfort.',
    carouselImages: [
      'https://images.unsplash.com/photo-1552321554-5fefe8c9ef14?w=800&q=80',
      'https://images.unsplash.com/photo-1631889993959-41b4e9c6e3c5?w=800&q=80',
      'https://images.unsplash.com/photo-1620626011761-996317b8d101?w=800&q=80',
      'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?w=800&q=80'
    ],
    features: [
      'Walk-In Duschen',
      'Waschtischgestaltungen',
      'General-Sanierungen'
    ]
  },
  {
    id: 3,
    name: 'Exclusive Galabau',
    icon: 'park',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b70b0803723582ed6.png',
    description: 'Garten- und Landschaftsbau der Extraklasse',
    fullDescription: 'Unser Galabau-Team verwandelt Außenbereiche in exklusive Wohlfühlräume. Von eleganten Terrassenanlagen mit Natursteinbelägen über maßgeschneiderte Poollandschaften bis hin zu kompletter Gartenarchitektur. Wir schaffen harmonische Übergänge zwischen Innen- und Außenraum und setzen dabei auf nachhaltige, hochwertige Materialien und durchdachte Gestaltungskonzepte.',
    carouselImages: [
      'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800&q=80',
      'https://images.unsplash.com/photo-1544373345-2516e8570bb4?w=800&q=80',
      'https://images.unsplash.com/photo-1553799933-4fa3d6f715c1?w=800&q=80',
      'https://images.unsplash.com/photo-1566493896773-91918dd40065?w=800&q=80'
    ],
    features: [
      'Terrassengestaltung',
      'Poolbau',
      'Gartenarchitektur'
    ]
  },
  {
    id: 4,
    name: 'Architektur Services',
    icon: 'architecture',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png',
    description: 'Komplettservice aus einer Hand',
    fullDescription: 'Als ganzheitlicher Architektur-Service begleiten wir Sie von der ersten Idee bis zur schlüsselfertigen Übergabe. Unser erfahrenes Team aus Architekten, Ingenieuren und Projektleitern sorgt für reibungslose Abläufe und höchste Qualitätsstandards. Ob Neubau oder Renovierung – wir koordinieren alle Gewerke und garantieren termingerechte, budgetkonforme Umsetzung.',
    carouselImages: [
      'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=800&q=80',
      'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=800&q=80',
      'https://images.unsplash.com/photo-1512918728675-ed5a9ecdebfd?w=800&q=80',
      'https://images.unsplash.com/photo-1582063289852-62e3ba2747f8?w=800&q=80'
    ],
    features: [
      'Projektleitung',
      'Innenarchitektur',
      'Schlüsselfertige Übergabe'
    ]
  }
]

// Carousel functions
const startCarousel = () => {
  if (carouselInterval) clearInterval(carouselInterval)
  carouselInterval = setInterval(() => {
    if (selectedUnit.value && selectedUnit.value.carouselImages) {
      currentCarouselIndex.value = (currentCarouselIndex.value + 1) % selectedUnit.value.carouselImages.length
    }
  }, 3000) // Change image every 3 seconds
}

const stopCarousel = () => {
  if (carouselInterval) {
    clearInterval(carouselInterval)
    carouselInterval = null
  }
}

const goToCarouselSlide = (index) => {
  currentCarouselIndex.value = index
}

// Methods
const openUnitModal = (unit) => {
  selectedUnit.value = unit
  currentCarouselIndex.value = 0
  showUnitModal.value = true
  if (process.client) {
    document.body.style.overflow = 'hidden'
  }
  startCarousel()
}

const closeModals = () => {
  stopCarousel()
  showUnitModal.value = false
  selectedUnit.value = null
  if (process.client) {
    document.body.style.overflow = 'auto'
  }
}

const scrollToContent = () => {
  const storySection = document.querySelector('.story-section')
  if (storySection) {
    storySection.scrollIntoView({ behavior: 'smooth' })
  }
}

// Mobile detection function
const checkMobile = () => {
  if (process.client) {
    isMobile.value = window.innerWidth <= 768
  }
}

// Specific transition from locations-section to units-section
const transitionToUnitsSection = () => {
  console.log('LOCATIONS → UNITS TRANSITION - Starting fade transition')
  
  // Get both sections
  const unitsSection = document.querySelector('.units-section')
  const locationsSection = document.querySelector('.locations-section')
  
  if (!unitsSection || !locationsSection) return
  
  // Get hero badges
  const unitsBadge = unitsSection.querySelector('.hero-badge')
  const locationsBadge = locationsSection.querySelector('.hero-badge')
  
  if (!unitsBadge || !locationsBadge) return
  
  console.log('Transitioning from locations to units section')
  
  // Start fade transition
  isNudging.value = true
  
  // Prepare units section for fade-in from top
  unitsSection.style.transition = ''
  unitsSection.style.opacity = '0'
  unitsSection.style.transform = 'translateY(-60px)'
  
  // Apply fade-out to locations section - fade down and out (faster)
  locationsSection.style.transition = 'all 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94)'
  locationsSection.style.opacity = '0'
  locationsSection.style.transform = 'translateY(60px)'
  
  // Calculate scroll position to place units badge at exactly 10% from top
  const viewportHeight = window.innerHeight
  const targetBadgePositionFromTop = viewportHeight * 0.1 // 10% from top
  const unitsBadgeRect = unitsBadge.getBoundingClientRect()
  
  // Calculate target scroll to position badge at exactly 10% from top
  const targetScroll = window.scrollY + unitsBadgeRect.top - targetBadgePositionFromTop
  
  console.log('Units Badge Positioning (10% target):', {
    viewportHeight,
    targetPosition: targetBadgePositionFromTop,
    currentBadgeTop: unitsBadgeRect.top,
    scrollOffset: unitsBadgeRect.top - targetBadgePositionFromTop,
    finalTargetScroll: targetScroll
  })
  
  // Prevent scroll events during transition
  document.body.style.overflow = 'hidden'
  
  // Faster fade timing - start fade in earlier
  setTimeout(() => {
    // Instantly scroll to target position while sections are fading
    window.scrollTo({
      top: targetScroll,
      behavior: 'auto' // Instant scroll during transition
    })
    
    // Start fade-in of units section from top (faster)
    unitsSection.style.transition = 'all 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94)'
    unitsSection.style.opacity = '1'
    unitsSection.style.transform = 'translateY(0)'
    
    console.log('Faded to units section with badge positioned at 10% from top')
    
  }, 200) // Start fade-in earlier (200ms instead of 400ms)
  
  // Reset all transforms after full transition (faster cleanup)
  setTimeout(() => {
    locationsSection.style.opacity = '1'
    locationsSection.style.transform = 'translateY(0)'
    locationsSection.style.transition = ''
    unitsSection.style.transition = ''
    document.body.style.overflow = 'auto' // Re-enable scrolling
    isNudging.value = false
  }, 1000) // Faster cleanup (1000ms instead of 1600ms)
}

// nudgeToNextSection() - only for units → locations transition
// Fade transition from units-section to locations-section
const nudgeToNextSection = () => {
  console.log('UNITS → LOCATIONS TRANSITION - Starting fade transition')
  
  // Get both sections
  const unitsSection = document.querySelector('.units-section')
  const locationsSection = document.querySelector('.locations-section')
  
  if (!unitsSection || !locationsSection) return
  
  // Determine which section is currently visible
  const unitsBadge = unitsSection.querySelector('.hero-badge')
  const locationsBadge = locationsSection.querySelector('.hero-badge')
  
  if (!unitsBadge || !locationsBadge) return
  
  // Check which badge is currently more visible (closer to top)
  const unitsBadgeRect = unitsBadge.getBoundingClientRect()
  const locationsBadgeRect = locationsBadge.getBoundingClientRect()
  
  // This function is primarily for units → locations (from mobile slider)
  const isInUnitsSection = unitsBadgeRect.top < window.innerHeight * 0.5
  
  if (isInUnitsSection) {
    // FORWARD: Units → Locations
    console.log('Forward transition: Units → Locations')
    
    const currentSection = unitsSection
    const targetSection = locationsSection
    const targetBadge = locationsBadge
    
    // Start fade transition
    isNudging.value = true
    
    // Prepare target section for fade-in from bottom
    targetSection.style.transition = ''
    targetSection.style.opacity = '0'
    targetSection.style.transform = 'translateY(60px)'
    
    // Apply fade-out to current section - fade up and out (faster)
    currentSection.style.transition = 'all 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94)'
    currentSection.style.opacity = '0'
    currentSection.style.transform = 'translateY(-60px)'
    
    // Calculate scroll position to place locations badge at exactly 10% from top
    const viewportHeight = window.innerHeight
    const targetBadgePositionFromTop = viewportHeight * 0.1 // 10% from top
    const targetBadgeRect = targetBadge.getBoundingClientRect()
    
    // Calculate target scroll to position badge at exactly 10% from top
    const targetScroll = window.scrollY + targetBadgeRect.top - targetBadgePositionFromTop
    
    console.log('Locations Badge Positioning (10% target):', {
      viewportHeight,
      targetPosition: targetBadgePositionFromTop,
      currentBadgeTop: targetBadgeRect.top,
      scrollOffset: targetBadgeRect.top - targetBadgePositionFromTop,
      finalTargetScroll: targetScroll
    })
    
    // Prevent scroll events during transition
    document.body.style.overflow = 'hidden'
    
    // Faster fade timing - start fade in earlier
    setTimeout(() => {
      // Instantly scroll to target position while sections are fading
      window.scrollTo({
        top: targetScroll,
        behavior: 'auto' // Instant scroll during transition
      })
      
      // Start fade-in of target section from bottom (faster)
      targetSection.style.transition = 'all 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94)'
      targetSection.style.opacity = '1'
      targetSection.style.transform = 'translateY(0)'
      
      console.log('Faded to locations section with badge positioned at 10% from top')
      
    }, 200) // Start fade-in earlier (200ms instead of 400ms)
    
    // Reset all transforms after full transition (faster cleanup)
    setTimeout(() => {
      currentSection.style.opacity = '1'
      currentSection.style.transform = 'translateY(0)'
      currentSection.style.transition = ''
      targetSection.style.transition = ''
      document.body.style.overflow = 'auto' // Re-enable scrolling
      isNudging.value = false
    }, 1000) // Faster cleanup (1000ms instead of 1600ms)
  } else {
    console.log('Warning: nudgeToNextSection called from locations section - use transitionToUnitsSection instead')
  }
}

// Handle wheel events for mobile slider navigation and scroll blocking
const handleWheel = (event) => {
  console.log('Wheel:', { deltaY: event.deltaY, currentSlide: currentSlideIndex.value, totalSlides: totalSlides.value })
  
  // Block fast scrolling from locations to units section
  if (event.deltaY < -100 && !isNudging.value) { // Fast upward scroll
    const locationsSection = document.querySelector('.locations-section')
    const unitsSection = document.querySelector('.units-section')
    
    if (locationsSection && unitsSection) {
      const locationsBadge = locationsSection.querySelector('.hero-badge')
      const unitsBadge = unitsSection.querySelector('.hero-badge')
      
      if (locationsBadge && unitsBadge) {
        const locationsBadgeRect = locationsBadge.getBoundingClientRect()
        const unitsBadgeRect = unitsBadge.getBoundingClientRect()
        const viewportHeight = window.innerHeight
        
        // Check if user is in locations section
        const isInLocationsSection = locationsBadgeRect.top < viewportHeight * 0.8
        
        // Block if trying to fast scroll to units section without proper transition
        if (isInLocationsSection && unitsBadgeRect.bottom > 0) {
          console.log('🚫 WHEEL BLOCKED: Fast scroll to units section prevented')
          event.preventDefault()
          return
        }
      }
    }
  }
  
  // Handle mobile wheel events normally for other cases
  if (isMobile.value) {
    // Let the mobile slider handle its own navigation through touch events
    // The wheel events should not interfere with touch-based navigation
  }
}

// Handle slider change events
const handleSliderChange = (swiper) => {
  // Only update if this is a legitimate slide change, not a reset
  if (swiper && swiper.activeIndex !== undefined) {
    const newIndex = swiper.activeIndex
    console.log('Slide changed from', currentSlideIndex.value, 'to', newIndex)
    currentSlideIndex.value = newIndex
  }
  // Keine automatische Entsperrung mehr - nur über die spezifischen Scroll-Aktionen
}

// Enhanced smooth scroll function with easing
const smoothScrollTo = (targetPosition, duration = 800) => {
  if (isSmoothScrolling.value) return // Prevent multiple simultaneous smooth scrolls
  
  const startPosition = window.scrollY
  const distance = targetPosition - startPosition
  const startTime = performance.now()
  
  isSmoothScrolling.value = true
  
  // Easing function (ease-out cubic)
  const easeOutCubic = (t) => 1 - Math.pow(1 - t, 3)
  
  const animate = (currentTime) => {
    const elapsed = currentTime - startTime
    const progress = Math.min(elapsed / duration, 1)
    const easedProgress = easeOutCubic(progress)
    
    const currentPosition = startPosition + (distance * easedProgress)
    window.scrollTo(0, currentPosition)
    
    if (progress < 1) {
      requestAnimationFrame(animate)
    } else {
      isSmoothScrolling.value = false
      console.log('✅ Smooth scroll completed')
    }
  }
  
  requestAnimationFrame(animate)
}

// Update the handleScroll function
const handleScroll = () => {
  const currentScrollY = window.scrollY
  const previousScrollY = scrollY.value
  scrollY.value = currentScrollY
  
  // Determine scroll direction
  if (currentScrollY > previousScrollY) {
    scrollDirection.value = 'down'
  } else if (currentScrollY < previousScrollY) {
    scrollDirection.value = 'up'
  }

  // Check for smooth scroll stop when units section hero badge reaches top 10% (MOBILE ONLY)
  if (isMobile.value) { // Only apply smooth scroll stop on mobile devices
    const unitsSection = document.querySelector('.units-section')
    if (unitsSection && !isNudging.value && !isSmoothScrolling.value) {
      const unitsBadge = unitsSection.querySelector('.hero-badge')
      if (unitsBadge) {
        const unitsBadgeRect = unitsBadge.getBoundingClientRect()
        const viewportHeight = window.innerHeight
        const topTenPercent = viewportHeight * 0.1 // 10% from top
        const badgeTop = unitsBadgeRect.top
        
        // Check if we should bypass smooth scroll stop
        // Bypass when mobile luxury slider is on "Premium Fliesen Design" (index 0) 
        // and user is trying to scroll up (to previous slider)
        const isOnPremiumFliesenDesign = currentSlideIndex.value === 0 // "Premium Fliesen Design" is at index 0
        const isScrollingUp = scrollDirection.value === 'up'
        const shouldBypassForSliderNavigation = isOnPremiumFliesenDesign && isScrollingUp && isMobile.value
        
        // Enhanced approach zone detection for smoother stopping
        const approachZone = 60 // Larger approach zone for earlier detection
        const snapZone = 15 // Smaller snap zone for precise stopping
        
        const distanceFromTarget = Math.abs(badgeTop - topTenPercent)
        const isInApproachZone = badgeTop <= topTenPercent + approachZone && badgeTop >= topTenPercent - approachZone
        const isInSnapZone = distanceFromTarget <= snapZone
        
        // Only apply smooth scroll stop if NOT bypassing AND in approach zone
        if (!shouldBypassForSliderNavigation && isInApproachZone) {
          // Calculate exact position where badge should be at 10%
          const targetScrollPosition = window.scrollY + (badgeTop - topTenPercent)
          
          if (isInSnapZone) {
            console.log('🎯 PRECISION STOP: Units badge in snap zone - smooth scrolling to 10% (MOBILE)')
            
            // Use enhanced smooth scroll with shorter duration for nearby targets
            smoothScrollTo(targetScrollPosition, 400)
            return // Prevent further scroll processing
            
          } else {
            // In approach zone but not snap zone - gentle deceleration
            const decelerationFactor = Math.max(0.3, 1 - (approachZone - distanceFromTarget) / approachZone)
            
            console.log('⚡ APPROACH ZONE: Gentle deceleration (MOBILE)', {
              distanceFromTarget,
              decelerationFactor,
              badgeTop,
              targetPosition: topTenPercent
            })
            
            // Gentle scroll adjustment (optional micro-adjustment)
            if (distanceFromTarget > snapZone && distanceFromTarget < 30) {
              smoothScrollTo(targetScrollPosition, 600)
              return
            }
          }
        } else if (shouldBypassForSliderNavigation) {
          console.log('🔄 BYPASS: On Premium Fliesen Design slide, allowing upward scroll for slider navigation (MOBILE)')
          // Don't return here - allow the function to continue to the transition logic
        }
      }
    }
  }

  // Check for locations-section → units-section transition when hero badge reaches top 15% (MOBILE ONLY)
  if (scrollDirection.value === 'up' && !isNudging.value && isMobile.value) {
    const locationsSection = document.querySelector('.locations-section')
    const unitsSection = document.querySelector('.units-section')
    
    if (locationsSection && unitsSection) {
      const locationsBadge = locationsSection.querySelector('.hero-badge')
      const unitsBadge = unitsSection.querySelector('.hero-badge')
      
      if (locationsBadge && unitsBadge) {
        const locationsBadgeRect = locationsBadge.getBoundingClientRect()
        const unitsBadgeRect = unitsBadge.getBoundingClientRect()
        const viewportHeight = window.innerHeight
        const topFifteenPercent = viewportHeight * 0.15 
        
        // Check if user is in locations section
        const isInLocationsSection = locationsBadgeRect.top < viewportHeight * 0.8
        
        // Only trigger transition when badge is exactly at 15% AND visible on screen
        const badgeTop = locationsBadgeRect.top
        const badgeIsVisible = badgeTop >= 0 && badgeTop <= viewportHeight // Badge is in viewport
        const badgeReachedTriggerPoint = badgeTop <= topFifteenPercent && badgeTop >= topFifteenPercent - 10 // Within 10px tolerance of 15%
        const canTriggerTransition = badgeIsVisible && badgeReachedTriggerPoint
        
        // BLOCK: Prevent direct scrolling to units section from locations (MOBILE ONLY)
        if (isInLocationsSection && !canTriggerTransition && unitsBadgeRect.bottom > 0) {
          console.log('🚫 BLOCKED: Direct scroll to units section prevented - use transition instead (MOBILE)')
          // Prevent scroll by resetting to previous position
          window.scrollTo({
            top: previousScrollY,
            behavior: 'auto'
          })
          return // Stop further scroll processing
        }
        
        // Debug logging
        console.log('Badge Position Debug (MOBILE):', {
          badgeTop: badgeTop,
          topFifteenPercent,
          badgeIsVisible,
          badgeReachedTriggerPoint,
          canTriggerTransition,
          isInLocationsSection,
          scrollDirection: scrollDirection.value,
          isNudging: isNudging.value
        })
        
        if (canTriggerTransition) {
          console.log('🎯 BADGE TRIGGER: Locations badge reached exactly 15% while visible - triggering transition to units! (MOBILE)')
          transitionToUnitsSection() // Use specific function for locations → units
          return // Prevent normal scroll handling during transition
        } else if (!badgeIsVisible && scrollDirection.value === 'up') {
          console.log('❌ Badge out of view - no transition triggered on scroll up (MOBILE)')
        }
      }
    }
  }
  
  const timelineEl = document.querySelector('.timeline')
  if (timelineEl) {
    const timelineRect = timelineEl.getBoundingClientRect()
    const viewportHeight = window.innerHeight
    
    if (timelineRect.top < viewportHeight * 0.8) {
      const timelineSteps = document.querySelectorAll('.timeline-step')
      timelineSteps.forEach((step, index) => {
        const stepRect = step.getBoundingClientRect()
        if (stepRect.top < viewportHeight * 0.8) {
          if (!visibleTimeline.value.includes(index)) {
            visibleTimeline.value.push(index)
          }
        }
      })
    }

    // Position the timeline line correctly relative to the first marker
    const firstStepMarker = timelineEl.querySelector('.step-marker')
    if (firstStepMarker) {
      const firstStepMarkerRect = firstStepMarker.getBoundingClientRect()
      const timelineLineLeft = firstStepMarkerRect.left + firstStepMarkerRect.width/2 - timelineRect.left
      
      const timelineLine = timelineEl.querySelector('.timeline-line')
      if (timelineLine) {
        timelineLine.style.left = `${timelineLineLeft}px`
      }
    }
    
    // Update timeline line height
    const firstDot = timelineEl.querySelector('.timeline-dot')
    const lastDot = timelineEl.querySelectorAll('.timeline-dot')[timeline.length - 1]
    
    if (firstDot && lastDot) {
      const firstDotRect = firstDot.getBoundingClientRect()
      const lastDotRect = lastDot.getBoundingClientRect()
      const lineHeight = lastDotRect.top - firstDotRect.top
      
      const timelineLine = timelineEl.querySelector('.timeline-line')
      if (timelineLine) {
        timelineLine.style.height = `${lineHeight}px`
        timelineLine.style.top = `${firstDotRect.top - timelineRect.top}px`
      }
    }
  }
}

// Update the computed timelineProgress
const timelineProgress = computed(() => {
  if (!visibleTimeline.value.length) return 0
  
  // Find the most recent visible step
  const lastVisibleIndex = Math.max(...visibleTimeline.value)
  const totalSteps = timeline.length - 1 // Subtract 1 for zero-based index
  
  // Calculate progress as a percentage of visible distance between dots
  return ((lastVisibleIndex) / totalSteps) * 100
})

// Number Counter Animation
const animateNumbers = () => {
  const numbers = document.querySelectorAll('.stat-number[data-target]')
  numbers.forEach(num => {
    const target = parseInt(num.dataset.target)
    const duration = 2000
    const increment = target / (duration / 16)
    let current = 0
    
    const updateNumber = () => {
      current += increment
      if (current < target) {
        num.textContent = Math.floor(current).toLocaleString('de-DE')
        requestAnimationFrame(updateNumber)
      } else {
        num.textContent = target.toLocaleString('de-DE')
      }
    }
    
    updateNumber()
  })
}

// Intersection Observer für Scroll-Animationen
const initScrollAnimations = () => {
  if (!process.client) return
  
  // Konfiguration für den Observer
  const observerOptions = {
    root: null,
    rootMargin: '-10% 0px -10% 0px', // Element muss 10% im Viewport sein
    threshold: 0.1
  }
  
  // Observer Callback
  const observerCallback = (entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        // Element ist sichtbar - Animation starten
        entry.target.classList.add('is-visible')
        
        console.log('🎯 Animation triggered for:', entry.target.className)
      }
    })
  }
  
  // Observer erstellen
  scrollAnimationObserver = new IntersectionObserver(observerCallback, observerOptions)
  
  // Alle animierbaren Elemente finden und observieren
  const animatableElements = document.querySelectorAll('.animate-on-scroll, .animate-on-scroll-delayed, .animate-on-scroll-slow')
  
  animatableElements.forEach(element => {
    scrollAnimationObserver.observe(element)
  })
  
  console.log(`📊 Initialized scroll animations for ${animatableElements.length} elements`)
}

// Observer cleanup
const cleanupScrollAnimations = () => {
  if (scrollAnimationObserver) {
    scrollAnimationObserver.disconnect()
    scrollAnimationObserver = null
  }
}

// Lifecycle
onMounted(() => {
  checkMobile()
  if (process.client) {
    window.addEventListener('resize', checkMobile)
    window.addEventListener('scroll', handleScroll, { passive: true })
    window.addEventListener('scroll', requestTick, { passive: true })
    window.addEventListener('wheel', handleWheel, { passive: false })
    
    // Scroll-Animationen initialisieren (mit Delay für DOM-Rendering)
    setTimeout(() => {
      initScrollAnimations()
    }, 100)
  }
  updateParallax()
})

onUnmounted(() => {
  if (process.client) {
    window.removeEventListener('resize', checkMobile)
    window.removeEventListener('scroll', handleScroll)
    window.removeEventListener('scroll', requestTick)
    window.removeEventListener('wheel', handleWheel)
    document.body.style.overflow = 'auto'
    
    // Scroll-Animationen cleanup
    cleanupScrollAnimations()
  }
})

function updateParallax() {
  if (!process.client || !heroBg.value || !heroContent.value || !heroSubheading.value) return

  const scrollY = window.scrollY
  const viewportHeight = window.innerHeight
  
  const heroScrollProgress = Math.min(scrollY / (viewportHeight * 0.8), 1)
  const bgScale = 1.05 + (heroScrollProgress * 0.1)
  const bgBrightness = Math.max(0.1, 1 - (heroScrollProgress * 1.5))
  const bgOpacity = Math.max(0, 1 - (heroScrollProgress * 1.2))
  
  //heroBg.value.style.transform = `scale(${bgScale})`
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
</script>

<style scoped>
/* Update hero styles */
.hero {
  position: relative;
  height: 100vh;
  overflow: hidden;
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
  top: 20%;
  left: 10%;
  z-index: 2;
  color: white;
  text-align: left;
  max-width: 1200px;
  will-change: transform;
}


.hero-badge {
  display: inline-block;
  padding: 1rem 3rem;
  background: rgba(0, 0, 0, 0.3);
  border: 3px solid var(--primary-gold);
  color: var(--primary-gold);
  font-size: 1rem;
  font-weight: 900;
  letter-spacing: 0.4em;
  margin-top: 2rem;  /* Changed from margin-bottom to margin-top */
  clip-path: polygon(15px 0, 100% 0, calc(100% - 15px) 100%, 0 100%);
  backdrop-filter: blur(10px);
}

.hero-title {
  font-size: clamp(2rem, 6vw, 5rem); /* Reduced from clamp(4rem, 12vw, 10rem) */
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
  bottom: 20%;
  left: 10%;
  transform: translateX(0);
  z-index: 2;
  text-align: left;
  width: 90%;
  max-width: 800px;
  will-change: transform;
}

.hero-subheading p {
  font-size: clamp(1.2rem, 2vw, 1.8rem);
  color: #e6e0d5;
  margin: 0;
  line-height: 1.3;
  font-weight: 300;
  opacity: 0;
  transform: translateY(30px);
  animation: slideUpFromBottom 1.8s ease-out 1.2s forwards;
  padding: 1rem 2rem;
  border-radius: 8px;
}


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

/* Global Styles */
.about-page {
  min-height: 100vh;
  background: var(--bg-dark);
  color: var(--primary-light);
  overflow-x: hidden;
  padding-top: var(--header-height);
}

.container {
  max-width: 1400px;
  margin: 0 auto;
  padding: 0 2rem;
}

/* Hero Section - ENHANCED */
.hero-section {
  position: relative;
  min-height: calc(100vh - var(--header-height));
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
}

.hero-background {
  position: absolute;
  inset: 0;
}

.hero-video {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.hero-overlay {
  position: absolute;
  inset: 0;
  background: radial-gradient(ellipse at center, rgba(0,0,0,0.5) 0%, rgba(0,0,0,0.9) 100%);
}

.hero-content {
  position: relative;
  z-index: 2;
  text-align: left;
  max-width: 1200px;
  padding: 0 2rem;
}

.hero-badge {
  display: inline-block;
  padding: 1rem 3rem;
  background: transparent;
  border: 3px solid var(--primary-gold);
  color: var(--primary-gold);
  font-size: 1rem;
  font-weight: 900;
  letter-spacing: 0.4em;
  margin-bottom: 3rem;
  position: relative;
  overflow: hidden;
  clip-path: polygon(15px 0, 100% 0, calc(100% - 15px) 100%, 0 100%);
  transition: all 0.4s ease;
}

.hero-badge::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(164, 113, 72, 0.5), transparent);
  animation: sweep 3s forwards;
}

@keyframes sweep {
  0% { left: -100%; }
  100% { left: 100%; }
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

.animate-fade-in {
  animation: fadeIn 1s ease-out;
}

.animate-fade-up {
  animation: fadeUp 1s ease-out 0.5s backwards;
}

@keyframes fadeIn {
  from { opacity: 0; }
  to { opacity: 1; }
}

@keyframes fadeUp {
  from {
    opacity: 0;
    transform: translateY(30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* Hero-Subheading Style Animation für alle Elemente */
.animate-on-scroll {
  opacity: 0;
  transform: translateY(40px);
  transition: opacity 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94), 
              transform 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

.animate-on-scroll.is-visible {
  opacity: 1;
  transform: translateY(0);
}

/* Variationen für unterschiedliche Timing */
.animate-on-scroll-delayed {
  opacity: 0;
  transform: translateY(40px);
  transition: opacity 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94) 0.2s,
              transform 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94) 0.2s;
}

.animate-on-scroll-delayed.is-visible {
  opacity: 1;
  transform: translateY(0);
}

.animate-on-scroll-slow {
  opacity: 0;
  transform: translateY(40px);
  transition: opacity 1.2s cubic-bezier(0.25, 0.46, 0.45, 0.94),
              transform 1.2s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

.animate-on-scroll-slow.is-visible {
  opacity: 1;
  transform: translateY(0);
}

.scroll-indicator {
  position: absolute;
  bottom: 2rem;
  left: 50%;
  transform: translateX(-50%);
  cursor: pointer;
  animation: bounce 2s infinite;
}

@keyframes bounce {
  0%, 100% { transform: translateX(-50%) translateY(0); }
  50% { transform: translateX(-50%) translateY(10px); }
}

.scroll-indicator .material-icons {
  font-size: 3rem;
  color: var(--primary-gold);
}

/* Floating Elements */
.floating-elements {
  position: absolute;
  inset: 0;
  pointer-events: none;
}

.float-element {
  position: absolute;
  background: linear-gradient(135deg, var(--primary-gold), transparent);
  border-radius: 50%;
  filter: blur(100px);
  opacity: 0.3;
}

.element-1 {
  width: 300px;
  height: 300px;
  top: 10%;
  left: -10%;
  animation: float1 20s infinite;
}

.element-2 {
  width: 400px;
  height: 400px;
  bottom: 10%;
  right: -10%;
  animation: float2 25s infinite;
}

.element-3 {
  width: 200px;
  height: 200px;
  top: 50%;
  right: 10%;
  animation: float3 15s infinite;
}

@keyframes float1 {
  0%, 100% { transform: translate(0, 0) scale(1); }
  50% { transform: translate(50px, -30px) scale(1.1); }
}

@keyframes float2 {
  0%, 100% { transform: translate(0, 0) scale(1); }
  50% { transform: translate(-30px, 50px) scale(0.9); }
}

@keyframes float3 {
  0%, 100% { transform: translate(0, 0) scale(1); }
  50% { transform: translate(30px, 30px) scale(1.2); }
}

/* All Section Headers - CYBER ENHANCEMENT */
.section-header {
  text-align: left;
  margin-bottom: 8rem;
  position: relative;
  z-index: 1;
}

/* Additional hover effects for interactive sections */
.section-header:hover .section-title {
  animation-duration: 0.1s;
  transform: scale(1.02);
  transition: transform 0.3s ease;
}

.section-header:hover .section-badge {
  animation: badgeShake 0.5s ease;
}

@keyframes badgeShake {
  0%, 100% { transform: translateX(0); }
  25% { transform: translateX(-5px); }
  75% { transform: translateX(5px); }
}

/* Section Badge - FINAL PUNK STYLE */
.section-badge {
  display: inline-block;
  padding: 0.75rem 2.5rem;
  background: transparent;
  border: 2px solid var(--primary-gold);
  color: var(--primary-gold);
  font-size: 0.8rem;
  letter-spacing: 0.3em;
  margin-bottom: 2rem;
  font-weight: 700;
  position: relative;
  overflow: hidden;
  text-transform: uppercase;
  transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  clip-path: polygon(0 0, calc(100% - 15px) 0, 100% 50%, calc(100% - 15px) 100%, 0 100%, 15px 50%);
  box-shadow: 
    0 0 20px rgba(164, 113, 72, 0.2),
    inset 0 0 20px rgba(164, 113, 72, 0.1);
}

.section-badge::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, var(--primary-gold), transparent);
  transition: left 0.8s ease;
}

.section-badge::after {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: var(--primary-gold);
  z-index: -1;
  transform: scaleX(0);
  transform-origin: left;
  transition: transform 0.4s ease;
}

.section-badge:hover::before {
  left: 100%;
}

.section-badge:hover::after {
  transform: scaleX(1);
}

.section-badge:hover {
  color: var(--bg-dark);
  transform: scale(1.1) translateY(-2px);
  box-shadow: 
    0 10px 40px rgba(164, 113, 72, 0.4),
    inset 0 0 30px rgba(250, 250, 248, 0.2);
  border-color: var(--primary-light);
}

.section-title {
  font-size: clamp(3rem, 7vw, 6rem);
  font-weight: 300;
  margin-bottom: 1.5rem;
  line-height: 1;
  position: left;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  
  /* Always ensure text is visible with solid color */
  color: var(--primary-light);
  
  /* Enhanced visibility and styling */
  text-shadow: 
    0 0 20px rgba(250, 250, 248, 0.3),
    0 0 40px rgba(164, 113, 72, 0.2),
    2px 2px 4px rgba(0, 0, 0, 0.8);
  
  transition: transform 0.3s ease;
}

/* Removed the ::before and ::after pseudo-elements since they're no longer needed */
.section-title::before,
.section-title::after {
  content: none;
}

.section-subtitle {
  font-size: 1.25rem;
  color: var(--text-gray);
  max-width: 800px;
  margin: 0 auto;
  opacity: 0.8;
  animation: subtitleFade 2s ease-out;
  position: absolute;
  text-align: left;
  margin-bottom: 8rem; 
}

/* Add a utility class for sections that follow subtitles */
.showrooms-grid,
.values-grid,
.team-showcase,
.articles-grid,
.luxury-slider {
  margin-top: 0rem; /* Increased top margin for content following subtitles */
}

/* Make luxury-slider match section header width */
.luxury-slider {
  max-width: 1400px;
  margin-left: 0 !important;
}

/* Story Section Title - ULTRA PREMIUM STYLING */
.story-content .story-title {
  font-size: clamp(3rem, 6vw, 5rem);
  font-weight: 900;
  margin-bottom: 3rem;
  line-height: 1;
  text-align: left;
  position: relative;
  overflow: visible;
}

.story-title .title-line-1 {
  display: block;
  font-size: clamp(4rem, 8vw, 7rem);
  font-weight: 900;
  margin-bottom: -0.2rem;
  position: relative;
  animation: 
    slideInLeft 1s cubic-bezier(0.68, -0.55, 0.265, 1.55),
    textGlow 4s ease-in-out infinite;
  text-transform: uppercase;
  letter-spacing: -0.02em;
  background: linear-gradient(
    90deg,
    var(--primary-gold),
    var(--primary-light),
    var(--primary-gold),
    var(--primary-light)
  );
  background-size: 400% 100%;
  -webkit-background-clip: text;
  background-clip: text;
  -webkit-text-fill-color: white;
  animation: slideInLeft 1s cubic-bezier(0.68, -0.55, 0.265, 1.55),
            gradientMove 6s linear infinite;
}

@keyframes gradientMove {
  0% { background-position: 0% 50%; }
  100% { background-position: 400% 50%; }
}

@keyframes textGlow {
  0%, 100% {
    filter: drop-shadow(0 0 20px rgba(164, 113, 72, 0.5));
  }
  50% {
    filter: drop-shadow(0 0 40px rgba(164, 113, 72, 0.8));
  }
}

.story-title .title-line-2 {
  display: block;
  font-size: clamp(3rem, 6vw, 5rem);
  font-weight: 300;
  position: relative;
  animation: slideInRight 1s cubic-bezier(0.68, -0.55, 0.265, 1.55) 0.2s backwards;
  text-transform: uppercase;
  letter-spacing: 0.2em;
  background: linear-gradient(135deg, #FAFAF8 0%, #a47148 100%);
  -webkit-background-clip: text;
  background-clip: text;
  -webkit-text-fill-color: transparent;
  text-shadow: none;
}

.story-title .title-line-2::after {
  content: '';
  position: absolute;
  bottom: -10px;
  left: 0;
  width: 0;
  height: 3px;
  background: linear-gradient(90deg, var(--primary-gold), transparent);
  animation: lineExpand 2s ease-out 1s forwards;
}

@keyframes lineExpand {
  to {
    width: 100%;
  }
}

@keyframes slideInLeft {
  from {
    transform: translateX(-100px);
    opacity: 0;
    filter: blur(5px);
  }
  to {
    transform: translateX(0);
    opacity: 1;
    filter: blur(0);
  }
}

@keyframes slideInRight {
  from {
    transform: translateX(100px);
    opacity: 0;
    filter: blur(5px);
  }
  to {
    transform: translateX(0);
    opacity: 1;
    filter: blur(0);
  }
}

/* Galabau Title - SPECIAL EFFECT */
.galabau-title {
  font-size: clamp(3rem, 7vw, 6rem) !important;
  line-height: 0.9 !important;
  text-align: left;
  font-weight: 900 !important;
  text-transform: uppercase;
  position: relative;
  letter-spacing: -0.02em;
}

.galabau-title::before {
  content: 'EXCLUSIVE';
  position: absolute;
  top: -40px;
  left: 0;
  font-size: 0.8rem;
  letter-spacing: 0.5em;
  color: var(--primary-gold);
  opacity: 0.5;
  font-weight: 300;
}

/* CTA Title - EPIC STYLE */
.cta-title {
  font-size: clamp(3.5rem, 8vw, 7rem) !important;
  font-weight: 900;
  line-height: 1.1; /* Adjusted from 0.9 */
  margin-bottom: 1.5rem;
  text-transform: uppercase;
  letter-spacing: -0.03em;
  position: relative;
  color: var(--primary-light);
  text-align: center;
  width: 100%;
  display: inline-block; /* Changed from block to inline-block */
  white-space: nowrap; /* Added to prevent unwanted line breaks */
}

.cta-title br {
  display: block; /* Added to ensure line break works */
}

/* Mobile Responsive - IMPROVED */
@media (max-width: 768px) {
  .hero {
    height: 100vh; /* Ensure full height */
    display: flex;
    flex-direction: column;
    justify-content: center;
  }

  .hero-content {
    position: absolute;
    bottom: 30%; /* Adjusted for mobile */
    left: 5%;
    right: 5%;
    max-width: none;
    text-align: left
  }

  .hero-subheading {
    position: absolute;
    bottom: 25%; /* Moved closer to content */
    left: 5%;
    right: 5%;
    width: auto;
    max-width: none;
    text-align: left;
  }

  .hero-subheading p {
    font-size: clamp(1rem, 4vw, 1.4rem);
    padding: 1rem;
  }

  .hero-title {
    font-size: clamp(2rem, 8vw, 3rem);
    text-align: center;
  }

  

  .section-title {
    font-size: clamp(2rem, 5vw, 3rem);
  }
  
  .story-title .title-line-1 {
    font-size: clamp(2.5rem, 6vw, 4rem);
  }
  
  .story-title .title-line-2 {
    font-size: clamp(2rem, 5vw, 3rem);
    letter-spacing: 0.1em;
  }
  
  .cta-buttons {
    flex-direction: column;
    gap: 1rem;
  }
  
  .quick-contact {
    flex-direction: column;
    gap: 1rem;
  }
  
  .modal-body {
    padding: 2rem;
  }
  
  .modal-buttons {
    flex-direction: column;
  }

  /* Timeline adjustments for mobile */
  .timeline {
    padding-left: 2rem;
  }

  .timeline-step {
    grid-template-columns: 30px 1fr;
    gap: 1rem;
  }
}

@media (max-width: 480px) {
  .hero-content {
    top: 25%;
    left: 1rem;
    right: 1rem;
  }

  .hero-subheading {
    bottom: 20%;
    left: 1rem;
    right: 1rem;
  }

  .hero-subheading p {
    padding: 0.75rem 1rem;
  }

  .about-page {
    padding-top: 60px;
  }
  
  .container {
    padding: 0 1rem;
  }
  
  .hero-title {
    font-size: 2rem;
  }
}

/* Story Section - Updated */
.story-section {
  padding: 8rem 0;
  position: relative;
  background: linear-gradient(180deg, var(--bg-dark) 0%, var(--bg-dark-alt) 100%);
}

.story-section::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 1px;
  background: linear-gradient(90deg, transparent, var(--primary-gold), transparent);
  animation: lineGlow 3s ease-in-out infinite;
}

@keyframes lineGlow {
  0%, 100% { opacity: 0.3; }
  50% { opacity: 1; }
}

.story-grid {
  display: grid;
  grid-template-columns: 1.2fr 1fr;
  gap: 6rem;
  align-items: center;
}

.story-content .section-badge {
  animation: slideInDown 1s ease-out;
}

@keyframes slideInDown {
  from {
    transform: translateY(-30px);
    opacity: 0;
  }
  to {
    transform: translateY(0);
    opacity: 1;
  }
}

.story-text {
  font-size: 1.1rem;
  line-height: 1.8;
  color: #ccc;
  margin-bottom: 2rem;
  opacity: 0;
  animation: fadeIn 1s ease-out 0.5s forwards;
}

@keyframes fadeIn {
  to { opacity: 1; }
}

/* Timeline - IMPROVED ALIGNMENT */
.timeline {
  position: relative;
  padding-left: 3rem;
  margin-top: 4rem;
  padding-bottom: 2rem;
}

.timeline-line {
  position: absolute;
  left: 0;
  top: 0;
  bottom: 0;
  width: 2px;
  background: rgba(255, 255, 255, 0.1);
  z-index: 0;
}

.timeline-progress {
  position: absolute;
  left: 0;
  top: 0;
  width: 100%;
  background: var(--primary-gold);
  z-index: 1;
  transition: height 0.3s ease-out;
}

.timeline-step {
  position: relative;
  margin-bottom: 3rem;
  opacity: 0;
  transform: translateY(30px);
  transition: all 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  display: grid;
  grid-template-columns: 40px 1fr; /* Adjust width of dot column */
  gap: 2rem;
  z-index: 2;
}

.step-marker {
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  width: 100%;
  height: 20px;
  margin-top: 8px;
}

.timeline-dot {
  width: 20px;
  height: 20px;
  background: var(--primary-gold);
  border-radius: 50%;
  position: relative;
  z-index: 3;
  border: 2px solid var(--bg-dark);
  box-shadow: 0 0 0 2px var(--primary-gold);
}

.marker-pulse {
  position: absolute;
  top: 50%;
  left: 50%;
  width: 40px;
  height: 40px;
  transform: translate(-50%, -50%);
  border: 2px solid var(--primary-gold);
  border-radius: 50%;
  animation: pulse 2s infinite;
  z-index: 2;
}

@keyframes pulse {
  0% {
    transform: translate(-50%, -50%) scale(1);
    opacity: 1;
  }
  100% {
    transform: translate(-50%, -50%) scale(2);
    opacity: 0;
  }
}

.timeline-step.active {
  opacity: 1;
  transform: translateY(0);
}

.timeline-step.active .timeline-dot {
  background: var(--primary-gold);
  box-shadow: 0 0 20px rgba(164, 113, 72, 0.5);
}

/* Stats Cards - New Design */
.story-visuals {
  position: relative;
}

.stats-cards {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 2rem;
}

.stat-card {
  padding: 2.5rem;
  background: linear-gradient(135deg, rgba(164, 113, 72, 0.1) 0%, rgba(255, 255, 255, 0.03) 100%);
  border-radius: 20px;
  border: 1px solid rgba(164, 113, 72, 0.3);
  position: relative;
  overflow: hidden;
  transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

.stat-card::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(164, 113, 72, 0.2), transparent);
  transition: left 0.6s ease;
}

.stat-card:hover::before {
  left: 100%;
}

.stat-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 20px 40px rgba(164, 113, 72, 0.3);
  background: linear-gradient(135deg, rgba(164, 113, 72, 0.15) 0%, rgba(255, 255, 255, 0.05) 100%);
}

.stat-card .stat-number {
  font-size: 3.5rem;
  font-weight: 700;
  background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary-gold) 100%);
  -webkit-background-clip: text;
  background-clip: text;
  -webkit-text-fill-color: transparent;
  margin-bottom: 0.5rem;
}

.stat-card .stat-label {
  font-size: 1.1rem;
  color: #ccc;
  text-transform: uppercase;
  letter-spacing: 0.1em;
  margin-bottom: 1rem;
}

.stat-card .stat-icon {
  position: absolute;
  top: 2rem;
  right: 2rem;
  width: 60px;
  height: 60px;
  background: rgba(164, 113, 72, 0.1);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
}

.stat-card .stat-icon .material-icons {
  font-size: 2rem;
  color: var(--primary-gold);
  opacity: 0.5;
}

@media (max-width: 768px) {
  .stats-cards {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 480px) {
  .stat-card {
    padding: 2rem 1.5rem;
  }
  
  .stat-card .stat-number {
    font-size: 2.5rem;
  }
  
  .stat-card .stat-icon {
    width: 50px;
    height: 50px;
    top: 1.5rem;
    right: 1.5rem;
  }
  
  .stat-card .stat-icon .material-icons {
    font-size: 1.5rem;
  }
}

/* Business Units Section */
.units-section {
  padding: 6rem 0;
  background: #000; /* Changed from gradient to solid black */
  position: relative; /* Added to create new stacking context */
  z-index: 1; /* Ensure it's above the fixed hero background */
  transition: all 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  transform: translateY(0);
  opacity: 1;
}

/* Nudge out animation for units section */
.units-section.nudge-out {
  transform: translateY(-100vh);
  opacity: 0;
}

/* Locations section animations */
.locations-section {
  background: linear-gradient(135deg, #1a1a1a 0%, #0a0a0a 100%);
  position: relative;
  z-index: 1; /* Ensure it's above the fixed hero background */
  transition: all 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  transform: translateY(0);
  opacity: 1;
}

/* Nudge in animation for locations section */
.locations-section.nudge-in {
  transform: translateY(0);
  opacity: 1;
}

/* Default state for locations section (when not nudging) */
.locations-section:not(.nudge-in) {
  transform: translateY(50px);
  opacity: 0.8;
}

.map-container {
  margin-top: 4rem;
  position: relative;
}

/* Individual text fade-in animations */
.fade-in-individually {
  opacity: 0;
  transform: translateY(30px);
  animation: fadeInUp 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94) forwards;
}

.location-text-1.fade-in-individually {
  animation-delay: 0.1s;
}

.location-text-2.fade-in-individually {
  animation-delay: 0.3s;
}

.location-text-3.fade-in-individually {
  animation-delay: 0.5s;
}

.location-text-4.fade-in-individually {
  animation-delay: 0.7s;
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

.units-carousel {
  position: relative;
  overflow: hidden;
  margin-top: 4rem;
  height: calc(100vh - 20rem); /* Adjust based on your header and padding */
}

.carousel-container {
  display: flex;
  height: 100%;
  transition: transform 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

.unit-card {
  min-width: 100%;
  height: 100%;
  display: grid;
  grid-template-columns: 45% 1fr;
  gap: 4rem;
  background: rgba(255, 255, 255, 0.03);
  border-radius: 20px;
  border: 1px solid var(--border-color);
  overflow: hidden;
}

.unit-image {
  height: 100%;
  overflow: hidden;
}

.unit-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.unit-content {
  padding: 4rem 2rem;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.unit-icon {
  width: 80px;
  height: 80px;
  margin-bottom: 2rem;
  background: linear-gradient(135deg, var(--primary-gold), var(--primary-light));
  border-radius: 20px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 2.5rem;
  color: var(--bg-dark);
}

/* Carousel Navigation */
.carousel-nav {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 2rem;
  margin-top: 3rem;
}

.nav-btn {
  width: 50px;
  height: 50px;
  background: rgba(255, 255, 255, 0.05);
  border: 1px solid var(--border-color);
  border-radius: 50%;
  color: var(--primary-light);
  cursor: pointer;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  justify-content: center;
}

.nav-btn:hover {
  background: var(--primary-gold);
  color: var(--bg-dark);
}

.carousel-dots {
  display: flex;
  gap: 0.5rem;
}

.dot {
  width: 12px;
  height: 12px;
  background: rgba(255, 255, 255, 0.3);
  border: none;
  border-radius: 50%;
  cursor: pointer;
  transition: all 0.3s ease;
}

.dot.active {
  background: var(--primary-gold);
  transform: scale(1.5);
}

/* Showrooms Section */
.showrooms-section {
  padding: 6rem 0;
  position: relative;
  overflow: hidden;
}

.showroom-bg-pattern {
  position: absolute;
  inset: 0;
  opacity: 0.03;
  background-image: repeating-linear-gradient(
    45deg,
    var(--primary-gold),
    var(--primary-gold) 1px,
    transparent 1px,
    transparent 15px
  );
}

.showrooms-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(500px, 1fr));
  gap: 3rem;
  margin-top: 4rem;
}

.showroom-card {
  background: rgba(255, 255, 255, 0.03);
  border-radius: 20px;
  overflow: hidden;
  border: 1px solid var(--border-color);
  transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

.showroom-card:hover {
  transform: translateY(-10px);
  box-shadow: 0 30px 60px rgba(164, 113, 72, 0.3);
}

.card-image {
  position: relative;
  height: 300px;
  overflow: hidden;
}

.card-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.6s ease;
}

.showroom-card:hover .card-image img {
  transform: scale(1.1);
}

.image-overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(180deg, transparent 0%, rgba(0,0,0,0.7) 100%);
}

.card-content {
  padding: 2.5rem;
}

.location-badge {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.5rem 1rem;
  background: rgba(164, 113, 72, 0.1);
  border: 1px solid var(--primary-gold);
  color: var(--primary-gold);
  font-size: 0.75rem;
  letter-spacing: 0.1em;
  margin-bottom: 1rem;
  border-radius: 50px;
}

.card-content h3 {
  font-size: 2rem;
  margin-bottom: 1.5rem;
  color: var(--primary-light);
}

.showroom-info {
  display: flex;
  flex-direction: column;
  gap: 1rem;
  margin-bottom: 2rem;
}

.info-item {
  display: flex;
  align-items: center;
  gap: 1rem;
  color: #ccc;
}

.info-item .material-icons {
  color: var(--primary-gold);
  font-size: 1.25rem;
}

.card-actions {
  display: flex;
  gap: 1rem;
}

.action-btn {
  flex: 1;
  padding: 0.875rem;
  border-radius: 10px;
  cursor: pointer;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  font-size: 0.875rem;
  letter-spacing: 0.05em;
}

.action-btn.primary {
  background: linear-gradient(135deg, var(--primary-gold), #ffd700);
  color: var(--bg-dark);
  border: none;
  font-weight: 700;
  text-transform: uppercase;
  box-shadow: 
    0 10px 30px rgba(164, 113, 72, 0.4),
    0 0 20px rgba(255, 215, 0, 0.2);
  text-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
}

.action-btn.primary:hover {
  transform: translateY(-5px) scale(1.05);
  box-shadow: 
    0 20px 40px rgba(164, 113, 72, 0.6),
    0 0 30px rgba(255, 215, 0, 0.3);
  background: linear-gradient(135deg, #ffd700, var(--primary-gold));
}

.action-btn.secondary {
  background: transparent;
  color: var(--primary-light);
  border: 2px solid var(--border-color);
}

.action-btn:hover {
  transform: translateY(-2px);
}

/* Team Section */
.team-section {
  padding: 6rem 0;
}

.team-showcase {
  margin-top: 4rem;
}

.showcase-main {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 4rem;
  align-items: center;
}

.main-image {
  position: relative;
  height: 500px;
  border-radius: 20px;
  overflow: hidden;
}

.main-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.main-content h3 {
  font-size: 2rem;
  margin-bottom: 1.5rem;
  color: var(--primary-light);
}

.main-content p {
  font-size: 1.1rem;
  line-height: 1.8;
  color: #ccc;
  margin-bottom: 2rem;
}

.team-stats {
  display: flex;
  gap: 3rem;
}

.team-stats .stat {
  text-align: center;
}

.team-stats .stat-number {
  display: block;
  font-size: 2.5rem;
  font-weight: 600;
  color: var(--primary-gold);
  margin-bottom: 0.5rem;
}

.team-stats .stat-label {
  font-size: 0.875rem;
  color: var(--text-gray);
  text-transform: uppercase;
  letter-spacing: 0.1em;
}

/* CTA Section */
.cta-section {
  padding: 8rem 0;
  position: relative;
  overflow: hidden;
}

.cta-background {
  position: absolute;
  inset: 0;
  z-index: 0;
}

.animated-gradient {
  width: 100%;
  height: 100%;
  background: linear-gradient(
    -45deg,
    #000,
    #1a1a1a,
    #a47148,
    #1a1a1a
  );
  background-size: 400% 400%;
  animation: gradientShift 15s ease infinite;
}

@keyframes gradientShift {
    0% { background-position: 0% 50%; }
  50% { background-position: 100% 50%; }
  100% { background-position: 0% 50%; }
}

.cta-content {
  position: relative;
  z-index: 1;
  text-align: center;
  max-width: 1200px; /* Increased from 800px */
  margin: 0 auto;
}

.cta-title {
  font-size: clamp(3.5rem, 8vw, 7rem) !important;
  font-weight: 900;
  line-height: 1.1; /* Adjusted from 0.9 */
  margin-bottom: 1.5rem;
  text-transform: uppercase;
  letter-spacing: -0.03em;
  position: relative;
  color: var(--primary-light);
  text-align: center;
  width: 100%;
  display: inline-block; /* Changed from block to inline-block */
  white-space: nowrap; /* Added to prevent unwanted line breaks */
}

.cta-title br {
  display: block; /* Added to ensure line break works */
}

.cta-subtitle {
  font-size: 1.5rem;
  color: #ccc;
  margin-bottom: 3rem;
}

.cta-buttons {
  display: flex;
  justify-content: center;
  gap: 1.5rem;
  margin-bottom: 3rem;
}

.cta-btn {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  padding: 1.25rem 2.5rem;
  font-size: 1rem;
  font-weight: 500;
  letter-spacing: 0.05em;
  text-decoration: none;
  cursor: pointer;
  transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  border-radius: 50px;
  position: relative;
  overflow: hidden;
}

.cta-btn.primary {
  background: linear-gradient(135deg, var(--primary-gold), #ffd700);
  color: var(--bg-dark);
  border: none;
  font-weight: 700;
  text-transform: uppercase;
  box-shadow: 
    0 10px 30px rgba(164, 113, 72, 0.4),
    0 0 20px rgba(255, 215, 0, 0.2);
  text-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
}

.cta-btn.primary:hover {
  transform: translateY(-5px) scale(1.05);
  box-shadow: 
    0 20px 40px rgba(164, 113, 72, 0.6),
    0 0 30px rgba(255, 215, 0, 0.3);
  background: linear-gradient(135deg, #ffd700, var(--primary-gold));
}

.cta-btn.secondary {
  background: transparent;
  color: var(--primary-light);
  border: 2px solid var(--primary-light);
}

.cta-btn:hover {
  transform: translateY(-5px);
}

.quick-contact {
  display: flex;
  justify-content: center;
  gap: 3rem;
}

.contact-item {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  color: #ccc;
}

.contact-item .material-icons {
  color: var(--primary-gold);
}

/* Modals */
.modal-overlay {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.95);
  z-index: 1000;
  display: flex;
  align-items: center;
  justify-content: center;
  backdrop-filter: blur(20px);
}

.modal-content {
  max-width: 900px;
  width: 90%;
  max-height: 90vh;
  overflow-y: auto;
  background: linear-gradient(135deg, 
    rgba(0, 0, 0, 0.95) 0%, 
    rgba(26, 26, 26, 0.9) 50%, 
    rgba(10, 10, 10, 0.95) 100%);
  border-radius: 20px;
  border: 2px solid var(--primary-gold);
  box-shadow: 
    0 20px 40px rgba(0, 0, 0, 0.8),
    0 0 0 1px rgba(164, 113, 72, 0.3),
    inset 0 1px 0 rgba(164, 113, 72, 0.2);
  backdrop-filter: blur(20px);
  animation: modalIn 0.4s ease-out;
  position: relative;
  padding: 0;
  color: var(--primary-light);
}

@keyframes modalIn {
  from {
    opacity: 0;
    transform: scale(0.9);
  }
  to {
    opacity: 1;
    transform: scale(1);
  }
}

.modal-close {
  position: absolute;
  top: 2rem;
  right: 2rem;
  width: 50px;
  height: 50px;
  background: rgba(0, 0, 0, 0.4);
  border: 2px solid var(--primary-gold);
  border-radius: 50%;
  color: var(--primary-gold);
  cursor: pointer;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  justify-content: center;
  backdrop-filter: blur(10px);
  z-index: 10;
}

.modal-close:hover {
  background: var(--primary-gold);
  color: var(--bg-dark);
  transform: rotate(90deg) scale(1.1);
  box-shadow: 0 0 20px rgba(164, 113, 72, 0.4);
}

.modal-body {
  padding: 3rem;
}

/* Modal Carousel */
.modal-carousel {
  margin: 0;
  border-radius: 20px 20px 0 0;
  overflow: hidden;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
  width: 100%;
}

.carousel-container {
  position: relative;
  width: 100%;
  height: 300px;
  overflow: hidden;
}

.carousel-track {
  display: flex;
  height: 100%;
  transition: transform 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

.carousel-slide {
  min-width: 100%;
  height: 100%;
  position: relative;
}

.carousel-slide img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
}

.carousel-indicators {
  position: absolute;
  bottom: 20px;
  left: 50%;
  transform: translateX(-50%);
  display: flex;
  gap: 12px;
  z-index: 5;
}

.carousel-dot {
  width: 12px;
  height: 12px;
  border-radius: 50%;
  border: 2px solid rgba(255, 255, 255, 0.6);
  background: rgba(0, 0, 0, 0.4);
  cursor: pointer;
  transition: all 0.3s ease;
  backdrop-filter: blur(10px);
}

.carousel-dot.active {
  background: var(--primary-gold);
  border-color: var(--primary-gold);
  transform: scale(1.2);
  box-shadow: 0 0 10px rgba(164, 113, 72, 0.6);
}

.carousel-dot:hover:not(.active) {
  background: rgba(255, 255, 255, 0.4);
  border-color: rgba(255, 255, 255, 0.8);
}

.modal-header {
  text-align: center;
  margin-bottom: 2rem;
}

.modal-description {
  margin-bottom: 3rem;
}

.modal-description h3 {
  font-size: 1.5rem;
  margin-bottom: 1.5rem;
  color: var(--primary-light);
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.modal-description h3::before {
  content: '';
  width: 4px;
  height: 20px;
  background: var(--primary-gold);
  border-radius: 2px;
}

.modal-description p {
  color: rgba(250, 250, 248, 0.8);
  line-height: 1.8;
  font-size: 1.1rem;
  font-weight: 300;
}

.modal-header {
  text-align: center;
  margin-bottom: 3rem;
}

.modal-subtitle {
  font-size: 1.2rem;
  color: rgba(250, 250, 248, 0.7);
  font-weight: 300;
  letter-spacing: 0.05em;
}

.modal-features {
  margin-bottom: 3rem;
}

.modal-features h3 {
  font-size: 1.5rem;
  margin-bottom: 2rem;
  color: var(--primary-light);
}

.features-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 1.5rem;
}

.feature-card {
  padding: 1.5rem;
  background: linear-gradient(135deg, 
    rgba(0, 0, 0, 0.4) 0%, 
    rgba(26, 26, 26, 0.2) 100%);
  border-radius: 15px;
  border: 1px solid rgba(164, 113, 72, 0.3);
  display: flex;
  align-items: flex-start;
  gap: 1rem;
  backdrop-filter: blur(10px);
  transition: all 0.3s ease;
  position: relative;
  overflow: hidden;
}

.feature-card::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 1px;
  background: linear-gradient(90deg, transparent, var(--primary-gold), transparent);
  opacity: 0;
  transition: opacity 0.3s ease;
}

.feature-card:hover {
  border-color: var(--primary-gold);
  transform: translateY(-2px);
  box-shadow: 0 8px 25px rgba(164, 113, 72, 0.2);
}

.feature-card:hover::before {
  opacity: 1;
}

.feature-card .material-icons {
  color: var(--primary-gold);
  font-size: 1.5rem;
  flex-shrink: 0;
}

.feature-card p {
  color: rgba(250, 250, 248, 0.8);
  line-height: 1.6;
  font-weight: 300;
  margin: 0;
}

.modal-cta {
  text-align: center;
  padding: 3rem;
  background: linear-gradient(135deg, 
    rgba(164, 113, 72, 0.1) 0%, 
    rgba(0, 0, 0, 0.2) 50%, 
    rgba(164, 113, 72, 0.05) 100%);
  border-radius: 20px;
  border: 1px solid rgba(164, 113, 72, 0.3);
  margin-top: 2rem;
  position: relative;
  overflow: hidden;
}

.modal-cta::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 2px;
  background: linear-gradient(90deg, transparent, var(--primary-gold), transparent);
}

.cta-highlight {
  margin-bottom: 2.5rem;
}

.cta-highlight h3 {
  font-size: 1.8rem;
  font-weight: 300;
  margin-bottom: 1rem;
  color: var(--primary-light);
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.cta-highlight p {
  font-size: 1.1rem;
  color: rgba(250, 250, 248, 0.7);
  font-style: italic;
  margin: 0;
}

.modal-buttons {
  display: flex;
  justify-content: center;
  gap: 1.5rem;
  flex-wrap: wrap;
}

.modal-btn {
  display: inline-flex;
  align-items: center;
  gap: 0.8rem;
  padding: 1.5rem 3rem;
  font-size: 1rem;
  font-weight: 600;
  letter-spacing: 0.05em;
  text-decoration: none;
  cursor: pointer;
  transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  border-radius: 50px;
  text-transform: uppercase;
  position: relative;
  overflow: hidden;
}

.modal-btn::before {
  content: '';
  position: absolute;
  top: 50%;
  left: 50%;
  width: 0;
  height: 0;
  background: rgba(255, 255, 255, 0.1);
  border-radius: 50%;
  transform: translate(-50%, -50%);
  transition: width 0.6s ease, height 0.6s ease;
}

.modal-btn:hover::before {
  width: 300px;
  height: 300px;
}

.modal-btn.primary {
  background: linear-gradient(135deg, var(--primary-gold) 0%, #ffd700 100%);
  color: var(--bg-dark);
  border: none;
  box-shadow: 
    0 8px 25px rgba(164, 113, 72, 0.4),
    0 0 20px rgba(255, 215, 0, 0.2);
  font-weight: 700;
}

.modal-btn.primary:hover {
  transform: translateY(-5px) scale(1.05);
  box-shadow: 
    0 15px 35px rgba(164, 113, 72, 0.6),
    0 0 30px rgba(255, 215, 0, 0.3);
  background: linear-gradient(135deg, #ffd700 0%, var(--primary-gold) 100%);
}

.modal-btn.primary .btn-icon {
  font-size: 1.2rem;
}

.modal-btn.secondary {
  background: rgba(0, 0, 0, 0.3);
  color: var(--primary-light);
  border: 2px solid rgba(164, 113, 72, 0.5);
  backdrop-filter: blur(10px);
}

.modal-btn.secondary:hover {
  background: rgba(164, 113, 72, 0.1);
  border-color: var(--primary-gold);
  color: var(--primary-gold);
  transform: translateY(-3px);
  box-shadow: 0 10px 25px rgba(164, 113, 72, 0.3);
}

/* Transitions */
.slide-fade-enter-active,
.slide-fade-leave-active {
  transition: all 0.5s ease;
}

.slide-fade-enter-from {
  transform: translateX(-30px);
  opacity: 0;
}

.slide-fade-leave-to {
  transform: translateX(30px);
  opacity: 0;
}

.modal-enter-active,
.modal-leave-active {
  transition: opacity 0.3s ease;
}

.modal-enter-from,
.modal-leave-to {
  opacity: 0;
}

/* Responsive Design */
@media (max-width: 1200px) {
  .story-grid {
    grid-template-columns: 1fr;
    gap: 4rem;
  }
  
  .showcase-main {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 768px) {
  .hero {
    height: 100vh; /* Ensure full height */
    display: flex;
    flex-direction: column;
    justify-content: center;
  }
  

  .hero-content {
    position: absolute;
    top: 30%; /* Adjusted for mobile */
    left: 5%;
    right: 5%;
    max-width: none;
    
  }

  .hero-title {
    font-size: clamp(2rem, 8vw, 3rem);
    text-align: center;
  }

  .hero-badge {
    margin-top: 1rem;
    margin-bottom: 1rem;
    padding: 0.75rem 2rem;
    font-size: 0.875rem;
  }

  .section-title {
    font-size: clamp(2rem, 5vw, 3rem);
    /* Ensure mobile titles are also visible */
    color: var(--primary-light);
    text-shadow: 
      0 0 15px rgba(250, 250, 248, 0.4),
      0 0 30px rgba(164, 113, 72, 0.3),
      1px 1px 3px rgba(0, 0, 0, 0.9);
  }
  
  .story-title .title-line-1 {
    font-size: clamp(2.5rem, 6vw, 4rem);
  }
  
  .story-title .title-line-2 {
    font-size: clamp(2rem, 5vw, 3rem);
    letter-spacing: 0.1em;
  }
  
  .cta-buttons {
    flex-direction: column;
    gap: 1rem;
  }
  
  .quick-contact {
    flex-direction: column;
    gap: 1rem;
    align-items: center;
    text-align: center;
  }
  
  .modal-body {
    padding: 2rem;
  }
  
  .modal-buttons {
    flex-direction: column;
  }

  /* Timeline adjustments for mobile */
  .timeline {
    padding-left: 2rem;
  }

  .timeline-step {
    grid-template-columns: 30px 1fr;
    gap: 1rem;
  }

  /* No need to adjust step-marker positioning since it now uses flexbox centering */
}

@media (max-width: 480px) {
  .hero-content {
    top: 25%;
    left: 1rem;
    right: 1rem;
  }

  .hero-subheading {
    bottom: 20%;
    left: 1rem;
    right: 1rem;
  }

  .hero-subheading p {
    padding: 0.75rem 1rem;
  }

  .about-page {
    padding-top: 60px;
  }
  
  .container {
    padding: 0 1rem;
  }
  
  .hero-title {
    font-size: 2rem;
  }
}
</style>

<!-- Loading states for ClientOnly components -->
<style scoped>
.slider-loading,
.map-loading {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 400px;
  color: var(--primary-light);
  opacity: 0.6;
}

.loading-spinner {
  width: 40px;
  height: 40px;
  border: 3px solid rgba(164, 113, 72, 0.3);
  border-top: 3px solid var(--primary-gold);
  border-radius: 50%;
  animation: spin 1s linear infinite;
  margin-bottom: 1rem;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}
</style>