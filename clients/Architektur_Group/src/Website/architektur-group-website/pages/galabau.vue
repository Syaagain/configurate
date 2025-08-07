<template>
  <div class="galabau-page">
    <!-- Hero Section -->
    <section class="hero-section">
      <div class="hero-background">
        <div class="hero-overlay"></div>
        <img 
          src="https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png" 
          alt="Exclusive Galabau"
          class="hero-image"
        >
      </div>
      <div class="hero-content">
        <div class="hero-text">
          <h1 class="hero-title">EXCLUSIVE GALABAU</h1>
          <p class="hero-subtitle">Garten- & Landschaftsbau in Perfektion</p>
          <p class="hero-description">Von Naturstein über Planung bis zur Ausführung – Außenbereiche in höchster Vollendung</p>
        </div>
      </div>
    </section>

    <!-- Services Overview -->
    <section class="services-section">
      <div class="container">
        <div class="section-header">
          <h2 class="section-title">UNSERE LEISTUNGEN</h2>
          <p class="section-subtitle">Maßgeschneiderte Lösungen für jeden Außenbereich</p>
        </div>
        
        <div class="services-grid">
          <div 
            v-for="(service, index) in services" 
            :key="service.id"
            class="service-card"
            :style="{ animationDelay: `${index * 0.2}s` }"
            @mouseenter="playHoverSound"
          >
            <div class="service-icon">
              <span class="material-icons">{{ service.icon }}</span>
            </div>
            <h3 class="service-title">{{ service.title }}</h3>
            <p class="service-description">{{ service.description }}</p>
            <ul class="service-features">
              <li v-for="feature in service.features" :key="feature">{{ feature }}</li>
            </ul>
            <div class="service-action">
              <button @click="openServiceModal(service)" class="service-btn">
                DETAILS
              </button>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Project Showcase -->
    <section class="showcase-section">
      <div class="container">
        <div class="section-header">
          <h2 class="section-title">REFERENZPROJEKTE</h2>
          <p class="section-subtitle">Einblicke in unsere exklusiven Realisierungen</p>
        </div>
        
        <div class="showcase-slider" ref="showcaseSlider">
          <div class="showcase-track" :style="{ transform: `translateX(-${currentSlide * 100}%)` }">
            <div 
              v-for="project in projects" 
              :key="project.id"
              class="showcase-slide"
            >
              <div class="project-image">
                <img :src="project.image" :alt="project.title">
                <div class="project-overlay">
                  <div class="project-info">
                    <h3>{{ project.title }}</h3>
                    <p>{{ project.location }}</p>
                    <div class="project-tags">
                      <span v-for="tag in project.tags" :key="tag" class="project-tag">{{ tag }}</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          
          <div class="showcase-controls">
            <button @click="prevSlide" class="control-btn prev">
              <span class="material-icons">chevron_left</span>
            </button>
            <div class="slide-indicators">
              <button 
                v-for="(project, index) in projects" 
                :key="index"
                @click="goToSlide(index)"
                :class="['indicator', { active: currentSlide === index }]"
              ></button>
            </div>
            <button @click="nextSlide" class="control-btn next">
              <span class="material-icons">chevron_right</span>
            </button>
          </div>
        </div>
      </div>
    </section>

    <!-- Process Section -->
    <section class="process-section">
      <div class="container">
        <div class="section-header">
          <h2 class="section-title">UNSER PROZESS</h2>
          <p class="section-subtitle">Von der Idee zur Realisation</p>
        </div>
        
        <div class="process-timeline">
          <div 
            v-for="(step, index) in processSteps" 
            :key="step.id"
            class="timeline-item"
            :class="{ visible: visibleSteps.includes(index) }"
          >
            <div class="timeline-marker">
              <span class="step-number">{{ index + 1 }}</span>
            </div>
            <div class="timeline-content">
              <h3 class="step-title">{{ step.title }}</h3>
              <p class="step-description">{{ step.description }}</p>
              <ul class="step-details">
                <li v-for="detail in step.details" :key="detail">{{ detail }}</li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Service Modal -->
    <transition name="modal">
      <div v-if="selectedService" class="modal-overlay" @click="closeModal">
        <div class="modal-content" @click.stop>
          <button class="modal-close" @click="closeModal">
            <span class="material-icons">close</span>
          </button>
          <div class="modal-body">
            <div class="modal-header">
              <div class="modal-icon">
                <span class="material-icons">{{ selectedService.icon }}</span>
              </div>
              <h2 class="modal-title">{{ selectedService.title }}</h2>
            </div>
            <div class="modal-info">
              <p class="modal-description">{{ selectedService.fullDescription }}</p>
              <div class="modal-features">
                <h4>Leistungsumfang:</h4>
                <ul>
                  <li v-for="feature in selectedService.features" :key="feature">{{ feature }}</li>
                </ul>
              </div>
              <div class="modal-materials" v-if="selectedService.materials">
                <h4>Materialien:</h4>
                <div class="material-chips">
                  <span v-for="material in selectedService.materials" :key="material" class="material-chip">
                    {{ material }}
                  </span>
                </div>
              </div>
              <div class="modal-actions">
                <NuxtLink to="/kontakt" class="cta-button">PROJEKT ANFRAGEN</NuxtLink>
                <button @click="closeModal" class="secondary-button">SCHLIEßEN</button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </transition>

    <!-- CTA Section -->
    <section class="cta-section">
      <div class="cta-background">
        <div class="cta-overlay"></div>
      </div>
      <div class="container">
        <div class="cta-content">
          <h2 class="cta-title">VERWIRKLICHEN SIE IHREN TRAUMGARTEN</h2>
          <p class="cta-text">Lassen Sie uns gemeinsam Ihren Außenbereich zu einem Meisterwerk gestalten. Individuelle Beratung und maßgeschneiderte Lösungen erwarten Sie.</p>
          <div class="cta-actions">
            <NuxtLink to="/kontakt" class="cta-button primary">KOSTENLOSE BERATUNG</NuxtLink>
            <button @click="scrollToTop" class="cta-button secondary">PROJEKTE ANSEHEN</button>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
