<template>
  <div class="mobile-video-player" ref="playerContainer">
    <!-- Video Element -->
    <video
      ref="videoElement"
      :src="currentVideo.src"
      :poster="currentVideo.poster"
      @timeupdate="updateProgress"
      @loadedmetadata="onVideoLoaded"
      @ended="onVideoEnded"
      @click="togglePlay"
      playsinline
      webkit-playsinline
    ></video>
<!-- Loading Overlay -->
<Transition name="fade">
  <div v-if="isLoading" class="loading-overlay">
    <div class="loading-ring">
      <div></div>
      <div></div>
      <div></div>
    </div>
  </div>
</Transition>

<!-- Controls Overlay -->
<div 
  class="controls-overlay"
  :class="{ hidden: !showControls && isPlaying }"
  @click="handleOverlayClick"
>
  <!-- Top Bar -->
  <div class="top-bar">
    <button @click="$emit('close')" class="close-btn">
      <span class="material-icons">close</span>
    </button>
    
    <div class="video-title">
      <h3>{{ currentVideo.title }}</h3>
      <p>{{ currentVideo.subtitle }}</p>
    </div>

    <button @click="toggleSettings" class="settings-btn">
      <span class="material-icons">settings</span>
    </button>
  </div>

  <!-- Center Controls -->
  <div class="center-controls">
    <!-- Rewind -->
    <button @click="skip(-10)" class="skip-btn">
      <span class="material-icons">replay_10</span>
    </button>

    <!-- Play/Pause -->
    <button @click="togglePlay" class="play-btn">
      <div class="play-btn-ring"></div>
      <span class="material-icons">{{ isPlaying ? 'pause' : 'play_arrow' }}</span>
    </button>

    <!-- Forward -->
    <button @click="skip(10)" class="skip-btn">
      <span class="material-icons">forward_10</span>
    </button>
  </div>

  <!-- Bottom Bar -->
  <div class="bottom-bar">
    <!-- Progress Bar -->
    <div class="progress-container">
      <span class="time-label">{{ formatTime(currentTime) }}</span>
      
      <div 
        class="progress-bar"
        @click="seek"
        @touchstart="startScrub"
        @touchmove="scrub"
        @touchend="endScrub"
      >
        <div class="progress-buffered" :style="{ width: bufferedWidth }"></div>
        <div class="progress-played" :style="{ width: playedWidth }"></div>
        <div 
          class="progress-thumb" 
          :style="{ left: playedWidth }"
          :class="{ dragging: isScrubbing }"
        ></div>
        
        <!-- Chapter Markers -->
        <div 
          v-for="chapter in currentVideo.chapters"
          :key="chapter.time"
          class="chapter-marker"
          :style="{ left: getChapterPosition(chapter.time) }"
          @click.stop="seekTo(chapter.time)"
        >
          <div class="chapter-tooltip">{{ chapter.title }}</div>
        </div>
      </div>
      
      <span class="time-label">{{ formatTime(duration) }}</span>
    </div>

    <!-- Bottom Controls -->
    <div class="bottom-controls">
      <!-- Left Controls -->
      <div class="controls-left">
        <button @click="toggleMute" class="control-btn">
          <span class="material-icons">
            {{ isMuted ? 'volume_off' : 'volume_up' }}
          </span>
        </button>
        
        <div class="volume-slider" v-show="showVolume">
          <input
            type="range"
            min="0"
            max="100"
            v-model="volume"
            @input="changeVolume"
            class="volume-input"
          >
        </div>
      </div>

      <!-- Center Info -->
      <div class="video-info">
        <span class="quality-badge">{{ currentQuality }}</span>
        <span class="separator">•</span>
        <span class="views">{{ formatViews(currentVideo.views) }} Views</span>
      </div>

      <!-- Right Controls -->
      <div class="controls-right">
        <button @click="togglePictureInPicture" class="control-btn" v-if="pipSupported">
          <span class="material-icons">picture_in_picture_alt</span>
        </button>
        
        <button @click="toggleFullscreen" class="control-btn">
          <span class="material-icons">
            {{ isFullscreen ? 'fullscreen_exit' : 'fullscreen' }}
          </span>
        </button>
      </div>
    </div>
  </div>
