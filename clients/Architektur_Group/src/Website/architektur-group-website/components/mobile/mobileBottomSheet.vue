<template>
  <Teleport to="body">
    <Transition name="sheet">
      <div
        v-if="isOpen"
        class="mobile-bottom-sheet"
        @click.self="handleBackdropClick"
      >
        <div class="sheet-overlay" :style="{ opacity: overlayOpacity }"></div>
        <div
          ref="sheetContent"
          class="sheet-content"
          :style="{ transform: `translateY(${translateY}px)` }"
          @touchstart="handleTouchStart"
          @touchmove="handleTouchMove"
          @touchend="handleTouchEnd"
        >
          <!-- Drag Handle -->
          <div class="sheet-handle-container">
            <div class="sheet-handle"></div>
          </div>
      <!-- Header -->
      <div class="sheet-header">
        <h3 class="sheet-title">{{ title }}</h3>
        <button @click="close" class="sheet-close">
          <span class="material-icons">close</span>
        </button>
      </div>
      
      <!-- Content -->
      <div class="sheet-body" ref="sheetBody">
        <slot></slot>
      </div>
      
      <!-- Actions -->
      <div v-if="$slots.actions" class="sheet-actions">
        <slot name="actions"></slot>
      </div>
    </div>
  </div>
</Transition>
  </Teleport>
</template>
<script setup>
import { ref, watch, onMounted, onUnmounted, computed } from 'vue'

const props = defineProps({
  modelValue: {
    type: Boolean,
    default: false
  },
  title: {
    type: String,
    default: ''
  },
  height: {
    type: String,
    default: 'auto' // 'auto', 'full', 'half'
  },
  persistent: {
    type: Boolean,
    default: false
  }
})

const emit = defineEmits(['update:modelValue', 'closed', 'opened'])

// Refs
const sheetContent = ref(null)
const sheetBody = ref(null)
const isOpen = ref(props.modelValue)
const translateY = ref(0)

// Touch handling
const startY = ref(0)
const currentY = ref(0)
const isDragging = ref(false)
const velocity = ref(0)
const lastTime = ref(0)
const lastY = ref(0)

// Computed
const overlayOpacity = computed(() => {
  if (!sheetContent.value) return 0.5
  const maxTranslate = window.innerHeight
  const opacity = 1 - (translateY.value / maxTranslate)
  return Math.max(0, Math.min(0.5, opacity * 0.5))
})

// Methods
const open = () => {
  isOpen.value = true
  translateY.value = 0
  document.body.style.overflow = 'hidden'
  
  // Animate in
  setTimeout(() => {
    emit('opened')
  }, 300)
}

const close = () => {
  const contentHeight = sheetContent.value?.offsetHeight || 0
  translateY.value = contentHeight
  
  setTimeout(() => {
    isOpen.value = false
    document.body.style.overflow = ''
    emit('update:modelValue', false)
    emit('closed')
  }, 300)
}

const handleBackdropClick = () => {
  if (!props.persistent) {
    close()
  }
}

const handleTouchStart = (e) => {
  if (e.target.closest('.sheet-body') && sheetBody.value.scrollTop > 0) {
    return
  }
  
  isDragging.value = true
  startY.value = e.touches[0].clientY
  currentY.value = startY.value
  lastY.value = startY.value
  lastTime.value = Date.now()
  velocity.value = 0
}

const handleTouchMove = (e) => {
  if (!isDragging.value) return
  
  const touch = e.touches[0]
  currentY.value = touch.clientY
  const deltaY = currentY.value - startY.value
  
  // Calculate velocity
  const currentTime = Date.now()
  const timeDiff = currentTime - lastTime.value
  const distance = currentY.value - lastY.value
  
  if (timeDiff > 0) {
    velocity.value = distance / timeDiff
  }
  
  lastY.value = currentY.value
  lastTime.value = currentTime
  
  // Only allow dragging down
  if (deltaY > 0) {
    translateY.value = deltaY
    e.preventDefault()
  }
}

