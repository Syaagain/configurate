<template>
  <div class="terrassen-page">
    <!-- Hero Section -->
    <section class="hero-section">
      <div class="hero-background">
        <div class="hero-overlay"></div>
        <img 
          src="https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b70b0803723582ed6.png" 
          alt="Exklusive Terrassenplatten"
          class="hero-image"
        >
      </div>
      <div class="hero-content">
        <div class="hero-text">
          <h1 class="hero-title">EXKLUSIVE TERRASSENPLATTEN</h1>
          <p class="hero-subtitle">Innovative Lösungen für stilvolle Außenbereiche</p>
          <p class="hero-description">Langlebige Terrassenplatten in höchster Qualität – robust, elegant und individuell nach Ihren Wünschen gestaltet</p>
        </div>
      </div>
    </section>

    <!-- Features Overview -->
    <section class="features-overview">
      <div class="container">
        <div class="features-grid">
          <div 
            v-for="(feature, index) in keyFeatures" 
            :key="feature.id"
            class="feature-card"
            :style="{ animationDelay: `${index * 0.1}s` }"
            @mouseenter="startFeatureAnimation(index)"
          >
            <div class="feature-icon" :class="{ 'animate': animatingFeatures.includes(index) }">
              <span class="material-icons">{{ feature.icon }}</span>
            </div>
            <h3 class="feature-title">{{ feature.title }}</h3>
            <p class="feature-description">{{ feature.description }}</p>
            <div class="feature-stats">
              <div class="stat">
                <span class="stat-number">{{ feature.stat.number }}</span>
                <span class="stat-label">{{ feature.stat.label }}</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Material Explorer -->
    <section class="material-explorer">
      <div class="container">
        <div class="section-header">
          <h2 class="section-title">TERRASSENPLATTEN EXPLORER</h2>
          <p class="section-subtitle">Entdecken Sie unsere Materialvielfalt interaktiv</p>
        </div>

        <div class="explorer-interface">
          <div class="filter-panel">
            <div class="filter-group">
              <h4>Material</h4>
              <div class="filter-buttons">
                <button 
                  v-for="material in materialTypes" 
                  :key="material.id"
                  @click="activeMaterial = material.id"
                  :class="['filter-btn', { active: activeMaterial === material.id }]"
                >
                  <span class="material-icons">{{ material.icon }}</span>
                  {{ material.name }}
                </button>
              </div>
            </div>

            <div class="filter-group">
              <h4>Format</h4>
              <div class="format-selector">
                <input 
                  v-for="format in formats" 
                  :key="format.id"
                  type="radio" 
                  :id="format.id" 
                  v-model="activeFormat" 
                  :value="format.id"
                  class="format-radio"
                >
                <label v-for="format in formats" :key="format.id" :for="format.id" class="format-label">
                  {{ format.size }}
                </label>
              </div>
            </div>

            <div class="filter-group">
              <h4>Oberflächenstruktur</h4>
              <div class="surface-options">
                <div 
                  v-for="surface in surfaceTypes" 
                  :key="surface.id"
                  @click="activeSurface = surface.id"
                  :class="['surface-option', { active: activeSurface === surface.id }]"
                >
                  <div class="surface-preview" :style="{ backgroundImage: surface.texture }"></div>
                  <span>{{ surface.name }}</span>
                </div>
              </div>
            </div>
          </div>

          <div class="material-preview">
            <div class="preview-container">
              <div class="material-sample" :key="`${activeMaterial}-${activeFormat}-${activeSurface}`">
                <img :src="currentMaterialImage" :alt="currentMaterialName" class="sample-image">
                <div class="sample-overlay">
                  <div class="sample-info">
                    <h3>{{ currentMaterialName }}</h3>
                    <p>{{ currentMaterialDescription }}</p>
                    <div class="sample-properties">
                      <div class="property" v-for="prop in currentProperties" :key="prop.label">
                        <strong>{{ prop.label }}:</strong> {{ prop.value }}
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              
              <div class="preview-tools">
                <button @click="zoom3D = !zoom3D" :class="['tool-btn', { active: zoom3D }]">
                  <span class="material-icons">3d_rotation</span>
                  3D Ansicht
                </button>
                <button @click="showInEnvironment = !showInEnvironment" :class="['tool-btn', { active: showInEnvironment }]">
                  <span class="material-icons">landscape</span>
                  In Umgebung
                </button>
                <NuxtLink to="/kontakt" class="tool-btn primary">
                  <span class="material-icons">request_quote</span>
                  Angebot anfordern
                </NuxtLink>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Installation Technologies -->
    <section class="installation-section">
      <div class="container">
        <div class="section-header">
          <h2 class="section-title">VERLEGETECHNOLOGIEN</h2>
          <p class="section-subtitle">Modernste Verfahren für perfekte Ergebnisse</p>
        </div>

        <div class="technologies-showcase">
          <div 
            v-for="(tech, index) in technologies" 
            :key="tech.id"
            class="technology-card"
            :class="{ active: activeTechnology === index }"
            @click="setActiveTechnology(index)"
          >
            <div class="tech-header">
              <div class="tech-icon">
                <span class="material-icons">{{ tech.icon }}</span>
              </div>
              <div class="tech-title">
                <h3>{{ tech.name }}</h3>
                <p class="tech-subtitle">{{ tech.subtitle }}</p>
              </div>
            </div>
            
            <div class="tech-content" v-show="activeTechnology === index">
              <div class="tech-description">
                <p>{{ tech.description }}</p>
              </div>
              
              <div class="tech-benefits">
                <h4>Vorteile:</h4>
                <ul>
                  <li v-for="benefit in tech.benefits" :key="benefit">{{ benefit }}</li>
                </ul>
              </div>
              
              <div class="tech-applications">
                <h4>Anwendung:</h4>
                <div class="application-tags">
                  <span v-for="app in tech.applications" :key="app" class="app-tag">{{ app }}</span>
                </div>
              </div>

              <div class="tech-process">
                <h4>Verlegeprozess:</h4>
                <div class="process-steps">
                  <div 
                    v-for="(step, stepIndex) in tech.process" 
                    :key="stepIndex"
                    class="process-step"
                  >
                    <div class="step-number">{{ stepIndex + 1 }}</div>
                    <div class="step-content">
                      <h5>{{ step.title }}</h5>
                      <p>{{ step.description }}</p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Project Calculator -->
    <section class="calculator-section">
      <div class="container">
        <div class="section-header">
          <h2 class="section-title">PROJEKT-KALKULATOR</h2>
          <p class="section-subtitle">Berechnen Sie Ihren Materialbedarf und die Kosten</p>
        </div>

        <div class="calculator-interface">
          <div class="calculator-inputs">
            <div class="input-group">
              <label>Terrassengröße</label>
              <div class="size-inputs">
                <div class="input-field">
                  <input 
                    type="number" 
                    v-model="terraceLength" 
                    placeholder="Länge"
                    @input="calculateProject"
                  >
                  <span class="unit">m</span>
                </div>
                <div class="multiply">×</div>
                <div class="input-field">
                  <input 
                    type="number" 
                    v-model="terraceWidth" 
                    placeholder="Breite"
                    @input="calculateProject"
                  >
                  <span class="unit">m</span>
                </div>
              </div>
              <div class="area-display">
                Gesamtfläche: <strong>{{ totalArea }} m²</strong>
              </div>
            </div>

            <div class="input-group">
              <label>Plattengröße</label>
              <select v-model="selectedPlateSize" @change="calculateProject" class="plate-selector">
                <option v-for="plate in plateSizes" :key="plate.id" :value="plate">
                  {{ plate.size }} ({{ plate.area }}m² pro Platte)
                </option>
              </select>
            </div>

            <div class="input-group">
              <label>Material</label>
              <select v-model="selectedMaterial" @change="calculateProject" class="material-selector">
                <option v-for="material in calculatorMaterials" :key="material.id" :value="material">
                  {{ material.name }} - {{ material.price }}€/m²
                </option>
              </select>
            </div>

            <div class="input-group">
              <label>Zusatzleistungen</label>
              <div class="extras-grid">
                <label v-for="extra in extras" :key="extra.id" class="extra-option">
                  <input type="checkbox" v-model="selectedExtras" :value="extra" @change="calculateProject">
                  <span class="checkmark"></span>
                  <div class="extra-info">
                    <span class="extra-name">{{ extra.name }}</span>
                    <span class="extra-price">+{{ extra.price }}€/m²</span>
                  </div>
                </label>
              </div>
            </div>
          </div>

          <div class="calculator-results">
            <div class="results-card">
              <h3>Materialberechnung</h3>
              <div class="result-item">
                <span>Benötigte Platten:</span>
                <strong>{{ requiredPlates }} Stück</strong>
              </div>
              <div class="result-item">
                <span>Material ({{ selectedMaterial?.name }}):</span>
                <strong>{{ materialCost }}€</strong>
              </div>
              <div class="result-item" v-if="extrasCost > 0">
                <span>Zusatzleistungen:</span>
                <strong>{{ extrasCost }}€</strong>
              </div>
              <div class="result-separator"></div>
              <div class="result-total">
                <span>Gesamtkosten:</span>
                <strong>{{ totalCost }}€</strong>
              </div>
              <div class="result-note">
                *Preise verstehen sich zzgl. MwSt. und ohne Montage
              </div>
              
              <div class="results-actions">
                <button @click="exportCalculation" class="action-btn secondary">
                  <span class="material-icons">download</span>
                  Berechnung exportieren
                </button>
                <NuxtLink to="/kontakt" class="action-btn primary">
                  <span class="material-icons">send</span>
                  Angebot anfordern
                </NuxtLink>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Environmental Benefits -->
    <section class="environment-section">
      <div class="container">
        <div class="section-header">
          <h2 class="section-title">NACHHALTIGKEIT & UMWELT</h2>
          <p class="section-subtitle">Verantwortungsvoll produziert, langlebig designt</p>
        </div>

        <div class="environment-content">
          <div class="sustainability-stats">
            <div 
              v-for="(stat, index) in sustainabilityStats" 
              :key="stat.id"
              class="stat-card"
              :style="{ animationDelay: `${index * 0.2}s` }"
            >
              <div class="stat-icon">
                <span class="material-icons">{{ stat.icon }}</span>
              </div>
              <div class="stat-content">
                <div class="stat-number">{{ stat.number }}</div>
                <div class="stat-label">{{ stat.label }}</div>
                <div class="stat-description">{{ stat.description }}</div>
              </div>
            </div>
          </div>

          <div class="sustainability-features">
            <div class="feature-grid">
              <div 
                v-for="feature in sustainabilityFeatures" 
                :key="feature.id"
                class="sustainability-feature"
              >
                <div class="feature-visual">
                  <div class="feature-bg" :style="{ backgroundImage: `url(${feature.image})` }"></div>
                  <div class="feature-overlay">
                    <span class="material-icons">{{ feature.icon }}</span>
                  </div>
                </div>
                <div class="feature-info">
                  <h4>{{ feature.title }}</h4>
                  <p>{{ feature.description }}</p>
                  <div class="feature-benefits">
                    <span v-for="benefit in feature.benefits" :key="benefit" class="benefit-tag">
                      {{ benefit }}
                    </span>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- CTA Section -->
    <section class="cta-section">
      <div class="cta-background">
        <div class="cta-overlay"></div>
        <div class="floating-particles">
          <div v-for="i in 20" :key="i" class="particle" :style="getParticleStyle(i)"></div>
        </div>
      </div>
      <div class="container">
        <div class="cta-content">
          <h2 class="cta-title">GESTALTEN SIE IHRE TRAUMTERRASSE</h2>
          <p class="cta-text">
            Lassen Sie sich von unserem Expertenteam beraten und entdecken Sie die perfekte Lösung für Ihren Außenbereich.
            Kostenlose Beratung, individuelle Planung und professionelle Umsetzung – alles aus einer Hand.
          </p>
          <div class="cta-actions">
            <NuxtLink to="/kontakt" class="cta-button primary">
              <span class="material-icons">calendar_month</span>
              BERATUNGSTERMIN VEREINBAREN
            </NuxtLink>
            <button @click="openVirtualShowroom" class="cta-button secondary">
              <span class="material-icons">view_in_ar</span>
              VIRTUELLER SHOWROOM
            </button>
          </div>
          <div class="cta-contact-info">
            <div class="contact-item">
              <span class="material-icons">phone</span>
              <a href="tel:+4981713868770">+49 8171 / 3868770</a>
            </div>
            <div class="contact-item">
              <span class="material-icons">email</span>
              <a href="mailto:info@architektur-group.de">info@architektur-group.de</a>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
