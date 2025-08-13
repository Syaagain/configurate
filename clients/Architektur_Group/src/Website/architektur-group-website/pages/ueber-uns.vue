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
            <span class="hero-badge animate-fade-in">UNSERE GESCHICHTE</span>
            <h2 class="section-title story-title">
              <span class="gradient-text title-line-1" data-text="3 GENERATIONEN">3 GENERATIONEN</span>
              <span class="title-line-2" data-text="HANDWERKSKUNST">HANDWERKSKUNST</span>
            </h2>
            <p class="story-text">
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
    <section class="units-section">
      <div class="container">
        <div class="section-header">
          <span class="hero-badge animate-fade-in">UNTERNEHMENSGRUPPE</span>
          <h2 class="section-title" data-text="ALLES AUS EINER HAND">ALLES AUS EINER HAND</h2>
          <p class="section-subtitle">
            Unser Leistungsangebot für Neubauten und Generalsanierungen
          </p>
        </div>
        
        <LuxurySlider 
          :units="businessUnits"
          @unit-click="openUnitModal"
        />
      </div>
    </section>

    <!-- Showrooms Section -->
    <section class="showrooms-section">
      <div class="showroom-bg-pattern"></div>
      <div class="container">
        <div class="section-header">
          <span class="hero-badge animate-fade-in">SHOWROOMS</span>
          <h2 class="section-title" data-text="BESUCHEN SIE UNS">BESUCHEN SIE UNS</h2>
          <p class="section-subtitle">
            Über 2.500 verschiedene Natursteinsorten auf mehr als 2000m² Ausstellungsfläche
          </p>
        </div>
        
        <div class="showrooms-grid">
          <!-- München Showroom -->
          <div class="showroom-card munich" @mouseenter="playHoverSound">
            <div class="card-image">
              <img src="https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686576cf622e38e88f0236c5.png" alt="München">
              <div class="image-overlay"></div>
            </div>
            <div class="card-content">
              <div class="location-badge">
                <span class="material-icons">location_on</span>
                MÜNCHEN / STARNBERG
              </div>
              <h3>Showroom München</h3>
              <div class="showroom-info">
                <div class="info-item">
                  <span class="material-icons">square_foot</span>
                  <span>2500m² Showroomfläche</span>
                </div>
                <div class="info-item">
                  <span class="material-icons">home</span>
                  <span>Am Hohenrand 9, 82335 Berg</span>
                </div>
                <div class="info-item">
                  <span class="material-icons">phone</span>
                  <span>+49 8171 / 3868770</span>
                </div>
                <div class="info-item">
                  <span class="material-icons">schedule</span>
                  <span>Di-Fr: 9-17 Uhr, Sa: 9-16 Uhr</span>
                </div>
              </div>
              <div class="card-actions">
                <button @click="openMap('munich')" class="action-btn primary">
                  <span class="material-icons">map</span>
                  ROUTE PLANEN
                </button>
                <button @click="bookAppointment('munich')" class="action-btn secondary">
                  <span class="material-icons">calendar_today</span>
                  TERMIN BUCHEN
                </button>
              </div>
            </div>
          </div>
          
          <!-- Düsseldorf Showroom -->
          <div class="showroom-card dusseldorf" @mouseenter="playHoverSound">
            <div class="card-image">
              <img src="https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png" alt="Düsseldorf">
              <div class="image-overlay"></div>
            </div>
            <div class="card-content">
              <div class="location-badge">
                <span class="material-icons">location_on</span>
                DÜSSELDORF / NEUSS
              </div>
              <h3>Showroom Düsseldorf</h3>
              <div class="showroom-info">
                <div class="info-item">
                  <span class="material-icons">square_foot</span>
                  <span>Europas größte Auswahl</span>
                </div>
                <div class="info-item">
                  <span class="material-icons">inventory</span>
                  <span>80.000m² Lagerfläche</span>
                </div>
                <div class="info-item">
                  <span class="material-icons">phone</span>
                  <span>+49 2131 / 1234567</span>
                </div>
                <div class="info-item">
                  <span class="material-icons">schedule</span>
                  <span>Di-Fr: 9-17 Uhr, Sa: 9-16 Uhr</span>
                </div>
              </div>
              <div class="card-actions">
                <button @click="openMap('dusseldorf')" class="action-btn primary">
                  <span class="material-icons">map</span>
                  ROUTE PLANEN
                </button>
                <button @click="bookAppointment('dusseldorf')" class="action-btn secondary">
                  <span class="material-icons">calendar_today</span>
                  TERMIN BUCHEN
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Interactive Locations Map -->
    <section class="locations-section">
      <div class="container">
        <div class="section-header">
          <span class="hero-badge animate-fade-in">INTERNATIONAL</span>
          <h2 class="section-title" data-text="UNSERE STANDORTE">UNSERE STANDORTE</h2>
          <p class="section-subtitle">Präsenz in ganz Europa für beste Erreichbarkeit</p>
        </div>
        
        <div class="map-container">
          <!-- Google Maps Embed -->
          <div class="google-map">
            <iframe
              src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d5570665.339444434!2d5.866341973291837!3d50.503887287677804!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x479e75f9a38c5fd9%3A0x10cb84a7db1987d!2sMunich%2C%20Germany!5e0!3m2!1sen!2sus!4v1706285439215!5m2!1sen!2sus"
              width="100%"
              height="500"
              style="border:0; border-radius: 20px;"
              allowfullscreen=""
              loading="lazy"
              referrerpolicy="no-referrer-when-downgrade">
            </iframe>
            
            <!-- Custom Location Markers Overlay -->
            <div class="location-markers-overlay">
              <div 
                v-for="location in locations" 
                :key="location.id"
                class="custom-marker"
                :style="{ left: location.mapX + '%', top: location.mapY + '%' }"
                @click="selectLocation(location)"
                :class="{ active: selectedLocation?.id === location.id }"
              >
                <div class="marker-pulse"></div>
                <div class="marker-dot"></div>
                <div class="marker-label">{{ location.city }}</div>
              </div>
            </div>
          </div>
          
          <!-- Location Details -->
          <transition name="slide-fade">
            <div v-if="selectedLocation" class="location-details">
              <h3>{{ selectedLocation.city }}</h3>
              <p>{{ selectedLocation.country }}</p>
              <div class="detail-info">
                <span class="material-icons">{{ selectedLocation.icon }}</span>
                <span>{{ selectedLocation.type }}</span>
              </div>
              <p class="detail-description">{{ selectedLocation.description }}</p>
              <button @click="openGoogleMaps(selectedLocation)" class="location-btn">
                <span class="material-icons">directions</span>
                ROUTE PLANEN
              </button>
            </div>
          </transition>
        </div>
      </div>
    </section>


    <!-- Values Section -->
    <section class="values-section">
      <div class="container">
        <div class="section-header">
          <span class="hero-badge animate-fade-in">UNSERE WERTE</span>
          <h2 class="section-title" data-text="WAS UNS AUSZEICHNET">WAS UNS AUSZEICHNET</h2>
        </div>
        
        <div class="values-grid">
          <div 
            class="value-card" 
            v-for="(value, index) in companyValues" 
            :key="value.id"
            :style="{ animationDelay: `${index * 0.1}s` }"
          >
            <div class="value-icon">
              <span class="material-icons">{{ value.icon }}</span>
            </div>
            <h3>{{ value.title }}</h3>
            <p>{{ value.description }}</p>
            <div class="value-number">{{ String(index + 1).padStart(2, '0') }}</div>
          </div>
        </div>
      </div>
    </section>

    <!-- Team Section -->
    <section class="team-section">
      <div class="container">
        <div class="section-header">
          <span class="hero-badge animate-fade-in">UNSER TEAM</span>
          <h2 class="section-title" data-text="EXPERTEN MIT LEIDENSCHAFT">EXPERTEN MIT LEIDENSCHAFT</h2>
          <p class="section-subtitle">
            Speziell geschulte Innenarchitekten und Designer stehen Ihnen zur Seite
          </p>
        </div>
        
        <div class="team-showcase">
          <div class="showcase-main">
            <div class="main-image">
              <img src="https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686576cf622e38e88f0236c5.png" alt="Team">
              <div class="image-overlay"></div>
            </div>
            <div class="main-content">
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
          <div class="modal-body" v-if="selectedUnit">
            <div class="modal-header">
              <div class="modal-icon">
                <span class="material-icons">{{ selectedUnit.icon }}</span>
              </div>
              <h2>{{ selectedUnit.name }}</h2>
              <p class="modal-subtitle">{{ selectedUnit.description }}</p>
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
              <p>Interessiert an unseren {{ selectedUnit.name }} Services?</p>
              <div class="modal-buttons">
                <NuxtLink to="/kontakt" class="modal-btn primary">
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
import LuxurySlider from '~/components/LuxurySlider.vue'

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

