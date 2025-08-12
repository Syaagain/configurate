<template>
  <div class="mobile-interactive-map">
    <!-- Google Maps Container -->
    <div ref="mapContainer" class="map-container">
      <!-- Actual Google Maps -->
      <iframe
        :src="`https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d5570665.339444434!2d5.866341973291837!3d50.503887287677804!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x479e75f9a38c5fd9%3A0x10cb84a7db1987d!2sMunich%2C%20Germany!5e0!3m2!1sen!2sus!4v1706285439215!5m2!1sen!2sus&zoom=${mapZoom}&center=${mapCenter.lat},${mapCenter.lng}`"
        width="100%"
        height="100%"
        style="border:0; filter: grayscale(50%) contrast(1.1);"
        allowfullscreen=""
        loading="lazy"
        referrerpolicy="no-referrer-when-downgrade"
        :class="['google-map-iframe', mapStyleClass]"
      ></iframe>

      <!-- Custom Map Overlay -->
      <div class="map-overlay">

        <!-- Location Toggle -->
        <button 
          @click="getCurrentLocation"
          :class="['location-btn', { active: trackingLocation, pulsing: findingLocation }]"
        >
          <span class="material-icons">{{ trackingLocation ? 'my_location' : 'location_searching' }}</span>
        </button>

        <!-- Map Controls -->
        <div class="map-controls">
          <button @click="zoomIn" class="control-btn">
            <span class="material-icons">add</span>
          </button>
          <button @click="zoomOut" class="control-btn">
            <span class="material-icons">remove</span>
          </button>
        </div>
      </div>

      <!-- Custom Animated Markers -->
      <div 
        v-for="location in filteredLocations"
        :key="location.id"
        :class="['custom-marker', { active: selectedLocation?.id === location.id }]"
        :style="getMarkerPosition(location)"
        @click="selectLocation(location)"
      >
        <div class="marker-container">
          <div class="marker-pulse"></div>
          <div class="marker-pulse-2"></div>
          <div class="marker-pin">
            <span class="material-icons">{{ location.icon }}</span>
          </div>
          <div class="marker-shadow"></div>
        </div>
        <div class="marker-label">{{ location.city }}</div>
      </div>

      <!-- User Location Marker -->
      <div 
        v-if="userLocation.lat"
        class="user-marker"
        :style="getUserMarkerPosition()"
      >
        <div class="user-pulse"></div>
        <div class="user-pulse-2"></div>
        <div class="user-dot">
          <span class="material-icons">person_pin</span>
        </div>
      </div>
    </div>

    <!-- Selected Location Detail (Fullscreen) -->
    <Transition name="slide-up">
      <div v-if="selectedLocation && !listExpanded" class="location-detail">
        <button @click="selectedLocation = null" class="detail-close">
          <span class="material-icons">expand_more</span>
        </button>

        <div class="detail-header">
          <div class="detail-image">
            <div class="location-type-badge">{{ selectedLocation.type }}</div>
            <div class="location-icon">
              <span class="material-icons">{{ selectedLocation.icon }}</span>
            </div>
          </div>
          <div class="detail-title">
            <h2>{{ selectedLocation.city }}</h2>
            <p>{{ selectedLocation.country }}</p>
            <div class="location-type">
              <span class="material-icons">{{ selectedLocation.icon }}</span>
              <span>{{ selectedLocation.type }}</span>
            </div>
          </div>
        </div>

        <div class="detail-content">
          <!-- Quick Actions -->
          <div class="quick-actions">
            <button @click="getDirections(selectedLocation)" class="quick-action">
              <div class="action-icon">
                <span class="material-icons">navigation</span>
              </div>
              <span>Route</span>
            </button>
            <button @click="callLocation(selectedLocation)" class="quick-action" v-if="selectedLocation.phone">
              <div class="action-icon">
                <span class="material-icons">phone</span>
              </div>
              <span>Anrufen</span>
            </button>
            <button @click="bookAppointment(selectedLocation)" class="quick-action" v-if="selectedLocation.bookingAvailable">
              <div class="action-icon">
                <span class="material-icons">event</span>
              </div>
              <span>Termin</span>
            </button>
            <button @click="shareLocation(selectedLocation)" class="quick-action">
              <div class="action-icon">
                <span class="material-icons">share</span>
              </div>
              <span>Teilen</span>
            </button>
          </div>

          <div class="detail-section">
            <h4>
              <span class="material-icons">info</span>
              Über diesen Standort
            </h4>
            <p>{{ selectedLocation.description }}</p>
          </div>

          <div class="detail-section" v-if="selectedLocation.address">
            <h4>
              <span class="material-icons">location_on</span>
              Adresse
            </h4>
            <p>{{ selectedLocation.address }}</p>
          </div>

          <div class="detail-section" v-if="selectedLocation.openingHours">
            <h4>
              <span class="material-icons">schedule</span>
              Öffnungszeiten
              <span class="status-badge" :class="{ open: isOpen(selectedLocation) }">
                {{ isOpen(selectedLocation) ? 'Geöffnet' : 'Geschlossen' }}
              </span>
            </h4>
            <div class="opening-hours">
              <div 
                v-for="(hours, day) in selectedLocation.openingHours" 
                :key="day"
                class="hours-row"
                :class="{ today: isToday(day) }"
              >
                <span class="day">{{ day }}</span>
                <span class="hours">{{ hours }}</span>
              </div>
            </div>
          </div>

          <div class="detail-section" v-if="selectedLocation.features">
            <h4>
              <span class="material-icons">star</span>
              Highlights
            </h4>
            <div class="highlights-grid">
              <div v-for="feature in selectedLocation.features" :key="feature" class="highlight-item">
                <div class="highlight-icon">
                  <span class="material-icons">check_circle</span>
                </div>
                <span>{{ feature }}</span>
              </div>
            </div>
          </div>

          <div class="detail-actions">
            <button @click="getDirections(selectedLocation)" class="detail-btn primary">
              <span class="material-icons">navigation</span>
              Navigation starten
            </button>
            <button @click="bookAppointment(selectedLocation)" v-if="selectedLocation.bookingAvailable" class="detail-btn secondary">
              <span class="material-icons">calendar_today</span>
              Termin vereinbaren
            </button>
          </div>
        </div>
      </div>
    </Transition>

    <!-- Loading State -->
    <Transition name="fade">
      <div v-if="isLoading" class="loading-overlay">
        <div class="loading-content">
          <div class="loading-spinner"></div>
          <p>Lade Standorte...</p>
        </div>
      </div>
    </Transition>

    <!-- Distance Info Toast -->
    <Transition name="toast">
      <div v-if="showDistanceToast" class="distance-toast">
        <span class="material-icons">info</span>
        <span>{{ distanceMessage }}</span>
      </div>
    </Transition>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, reactive, watch } from 'vue'

