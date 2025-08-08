<template>
  <div class="mobile-ar-viewer">
    <!-- AR Toggle Button -->
    <button 
      v-if="!isARMode"
      @click="toggleAR"
      class="ar-toggle-button"
    >
      <span class="material-icons">view_in_ar</span>
      <span>AR Ansicht</span>
    </button>
<!-- 3D Viewer Container -->
<div 
  ref="viewerContainer"
  class="viewer-container"
  :class="{ 'ar-mode': isARMode }"
>
  <!-- Loading State -->
  <div v-if="isLoading" class="loading-state">
    <div class="loading-spinner"></div>
    <p>Lade 3D-Modell...</p>
  </div>

  <!-- 3D Canvas -->
  <canvas 
    ref="canvas3d"
    @touchstart="handleTouchStart"
    @touchmove="handleTouchMove"
    @touchend="handleTouchEnd"
  ></canvas>

  <!-- AR Camera View (Placeholder) -->
  <div v-if="isARMode" class="ar-camera-view">
    <video ref="arVideo" autoplay playsinline></video>
    <div class="ar-overlay">
      <div class="ar-crosshair"></div>
      <div class="ar-instructions">
        <p>{{ arInstructions }}</p>
      </div>
    </div>
  </div>

  <!-- Controls -->
  <div class="viewer-controls">
    <!-- Zoom Controls -->
    <div class="zoom-controls">
      <button @click="zoomIn" class="control-btn">
        <span class="material-icons">add</span>
      </button>
      <div class="zoom-indicator">{{ Math.round(zoomLevel) }}%</div>
      <button @click="zoomOut" class="control-btn">
        <span class="material-icons">remove</span>
      </button>
    </div>

    <!-- View Options -->
    <div class="view-options">
      <button 
        v-for="view in viewOptions" 
        :key="view.id"
        @click="setView(view.id)"
        :class="['view-btn', { active: currentView === view.id }]"
      >
        <span class="material-icons">{{ view.icon }}</span>
      </button>
    </div>

    <!-- Material Switcher -->
    <div class="material-switcher">
      <button @click="showMaterials = !showMaterials" class="material-toggle">
        <span class="material-icons">palette</span>
      </button>
      
      <Transition name="slide">
        <div v-if="showMaterials" class="material-options">
          <button
            v-for="material in materials"
            :key="material.id"
            @click="changeMaterial(material)"
            class="material-option"
            :style="{ background: material.color }"
          >
            <span class="material-label">{{ material.name }}</span>
          </button>
        </div>
      </Transition>
    </div>
  </div>

  <!-- Product Info Overlay -->
  <div class="product-info-overlay">
    <h3>{{ product.name }}</h3>
    <p class="product-material">{{ currentMaterial.name }}</p>
    <div class="product-dimensions">
      <span class="material-icons">straighten</span>
      <span>{{ product.dimensions }}</span>
    </div>
  </div>

  <!-- AR Controls -->
  <div v-if="isARMode" class="ar-controls">
    <button @click="captureAR" class="capture-btn">
      <span class="material-icons">photo_camera</span>
    </button>
    <button @click="toggleAR" class="exit-ar-btn">
      <span class="material-icons">close</span>
      <span>Beenden</span>
    </button>
  </div>
</div>

<!-- Captured Image Preview -->
<Transition name="fade">
  <div v-if="capturedImage" class="capture-preview">
    <img :src="capturedImage" alt="AR Capture">
    <div class="capture-actions">
      <button @click="shareCapture" class="share-btn">
        <span class="material-icons">share</span>
      </button>
      <button @click="saveCapture" class="save-btn">
        <span class="material-icons">download</span>
      </button>
      <button @click="capturedImage = null" class="close-btn">
        <span class="material-icons">close</span>
      </button>
    </div>
  </div>
</Transition>
  </div>
</template>
<script setup>
import { ref, onMounted, onUnmounted, reactive } from 'vue'

const props = defineProps({
  product: {
    type: Object,
    default: () => ({
      name: 'Carrara Marmor',
      model: '/models/marble.glb',
      dimensions: '120 x 60 x 2 cm'
    })
  }
})

