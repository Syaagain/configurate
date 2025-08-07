<template>
  <div class="fliesen-page">
    <!-- Hero Section -->
    <section class="hero-section">
      <div class="hero-background">
        <div class="hero-overlay"></div>
        <img 
          src="https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png" 
          alt="Premium Fliesen Design"
          class="hero-image"
        >
      </div>
      <div class="hero-content">
        <div class="hero-text">
          <h1 class="hero-title">PREMIUM FLIESEN DESIGN</h1>
          <p class="hero-subtitle">Verlegung auf höchstem Niveau</p>
          <p class="hero-description">Edle Materialien, präzise Verlegung – für Böden, Bäder und Wände mit Stil</p>
        </div>
      </div>
    </section>

    <!-- Features Section -->
    <section class="features-section">
      <div class="container">
        <div class="features-grid">
          <div 
            v-for="(feature, index) in features" 
            :key="feature.id"
            class="feature-card"
            :style="{ animationDelay: `${index * 0.2}s` }"
          >
            <div class="feature-icon">
              <span class="material-icons">{{ feature.icon }}</span>
            </div>
            <h3 class="feature-title">{{ feature.title }}</h3>
            <p class="feature-description">{{ feature.description }}</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Material Categories -->
    <section class="materials-section">
      <div class="container">
        <div class="section-header">
          <h2 class="section-title">UNSERE MATERIALIEN</h2>
          <p class="section-subtitle">Exklusive Auswahl für höchste Ansprüche</p>
        </div>

        <div class="materials-tabs">
          <button 
            v-for="category in materialCategories" 
            :key="category.id"
            @click="activeCategory = category.id"
            :class="['tab-button', { active: activeCategory === category.id }]"
          >
            {{ category.name }}
          </button>
        </div>

        <div class="materials-content">
          <transition name="fade" mode="out-in">
            <div :key="activeCategory" class="category-content">
              <div class="materials-grid">
                <div 
                  v-for="material in currentMaterials" 
                  :key="material.id"
                  class="material-card"
                  @click="openMaterialModal(material)"
                >
                  <div class="material-image">
                    <img :src="material.image" :alt="material.name">
                    <div class="material-overlay">
                      <div class="material-info">
                        <h4>{{ material.name }}</h4>
                        <p>{{ material.size }}</p>
                        <div class="material-properties">
                          <span v-for="prop in material.properties" :key="prop" class="property-tag">
                            {{ prop }}
                          </span>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="material-details">
                    <h4 class="material-name">{{ material.name }}</h4>
                    <p class="material-type">{{ material.type }}</p>
                    <div class="material-rating">
                      <div class="stars">
                        <span v-for="star in 5" :key="star" class="star" :class="{ filled: star <= material.rating }">
                          ★
                        </span>
                      </div>
                      <span class="rating-text">{{ material.rating }}/5</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </transition>
        </div>
      </div>
    </section>

    <!-- Services Section -->
    <section class="services-section">
      <div class="container">
        <div class="section-header">
          <h2 class="section-title">UNSERE EXPERTISE</h2>
          <p class="section-subtitle">Meisterhafte Verlegung in allen Bereichen</p>
        </div>

        <div class="services-showcase">
          <div class="service-item" v-for="(service, index) in services" :key="service.id">
            <div class="service-visual" :class="{ active: activeService === index }" @click="setActiveService(index)">
              <img :src="service.image" :alt="service.title">
              <div class="service-overlay">
                <div class="service-content">
                  <h3>{{ service.title }}</h3>
                  <p>{{ service.description }}</p>
                  <ul class="service-features">
                    <li v-for="feature in service.features" :key="feature">{{ feature }}</li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="service-indicators">
          <button 
            v-for="(service, index) in services" 
            :key="index"
            @click="setActiveService(index)"
            :class="['indicator', { active: activeService === index }]"
          >
            {{ service.title }}
          </button>
        </div>
      </div>
    </section>

    <!-- Process Visualization -->
    <section class="process-section">
      <div class="container">
        <div class="section-header">
          <h2 class="section-title">VERLEGUNGSPROZESS</h2>
          <p class="section-subtitle">Perfektion in jedem Schritt</p>
        </div>

        <div class="process-visualization">
          <div class="process-steps">
            <div 
              v-for="(step, index) in processSteps" 
              :key="step.id"
              class="process-step"
              :class="{ active: activeStep === index, completed: activeStep > index }"
              @click="setActiveStep(index)"
            >
              <div class="step-circle">
                <span v-if="activeStep > index" class="material-icons">check</span>
                <span v-else>{{ index + 1 }}</span>
              </div>
              <div class="step-label">{{ step.title }}</div>
            </div>
          </div>
          
          <div class="process-details">
            <transition name="slide" mode="out-in">
              <div :key="activeStep" class="step-content">
                <div class="step-image">
                  <img :src="processSteps[activeStep].image" :alt="processSteps[activeStep].title">
                </div>
                <div class="step-info">
                  <h3>{{ processSteps[activeStep].title }}</h3>
                  <p>{{ processSteps[activeStep].description }}</p>
                  <ul class="step-checklist">
                    <li v-for="item in processSteps[activeStep].checklist" :key="item">
                      <span class="material-icons">check_circle</span>
                      {{ item }}
                    </li>
                  </ul>
                </div>
              </div>
            </transition>
          </div>
        </div>
      </div>
    </section>

    <!-- Material Modal -->
    <transition name="modal">
      <div v-if="selectedMaterial" class="modal-overlay" @click="closeMaterialModal">
        <div class="modal-content" @click.stop>
          <button class="modal-close" @click="closeMaterialModal">
            <span class="material-icons">close</span>
          </button>
          
          <div class="modal-body">
            <div class="modal-image">
              <img :src="selectedMaterial.image" :alt="selectedMaterial.name">
            </div>
            
            <div class="modal-info">
              <h2 class="modal-title">{{ selectedMaterial.name }}</h2>
              <p class="modal-type">{{ selectedMaterial.type }}</p>
              
              <div class="material-specs">
                <div class="spec-item">
                  <strong>Format:</strong>
                  <span>{{ selectedMaterial.size }}</span>
                </div>
                <div class="spec-item">
                  <strong>Stärke:</strong>
                  <span>{{ selectedMaterial.thickness || '10mm' }}</span>
                </div>
                <div class="spec-item">
                  <strong>Oberfläche:</strong>
                  <span>{{ selectedMaterial.surface || 'Poliert' }}</span>
                </div>
                <div class="spec-item">
                  <strong>Rutschfestigkeit:</strong>
                  <span>{{ selectedMaterial.slipResistance || 'R9' }}</span>
                </div>
              </div>

              <div class="material-properties-detail">
                <h4>Eigenschaften:</h4>
                <div class="properties-grid">
                  <span v-for="prop in selectedMaterial.properties" :key="prop" class="property-badge">
                    {{ prop }}
                  </span>
                </div>
              </div>

              <div class="material-applications">
                <h4>Anwendungsbereiche:</h4>
                <ul>
                  <li v-for="app in selectedMaterial.applications" :key="app">{{ app }}</li>
                </ul>
              </div>

              <div class="modal-actions">
                <NuxtLink to="/kontakt" class="cta-button">MUSTER ANFORDERN</NuxtLink>
                <button @click="closeMaterialModal" class="secondary-button">SCHLIEßEN</button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </transition>

    <!-- CTA Section -->
    <section class="cta-section">
      <div class="container">
        <div class="cta-content">
          <h2 class="cta-title">BEREIT FÜR IHR FLIESENPROJEKT?</h2>
          <p class="cta-text">Vereinbaren Sie einen Termin in unserem Showroom und lassen Sie sich von unserer Expertise überzeugen.</p>
          <div class="cta-actions">
            <NuxtLink to="/kontakt" class="cta-button primary">BERATUNG VEREINBAREN</NuxtLink>
            <NuxtLink to="/sortiment" class="cta-button secondary">SORTIMENT ENTDECKEN</NuxtLink>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