const animatingFeatures = ref([])
const activeMaterial = ref('keramik')
const activeFormat = ref('large')
const activeSurface = ref('structured')
const activeTechnology = ref(0)
const zoom3D = ref(false)
const showInEnvironment = ref(false)

// Calculator state
const terraceLength = ref(6)
const terraceWidth = ref(4)
const selectedPlateSize = ref({ id: 'large', size: '60x60cm', area: 0.36 })
const selectedMaterial = ref({ id: 'keramik', name: 'Premium Keramik', price: 85 })
const selectedExtras = ref([])

// Calculated values
const totalArea = ref(24)
const requiredPlates = ref(67)
const materialCost = ref(2040)
const extrasCost = ref(0)
const totalCost = ref(2040)

const keyFeatures = [
  {
    id: 1,
    icon: 'shield',
    title: 'Extrem robust',
    description: 'Widerstandsfähig gegen Frost, UV-Strahlung und mechanische Belastung',
    stat: { number: '50+', label: 'Jahre Haltbarkeit' }
  },
  {
    id: 2,
    icon: 'water_drop',
    title: 'Wasserabweisend',
    description: 'Minimale Wasseraufnahme verhindert Frost- und Algenbildung',
    stat: { number: '<0.5%', label: 'Wasseraufnahme' }
  },
  {
    id: 3,
    icon: 'cleaning_services',
    title: 'Pflegeleicht',
    description: 'Einfache Reinigung ohne spezielle Pflegemittel erforderlich',
    stat: { number: '5min', label: 'Reinigungsaufwand/Woche' }
  },
  {
    id: 4,
    icon: 'palette',
    title: 'Designvielfalt',
    description: 'Große Auswahl an Farben, Formaten und Oberflächenstrukturen',
    stat: { number: '200+', label: 'Designvarianten' }
  }
]

