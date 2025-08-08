<template>
  <div class="mobile-interactive-map">
    <!-- Map Container -->
    <div ref="mapContainer" class="map-container">
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
      :class="['location-btn', { active: trackingLocation }]"
    >
      <span class="material-icons">{{ trackingLocation ? 'my_location' : 'location_searching' }}</span>
    </button>

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

  <!-- Custom Markers -->
  <div 
    v-for="showroom in filteredShowrooms"
    :key="showroom.id"
    :class="['custom-marker', { active: selectedShowroom?.id === showroom.id }]"
    :style="getMarkerPosition(showroom)"
    @click="selectShowroom(showroom)"
  >
    <div class="marker-pin">
      <div class="marker-pulse"></div>
      <span class="material-icons">store</span>
    </div>
    <div class="marker-label">{{ showroom.name }}</div>
  </div>

  <!-- User Location Marker -->
  <div 
    v-if="userLocation"
    class="user-marker"
    :style="getUserMarkerPosition()"
  >
    <div class="user-pulse"></div>
    <div class="user-dot"></div>
  </div>
</div>

<!-- Showroom List (Collapsible) -->
<div 
  class="showroom-list"
  :class="{ expanded: listExpanded }"
>
  <div 
    class="list-handle"
    @click="listExpanded = !listExpanded"
  >
    <div class="handle-bar"></div>
    <span class="handle-text">{{ filteredShowrooms.length }} Showrooms</span>
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
        <div class="distance-badge" v-if="showroom.distance">
          {{ formatDistance(showroom.distance) }}
        </div>
      </div>
      
      <div class="showroom-info">
        <h3>{{ showroom.name }}</h3>
        <p class="showroom-address">{{ showroom.address }}</p>
        
        <div class="showroom-features">
          <span v-for="feature in showroom.features" :key="feature" class="feature-tag">
            {{ feature }}
          </span>
        </div>
        
        <div class="showroom-actions">
          <button @click.stop="getDirections(showroom)" class="action-btn primary">
            <span class="material-icons">directions</span>
            Route
          </button>
          <button @click.stop="callShowroom(showroom)" class="action-btn">
            <span class="material-icons">phone</span>
            Anrufen
          </button>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Selected Showroom Detail -->
<Transition name="slide-up">
  <div v-if="selectedShowroom && !listExpanded" class="showroom-detail">
    <button @click="selectedShowroom = null" class="detail-close">
      <span class="material-icons">close</span>
    </button>

    <div class="detail-header">
      <img :src="selectedShowroom.image" :alt="selectedShowroom.name" class="detail-image">
      <div class="detail-gradient"></div>
      <div class="detail-title">
        <h2>{{ selectedShowroom.name }}</h2>
        <p>{{ selectedShowroom.city }}</p>
      </div>
    </div>

    <div class="detail-content">
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
            <span class="material-icons">check_circle</span>
            {{ highlight }}
          </div>
        </div>
      </div>

      <div class="detail-actions">
        <button @click="getDirections(selectedShowroom)" class="detail-btn primary">
          <span class="material-icons">navigation</span>
          Navigation starten
        </button>
        <button @click="shareShowroom(selectedShowroom)" class="detail-btn">
          <span class="material-icons">share</span>
          Teilen
        </button>
      </div>
    </div>
  </div>
</Transition>

<!-- Loading State -->
<div v-if="isLoading" class="loading-overlay">
  <div class="loading-spinner"></div>
  <p>Lade Karte...</p>
</div>
  </div>
</template>
<script setup>
import { ref, computed, onMounted, reactive } from 'vue'

// Refs
const mapContainer = ref(null)
const searchQuery = ref('')
const selectedShowroom = ref(null)
const currentStyle = ref('default')
const listExpanded = ref(false)
const trackingLocation = ref(false)
const isLoading = ref(true)

// User location
const userLocation = reactive({
  lat: null,
  lng: null
})

// Data
const mapStyles = [
  { id: 'default', icon: 'map' },
  { id: 'satellite', icon: 'satellite' },
  { id: 'dark', icon: 'dark_mode' }
]