// Refs
const viewerContainer = ref(null)
const canvas3d = ref(null)
const arVideo = ref(null)
const isLoading = ref(true)
const isARMode = ref(false)
const zoomLevel = ref(100)
const currentView = ref('perspective')
const showMaterials = ref(false)
const capturedImage = ref(null)
const arInstructions = ref('Bewegen Sie Ihr Gerät, um die Oberfläche zu scannen')

// Touch handling
const touches = reactive({
  startX: 0,
  startY: 0,
  startDistance: 0,
  isRotating: false,
  isPinching: false
})

// Data
const viewOptions = [
  { id: 'perspective', icon: '3d_rotation' },
  { id: 'top', icon: 'vertical_align_top' },
  { id: 'front', icon: 'view_agenda' },
  { id: 'side', icon: 'view_sidebar' }
]

const materials = ref([
  { id: 1, name: 'Carrara Weiß', color: '#F5F5F5' },
  { id: 2, name: 'Nero Marquina', color: '#1A1A1A' },
  { id: 3, name: 'Emperador', color: '#8B4513' },
  { id: 4, name: 'Calacatta Gold', color: '#F4E5D3' }
])

const currentMaterial = ref(materials.value[0])

// Methods
const initializeViewer = () => {
  // Simulated 3D viewer initialization
  setTimeout(() => {
    isLoading.value = false
    // Here you would initialize Three.js or another 3D library
    console.log('3D Viewer initialized')
  }, 2000)
}

const toggleAR = async () => {
  isARMode.value = !isARMode.value
  
  if (isARMode.value && arVideo.value) {
    try {
      // Request camera access
      const stream = await navigator.mediaDevices.getUserMedia({ 
        video: { 
          facingMode: 'environment',
          width: { ideal: 1920 },
          height: { ideal: 1080 }
        } 
      })
      arVideo.value.srcObject = stream
      
      // Simulate AR tracking
      setTimeout(() => {
        arInstructions.value = 'Tippen Sie, um das Objekt zu platzieren'
      }, 3000)
    } catch (error) {
      console.error('Camera access denied:', error)
      isARMode.value = false
    }
  } else if (!isARMode.value && arVideo.value?.srcObject) {
    // Stop camera
    const stream = arVideo.value.srcObject
    stream.getTracks().forEach(track => track.stop())
    arVideo.value.srcObject = null
  }
}

const zoomIn = () => {
  zoomLevel.value = Math.min(200, zoomLevel.value + 10)
}

const zoomOut = () => {
  zoomLevel.value = Math.max(50, zoomLevel.value - 10)
}

const setView = (viewId) => {
  currentView.value = viewId
  // Here you would update the 3D camera position
}

const changeMaterial = (material) => {
  currentMaterial.value = material
  showMaterials.value = false
  // Here you would update the 3D model material
}

const handleTouchStart = (e) => {
  if (e.touches.length === 1) {
    touches.startX = e.touches[0].clientX
    touches.startY = e.touches[0].clientY
    touches.isRotating = true
  } else if (e.touches.length === 2) {
    const dx = e.touches[0].clientX - e.touches[1].clientX
    const dy = e.touches[0].clientY - e.touches[1].clientY
    touches.startDistance = Math.sqrt(dx * dx + dy * dy)
    touches.isPinching = true
    touches.isRotating = false
  }
}

const handleTouchMove = (e) => {
  e.preventDefault()
  
  if (touches.isRotating && e.touches.length === 1) {
    const deltaX = e.touches[0].clientX - touches.startX
    const deltaY = e.touches[0].clientY - touches.startY
    
    // Rotate 3D model based on touch movement
    // Implementation would depend on 3D library
    
    touches.startX = e.touches[0].clientX
    touches.startY = e.touches[0].clientY
  } else if (touches.isPinching && e.touches.length === 2) {
    const dx = e.touches[0].clientX - e.touches[1].clientX
    const dy = e.touches[0].clientY - e.touches[1].clientY
    const distance = Math.sqrt(dx * dx + dy * dy)
    
    const scale = distance / touches.startDistance
    zoomLevel.value = Math.max(50, Math.min(200, zoomLevel.value * scale))
    
    touches.startDistance = distance
  }
}

const handleTouchEnd = () => {
  touches.isRotating = false
  touches.isPinching = false
}