const selectedService = ref(null)
const currentSlide = ref(0)
const visibleSteps = ref([])
const showcaseSlider = ref(null)

const services = [
  {
    id: 1,
    title: 'Natursteinverlegung',
    icon: 'landscape',
    description: 'Exklusive Natursteinarbeiten für Terrassen, Wege und Einfahrten.',
    fullDescription: 'Professionelle Verlegung von hochwertigen Natursteinen mit jahrzehntelanger Erfahrung. Wir verwenden ausschließlich erstklassige Materialien und innovative Verlegetechniken.',
    features: [
      'Individuelle Beratung und Planung',
      'Fachgerechte Vorbereitung des Untergrunds',
      'Präzise Verlegung nach höchsten Standards',
      'Fugenarbeiten und Oberflächenbehandlung',
      '10 Jahre Garantie auf unsere Arbeiten'
    ],
    materials: ['Granit', 'Marmor', 'Travertin', 'Schiefer', 'Sandstein']
  },
  {
    id: 2,
    title: 'Gartenplanung',
    icon: 'park',
    description: 'Durchdachte Konzepte für harmonische Garten- und Landschaftsgestaltung.',
    fullDescription: 'Unsere erfahrenen Landschaftsarchitekten entwickeln maßgeschneiderte Konzepte, die Ihre Wünsche mit den örtlichen Gegebenheiten perfekt in Einklang bringen.',
    features: [
      '3D-Visualisierung Ihres Traumgartens',
      'Berücksichtigung von Klima und Boden',
      'Nachhaltige Materialauswahl',
      'Integration moderner Bewässerungssysteme',
      'Langfristige Pflegekonzepte'
    ],
    materials: ['Naturstein', 'Holz', 'Metall', 'Glas', 'Beton']
  },
  {
    id: 3,
    title: 'Wasserlandschaften',
    icon: 'water_drop',
    description: 'Elegante Teiche, Brunnen und Wasserspiele für lebendige Atmosphäre.',
    fullDescription: 'Schaffen Sie mit unseren Wasserlandschaften einen besonderen Wohlfühlbereich. Von klassischen Gartenteichen bis zu modernen Wasserspielen.',
    features: [
      'Naturnahe Teichgestaltung',
      'Moderne Filtertechnik',
      'LED-Unterwasserbeleuchtung',
      'Automatische Steuerungssysteme',
      'Ganzjährige Wartung'
    ],
    materials: ['Naturstein', 'EPDM-Folie', 'Edelstahl', 'Keramik']
  },
  {
    id: 4,
    title: 'Outdoor Living',
    icon: 'deck',
    description: 'Luxuriöse Außenbereiche zum Entspannen und Genießen.',
    fullDescription: 'Verwandeln Sie Ihren Garten in eine exklusive Outdoor-Oase mit stilvollen Terrassen, Grillbereichen und gemütlichen Sitzecken.',
    features: [
      'Maßgeschneiderte Terrassengestaltung',
      'Integrierte Grillstationen',
      'Wettergeschützte Bereiche',
      'Ambiente-Beleuchtung',
      'Hochwertige Gartenmöbel-Beratung'
    ],
    materials: ['WPC', 'Naturstein', 'Keramikplatten', 'Holz']
  },
  {
    id: 5,
    title: 'Pflanzengestaltung',
    icon: 'eco',
    description: 'Durchdachte Bepflanzungskonzepte für ganzjährige Schönheit.',
    fullDescription: 'Unsere Pflanzenexperten gestalten harmonische Pflanzenkombinationen, die zu jeder Jahreszeit begeistern und pflegeleicht sind.',
    features: [
      'Standortgerechte Pflanzenauswahl',
      'Saisonale Gestaltungskonzepte',
      'Automatische Bewässerung',
      'Professioneller Gehölzschnitt',
      'Langfristige Gartenpflege'
    ],
    materials: ['Stauden', 'Gehölze', 'Gräser', 'Rosen', 'Exotische Pflanzen']
  },
  {
    id: 6,
    title: 'Beleuchtungskonzepte',
    icon: 'lightbulb',
    description: 'Stimmungsvolle Gartenbeleuchtung für Tag und Nacht.',
    fullDescription: 'Mit durchdachten Beleuchtungskonzepten setzen wir Ihren Garten auch nach Sonnenuntergang perfekt in Szene.',
    features: [
      'LED-Technik für Energieeffizienz',
      'Smart Home Integration',
      'Wetterfeste Komponenten',
      'Individuelle Lichtszenarien',
      'Professionelle Installation'
    ],
    materials: ['LED-Spots', 'Pollerleuchten', 'Unterwasserstrahler', 'Solarleuchten']
  }
]