// Refs for parallax
const heroBg = ref(null)
const heroContent = ref(null)
const heroSubheading = ref(null)
const ticking = ref(false)

// Hero Title Animation
const heroTitle = ['ARCHITEKTUR', 'GROUP']

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
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b70b0803723582ed6.png', // Added image
    description: 'Garten- und Landschaftsbau der Extraklasse',
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
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png', // Added image
    description: 'Komplettservice aus einer Hand',
    features: [
      'Projektleitung',
      'Innenarchitektur',
      'Schlüsselfertige Übergabe'
    ]
  }
]

// Locations with Google Maps positions
const locations = [
  {
    id: 1,
    city: 'München',
    country: 'Deutschland',
    x: 52,
    y: 48,
    mapX: 60,
    mapY: 55,
    type: 'Showroom & Hauptsitz',
    icon: 'business',
    description: '2500m² Showroom mit Europas größter Natursteinauswahl',
    address: 'Am Hohenrand 9, 82335 Berg'
  },
  {
    id: 2,
    city: 'Düsseldorf',
    country: 'Deutschland',
    x: 48,
    y: 42,
    mapX: 40,
    mapY: 40,
    type: 'Showroom & Lager',
    icon: 'warehouse',
    description: '80.000m² Lagerfläche für sofortige Verfügbarkeit',
    address: 'Düsseldorf, Deutschland'
  },
  {
    id: 3,
    city: 'Zürich',
    country: 'Schweiz',
    x: 50,
    y: 55,
    mapX: 55,
    mapY: 65,
    type: 'Vertriebsbüro',
    icon: 'store',
    description: 'Beratung und Vertrieb für die Schweiz',
    address: 'Zürich, Schweiz'
  },
  {
    id: 4,
    city: 'Côte d\'Azur',
    country: 'Frankreich',
    x: 45,
    y: 65,
    mapX: 45,
    mapY: 75,
    type: 'Partner Showroom',
    icon: 'handshake',
    description: 'Exklusive Präsenz an der französischen Riviera',
    address: 'Nice, Frankreich'
  },
  {
    id: 5,
    city: 'Bergamo',
    country: 'Italien',
    x: 55,
    y: 60,
    mapX: 58,
    mapY: 70,
    type: 'Produktionspartner',
    icon: 'factory',
    description: 'Direkte Zusammenarbeit mit italienischen Steinbrüchen',
    address: 'Bergamo, Italien'
  }
]