const materialTypes = [
  { id: 'keramik', name: 'Feinsteinzeug', icon: 'diamond' },
  { id: 'naturstein', name: 'Naturstein', icon: 'landscape' },
  { id: 'beton', name: 'Betonoptik', icon: 'foundation' },
  { id: 'holzoptik', name: 'Holzoptik', icon: 'park' }
]

const formats = [
  { id: 'small', size: '30x30cm' },
  { id: 'medium', size: '45x45cm' },
  { id: 'large', size: '60x60cm' },
  { id: 'rectangle', size: '30x60cm' },
  { id: 'xl', size: '80x80cm' }
]

const surfaceTypes = [
  { id: 'structured', name: 'Strukturiert', texture: 'linear-gradient(45deg, #666, #999)' },
  { id: 'smooth', name: 'Glatt', texture: 'linear-gradient(45deg, #888, #aaa)' },
  { id: 'antique', name: 'Antik', texture: 'linear-gradient(45deg, #777, #999)' },
  { id: 'brushed', name: 'Gebürstet', texture: 'linear-gradient(45deg, #555, #888)' }
]

const technologies = [
  {
    id: 1,
    name: 'Stelzlager-System',
    subtitle: 'Höhenverstellbar & drainage-optimiert',
    icon: 'architecture',
    description: 'Innovative Verlegung auf höhenverstellbaren Stelzlagern ermöglicht perfekte Entwässerung und einfachen Zugang zu Leitungen.',
    benefits: [
      'Perfekte Höhenausgleichung',
      'Optimaler Wasserabfluss',
      'Revisionsfreundlich',
      'Geringerer Aufbau'
    ],
    applications: ['Dachterrassen', 'Balkone', 'Aufgeständerte Terrassen'],
    process: [
      { title: 'Untergrund vorbereiten', description: 'Tragfähigen und ebenen Untergrund schaffen' },
      { title: 'Stelzlager positionieren', description: 'Höhenverstellbare Stelzlager nach Plan setzen' },
      { title: 'Platten verlegen', description: 'Terrassenplatten auf Stelzlager aufbringen' },
      { title: 'Ausrichten & justieren', description: 'Finale Höhenanpassung und Ausrichtung' }
    ]
  },
  {
    id: 2,
    name: 'Splittbett-Verlegung',
    subtitle: 'Traditionell bewährt & kosteneffizient',
    icon: 'foundation',
    description: 'Klassische Verlegung im Splittbett bietet dauerhafte Stabilität und natürliche Entwässerung bei optimalem Preis-Leistungs-Verhältnis.',
    benefits: [
      'Bewährte Technologie',
      'Kostengünstig',
      'Langlebig stabil',
      'Natürliche Drainage'
    ],
    applications: ['Gartenterrassen', 'Wege', 'Großflächige Bereiche'],
    process: [
      { title: 'Aushub & Planierung', description: 'Baugrund ausheben und planieren' },
      { title: 'Tragschicht einbauen', description: 'Schotterschicht verdichtet einbauen' },
      { title: 'Splittbett erstellen', description: 'Ausgleichsschicht aus Splitt aufbringen' },
      { title: 'Platten verlegen', description: 'Platten einschlämmen und ausrichten' }
    ]
  },
  {
    id: 3,
    name: 'Mörtelbett-System',
    subtitle: 'Maximale Stabilität für hohe Belastungen',
    icon: 'build',
    description: 'Vollflächige Verlegung im Mörtelbett für höchste Belastbarkeit und dauerhafte Verbindung mit dem Untergrund.',
    benefits: [
      'Maximale Belastbarkeit',
      'Vollflächige Auflage',
      'Keine Setzungen',
      'Professionelle Lösung'
    ],
    applications: ['Einfahrten', 'Hochfrequentierte Bereiche', 'Gewerbliche Nutzung'],
    process: [
      { title: 'Betonuntergrund', description: 'Tragfähigen Betonuntergrund erstellen' },
      { title: 'Haftschlämme auftragen', description: 'Verbindungsschicht für optimale Haftung' },
      { title: 'Mörtelbett einbringen', description: 'Frischen Verlegemörtel aufbringen' },
      { title: 'Platten einlegen', description: 'Platten vollflächig ins Mörtelbett einlegen' }
    ]
  }
]