const activeCategory = ref('keramik')
const selectedMaterial = ref(null)
const activeService = ref(0)
const activeStep = ref(0)

let serviceInterval = null

const features = [
  {
    id: 1,
    icon: 'precision_manufacturing',
    title: 'Millimetergenaue Verlegung',
    description: 'Präzision bis ins kleinste Detail für ein perfektes Erscheinungsbild'
  },
  {
    id: 2,
    icon: 'high_quality',
    title: 'Premium Materialien',
    description: 'Ausschließlich hochwertigste Fliesen von europäischen Markenherstellern'
  },
  {
    id: 3,
    icon: 'engineering',
    title: 'Innovative Techniken',
    description: 'Modernste Verlegetechniken für langlebige und beeindruckende Ergebnisse'
  },
  {
    id: 4,
    icon: 'support_agent',
    title: 'Fachberatung',
    description: 'Individuelle Beratung durch zertifizierte Fliesenlegermeister'
  }
]

const materialCategories = [
  { id: 'keramik', name: 'Feinsteinzeug' },
  { id: 'naturstein', name: 'Naturstein' },
  { id: 'grossformat', name: 'Großformat' },
  { id: 'mosaik', name: 'Mosaik' }
]

const materials = {
  keramik: [
    {
      id: 1,
      name: 'Calacatta Oro',
      type: 'Feinsteinzeug',
      size: '120x120 cm',
      image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png',
      properties: ['Poliert', 'Rektifiziert', 'Frostsicher'],
      rating: 5,
      thickness: '12mm',
      surface: 'Hochglanz poliert',
      slipResistance: 'R9',
      applications: ['Wohnbereich', 'Badezimmer', 'Küche', 'Repräsentative Bereiche']
    },
    {
      id: 2,
      name: 'Nero Marquina',
      type: 'Feinsteinzeug',
      size: '60x120 cm',
      image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png',
      properties: ['Matt', 'Rutschfest', 'Pflegeleicht'],
      rating: 5,
      thickness: '10mm',
      surface: 'Matt strukturiert',
      slipResistance: 'R11',
      applications: ['Badezimmer', 'Außenbereich', 'Wellness', 'Gewerbliche Bereiche']
    },
    {
      id: 3,
      name: 'Travertino Romano',
      type: 'Feinsteinzeug',
      size: '80x80 cm',
      image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b70b0803723582ed6.png',
      properties: ['Antikfinish', 'Wärmeleitsystem geeignet', 'UV-beständig'],
      rating: 4,
      thickness: '11mm',
      surface: 'Antik gebürstet',
      slipResistance: 'R10',
      applications: ['Wohnbereich', 'Terrasse', 'Pool', 'Mediterrane Gestaltung']
    }
  ],
  naturstein: [
    {
      id: 4,
      name: 'Carrara Marmor',
      type: 'Marmor',
      size: '60x60 cm',
      image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b097a8069ca3ac95a.png',
      properties: ['Poliert', 'Exklusiv', 'Einzigartige Maserung'],
      rating: 5,
      thickness: '20mm',
      surface: 'Hochglanz poliert',
      slipResistance: 'R9',
      applications: ['Repräsentative Bereiche', 'Badezimmer', 'Küche', 'Wandverkleidung']
    },
    {
      id: 5,
      name: 'Kashmir White',
      type: 'Granit',
      size: '40x40 cm',
      image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png',
      properties: ['Robust', 'Hitzebeständig', 'Säurebeständig'],
      rating: 5,
      thickness: '30mm',
      surface: 'Poliert',
      slipResistance: 'R10',
      applications: ['Küche', 'Außenbereich', 'Arbeitsplatten', 'Hochfrequentierte Bereiche']
    }
  ],
  grossformat: [
    {
      id: 6,
      name: 'Maxima White',
      type: 'Großformat Keramik',
      size: '160x320 cm',
      image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png',
      properties: ['Dünn', 'Leicht', 'Fugenarm'],
      rating: 5,
      thickness: '6mm',
      surface: 'Seidenmatt',
      slipResistance: 'R9',
      applications: ['Wände', 'Moderne Architektur', 'Großflächige Bereiche', 'Minimalistische Designs']
    },
    {
      id: 7,
      name: 'Concrete Grey',
      type: 'Großformat Keramik',
      size: '120x280 cm',
      image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b70b0803723582ed6.png',
      properties: ['Industrial Look', 'Modern', 'Rektifiziert'],
      rating: 4,
      thickness: '9mm',
      surface: 'Strukturiert',
      slipResistance: 'R10',
      applications: ['Loft-Style', 'Moderne Büros', 'Industrial Design', 'Gewerbliche Bereiche']
    }
  ],
  mosaik: [
    {
      id: 8,
      name: 'Golden Mix',
      type: 'Glasmosaik',
      size: '2.5x2.5 cm',
      image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b097a8069ca3ac95a.png',
      properties: ['Glänzend', 'Lichtreflektierend', 'Wasserdicht'],
      rating: 4,
      thickness: '8mm',
      surface: 'Hochglanz',
      slipResistance: 'R9',
      applications: ['Pools', 'Wellness', 'Akzentbereiche', 'Wandgestaltung']
    }
  ]
}