const projects = [
  {
    id: 1,
    title: 'Villa am Starnberger See',
    location: 'Starnberg, Bayern',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png',
    tags: ['Naturstein', 'Wasserspiel', 'Terrasse']
  },
  {
    id: 2,
    title: 'Penthouse Garten Düsseldorf',
    location: 'Düsseldorf, NRW',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b70b0803723582ed6.png',
    tags: ['Dachterrasse', 'Modern', 'Beleuchtung']
  },
  {
    id: 3,
    title: 'Luxus Resort Garmisch',
    location: 'Garmisch-Partenkirchen',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b097a8069ca3ac95a.png',
    tags: ['Großprojekt', 'Alpine Gestaltung', 'Wellness']
  }
]

const processSteps = [
  {
    id: 1,
    title: 'Erstberatung & Besichtigung',
    description: 'Persönliche Beratung vor Ort zur Erfassung Ihrer Wünsche und Gegebenheiten.',
    details: [
      'Kostenlose Erstberatung',
      'Aufmaß und Bestandsaufnahme',
      'Ideensammlung und Inspiration',
      'Budgetplanung'
    ]
  },
  {
    id: 2,
    title: 'Planung & Design',
    description: '3D-Planung und detaillierte Ausarbeitung Ihres individuellen Gartenkonzepts.',
    details: [
      '3D-Visualisierung',
      'Materialauswahl',
      'Technische Planung',
      'Zeitplanung'
    ]
  },
  {
    id: 3,
    title: 'Angebot & Beauftragung',
    description: 'Transparentes Angebot mit detaillierter Aufschlüsselung aller Leistungen.',
    details: [
      'Detailliertes Angebot',
      'Festpreisgarantie',
      'Vertragsabschluss',
      'Terminplanung'
    ]
  },
  {
    id: 4,
    title: 'Umsetzung',
    description: 'Professionelle Ausführung durch unser erfahrenes Fachteam.',
    details: [
      'Vorarbeiten und Erdarbeiten',
      'Materiallieferung',
      'Fachgerechte Ausführung',
      'Qualitätskontrolle'
    ]
  },
  {
    id: 5,
    title: 'Abnahme & Service',
    description: 'Gemeinsame Abnahme und langfristige Betreuung Ihres Traumgartens.',
    details: [
      'Gemeinsame Abnahme',
      'Einweisung und Pflege-Tipps',
      'Garantieleistungen',
      'Langfristiger Service'
    ]
  }
]

