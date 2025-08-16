<template>
  <section class="locations-section">
    <div class="container">
      <!-- Enhanced Hero Section -->
      <div class="hero-section">
        <div class="hero-background">
          <div class="floating-shapes">
            <div v-for="n in 8" :key="n" class="shape" :style="getShapeStyle(n)"></div>
          </div>
          <div class="gradient-orbs">
            <div class="orb orb-1"></div>
            <div class="orb orb-2"></div>
            <div class="orb orb-3"></div>
          </div>
        </div>
        
        <!-- Header Content -->
        <div class="hero-content">
          <div class="section-badge-container">
            <div class="badge-glow"></div>
            <div class="section-badge premium">
              <span class="material-icons">public</span>
              <span class="badge-text">INTERNATIONAL PRÄSENT</span>
              <div class="badge-pulse"></div>
            </div>
          </div>
          
          <p class="hero-subtitle">
            Besuchen Sie uns in einem unserer exklusiven Showrooms und erleben Sie 
            die Welt der Premium-Natursteine hautnah
          </p>
        </div>
      </div>

      <!-- Interactive Selection Guide -->
      <div class="selection-guide">
        <div class="guide-container">
          <!-- Step Indicators -->
          <div class="steps-container">
            <div class="step-indicator">
              <div class="step-number">1</div>
              <div class="step-content">
                <h3>Standort wählen</h3>
                <p>Klicken Sie auf einen Marker</p>
              </div>
            </div>
            
            <div class="step-connector">
              <div class="connector-line"></div>
              <div class="connector-arrow">
                <span class="material-icons">arrow_forward</span>
              </div>
            </div>
            
            <div class="step-indicator">
              <div class="step-number">2</div>
              <div class="step-content">
                <h3>Details ansehen</h3>
                <p>Informationen zum Showroom</p>
              </div>
            </div>
            
            <div class="step-connector">
              <div class="connector-line"></div>
              <div class="connector-arrow">
                <span class="material-icons">arrow_forward</span>
              </div>
            </div>
            
            <div class="step-indicator">
              <div class="step-number">3</div>
              <div class="step-content">
                <h3>Termin buchen</h3>
                <p>Direkt kontaktieren</p>
              </div>
            </div>
          </div>
        </div>
      </div>
      
      <!-- Map Container -->
      <div class="map-wrapper">
        <div class="map-container">
          <!-- Map Header -->
          <div class="map-header">
            <div class="map-title">
              <span class="material-icons">map</span>
              <h3>Klicken Sie auf einen Standort</h3>
            </div>
            <div class="map-status">
              <div class="status-dot"></div>
              <span>{{ locations.length }} Standorte verfügbar</span>
            </div>
          </div>
          
          <!-- OpenStreetMap Container -->
          <div id="osm-map" class="osm-map"></div>
          
          <!-- Loading Overlay -->
          <div v-if="mapLoading" class="map-loading">
            <div class="loading-container">
              <div class="loading-spinner"></div>
              <h3>Standorte werden geladen</h3>
              <p>Einen Moment bitte...</p>
            </div>
          </div>
          
          <!-- Map Instructions -->
          <div class="map-instructions">
            <div class="instruction-tooltip">
              <div class="tooltip-content">
                <span class="material-icons">touch_app</span>
                <span>Standort für Details anklicken</span>
              </div>
              <div class="tooltip-arrow"></div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Enhanced Location Modal -->
    <Transition name="modal-fade">
      <div v-if="selectedLocation" class="modal-overlay" @click="closeLocationModal">
        <!-- Animated Background -->
        <div class="modal-background">
          <div class="bg-gradient-1"></div>
          <div class="bg-gradient-2"></div>
          <div class="floating-particles">
            <div v-for="n in 15" :key="n" class="particle" :style="getParticleStyle(n)"></div>
          </div>
        </div>

        <!-- Modal Content -->
        <div class="modal-container" @click.stop>
          <div class="modal-card">
            <!-- Header with Close Button -->
            <div class="modal-header">
              <div class="location-type-badge">
                <span class="material-icons">{{ selectedLocation.icon }}</span>
                <span>{{ selectedLocation.type }}</span>
              </div>
              <button class="close-button" @click="closeLocationModal">
                <span class="material-icons">close</span>
              </button>
            </div>

            <!-- Hero Section -->
            <div class="modal-hero">
              <div class="location-icon-display">
                <div class="icon-backdrop">
                  <div class="rotating-ring ring-1"></div>
                  <div class="rotating-ring ring-2"></div>
                  <div class="rotating-ring ring-3"></div>
                </div>
                <div class="main-icon">
                  <span class="material-icons">{{ selectedLocation.icon }}</span>
                </div>
              </div>
              
              <div class="location-title-section">
                <h1 class="location-name">{{ selectedLocation.city }}</h1>
                <p class="location-country">{{ selectedLocation.country }}</p>
              </div>
            </div>

            <!-- Content Grid -->
            <div class="modal-content">
              <!-- Description Card -->
              <div class="info-card description-card">
                <div class="card-header">
                  <span class="material-icons">info</span>
                  <h3>Über diesen Standort</h3>
                </div>
                <p class="description-text">{{ selectedLocation.description }}</p>
              </div>

              <!-- Details Grid -->
              <div class="details-grid">
                <div class="detail-item">
                  <div class="detail-icon">
                    <span class="material-icons">place</span>
                  </div>
                  <div class="detail-content">
                    <h4>Adresse</h4>
                    <p>{{ selectedLocation.address }}</p>
                  </div>
                </div>
                
                <div class="detail-item">
                  <div class="detail-icon">
                    <span class="material-icons">business_center</span>
                  </div>
                  <div class="detail-content">
                    <h4>Standort-Typ</h4>
                    <p>{{ selectedLocation.type }}</p>
                  </div>
                </div>

                <div class="detail-item">
                  <div class="detail-icon">
                    <span class="material-icons">schedule</span>
                  </div>
                  <div class="detail-content">
                    <h4>Verfügbarkeit</h4>
                    <p>Mo-Fr: 8:00-18:00 Uhr</p>
                  </div>
                </div>

                <div class="detail-item">
                  <div class="detail-icon">
                    <span class="material-icons">phone</span>
                  </div>
                  <div class="detail-content">
                    <h4>Kontakt</h4>
                    <p>+49 (0) 8171 99 87 0</p>
                  </div>
                </div>
              </div>
            </div>

            <!-- Action Footer -->
            <div class="modal-footer">
              <div class="action-buttons">
                <NuxtLink 
                  to="/kontakt" 
                  class="action-btn primary cta-button"
                  @click="closeLocationModal"
                >
                  <span class="material-icons">rocket_launch</span>
                  Jetzt Termin vereinbaren
                  <div class="btn-shine"></div>
                </NuxtLink>
              </div>
            </div>
          </div>
        </div>
      </div>
    </Transition>
  </section>
