<template>
  <section id="hero" :class="['hero', { 'hide-hero': hideHero }]">
    <video
      id="heroVideo"
      src="https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/68545d9204d5bf38e7066c74.mp4"
      autoplay
      muted
      playsinline
      preload="auto"
      class="hero-video"
    ></video>
    
    <div class="hero-claim">
      <h1>EUROPAS EXQUISITESTE SELEKTION<br>ERLESENER BELÄGE</h1>
      <p class="subtitle">Vollendete Luxuslösungen – maßgeschneiderte Meisterwerke aus einer Hand</p>
    </div>
  </section>
</template>

<script setup>
const hideHero = ref(false)

onMounted(() => {
  window.addEventListener('scroll', handleScroll)
})

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll)
})

const handleScroll = () => {
  if (window.scrollY > window.innerHeight * 0.8) {
    hideHero.value = true
  } else {
    hideHero.value = false
  }
}
</script>

<style scoped>
.hero {
  position: relative;
  width: 100%;
  height: 100vh;
  overflow: hidden;
  transition: opacity 0.6s ease, height 0.6s ease;
}

.hero.hide-hero {
  opacity: 0;
  height: 0 !important;
  pointer-events: none;
}

.hero-video {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.hero-claim {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 100%;
  text-align: center;
  color: white;
  opacity: 0;
  animation: claimMove 1s ease-out forwards;
  animation-delay: 0.1s;
}

.hero-claim h1 {
  font-size: clamp(1.6rem, 4vw, 3.2rem);
  font-weight: 600;
  letter-spacing: 0.03em;
  margin-bottom: 1rem;
}

.subtitle {
  font-size: clamp(1rem, 2vw, 1.5rem);
  font-weight: 300;
  opacity: 0.9;
}
</style>