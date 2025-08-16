<template>
  <div class="mobile-premium-map">
    <!-- Enhanced Background -->
    <div class="map-background">
      <div class="floating-shapes">
        <div v-for="n in 6" :key="n" class="shape" :style="getShapeStyle(n)"></div>
      </div>
      <div class="gradient-orbs">
        <div class="orb orb-1"></div>
        <div class="orb orb-2"></div>
        <div class="orb orb-3"></div>
      </div>
    </div>

    <!-- Status Bar Overlay -->
    <div class="status-overlay">
      <div class="section-badge-container">
        <div class="badge-glow"></div>
        <div class="section-badge premium">
          <span class="material-icons">public</span>
          <span class="badge-text">STANDORTE</span>
          <div class="badge-pulse"></div>
        </div>
      </div>
    </div>

    <!-- Mobile Selection Guide -->
    <div class="mobile-selection-guide">
      <div class="guide-container">
        <div class="guide-header">
          <h3>So funktioniert's</h3>
          <p>In 3 einfachen Schritten zu Ihrem Beratungstermin</p>
        </div>
        
        <div class="steps-horizontal">
          <div class="step-card" :class="{ active: currentStep >= 1 }">
            <div class="step-number">
              <span>1</span>
              <div class="step-pulse"></div>
            </div>
            <div class="step-content">
              <h4>Standort antippen</h4>
              <p>Marker auf der Karte berühren</p>
            </div>
            <div class="step-icon">
              <span class="material-icons">touch_app</span>
            </div>
          </div>

          <div class="step-connector">
            <div class="connector-line"></div>
            <div class="connector-arrow">
              <span class="material-icons">arrow_forward</span>
            </div>
          </div>

          <div class="step-card" :class="{ active: currentStep >= 2 }">
            <div class="step-number">
              <span>2</span>
              <div class="step-pulse"></div>
            </div>
            <div class="step-content">
              <h4>Details ansehen</h4>
              <p>Alle Informationen erhalten</p>
            </div>
            <div class="step-icon">
              <span class="material-icons">info</span>
            </div>
          </div>

          <div class="step-connector">
            <div class="connector-line"></div>
            <div class="connector-arrow">
              <span class="material-icons">arrow_forward</span>
            </div>
          </div>

          <div class="step-card" :class="{ active: currentStep >= 3 }">
            <div class="step-number">
              <span>3</span>
              <div class="step-pulse"></div>
            </div>
            <div class="step-content">
              <h4>Termin buchen</h4>
              <p>Direkt Beratung vereinbaren</p>
            </div>
            <div class="step-icon">
              <span class="material-icons">event</span>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Map Container -->
    <div ref="mapContainer" class="map-container">
      <!-- Enhanced Map Header -->
      <div class="map-header">
        <div class="map-title">
          <span class="material-icons">map</span>
          <h3>{{ locations.length }} Premium Standorte</h3>
        </div>
        <div class="map-status">
          <div class="status-dot"></div>
          <span>Live verfügbar</span>
        </div>
      </div>

      <!-- OpenStreetMap Container -->
      <div id="mobile-osm-map" class="mobile-osm-map"></div>
      
      <!-- Loading Overlay -->
      <div v-if="mapLoading" class="map-loading">
        <div class="map-loading-content">
          <div class="map-loading-spinner"></div>
          <h3>Karte wird geladen</h3>
          <p>Einen Moment bitte...</p>
        </div>
      </div>

      <!-- Enhanced Map Overlay -->
      <div class="map-overlay">
        <!-- Premium Search Bar -->
        <div class="search-bar">
          <div class="search-icon">
            <span class="material-icons">search</span>
          </div>
          <input
            v-model="searchQuery"
            type="text"
            placeholder="Standort suchen..."
            class="search-input"
            @input="handleSearch"
          />
          <button v-if="searchQuery" @click="clearSearch" class="clear-btn">
            <span class="material-icons">close</span>
          </button>
        </div>

        <!-- Enhanced Location Button -->
        <button 
          @click="getCurrentLocation"
          :class="['location-btn', 'premium-btn', { active: trackingLocation, pulsing: findingLocation }]"
        >
          <div class="btn-glow"></div>
          <span class="material-icons">{{ trackingLocation ? 'my_location' : 'location_searching' }}</span>
          <div class="btn-pulse"></div>
        </button>
      </div>

      <!-- Map Instructions with Premium Design -->
      <div class="map-instructions">
        <div class="instruction-tooltip">
          <div class="tooltip-content">
            <span class="material-icons">touch_app</span>
            <span>Für Details antippen</span>
          </div>
          <div class="tooltip-arrow"></div>
          <div class="tooltip-glow"></div>
        </div>
      </div>
    </div>

    <!-- Enhanced Location Detail Modal -->
    <Transition name="modal-fade">
      <div v-if="selectedLocation && !listExpanded" class="location-detail premium-modal">
        <!-- Animated Modal Background -->
        <div class="modal-background">
          <div class="bg-gradient-1"></div>
          <div class="bg-gradient-2"></div>
          <div class="floating-particles">
            <div v-for="n in 8" :key="n" class="particle" :style="getParticleStyle(n)"></div>
          </div>
        </div>

        <!-- Enhanced Close Button -->
        <button @click="closeLocationModal" class="detail-close premium-close">
          <div class="close-glow"></div>
          <span class="material-icons">expand_more</span>
        </button>

        <!-- Redesigned Detail Content -->
        <div class="detail-container">
          <!-- Compact Header -->
          <div class="detail-header-compact">
            <div class="location-icon-small">
              <span class="material-icons">{{ selectedLocation.icon }}</span>
            </div>
            <div class="location-info">
              <h2>{{ selectedLocation.city }}</h2>
              <p class="location-subtitle">{{ selectedLocation.country }} • {{ selectedLocation.type }}</p>
              <div class="location-status" :class="{ open: isOpen(selectedLocation) }">
                <div class="status-indicator"></div>
                <span>{{ isOpen(selectedLocation) ? 'Geöffnet' : 'Geschlossen' }}</span>
                <span v-if="selectedLocation.distance" class="distance">{{ formatDistance(selectedLocation.distance) }}</span>
              </div>
            </div>
          </div>

          <!-- Quick Actions Grid -->
          <div class="quick-actions-redesigned">
            
            <button @click="bookAppointment(selectedLocation)" v-if="selectedLocation.bookingAvailable" class="action-card">
              <div class="action-icon-new">
                <span class="material-icons">event</span>
              </div>
              <div class="action-text">
                <span class="action-title">Termin</span>
                <span class="action-subtitle">Beratung buchen</span>
              </div>
            </button>
          </div>

          <!-- Information Cards -->
          <div class="info-cards">
            <!-- About Card -->
            <div class="info-card">
              <div class="card-header">
                <span class="material-icons">info_outline</span>
                <h4>Über diesen Standort</h4>
              </div>
              <p class="card-description">{{ selectedLocation.description }}</p>
            </div>

            <!-- Address Card -->
            <div class="info-card" v-if="selectedLocation.address">
              <div class="card-header">
                <span class="material-icons">location_on</span>
                <h4>Adresse</h4>
              </div>
              <p class="card-address">{{ selectedLocation.address }}</p>
            </div>

            <!-- Hours Card -->
            <div class="info-card" v-if="selectedLocation.openingHours">
              <div class="card-header">
                <span class="material-icons">access_time</span>
                <h4>Öffnungszeiten</h4>
                <div class="hours-toggle" @click="hoursExpanded = !hoursExpanded">
                  <span class="material-icons">{{ hoursExpanded ? 'expand_less' : 'expand_more' }}</span>
                </div>
              </div>
              <div v-if="hoursExpanded" class="hours-grid">
                <div 
                  v-for="(hours, day) in selectedLocation.openingHours" 
                  :key="day"
                  class="hours-item"
                  :class="{ today: isToday(day) }"
                >
                  <span class="day-label">{{ day }}</span>
                  <span class="hours-label">{{ hours }}</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </Transition>

    <!-- Enhanced Loading State -->
    <Transition name="fade">
      <div v-if="isLoading" class="loading-overlay premium-loading">
        <div class="loading-background">
          <div class="loading-orb-1"></div>
          <div class="loading-orb-2"></div>
        </div>
        <div class="loading-content">
          <div class="loading-spinner premium-spinner">
            <div class="spinner-ring ring-1"></div>
            <div class="spinner-ring ring-2"></div>
            <div class="spinner-ring ring-3"></div>
          </div>
          <h3>Premium Standorte werden geladen</h3>
          <p>Einen Moment bitte...</p>
        </div>
      </div>
    </Transition>

    <!-- Enhanced Distance Toast -->
    <Transition name="toast">
      <div v-if="showDistanceToast" class="distance-toast premium-toast">
        <div class="toast-glow"></div>
        <span class="material-icons">info</span>
        <span>{{ distanceMessage }}</span>
      </div>
    </Transition>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted, reactive, watch } from 'vue'