</div>

<!-- Settings Panel -->
<Transition name="slide">
  <div v-if="showSettings" class="settings-panel">
    <div class="settings-header">
      <h4>Einstellungen</h4>
      <button @click="showSettings = false" class="settings-close">
        <span class="material-icons">close</span>
      </button>
    </div>

    <!-- Playback Speed -->
    <div class="setting-group">
      <label>Geschwindigkeit</label>
      <div class="speed-options">
        <button
          v-for="speed in playbackSpeeds"
          :key="speed"
          @click="setPlaybackSpeed(speed)"
          :class="['speed-btn', { active: currentSpeed === speed }]"
        >
          {{ speed }}x
        </button>
      </div>
    </div>

    <!-- Quality -->
    <div class="setting-group">
      <label>Qualität</label>
      <div class="quality-options">
        <button
          v-for="quality in qualities"
          :key="quality.value"
          @click="setQuality(quality)"
          :class="['quality-btn', { active: currentQuality === quality.label }]"
        >
          {{ quality.label }}
          <span class="quality-detail">{{ quality.resolution }}</span>
        </button>
      </div>
    </div>

    <!-- Subtitles -->
    <div class="setting-group">
      <label>Untertitel</label>
      <div class="subtitle-toggle">
        <label class="switch">
          <input type="checkbox" v-model="showSubtitles">
          <span class="slider"></span>
        </label>
        <span>{{ showSubtitles ? 'Ein' : 'Aus' }}</span>
      </div>
    </div>
  </div>
</Transition>

<!-- Gesture Indicators -->
<Transition name="fade">
  <div v-if="gestureIndicator" class="gesture-indicator">
    <span class="material-icons">{{ gestureIcon }}</span>
    <span>{{ gestureText }}</span>
  </div>
</Transition>

<!-- Playlist -->
<div 
  v-if="playlist.length > 1"
  class="playlist-drawer"
  :class="{ expanded: showPlaylist }"
>
  <button @click="showPlaylist = !showPlaylist" class="playlist-toggle">
    <span class="material-icons">playlist_play</span>
    <span>Playlist ({{ currentIndex + 1 }}/{{ playlist.length }})</span>
  </button>

  <div class="playlist-content">
    <div
      v-for="(video, index) in playlist"
      :key="video.id"
      @click="playVideo(index)"
      :class="['playlist-item', { active: currentIndex === index }]"
    >
      <div class="playlist-thumbnail">
        <img :src="video.poster" :alt="video.title">
        <div class="playlist-duration">{{ formatTime(video.duration) }}</div>
      </div>
      <div class="playlist-info">
        <h5>{{ video.title }}</h5>
        <p>{{ video.subtitle }}</p>
      </div>
    </div>
  </div>
</div>
  </div>
</template>
<script setup>
import { ref, computed, onMounted, onUnmounted } from 'vue'

const props = defineProps({
  playlist: {
    type: Array,
    default: () => [
      {
        id: 1,
        src: 'https://example.com/video1.mp4',
        poster: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686576cf622e38e88f0236c5.png',
        title: 'Exklusive Badgestaltung',
        subtitle: 'Meisterhafte Handwerkskunst',
        duration: 240,
        views: 15420,
        chapters: [
          { time: 0, title: 'Einführung' },
          { time: 60, title: 'Materialauswahl' },
          { time: 120, title: 'Verarbeitung' },
          { time: 180, title: 'Finale Details' }
        ]
      }
    ]
  }
})

const emit = defineEmits(['close'])

// Refs
const playerContainer = ref(null)
const videoElement = ref(null)

// State
const currentIndex = ref(0)
const isPlaying = ref(false)
const isLoading = ref(false)
const isMuted = ref(false)
const isFullscreen = ref(false)
const showControls = ref(true)
const showSettings = ref(false)
const showVolume = ref(false)
const showPlaylist = ref(false)
const showSubtitles = ref(false)
const isScrubbing = ref(false)
const pipSupported = ref('pictureInPictureEnabled' in document)

