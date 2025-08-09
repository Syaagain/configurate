<template>
  <div class="mobile-interactive-map">
    <!-- Google Maps Container -->
    <div ref="mapContainer" class="map-container">
      <!-- Actual Google Maps -->
      <iframe
        :src="`https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d5570665.339444434!2d5.866341973291837!3d50.503887287677804!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x479e75f9a38c5fd9%3A0x10cb84a7db1987d!2sMunich%2C%20Germany!5e0!3m2!1sen!2sus!4v1706285439215!5m2!1sen!2sus&zoom=${mapZoom}&center=${mapCenter.lat},${mapCenter.lng}`"
        width="100%"
        height="100%"
        style="border:0;"
        allowfullscreen=""
        loading="lazy"
        referrerpolicy="no-referrer-when-downgrade"
        :class="['google-map-iframe', mapStyleClass]"
      ></iframe>

      <!-- Custom Map Overlay -->
      <div class="map-overlay">
        <!-- Search Bar -->
        <div class="search-bar">
          <span class="material-icons search-icon">search</span>
          <input 
            v-model="searchQuery"
            @input="handleSearch"
            placeholder="Showroom suchen..."
            class="search-input"
          >
          <button 
            v-if="searchQuery"
            @click="clearSearch"
            class="clear-btn"
          >
            <span class="material-icons">close</span>
          </button>
        </div>

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

        <!-- Map Style Toggle -->
        <div class="style-toggle">
          <button 
            v-for="style in mapStyles"
            :key="style.id"
            @click="setMapStyle(style.id)"
            :class="['style-btn', { active: currentStyle === style.id }]"
          >
            <span class="material-icons">{{ style.icon }}</span>
          </button>
        </div>
      </div>

      <!-- Custom Animated Markers (wie Desktop) -->
      <div 
        v-for="showroom in filteredShowrooms"
        :key="showroom.id"
        :class="['custom-marker', { active: selectedShowroom?.id === showroom.id }]"
        :style="getMarkerPosition(showroom)"
        @click="selectShowroom(showroom)"
      >
        <div class="marker-container">
          <div class="marker-pulse"></div>
          <div class="marker-pulse-2"></div>
          <div class="marker-pin">
            <span class="material-icons">store</span>
          </div>
          <div class="marker-shadow"></div>
        </div>
        <div class="marker-label">{{ showroom.name }}</div>
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

    <!-- Showroom List (Swipeable) -->
    <div 
      class="showroom-list"
      :class="{ expanded: listExpanded }"
      @touchstart="handleTouchStart"
      @touchmove="handleTouchMove"
      @touchend="handleTouchEnd"
    >
      <div class="list-handle" @click="listExpanded = !listExpanded">
        <div class="handle-bar"></div>
        <span class="handle-text">
          <span class="material-icons">place</span>
          {{ filteredShowrooms.length }} Showrooms in Ihrer Nähe
        </span>
      </div>

      <div class="list-content">
        <div 
          v-for="showroom in sortedShowrooms"
          :key="showroom.id"
          class="showroom-card"
          :class="{ selected: selectedShowroom?.id === showroom.id }"
          @click="selectShowroom(showroom)"
        >
          <div class="showroom-image">
            <img :src="showroom.image" :alt="showroom.name">
            <div class="image-overlay"></div>
            <div class="distance-badge" v-if="showroom.distance">
              <span class="material-icons">navigation</span>
              {{ formatDistance(showroom.distance) }}
            </div>
          </div>
          
          <div class="showroom-info">
            <div class="info-header">
              <h3>{{ showroom.name }}</h3>
              <div class="rating">
                <span class="material-icons">star</span>
                {{ showroom.rating }}
              </div>
            </div>
            
            <p class="showroom-address">
              <span class="material-icons">location_on</span>
              {{ showroom.address }}
            </p>
            
            <div class="showroom-features">
              <span v-for="feature in showroom.features.slice(0, 3)" :key="feature" class="feature-tag">
                {{ feature }}
              </span>
              <span v-if="showroom.features.length > 3" class="feature-more">
                +{{ showroom.features.length - 3 }}
              </span>
            </div>
            
            <div class="showroom-actions">
              <button @click.stop="getDirections(showroom)" class="action-btn primary">
                <span class="material-icons">directions</span>
                Route
              </button>
              <button @click.stop="callShowroom(showroom)" class="action-btn">
                <span class="material-icons">phone</span>
              </button>
              <button @click.stop="shareShowroom(showroom)" class="action-btn">
                <span class="material-icons">share</span>
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Selected Showroom Detail (Fullscreen) -->
    <Transition name="slide-up">
      <div v-if="selectedShowroom && !listExpanded" class="showroom-detail">
        <button @click="selectedShowroom = null" class="detail-close">
          <span class="material-icons">expand_more</span>
        </button>

        <div class="detail-header">
          <img :src="selectedShowroom.image" :alt="selectedShowroom.name" class="detail-image">
          <div class="detail-gradient"></div>
          <div class="detail-badge">SHOWROOM</div>
          <div class="detail-title">
            <h2>{{ selectedShowroom.name }}</h2>
            <p>{{ selectedShowroom.city }}</p>
            <div class="detail-rating">
              <span class="material-icons">star</span>
              <span>{{ selectedShowroom.rating }}</span>
              <span class="reviews">({{ selectedShowroom.reviews }} Bewertungen)</span>
            </div>
          </div>
        </div>

        <div class="detail-content">
          <!-- Quick Actions -->
          <div class="quick-actions">
            <button @click="getDirections(selectedShowroom)" class="quick-action">
              <div class="action-icon">
                <span class="material-icons">navigation</span>
              </div>
              <span>Route</span>
            </button>
            <button @click="callShowroom(selectedShowroom)" class="quick-action">
              <div class="action-icon">
                <span class="material-icons">phone</span>
              </div>
              <span>Anrufen</span>
            </button>
            <button @click="bookAppointment(selectedShowroom)" class="quick-action">
              <div class="action-icon">
                <span class="material-icons">event</span>
              </div>
              <span>Termin</span>
            </button>
            <button @click="shareShowroom(selectedShowroom)" class="quick-action">
              <div class="action-icon">
                <span class="material-icons">share</span>
              </div>
              <span>Teilen</span>
            </button>
          </div>

          <div class="detail-section">
            <h4>
              <span class="material-icons">location_on</span>
              Adresse
            </h4>
            <p>{{ selectedShowroom.address }}</p>
            <p>{{ selectedShowroom.postalCode }} {{ selectedShowroom.city }}</p>
          </div>

          <div class="detail-section">
            <h4>
              <span class="material-icons">schedule</span>
              Öffnungszeiten
              <span class="status-badge" :class="{ open: isOpen }">
                {{ isOpen ? 'Geöffnet' : 'Geschlossen' }}
              </span>
            </h4>
            <div class="opening-hours">
              <div 
                v-for="(hours, day) in selectedShowroom.openingHours" 
                :key="day"
                class="hours-row"
                :class="{ today: isToday(day) }"
              >
                <span class="day">{{ day }}</span>
                <span class="hours">{{ hours }}</span>
              </div>
            </div>
          </div>

          <div class="detail-section">
            <h4>
              <span class="material-icons">star</span>
              Highlights
            </h4>
            <div class="highlights-grid">
              <div v-for="highlight in selectedShowroom.highlights" :key="highlight" class="highlight-item">
                <div class="highlight-icon">
                  <span class="material-icons">check_circle</span>
                </div>
                <span>{{ highlight }}</span>
              </div>
            </div>
          </div>

          <div class="detail-section">
            <h4>
              <span class="material-icons">category</span>
              Sortiment
            </h4>
            <div class="features-grid">
              <span v-for="feature in selectedShowroom.features" :key="feature" class="feature-chip">
                {{ feature }}
              </span>
            </div>
          </div>

          <div class="detail-actions">
            <button @click="getDirections(selectedShowroom)" class="detail-btn primary">
              <span class="material-icons">navigation</span>
              Navigation starten
            </button>
            <button @click="bookAppointment(selectedShowroom)" class="detail-btn secondary">
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
          <p>Lade Showrooms...</p>
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
const selectedShowroom = ref(null)
const currentStyle = ref('default')
const listExpanded = ref(false)
const trackingLocation = ref(false)
const findingLocation = ref(false)
const isLoading = ref(true)
const mapZoom = ref(10)
const showDistanceToast = ref(false)
const distanceMessage = ref('')
const isOpen = ref(false)

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