const handleTouchEnd = () => {
  if (!isDragging.value) return
  
  isDragging.value = false
  const threshold = 100
  const velocityThreshold = 0.5
  
  // Check if should close based on position or velocity
  if (translateY.value > threshold || velocity.value > velocityThreshold) {
    close()
  } else {
    // Snap back
    translateY.value = 0
  }
}

// Watchers
watch(() => props.modelValue, (newVal) => {
  if (newVal) {
    open()
  } else {
    close()
  }
})

// Lifecycle
onMounted(() => {
  if (props.modelValue) {
    open()
  }
})

onUnmounted(() => {
  document.body.style.overflow = ''
})
</script>
<style scoped>
.mobile-bottom-sheet {
  position: fixed;
  inset: 0;
  z-index: 9999;
  pointer-events: none;
}

.sheet-overlay {
  position: absolute;
  inset: 0;
  background: rgba(0, 0, 0, 0.5);
  pointer-events: auto;
  transition: opacity 0.3s ease;
}

.sheet-content {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  background: linear-gradient(135deg, #1a1a1a 0%, #0a0a0a 100%);
  border-top-left-radius: 24px;
  border-top-right-radius: 24px;
  box-shadow: 0 -10px 40px rgba(0, 0, 0, 0.5);
  pointer-events: auto;
  transition: transform 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  max-height: 90vh;
  display: flex;
  flex-direction: column;
}

.sheet-handle-container {
  padding: 12px;
  display: flex;
  justify-content: center;
  cursor: grab;
}

.sheet-handle-container:active {
  cursor: grabbing;
}

.sheet-handle {
  width: 48px;
  height: 4px;
  background: rgba(255, 255, 255, 0.3);
  border-radius: 2px;
  transition: all 0.3s ease;
}

.sheet-content:active .sheet-handle {
  background: rgba(164, 113, 72, 0.6);
  width: 64px;
}

.sheet-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 24px 20px;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.sheet-title {
  font-size: 1.5rem;
  font-weight: 300;
  color: #FAFAF8;
  background: linear-gradient(135deg, #FAFAF8 0%, #a47148 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.sheet-close {
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

.sheet-close:active {
  transform: scale(0.9);
  background: rgba(164, 113, 72, 0.2);
}

.sheet-body {
  flex: 1;
  padding: 24px;
  overflow-y: auto;
  -webkit-overflow-scrolling: touch;
  color: #FAFAF8;
}

/* Custom scrollbar */
.sheet-body::-webkit-scrollbar {
  width: 4px;
}

.sheet-body::-webkit-scrollbar-track {
  background: transparent;
}

.sheet-body::-webkit-scrollbar-thumb {
  background: rgba(164, 113, 72, 0.5);
  border-radius: 2px;
}

.sheet-actions {
  padding: 20px 24px;
  border-top: 1px solid rgba(255, 255, 255, 0.1);
  display: flex;
  gap: 12px;
  background: rgba(0, 0, 0, 0.3);
}

/* Transitions */
.sheet-enter-active,
.sheet-leave-active {
  transition: opacity 0.3s ease;
}

.sheet-enter-from,
.sheet-leave-to {
  opacity: 0;
}

.sheet-enter-active .sheet-content {
  transition: transform 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

.sheet-enter-from .sheet-content {
  transform: translateY(100%);
}

.sheet-leave-active .sheet-content {
  transition: transform 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

.sheet-leave-to .sheet-content {
  transform: translateY(100%);
}

/* Premium glass effect */
@supports (backdrop-filter: blur(20px)) {
  .sheet-content {
    background: linear-gradient(135deg, 
      rgba(26, 26, 26, 0.95) 0%, 
      rgba(10, 10, 10, 0.95) 100%);
    backdrop-filter: blur(20px);
  }
}

/* Haptic feedback animation */
@keyframes haptic {
  0%, 100% { transform: scale(1); }
  50% { transform: scale(0.95); }
}

.sheet-close:active {
  animation: haptic 0.1s ease;
}
</style>