// Refs
const mapContainer = ref(null)
const searchQuery = ref('')
const selectedLocation = ref(null)
const listExpanded = ref(false)
const trackingLocation = ref(false)
const findingLocation = ref(false)
const isLoading = ref(true)
const mapLoading = ref(true)
const showDistanceToast = ref(false)
const distanceMessage = ref('')
const hoursExpanded = ref(false)
const currentStep = ref(1)

// Map variables
let map = null
let markers = []

// User location
const userLocation = reactive({
  lat: null,
  lng: null
})

// Enhanced Locations with Premium Features and correct coordinates
const locations = ref([
  {
    id: 1,
    city: 'München',
    country: 'Deutschland',
    lat: 47.9065, 
    lng: 11.5528,
    type: 'Showroom & Hauptsitz',
    icon: 'business',
    description: '2500m² Showroom mit Europas größter Natursteinauswahl. Hier finden Sie unsere komplette Kollektion und erhalten professionelle Beratung von unseren Experten.',
    address: 'Am Hohenrand 9, 82335 Berg',
    phone: '+49 8171 / 3868770',
    bookingAvailable: true,
    features: ['2500m² Ausstellungsfläche', '3D-Planung', 'Barrierefreier Zugang', 'Kostenlose Parkplätze', 'VIP-Beratung'],
    openingHours: {
      'Mo': 'Geschlossen',
      'Di-Fr': '09:00 - 17:00',
      'Sa': '09:00 - 16:00',
      'So': 'Geschlossen'
    },
    distance: null
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
    address: 'Osterather Str. 6 i, 41460 Neuss',
    phone: '+49 2131 / 1234567',
    bookingAvailable: true,
    features: ['Europas größte Auswahl', '80.000m² Lagerfläche', 'Premium Materialien', 'Express-Lieferung'],
    openingHours: {
      'Mo': 'Geschlossen',
      'Di-Fr': '09:00 - 17:00',
      'Sa': '09:00 - 16:00',
      'So': 'Geschlossen'
    },
    distance: null
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
    address: 'Bahnhofstrasse 120, 8001 Zürich',
    bookingAvailable: true,
    features: ['Persönliche Beratung', 'Schweizer Standards', 'Lokaler Service'],
    distance: null
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
    address: 'Promenade des Anglais 200, 06000 Nice',
    bookingAvailable: false,
    features: ['Exklusive Materialien', 'Luxus-Segment', 'Französische Riviera'],
    distance: null
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
    address: 'Via Roma 45, 24121 Bergamo',
    bookingAvailable: false,
    features: ['Direkte Produktion', 'Italienische Qualität', 'Steinbruch-Zugang'],
    distance: null
  }
])

// Computed Properties
const filteredLocations = computed(() => {
  if (!searchQuery.value) return locations.value
  
  const query = searchQuery.value.toLowerCase()
  return locations.value.filter(location => 
    location.city.toLowerCase().includes(query) ||
    location.country.toLowerCase().includes(query) ||
    location.type.toLowerCase().includes(query) ||
    location.description.toLowerCase().includes(query)
  )
})

const sortedLocations = computed(() => {
  const sorted = [...filteredLocations.value]
  if (userLocation.lat && userLocation.lng) {
    sorted.sort((a, b) => (a.distance || Infinity) - (b.distance || Infinity))
  }
  return sorted
})

// Animation Style Generators
const getShapeStyle = (index) => {
  return {
    '--delay': `${index * 0.5}s`,
    '--duration': `${8 + (index % 4)}s`,
    '--size': `${15 + (index % 3) * 8}px`,
    '--x': `${Math.random() * 100}%`,
    '--y': `${Math.random() * 100}%`
  }
}

const getParticleStyle = (index) => {
  return {
    '--delay': `${index * 0.2}s`,
    '--duration': `${3 + (index % 3)}s`,
    '--x': `${Math.random() * 100}%`,
    '--y': `${Math.random() * 100}%`
  }
}