const services = [
  {
    id: 1,
    title: 'Badezimmer',
    description: 'Luxuriöse Badgestaltung mit hochwertigen Fliesen',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png',
    features: [
      'Wasserdichte Abdichtungssysteme',
      'Barrierefreie Lösungen',
      'Fußbodenheizung-Integration',
      'Wellness-Atmosphäre'
    ]
  },
  {
    id: 2,
    title: 'Küche',
    description: 'Praktische und elegante Küchengestaltung',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png',
    features: [
      'Pflegeleichte Oberflächen',
      'Hitze- und fleckenresistent',
      'Individuelle Lösungen',
      'Moderne Optik'
    ]
  },
  {
    id: 3,
    title: 'Wohnbereich',
    description: 'Elegante Bodengestaltung für Wohnräume',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b70b0803723582ed6.png',
    features: [
      'Großformatige Fliesen',
      'Nahtlose Übergänge',
      'Behagliche Atmosphäre',
      'Langlebigkeit'
    ]
  },
  {
    id: 4,
    title: 'Außenbereich',
    description: 'Wetterfeste Lösungen für Terrasse und Balkon',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b097a8069ca3ac95a.png',
    features: [
      'Frostsichere Materialien',
      'Rutschfeste Oberflächen',
      'UV-Beständigkeit',
      'Drainage-Systeme'
    ]
  }
]