// Video state
const currentTime = ref(0)
const duration = ref(0)
const buffered = ref(0)
const volume = ref(100)
const currentSpeed = ref(1)
const currentQuality = ref('1080p')

// Gesture state
const gestureIndicator = ref(false)
const gestureIcon = ref('')
const gestureText = ref('')

// Touch state
const touchStartX = ref(0)
const touchStartY = ref(0)
const touchStartTime = ref(0)

// Data
const playbackSpeeds = [0.5, 0.75, 1, 1.25, 1.5, 2]
const qualities = [
  { label: '1080p', value: 'hd1080', resolution: 'Full HD' },
  { label: '720p', value: 'hd720', resolution: 'HD' },
  { label: '480p', value: 'large', resolution: 'SD' },
  { label: '360p', value: 'medium', resolution: 'Mobile' }
]

// Computed
const currentVideo = computed(() => props.playlist[currentIndex.value])
const playedWidth = computed(() => {
  if (duration.value === 0) return '0%'
  return `${(currentTime.value / duration.value) * 100}%`
})
const bufferedWidth = computed(() => `${buffered.value}%`)

// Methods
const togglePlay = () => {
  if (videoElement.value) {
    if (isPlaying.value) {
      videoElement.value.pause()
    } else {
      videoElement.value.play()
    }
    isPlaying.value = !isPlaying.value
    showControlsTemporarily()
  }
}

const skip = (seconds) => {
  if (videoElement.value) {
    videoElement.value.currentTime += seconds
    showGesture(seconds > 0 ? 'forward_10' : 'replay_10', `${Math.abs(seconds)} Sekunden`)
  }
}

const seek = (event) => {
  const rect = event.currentTarget.getBoundingClientRect()
  const percent = (event.clientX - rect.left) / rect.width
  if (videoElement.value) {
    videoElement.value.currentTime = percent * duration.value
  }
}

const seekTo = (time) => {
  if (videoElement.value) {
    videoElement.value.currentTime = time
  }
}

const startScrub = (event) => {
  isScrubbing.value = true
  touchStartTime.value = currentTime.value
  scrub(event)
}

const scrub = (event) => {
  if (!isScrubbing.value) return
  
  const rect = event.currentTarget.getBoundingClientRect()
  const touch = event.touches[0]
  const percent = Math.max(0, Math.min(1, (touch.clientX - rect.left) / rect.width))
  
  if (videoElement.value) {
    videoElement.value.currentTime = percent * duration.value
  }
}

const endScrub = () => {
  isScrubbing.value = false
}

const toggleMute = () => {
  if (videoElement.value) {
    videoElement.value.muted = !videoElement.value.muted
    isMuted.value = videoElement.value.muted
  }
  showVolume.value = !isMuted.value
}

const changeVolume = () => {
  if (videoElement.value) {
    videoElement.value.volume = volume.value / 100
    if (volume.value === 0) {
      isMuted.value = true
    } else {
      isMuted.value = false
      videoElement.value.muted = false
    }
  }
}

const setPlaybackSpeed = (speed) => {
  if (videoElement.value) {
    videoElement.value.playbackRate = speed
    currentSpeed.value = speed
  }
  showSettings.value = false
}

const setQuality = (quality) => {
  currentQuality.value = quality.label
  // In production, this would change the video source
  showSettings.value = false
}

const toggleFullscreen = async () => {
  if (!document.fullscreenElement) {
    await playerContainer.value.requestFullscreen()
    isFullscreen.value = true
  } else {
    await document.exitFullscreen()
    isFullscreen.value = false
  }
}

const togglePictureInPicture = async () => {
  if (document.pictureInPictureElement) {
    await document.exitPictureInPicture()
  } else if (videoElement.value) {
    await videoElement.value.requestPictureInPicture()
  }
}

const toggleSettings = () => {
  showSettings.value = !showSettings.value
}

const playVideo = (index) => {
  currentIndex.value = index
  currentTime.value = 0
  if (videoElement.value) {
    videoElement.value.load()
    if (isPlaying.value) {
      videoElement.value.play()
    }
  }
  showPlaylist.value = false
}