let slideInterval = null

const openServiceModal = (service) => {
  selectedService.value = service
  document.body.style.overflow = 'hidden'
}

const closeModal = () => {
  selectedService.value = null
  document.body.style.overflow = 'auto'
}

const nextSlide = () => {
  currentSlide.value = (currentSlide.value + 1) % projects.length
}

const prevSlide = () => {
  currentSlide.value = currentSlide.value === 0 ? projects.length - 1 : currentSlide.value - 1
}

const goToSlide = (index) => {
  currentSlide.value = index
}

const playHoverSound = () => {
  // Placeholder for hover sound effect
  console.log('Hover sound effect')
}

const scrollToTop = () => {
  window.scrollTo({ top: 0, behavior: 'smooth' })
}

onMounted(() => {
  // Auto-play slideshow
  slideInterval = setInterval(nextSlide, 5000)
  
  // Intersection Observer for timeline animation
  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        const index = parseInt(entry.target.dataset.index)
        if (!visibleSteps.value.includes(index)) {
          visibleSteps.value.push(index)
        }
      }
    })
  }, { threshold: 0.5 })
  
  // Observe timeline items after next tick
  nextTick(() => {
    document.querySelectorAll('.timeline-item').forEach((item, index) => {
      item.dataset.index = index
      observer.observe(item)
    })
  })
})

onUnmounted(() => {
  if (slideInterval) {
    clearInterval(slideInterval)
  }
  document.body.style.overflow = 'auto'
})
</script>

<style scoped>
.galabau-page {
  min-height: 100vh;
  background: #000;
  color: #FAFAF8;
  padding-top: 80px;
}

/* Hero Section */
.hero-section {
  position: relative;
  height: 80vh;
  overflow: hidden;
}

.hero-background {
  position: relative;
  width: 100%;
  height: 100%;
}

.hero-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.hero-overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(45deg, rgba(0,0,0,0.8), rgba(164, 113, 72, 0.4));
  z-index: 1;
}

.hero-content {
  position: absolute;
  inset: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 2;
}

.hero-text {
  text-align: center;
  max-width: 800px;
  padding: 0 2rem;
  animation: heroFadeIn 1.5s ease-out;
}