// Refs
const mapContainer = ref(null)
const searchQuery = ref('')
const selectedLocation = ref(null)
const currentStyle = ref('default')
const listExpanded = ref(false)
const trackingLocation = ref(false)
const findingLocation = ref(false)
const isLoading = ref(true)
const mapZoom = ref(10)
const showDistanceToast = ref(false)
const distanceMessage = ref('')

// Map Center
const mapCenter = reactive({
  lat: 48.1351,
  lng: 11.5820
})

// Touch handling
const touchStart = ref(0)
const touchEnd = ref(0)

// User location
const userLocation = reactive({
  lat: null,
  lng: null
})

// Locations with same data structure as about page
const locations = ref([
  {
    id: 1,
    city: 'München',
    country: 'Deutschland',
    mapX: 60,
    mapY: 55,
    lat: 48.1351,
    lng: 11.5820,
    type: 'Showroom & Hauptsitz',
    icon: 'business',
    description: '2500m² Showroom mit Europas größter Natursteinauswahl',
    address: 'Am Hohenrand 9, 82335 Berg',
    phone: '+49 8171 / 3868770',
    bookingAvailable: true,
    features: ['2500m² Ausstellungsfläche', '3D-Planung', 'Barrierefreier Zugang', 'Kostenlose Parkplätze'],
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
    mapX: 40,
    mapY: 40,
    lat: 51.2277,
    lng: 6.7735,
    type: 'Showroom & Lager',
    icon: 'warehouse',
    description: '80.000m² Lagerfläche für sofortige Verfügbarkeit',
    address: 'Düsseldorf, Deutschland',
    phone: '+49 2131 / 1234567',
    bookingAvailable: true,
    features: ['Europas größte Auswahl', '80.000m² Lagerfläche', 'Premium Materialien', 'VIP-Beratung'],
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
    mapX: 55,
    mapY: 65,
    lat: 47.3769,
    lng: 8.5417,
    type: 'Vertriebsbüro',
    icon: 'store',
    description: 'Beratung und Vertrieb für die Schweiz',
    address: 'Zürich, Schweiz',
    bookingAvailable: true,
    features: ['Persönliche Beratung', 'Schweizer Standards', 'Lokaler Service'],
    distance: null
  },
  {
    id: 4,
    city: 'Côte d\'Azur',
    country: 'Frankreich',
    mapX: 45,
    mapY: 75,
    lat: 43.7102,
    lng: 7.2620,
    type: 'Partner Showroom',
    icon: 'handshake',
    description: 'Exklusive Präsenz an der französischen Riviera',
    address: 'Nice, Frankreich',
    bookingAvailable: false,
    features: ['Exklusive Materialien', 'Luxus-Segment', 'Französische Riviera'],
    distance: null
  },
  {
    id: 5,
    city: 'Bergamo',
    country: 'Italien',
    mapX: 58,
    mapY: 70,
    lat: 45.6983,
    lng: 9.6773,
    type: 'Produktionspartner',
    icon: 'factory',
    description: 'Direkte Zusammenarbeit mit italienischen Steinbrüchen',
    address: 'Bergamo, Italien',
    bookingAvailable: false,
    features: ['Direkte Produktion', 'Italienische Qualität', 'Steinbruch-Zugang'],
    distance: null
  }
])