const processSteps = [
  {
    id: 1,
    title: 'Beratung & Planung',
    description: 'Umfassende Beratung und detaillierte Planung Ihres Fliesenprojekts',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png',
    checklist: [
      'Vor-Ort-Begehung und Aufmaß',
      'Materialberatung im Showroom',
      '3D-Visualisierung des Projekts',
      'Kostenvoranschlag erstellen'
    ]
  },
  {
    id: 2,
    title: 'Vorbereitung',
    description: 'Professionelle Vorbereitung des Untergrunds für optimale Haftung',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png',
    checklist: [
      'Untergrund prüfen und vorbereiten',
      'Abdichtung anbringen',
      'Heizungsrohre verlegen',
      'Grundierung auftragen'
    ]
  },
  {
    id: 3,
    title: 'Verlegung',
    description: 'Millimetergenaue Verlegung durch erfahrene Fliesenlegermeister',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b70b0803723582ed6.png',
    checklist: [
      'Präzise Fliesenverlegung',
      'Spezialkleber verwenden',
      'Fugenbreite exakt einhalten',
      'Zwischenkontrolle durchführen'
    ]
  },
  {
    id: 4,
    title: 'Verfugung',
    description: 'Fachgerechte Verfugung mit hochwertigen Fugenmassen',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b097a8069ca3ac95a.png',
    checklist: [
      'Premium Fugenmaterial verwenden',
      'Gleichmäßige Fugen ziehen',
      'Reinigung der Fliesenoberfläche',
      'Silikonfugen professionell ziehen'
    ]
  },
  {
    id: 5,
    title: 'Abschluss',
    description: 'Finale Reinigung und Übergabe des perfekten Ergebnisses',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png',
    checklist: [
      'Gründliche Endreinigung',
      'Qualitätskontrolle durchführen',
      'Pflegehinweise übergeben',
      'Garantieschein ausstellen'
    ]
  }
]

const currentMaterials = computed(() => {
  return materials[activeCategory.value] || []
})

const openMaterialModal = (material) => {
  selectedMaterial.value = material
  document.body.style.overflow = 'hidden'
}