const updateProgress = () => {
  if (videoElement.value) {
    currentTime.value = videoElement.value.currentTime
    
    // Update buffered
    if (videoElement.value.buffered.length > 0) {
      const bufferedEnd = videoElement.value.buffered.end(videoElement.value.buffered.length - 1)
      buffered.value = (bufferedEnd / duration.value) * 100
    }
  }
}

const onVideoLoaded = () => {
  if (videoElement.value) {
    duration.value = videoElement.value.duration
  }
  isLoading.value = false
}

const onVideoEnded = () => {
  isPlaying.value = false
  
  // Auto-play next in playlist
  if (currentIndex.value < props.playlist.length - 1) {
    playVideo(currentIndex.value + 1)
  }
}

const handleOverlayClick = (event) => {
  // Don't toggle if clicking on controls
  if (event.target === event.currentTarget) {
    togglePlay()
  }
}

const showControlsTemporarily = () => {
  showControls.value = true
  
  if (controlsTimeout) {
    clearTimeout(controlsTimeout)
  }
  
  controlsTimeout = setTimeout(() => {
    if (isPlaying.value) {
      showControls.value = false
    }
  }, 3000)
}

const showGesture = (icon, text) => {
  gestureIcon.value = icon
  gestureText.value = text
  gestureIndicator.value = true
  
  setTimeout(() => {
    gestureIndicator.value = false
  }, 1000)
}

const formatTime = (seconds) => {
  if (!seconds || isNaN(seconds)) return '0:00'
  
  const h = Math.floor(seconds / 3600)
  const m = Math.floor((seconds % 3600) / 60)
  const s = Math.floor(seconds % 60)
  
  if (h > 0) {
    return `${h}:${m.toString().padStart(2, '0')}:${s.toString().padStart(2, '0')}`
  }
  return `${m}:${s.toString().padStart(2, '0')}`
}

const formatViews = (views) => {
  if (views > 1000000) {
    return `${(views / 1000000).toFixed(1)}M`
  }
  if (views > 1000) {
    return `${(views / 1000).toFixed(1)}K`
  }
  return views.toString()
}

const getChapterPosition = (time) => {
  if (duration.value === 0) return '0%'
  return `${(time / duration.value) * 100}%`
}

// Touch gestures
let controlsTimeout = null

const handleTouchStart = (event) => {
  touchStartX.value = event.touches[0].clientX
  touchStartY.value = event.touches[0].clientY
}

const handleTouchMove = (event) => {
  const deltaX = event.touches[0].clientX - touchStartX.value
  const deltaY = event.touches[0].clientY - touchStartY.value
  
  // Horizontal swipe for seeking
  if (Math.abs(deltaX) > Math.abs(deltaY) && Math.abs(deltaX) > 50) {
    const seekAmount = (deltaX / window.innerWidth) * 30
    skip(seekAmount)
    touchStartX.value = event.touches[0].clientX
  }
  
  // Vertical swipe for volume (left side) or brightness (right side)
  if (Math.abs(deltaY) > Math.abs(deltaX) && Math.abs(deltaY) > 20) {
    const isLeftSide = touchStartX.value < window.innerWidth / 2
    
    if (isLeftSide) {
      // Volume control
      const volumeChange = -(deltaY / window.innerHeight) * 100
      volume.value = Math.max(0, Math.min(100, volume.value + volumeChange))
      changeVolume()
      showGesture('volume_up', `Lautstärke ${Math.round(volume.value)}%`)
    } else {
      // Brightness control (would need screen API)
      showGesture('brightness_high', 'Helligkeit')
    }
    
    touchStartY.value = event.touches[0].clientY
  }
}

// Lifecycle
onMounted(() => {
  // Add touch event listeners
  if (playerContainer.value) {
    playerContainer.value.addEventListener('touchstart', handleTouchStart)
    playerContainer.value.addEventListener('touchmove', handleTouchMove)
  }
  
  // Auto-hide controls
  showControlsTemporarily()
  
  // Listen for fullscreen changes
  document.addEventListener('fullscreenchange', () => {
    isFullscreen.value = !!document.fullscreenElement
  })
})