// Computed
const mapStyleClass = computed(() => {
  const styles = {
    default: '',
    satellite: 'map-satellite',
    dark: 'map-dark'
  }
  return styles[currentStyle.value]
})

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

// Methods
const getMarkerPosition = (location) => {
  return { left: location.mapX + '%', top: location.mapY + '%' }
}

const getUserMarkerPosition = () => {
  return { left: '50%', top: '50%' }
}

const selectLocation = (location) => {
  selectedLocation.value = location
  listExpanded.value = false
  
  // Center map on location
  if (location.lat && location.lng) {
    mapCenter.lat = location.lat
    mapCenter.lng = location.lng
    mapZoom.value = 14
  }
  
  // Haptic feedback
  if (navigator.vibrate) {
    navigator.vibrate(50)
  }
}

const isOpen = (location) => {
  if (!location.openingHours) return false
  
  const now = new Date()
  const day = now.getDay()
  const days = ['So', 'Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa']
  const currentDay = days[day]
  
  // Simple check - would be more complex in production
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
      // Haversine formula for distance calculation
      const R = 6371 // Earth's radius in km
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
  // Navigate to booking page
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

const setMapStyle = (styleId) => {
  currentStyle.value = styleId
}

const zoomIn = () => {
  mapZoom.value = Math.min(mapZoom.value + 1, 20)
}

const zoomOut = () => {
  mapZoom.value = Math.max(mapZoom.value - 1, 5)
}

const handleSearch = () => {
  // Search logic is handled by computed property
}

const clearSearch = () => {
  searchQuery.value = ''
}

const isToday = (day) => {
  const days = ['So', 'Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa']
  const today = days[new Date().getDay()]
  return day.includes(today)
}

// Touch handlers for swipe
const handleTouchStart = (e) => {
  touchStart.value = e.targetTouches[0].clientY
}

const handleTouchMove = (e) => {
  touchEnd.value = e.targetTouches[0].clientY
}

const handleTouchEnd = () => {
  if (!touchStart.value || !touchEnd.value) return
  
  const distance = touchStart.value - touchEnd.value
  const isSwipeUp = distance > 50
  const isSwipeDown = distance < -50
  
  if (isSwipeUp) {
    listExpanded.value = true
  }
  if (isSwipeDown && listExpanded.value) {
    listExpanded.value = false
  }
}

// Lifecycle
onMounted(() => {
  setTimeout(() => {
    isLoading.value = false
    getCurrentLocation()
  }, 1500)
})

// Watch for location changes
watch(trackingLocation, (newVal) => {
  if (newVal) {
    // Update map center to user location
    if (userLocation.lat && userLocation.lng) {
      mapCenter.lat = userLocation.lat
      mapCenter.lng = userLocation.lng
    }
  }
})
</script>

<style scoped>
.mobile-interactive-map {
  position: relative;
  width: 100%;
  height: 100vh;
  height: 100dvh;
  background: #000;
  overflow: hidden;
}

/* Map Container */
.map-container {
  position: relative;
  width: 100%;
  height: 100%;
}

/* Google Maps Iframe */
.google-map-iframe {
  width: 100%;
  height: 100%;
  transition: filter 0.3s ease;
}

.google-map-iframe.map-satellite {
  filter: none !important;
}

.google-map-iframe.map-dark {
  filter: grayscale(100%) invert(100%) contrast(1.2) !important;
}

/* Map Overlay */
.map-overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  z-index: 10;
  padding: env(safe-area-inset-top) 20px 20px;
  pointer-events: none;
}