// Map functions
const initMap = () => {
  if (typeof window === 'undefined' || !window.L) {
    console.error('Leaflet not loaded')
    return
  }

  try {
    // Create map with ZOOM DISABLED
    map = window.L.map('mobile-osm-map', {
      zoomControl: false,
      attributionControl: false,
      scrollWheelZoom: false,  // DISABLED
      doubleClickZoom: false,  // DISABLED
      boxZoom: false,
      keyboard: false,         // DISABLED
      dragging: true,          // Keep dragging enabled
      touchZoom: false,        // DISABLED
      zoomSnap: 1,
      zoomDelta: 1
    })

    // Add dark tile layer optimized for mobile
    window.L.tileLayer('https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png', {
      attribution: '© OpenStreetMap contributors © CARTO',
      subdomains: 'abcd',
      maxZoom: 19
    }).addTo(map)

    // Add markers and fit bounds
    addMarkers()
    fitMapToMarkersOptimal()
    mapLoading.value = false

    console.log('Map initialized successfully with zoom disabled')
  } catch (error) {
    console.error('Error initializing map:', error)
    mapLoading.value = false
  }
}

const addMarkers = () => {
  if (!window.L || !map) return

  try {
    markers = locations.value.map(location => {
      const customIcon = window.L.divIcon({
        className: 'custom-leaflet-marker-mobile',
        html: `
          <div class="mobile-marker-container">
            <div class="mobile-marker-pulse"></div>
            <div class="mobile-marker-pulse-2"></div>
            <div class="mobile-marker-dot">
              <span class="material-icons">${location.icon}</span>
            </div>
            <div class="mobile-marker-label">${location.city}</div>
          </div>
        `,
        iconSize: [40, 40],
        iconAnchor: [20, 35]
      })

      const marker = window.L.marker([location.lat, location.lng], {
        icon: customIcon
      }).addTo(map)

      marker.on('click', () => {
        selectLocation(location)
        markers.forEach(m => {
          m.getElement()?.classList.remove('active')
        })
        marker.getElement()?.classList.add('active')
      })

      return marker
    })

    console.log(`Added ${markers.length} markers to map`)
  } catch (error) {
    console.error('Error adding markers:', error)
  }
}

const fitMapToMarkersOptimal = () => {
  if (!window.L || !map || markers.length === 0) return

  try {
    const group = new window.L.featureGroup(markers)
    map.fitBounds(group.getBounds().pad(0.1), {
      maxZoom: 6,
      animate: false
    })
  } catch (error) {
    console.error('Error fitting map bounds:', error)
  }
}

const loadLeaflet = () => {
  return new Promise((resolve, reject) => {
    if (typeof window !== 'undefined' && window.L) {
      resolve()
      return
    }

    // Load CSS
    const cssLink = document.createElement('link')
    cssLink.rel = 'stylesheet'
    cssLink.href = 'https://unpkg.com/leaflet@1.9.4/dist/leaflet.css'
    cssLink.onload = () => {
      console.log('Leaflet CSS loaded')
    }
    document.head.appendChild(cssLink)

    // Load JS
    const script = document.createElement('script')
    script.src = 'https://unpkg.com/leaflet@1.9.4/dist/leaflet.js'
    script.onload = () => {
      console.log('Leaflet JS loaded')
      resolve()
    }
    script.onerror = () => {
      console.error('Failed to load Leaflet')
      reject(new Error('Failed to load Leaflet'))
    }
    document.head.appendChild(script)
  })
}

const selectLocation = (location) => {
  selectedLocation.value = location
  listExpanded.value = false
  hoursExpanded.value = false
  currentStep.value = 2 // User has selected a location, progress to step 2
  
  if (location.lat && location.lng && map) {
    map.setView([location.lat, location.lng], map.getZoom(), { animate: true })
  }
  
  // Haptic feedback
  if (navigator.vibrate) {
    navigator.vibrate(50)
  }
}

const closeLocationModal = () => {
  selectedLocation.value = null
  currentStep.value = 1 // Reset to step 1
}

const isOpen = (location) => {
  if (!location.openingHours) return false
  
  const now = new Date()
  const day = now.getDay()
  
  const hours = location.openingHours['Di-Fr']
  return hours && hours !== 'Geschlossen' && day >= 2 && day <= 5
}

const getCurrentLocation = () => {
  findingLocation.value = true
  
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(
      (position) => {
        userLocation.lat = position.coords.latitude
        userLocation.lng = position.coords.longitude
        trackingLocation.value = true
        findingLocation.value = false
        calculateDistances()
        showLocationToast()
        
        // Center map on user location without changing zoom
        if (map) {
          map.setView([userLocation.lat, userLocation.lng], map.getZoom(), { animate: true })
        }
      },
      (error) => {
        console.error('Location error:', error)
        findingLocation.value = false
        trackingLocation.value = false
      }
    )
  }
}

const calculateDistances = () => {
  locations.value.forEach(location => {
    if (userLocation.lat && userLocation.lng && location.lat && location.lng) {
      const R = 6371
      const dLat = (location.lat - userLocation.lat) * Math.PI / 180
      const dLng = (location.lng - userLocation.lng) * Math.PI / 180
      const a = Math.sin(dLat/2) * Math.sin(dLat/2) +
                Math.cos(userLocation.lat * Math.PI / 180) * 
                Math.cos(location.lat * Math.PI / 180) *
                Math.sin(dLng/2) * Math.sin(dLng/2)
      const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
      location.distance = R * c
    }
  })
}

const showLocationToast = () => {
  const nearest = sortedLocations.value[0]
  if (nearest && nearest.distance) {
    distanceMessage.value = `Nächster Standort: ${nearest.city} (${formatDistance(nearest.distance)})`
    showDistanceToast.value = true
    setTimeout(() => {
      showDistanceToast.value = false
    }, 3000)
  }
}

const formatDistance = (distance) => {
  if (distance < 1) {
    return `${Math.round(distance * 1000)}m`
  }
  return `${distance.toFixed(1)}km`
}

const getDirections = (location) => {
  let destination = ''
  if (location.lat && location.lng) {
    destination = `${location.lat},${location.lng}`
  } else if (location.address) {
    destination = encodeURIComponent(location.address)
  } else {
    destination = encodeURIComponent(`${location.city}, ${location.country}`)
  }
  
  const url = `https://maps.google.com/maps?daddr=${destination}`
  window.open(url, '_blank')
}

const callLocation = (location) => {
  if (location.phone) {
    window.location.href = `tel:${location.phone}`
  }
}

const bookAppointment = (location) => {
  currentStep.value = 3 // User is booking appointment, progress to step 3
  window.location.href = `/kontakt?location=${location.id}`
}

const shareLocation = async (location) => {
  if (navigator.share) {
    try {
      await navigator.share({
        title: `${location.city} - ${location.type}`,
        text: location.description,
        url: window.location.href
      })
    } catch (error) {
      console.log('Share failed:', error)
    }
  }
}