// Data
const mapStyles = [
  { id: 'default', icon: 'map' },
  { id: 'satellite', icon: 'satellite_alt' },
  { id: 'dark', icon: 'nightlight' }
]

const showrooms = ref([
  {
    id: 1,
    name: 'Showroom München',
    city: 'München / Starnberg',
    address: 'Am Hohenrand 9, 82335 Berg',
    postalCode: '82335',
    lat: 48.1351,
    lng: 11.5820,
    phone: '+49 8171 / 3868770',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686576cf622e38e88f0236c5.png',
    features: ['Naturstein', 'Keramik', 'Bad', 'Outdoor'],
    highlights: ['2500m² Ausstellungsfläche', '3D-Planung', 'Barrierefreier Zugang', 'Kostenlose Parkplätze'],
    rating: 4.9,
    reviews: 127,
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
    name: 'Showroom Düsseldorf',
    city: 'Düsseldorf / Neuss',
    address: 'Königsallee 60',
    postalCode: '40212',
    lat: 51.2277,
    lng: 6.7735,
    phone: '+49 2131 / 1234567',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png',
    features: ['Exklusiv', 'Marmor', 'Luxus', 'Designer'],
    highlights: ['80.000m² Lagerfläche', 'Premium Materialien', 'VIP-Beratung', 'Event-Location'],
    rating: 4.8,
    reviews: 89,
    openingHours: {
      'Mo': 'Geschlossen',
      'Di-Fr': '09:00 - 17:00',
      'Sa': '09:00 - 16:00',
      'So': 'Geschlossen'
    },
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

const filteredShowrooms = computed(() => {
  if (!searchQuery.value) return showrooms.value
  
  const query = searchQuery.value.toLowerCase()
  return showrooms.value.filter(showroom => 
    showroom.name.toLowerCase().includes(query) ||
    showroom.city.toLowerCase().includes(query) ||
    showroom.features.some(f => f.toLowerCase().includes(query))
  )
})

const sortedShowrooms = computed(() => {
  const sorted = [...filteredShowrooms.value]
  if (userLocation.lat && userLocation.lng) {
    sorted.sort((a, b) => (a.distance || Infinity) - (b.distance || Infinity))
  }
  return sorted
})

// Methods
const getMarkerPosition = (showroom) => {
  // Calculate position based on actual coordinates
  // This is simplified - in production, use proper map projection
  if (showroom.id === 1) {
    return { left: '55%', top: '60%' }
  } else {
    return { left: '35%', top: '25%' }
  }
}

const getUserMarkerPosition = () => {
  // Calculate based on user location
  return { left: '50%', top: '50%' }
}

const selectShowroom = (showroom) => {
  selectedShowroom.value = showroom
  listExpanded.value = false
  
  // Center map on showroom
  mapCenter.lat = showroom.lat
  mapCenter.lng = showroom.lng
  mapZoom.value = 14
  
  // Check if open
  checkIfOpen(showroom)
  
  // Haptic feedback
  if (navigator.vibrate) {
    navigator.vibrate(50)
  }
}

const checkIfOpen = (showroom) => {
  const now = new Date()
  const day = now.getDay()
  const days = ['So', 'Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa']
  const currentDay = days[day]
  
  // Simple check - würde in Produktion komplexer sein
  const hours = showroom.openingHours['Di-Fr']
  isOpen.value = hours !== 'Geschlossen' && day >= 2 && day <= 5
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
  showrooms.value.forEach(showroom => {
    if (userLocation.lat && userLocation.lng) {
      // Haversine formula for distance calculation
      const R = 6371 // Earth's radius in km
      const dLat = (showroom.lat - userLocation.lat) * Math.PI / 180
      const dLng = (showroom.lng - userLocation.lng) * Math.PI / 180
      const a = Math.sin(dLat/2) * Math.sin(dLat/2) +
                Math.cos(userLocation.lat * Math.PI / 180) * 
                Math.cos(showroom.lat * Math.PI / 180) *
                Math.sin(dLng/2) * Math.sin(dLng/2)
      const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
      showroom.distance = R * c
    }
  })
}

const showLocationToast = () => {
  const nearest = sortedShowrooms.value[0]
  if (nearest && nearest.distance) {
    distanceMessage.value = `Nächster Showroom: ${nearest.name} (${formatDistance(nearest.distance)})`
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

const getDirections = (showroom) => {
  const url = `https://maps.google.com/maps?daddr=${showroom.lat},${showroom.lng}`
  window.open(url, '_blank')
}

const callShowroom = (showroom) => {
  window.location.href = `tel:${showroom.phone}`
}

const bookAppointment = (showroom) => {
  // Navigate to booking page
  window.location.href = `/kontakt?showroom=${showroom.id}`
}

const shareShowroom = async (showroom) => {
  if (navigator.share) {
    try {
      await navigator.share({
        title: showroom.name,
        text: `Besuchen Sie unseren Showroom in ${showroom.city}`,
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
  // Search logic
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
  height: 100dvh; /* Dynamic viewport height for mobile */
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
  filter: grayscale(30%) contrast(1.1);
  transition: filter 0.3s ease;
}

.google-map-iframe.map-satellite {
  filter: none;
}

.google-map-iframe.map-dark {
  filter: grayscale(100%) invert(100%) contrast(1.2);
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

/* Custom Animated Markers (wie Desktop) */
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

/* Showroom List */
.showroom-list {
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

.showroom-list.expanded {
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

/* Showroom Card */
.showroom-card {
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

.showroom-card:active {
  transform: scale(0.98);
}

.showroom-card.selected {
  background: rgba(164, 113, 72, 0.2);
  border-color: rgba(164, 113, 72, 0.3);
}

.showroom-image {
  position: relative;
  width: 100px;
  height: 100px;
  border-radius: 12px;
  overflow: hidden;
  flex-shrink: 0;
}

.showroom-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.showroom-image .image-overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(135deg, transparent, rgba(0, 0, 0, 0.3));
}

.distance-badge {
  position: absolute;
  top: 8px;
  right: 8px;
  background: rgba(0, 0, 0, 0.9);
  color: #a47148;
  padding: 4px 8px;
  border-radius: 12px;
  font-size: 0.7rem;
  font-weight: 600;
  display: flex;
  align-items: center;
  gap: 3px;
  border: 1px solid rgba(164, 113, 72, 0.3);
}

.distance-badge .material-icons {
  font-size: 12px;
}

.showroom-info {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.info-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
}

.showroom-info h3 {
  font-size: 1.125rem;
  font-weight: 400;
  color: #FAFAF8;
  margin: 0;
}

.rating {
  display: flex;
  align-items: center;
  gap: 2px;
  background: rgba(164, 113, 72, 0.1);
  padding: 2px 6px;
  border-radius: 8px;
  font-size: 0.75rem;
  color: #a47148;
}

.rating .material-icons {
  font-size: 14px;
}

.showroom-address {
  font-size: 0.875rem;
  color: #999;
  margin: 0;
  display: flex;
  align-items: center;
  gap: 4px;
}

.showroom-address .material-icons {
  font-size: 14px;
  color: #666;
}

.showroom-features {
  display: flex;
  gap: 6px;
  flex-wrap: wrap;
}

.feature-tag {
  padding: 3px 8px;
  background: rgba(164, 113, 72, 0.1);
  color: #a47148;
  font-size: 0.7rem;
  border-radius: 8px;
  font-weight: 500;
}

.feature-more {
  padding: 3px 8px;
  background: rgba(255, 255, 255, 0.1);
  color: #666;
  font-size: 0.7rem;
  border-radius: 8px;
}

.showroom-actions {
  display: flex;
  gap: 8px;
  margin-top: auto;
}

.action-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 4px;
  padding: 8px 14px;
  border-radius: 20px;
  border: 1px solid rgba(255, 255, 255, 0.2);
  background: transparent;
  color: #FAFAF8;
  font-size: 0.875rem;
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
  font-size: 16px;
}

/* Showroom Detail */
.showroom-detail {
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
  height: 250px;
  overflow: hidden;
}

.detail-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.detail-gradient {
  position: absolute;
  inset: 0;
  background: linear-gradient(transparent, rgba(0, 0, 0, 0.9));
}

.detail-badge {
  position: absolute;
  top: 20px;
  right: 20px;
  padding: 6px 12px;
  background: rgba(164, 113, 72, 0.9);
  color: #000;
  font-size: 0.7rem;
  font-weight: 700;
  letter-spacing: 0.1em;
  border-radius: 20px;
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

.detail-rating {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 0.875rem;
}

.detail-rating .material-icons {
  color: #a47148;
  font-size: 18px;
}

.detail-rating .reviews {
  color: #999;
  font-size: 0.75rem;
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

.features-grid {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.feature-chip {
  padding: 6px 12px;
  background: rgba(164, 113, 72, 0.1);
  color: #a47148;
  font-size: 0.875rem;
  border-radius: 20px;
  border: 1px solid rgba(164, 113, 72, 0.2);
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
  .showroom-list {
    max-height: 50vh;
  }
  
  .showroom-detail {
    max-height: 90vh;
  }
  
  .detail-header {
    height: 150px;
  }
}
</style>