.map-overlay > * {
  pointer-events: auto;
}

/* Search Bar */
.search-bar {
  display: flex;
  align-items: center;
  background: rgba(26, 26, 26, 0.95);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border-radius: 50px;
  padding: 14px 20px;
  box-shadow: 
    0 10px 30px rgba(0, 0, 0, 0.3),
    0 0 0 1px rgba(164, 113, 72, 0.1);
  margin-top: 20px;
}

.search-icon {
  color: #a47148;
  margin-right: 12px;
  font-size: 22px;
}

.search-input {
  flex: 1;
  background: transparent;
  border: none;
  color: #FAFAF8;
  font-size: 1rem;
  outline: none;
  -webkit-appearance: none;
}

.search-input::placeholder {
  color: rgba(250, 250, 248, 0.5);
}

.clear-btn {
  width: 32px;
  height: 32px;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.1);
  border: none;
  color: #FAFAF8;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.3s ease;
}

.clear-btn:active {
  transform: scale(0.9);
  background: rgba(255, 255, 255, 0.2);
}

/* Location Button */
.location-btn {
  position: absolute;
  top: calc(env(safe-area-inset-top) + 90px);
  right: 20px;
  width: 48px;
  height: 48px;
  border-radius: 50%;
  background: rgba(26, 26, 26, 0.95);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border: 2px solid rgba(164, 113, 72, 0.2);
  color: #FAFAF8;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow: 0 5px 20px rgba(0, 0, 0, 0.3);
}

.location-btn.active {
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  color: #000;
  border-color: transparent;
}

.location-btn.pulsing {
  animation: locationPulse 1s ease-in-out infinite;
}

@keyframes locationPulse {
  0%, 100% { transform: scale(1); }
  50% { transform: scale(1.1); }
}

.location-btn:active {
  transform: scale(0.9);
}