const closeMaterialModal = () => {
  selectedMaterial.value = null
  document.body.style.overflow = 'auto'
}

const setActiveService = (index) => {
  activeService.value = index
}

const setActiveStep = (index) => {
  activeStep.value = index
}

onMounted(() => {
  // Auto-cycle through services
  serviceInterval = setInterval(() => {
    activeService.value = (activeService.value + 1) % services.length
  }, 4000)
})

onUnmounted(() => {
  if (serviceInterval) {
    clearInterval(serviceInterval)
  }
  document.body.style.overflow = 'auto'
})
</script>

<style scoped>
.fliesen-page {
  min-height: 100vh;
  background: #000;
  color: #FAFAF8;
  padding-top: 80px;
}

/* Hero Section */
.hero-section {
  position: relative;
  height: 70vh;
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

/* Common Styles */
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

/* Features Section */
.features-section {
  padding: 6rem 0;
  background: linear-gradient(135deg, #0a0a0a 0%, #1a1a1a 100%);
}

.features-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
}

.feature-card {
  background: rgba(255, 255, 255, 0.05);
  border-radius: 20px;
  padding: 3rem 2rem;
  text-align: center;
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.1);
  transition: all 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  animation: featureFadeIn 0.8s ease-out forwards;
  opacity: 0;
  transform: translateY(30px);
}

.feature-card:hover {
  transform: translateY(-10px);
  background: rgba(255, 255, 255, 0.08);
  box-shadow: 0 20px 40px rgba(164, 113, 72, 0.2);
}

.feature-icon {
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
  transition: transform 0.3s ease;
}

.feature-card:hover .feature-icon {
  transform: rotateY(180deg);
}

.feature-title {
  font-size: 1.5rem;
  font-weight: 400;
  margin-bottom: 1rem;
  color: #FAFAF8;
}

.feature-description {
  font-size: 1rem;
  line-height: 1.6;
  color: #ccc;
}

/* Materials Section */
.materials-section {
  padding: 6rem 0;
}

.materials-tabs {
  display: flex;
  justify-content: center;
  gap: 1rem;
  margin-bottom: 3rem;
  flex-wrap: wrap;
}

.tab-button {
  padding: 1rem 2rem;
  background: transparent;
  border: 2px solid rgba(255, 255, 255, 0.2);
  color: #FAFAF8;
  font-size: 1rem;
  font-weight: 300;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  border-radius: 50px;
  cursor: pointer;
  transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  position: relative;
  overflow: hidden;
}

.tab-button::before {
  content: '';
  position: absolute;
  inset: 0;
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  transform: translateY(-100%);
  transition: transform 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  z-index: -1;
}

.tab-button:hover,
.tab-button.active {
  border-color: #a47148;
  color: #000;
}

.tab-button:hover::before,
.tab-button.active::before {
  transform: translateY(0);
}

.materials-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
}

.material-card {
  background: rgba(255, 255, 255, 0.05);
  border-radius: 20px;
  overflow: hidden;
  cursor: pointer;
  transition: all 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  border: 1px solid rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
}

.material-card:hover {
  transform: translateY(-10px);
  box-shadow: 0 20px 40px rgba(164, 113, 72, 0.3);
}

.material-image {
  position: relative;
  height: 250px;
  overflow: hidden;
}

.material-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.6s ease;
}

.material-card:hover .material-image img {
  transform: scale(1.1);
}

.material-overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(45deg, rgba(0,0,0,0.7), transparent);
  display: flex;
  align-items: end;
  padding: 1.5rem;
  opacity: 0;
  transition: opacity 0.5s ease;
}

.material-card:hover .material-overlay {
  opacity: 1;
}

.material-info h4 {
  font-size: 1.2rem;
  color: #FAFAF8;
  margin-bottom: 0.5rem;
}

.material-info p {
  color: #a47148;
  margin-bottom: 1rem;
}

.material-properties {
  display: flex;
  gap: 0.25rem;
  flex-wrap: wrap;
}

.property-tag {
  padding: 0.25rem 0.5rem;
  background: rgba(164, 113, 72, 0.3);
  color: #a47148;
  font-size: 0.75rem;
  border-radius: 10px;
  border: 1px solid rgba(164, 113, 72, 0.5);
}