onUnmounted(() => {
  if (controlsTimeout) {
    clearTimeout(controlsTimeout)
  }
  
  if (playerContainer.value) {
    playerContainer.value.removeEventListener('touchstart', handleTouchStart)
    playerContainer.value.removeEventListener('touchmove', handleTouchMove)
  }
})
</script>
<style scoped>
.mobile-video-player {
  position: relative;
  width: 100%;
  height: 100vh;
  background: #000;
  overflow: hidden;
  -webkit-tap-highlight-color: transparent;
}

/* Video Element */
video {
  width: 100%;
  height: 100%;
  object-fit: contain;
}

/* Loading Overlay */
.loading-overlay {
  position: absolute;
  inset: 0;
  background: rgba(0, 0, 0, 0.8);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 100;
}

.loading-ring {
  display: inline-block;
  position: relative;
  width: 80px;
  height: 80px;
}

.loading-ring div {
  box-sizing: border-box;
  display: block;
  position: absolute;
  width: 64px;
  height: 64px;
  margin: 8px;
  border: 3px solid #a47148;
  border-radius: 50%;
  animation: loading-ring 1.2s cubic-bezier(0.5, 0, 0.5, 1) infinite;
  border-color: #a47148 transparent transparent transparent;
}

.loading-ring div:nth-child(1) { animation-delay: -0.45s; }
.loading-ring div:nth-child(2) { animation-delay: -0.3s; }
.loading-ring div:nth-child(3) { animation-delay: -0.15s; }

@keyframes loading-ring {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

/* Controls Overlay */
.controls-overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(
    to bottom,
    rgba(0, 0, 0, 0.7) 0%,
    transparent 20%,
    transparent 80%,
    rgba(0, 0, 0, 0.7) 100%
  );
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  padding: 20px;
  transition: opacity 0.3s ease;
  z-index: 10;
}

.controls-overlay.hidden {
  opacity: 0;
  pointer-events: none;
}

/* Top Bar */
.top-bar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 16px;
}

.close-btn,
.settings-btn {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background: rgba(0, 0, 0, 0.5);
  backdrop-filter: blur(10px);
  border: none;
  color: #FAFAF8;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.3s ease;
}

.close-btn:active,
.settings-btn:active {
  transform: scale(0.9);
  background: rgba(164, 113, 72, 0.3);
}

.video-title {
  flex: 1;
  text-align: center;
  color: #FAFAF8;
}

.video-title h3 {
  font-size: 1.125rem;
  font-weight: 400;
  margin: 0 0 4px;
}

.video-title p {
  font-size: 0.875rem;
  color: #a47148;
  margin: 0;
}

/* Center Controls */
.center-controls {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 48px;
}

.skip-btn {
  width: 56px;
  height: 56px;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  border: none;
  color: #FAFAF8;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.3s ease;
}

.skip-btn:active {
  transform: scale(0.9);
  background: rgba(164, 113, 72, 0.3);
}

.play-btn {
  position: relative;
  width: 80px;
  height: 80px;
  border-radius: 50%;
  background: linear-gradient(135deg, rgba(164, 113, 72, 0.8), rgba(250, 250, 248, 0.8));
  backdrop-filter: blur(10px);
  border: none;
  color: #000;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow: 0 10px 30px rgba(164, 113, 72, 0.3);
}

.play-btn:active {
  transform: scale(0.9);
}

.play-btn-ring {
  position: absolute;
  inset: -4px;
  border: 2px solid rgba(164, 113, 72, 0.3);
  border-radius: 50%;
  animation: play-pulse 2s ease-in-out infinite;
}

@keyframes play-pulse {
  0%, 100% { transform: scale(1); opacity: 0.5; }
  50% { transform: scale(1.1); opacity: 0; }
}

.play-btn .material-icons {
  font-size: 40px;
}