const plateSizes = [
  { id: 'small', size: '30x30cm', area: 0.09 },
  { id: 'medium', size: '45x45cm', area: 0.20 },
  { id: 'large', size: '60x60cm', area: 0.36 },
  { id: 'xl', size: '80x80cm', area: 0.64 }
]

const calculatorMaterials = [
  { id: 'keramik_basic', name: 'Keramik Standard', price: 65 },
  { id: 'keramik_premium', name: 'Keramik Premium', price: 85 },
  { id: 'naturstein', name: 'Naturstein', price: 120 },
  { id: 'beton', name: 'Betonoptik', price: 75 }
]

const extras = [
  { id: 'edge', name: 'Kantenabschluss', price: 15 },
  { id: 'impregnation', name: 'Imprägnierung', price: 8 },
  { id: 'joint_sand', name: 'Fugensand', price: 5 },
  { id: 'drainage', name: 'Drainage-System', price: 25 }
]

const sustainabilityStats = [
  {
    id: 1,
    icon: 'eco',
    number: '100%',
    label: 'Recyclebar',
    description: 'Vollständig wiederverwertbare Materialien'
  },
  {
    id: 2,
    icon: 'local_shipping',
    number: '<500km',
    label: 'Transportweg',
    description: 'Kurze Lieferwege reduzieren CO₂-Emissionen'
  },
  {
    id: 3,
    icon: 'battery_full',
    number: '50+',
    label: 'Jahre Lebensdauer',
    description: 'Langlebigkeit reduziert Ressourcenverbrauch'
  },
  {
    id: 4,
    icon: 'water_drop',
    number: '80%',
    label: 'Wassereinsparung',
    description: 'Bei der Produktion vs. herkömmliche Verfahren'
  }
]

const sustainabilityFeatures = [
  {
    id: 1,
    title: 'Lokale Produktion',
    description: 'Herstellung in europäischen Werken mit kurzen Transportwegen und strengen Umweltauflagen.',
    icon: 'factory',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b70b0803723582ed6.png',
    benefits: ['CO₂-Reduktion', 'Regionale Wertschöpfung', 'Qualitätskontrolle']
  },
  {
    id: 2,
    title: 'Recycling-Materialien',
    description: 'Verwendung von bis zu 40% recycelten Rohstoffen ohne Qualitätsverlust.',
    icon: 'recycling',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png',
    benefits: ['Ressourcenschonung', 'Abfallreduktion', 'Circular Economy']
  },
  {
    id: 3,
    title: 'Energieeffiziente Produktion',
    description: 'Modernste Brenntechnologien reduzieren den Energieverbrauch um bis zu 30%.',
    icon: 'bolt',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686576cf622e38e88f0236c5.png',
    benefits: ['Energieeinsparung', 'Emissionsreduktion', 'Kostensenkung']
  }
]

const currentMaterialImage = computed(() => {
  const images = {
    'keramik': 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png',
    'naturstein': 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png',
    'beton': 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b70b0803723582ed6.png',
    'holzoptik': 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b097a8069ca3ac95a.png'
  }
  return images[activeMaterial.value]
})

const currentMaterialName = computed(() => {
  const names = {
    'keramik': 'Premium Feinsteinzeug',
    'naturstein': 'Naturstein Klassik',
    'beton': 'Moderne Betonoptik',
    'holzoptik': 'Edle Holzoptik'
  }
  return names[activeMaterial.value]
})