</template>

<script setup>
import { ref, onMounted, onUnmounted, computed } from 'vue'

// State
const selectedLocation = ref(null)
const mapLoading = ref(true)
let map = null
let markers = []

// Locations data
const locations = [
  {
    id: 1,
    city: 'München',
    country: 'Deutschland',
    lat: 47.9065, 
    lng: 11.5528,
    type: 'Showroom & Hauptsitz',
    icon: 'business',
    description: '2500m² Showroom mit Europas größter Natursteinauswahl. Hier finden Sie unsere komplette Kollektion und erhalten professionelle Beratung von unseren Experten.',
    address: 'Am Hohenrand 9, 82335 Berg'
  },
  {
    id: 2,
    city: 'Düsseldorf',
    country: 'Deutschland',
    lat: 51.2217,
    lng: 6.7762,
    type: 'Showroom & Lager',
    icon: 'warehouse',
    description: '80.000m² Lagerfläche für sofortige Verfügbarkeit. Unser Logistikzentrum für den deutschen Markt mit über 1000 verschiedenen Natursteinarten.',
    address: 'Osterather Str. 6 i, 41460 Neuss'
  },
  {
    id: 3,
    city: 'Zürich',
    country: 'Schweiz',
    lat: 47.3769,
    lng: 8.5417,
    type: 'Vertriebsbüro',
    icon: 'store',
    description: 'Beratung und Vertrieb für die Schweiz. Ihr kompetenter Ansprechpartner für Premium-Natursteine mit persönlicher Betreuung.',
    address: 'Bahnhofstrasse 120, 8001 Zürich'
  },
  {
    id: 4,
    city: 'Côte d\'Azur',
    country: 'Frankreich',
    lat: 43.7102,
    lng: 7.2620,
    type: 'Partner Showroom',
    icon: 'handshake',
    description: 'Exklusive Präsenz an der französischen Riviera. Spezialisiert auf Luxus-Projekte und hochwertige Natursteinarbeiten.',
    address: 'Promenade des Anglais 200, 06000 Nice'
  },
  {
    id: 5,
    city: 'Bergamo',
    country: 'Italien',
    lat: 45.6983,
    lng: 9.6773,
    type: 'Produktionspartner',
    icon: 'factory',
    description: 'Direkte Zusammenarbeit mit italienischen Steinbrüchen. Qualitätskontrolle vor Ort und exklusive Materialauswahl.',
    address: 'Via Roma 45, 24121 Bergamo'
  }
]

// Computed properties
const getParticleStyle = (index) => {
  return {
    '--delay': `${index * 0.2}s`,
    '--duration': `${4 + (index % 3)}s`,
    '--x': `${Math.random() * 100}%`,
    '--y': `${Math.random() * 100}%`
  }
}

const getShapeStyle = (index) => {
  return {
    '--delay': `${index * 0.5}s`,
    '--duration': `${8 + (index % 4)}s`,
    '--size': `${20 + (index % 3) * 10}px`,
    '--x': `${Math.random() * 100}%`,
    '--y': `${Math.random() * 100}%`
  }
}

// Map functions
const initMap = () => {
  // Create map with disabled zoom and interactions - only allow viewing
  map = L.map('osm-map', {
    zoomControl: false,
    attributionControl: false,
    scrollWheelZoom: false,
    doubleClickZoom: false,
    boxZoom: false,
    keyboard: false,
    dragging: false,
    touchZoom: false,
    zoomSnap: 0,
    zoomDelta: 0
  })

  // Add dark tile layer
  L.tileLayer('https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png', {
    attribution: '© OpenStreetMap contributors © CARTO',
    subdomains: 'abcd',
    maxZoom: 19
  }).addTo(map)

  // Add markers and fit bounds optimally
  addMarkers()
  fitMapToMarkersOptimal()
  mapLoading.value = false
}