/* Bottom Bar */
.bottom-bar {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

/* Progress Container */
.progress-container {
  display: flex;
  align-items: center;
  gap: 12px;
}

.time-label {
  font-size: 0.875rem;
  color: #FAFAF8;
  min-width: 45px;
}

.progress-bar {
  position: relative;
  flex: 1;
  height: 4px;
  background: rgba(255, 255, 255, 0.2);
  border-radius: 2px;
  cursor: pointer;
  overflow: visible;
}

.progress-buffered {
  position: absolute;
  top: 0;
  left: 0;
  height: 100%;
  background: rgba(255, 255, 255, 0.3);
  border-radius: 2px;
}

.progress-played {
  position: absolute;
  top: 0;
  left: 0;
  height: 100%;
  background: linear-gradient(90deg, #a47148, #FAFAF8);
  border-radius: 2px;
  transition: width 0.1s linear;
}

.progress-thumb {
  position: absolute;
  top: 50%;
  transform: translate(-50%, -50%);
  width: 16px;
  height: 16px;
  background: #FAFAF8;
  border-radius: 50%;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.3);
  transition: all 0.2s ease;
  opacity: 0;
}

.progress-bar:hover .progress-thumb,
.progress-thumb.dragging {
  opacity: 1;
  transform: translate(-50%, -50%) scale(1.2);
}

/* Chapter Markers */
.chapter-marker {
  position: absolute;
  top: 50%;
  transform: translate(-50%, -50%);
  width: 8px;
  height: 8px;
  background: #a47148;
  border-radius: 50%;
  cursor: pointer;
  transition: all 0.2s ease;
}

.chapter-marker:hover {
  transform: translate(-50%, -50%) scale(1.5);
}

.chapter-tooltip {
  position: absolute;
  bottom: 16px;
  left: 50%;
  transform: translateX(-50%);
  background: rgba(0, 0, 0, 0.9);
  color: #FAFAF8;
  padding: 4px 8px;
  border-radius: 4px;
  font-size: 0.75rem;
  white-space: nowrap;
  opacity: 0;
  pointer-events: none;
  transition: opacity 0.2s ease;
}

.chapter-marker:hover .chapter-tooltip {
  opacity: 1;
}

/* Bottom Controls */
.bottom-controls {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.controls-left,
.controls-right {
  display: flex;
  align-items: center;
  gap: 8px;
}

.control-btn {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  border: none;
  color: #FAFAF8;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.3s ease;
}

.control-btn:active {
  transform: scale(0.9);
  background: rgba(164, 113, 72, 0.3);
}

/* Volume Slider */
.volume-slider {
  width: 100px;
  display: flex;
  align-items: center;
}

.volume-input {
  width: 100%;
  height: 4px;
  background: linear-gradient(
    to right,
    #a47148 0%,
    #a47148 var(--value),
    rgba(255, 255, 255, 0.2) var(--value)
  );
  border-radius: 2px;
  outline: none;
  -webkit-appearance: none;
}

.volume-input::-webkit-slider-thumb {
  -webkit-appearance: none;
  width: 16px;
  height: 16px;
  background: #FAFAF8;
  border-radius: 50%;
  cursor: pointer;
}

/* Video Info */
.video-info {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 0.875rem;
  color: #ccc;
}

.quality-badge {
  padding: 2px 8px;
  background: rgba(164, 113, 72, 0.3);
  color: #a47148;
  border-radius: 4px;
  font-weight: 500;
}

.separator {
  color: rgba(255, 255, 255, 0.3);
}

/* Settings Panel */
.settings-panel {
  position: absolute;
  right: 0;
  top: 0;
  bottom: 0;
  width: 300px;
  max-width: 80%;
  background: linear-gradient(135deg, rgba(26, 26, 26, 0.98) 0%, rgba(10, 10, 10, 0.98) 100%);
  backdrop-filter: blur(20px);
  padding: 20px;
  z-index: 20;
  overflow-y: auto;
  -webkit-overflow-scrolling: touch;
}

.settings-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 24px;
}

.settings-header h4 {
  font-size: 1.25rem;
  font-weight: 400;
  color: #FAFAF8;
  margin: 0;
}

.settings-close {
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

.settings-close:active {
  transform: scale(0.9);
}

.setting-group {
  margin-bottom: 24px;
}

.setting-group label {
  display: block;
  font-size: 1rem;
  color: #FAFAF8;
  margin-bottom: 12px;
}

.speed-options,
.quality-options {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.speed-btn,
.quality-btn {
  padding: 8px 16px;
  background: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 20px;
  color: #FAFAF8;
  cursor: pointer;
  transition: all 0.3s ease;
}

.speed-btn.active,
.quality-btn.active {
  background: rgba(164, 113, 72, 0.3);
  border-color: #a47148;
  color: #a47148;
}

.quality-btn {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 12px 16px;
}

.quality-detail {
  font-size: 0.75rem;
  color: #999;
  margin-top: 4px;
}

/* Subtitle Toggle */
.subtitle-toggle {
  display: flex;
  align-items: center;
  gap: 16px;
}

.switch {
  position: relative;
  display: inline-block;
  width: 48px;
  height: 24px;
}

.switch input {
  opacity: 0;
  width: 0;
  height: 0;
}

.slider {
  position: absolute;
  cursor: pointer;
  inset: 0;
  background: rgba(255, 255, 255, 0.2);
  border-radius: 24px;
  transition: 0.3s;
}

.slider:before {
  position: absolute;
  content: "";
  height: 18px;
  width: 18px;
  left: 3px;
  bottom: 3px;
  background: #FAFAF8;
  border-radius: 50%;
  transition: 0.3s;
}

input:checked + .slider {
  background: #a47148;
}

input:checked + .slider:before {
  transform: translateX(24px);
}

/* Gesture Indicator */
.gesture-indicator {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background: rgba(0, 0, 0, 0.8);
  backdrop-filter: blur(10px);
  padding: 16px 24px;
  border-radius: 50px;
  display: flex;
  align-items: center;
  gap: 12px;
  color: #FAFAF8;
  pointer-events: none;
  z-index: 30;
}

.gesture-indicator .material-icons {
  font-size: 28px;
  color: #a47148;
}

/* Playlist Drawer */
.playlist-drawer {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  background: linear-gradient(135deg, rgba(26, 26, 26, 0.98) 0%, rgba(10, 10, 10, 0.98) 100%);
  backdrop-filter: blur(20px);
  border-top-left-radius: 24px;
  border-top-right-radius: 24px;
  transform: translateY(calc(100% - 60px));
  transition: transform 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  z-index: 15;
  max-height: 50vh;
}

.playlist-drawer.expanded {
  transform: translateY(0);
}

.playlist-toggle {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  width: 100%;
  padding: 20px;
  background: transparent;
  border: none;
  color: #FAFAF8;
  cursor: pointer;
}

.playlist-content {
  padding: 0 20px 20px;
  overflow-y: auto;
  max-height: calc(50vh - 60px);
  -webkit-overflow-scrolling: touch;
}

.playlist-item {
  display: flex;
  gap: 12px;
  padding: 12px;
  background: rgba(255, 255, 255, 0.05);
  border-radius: 12px;
  margin-bottom: 8px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.playlist-item:active {
  transform: scale(0.98);
}

.playlist-item.active {
  background: rgba(164, 113, 72, 0.2);
  border: 1px solid rgba(164, 113, 72, 0.3);
}

.playlist-thumbnail {
  position: relative;
  width: 80px;
  height: 60px;
  border-radius: 8px;
  overflow: hidden;
  flex-shrink: 0;
}

.playlist-thumbnail img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.playlist-duration {
  position: absolute;
  bottom: 4px;
  right: 4px;
  background: rgba(0, 0, 0, 0.8);
  color: #FAFAF8;
  padding: 2px 6px;
  border-radius: 4px;
  font-size: 0.75rem;
}

.playlist-info {
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.playlist-info h5 {
  font-size: 0.875rem;
  font-weight: 400;
  color: #FAFAF8;
  margin: 0 0 4px;
}

.playlist-info p {
  font-size: 0.75rem;
  color: #999;
  margin: 0;
}

/* Transitions */
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}

.slide-enter-active,
.slide-leave-active {
  transition: transform 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

.slide-enter-from,
.slide-leave-to {
  transform: translateX(100%);
}

/* Fullscreen adjustments */
.mobile-video-player:fullscreen {
  background: #000;
}

.mobile-video-player:fullscreen video {
  object-fit: contain;
}
</style>