.material-details {
  padding: 1.5rem;
}

.material-name {
  font-size: 1.2rem;
  font-weight: 400;
  margin-bottom: 0.5rem;
  color: #FAFAF8;
}

.material-type {
  font-size: 1rem;
  color: #999;
  margin-bottom: 1rem;
}

.material-rating {
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.stars {
  display: flex;
  gap: 0.125rem;
}

.star {
  color: #333;
  transition: color 0.2s ease;
}

.star.filled {
  color: #a47148;
}

.rating-text {
  font-size: 0.875rem;
  color: #999;
}

/* Services Section */
.services-section {
  padding: 6rem 0;
  background: linear-gradient(135deg, #1a1a1a 0%, #0a0a0a 100%);
}

.services-showcase {
  position: relative;
  height: 500px;
  margin-bottom: 3rem;
  border-radius: 20px;
  overflow: hidden;
}

.service-item {
  position: absolute;
  inset: 0;
}

.service-visual {
  width: 100%;
  height: 100%;
  position: relative;
  cursor: pointer;
  transition: all 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  opacity: 0;
}

.service-visual.active {
  opacity: 1;
}

.service-visual img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.service-overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(45deg, rgba(0,0,0,0.8), rgba(164, 113, 72, 0.4));
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 3rem;
}

.service-content {
  text-align: center;
  max-width: 600px;
}

.service-content h3 {
  font-size: 2.5rem;
  font-weight: 400;
  margin-bottom: 1rem;
  color: #FAFAF8;
}

.service-content p {
  font-size: 1.2rem;
  color: #ccc;
  margin-bottom: 2rem;
  line-height: 1.6;
}

.service-features {
  list-style: none;
  padding: 0;
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 0.5rem;
  text-align: left;
}

.service-features li {
  color: #a47148;
  position: relative;
  padding-left: 1.5rem;
}

.service-features li:before {
  content: '✓';
  position: absolute;
  left: 0;
  font-weight: bold;
}

.service-indicators {
  display: flex;
  justify-content: center;
  gap: 1rem;
  flex-wrap: wrap;
}

.service-indicators .indicator {
  padding: 0.75rem 1.5rem;
  background: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.2);
  color: #FAFAF8;
  border-radius: 25px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.service-indicators .indicator.active {
  background: #a47148;
  border-color: #a47148;
  color: #000;
}

/* Process Section */
.process-section {
  padding: 6rem 0;
}

.process-visualization {
  max-width: 1000px;
  margin: 0 auto;
}

.process-steps {
  display: flex;
  justify-content: space-between;
  margin-bottom: 3rem;
  position: relative;
}

.process-steps::before {
  content: '';
  position: absolute;
  top: 30px;
  left: 5%;
  right: 5%;
  height: 2px;
  background: linear-gradient(90deg, #a47148, #FAFAF8);
  z-index: 0;
}

.process-step {
  text-align: center;
  cursor: pointer;
  transition: all 0.3s ease;
  z-index: 1;
  position: relative;
}

.step-circle {
  width: 60px;
  height: 60px;
  background: rgba(255, 255, 255, 0.1);
  border: 3px solid rgba(255, 255, 255, 0.2);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 1rem;
  color: #999;
  font-weight: 600;
  transition: all 0.4s ease;
}

.process-step.active .step-circle,
.process-step.completed .step-circle {
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  border-color: #a47148;
  color: #000;
  transform: scale(1.1);
}

.step-label {
  font-size: 0.9rem;
  font-weight: 300;
  color: #999;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.process-step.active .step-label {
  color: #a47148;
}

.process-details {
  background: rgba(255, 255, 255, 0.05);
  border-radius: 20px;
  padding: 3rem;
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.1);
  min-height: 400px;
}

.step-content {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 3rem;
  align-items: center;
}

.step-image img {
  width: 100%;
  height: 300px;
  object-fit: cover;
  border-radius: 15px;
}

.step-info h3 {
  font-size: 2rem;
  font-weight: 400;
  margin-bottom: 1rem;
  color: #FAFAF8;
}

.step-info p {
  font-size: 1.1rem;
  line-height: 1.6;
  color: #ccc;
  margin-bottom: 2rem;
}

.step-checklist {
  list-style: none;
  padding: 0;
}

.step-checklist li {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  margin-bottom: 0.75rem;
  color: #ccc;
}

.step-checklist .material-icons {
  color: #a47148;
  font-size: 1.2rem;
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
  max-width: 900px;
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
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 2rem;
}

.modal-image img {
  width: 100%;
  height: 400px;
  object-fit: cover;
  border-top-left-radius: 20px;
  border-bottom-left-radius: 20px;
}

.modal-info {
  padding: 2rem;
}

.modal-title {
  font-size: 2rem;
  font-weight: 400;
  margin-bottom: 0.5rem;
  color: #FAFAF8;
}

.modal-type {
  font-size: 1rem;
  color: #a47148;
  text-transform: uppercase;
  letter-spacing: 0.1em;
  margin-bottom: 2rem;
}

.material-specs {
  margin-bottom: 2rem;
}

.spec-item {
  display: flex;
  justify-content: space-between;
  padding: 0.5rem 0;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.spec-item strong {
  color: #FAFAF8;
}

.spec-item span {
  color: #ccc;
}

.material-properties-detail,
.material-applications {
  margin-bottom: 2rem;
}

.material-properties-detail h4,
.material-applications h4 {
  font-size: 1.2rem;
  color: #FAFAF8;
  margin-bottom: 1rem;
}

.properties-grid {
  display: flex;
  gap: 0.5rem;
  flex-wrap: wrap;
}

.property-badge {
  padding: 0.5rem 1rem;
  background: rgba(164, 113, 72, 0.2);
  color: #a47148;
  border-radius: 20px;
  font-size: 0.875rem;
  border: 1px solid rgba(164, 113, 72, 0.3);
}

.material-applications ul {
  list-style: none;
  padding: 0;
}

.material-applications li {
  padding: 0.5rem 0;
  color: #ccc;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
  position: relative;
  padding-left: 1.5rem;
}

.material-applications li:before {
  content: '→';
  position: absolute;
  left: 0;
  color: #a47148;
  font-weight: bold;
}

.modal-actions {
  display: flex;
  gap: 1rem;
  justify-content: center;
  margin-top: 2rem;
}

/* CTA Section */
.cta-section {
  padding: 6rem 0;
  background: linear-gradient(135deg, #1a1a1a 0%, #0a0a0a 100%);
}

.cta-content {
  text-align: center;
  max-width: 800px;
  margin: 0 auto;
}

.cta-title {
  font-size: 3rem;
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

/* Transitions */
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.5s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}

.slide-enter-active,
.slide-leave-active {
  transition: all 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

.slide-enter-from {
  opacity: 0;
  transform: translateX(50px);
}

.slide-leave-to {
  opacity: 0;
  transform: translateX(-50px);
}

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

@keyframes featureFadeIn {
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* Responsive Design */
@media (max-width: 768px) {
  .hero-title {
    font-size: 2.5rem;
  }
  
  .features-grid,
  .materials-grid {
    grid-template-columns: 1fr;
    gap: 1.5rem;
  }
  
  .materials-tabs {
    gap: 0.5rem;
  }
  
  .tab-button {
    padding: 0.75rem 1.5rem;
    font-size: 0.875rem;
  }
  
  .service-content h3 {
    font-size: 2rem;
  }
  
  .service-features {
    grid-template-columns: 1fr;
  }
  
  .process-steps {
    flex-direction: column;
    align-items: center;
    gap: 2rem;
  }
  
  .process-steps::before {
    display: none;
  }
  
  .step-content {
    grid-template-columns: 1fr;
    text-align: center;
  }
  
  .modal-body {
    grid-template-columns: 1fr;
  }
  
  .modal-image img {
    height: 250px;
    border-radius: 0;
    border-top-left-radius: 20px;
    border-top-right-radius: 20px;
  }
  
  .cta-title {
    font-size: 2.5rem;
  }
  
  .cta-actions {
    flex-direction: column;
    align-items: center;
  }
  
  .modal-actions {
    flex-direction: column;
  }
}
</style>