const captureAR = () => {
  // Simulate AR capture
  capturedImage.value = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNkYPhfDwAChwGA60e6kgAAAABJRU5ErkJggg=='
  
  // Haptic feedback if available
  if (navigator.vibrate) {
    navigator.vibrate(50)
  }
}

const shareCapture = async () => {
  if (navigator.share && capturedImage.value) {
    try {
      await navigator.share({
        title: 'AR Ansicht',
        text: 'Schau dir diese AR-Ansicht an!',
        url: capturedImage.value
      })
    } catch (error) {
      console.log('Share failed:', error)
    }
  }
}

const saveCapture = () => {
  if (capturedImage.value) {
    const link = document.createElement('a')
    link.href = capturedImage.value
    link.download = 'ar-capture.png'
    link.click()
  }
}

// Lifecycle
onMounted(() => {
  initializeViewer()
})

onUnmounted(() => {
  if (arVideo.value?.srcObject) {
    const stream = arVideo.value.srcObject
    stream.getTracks().forEach(track => track.stop())
  }
})
</script>
<style scoped>
.mobile-ar-viewer {
  position: relative;
  width: 100%;
  height: 100vh;
  background: #000;
  overflow: hidden;
}

.ar-toggle-button {
  position: absolute;
  top: 20px;
  right: 20px;
  z-index: 100;
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 12px 20px;
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  color: #000;
  border: none;
  border-radius: 50px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow: 0 10px 30px rgba(164, 113, 72, 0.3);
}

.ar-toggle-button:active {
  transform: scale(0.95);
}