const currentMaterialDescription = computed(() => {
  const descriptions = {
    'keramik': 'Hochwertige Keramikplatten mit durchgefärbtem Körper und rutschfester Oberfläche.',
    'naturstein': 'Authentische Natursteinplatten mit einzigartiger Maserung und natürlicher Haptik.',
    'beton': 'Moderne Betonoptik mit industriellem Charakter und zeitgemäßem Design.',
    'holzoptik': 'Täuschend echte Holzoptik ohne die Nachteile von echtem Holz.'
  }
  return descriptions[activeMaterial.value]
})

const currentProperties = computed(() => {
  const properties = {
    'keramik': [
      { label: 'Rutschfestigkeit', value: 'R11' },
      { label: 'Frostbeständigkeit', value: 'Ja' },
      { label: 'Wasseraufnahme', value: '<0.5%' }
    ],
    'naturstein': [
      { label: 'Härte', value: 'Sehr hoch' },
      { label: 'Einzigartige Optik', value: 'Ja' },
      { label: 'Pflegeaufwand', value: 'Gering' }
    ],
    'beton': [
      { label: 'Belastbarkeit', value: 'Extrem hoch' },
      { label: 'Design', value: 'Modern' },
      { label: 'Wartung', value: 'Minimal' }
    ],
    'holzoptik': [
      { label: 'Optik', value: 'Wie Echtholz' },
      { label: 'Haltbarkeit', value: '>30 Jahre' },
      { label: 'Verrottung', value: 'Unmöglich' }
    ]
  }
  return properties[activeMaterial.value] || []
})

const startFeatureAnimation = (index) => {
  if (!animatingFeatures.value.includes(index)) {
    animatingFeatures.value.push(index)
    setTimeout(() => {
      animatingFeatures.value = animatingFeatures.value.filter(i => i !== index)
    }, 1000)
  }
}

const setActiveTechnology = (index) => {
  activeTechnology.value = activeTechnology.value === index ? -1 : index
}

const calculateProject = () => {
  totalArea.value = Math.round((terraceLength.value * terraceWidth.value) * 100) / 100
  requiredPlates.value = Math.ceil(totalArea.value / selectedPlateSize.value.area)
  
  const baseMaterialCost = totalArea.value * selectedMaterial.value.price
  const extrasTotal = selectedExtras.value.reduce((sum, extra) => sum + (extra.price * totalArea.value), 0)
  
  materialCost.value = Math.round(baseMaterialCost)
  extrasCost.value = Math.round(extrasTotal)
  totalCost.value = materialCost.value + extrasCost.value
}

const exportCalculation = () => {
  const calculation = {
    dimensions: `${terraceLength.value}m x ${terraceWidth.value}m`,
    area: `${totalArea.value}m²`,
    material: selectedMaterial.value.name,
    plateSize: selectedPlateSize.value.size,
    requiredPlates: requiredPlates.value,
    costs: {
      material: materialCost.value,
      extras: extrasCost.value,
      total: totalCost.value
    },
    extras: selectedExtras.value.map(e => e.name)
  }
  
  console.log('Calculation exported:', calculation)
  // Hier könnte eine echte Export-Funktion implementiert werden
}

const openVirtualShowroom = () => {
  console.log('Opening virtual showroom...')
  // Hier könnte eine AR/VR-Funktion implementiert werden
}

const getParticleStyle = (index) => {
  return {
    left: `${Math.random() * 100}%`,
    top: `${Math.random() * 100}%`,
    animationDelay: `${Math.random() * 10}s`,
    animationDuration: `${10 + Math.random() * 20}s`
  }
}

onMounted(() => {
  calculateProject()
})
</script>