const addMarkers = () => {
  markers = locations.map(location => {
    const customIcon = L.divIcon({
      className: 'custom-leaflet-marker',
      html: `
        <div class="marker-container">
          <div class="marker-dot"></div>
          <div class="marker-pulse"></div>
          <div class="marker-label">${location.city}</div>
        </div>
      `,
      iconSize: [40, 40],
      iconAnchor: [20, 20]
    })

    const marker = L.marker([location.lat, location.lng], {
      icon: customIcon
    }).addTo(map)

    marker.on('click', () => {
      openLocationModal(location)
      markers.forEach(m => {
        m.getElement()?.classList.remove('active')
      })
      marker.getElement()?.classList.add('active')
    })

    return marker
  })
}

const fitMapToMarkersOptimal = () => {
  if (markers.length > 0) {
    const group = new L.featureGroup(markers)
    map.fitBounds(group.getBounds().pad(0.15), {
      maxZoom: 5,
      animate: false
    })
    
    map.setMaxZoom(map.getZoom())
    map.setMinZoom(map.getZoom())
  }
}

const loadLeaflet = () => {
  if (window.L) {
    initMap()
    return
  }

  const cssLink = document.createElement('link')
  cssLink.rel = 'stylesheet'
  cssLink.href = 'https://unpkg.com/leaflet@1.9.4/dist/leaflet.css'
  document.head.appendChild(cssLink)

  const script = document.createElement('script')
  script.src = 'https://unpkg.com/leaflet@1.9.4/dist/leaflet.js'
  script.onload = initMap
  document.head.appendChild(script)
}

// Modal functions
const openLocationModal = (location) => {
  selectedLocation.value = location
  document.body.style.overflow = 'hidden'
}

const closeLocationModal = () => {
  selectedLocation.value = null
  document.body.style.overflow = 'auto'
  if (markers.length) {
    markers.forEach(marker => {
      marker.getElement()?.classList.remove('active')
    })
  }
}

// Lifecycle
onMounted(() => {
  loadLeaflet()
})

onUnmounted(() => {
  document.body.style.overflow = 'auto'
})
</script>

<style scoped>
@import url('https://fonts.googleapis.com/icon?family=Material+Icons');

/* CSS Variables */
:root {
  --primary-gold: #a47148;
  --primary-light: #FAFAF8;
  --bg-dark: #000;
  --text-gray: #999;
  --text-light: #ccc;
  --border-color: rgba(255, 255, 255, 0.1);
  --glass-bg: rgba(255, 255, 255, 0.05);
  --glass-border: rgba(255, 255, 255, 0.1);
  --backdrop-blur: blur(20px);
}

/* Container */
.container {
  max-width: 1400px;
  margin: 0 auto;
  padding: 0 2rem;
  position: relative;
  z-index: 2;
}