const showrooms = ref([
  {
    id: 1,
    name: 'Showroom München',
    city: 'München',
    address: 'Maximilianstraße 35',
    postalCode: '80539',
    lat: 48.1351,
    lng: 11.5820,
    phone: '+49 89 12345678',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686576cf622e38e88f0236c5.png',
    features: ['Naturstein', 'Keramik', 'Bad'],
    highlights: ['500m² Ausstellungsfläche', '3D-Planung', 'Barrierefreier Zugang', 'Parkplätze vorhanden'],
    openingHours: {
      'Mo-Fr': '09:00 - 18:00',
      'Sa': '10:00 - 16:00',
      'So': 'Geschlossen'
    },
    distance: null
  },
  {
    id: 2,
    name: 'Showroom Starnberg',
    city: 'Starnberg',
    address: 'Seestraße 12',
    postalCode: '82319',
    lat: 47.9970,
    lng: 11.3403,
    phone: '+49 8151 98765432',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png',
    features: ['Terrassen', 'Garten', 'Fliesen'],
    highlights: ['800m² Außenbereich', 'Musterterrasse', 'Beratungstermine', 'Café im Showroom'],
    openingHours: {
      'Mo-Fr': '08:00 - 19:00',
      'Sa': '09:00 - 17:00',
      'So': '11:00 - 16:00'
    },
    distance: null
  },
  {
    id: 3,
    name: 'Showroom Düsseldorf',
    city: 'Düsseldorf',
    address: 'Königsallee 60',
    postalCode: '40212',
    lat: 51.2277,
    lng: 6.7735,
    phone: '+49 211 87654321',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png',
    features: ['Exklusiv', 'Marmor', 'Luxus'],
    highlights: ['Premium Materialien', 'VIP-Beratung', 'Event-Location', 'Valet Parking'],
    openingHours: {
      'Mo-Fr': '10:00 - 19:00',
      'Sa': '10:00 - 18:00',
      'So': 'Geschlossen'
    },
    distance: null
  }
])

// Computed
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
  // This would be calculated based on map projection
  // For demo purposes, using fixed positions
  const positions = {
    1: { left: '50%', top: '40%' },
    2: { left: '45%', top: '45%' },
    3: { left: '30%', top: '20%' }
  }
  return positions[showroom.id] || { left: '50%', top: '50%' }
}

const getUserMarkerPosition = () => {
  // Calculate based on user location
  return { left: '55%', top: '50%' }
}

const selectShowroom = (showroom) => {
  selectedShowroom.value = showroom
  listExpanded.value = false
  
  // Center map on showroom
  centerMapOn(showroom)
  
  // Haptic feedback
  if (navigator.vibrate) {
    navigator.vibrate(50)
  }
}

const centerMapOn = (showroom) => {
  // Map centering logic
  console.log('Centering on:', showroom.name)
}

const getCurrentLocation = () => {
  trackingLocation.value = true
  
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(
      (position) => {
        userLocation.lat = position.coords.latitude
        userLocation.lng = position.coords.longitude
        calculateDistances()
      },
      (error) => {
        console.error('Location error:', error)
        trackingLocation.value = false
      }
    )
  }
}

const calculateDistances = () => {
  showrooms.value.forEach(showroom => {
    if (userLocation.lat && userLocation.lng) {
      // Simplified distance calculation
      const dx = showroom.lat - userLocation.lat
      const dy = showroom.lng - userLocation.lng
      showroom.distance = Math.sqrt(dx * dx + dy * dy) * 111 // Convert to km (rough)
    }
  })
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
  // Apply map style
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
  return day.startsWith(today)
}

// Lifecycle
onMounted(() => {
  setTimeout(() => {
    isLoading.value = false
  }, 1500)
  
  getCurrentLocation()
})
</script>
<style scoped>
.mobile-interactive-map {
  position: relative;
  width: 100%;
  height: 100vh;
  background: #000;
  overflow: hidden;
}

/* Map Container */
.map-container {
  position: relative;
  width: 100%;
  height: 100%;
  background: linear-gradient(135deg, #1a1a1a 0%, #0a0a0a 100%);
  /* In production, this would be replaced with actual map */
}

/* Map Overlay */
.map-overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  z-index: 10;
  padding: 20px;
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
  border-radius: 50px;
  padding: 12px 20px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
}

.search-icon {
  color: #a47148;
  margin-right: 12px;
}

.search-input {
  flex: 1;
  background: transparent;
  border: none;
  color: #FAFAF8;
  font-size: 1rem;
  outline: none;
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
  top: 80px;
  right: 20px;
  width: 48px;
  height: 48px;
  border-radius: 50%;
  background: rgba(26, 26, 26, 0.95);
  backdrop-filter: blur(20px);
  border: none;
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
}

.location-btn:active {
  transform: scale(0.9);
}

/* Style Toggle */
.style-toggle {
  position: absolute;
  top: 140px;
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
  border: none;
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
}

/* Custom Markers */
.custom-marker {
  position: absolute;
  transform: translate(-50%, -100%);
  cursor: pointer;
  z-index: 5;
  transition: all 0.3s ease;
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
  box-shadow: 0 5px 20px rgba(164, 113, 72, 0.4);
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
  animation: pulse 2s ease-in-out infinite;
  opacity: 0;
}

.custom-marker.active .marker-pulse {
  opacity: 1;
}

.marker-label {
  position: absolute;
  bottom: -25px;
  left: 50%;
  transform: translateX(-50%);
  background: rgba(0, 0, 0, 0.8);
  color: #FAFAF8;
  padding: 4px 8px;
  border-radius: 4px;
  font-size: 0.75rem;
  white-space: nowrap;
  opacity: 0;
  transition: opacity 0.3s ease;
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
  width: 16px;
  height: 16px;
  background: #4285F4;
  border: 3px solid white;
  border-radius: 50%;
  box-shadow: 0 2px 10px rgba(66, 133, 244, 0.5);
}