const handleSearch = () => {
  // Search handled by computed property
}

const clearSearch = () => {
  searchQuery.value = ''
}

const isToday = (day) => {
  const days = ['So', 'Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa']
  const today = days[new Date().getDay()]
  return day.includes(today)
}

// Lifecycle
onMounted(async () => {
  try {
    await loadLeaflet()
    
    // Wait for DOM to be ready
    setTimeout(() => {
      initMap()
      isLoading.value = false
      getCurrentLocation()
    }, 500)
  } catch (error) {
    console.error('Failed to initialize map:', error)
    isLoading.value = false
    mapLoading.value = false
  }
})

onUnmounted(() => {
  if (map) {
    map.remove()
    map = null
  }
  markers = []
})

// Watch for location changes
watch(trackingLocation, (newVal) => {
  if (newVal && map && userLocation.lat && userLocation.lng) {
    map.setView([userLocation.lat, userLocation.lng], map.getZoom(), { animate: true })
  }
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

/* Main Container */
.mobile-premium-map {
  position: relative;
  width: 100%;
  height: 100vh;
  height: 100dvh;
  background: linear-gradient(135deg, #1a1a1a 0%, #0a0a0a 100%);
  overflow: hidden;
}

/* Enhanced Background */
.map-background {
  position: absolute;
  inset: 0;
  overflow: hidden;
  z-index: 1;
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
    transform: translateY(-20px) rotate(180deg) scale(1.1);
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
  filter: blur(40px);
  animation: orbFloat 15s ease-in-out infinite;
}

.orb-1 {
  width: 200px;
  height: 200px;
  background: radial-gradient(circle, rgba(164, 113, 72, 0.3) 0%, transparent 70%);
  top: 10%;
  left: 10%;
  animation-delay: 0s;
}

.orb-2 {
  width: 150px;
  height: 150px;
  background: radial-gradient(circle, rgba(255, 215, 0, 0.2) 0%, transparent 70%);
  top: 60%;
  right: 20%;
  animation-delay: 5s;
}

.orb-3 {
  width: 100px;
  height: 100px;
  background: radial-gradient(circle, rgba(164, 113, 72, 0.25) 0%, transparent 70%);
  bottom: 20%;
  left: 60%;
  animation-delay: 10s;
}

@keyframes orbFloat {
  0%, 100% { transform: translate(0, 0) scale(1); }
  33% { transform: translate(20px, -15px) scale(1.1); }
  66% { transform: translate(-15px, 20px) scale(0.9); }
}

/* Status Overlay */
.status-overlay {
  position: absolute;
  top: env(safe-area-inset-top);
  left: 0;
  right: 0;
  z-index: 15;
  display: flex;
  justify-content: center;
  padding: 1rem;
}

.section-badge-container {
  position: relative;
  display: flex;
  justify-content: center;
}

.badge-glow {
  position: absolute;
  inset: -15px;
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
  gap: 0.5rem;
  padding: 0.75rem 1.5rem;
  background: linear-gradient(135deg, 
    rgba(164, 113, 72, 0.25), 
    rgba(255, 255, 255, 0.08), 
    rgba(164, 113, 72, 0.15));
  border: 2px solid rgba(164, 113, 72, 0.4);
  border-radius: 50px;
  backdrop-filter: var(--backdrop-blur);
  font-size: 0.8rem;
  letter-spacing: 0.1em;
  font-weight: 700;
  color: var(--primary-gold);
  text-transform: uppercase;
  box-shadow: 
    0 8px 25px rgba(164, 113, 72, 0.3),
    inset 0 1px 0 rgba(255, 255, 255, 0.2);
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

/* MOBILE SELECTION GUIDE */
.mobile-selection-guide {
  position: relative;
  z-index: 14;
  padding: calc(env(safe-area-inset-top) + 80px) 16px 12px;
}

.guide-container {
  background: linear-gradient(135deg, 
    rgba(255, 255, 255, 0.08) 0%,
    rgba(164, 113, 72, 0.12) 50%,
    rgba(255, 255, 255, 0.06) 100%);
  backdrop-filter: var(--backdrop-blur);
  border: 1px solid rgba(164, 113, 72, 0.25);
  border-radius: 16px;
  padding: 14px 12px 10px;
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3);
  position: relative;
  overflow: hidden;
}

.guide-container::before {
  content: '';
  position: absolute;
  inset: -1px;
  background: linear-gradient(135deg, 
    rgba(164, 113, 72, 0.4), 
    transparent, 
    rgba(164, 113, 72, 0.2));
  border-radius: 16px;
  z-index: -1;
  animation: guideGlow 4s ease-in-out infinite;
}

@keyframes guideGlow {
  0%, 100% { opacity: 0.3; }
  50% { opacity: 0.6; }
}

.guide-header {
  text-align: center;
  margin-bottom: 12px;
}

.guide-header h3 {
  font-size: 0.9rem;
  font-weight: 600;
  color: var(--primary-light);
  margin: 0 0 3px;
}

.guide-header p {
  font-size: 0.7rem;
  color: var(--text-gray);
  margin: 0;
  line-height: 1.3;
}

.steps-horizontal {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 10px;
  gap: 8px;
}

.step-card {
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  position: relative;
  flex: 1;
  transition: all 0.3s ease;
}

.step-number {
  width: 28px;
  height: 28px;
  background: linear-gradient(135deg, var(--primary-gold), #d4af37);
  border: 2px solid rgba(164, 113, 72, 0.4);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 0.75rem;
  font-weight: 700;
  color: var(--bg-dark);
  margin-bottom: 6px;
  position: relative;
  overflow: hidden;
  transition: all 0.3s ease;
  box-shadow: 0 3px 10px rgba(164, 113, 72, 0.3);
}

.step-card.active .step-number {
  transform: scale(1.1);
  box-shadow: 0 4px 15px rgba(164, 113, 72, 0.5);
}

.step-pulse {
  position: absolute;
  inset: -4px;
  border: 2px solid var(--primary-gold);
  border-radius: 50%;
  opacity: 0;
  animation: stepPulse 2.5s ease-in-out infinite;
}

.step-card.active .step-pulse {
  opacity: 1;
}

@keyframes stepPulse {
  0% { transform: scale(1); opacity: 1; }
  100% { transform: scale(1.6); opacity: 0; }
}

.step-content {
  margin-bottom: 6px;
}

.step-content h4 {
  font-size: 0.65rem;
  font-weight: 600;
  color: var(--primary-light);
  margin: 0 0 1px;
  line-height: 1.1;
}

.step-content p {
  font-size: 0.55rem;
  color: var(--text-gray);
  margin: 0;
  line-height: 1.1;
}

.step-card.active .step-content h4 {
  color: var(--primary-gold);
}

.step-card.active .step-content p {
  color: var(--primary-light);
}

.step-icon {
  width: 16px;
  height: 16px;
  background: rgba(164, 113, 72, 0.2);
  border-radius: 4px;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.3s ease;
}

.step-card.active .step-icon {
  background: rgba(164, 113, 72, 0.4);
}

.step-icon .material-icons {
  font-size: 10px;
  color: var(--primary-gold);
}

.step-connector {
  display: flex;
  align-items: center;
  gap: 2px;
  margin: 0 4px;
  opacity: 0.6;
  flex-shrink: 0;
}

.connector-line {
  width: 12px;
  height: 1px;
  background: linear-gradient(90deg, 
    var(--primary-gold), 
    rgba(164, 113, 72, 0.3));
}

.connector-arrow {
  animation: arrowBounce 2s ease-in-out infinite;
}

.connector-arrow .material-icons {
  font-size: 10px;
  color: var(--primary-gold);
}

@keyframes arrowBounce {
  0%, 100% { transform: translateX(0); }
  50% { transform: translateX(1px); }
}

.guide-footer {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 4px;
}

.progress-bar {
  width: 100%;
  height: 2px;
  background: rgba(164, 113, 72, 0.2);
  border-radius: 1px;
  overflow: hidden;
  position: relative;
}

.progress-fill {
  height: 100%;
  background: linear-gradient(90deg, var(--primary-gold), #d4af37);
  border-radius: 1px;
  transition: width 0.6s ease;
  position: relative;
}

.progress-fill::after {
  content: '';
  position: absolute;
  top: 0;
  left: -20px;
  width: 20px;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4));
  animation: progressShine 2s ease-in-out infinite;
}

@keyframes progressShine {
  0% { left: -20px; }
  100% { left: 100%; }
}

.progress-text {
  font-size: 0.6rem;
  color: var(--text-gray);
  margin: 0;
  font-weight: 500;
}

/* Map Container */
.map-container {
  position: relative;
  width: 100%;
  height: calc(100vh - 180px); /* Adjusted for smaller guide */
  z-index: 2;
}

/* Enhanced Map Header */
.map-header {
  position: absolute;
  top: 20px;
  left: 20px;
  right: 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem 1.5rem;
  background: linear-gradient(135deg, 
    rgba(255, 255, 255, 0.08) 0%,
    rgba(164, 113, 72, 0.1) 100%);
  border: 1px solid rgba(164, 113, 72, 0.2);
  border-radius: 20px;
  backdrop-filter: var(--backdrop-blur);
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3);
  z-index: 10;
}

.map-title {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  color: var(--primary-light);
}

.map-title .material-icons {
  color: var(--primary-gold);
  font-size: 1.25rem;
}

.map-title h3 {
  font-size: 1rem;
  font-weight: 600;
  margin: 0;
}

.map-status {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  color: var(--text-light);
  font-size: 0.75rem;
}

.status-dot {
  width: 6px;
  height: 6px;
  background: var(--primary-gold);
  border-radius: 50%;
  animation: statusPulse 2s ease-in-out infinite;
}

@keyframes statusPulse {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.5; }
}

/* OpenStreetMap */
.mobile-osm-map {
  width: 100%;
  height: 100%;
  cursor: grab !important;
}

.mobile-osm-map:active {
  cursor: grabbing !important;
}

/* Map Loading */
.map-loading {
  position: absolute;
  inset: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, #1a1a1a 0%, #0a0a0a 100%);
  z-index: 10;
}

.map-loading-content {
  text-align: center;
  color: var(--primary-light);
}

.map-loading-spinner {
  width: 50px;
  height: 50px;
  border: 3px solid var(--border-color);
  border-top: 3px solid var(--primary-gold);
  border-radius: 50%;
  animation: spin 1s linear infinite;
  margin: 0 auto 1rem;
}

@keyframes spin {
  to { transform: rotate(360deg); }
}

.map-loading-content h3 {
  font-size: 1.1rem;
  font-weight: 500;
  margin: 0 0 0.5rem 0;
}

.map-loading-content p {
  color: var(--text-gray);
  margin: 0;
  font-size: 0.9rem;
}

/* Enhanced Map Overlay */
.map-overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  z-index: 10;
  padding: 80px 20px 20px;
  pointer-events: none;
}