<style scoped>
.terrassen-page {
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
  max-width: 900px;
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

/* Features Overview */
.features-overview {
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
  transition: transform 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

.feature-icon.animate {
  transform: rotateY(360deg) scale(1.1);
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
  margin-bottom: 2rem;
}

.feature-stats {
  padding-top: 1rem;
  border-top: 1px solid rgba(255, 255, 255, 0.1);
}

.stat {
  text-align: center;
}

.stat-number {
  font-size: 2rem;
  font-weight: 600;
  color: #a47148;
  display: block;
  margin-bottom: 0.5rem;
}

.stat-label {
  font-size: 0.9rem;
  color: #999;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

/* Material Explorer */
.material-explorer {
  padding: 6rem 0;
}

.explorer-interface {
  display: grid;
  grid-template-columns: 400px 1fr;
  gap: 4rem;
  max-width: 1200px;
  margin: 0 auto;
}

.filter-panel {
  background: rgba(255, 255, 255, 0.05);
  border-radius: 20px;
  padding: 2rem;
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.1);
  height: fit-content;
}

.filter-group {
  margin-bottom: 2rem;
}

.filter-group h4 {
  font-size: 1.2rem;
  font-weight: 400;
  margin-bottom: 1rem;
  color: #FAFAF8;
}

.filter-buttons {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.filter-btn {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  padding: 0.75rem 1rem;
  background: rgba(255, 255, 255, 0.05);
  border: 2px solid rgba(255, 255, 255, 0.1);
  color: #FAFAF8;
  border-radius: 10px;
  cursor: pointer;
  transition: all 0.3s ease;
  font-size: 0.9rem;
}

.filter-btn:hover {
  background: rgba(255, 255, 255, 0.08);
  border-color: rgba(164, 113, 72, 0.5);
}

.filter-btn.active {
  background: rgba(164, 113, 72, 0.2);
  border-color: #a47148;
  color: #a47148;
}

.format-selector {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 0.5rem;
}

.format-radio {
  display: none;
}

.format-label {
  padding: 0.75rem;
  background: rgba(255, 255, 255, 0.05);
  border: 2px solid rgba(255, 255, 255, 0.1);
  border-radius: 8px;
  text-align: center;
  cursor: pointer;
  transition: all 0.3s ease;
  font-size: 0.9rem;
}

.format-radio:checked + .format-label,
.format-label:hover {
  background: rgba(164, 113, 72, 0.2);
  border-color: #a47148;
  color: #a47148;
}

.surface-options {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 0.75rem;
}

.surface-option {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 1rem;
  background: rgba(255, 255, 255, 0.05);
  border: 2px solid rgba(255, 255, 255, 0.1);
  border-radius: 10px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.surface-option:hover {
  background: rgba(255, 255, 255, 0.08);
}

.surface-option.active {
  background: rgba(164, 113, 72, 0.2);
  border-color: #a47148;
  color: #a47148;
}

.surface-preview {
  width: 40px;
  height: 40px;
  border-radius: 8px;
  margin-bottom: 0.5rem;
  border: 1px solid rgba(255, 255, 255, 0.2);
}

.surface-option span {
  font-size: 0.8rem;
  text-align: center;
}

.material-preview {
  background: rgba(255, 255, 255, 0.05);
  border-radius: 20px;
  padding: 2rem;
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.preview-container {
  height: 600px;
  display: flex;
  flex-direction: column;
}

.material-sample {
  flex: 1;
  position: relative;
  border-radius: 15px;
  overflow: hidden;
  margin-bottom: 2rem;
}

.sample-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.6s ease;
}

.sample-overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(45deg, rgba(0,0,0,0.7), transparent);
  display: flex;
  align-items: end;
  padding: 2rem;
  opacity: 0;
  transition: opacity 0.5s ease;
}

.material-sample:hover .sample-overlay {
  opacity: 1;
}

.material-sample:hover .sample-image {
  transform: scale(1.05);
}

.sample-info h3 {
  font-size: 1.5rem;
  font-weight: 400;
  margin-bottom: 0.5rem;
  color: #FAFAF8;
}

.sample-info p {
  color: #ccc;
  margin-bottom: 1rem;
}

.sample-properties {
  display: flex;
  flex-direction: column;
  gap: 0.25rem;
}

.property {
  font-size: 0.9rem;
  color: #ccc;
}

.property strong {
  color: #a47148;
}

.preview-tools {
  display: flex;
  gap: 1rem;
  flex-wrap: wrap;
}

.tool-btn {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.75rem 1.5rem;
  background: rgba(255, 255, 255, 0.05);
  border: 2px solid rgba(255, 255, 255, 0.2);
  color: #FAFAF8;
  border-radius: 25px;
  cursor: pointer;
  transition: all 0.3s ease;
  text-decoration: none;
  font-size: 0.9rem;
}

.tool-btn:hover,
.tool-btn.active {
  background: rgba(164, 113, 72, 0.2);
  border-color: #a47148;
  color: #a47148;
}

.tool-btn.primary {
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  color: #000;
  border-color: transparent;
}

.tool-btn.primary:hover {
  transform: translateY(-2px);
  box-shadow: 0 10px 20px rgba(164, 113, 72, 0.4);
}

/* Installation Technologies */
.installation-section {
  padding: 6rem 0;
  background: linear-gradient(135deg, #1a1a1a 0%, #0a0a0a 100%);
}

.technologies-showcase {
  max-width: 1000px;
  margin: 0 auto;
}

.technology-card {
  background: rgba(255, 255, 255, 0.05);
  border-radius: 20px;
  margin-bottom: 2rem;
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.1);
  transition: all 0.4s ease;
  overflow: hidden;
}

.technology-card:hover {
  background: rgba(255, 255, 255, 0.08);
}

.technology-card.active {
  border-color: #a47148;
  background: rgba(164, 113, 72, 0.05);
}

.tech-header {
  display: flex;
  align-items: center;
  gap: 2rem;
  padding: 2rem;
  cursor: pointer;
}

.tech-icon {
  width: 60px;
  height: 60px;
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #000;
  font-size: 1.5rem;
  flex-shrink: 0;
}

.tech-title h3 {
  font-size: 1.5rem;
  font-weight: 400;
  margin-bottom: 0.5rem;
  color: #FAFAF8;
}

.tech-subtitle {
  color: #a47148;
  font-size: 1rem;
}

.tech-content {
  padding: 0 2rem 2rem;
  animation: slideDown 0.4s ease-out;
}

.tech-description {
  margin-bottom: 2rem;
}

.tech-description p {
  font-size: 1.1rem;
  line-height: 1.6;
  color: #ccc;
}

.tech-benefits,
.tech-applications,
.tech-process {
  margin-bottom: 2rem;
}

.tech-benefits h4,
.tech-applications h4,
.tech-process h4 {
  font-size: 1.2rem;
  color: #FAFAF8;
  margin-bottom: 1rem;
}

.tech-benefits ul {
  list-style: none;
  padding: 0;
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 0.5rem;
}

.tech-benefits li {
  color: #ccc;
  position: relative;
  padding-left: 1.5rem;
}

.tech-benefits li:before {
  content: '✓';
  position: absolute;
  left: 0;
  color: #a47148;
  font-weight: bold;
}

.application-tags {
  display: flex;
  gap: 0.5rem;
  flex-wrap: wrap;
}

.app-tag {
  padding: 0.5rem 1rem;
  background: rgba(164, 113, 72, 0.2);
  color: #a47148;
  border-radius: 15px;
  font-size: 0.875rem;
  border: 1px solid rgba(164, 113, 72, 0.3);
}

.process-steps {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 1.5rem;
}

.process-step {
  display: flex;
  gap: 1rem;
  align-items: flex-start;
}

.step-number {
  width: 30px;
  height: 30px;
  background: #a47148;
  color: #000;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 600;
  font-size: 0.9rem;
  flex-shrink: 0;
}

.step-content h5 {
  font-size: 1rem;
  font-weight: 400;
  margin-bottom: 0.5rem;
  color: #FAFAF8;
}

.step-content p {
  font-size: 0.9rem;
  color: #ccc;
  line-height: 1.4;
}

/* Calculator Section */
.calculator-section {
  padding: 6rem 0;
}

.calculator-interface {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 4rem;
  max-width: 1200px;
  margin: 0 auto;
}

.calculator-inputs {
  background: rgba(255, 255, 255, 0.05);
  border-radius: 20px;
  padding: 2rem;
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.input-group {
  margin-bottom: 2rem;
}

.input-group label {
  display: block;
  font-size: 1.2rem;
  font-weight: 400;
  margin-bottom: 1rem;
  color: #FAFAF8;
}

.size-inputs {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.input-field {
  position: relative;
  flex: 1;
}

.input-field input {
  width: 100%;
  padding: 0.75rem 3rem 0.75rem 1rem;
  background: rgba(255, 255, 255, 0.1);
  border: 2px solid rgba(255, 255, 255, 0.2);
  border-radius: 10px;
  color: #FAFAF8;
  font-size: 1rem;
}

.input-field input:focus {
  outline: none;
  border-color: #a47148;
}

.unit {
  position: absolute;
  right: 1rem;
  top: 50%;
  transform: translateY(-50%);
  color: #999;
  pointer-events: none;
}

.multiply {
  color: #a47148;
  font-size: 1.5rem;
  font-weight: 600;
}

.area-display {
  margin-top: 1rem;
  padding: 1rem;
  background: rgba(164, 113, 72, 0.1);
  border-radius: 10px;
  color: #ccc;
  text-align: center;
}

.area-display strong {
  color: #a47148;
}

.plate-selector,
.material-selector {
  width: 100%;
  padding: 0.75rem 1rem;
  background: rgba(255, 255, 255, 0.1);
  border: 2px solid rgba(255, 255, 255, 0.2);
  border-radius: 10px;
  color: #FAFAF8;
  font-size: 1rem;
}

.plate-selector:focus,
.material-selector:focus {
  outline: none;
  border-color: #a47148;
}

.extras-grid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 0.75rem;
}

.extra-option {
  display: flex;
  align-items: center;
  gap: 1rem;
  padding: 1rem;
  background: rgba(255, 255, 255, 0.05);
  border-radius: 10px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.extra-option:hover {
  background: rgba(255, 255, 255, 0.08);
}

.extra-option input[type="checkbox"] {
  display: none;
}

.checkmark {
  width: 20px;
  height: 20px;
  border: 2px solid rgba(255, 255, 255, 0.3);
  border-radius: 4px;
  position: relative;
  transition: all 0.3s ease;
}

.extra-option input[type="checkbox"]:checked + .checkmark {
  background: #a47148;
  border-color: #a47148;
}

.extra-option input[type="checkbox"]:checked + .checkmark:after {
  content: '✓';
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
  color: #000;
  font-weight: bold;
  font-size: 0.8rem;
}

.extra-info {
  flex: 1;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.extra-name {
  color: #FAFAF8;
}

.extra-price {
  color: #a47148;
  font-weight: 500;
}

.calculator-results {
  background: rgba(255, 255, 255, 0.05);
  border-radius: 20px;
  padding: 2rem;
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.1);
  height: fit-content;
}

.results-card h3 {
  font-size: 1.5rem;
  font-weight: 400;
  margin-bottom: 2rem;
  color: #FAFAF8;
  text-align: center;
}

.result-item {
  display: flex;
  justify-content: space-between;
  padding: 0.75rem 0;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
  color: #ccc;
}

.result-item strong {
  color: #FAFAF8;
}

.result-separator {
  height: 2px;
  background: linear-gradient(90deg, transparent, #a47148, transparent);
  margin: 1rem 0;
}

.result-total {
  display: flex;
  justify-content: space-between;
  padding: 1rem 0;
  font-size: 1.2rem;
  color: #FAFAF8;
  font-weight: 500;
}

.result-total strong {
  color: #a47148;
  font-size: 1.5rem;
}

.result-note {
  font-size: 0.8rem;
  color: #999;
  text-align: center;
  margin: 1rem 0 2rem;
}

.results-actions {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.action-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  padding: 0.75rem 1.5rem;
  border-radius: 25px;
  cursor: pointer;
  transition: all 0.3s ease;
  text-decoration: none;
  font-size: 0.9rem;
}

.action-btn.primary {
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  color: #000;
  border: none;
}

.action-btn.secondary {
  background: transparent;
  color: #FAFAF8;
  border: 2px solid #FAFAF8;
}

.action-btn:hover {
  transform: translateY(-2px);
}

.action-btn.primary:hover {
  box-shadow: 0 10px 20px rgba(164, 113, 72, 0.4);
}

.action-btn.secondary:hover {
  background: #FAFAF8;
  color: #000;
}

/* Environment Section */
.environment-section {
  padding: 6rem 0;
  background: linear-gradient(135deg, #0a0a0a 0%, #1a1a1a 100%);
}

.environment-content {
  max-width: 1200px;
  margin: 0 auto;
}

.sustainability-stats {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 2rem;
  margin-bottom: 4rem;
}

.stat-card {
  background: rgba(255, 255, 255, 0.05);
  border-radius: 20px;
  padding: 2rem;
  text-align: center;
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.1);
  transition: all 0.6s ease;
  animation: statFadeIn 0.8s ease-out forwards;
  opacity: 0;
  transform: translateY(30px);
}

.stat-card:hover {
  transform: translateY(-5px);
  background: rgba(255, 255, 255, 0.08);
}

.stat-icon {
  width: 60px;
  height: 60px;
  margin: 0 auto 1rem;
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #000;
  font-size: 1.5rem;
}

.stat-content {
  color: #FAFAF8;
}

.stat-number {
  font-size: 2rem;
  font-weight: 600;
  color: #a47148;
  margin-bottom: 0.5rem;
}

.stat-label {
  font-size: 1.1rem;
  margin-bottom: 1rem;
}

.stat-description {
  font-size: 0.9rem;
  color: #ccc;
  line-height: 1.4;
}

.feature-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
  gap: 2rem;
}

.sustainability-feature {
  background: rgba(255, 255, 255, 0.05);
  border-radius: 20px;
  overflow: hidden;
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.1);
  transition: all 0.4s ease;
}

.sustainability-feature:hover {
  transform: translateY(-5px);
  box-shadow: 0 15px 30px rgba(164, 113, 72, 0.2);
}

.feature-visual {
  position: relative;
  height: 200px;
}

.feature-bg {
  width: 100%;
  height: 100%;
  background-size: cover;
  background-position: center;
}

.feature-overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(45deg, rgba(0,0,0,0.6), rgba(164, 113, 72, 0.3));
  display: flex;
  align-items: center;
  justify-content: center;
}

.feature-overlay .material-icons {
  font-size: 3rem;
  color: #FAFAF8;
}

.feature-info {
  padding: 2rem;
}

.feature-info h4 {
  font-size: 1.3rem;
  font-weight: 400;
  margin-bottom: 1rem;
  color: #FAFAF8;
}

.feature-info p {
  font-size: 1rem;
  line-height: 1.6;
  color: #ccc;
  margin-bottom: 1.5rem;
}

.feature-benefits {
  display: flex;
  gap: 0.5rem;
  flex-wrap: wrap;
}

.benefit-tag {
  padding: 0.4rem 0.8rem;
  background: rgba(164, 113, 72, 0.2);
  color: #a47148;
  font-size: 0.8rem;
  border-radius: 12px;
  border: 1px solid rgba(164, 113, 72, 0.3);
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
  background: linear-gradient(135deg, #1a1a1a 0%, #0a0a0a 100%);
}

.cta-overlay {
  position: absolute;
  inset: 0;
  background: radial-gradient(circle at center, rgba(164, 113, 72, 0.1) 0%, transparent 70%);
}

.floating-particles {
  position: absolute;
  inset: 0;
  overflow: hidden;
}

.particle {
  position: absolute;
  width: 4px;
  height: 4px;
  background: #a47148;
  border-radius: 50%;
  animation: float infinite ease-in-out;
}

@keyframes float {
  0%, 100% { transform: translateY(0px) scale(0.8); opacity: 0.3; }
  50% { transform: translateY(-20px) scale(1); opacity: 0.8; }
}

.cta-content {
  position: relative;
  z-index: 2;
  text-align: center;
  max-width: 900px;
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
  margin-bottom: 3rem;
}

.cta-button {
  display: inline-flex;
  align-items: center;
  gap: 0.75rem;
  padding: 1.25rem 2.5rem;
  font-size: 1rem;
  font-weight: 500;
  text-transform: uppercase;
  letter-spacing: 0.05em;
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

.cta-button:hover {
  transform: translateY(-3px);
}

.cta-button.primary:hover {
  box-shadow: 0 15px 40px rgba(164, 113, 72, 0.4);
}

.cta-button.secondary:hover {
  background: #FAFAF8;
  color: #000;
}

.cta-contact-info {
  display: flex;
  justify-content: center;
  gap: 3rem;
  flex-wrap: wrap;
}

.contact-item {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  color: #ccc;
  font-size: 1rem;
}

.contact-item a {
  color: #FAFAF8;
  text-decoration: none;
  transition: color 0.3s ease;
}

.contact-item a:hover {
  color: #a47148;
}

.contact-item .material-icons {
  color: #a47148;
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

@keyframes statFadeIn {
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

@keyframes slideDown {
  from {
    opacity: 0;
    transform: translateY(-20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* Responsive Design */
@media (max-width: 1024px) {
  .explorer-interface,
  .calculator-interface {
    grid-template-columns: 1fr;
    gap: 3rem;
  }
  
  .explorer-interface .filter-panel {
    order: 2;
  }
}

@media (max-width: 768px) {
  .hero-title {
    font-size: 2.5rem;
  }
  
  .features-grid {
    grid-template-columns: 1fr;
  }
  
  .size-inputs {
    flex-direction: column;
    align-items: stretch;
  }
  
  .multiply {
    text-align: center;
    margin: 0.5rem 0;
  }
  
  .format-selector,
  .surface-options {
    grid-template-columns: 1fr;
  }
  
  .process-steps {
    grid-template-columns: 1fr;
  }
  
  .tech-benefits ul {
    grid-template-columns: 1fr;
  }
  
  .sustainability-stats {
    grid-template-columns: 1fr;
  }
  
  .cta-title {
    font-size: 2.5rem;
  }
  
  .cta-actions {
    flex-direction: column;
    align-items: center;
  }
  
  .cta-contact-info {
    flex-direction: column;
    gap: 1rem;
  }
}

@media (max-width: 480px) {
  .feature-card {
    padding: 2rem 1.5rem;
  }
  
  .preview-tools {
    flex-direction: column;
  }
  
  .cta-button {
    padding: 1rem 2rem;
    font-size: 0.9rem;
  }
}
</style>