.viewer-container {
  position: relative;
  width: 100%;
  height: 100%;
  background: radial-gradient(ellipse at center, #1a1a1a 0%, #000 100%);
}

.viewer-container.ar-mode {
  background: transparent;
}

/* Loading State */
.loading-state {
  position: absolute;
  inset: 0;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  color: #FAFAF8;
  background: rgba(0, 0, 0, 0.8);
  z-index: 10;
}

.loading-spinner {
  width: 60px;
  height: 60px;
  border: 3px solid rgba(164, 113, 72, 0.2);
  border-top-color: #a47148;
  border-radius: 50%;
  animation: spin 1s linear infinite;
}

@keyframes spin {
  to { transform: rotate(360deg); }
}

/* 3D Canvas */
canvas {
  width: 100%;
  height: 100%;
  touch-action: none;
}

/* AR Camera View */
.ar-camera-view {
  position: absolute;
  inset: 0;
  z-index: 1;
}

.ar-camera-view video {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.ar-overlay {
  position: absolute;
  inset: 0;
  pointer-events: none;
}

.ar-crosshair {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 100px;
  height: 100px;
  border: 2px solid rgba(164, 113, 72, 0.6);
  border-radius: 50%;
  animation: pulse 2s ease-in-out infinite;
}

@keyframes pulse {
  0%, 100% { transform: translate(-50%, -50%) scale(1); opacity: 1; }
  50% { transform: translate(-50%, -50%) scale(1.1); opacity: 0.5; }
}

.ar-instructions {
  position: absolute;
  bottom: 120px;
  left: 0;
  right: 0;
  text-align: center;
  padding: 16px 24px;
  background: rgba(0, 0, 0, 0.7);
  backdrop-filter: blur(10px);
  color: #FAFAF8;
}

/* Viewer Controls */
.viewer-controls {
  position: absolute;
  bottom: 20px;
  left: 20px;
  right: 20px;
  display: flex;
  justify-content: space-between;
  align-items: flex-end;
  z-index: 5;
}

.zoom-controls {
  display: flex;
  flex-direction: column;
  gap: 8px;
  background: rgba(0, 0, 0, 0.7);
  backdrop-filter: blur(10px);
  border-radius: 20px;
  padding: 8px;
}

.control-btn {
  width: 40px;
  height: 40px;
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

.control-btn:active {
  background: rgba(164, 113, 72, 0.3);
  transform: scale(0.9);
}

.zoom-indicator {
  text-align: center;
  color: #a47148;
  font-size: 0.875rem;
  font-weight: 500;
}

.view-options {
  display: flex;
  gap: 8px;
  background: rgba(0, 0, 0, 0.7);
  backdrop-filter: blur(10px);
  border-radius: 25px;
  padding: 8px;
}

.view-btn {
  width: 40px;
  height: 40px;
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

.view-btn.active {
  background: rgba(164, 113, 72, 0.3);
  color: #a47148;
}

/* Material Switcher */
.material-switcher {
  position: relative;
}

.material-toggle {
  width: 48px;
  height: 48px;
  border-radius: 50%;
  background: linear-gradient(135deg, rgba(164, 113, 72, 0.8), rgba(250, 250, 248, 0.8));
  border: none;
  color: #000;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow: 0 5px 20px rgba(164, 113, 72, 0.3);
}

.material-toggle:active {
  transform: scale(0.9);
}

.material-options {
  position: absolute;
  bottom: 60px;
  right: 0;
  display: flex;
  flex-direction: column;
  gap: 8px;
  padding: 12px;
  background: rgba(0, 0, 0, 0.9);
  backdrop-filter: blur(20px);
  border-radius: 16px;
  min-width: 150px;
}

.material-option {
  display: flex;
  align-items: center;
  padding: 12px;
  border-radius: 8px;
  border: 2px solid rgba(255, 255, 255, 0.1);
  cursor: pointer;
  transition: all 0.3s ease;
}

.material-option:active {
  transform: scale(0.95);
  border-color: #a47148;
}

.material-label {
  color: #FAFAF8;
  font-size: 0.875rem;
  text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.8);
}

/* Product Info Overlay */
.product-info-overlay {
  position: absolute;
  top: 20px;
  left: 20px;
  background: rgba(0, 0, 0, 0.7);
  backdrop-filter: blur(10px);
  padding: 16px 20px;
  border-radius: 16px;
  color: #FAFAF8;
  max-width: 250px;
}

.product-info-overlay h3 {
  font-size: 1.25rem;
  font-weight: 400;
  margin-bottom: 4px;
}

.product-material {
  color: #a47148;
  font-size: 0.875rem;
  margin-bottom: 8px;
}

.product-dimensions {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 0.875rem;
  color: #999;
}

/* AR Controls */
.ar-controls {
  position: absolute;
  bottom: 40px;
  left: 50%;
  transform: translateX(-50%);
  display: flex;
  gap: 24px;
  z-index: 10;
}

.capture-btn {
  width: 72px;
  height: 72px;
  border-radius: 50%;
  background: #FAFAF8;
  border: 4px solid rgba(164, 113, 72, 0.3);
  color: #000;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
}

.capture-btn:active {
  transform: scale(0.9);
  background: #a47148;
  color: #FAFAF8;
}

.capture-btn .material-icons {
  font-size: 32px;
}

.exit-ar-btn {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 16px 24px;
  background: rgba(0, 0, 0, 0.7);
  backdrop-filter: blur(10px);
  border: none;
  border-radius: 50px;
  color: #FAFAF8;
  cursor: pointer;
  transition: all 0.3s ease;
}

.exit-ar-btn:active {
  transform: scale(0.95);
  background: rgba(255, 0, 0, 0.2);
}

/* Capture Preview */
.capture-preview {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.95);
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  z-index: 1000;
  padding: 20px;
}

.capture-preview img {
  max-width: 100%;
  max-height: 70vh;
  border-radius: 16px;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5);
}

.capture-actions {
  display: flex;
  gap: 24px;
  margin-top: 32px;
}

.share-btn,
.save-btn,
.close-btn {
  width: 56px;
  height: 56px;
  border-radius: 50%;
  border: none;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.3s ease;
}

.share-btn {
  background: linear-gradient(135deg, #1DA1F2, #0A66C2);
  color: white;
}

.save-btn {
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  color: #000;
}

.close-btn {
  background: rgba(255, 255, 255, 0.1);
  color: #FAFAF8;
}

.share-btn:active,
.save-btn:active,
.close-btn:active {
  transform: scale(0.9);
}

/* Transitions */
.slide-enter-active,
.slide-leave-active {
  transition: all 0.3s ease;
}

.slide-enter-from {
  transform: translateY(20px);
  opacity: 0;
}

.slide-leave-to {
  transform: translateY(-20px);
  opacity: 0;
}

.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
</style>