// Company Values
const companyValues = [
  {
    id: 1,
    icon: 'star',
    title: 'Exzellenz',
    description: 'Höchste Qualität in Material und Verarbeitung'
  },
  {
    id: 2,
    icon: 'handshake',
    title: 'Vertrauen',
    description: '67 Jahre Familientradition und Zuverlässigkeit'
  },
  {
    id: 3,
    icon: 'lightbulb',
    title: 'Innovation',
    description: 'Modernste Technologien und patentierte Verfahren'
  },
  {
    id: 4,
    icon: 'favorite',
    title: 'Leidenschaft',
    description: 'Begeisterung für außergewöhnliches Design'
  },
  {
    id: 5,
    icon: 'eco',
    title: 'Nachhaltigkeit',
    description: 'Verantwortungsvoller Umgang mit Ressourcen'
  },
  {
    id: 6,
    icon: 'group',
    title: 'Partnerschaft',
    description: 'Gemeinsam zu Ihrem Traumprojekt'
  }
]

// Update the handleScroll function
const handleScroll = () => {
  scrollY.value = window.scrollY
  
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

// Lifecycle
onMounted(() => {
  window.addEventListener('scroll', handleScroll, { passive: true })
  window.addEventListener('scroll', requestTick, { passive: true })
  updateParallax()
  
  // Auto-rotate business units
  const interval = setInterval(() => {
    nextUnit()
  }, 5000)

  return () => {
    clearInterval(interval)
    window.removeEventListener('scroll', handleScroll)
    window.removeEventListener('scroll', requestTick)
  }
})

onUnmounted(() => {
  document.body.style.overflow = 'auto'
})

function updateParallax() {
  if (!heroBg.value || !heroContent.value || !heroSubheading.value) return

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

/* Removed duplicate styles for .hero-badge */
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
  animation: badgePulse 3s infinite;
  transition: all 0.4s ease;
}

@keyframes badgePulse {
  0%, 100% { 
    box-shadow: 
      0 0 20px rgba(164, 113, 72, 0.5),
      inset 0 0 20px rgba(164, 113, 72, 0.1);
    transform: scale(1);
  }
  50% { 
    box-shadow: 
      0 0 40px rgba(164, 113, 72, 0.8),
      inset 0 0 30px rgba(164, 113, 72, 0.2);
    transform: scale(1.05);
  }
}

.hero-badge::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(164, 113, 72, 0.5), transparent);
  animation: sweep 3s infinite;
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
  background: linear-gradient(135deg, #FAFAF8 0%, #a47148 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
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

/* Mobile Responsive */
@media (max-width: 768px) {
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
  
  .galabau-title {
    font-size: clamp(2rem, 5vw, 3.5rem) !important;
  }
  
  .cta-title {
    font-size: clamp(2.5rem, 6vw, 4rem) !important;
  }
  
  .cta-title .gradient-text {
    font-size: clamp(3rem, 7vw, 5rem);
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

/* Timeline */
.timeline {
  position: relative;
  padding-left: 3rem;
  margin-top: 4rem;
  padding-bottom: 2rem;
}

.timeline-line {
  position: absolute;
  left: 68px;
  width: 2px;
  background: rgba(255, 255, 255, 0.1);
  z-index: 0;
  transform: translateX(-50%);
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
  width: 20px;
  height: 20px;
  margin-top: 8px;
  transform: translateX(10px); /* Center dot on line */
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
  inset: -10px;
  border: 2px solid var(--primary-gold);
  border-radius: 50%;
  animation: pulse 2s infinite;
  z-index: 2;
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
  min-height: 100vh;
  padding: 6rem 0;
  padding-bottom: calc(90vh + 6rem);
  background: #000; /* Changed from gradient to solid black */
  position: relative; /* Added to create new stacking context */
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

/* Locations Section - Updated */
.locations-section {
  padding: 6rem 0;
  background: linear-gradient(135deg, #1a1a1a 0%, #0a0a0a 100%);
}

.map-container {
  margin-top:  4rem;
  position: relative;
}

.google-map {
  position: relative;
  width: 100%;
  max-width: 1200px;
  margin: 0; /* Changed from margin: 0 auto */
  border-radius: 20px;
  overflow: hidden;
  border: 2px solid var(--border-color);
}

.google-map iframe {
  width: 100%;
  height: 500px;
  filter: grayscale(50%) contrast(1.1);
  transition: filter 0.3s ease;
}

.google-map:hover iframe {
  filter: grayscale(0%) contrast(1);
}

.location-markers-overlay {
  position: absolute;
  inset: 0;
  pointer-events: none;
}

.custom-marker {
  position: absolute;
  cursor: pointer;
  pointer-events: all;
  transition: all 0.3s ease;
}

.custom-marker .marker-dot {
  width: 20px;
  height: 20px;
  background: var(--primary-gold);
  border-radius: 50%;
  border: 3px solid var(--bg-dark);
  position: relative;
  z-index: 2;
  box-shadow: 0 0 20px rgba(164, 113, 72, 0.5);
}

.custom-marker .marker-pulse {
  position: absolute;
   inset: -15px;
  border: 2px solid var(--primary-gold);
  border-radius: 50%;
  animation: markerPulse 2s infinite;
}

@keyframes markerPulse {
  0% {
    transform: scale(1);
    opacity: 1;
  }
  100% {
    transform: scale(2.5);
    opacity: 0;
  }
}

.custom-marker .marker-label {
  position: absolute;
  bottom: 30px;
  left: 50%;
  transform: translateX(-50%);
  background: var(--bg-dark);
  padding: 0.5rem 1rem;
  border-radius: 8px;
  font-size: 0.875rem;
  white-space: nowrap;
  opacity: 0;
  transition: opacity 0.3s ease;
  border: 1px solid var(--primary-gold);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.5);
}

.custom-marker:hover .marker-label,
.custom-marker.active .marker-label {
  opacity: 1;
}

.custom-marker.active .marker-dot {
  background: var(--primary-light);
  transform: scale(1.5);
  box-shadow: 0 0 30px rgba(250, 250, 248, 0.8);
}

.location-details {
  margin-top: 3rem;
 
  padding: 2.5rem;
  background: linear-gradient(135deg, rgba(164, 113, 72, 0.1) 0%, rgba(255, 255, 255, 0.03) 100%);
  border-radius: 20px;
  border: 1px solid var(--border-color);
  max-width: 600px;
  margin-left: auto;
  margin-right: auto;
}

.location-details h3 {
  font-size: 2rem;
  margin-bottom: 0.5rem;
  color: var(--primary-light);
}

.location-details p {
  color: #999;
  margin-bottom: 1rem;
}

.detail-info {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 1rem;
  background: rgba(164, 113, 72, 0.1);
  border-radius: 10px;
  margin-bottom: 1.5rem;
}

.detail-info .material-icons {
  color: var(--primary-gold);
  font-size: 1.5rem;
}

.detail-description {
  color: #ccc;
  line-height: 1.6;
  margin-bottom: 1.5rem;
}

.location-btn {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  padding: 1rem 2rem;
  background: linear-gradient(135deg, var(--primary-gold), var(--primary-light));
  color: var(--bg-dark);
  border: none;
  border-radius: 50px;
  font-size: 0.95rem;
  font-weight: 600;
  letter-spacing: 0.05em;
  cursor: pointer;
  transition: all 0.3s ease;
}

.location-btn:hover {
  transform: translateY(-3px);
  box-shadow: 0 15px 30px rgba(164, 113, 72, 0.4);
}


/* Values Section */
.values-section {
  padding: 6rem 0;
  background: linear-gradient(135deg, #0a0a0a 0%, #1a1a1a 100%);
}

.values-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
  margin-top: 4rem;
}

.value-card {
  position: relative;
  padding: 3rem 2rem;
  background: rgba(255, 255, 255, 0.03);
  border-radius: 20px;
  border: 1px solid var(--border-color);
  text-align: center;
  transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  animation: valueCardIn 0.8s ease-out backwards;
  overflow: hidden;
}

@keyframes valueCardIn {
  from {
    opacity: 0;
    transform: translateY(50px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.value-card:hover {
  transform: translateY(-10px);
  background: rgba(255, 255, 255, 0.05);
  box-shadow: 0 30px 60px rgba(164, 113, 72, 0.3);
}

.value-icon {
  width: 80px;
  height: 80px;
  margin: 0 auto 1.5rem;
  background: rgba(164, 113, 72, 0.1);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.3s ease;
}

.value-icon .material-icons {
  font-size: 2.5rem;
  color: var(--primary-gold);
  transition: all 0.3s ease;
}

.value-icon.hovered {
  background: linear-gradient(135deg, var(--primary-gold), var(--primary-light));
  transform: rotateY(180deg);
}

.value-icon.hovered .material-icons {
  color: var(--bg-dark);
}

.value-card h3 {
  font-size:  1.5rem;
  margin-bottom: 1rem;
  color: var(--primary-light);
}

.value-card p {
  color: #ccc;
  line-height: 1.6;
}

.value-number {
  position: absolute;
  top: 1rem;
  right: 1rem;
  font-size: 3rem;
  font-weight: 700;
  color: rgba(164, 113, 72, 0.1);
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
  background: linear-gradient(135deg, #1a1a1a 0%, #0a0a0a 100%);
  border-radius: 20px;
  border: 1px solid var(--border-color);
  animation: modalIn 0.4s ease-out;
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
  background: rgba(255, 255, 255, 0.1);
  border: none;
  border-radius: 50%;
  color: var(--primary-light);
  cursor: pointer;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  justify-content: center;
}

.modal-close:hover {
  background: rgba(255, 255, 255, 0.2);
  transform: rotate(90deg);
}

.modal-body {
  padding: 4rem;
}

.modal-header {
  text-align: center;
  margin-bottom: 3rem;
}

.modal-header .modal-icon {
  width: 100px;
  height: 100px;
  margin: 0 auto 2rem;
  background: linear-gradient(135deg, var(--primary-gold), var(--primary-light));
  border-radius: 25px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 3rem;
  color: var(--bg-dark);
}

.modal-header h2 {
  font-size: 2.5rem;
  font-weight: 300;
  margin-bottom: 1rem;
  color: var(--primary-light);
}

.modal-subtitle {
  font-size: 1.2rem;
  color: #ccc;
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
  background: rgba(255, 255, 255, 0.03);
  border-radius: 15px;
  border: 1px solid var(--border-color);
  display: flex;
  align-items: flex-start;
  gap: 1rem;
}

.feature-card .material-icons {
  color: var(--primary-gold);
  font-size: 1.5rem;
  flex-shrink: 0;
}

.feature-card p {
  color: #ccc;
  line-height: 1.6;
}

.modal-cta {
  text-align: center;
  padding: 2rem;
  background: rgba(164, 113, 72, 0.05);
  border-radius: 15px;
}

.modal-cta p {
  font-size: 1.2rem;
  color: #ccc;
  margin-bottom: 2rem;
}

.modal-buttons {
  display: flex;
  justify-content: center;
  gap: 1rem;
}

.modal-btn {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  padding: 1rem 2rem;
  font-size: 0.95rem;
  font-weight: 500;
  letter-spacing: 0.05em;
  text-decoration: none;
  cursor: pointer;
  transition: all 0.3s ease;
  border-radius: 50px;
}

.modal-btn.primary {
  background: linear-gradient(135deg, var(--primary-gold), var(--primary-light));
  color: var(--bg-dark);
}

.modal-btn.secondary {
  background: transparent;
  color: var(--primary-light);
  border: 2px solid var(--primary-light);
}

.modal-btn:hover {
  transform: translateY(-3px);
  box-shadow: 0 15px 30px rgba(164, 113, 72, 0.3);
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
  
  .stats-cards {
    gap: 1.5rem;
  }
  
  .galabau-content {
    grid-template-columns: 1fr;
  }
  
  .showcase-main {
    grid-template-columns: 1fr;
  }
  
  .google-map iframe {
    height: 400px;
  }
}

@media (max-width: 768px) {
  .hero-title {
    font-size: 3rem;
    flex-direction: column;
    gap: 0.5rem;
  }
  
  .section-title {
    font-size: 2rem;
  }
  
  .showrooms-grid {
    grid-template-columns: 1fr;
  }
  
  .values-grid {
    grid-template-columns: 1fr;
  }
  
  .cta-buttons {
    flex-direction: column;
  }
  
  .quick-contact {
    flex-direction: column;
    gap: 1rem;
  }
  
  .carousel-nav {
    flex-wrap: wrap;
  }
  
  .modal-body {
    padding: 2rem;
  }
  
  .modal-buttons {
    flex-direction: column;
  }
  
  .google-map iframe {
    height: 350px;
  }
  
  .location-markers-overlay {
    display: none; /* Hide custom markers on mobile for better UX */
  }
}

@media (max-width: 480px) {
  .about-page {
    padding-top: 60px;
  }
  
  .hero-section {
    min-height: calc(100vh - 60px);
  }
  
  .container {
    padding: 0 1rem;
  }
  
  .hero-title {
    font-size: 2.5rem;
  }
  
  .stats-cards {
    gap: 1rem;
  }
  
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
  
  .google-map iframe {
    height: 300px;
  }
}
</style>