/* Locations Section */
.locations-section {
  padding: 6rem 0;
  background: linear-gradient(135deg, #1a1a1a 0%, #0a0a0a 100%);
  position: relative;
  overflow: hidden;
}

/* Enhanced Hero Section */
.hero-section {
  position: relative;
  text-align: center;
  padding: 4rem 0 6rem;
  overflow: hidden;
}

.hero-background {
  position: absolute;
  inset: 0;
  overflow: hidden;
}

.floating-shapes {
  position: absolute;
  inset: 0;
}

.shape {
  position: absolute;
  width: var(--size);
  height: var(--size);
  background: linear-gradient(45deg, rgba(164, 113, 72, 0.1), rgba(255, 255, 255, 0.05));
  border: 1px solid rgba(164, 113, 72, 0.2);
  border-radius: 50%;
  top: var(--y);
  left: var(--x);
  animation: shapeFloat var(--duration) ease-in-out infinite var(--delay);
}

@keyframes shapeFloat {
  0%, 100% {
    transform: translateY(0) rotate(0deg) scale(1);
    opacity: 0.3;
  }
  50% {
    transform: translateY(-30px) rotate(180deg) scale(1.1);
    opacity: 0.6;
  }
}

.gradient-orbs {
  position: absolute;
  inset: 0;
}

.orb {
  position: absolute;
  border-radius: 50%;
  filter: blur(60px);
  animation: orbFloat 15s ease-in-out infinite;
}

.orb-1 {
  width: 300px;
  height: 300px;
  background: radial-gradient(circle, rgba(164, 113, 72, 0.3) 0%, transparent 70%);
  top: 10%;
  left: 10%;
  animation-delay: 0s;
}

.orb-2 {
  width: 200px;
  height: 200px;
  background: radial-gradient(circle, rgba(255, 215, 0, 0.2) 0%, transparent 70%);
  top: 60%;
  right: 20%;
  animation-delay: 5s;
}

.orb-3 {
  width: 150px;
  height: 150px;
  background: radial-gradient(circle, rgba(164, 113, 72, 0.25) 0%, transparent 70%);
  bottom: 20%;
  left: 60%;
  animation-delay: 10s;
}

@keyframes orbFloat {
  0%, 100% { transform: translate(0, 0) scale(1); }
  33% { transform: translate(30px, -20px) scale(1.1); }
  66% { transform: translate(-20px, 30px) scale(0.9); }
}

.hero-content {
  position: relative;
  z-index: 10;
}

.section-badge-container {
  position: relative;
  margin-bottom: 3rem;
  display: flex;
  justify-content: center;
}

.badge-glow {
  position: absolute;
  inset: -20px;
  background: radial-gradient(circle, rgba(164, 113, 72, 0.4) 0%, transparent 70%);
  border-radius: 50px;
  animation: glowPulse 4s ease-in-out infinite;
}

@keyframes glowPulse {
  0%, 100% { opacity: 0.3; transform: scale(1); }
  50% { opacity: 0.6; transform: scale(1.1); }
}

.section-badge.premium {
  position: relative;
  display: flex;
  align-items: center;
  gap: 0.75rem;
  padding: 1rem 2rem;
  background: linear-gradient(135deg, 
    rgba(164, 113, 72, 0.25), 
    rgba(255, 255, 255, 0.08), 
    rgba(164, 113, 72, 0.15));
  border: 2px solid rgba(164, 113, 72, 0.4);
  border-radius: 50px;
  backdrop-filter: var(--backdrop-blur);
  font-size: 0.9rem;
  letter-spacing: 0.1em;
  font-weight: 700;
  color: var(--primary-gold);
  text-transform: uppercase;
  box-shadow: 
    0 10px 30px rgba(164, 113, 72, 0.3),
    inset 0 1px 0 rgba(255, 255, 255, 0.2);
  animation: badgeHover 6s ease-in-out infinite;
}

@keyframes badgeHover {
  0%, 100% { transform: translateY(0px); }
  50% { transform: translateY(-5px); }
}

.badge-text {
  position: relative;
  z-index: 2;
}

.badge-pulse {
  position: absolute;
  inset: 0;
  border: 2px solid rgba(164, 113, 72, 0.6);
  border-radius: 50px;
  animation: badgePulse 3s ease-in-out infinite;
}

@keyframes badgePulse {
  0% { transform: scale(1); opacity: 1; }
  100% { transform: scale(1.2); opacity: 0; }
}

.hero-title {
  font-size: 4rem;
  font-weight: 300;
  margin-bottom: 2rem;
  line-height: 1.1;
}

.title-line-1 {
  display: block;
  color: var(--text-light);
  font-size: 0.7em;
  letter-spacing: 0.2em;
  margin-bottom: 0.5rem;
  opacity: 0.8;
  animation: titleSlideIn 1s ease-out 0.2s both;
}

.title-line-2 {
  display: block;
  position: relative;
  animation: titleSlideIn 1s ease-out 0.4s both;
}

@keyframes titleSlideIn {
  from {
    opacity: 0;
    transform: translateY(30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.title-gradient {
  background: linear-gradient(135deg, 
    var(--primary-light) 0%, 
    var(--primary-gold) 30%, 
    #d4af37 70%, 
    var(--primary-light) 100%);
  background-size: 300% 100%;
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  animation: titleShimmer 6s ease-in-out infinite;
  position: relative;
}

@keyframes titleShimmer {
  0%, 100% { background-position: 300% 0; }
  50% { background-position: -300% 0; }
}

.title-underline {
  position: absolute;
  bottom: -10px;
  left: 50%;
  transform: translateX(-50%);
  width: 0;
  height: 3px;
  background: linear-gradient(90deg, transparent, var(--primary-gold), transparent);
  animation: underlineGrow 2s ease-out 1s both;
}

@keyframes underlineGrow {
  to { width: 100%; }
}

.hero-subtitle {
  font-size: 1.25rem;
  color: var(--text-light);
  max-width: 600px;
  margin: 0 auto;
  line-height: 1.6;
  opacity: 0.9;
  animation: subtitleFadeIn 1s ease-out 0.8s both;
}

@keyframes subtitleFadeIn {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 0.9;
    transform: translateY(0);
  }
}

/* Interactive Selection Guide */
.selection-guide {
  margin-bottom: 4rem;
  padding: 3rem 0;
  position: relative;
}

.guide-container {
  display: flex;
  justify-content: center;
}

.steps-container {
  display: flex;
  align-items: center;
  gap: 2rem;
  padding: 2rem;
  background: linear-gradient(135deg, 
    rgba(255, 255, 255, 0.05) 0%,
    rgba(164, 113, 72, 0.1) 50%,
    rgba(255, 255, 255, 0.03) 100%);
  border: 1px solid rgba(164, 113, 72, 0.2);
  border-radius: 20px;
  backdrop-filter: var(--backdrop-blur);
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
}

.step-indicator {
  display: flex;
  align-items: center;
  gap: 1rem;
  text-align: left;
}

.step-number {
  width: 50px;
  height: 50px;
  background: linear-gradient(135deg, var(--primary-gold), #d4af37);
  color: var(--bg-dark);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.25rem;
  font-weight: bold;
  flex-shrink: 0;
  box-shadow: 0 5px 15px rgba(164, 113, 72, 0.4);
  animation: stepPulse 3s ease-in-out infinite;
}

@keyframes stepPulse {
  0%, 100% { transform: scale(1); }
  50% { transform: scale(1.05); }
}

.step-content h3 {
  color: var(--primary-light);
  font-size: 1rem;
  font-weight: 600;
  margin: 0 0 0.25rem 0;
}

.step-content p {
  color: var(--text-gray);
  font-size: 0.875rem;
  margin: 0;
}

.step-connector {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  color: var(--primary-gold);
}

.connector-line {
  width: 30px;
  height: 2px;
  background: linear-gradient(90deg, var(--primary-gold), rgba(164, 113, 72, 0.3));
}

.connector-arrow {
  animation: arrowBounce 2s ease-in-out infinite;
}

@keyframes arrowBounce {
  0%, 100% { transform: translateX(0); }
  50% { transform: translateX(5px); }
}

/* Enhanced CTA Section */
.cta-section {
  margin-bottom: 4rem;
  position: relative;
}

.cta-container {
  position: relative;
  overflow: hidden;
  border-radius: 24px;
}

.cta-background {
  position: absolute;
  inset: 0;
  background: linear-gradient(135deg, 
    rgba(164, 113, 72, 0.15) 0%,
    rgba(255, 255, 255, 0.05) 50%,
    rgba(164, 113, 72, 0.1) 100%);
  border: 1px solid rgba(164, 113, 72, 0.3);
  border-radius: 24px;
  backdrop-filter: var(--backdrop-blur);
}

.cta-pattern {
  position: absolute;
  inset: 0;
  background-image: 
    radial-gradient(circle at 20% 20%, rgba(164, 113, 72, 0.1) 0%, transparent 50%),
    radial-gradient(circle at 80% 80%, rgba(255, 215, 0, 0.08) 0%, transparent 50%),
    radial-gradient(circle at 40% 60%, rgba(164, 113, 72, 0.06) 0%, transparent 50%);
  animation: patternShift 20s ease-in-out infinite;
}

@keyframes patternShift {
  0%, 100% { transform: translateX(0) translateY(0); }
  50% { transform: translateX(20px) translateY(-20px); }
}

.cta-glow {
  position: absolute;
  inset: -2px;
  background: linear-gradient(135deg, 
    rgba(164, 113, 72, 0.3), 
    rgba(255, 255, 255, 0.1), 
    rgba(164, 113, 72, 0.2));
  border-radius: 26px;
  z-index: -1;
  animation: ctaGlow 4s ease-in-out infinite;
}

@keyframes ctaGlow {
  0%, 100% { opacity: 0.5; }
  50% { opacity: 0.8; }
}

.cta-content {
  position: relative;
  z-index: 2;
  padding: 3rem;
  display: flex;
  align-items: center;
  gap: 3rem;
}

.cta-icon-section {
  position: relative;
  flex-shrink: 0;
}

.icon-stack {
  position: relative;
  width: 120px;
  height: 120px;
}

.icon-layer {
  position: absolute;
  width: 60px;
  height: 60px;
  background: linear-gradient(135deg, var(--primary-gold), #d4af37);
  border-radius: 16px;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 10px 30px rgba(164, 113, 72, 0.4);
}

.layer-1 {
  top: 0;
  left: 0;
  z-index: 3;
  animation: layer1Float 4s ease-in-out infinite;
}

.layer-2 {
  top: 20px;
  left: 30px;
  z-index: 2;
  opacity: 0.8;
  animation: layer2Float 4s ease-in-out infinite 1s;
}

.layer-3 {
  top: 40px;
  left: 60px;
  z-index: 1;
  opacity: 0.6;
  animation: layer3Float 4s ease-in-out infinite 2s;
}

@keyframes layer1Float {
  0%, 100% { transform: translateY(0) rotate(0deg); }
  50% { transform: translateY(-10px) rotate(5deg); }
}

@keyframes layer2Float {
  0%, 100% { transform: translateY(0) rotate(0deg); }
  50% { transform: translateY(-8px) rotate(-3deg); }
}

@keyframes layer3Float {
  0%, 100% { transform: translateY(0) rotate(0deg); }
  50% { transform: translateY(-6px) rotate(2deg); }
}

.icon-layer .material-icons {
  color: var(--bg-dark);
  font-size: 1.75rem;
}

.pulsing-rings {
  position: absolute;
  inset: -20px;
}

.ring {
  position: absolute;
  border: 2px solid rgba(164, 113, 72, 0.3);
  border-radius: 50%;
  animation: ringPulse 3s ease-in-out infinite;
}

.ring-1 {
  inset: 0;
  animation-delay: 0s;
}

.ring-2 {
  inset: 15px;
  animation-delay: 1s;
}

.ring-3 {
  inset: 30px;
  animation-delay: 2s;
}

@keyframes ringPulse {
  0% { transform: scale(1); opacity: 0.3; }
  50% { transform: scale(1.1); opacity: 0.1; }
  100% { transform: scale(1.2); opacity: 0; }
}

.cta-text {
  flex: 1;
}

.cta-title {
  font-size: 2.25rem;
  font-weight: 300;
  margin-bottom: 1.5rem;
  color: var(--primary-light);
  line-height: 1.2;
}

.highlight {
  background: linear-gradient(135deg, var(--primary-gold), #d4af37);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  font-weight: 600;
}

.cta-description {
  font-size: 1.1rem;
  color: var(--text-light);
  line-height: 1.6;
  margin-bottom: 2rem;
  opacity: 0.9;
}

.cta-features {
  display: flex;
  gap: 2rem;
  flex-wrap: wrap;
}

.feature-item {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  color: var(--primary-gold);
  font-size: 0.95rem;
  font-weight: 500;
}

.feature-item .material-icons {
  font-size: 1.25rem;
}

.map-pointer {
  position: absolute;
  bottom: -2rem;
  left: 50%;
  transform: translateX(-50%);
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.5rem;
  z-index: 10;
}

.pointer-arrow {
  width: 40px;
  height: 40px;
  background: var(--primary-gold);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: var(--bg-dark);
  animation: pointerBounce 2s ease-in-out infinite;
  box-shadow: 0 5px 15px rgba(164, 113, 72, 0.4);
}

@keyframes pointerBounce {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(8px); }
}

.pointer-text {
  color: var(--primary-gold);
  font-size: 0.875rem;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.pointer-pulse {
  position: absolute;
  top: 0;
  left: 50%;
  transform: translateX(-50%);
  width: 40px;
  height: 40px;
  border: 2px solid var(--primary-gold);
  border-radius: 50%;
  animation: pointerPulse 2s ease-in-out infinite;
}

@keyframes pointerPulse {
  0% { transform: translateX(-50%) scale(1); opacity: 1; }
  100% { transform: translateX(-50%) scale(2); opacity: 0; }
}

/* Map Wrapper */
.map-wrapper {
  display: flex;
  justify-content: center;
  width: 100%;
}

.map-container {
  position: relative;
  width: 100%;
  max-width: 1200px;
  background: rgba(255, 255, 255, 0.02);
  border-radius: 24px;
  overflow: hidden;
  border: 2px solid rgba(164, 113, 72, 0.2);
  box-shadow: 
    0 20px 40px rgba(0, 0, 0, 0.3),
    inset 0 1px 0 rgba(255, 255, 255, 0.1);
}

.map-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1.5rem 2rem;
  background: linear-gradient(135deg, 
    rgba(255, 255, 255, 0.08) 0%,
    rgba(164, 113, 72, 0.1) 100%);
  border-bottom: 1px solid rgba(164, 113, 72, 0.2);
  backdrop-filter: var(--backdrop-blur);
}

.map-title {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  color: var(--primary-light);
}

.map-title .material-icons {
  color: var(--primary-gold);
  font-size: 1.5rem;
}

.map-title h3 {
  font-size: 1.25rem;
  font-weight: 600;
  margin: 0;
}

.map-status {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  color: var(--text-light);
  font-size: 0.875rem;
}

.status-dot {
  width: 8px;
  height: 8px;
  background: var(--primary-gold);
  border-radius: 50%;
  animation: statusPulse 2s ease-in-out infinite;
}

@keyframes statusPulse {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.5; }
}

.osm-map {
  width: 100%;
  height: 500px;
  cursor: default !important;
}

.map-loading {
  position: absolute;
  inset: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, #1a1a1a 0%, #0a0a0a 100%);
  z-index: 10;
}

.loading-container {
  text-align: center;
}

.loading-spinner {
  width: 60px;
  height: 60px;
  border: 4px solid var(--border-color);
  border-top: 4px solid var(--primary-gold);
  border-radius: 50%;
  animation: spin 1s linear infinite;
  margin: 0 auto 2rem;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

.loading-container h3 {
  color: var(--primary-light);
  font-size: 1.25rem;
  font-weight: 600;
  margin: 0 0 0.5rem 0;
}

.loading-container p {
  color: var(--text-gray);
  margin: 0;
}

.map-instructions {
  position: absolute;
  bottom: 2rem;
  right: 2rem;
  z-index: 100;
}

.instruction-tooltip {
  position: relative;
}

.tooltip-content {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 1rem 1.5rem;
  background: rgba(0, 0, 0, 0.9);
  border: 2px solid var(--primary-gold);
  border-radius: 50px;
  color: var(--primary-gold);
  font-size: 0.9rem;
  font-weight: 600;
  backdrop-filter: var(--backdrop-blur);
  animation: tooltipFloat 3s ease-in-out infinite;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
}

@keyframes tooltipFloat {
  0%, 100% { transform: translateY(0px); }
  50% { transform: translateY(-5px); }
}

.tooltip-arrow {
  position: absolute;
  top: 100%;
  left: 50%;
  transform: translateX(-50%);
  width: 0;
  height: 0;
  border-left: 8px solid transparent;
  border-right: 8px solid transparent;
  border-top: 8px solid var(--primary-gold);
}

/* Custom Leaflet Markers */
:global(.custom-leaflet-marker) {
  background: transparent !important;
  border: none !important;
}

:global(.marker-container) {
  position: relative;
  cursor: pointer;
  transition: all 0.3s ease;
}

:global(.marker-dot) {
  width: 24px;
  height: 24px;
  background: var(--primary-gold);
  border-radius: 50%;
  border: 4px solid var(--bg-dark);
  position: relative;
  z-index: 2;
  box-shadow: 0 0 25px rgba(164, 113, 72, 0.6);
  margin: 0 auto;
  transition: all 0.3s ease;
}

:global(.marker-pulse) {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 50px;
  height: 50px;
  border: 3px solid var(--primary-gold);
  border-radius: 50%;
  animation: markerPulse 2.5s infinite;
}

@keyframes markerPulse {
  0% { transform: translate(-50%, -50%) scale(1); opacity: 1; }
  100% { transform: translate(-50%, -50%) scale(3); opacity: 0; }
}

:global(.marker-label) {
  position: absolute;
  bottom: 45px;
  left: 50%;
  transform: translateX(-50%);
  background: linear-gradient(135deg, var(--bg-dark), #1a1a1a);
  padding: 0.75rem 1.25rem;
  border-radius: 12px;
  font-size: 0.875rem;
  font-weight: 600;
  white-space: nowrap;
  opacity: 0;
  transition: all 0.3s ease;
  border: 2px solid var(--primary-gold);
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.6);
  color: var(--primary-light);
  pointer-events: none;
}

:global(.marker-container:hover .marker-label),
:global(.active .marker-label) {
  opacity: 1;
  transform: translateX(-50%) translateY(-5px);
}

:global(.marker-container:hover .marker-dot) {
  transform: scale(1.3);
  box-shadow: 0 0 35px rgba(164, 113, 72, 0.8);
  background: #d4af37;
}

:global(.active .marker-dot) {
  background: var(--primary-light);
  transform: scale(1.6);
  box-shadow: 0 0 40px rgba(250, 250, 248, 0.9);
}

/* Modal Styles (unchanged from original) */
.modal-overlay {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.85);
  backdrop-filter: var(--backdrop-blur);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
  padding: 2rem;
  overflow-y: auto;
}

.modal-background {
  position: absolute;
  inset: 0;
  overflow: hidden;
}

.bg-gradient-1 {
  position: absolute;
  top: -50%;
  left: -50%;
  width: 200%;
  height: 200%;
  background: radial-gradient(circle at 30% 20%, rgba(164, 113, 72, 0.15) 0%, transparent 70%);
  animation: floatBg1 15s ease-in-out infinite;
}

.bg-gradient-2 {
  position: absolute;
  top: -50%;
  right: -50%;
  width: 200%;
  height: 200%;
  background: radial-gradient(circle at 70% 80%, rgba(255, 215, 0, 0.1) 0%, transparent 70%);
  animation: floatBg2 20s ease-in-out infinite reverse;
}

@keyframes floatBg1 {
  0%, 100% { transform: rotate(0deg) scale(1); }
  50% { transform: rotate(180deg) scale(1.1); }
}

@keyframes floatBg2 {
  0%, 100% { transform: rotate(0deg) scale(1); }
  50% { transform: rotate(-180deg) scale(0.9); }
}

.floating-particles {
  position: absolute;
  inset: 0;
}

.particle {
  position: absolute;
  width: 4px;
  height: 4px;
  background: rgba(164, 113, 72, 0.6);
  border-radius: 50%;
  top: var(--y);
  left: var(--x);
  animation: particleFloat var(--duration) ease-in-out infinite var(--delay);
}

@keyframes particleFloat {
  0%, 100% {
    opacity: 0;
    transform: translateY(0) scale(0);
  }
  10%, 90% {
    opacity: 1;
  }
  50% {
    opacity: 1;
    transform: translateY(-100px) scale(1);
  }
}

.modal-container {
  max-width: 700px;
  width: 100%;
  position: relative;
  max-height: 90vh;
  overflow-y: auto;
}

.modal-card {
  background: linear-gradient(135deg, 
    rgba(255, 255, 255, 0.08) 0%,
    rgba(255, 255, 255, 0.04) 50%,
    rgba(164, 113, 72, 0.08) 100%);
  backdrop-filter: var(--backdrop-blur);
  border: 1px solid rgba(255, 255, 255, 0.15);
  border-radius: 24px;
  overflow: hidden;
  box-shadow: 
    0 25px 50px rgba(0, 0, 0, 0.5),
    inset 0 1px 0 rgba(255, 255, 255, 0.1);
}

/* Modal Header */
.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1.5rem 2rem;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.location-type-badge {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.5rem 1rem;
  background: rgba(164, 113, 72, 0.2);
  border: 1px solid rgba(164, 113, 72, 0.4);
  border-radius: 50px;
  color: var(--primary-gold);
  font-size: 0.875rem;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.close-button {
  width: 40px;
  height: 40px;
  background: rgba(255, 255, 255, 0.1);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 50%;
  color: var(--text-light);
  cursor: pointer;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  justify-content: center;
}

.close-button:hover {
  background: rgba(255, 255, 255, 0.2);
  transform: rotate(90deg);
  color: var(--primary-light);
}

/* Modal Hero */
.modal-hero {
  padding: 2rem;
  text-align: center;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.location-icon-display {
  position: relative;
  width: 120px;
  height: 120px;
  margin: 0 auto 2rem;
}

.icon-backdrop {
  position: absolute;
  inset: 0;
}

.rotating-ring {
  position: absolute;
  border: 2px solid rgba(164, 113, 72, 0.3);
  border-radius: 50%;
  animation: rotateRing 15s linear infinite;
}

.ring-1 {
  inset: 0;
  animation-duration: 10s;
}

.ring-2 {
  inset: 15px;
  animation-duration: 15s;
  animation-direction: reverse;
}

.ring-3 {
  inset: 30px;
  animation-duration: 8s;
}

@keyframes rotateRing {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}

.main-icon {
  position: absolute;
  inset: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, var(--primary-gold), #d4af37);
  border-radius: 50%;
  width: 60px;
  height: 60px;
  margin: auto;
  box-shadow: 0 10px 30px rgba(164, 113, 72, 0.4);
  animation: iconHover 3s ease-in-out infinite;
}

@keyframes iconHover {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(-8px); }
}

.main-icon .material-icons {
  font-size: 2rem;
  color: var(--bg-dark);
}

.location-title-section {
  margin-bottom: 1rem;
}

.location-name {
  font-size: 2.5rem;
  font-weight: 300;
  margin-bottom: 0.5rem;
  background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary-gold) 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.location-country {
  color: var(--text-gray);
  font-size: 1.1rem;
  opacity: 0.8;
}

/* Modal Content */
.modal-content {
  padding: 2rem;
  display: flex;
  flex-direction: column;
  gap: 2rem;
}

.info-card {
  background: rgba(255, 255, 255, 0.03);
  border: 1px solid rgba(255, 255, 255, 0.08);
  border-radius: 16px;
  padding: 1.5rem;
  backdrop-filter: blur(10px);
}

.card-header {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  margin-bottom: 1rem;
}

.card-header .material-icons {
  color: var(--primary-gold);
  font-size: 1.25rem;
}

.card-header h3 {
  color: var(--primary-light);
  font-size: 1.1rem;
  font-weight: 600;
  margin: 0;
}

.description-text {
  color: var(--text-light);
  line-height: 1.6;
  margin: 0;
}

.details-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 1rem;
}

.detail-item {
  display: flex;
  align-items: flex-start;
  gap: 1rem;
  padding: 1rem;
  background: rgba(255, 255, 255, 0.03);
  border: 1px solid rgba(255, 255, 255, 0.08);
  border-radius: 12px;
  transition: all 0.3s ease;
}

.detail-item:hover {
  background: rgba(164, 113, 72, 0.1);
  border-color: rgba(164, 113, 72, 0.2);
  transform: translateY(-2px);
}

.detail-icon {
  width: 40px;
  height: 40px;
  background: rgba(164, 113, 72, 0.2);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}

.detail-icon .material-icons {
  color: var(--primary-gold);
  font-size: 1.25rem;
}

.detail-content h4 {
  color: var(--primary-light);
  font-size: 0.9rem;
  font-weight: 600;
  margin: 0 0 0.25rem 0;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.detail-content p {
  color: var(--text-light);
  font-size: 0.95rem;
  margin: 0;
}

/* Modal Footer */
.modal-footer {
  padding: 2rem;
  border-top: 1px solid rgba(255, 255, 255, 0.1);
}

.action-buttons {
  display: flex;
  gap: 1rem;
  justify-content: center;
}

.action-btn {
  position: relative;
  display: flex;
  align-items: center;
  gap: 0.75rem;
  padding: 1rem 2rem;
  border-radius: 50px;
  font-size: 0.95rem;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  cursor: pointer;
  transition: all 0.3s ease;
  text-decoration: none;
  border: none;
  backdrop-filter: blur(10px);
  overflow: hidden;
}

.action-btn.primary {
  background: linear-gradient(135deg, var(--primary-gold), #d4af37);
  color: var(--bg-dark);
  border: none;
  position: relative;
}

.action-btn.primary:hover {
  transform: translateY(-3px) scale(1.05);
  box-shadow: 0 15px 30px rgba(164, 113, 72, 0.4);
}

.btn-shine {
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
  transition: left 0.5s ease;
}

.action-btn.primary:hover .btn-shine {
  left: 100%;
}

.action-btn .material-icons {
  font-size: 1.25rem;
  transition: transform 0.3s ease;
}

.action-btn:hover .material-icons {
  transform: scale(1.1);
}

/* Modal Transitions */
.modal-fade-enter-active {
  transition: all 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
}

.modal-fade-leave-active {
  transition: all 0.3s ease-in;
}

.modal-fade-enter-from,
.modal-fade-leave-to {
  opacity: 0;
  backdrop-filter: blur(0px);
}

.modal-fade-enter-from .modal-container,
.modal-fade-leave-to .modal-container {
  transform: scale(0.9) translateY(30px);
  opacity: 0;
}

/* Responsive Design */
@media (max-width: 1200px) {
  .hero-title {
    font-size: 3.5rem;
  }
  
  .osm-map {
    height: 400px;
  }
  
  .cta-content {
    flex-direction: column;
    text-align: center;
    gap: 2rem;
  }
  
  .cta-features {
    justify-content: center;
  }
}

@media (max-width: 768px) {
  .hero-title {
    font-size: 2.5rem;
  }
  
  .hero-subtitle {
    font-size: 1rem;
  }
  
  .steps-container {
    flex-direction: column;
    gap: 1.5rem;
  }
  
  .step-connector {
    transform: rotate(90deg);
  }
  
  .step-indicator {
    flex-direction: column;
    text-align: center;
    gap: 0.75rem;
  }
  
  .cta-title {
    font-size: 1.75rem;
  }
  
  .cta-features {
    flex-direction: column;
    gap: 1rem;
  }
  
  .feature-item {
    justify-content: center;
  }
  
  .modal-overlay {
    padding: 1rem;
  }
  
  .modal-header,
  .modal-hero,
  .modal-content,
  .modal-footer {
    padding: 1.5rem;
  }
  
  .details-grid {
    grid-template-columns: 1fr;
  }
  
  .action-buttons {
    flex-direction: column;
  }
  
  .action-btn {
    width: 100%;
    justify-content: center;
  }
  
  .location-name {
    font-size: 2rem;
  }
  
  .osm-map {
    height: 350px;
  }
}

@media (max-width: 480px) {
  .hero-title {
    font-size: 2rem;
  }
  
  .title-line-1 {
    font-size: 0.6em;
  }
  
  .hero-subtitle {
    font-size: 0.9rem;
  }
  
  .cta-title {
    font-size: 1.5rem;
  }
  
  .cta-description {
    font-size: 1rem;
  }
  
  .osm-map {
    height: 300px;
  }
  
  .location-name {
    font-size: 1.75rem;
  }
  
  .location-icon-display {
    width: 100px;
    height: 100px;
  }
  
  .main-icon {
    width: 50px;
    height: 50px;
  }
  
  .main-icon .material-icons {
    font-size: 1.5rem;
  }
  
  .modal-header {
    flex-direction: column;
    gap: 1rem;
    align-items: flex-start;
  }
  
  .action-btn {
    padding: 0.875rem 1.5rem;
    font-size: 0.875rem;
  }
  
  .step-number {
    width: 40px;
    height: 40px;
    font-size: 1rem;
  }
  
  .map-header {
    flex-direction: column;
    gap: 1rem;
    text-align: center;
  }
  
  .map-instructions {
    bottom: 1rem;
    right: 1rem;
  }
  
  .tooltip-content {
    padding: 0.75rem 1rem;
    font-size: 0.8rem;
  }
}
</style>