.map-overlay > * {
  pointer-events: auto;
}

/* Premium Search Bar */
.search-bar {
  display: flex;
  align-items: center;
  background: linear-gradient(135deg, 
    rgba(26, 26, 26, 0.95) 0%,
    rgba(164, 113, 72, 0.1) 100%);
  backdrop-filter: var(--backdrop-blur);
  border-radius: 50px;
  padding: 12px 20px;
  box-shadow: 
    0 10px 30px rgba(0, 0, 0, 0.3),
    0 0 0 1px rgba(164, 113, 72, 0.2);
  margin-bottom: 20px;
  border: 1px solid rgba(164, 113, 72, 0.3);
}

.search-icon {
  color: var(--primary-gold);
  margin-right: 12px;
}

.search-input {
  flex: 1;
  background: transparent;
  border: none;
  color: var(--primary-light);
  font-size: 1rem;
  outline: none;
  -webkit-appearance: none;
}

.search-input::placeholder {
  color: rgba(250, 250, 248, 0.5);
}

.clear-btn {
  width: 28px;
  height: 28px;
  border-radius: 50%;
  background: rgba(164, 113, 72, 0.2);
  border: none;
  color: var(--primary-light);
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.3s ease;
}

.clear-btn:active {
  transform: scale(0.9);
  background: rgba(164, 113, 72, 0.3);
}

/* Enhanced Location Button */
.location-btn.premium-btn {
  position: absolute;
  top: 0;
  right: 0;
  width: 48px;
  height: 48px;
  border-radius: 50%;
  background: linear-gradient(135deg, 
    rgba(26, 26, 26, 0.95) 0%,
    rgba(164, 113, 72, 0.1) 100%);
  backdrop-filter: var(--backdrop-blur);
  border: 2px solid rgba(164, 113, 72, 0.3);
  color: var(--primary-light);
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3);
  position: relative;
  overflow: hidden;
}

.btn-glow {
  position: absolute;
  inset: -2px;
  background: linear-gradient(135deg, transparent, rgba(164, 113, 72, 0.3), transparent);
  border-radius: 50%;
  opacity: 0;
  transition: opacity 0.3s ease;
}