.hero-title {
  font-size: clamp(3rem, 6vw, 5rem);
  font-weight: 600;
  letter-spacing: 0.05em;
  margin-bottom: 1rem;
  background: linear-gradient(135deg, #FAFAF8 0%, #a47148 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.hero-subtitle {
  font-size: 1.8rem;
  font-weight: 300;
  margin-bottom: 1rem;
  color: #a47148;
}

.hero-description {
  font-size: 1.2rem;
  font-weight: 300;
  opacity: 0.9;
  line-height: 1.6;
}

/* Common Container */
.container {
  max-width: 1400px;
  margin: 0 auto;
  padding: 0 2rem;
}

.section-header {
  text-align: center;
  margin-bottom: 4rem;
}

.section-title {
  font-size: 3rem;
  font-weight: 300;
  margin-bottom: 1rem;
  background: linear-gradient(135deg, #FAFAF8 0%, #a47148 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.section-subtitle {
  font-size: 1.25rem;
  color: #999;
  font-weight: 300;
}

/* Services Section */
.services-section {
  padding: 6rem 0;
  background: linear-gradient(135deg, #0a0a0a 0%, #1a1a1a 100%);
}

.services-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
  gap: 2rem;
}

.service-card {
  background: rgba(255, 255, 255, 0.05);
  border-radius: 20px;
  padding: 2.5rem;
  text-align: center;
  transition: all 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  border: 1px solid rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  animation: serviceCardFadeIn 0.8s ease-out forwards;
  opacity: 0;
  transform: translateY(30px);
}

.service-card:hover {
  transform: translateY(-15px);
  background: rgba(255, 255, 255, 0.08);
  box-shadow: 0 25px 50px rgba(164, 113, 72, 0.3);
}

.service-icon {
  width: 80px;
  height: 80px;
  margin: 0 auto 2rem;
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #000;
  font-size: 2rem;
}

.service-title {
  font-size: 1.5rem;
  font-weight: 400;
  margin-bottom: 1rem;
  color: #FAFAF8;
}

.service-description {
  font-size: 1rem;
  line-height: 1.6;
  color: #ccc;
  margin-bottom: 2rem;
}

.service-features {
  list-style: none;
  padding: 0;
  margin-bottom: 2rem;
  text-align: left;
}

.service-features li {
  padding: 0.5rem 0;
  color: #999;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
  position: relative;
  padding-left: 1.5rem;
}

.service-features li:before {
  content: '→';
  position: absolute;
  left: 0;
  color: #a47148;
  font-weight: bold;
}

.service-btn {
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  color: #000;
  border: none;
  padding: 0.75rem 2rem;
  border-radius: 25px;
  font-weight: 500;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  cursor: pointer;
  transition: all 0.3s ease;
}

.service-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 10px 20px rgba(164, 113, 72, 0.4);
}

/* Showcase Section */
.showcase-section {
  padding: 6rem 0;
}

.showcase-slider {
  position: relative;
  overflow: hidden;
  border-radius: 20px;
  background: rgba(255, 255, 255, 0.05);
  backdrop-filter: blur(10px);
}

.showcase-track {
  display: flex;
  transition: transform 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

.showcase-slide {
  min-width: 100%;
  height: 500px;
  position: relative;
}

.project-image {
  width: 100%;
  height: 100%;
  position: relative;
  overflow: hidden;
}

.project-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.8s ease;
}

.project-overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(45deg, rgba(0,0,0,0.7), transparent);
  display: flex;
  align-items: end;
  padding: 3rem;
  opacity: 0;
  transition: opacity 0.5s ease;
}

.showcase-slide:hover .project-overlay {
  opacity: 1;
}

.showcase-slide:hover .project-image img {
  transform: scale(1.1);
}

.project-info h3 {
  font-size: 2rem;
  font-weight: 400;
  margin-bottom: 0.5rem;
  color: #FAFAF8;
}

.project-info p {
  font-size: 1.2rem;
  color: #a47148;
  margin-bottom: 1rem;
}

.project-tags {
  display: flex;
  gap: 0.5rem;
  flex-wrap: wrap;
}

.project-tag {
  padding: 0.25rem 0.75rem;
  background: rgba(164, 113, 72, 0.3);
  color: #a47148;
  font-size: 0.875rem;
  border-radius: 15px;
  border: 1px solid rgba(164, 113, 72, 0.5);
}

.showcase-controls {
  position: absolute;
  bottom: 2rem;
  left: 50%;
  transform: translateX(-50%);
  display: flex;
  align-items: center;
  gap: 2rem;
  background: rgba(0, 0, 0, 0.5);
  padding: 1rem 2rem;
  border-radius: 50px;
  backdrop-filter: blur(10px);
}