.user-pulse {
  position: absolute;
  inset: -20px;
  border: 2px solid #4285F4;
  border-radius: 50%;
  animation: userPulse 2s ease-in-out infinite;
}

@keyframes pulse {
  0%, 100% { transform: scale(1); opacity: 0; }
  50% { transform: scale(1.5); opacity: 0.5; }
}

@keyframes userPulse {
  0%, 100% { transform: scale(1); opacity: 0.5; }
  50% { transform: scale(2); opacity: 0; }
}

/* Showroom List */
.showroom-list {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  background: linear-gradient(135deg, rgba(26, 26, 26, 0.98) 0%, rgba(10, 10, 10, 0.98) 100%);
  backdrop-filter: blur(20px);
  border-top-left-radius: 24px;
  border-top-right-radius: 24px;
  transform: translateY(calc(100% - 80px));
  transition: transform 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  z-index: 15;
  max-height: 70vh;
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
}

.handle-bar {
  width: 48px;
  height: 4px;
  background: rgba(255, 255, 255, 0.3);
  border-radius: 2px;
}

.handle-text {
  color: #a47148;
  font-size: 0.875rem;
  font-weight: 500;
}

.list-content {
  padding: 0 20px 20px;
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
}

.showroom-card:active {
  transform: scale(0.98);
}

.showroom-card.selected {
  background: rgba(164, 113, 72, 0.2);
  border: 1px solid rgba(164, 113, 72, 0.3);
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

.distance-badge {
  position: absolute;
  top: 8px;
  right: 8px;
  background: rgba(0, 0, 0, 0.8);
  color: #a47148;
  padding: 4px 8px;
  border-radius: 12px;
  font-size: 0.75rem;
  font-weight: 500;
}

.showroom-info {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.showroom-info h3 {
  font-size: 1.125rem;
  font-weight: 400;
  color: #FAFAF8;
  margin: 0;
}

.showroom-address {
  font-size: 0.875rem;
  color: #999;
  margin: 0;
}

.showroom-features {
  display: flex;
  gap: 6px;
  flex-wrap: wrap;
}

.feature-tag {
  padding: 2px 8px;
  background: rgba(164, 113, 72, 0.2);
  color: #a47148;
  font-size: 0.75rem;
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
  gap: 4px;
  padding: 8px 12px;
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
}

.action-btn:active {
  transform: scale(0.95);
}

.action-btn .material-icons {
  font-size: 18px;
}

/* Showroom Detail */
.showroom-detail {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  background: linear-gradient(135deg, rgba(26, 26, 26, 0.98) 0%, rgba(10, 10, 10, 0.98) 100%);
  backdrop-filter: blur(20px);
  border-top-left-radius: 24px;
  border-top-right-radius: 24px;
  z-index: 20;
  max-height: 80vh;
  overflow-y: auto;
  -webkit-overflow-scrolling: touch;
}

.detail-close {
  position: absolute;
  top: 20px;
  right: 20px;
  width: 32px;
  height: 32px;
  border-radius: 50%;
  background: rgba(0, 0, 0, 0.5);
  backdrop-filter: blur(10px);
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
  transform: scale(0.9);
}

.detail-header {
  position: relative;
  height: 200px;
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
  background: linear-gradient(transparent, rgba(0, 0, 0, 0.8));
}

.detail-title {
  position: absolute;
  bottom: 20px;
  left: 20px;
  color: #FAFAF8;
}

.detail-title h2 {
  font-size: 1.75rem;
  font-weight: 400;
  margin: 0 0 4px;
}

.detail-title p {
  font-size: 1rem;
  color: #a47148;
  margin: 0;
}

.detail-content {
  padding: 24px 20px;
}

.detail-section {
  margin-bottom: 24px;
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
  padding: 8px 12px;
  background: rgba(255, 255, 255, 0.05);
  border-radius: 8px;
  color: #ccc;
}

.hours-row.today {
  background: rgba(164, 113, 72, 0.2);
  color: #FAFAF8;
}

.highlights-grid {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.highlight-item {
  display: flex;
  align-items: center;
  gap: 8px;
  color: #ccc;
}

.highlight-item .material-icons {
  color: #a47148;
  font-size: 18px;
}

.detail-actions {
  display: flex;
  gap: 12px;
  margin-top: 24px;
}

.detail-btn {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  padding: 16px;
  border-radius: 50px;
  border: 2px solid rgba(255, 255, 255, 0.2);
  background: transparent;
  color: #FAFAF8;
  font-size: 1rem;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.3s ease;
}

.detail-btn.primary {
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  color: #000;
  border: none;
}

.detail-btn:active {
  transform: scale(0.95);
}

/* Loading Overlay */
.loading-overlay {
  position: absolute;
  inset: 0;
  background: rgba(0, 0, 0, 0.9);
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  z-index: 100;
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
  margin-top: 16px;
  color: #FAFAF8;
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
</style>