.location-btn.active .btn-glow {
  opacity: 1;
}

.btn-pulse {
  position: absolute;
  inset: 0;
  border: 2px solid var(--primary-gold);
  border-radius: 50%;
  animation: btnPulse 2s ease-in-out infinite;
  opacity: 0;
}

.location-btn.pulsing .btn-pulse {
  opacity: 1;
}

@keyframes btnPulse {
  0% { transform: scale(1); opacity: 1; }
  100% { transform: scale(1.5); opacity: 0; }
}

.location-btn.active {
  background: linear-gradient(135deg, var(--primary-gold), #d4af37);
  color: var(--bg-dark);
  border-color: transparent;
}

/* Custom Leaflet Markers for Mobile */
:global(.custom-leaflet-marker-mobile) {
  background: transparent !important;
  border: none !important;
}

:global(.mobile-marker-container) {
  position: relative;
  width: 40px;
  height: 50px;
  cursor: pointer;
  transition: all 0.3s ease;
  display: flex;
  flex-direction: column;
  align-items: center;
}

:global(.mobile-marker-dot) {
  width: 32px;
  height: 32px;
  background: linear-gradient(135deg, var(--primary-gold), #d4af37);
  border-radius: 50% 50% 50% 0;
  transform: rotate(-45deg);
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 
    0 6px 20px rgba(164, 113, 72, 0.4),
    0 0 0 3px rgba(0, 0, 0, 0.2);
  z-index: 3;
  position: relative;
  transition: all 0.3s ease;
}

:global(.mobile-marker-dot .material-icons) {
  transform: rotate(45deg);
  color: var(--bg-dark);
  font-size: 16px;
}

:global(.mobile-marker-pulse) {
  position: absolute;
  top: 4px;
  left: 4px;
  width: 32px;
  height: 32px;
  border: 2px solid var(--primary-gold);
  border-radius: 50%;
  animation: mobileMarkerPulse 2.5s ease-in-out infinite;
  z-index: 1;
}

:global(.mobile-marker-pulse-2) {
  position: absolute;
  top: -4px;
  left: -4px;
  width: 48px;
  height: 48px;
  border: 1px solid var(--primary-gold);
  border-radius: 50%;
  animation: mobileMarkerPulse 2.5s ease-in-out infinite 0.5s;
  z-index: 1;
}

@keyframes mobileMarkerPulse {
  0% {
    transform: scale(1);
    opacity: 1;
  }
  100% {
    transform: scale(2);
    opacity: 0;
  }
}

:global(.mobile-marker-label) {
  position: absolute;
  bottom: -8px;
  left: 50%;
  transform: translateX(-50%);
  background: linear-gradient(135deg, rgba(0, 0, 0, 0.9), rgba(26, 26, 26, 0.9));
  color: var(--primary-light);
  padding: 4px 8px;
  border-radius: 12px;
  font-size: 0.65rem;
  font-weight: 500;
  white-space: nowrap;
  opacity: 0;
  transition: all 0.3s ease;
  box-shadow: 0 3px 10px rgba(0, 0, 0, 0.3);
  border: 1px solid rgba(164, 113, 72, 0.3);
  z-index: 4;
  pointer-events: none;
}

:global(.mobile-marker-container:hover .mobile-marker-label),
:global(.active .mobile-marker-label) {
  opacity: 1;
  transform: translateX(-50%) translateY(-5px);
}

:global(.mobile-marker-container:hover .mobile-marker-dot) {
  transform: rotate(-45deg) scale(1.1);
  box-shadow: 0 8px 25px rgba(164, 113, 72, 0.6);
  background: linear-gradient(135deg, #d4af37, var(--primary-gold));
}

:global(.active .mobile-marker-dot) {
  background: linear-gradient(135deg, var(--primary-light), var(--primary-gold));
  transform: rotate(-45deg) scale(1.2);
  box-shadow: 0 10px 30px rgba(250, 250, 248, 0.9);
  animation: mobileMarkerBounce 0.5s ease;
}

@keyframes mobileMarkerBounce {
  0%, 100% { transform: rotate(-45deg) scale(1.2); }
  50% { transform: rotate(-45deg) scale(1.4); }
}

/* Enhanced Map Instructions */
.map-instructions {
  position: absolute;
  bottom: 2rem;
  right: 0;
  z-index: 100;
}

.instruction-tooltip {
  position: relative;
}

.tooltip-content {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.75rem 1.25rem;
  background: linear-gradient(135deg, rgba(0, 0, 0, 0.9), rgba(26, 26, 26, 0.9));
  border: 2px solid var(--primary-gold);
  border-radius: 50px;
  color: var(--primary-gold);
  font-size: 0.8rem;
  font-weight: 600;
  backdrop-filter: var(--backdrop-blur);
  animation: tooltipFloat 3s ease-in-out infinite;
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.5);
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

.tooltip-glow {
  position: absolute;
  inset: -3px;
  background: linear-gradient(135deg, transparent, rgba(164, 113, 72, 0.3), transparent);
  border-radius: 50px;
  animation: tooltipGlow 3s ease-in-out infinite;
}

@keyframes tooltipGlow {
  0%, 100% { opacity: 0.3; }
  50% { opacity: 0.7; }
}

/* REDESIGNED LOCATION DETAIL MODAL */
.location-detail.premium-modal {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  background: linear-gradient(135deg, rgba(10, 10, 10, 0.98) 0%, rgba(26, 26, 26, 0.98) 100%);
  backdrop-filter: var(--backdrop-blur);
  border-top-left-radius: 24px;
  border-top-right-radius: 24px;
  z-index: 20;
  max-height: 85vh;
  overflow: hidden;
  box-shadow: 0 -8px 30px rgba(0, 0, 0, 0.5);
  border: 1px solid rgba(164, 113, 72, 0.2);
}

/* Modal Background */
.modal-background {
  position: absolute;
  inset: 0;
  overflow: hidden;
  border-radius: 24px 24px 0 0;
}

.bg-gradient-1 {
  position: absolute;
  top: -50%;
  left: -50%;
  width: 200%;
  height: 200%;
  background: radial-gradient(circle at 30% 20%, rgba(164, 113, 72, 0.08) 0%, transparent 70%);
  animation: floatBg1 15s ease-in-out infinite;
}

.bg-gradient-2 {
  position: absolute;
  top: -50%;
  right: -50%;
  width: 200%;
  height: 200%;
  background: radial-gradient(circle at 70% 80%, rgba(255, 215, 0, 0.05) 0%, transparent 70%);
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
  width: 2px;
  height: 2px;
  background: rgba(164, 113, 72, 0.4);
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
    transform: translateY(-60px) scale(1);
  }
}

/* Enhanced Close Button */
.detail-close.premium-close {
  position: absolute;
  top: 12px;
  left: 50%;
  transform: translateX(-50%);
  width: 40px;
  height: 24px;
  border-radius: 16px;
  background: linear-gradient(135deg, rgba(255, 255, 255, 0.08), rgba(164, 113, 72, 0.1));
  backdrop-filter: blur(10px);
  border: 1px solid rgba(164, 113, 72, 0.2);
  color: var(--text-light);
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  z-index: 1;
  transition: all 0.3s ease;
  position: relative;
  overflow: hidden;
}

.close-glow {
  position: absolute;
  inset: 0;
  background: linear-gradient(135deg, transparent, rgba(164, 113, 72, 0.2), transparent);
  opacity: 0;
  transition: opacity 0.3s ease;
}

.detail-close:active .close-glow {
  opacity: 1;
}

.detail-close:active {
  transform: translateX(-50%) scale(0.9);
  background: rgba(164, 113, 72, 0.15);
}

.detail-close .material-icons {
  font-size: 18px;
}

/* Detail Container */
.detail-container {
  padding: 48px 20px 20px;
  height: 85vh;
  overflow-y: auto;
  -webkit-overflow-scrolling: touch;
  position: relative;
  z-index: 2;
}

/* Compact Header */
.detail-header-compact {
  display: flex;
  align-items: flex-start;
  gap: 16px;
  margin-bottom: 24px;
  padding-bottom: 20px;
  border-bottom: 1px solid rgba(164, 113, 72, 0.15);
}

.location-icon-small {
  width: 52px;
  height: 52px;
  background: linear-gradient(135deg, var(--primary-gold), #d4af37);
  border-radius: 16px;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
  box-shadow: 0 8px 20px rgba(164, 113, 72, 0.3);
}

.location-icon-small .material-icons {
  font-size: 28px;
  color: var(--bg-dark);
}

.location-info {
  flex: 1;
}

.location-info h2 {
  font-size: 1.5rem;
  font-weight: 300;
  margin: 0 0 4px;
  color: var(--primary-light);
}

.location-subtitle {
  font-size: 0.9rem;
  color: var(--primary-gold);
  margin: 0 0 8px;
}

.location-status {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 0.8rem;
  color: var(--text-gray);
}

.status-indicator {
  width: 8px;
  height: 8px;
  background: #ff6b6b;
  border-radius: 50%;
  animation: statusBlink 2s ease-in-out infinite;
}

.location-status.open .status-indicator {
  background: #4caf50;
}

@keyframes statusBlink {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.5; }
}

.distance {
  margin-left: auto;
  color: var(--primary-gold);
  font-weight: 500;
}

/* Redesigned Quick Actions */
.quick-actions-redesigned {
  display: flex;
  flex-direction: column;
  gap: 12px;
  margin-bottom: 24px;
}

.action-card {
  display: flex;
  align-items: center;
  gap: 16px;
  padding: 16px;
  background: linear-gradient(135deg, 
    rgba(255, 255, 255, 0.04), 
    rgba(164, 113, 72, 0.08));
  border: 1px solid rgba(164, 113, 72, 0.15);
  border-radius: 16px;
  cursor: pointer;
  transition: all 0.3s ease;
  position: relative;
  overflow: hidden;
}

.action-card:active {
  transform: scale(0.98);
  background: rgba(164, 113, 72, 0.15);
}

.action-card.primary-action {
  background: linear-gradient(135deg, var(--primary-gold), #d4af37);
  border-color: transparent;
}

.action-card.primary-action .action-text {
  color: var(--bg-dark);
}

.action-card.primary-action .action-icon-new {
  background: rgba(0, 0, 0, 0.1);
}

.action-card.primary-action .action-icon-new .material-icons {
  color: var(--bg-dark);
}

.action-icon-new {
  width: 44px;
  height: 44px;
  background: rgba(164, 113, 72, 0.15);
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}

.action-icon-new .material-icons {
  color: var(--primary-gold);
  font-size: 20px;
}

.action-text {
  display: flex;
  flex-direction: column;
  gap: 2px;
  color: var(--primary-light);
}

.action-title {
  font-size: 0.95rem;
  font-weight: 500;
}

.action-subtitle {
  font-size: 0.75rem;
  color: var(--text-gray);
}

.action-card.primary-action .action-subtitle {
  color: rgba(0, 0, 0, 0.7);
}

/* Information Cards */
.info-cards {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.info-card {
  background: rgba(255, 255, 255, 0.02);
  border: 1px solid rgba(164, 113, 72, 0.1);
  border-radius: 16px;
  padding: 16px;
  backdrop-filter: blur(10px);
}

.card-header {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 12px;
}

.card-header .material-icons {
  color: var(--primary-gold);
  font-size: 20px;
}

.card-header h4 {
  font-size: 1rem;
  font-weight: 500;
  color: var(--primary-light);
  margin: 0;
  flex: 1;
}

.hours-toggle {
  width: 32px;
  height: 32px;
  background: rgba(164, 113, 72, 0.1);
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.3s ease;
}

.hours-toggle:active {
  background: rgba(164, 113, 72, 0.2);
  transform: scale(0.9);
}

.hours-toggle .material-icons {
  color: var(--primary-gold);
  font-size: 18px;
}

.card-description,
.card-address {
  color: var(--text-light);
  line-height: 1.5;
  margin: 0;
  font-size: 0.9rem;
}

/* Hours Grid */
.hours-grid {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.hours-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 8px 12px;
  background: rgba(255, 255, 255, 0.02);
  border-radius: 8px;
  font-size: 0.8rem;
  color: var(--text-gray);
}

.hours-item.today {
  background: rgba(164, 113, 72, 0.15);
  color: var(--primary-light);
}

.day-label {
  font-weight: 500;
}

.hours-label {
  color: var(--text-light);
}

.hours-item.today .hours-label {
  color: var(--primary-gold);
}

/* Features List */
.features-list {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.feature-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 8px 0;
  color: var(--text-light);
  font-size: 0.85rem;
}

.feature-item .material-icons {
  color: var(--primary-gold);
  font-size: 16px;
}

/* Loading State */
.loading-overlay.premium-loading {
  position: absolute;
  inset: 0;
  background: linear-gradient(135deg, rgba(0, 0, 0, 0.95) 0%, rgba(26, 26, 26, 0.95) 100%);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 100;
}

.loading-background {
  position: absolute;
  inset: 0;
}

.loading-orb-1,
.loading-orb-2 {
  position: absolute;
  border-radius: 50%;
  filter: blur(30px);
}

.loading-orb-1 {
  width: 150px;
  height: 150px;
  background: radial-gradient(circle, rgba(164, 113, 72, 0.4) 0%, transparent 70%);
  top: 30%;
  left: 20%;
  animation: loadingOrb 8s ease-in-out infinite;
}

.loading-orb-2 {
  width: 100px;
  height: 100px;
  background: radial-gradient(circle, rgba(255, 215, 0, 0.3) 0%, transparent 70%);
  bottom: 30%;
  right: 20%;
  animation: loadingOrb 6s ease-in-out infinite reverse;
}

@keyframes loadingOrb {
  0%, 100% { transform: translate(0, 0) scale(1); }
  50% { transform: translate(20px, -20px) scale(1.1); }
}

.loading-content {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 16px;
  z-index: 2;
}

.loading-spinner.premium-spinner {
  position: relative;
  width: 60px;
  height: 60px;
}

.spinner-ring {
  position: absolute;
  inset: 0;
  border: 2px solid transparent;
  border-radius: 50%;
  animation: spin 2s linear infinite;
}

.ring-1 {
  border-top-color: var(--primary-gold);
  animation-duration: 1s;
}

.ring-2 {
  inset: 8px;
  border-top-color: rgba(164, 113, 72, 0.5);
  animation-duration: 1.5s;
  animation-direction: reverse;
}

.ring-3 {
  inset: 16px;
  border-top-color: rgba(164, 113, 72, 0.3);
  animation-duration: 2s;
}

.loading-content h3 {
  color: var(--primary-light);
  font-size: 1.1rem;
  font-weight: 500;
  margin: 0;
  text-align: center;
}

.loading-content p {
  color: var(--text-gray);
  margin: 0;
  font-size: 0.9rem;
}

/* Distance Toast */
.distance-toast.premium-toast {
  position: fixed;
  top: calc(env(safe-area-inset-top) + 220px);
  left: 50%;
  transform: translateX(-50%);
  background: linear-gradient(135deg, rgba(26, 26, 26, 0.95), rgba(164, 113, 72, 0.1));
  backdrop-filter: var(--backdrop-blur);
  color: var(--primary-light);
  padding: 12px 20px;
  border-radius: 50px;
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 0.8rem;
  font-weight: 500;
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3);
  border: 1px solid rgba(164, 113, 72, 0.3);
  z-index: 30;
  position: relative;
  overflow: hidden;
}

.toast-glow {
  position: absolute;
  inset: 0;
  background: linear-gradient(135deg, transparent, rgba(164, 113, 72, 0.2), transparent);
  border-radius: 50px;
  animation: toastGlow 3s ease-in-out infinite;
}

@keyframes toastGlow {
  0%, 100% { opacity: 0.3; }
  50% { opacity: 0.7; }
}

.distance-toast .material-icons {
  color: var(--primary-gold);
  font-size: 16px;
  z-index: 2;
}

.distance-toast span:last-child {
  z-index: 2;
}

/* Transitions */
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
  transform: translateY(100%);
}

.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}

.toast-enter-active,
.toast-leave-active {
  transition: all 0.3s ease;
}

.toast-enter-from {
  opacity: 0;
  transform: translateX(-50%) translateY(-20px) scale(0.9);
}

.toast-leave-to {
  opacity: 0;
  transform: translateX(-50%) translateY(-20px) scale(0.9);
}

/* Safe Area Support */
@supports (padding: max(0px)) {
  .status-overlay {
    padding-top: max(1rem, env(safe-area-inset-top));
  }
  
  .detail-container {
    padding-bottom: max(20px, calc(20px + env(safe-area-inset-bottom)));
  }
}

/* Responsive Design */
@media (max-width: 480px) {
  .section-badge.premium {
    padding: 0.5rem 1rem;
    font-size: 0.7rem;
  }
  
  .mobile-selection-guide {
    padding: calc(env(safe-area-inset-top) + 80px) 12px 10px;
  }
  
  .guide-container {
    padding: 12px 10px 8px;
  }
  
  .guide-header h3 {
    font-size: 0.85rem;
  }
  
  .guide-header p {
    font-size: 0.65rem;
  }
  
  .step-number {
    width: 24px;
    height: 24px;
    font-size: 0.7rem;
  }
  
  .step-content h4 {
    font-size: 0.6rem;
  }
  
  .step-content p {
    font-size: 0.5rem;
  }
  
  .step-icon {
    width: 14px;
    height: 14px;
  }
  
  .step-icon .material-icons {
    font-size: 9px;
  }
  
  .step-connector {
    margin: 0 3px;
  }
  
  .connector-line {
    width: 10px;
  }
  
  .connector-arrow .material-icons {
    font-size: 9px;
  }
  
  .map-container {
    height: calc(100vh - 160px);
  }
  
  .map-header {
    padding: 0.75rem 1rem;
  }
  
  .map-title h3 {
    font-size: 0.9rem;
  }
  
  .search-bar {
    padding: 10px 16px;
    margin-bottom: 16px;
  }
  
  .location-btn.premium-btn {
    width: 44px;
    height: 44px;
  }
  
  .location-icon-small {
    width: 48px;
    height: 48px;
  }
  
  .location-icon-small .material-icons {
    font-size: 24px;
  }
  
  .location-info h2 {
    font-size: 1.3rem;
  }
  
  .action-card {
    padding: 14px;
  }
  
  .action-icon-new {
    width: 40px;
    height: 40px;
  }
  
  .action-icon-new .material-icons {
    font-size: 18px;
  }
  
  .distance-toast.premium-toast {
    top: calc(env(safe-area-inset-top) + 220px);
  }
}

/* Landscape Mode */
@media (orientation: landscape) and (max-height: 500px) {
  .mobile-selection-guide {
    display: none; /* Hide guide in landscape mode on small screens */
  }
  
  .map-container {
    height: calc(100vh - 80px);
  }
  
  .location-detail.premium-modal {
    max-height: 90vh;
  }
  
  .detail-container {
    height: 90vh;
  }
}

/* Extra Large Mobile Screens */
@media (min-width: 481px) and (max-width: 768px) {
  .guide-header h3 {
    font-size: 1rem;
  }
  
  .guide-header p {
    font-size: 0.75rem;
  }
  
  .step-content h4 {
    font-size: 0.7rem;
  }
  
  .step-content p {
    font-size: 0.6rem;
  }
  
  .step-connector {
    margin: 0 6px;
  }
  
  .connector-line {
    width: 16px;
  }
}
</style>