/* Map Controls */
.map-controls {
  position: absolute;
  top: calc(env(safe-area-inset-top) + 150px);
  right: 20px;
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.control-btn {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background: rgba(26, 26, 26, 0.95);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border: 1px solid rgba(164, 113, 72, 0.2);
  color: #FAFAF8;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow: 0 3px 10px rgba(0, 0, 0, 0.3);
}

.control-btn:active {
  transform: scale(0.9);
  background: rgba(164, 113, 72, 0.3);
}

/* Style Toggle */
.style-toggle {
  position: absolute;
  top: calc(env(safe-area-inset-top) + 250px);
  right: 20px;
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.style-btn {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background: rgba(26, 26, 26, 0.95);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border: 1px solid rgba(164, 113, 72, 0.2);
  color: #FAFAF8;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow: 0 3px 10px rgba(0, 0, 0, 0.3);
}

.style-btn.active {
  background: rgba(164, 113, 72, 0.3);
  color: #a47148;
  border-color: #a47148;
}

/* Custom Animated Markers */
.custom-marker {
  position: absolute;
  transform: translate(-50%, -100%);
  cursor: pointer;
  z-index: 5;
  transition: all 0.3s ease;
}

.marker-container {
  position: relative;
  width: 50px;
  height: 50px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.marker-pin {
  position: relative;
  width: 40px;
  height: 40px;
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  border-radius: 50% 50% 50% 0;
  transform: rotate(-45deg);
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 
    0 5px 20px rgba(164, 113, 72, 0.4),
    0 0 0 3px rgba(0, 0, 0, 0.2);
  z-index: 2;
}

.marker-pin .material-icons {
  transform: rotate(45deg);
  color: #000;
  font-size: 20px;
}

.marker-pulse {
  position: absolute;
  inset: -10px;
  border: 2px solid #a47148;
  border-radius: 50%;
  animation: markerPulse 2s ease-in-out infinite;
}

.marker-pulse-2 {
  position: absolute;
  inset: -20px;
  border: 1px solid #a47148;
  border-radius: 50%;
  animation: markerPulse 2s ease-in-out infinite 0.5s;
}

@keyframes markerPulse {
  0% {
    transform: scale(1);
    opacity: 1;
  }
  100% {
    transform: scale(2);
    opacity: 0;
  }
}

.marker-shadow {
  position: absolute;
  bottom: -5px;
  left: 50%;
  transform: translateX(-50%);
  width: 20px;
  height: 5px;
  background: rgba(0, 0, 0, 0.3);
  border-radius: 50%;
  filter: blur(3px);
}

.custom-marker.active .marker-pin {
  animation: markerBounce 0.5s ease;
  background: linear-gradient(135deg, #FAFAF8, #a47148);
}

@keyframes markerBounce {
  0%, 100% { transform: rotate(-45deg) scale(1); }
  50% { transform: rotate(-45deg) scale(1.2); }
}

.marker-label {
  position: absolute;
  bottom: -30px;
  left: 50%;
  transform: translateX(-50%);
  background: rgba(0, 0, 0, 0.9);
  color: #FAFAF8;
  padding: 6px 12px;
  border-radius: 20px;
  font-size: 0.75rem;
  font-weight: 500;
  white-space: nowrap;
  opacity: 0;
  transition: opacity 0.3s ease;
  box-shadow: 0 3px 10px rgba(0, 0, 0, 0.3);
  border: 1px solid rgba(164, 113, 72, 0.3);
}

.custom-marker:hover .marker-label,
.custom-marker.active .marker-label {
  opacity: 1;
}

/* User Location Marker */
.user-marker {
  position: absolute;
  transform: translate(-50%, -50%);
  z-index: 4;
}

.user-dot {
  width: 24px;
  height: 24px;
  background: linear-gradient(135deg, #4285F4, #1976D2);
  border: 3px solid white;
  border-radius: 50%;
  box-shadow: 
    0 3px 15px rgba(66, 133, 244, 0.5),
    0 0 0 1px rgba(0, 0, 0, 0.1);
  display: flex;
  align-items: center;
  justify-content: center;
}

.user-dot .material-icons {
  font-size: 14px;
  color: white;
}

.user-pulse,
.user-pulse-2 {
  position: absolute;
  inset: -15px;
  border: 2px solid #4285F4;
  border-radius: 50%;
  animation: userPulse 2s ease-in-out infinite;
}

.user-pulse-2 {
  inset: -25px;
  animation-delay: 0.5s;
  border-width: 1px;
}

@keyframes userPulse {
  0%, 100% { 
    transform: scale(1); 
    opacity: 0.8; 
  }
  50% { 
    transform: scale(1.5); 
    opacity: 0; 
  }
}

/* Locations List */
.locations-list {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  background: linear-gradient(135deg, rgba(26, 26, 26, 0.98) 0%, rgba(10, 10, 10, 0.98) 100%);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border-top-left-radius: 24px;
  border-top-right-radius: 24px;
  transform: translateY(calc(100% - 80px));
  transition: transform 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  z-index: 15;
  max-height: 70vh;
  box-shadow: 0 -5px 30px rgba(0, 0, 0, 0.3);
}

.locations-list.expanded {
  transform: translateY(0);
}

.list-handle {
  padding: 20px;
  cursor: pointer;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
  border-bottom: 1px solid rgba(164, 113, 72, 0.1);
}

.handle-bar {
  width: 48px;
  height: 4px;
  background: rgba(164, 113, 72, 0.5);
  border-radius: 2px;
}

.handle-text {
  color: #a47148;
  font-size: 0.875rem;
  font-weight: 500;
  display: flex;
  align-items: center;
  gap: 6px;
}

.handle-text .material-icons {
  font-size: 16px;
}

.list-content {
  padding: 20px;
  overflow-y: auto;
  max-height: calc(70vh - 80px);
  -webkit-overflow-scrolling: touch;
}

/* Location Card */
.location-card {
  display: flex;
  gap: 16px;
  padding: 16px;
  background: rgba(255, 255, 255, 0.05);
  border-radius: 16px;
  margin-bottom: 12px;
  cursor: pointer;
  transition: all 0.3s ease;
  border: 1px solid rgba(164, 113, 72, 0.1);
}

.location-card:active {
  transform: scale(0.98);
}

.location-card.selected {
  background: rgba(164, 113, 72, 0.2);
  border-color: rgba(164, 113, 72, 0.3);
}

.location-image {
  position: relative;
  width: 80px;
  height: 80px;
  border-radius: 12px;
  overflow: hidden;
  flex-shrink: 0;
}

.location-icon-bg {
  width: 100%;
  height: 100%;
  background: linear-gradient(135deg, rgba(164, 113, 72, 0.2), rgba(255, 255, 255, 0.1));
  display: flex;
  align-items: center;
  justify-content: center;
}

.location-icon-bg .material-icons {
  font-size: 2rem;
  color: #a47148;
}

.distance-badge {
  position: absolute;
  top: 4px;
  right: 4px;
  background: rgba(0, 0, 0, 0.9);
  color: #a47148;
  padding: 2px 6px;
  border-radius: 8px;
  font-size: 0.6rem;
  font-weight: 600;
  display: flex;
  align-items: center;
  gap: 2px;
  border: 1px solid rgba(164, 113, 72, 0.3);
}

.distance-badge .material-icons {
  font-size: 10px;
}

.location-info {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.info-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
}

.location-info h3 {
  font-size: 1.125rem;
  font-weight: 400;
  color: #FAFAF8;
  margin: 0;
}

.location-type-small {
  background: rgba(164, 113, 72, 0.1);
  padding: 2px 8px;
  border-radius: 8px;
  font-size: 0.7rem;
  color: #a47148;
  border: 1px solid rgba(164, 113, 72, 0.2);
}

.location-country {
  font-size: 0.875rem;
  color: #999;
  margin: 0;
  display: flex;
  align-items: center;
  gap: 4px;
}

.location-country .material-icons {
  font-size: 14px;
  color: #666;
}

.location-description {
  font-size: 0.8rem;
  color: #ccc;
  margin: 0;
  line-height: 1.4;
}

.location-actions {
  display: flex;
  gap: 8px;
  margin-top: auto;
}

.action-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 4px;
  padding: 6px 12px;
  border-radius: 16px;
  border: 1px solid rgba(255, 255, 255, 0.2);
  background: transparent;
  color: #FAFAF8;
  font-size: 0.75rem;
  cursor: pointer;
  transition: all 0.3s ease;
}

.action-btn.primary {
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  color: #000;
  border: none;
  font-weight: 500;
}

.action-btn:active {
  transform: scale(0.95);
}

.action-btn .material-icons {
  font-size: 14px;
}

/* Location Detail */
.location-detail {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  background: linear-gradient(135deg, rgba(26, 26, 26, 0.98) 0%, rgba(10, 10, 10, 0.98) 100%);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border-top-left-radius: 24px;
  border-top-right-radius: 24px;
  z-index: 20;
  max-height: 85vh;
  overflow-y: auto;
  -webkit-overflow-scrolling: touch;
  box-shadow: 0 -5px 30px rgba(0, 0, 0, 0.5);
}

.detail-close {
  position: absolute;
  top: 20px;
  left: 50%;
  transform: translateX(-50%);
  width: 48px;
  height: 32px;
  border-radius: 16px;
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  border: none;
  color: #FAFAF8;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  z-index: 1;
  transition: all 0.3s ease;
}

.detail-close:active {
  transform: translateX(-50%) scale(0.9);
  background: rgba(255, 255, 255, 0.2);
}

.detail-header {
  position: relative;
  height: 200px;
  overflow: hidden;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, rgba(164, 113, 72, 0.1), rgba(255, 255, 255, 0.05));
}

.detail-image {
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
}

.location-type-badge {
  position: absolute;
  top: -60px;
  right: 20px;
  padding: 6px 12px;
  background: rgba(164, 113, 72, 0.9);
  color: #000;
  font-size: 0.7rem;
  font-weight: 700;
  letter-spacing: 0.1em;
  border-radius: 20px;
}

.location-icon {
  width: 80px;
  height: 80px;
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  border-radius: 20px;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 10px 30px rgba(164, 113, 72, 0.3);
}

.location-icon .material-icons {
  font-size: 3rem;
  color: #000;
}

.detail-title {
  position: absolute;
  bottom: 20px;
  left: 20px;
  right: 20px;
  color: #FAFAF8;
}

.detail-title h2 {
  font-size: 2rem;
  font-weight: 400;
  margin: 0 0 4px;
}

.detail-title p {
  font-size: 1rem;
  color: #a47148;
  margin: 0 0 8px;
}

.location-type {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 0.875rem;
  color: #ccc;
}

.location-type .material-icons {
  color: #a47148;
  font-size: 18px;
}

.detail-content {
  padding: 24px 20px env(safe-area-inset-bottom);
}

/* Quick Actions */
.quick-actions {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 12px;
  margin-bottom: 24px;
}

.quick-action {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 6px;
  padding: 12px 8px;
  background: rgba(255, 255, 255, 0.05);
  border-radius: 12px;
  border: 1px solid rgba(164, 113, 72, 0.2);
  color: #FAFAF8;
  font-size: 0.75rem;
  cursor: pointer;
  transition: all 0.3s ease;
}

.quick-action:active {
  transform: scale(0.95);
  background: rgba(164, 113, 72, 0.2);
}

.action-icon {
  width: 40px;
  height: 40px;
  background: linear-gradient(135deg, rgba(164, 113, 72, 0.2), rgba(255, 255, 255, 0.05));
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
}

.action-icon .material-icons {
  color: #a47148;
  font-size: 20px;
}

.detail-section {
  margin-bottom: 24px;
  padding-bottom: 24px;
  border-bottom: 1px solid rgba(164, 113, 72, 0.1);
}

.detail-section:last-child {
  border-bottom: none;
}

.detail-section h4 {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 1.125rem;
  font-weight: 400;
  color: #FAFAF8;
  margin: 0 0 12px;
}

.detail-section h4 .material-icons {
  color: #a47148;
  font-size: 20px;
}

.status-badge {
  margin-left: auto;
  padding: 4px 8px;
  background: rgba(255, 0, 0, 0.2);
  color: #ff6b6b;
  font-size: 0.75rem;
  border-radius: 12px;
  font-weight: 500;
}

.status-badge.open {
  background: rgba(0, 255, 0, 0.2);
  color: #4caf50;
}

.detail-section p {
  color: #ccc;
  line-height: 1.5;
  margin: 0 0 4px;
}

.opening-hours {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.hours-row {
  display: flex;
  justify-content: space-between;
  padding: 10px 14px;
  background: rgba(255, 255, 255, 0.03);
  border-radius: 10px;
  color: #999;
  font-size: 0.875rem;
}

.hours-row.today {
  background: rgba(164, 113, 72, 0.2);
  color: #FAFAF8;
  border: 1px solid rgba(164, 113, 72, 0.3);
}

.highlights-grid {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.highlight-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 10px;
  background: rgba(255, 255, 255, 0.03);
  border-radius: 10px;
  color: #ccc;
  font-size: 0.875rem;
}

.highlight-icon {
  width: 32px;
  height: 32px;
  background: rgba(164, 113, 72, 0.1);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}

.highlight-icon .material-icons {
  color: #a47148;
  font-size: 18px;
}

.detail-actions {
  display: flex;
  gap: 12px;
  margin-top: 32px;
}

.detail-btn {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  padding: 16px;
  border-radius: 50px;
  font-size: 0.95rem;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.3s ease;
}

.detail-btn.primary {
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  color: #000;
  border: none;
}

.detail-btn.secondary {
  background: transparent;
  color: #FAFAF8;
  border: 2px solid rgba(164, 113, 72, 0.3);
}

.detail-btn:active {
  transform: scale(0.95);
}

/* Loading Overlay */
.loading-overlay {
  position: absolute;
  inset: 0;
  background: rgba(0, 0, 0, 0.95);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 100;
}

.loading-content {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 16px;
}

.loading-spinner {
  width: 48px;
  height: 48px;
  border: 3px solid rgba(164, 113, 72, 0.2);
  border-top-color: #a47148;
  border-radius: 50%;
  animation: spin 1s linear infinite;
}

@keyframes spin {
  to { transform: rotate(360deg); }
}

.loading-overlay p {
  color: #FAFAF8;
  font-size: 0.875rem;
}

/* Distance Toast */
.distance-toast {
  position: absolute;
  top: calc(env(safe-area-inset-top) + 100px);
  left: 50%;
  transform: translateX(-50%);
  background: rgba(26, 26, 26, 0.95);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  color: #FAFAF8;
  padding: 12px 20px;
  border-radius: 50px;
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 0.875rem;
  box-shadow: 0 5px 20px rgba(0, 0, 0, 0.3);
  border: 1px solid rgba(164, 113, 72, 0.3);
  z-index: 30;
}

.distance-toast .material-icons {
  color: #a47148;
  font-size: 18px;
}

/* Transitions */
.slide-up-enter-active,
.slide-up-leave-active {
  transition: transform 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

.slide-up-enter-from,
.slide-up-leave-to {
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
  transform: translateX(-50%) translateY(-20px);
}

.toast-leave-to {
  opacity: 0;
  transform: translateX(-50%) translateY(-20px);
}

/* Safe Area Support */
@supports (padding: max(0px)) {
  .map-overlay {
    padding-top: max(20px, env(safe-area-inset-top));
  }
  
  .detail-content {
    padding-bottom: max(24px, env(safe-area-inset-bottom));
  }
}

/* Landscape Mode Adjustments */
@media (orientation: landscape) and (max-height: 500px) {
  .locations-list {
    max-height: 50vh;
  }
  
  .location-detail {
    max-height: 90vh;
  }
  
  .detail-header {
    height: 150px;
  }
}
</style>