.control-btn {
  background: rgba(255, 255, 255, 0.2);
  border: none;
  border-radius: 50%;
  width: 50px;
  height: 50px;
  color: #FAFAF8;
  cursor: pointer;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  justify-content: center;
}

.control-btn:hover {
  background: #a47148;
  transform: scale(1.1);
}

.slide-indicators {
  display: flex;
  gap: 0.5rem;
}

.indicator {
  width: 12px;
  height: 12px;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.3);
  border: none;
  cursor: pointer;
  transition: all 0.3s ease;
}

.indicator.active {
  background: #a47148;
  transform: scale(1.2);
}

/* Process Section */
.process-section {
  padding: 6rem 0;
  background: linear-gradient(135deg, #1a1a1a 0%, #0a0a0a 100%);
}

.process-timeline {
  max-width: 800px;
  margin: 0 auto;
  position: relative;
}

.process-timeline::before {
  content: '';
  position: absolute;
  left: 50px;
  top: 0;
  bottom: 0;
  width: 2px;
  background: linear-gradient(180deg, #a47148, #FAFAF8);
}

.timeline-item {
  display: flex;
  gap: 3rem;
  margin-bottom: 4rem;
  opacity: 0;
  transform: translateX(-50px);
  transition: all 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

.timeline-item.visible {
  opacity: 1;
  transform: translateX(0);
}

.timeline-marker {
  flex: 0 0 100px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.step-number {
  width: 60px;
  height: 60px;
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.5rem;
  font-weight: 600;
  color: #000;
}

.timeline-content {
  flex: 1;
  padding: 1rem 0;
}

.step-title {
  font-size: 1.5rem;
  font-weight: 400;
  margin-bottom: 1rem;
  color: #FAFAF8;
}

.step-description {
  font-size: 1.1rem;
  line-height: 1.6;
  color: #ccc;
  margin-bottom: 1.5rem;
}

.step-details {
  list-style: none;
  padding: 0;
}

.step-details li {
  padding: 0.5rem 0;
  color: #999;
  position: relative;
  padding-left: 1.5rem;
}

.step-details li:before {
  content: '✓';
  position: absolute;
  left: 0;
  color: #a47148;
  font-weight: bold;
}

/* Modal Styles */
.modal-overlay {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.9);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
  backdrop-filter: blur(10px);
}

.modal-content {
  background: linear-gradient(135deg, #1a1a1a 0%, #0a0a0a 100%);
  border-radius: 20px;
  max-width: 800px;
  width: 90%;
  max-height: 90vh;
  overflow-y: auto;
  position: relative;
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.modal-close {
  position: absolute;
  top: 1rem;
  right: 1rem;
  background: rgba(255, 255, 255, 0.1);
  border: none;
  border-radius: 50%;
  width: 40px;
  height: 40px;
  color: #FAFAF8;
  cursor: pointer;
  z-index: 1;
  transition: all 0.3s ease;
}

.modal-close:hover {
  background: rgba(255, 255, 255, 0.2);
  transform: rotate(90deg);
}

.modal-body {
  padding: 3rem;
}

.modal-header {
  text-align: center;
  margin-bottom: 2rem;
}

.modal-icon {
  width: 80px;
  height: 80px;
  margin: 0 auto 1rem;
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #000;
  font-size: 2rem;
}

.modal-title {
  font-size: 2rem;
  font-weight: 400;
  color: #FAFAF8;
}

.modal-description {
  font-size: 1.1rem;
  line-height: 1.6;
  color: #ccc;
  margin-bottom: 2rem;
}

.modal-features,
.modal-materials {
  margin-bottom: 2rem;
}

.modal-features h4,
.modal-materials h4 {
  font-size: 1.2rem;
  color: #FAFAF8;
  margin-bottom: 1rem;
}

.modal-features ul {
  list-style: none;
  padding: 0;
}

.modal-features li {
  padding: 0.5rem 0;
  color: #ccc;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
  position: relative;
  padding-left: 1.5rem;
}

.modal-features li:before {
  content: '→';
  position: absolute;
  left: 0;
  color: #a47148;
  font-weight: bold;
}

.material-chips {
  display: flex;
  gap: 0.5rem;
  flex-wrap: wrap;
}

.material-chip {
  padding: 0.5rem 1rem;
  background: rgba(164, 113, 72, 0.2);
  color: #a47148;
  border-radius: 20px;
  font-size: 0.875rem;
  border: 1px solid rgba(164, 113, 72, 0.3);
}

.modal-actions {
  display: flex;
  gap: 1rem;
  justify-content: center;
  margin-top: 2rem;
}

/* CTA Section */
.cta-section {
  position: relative;
  padding: 8rem 0;
  overflow: hidden;
}

.cta-background {
  position: absolute;
  inset: 0;
  background: url('https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png') center/cover;
}

.cta-overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(45deg, rgba(0,0,0,0.9), rgba(164, 113, 72, 0.3));
}

.cta-content {
  position: relative;
  z-index: 2;
  text-align: center;
  max-width: 800px;
  margin: 0 auto;
}

.cta-title {
  font-size: 3.5rem;
  font-weight: 600;
  margin-bottom: 2rem;
  background: linear-gradient(135deg, #FAFAF8 0%, #a47148 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.cta-text {
  font-size: 1.25rem;
  line-height: 1.6;
  margin-bottom: 3rem;
  color: #ccc;
}

.cta-actions {
  display: flex;
  gap: 2rem;
  justify-content: center;
  flex-wrap: wrap;
}

/* Buttons */
.cta-button,
.secondary-button {
  display: inline-block;
  padding: 1rem 2.5rem;
  font-size: 1rem;
  font-weight: 500;
  text-transform: uppercase;
  letter-spacing: 0.1em;
  border-radius: 50px;
  text-decoration: none;
  cursor: pointer;
  transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  position: relative;
  overflow: hidden;
  border: 2px solid transparent;
}

.cta-button.primary {
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  color: #000;
}

.cta-button.secondary {
  background: transparent;
  color: #FAFAF8;
  border-color: #FAFAF8;
}

.secondary-button {
  background: transparent;
  color: #FAFAF8;
  border: 2px solid #FAFAF8;
}

.cta-button:hover,
.secondary-button:hover {
  transform: translateY(-3px);
}

.cta-button.primary:hover {
  box-shadow: 0 15px 30px rgba(164, 113, 72, 0.4);
}

.cta-button.secondary:hover,
.secondary-button:hover {
  background: #FAFAF8;
  color: #000;
}

/* Animations */
@keyframes heroFadeIn {
  from {
    opacity: 0;
    transform: translateY(50px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

@keyframes serviceCardFadeIn {
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* Modal Transitions */
.modal-enter-active,
.modal-leave-active {
  transition: opacity 0.4s ease;
}

.modal-enter-from,
.modal-leave-to {
  opacity: 0;
}

.modal-enter-active .modal-content,
.modal-leave-active .modal-content {
  transition: transform 0.4s ease;
}

.modal-enter-from .modal-content,
.modal-leave-to .modal-content {
  transform: scale(0.8);
}

/* Responsive Design */
@media (max-width: 768px) {
  .hero-title {
    font-size: 2.5rem;
  }
  
  .services-grid {
    grid-template-columns: 1fr;
    gap: 1.5rem;
  }
  
  .service-card {
    padding: 2rem;
  }
  
  .showcase-controls {
    gap: 1rem;
    padding: 0.75rem 1.5rem;
  }
  
  .process-timeline::before {
    left: 30px;
  }
  
  .timeline-item {
    gap: 2rem;
  }
  
  .timeline-marker {
    flex: 0 0 60px;
  }
  
  .step-number {
    width: 50px;
    height: 50px;
    font-size: 1.2rem;
  }
  
  .cta-title {
    font-size: 2.5rem;
  }
  
  .cta-actions {
    flex-direction: column;
    align-items: center;
  }
  
  .modal-body {
    padding: 2rem;
  }
  
  .modal-actions {
    flex-direction: column;
  }
}
</style>