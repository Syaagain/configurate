<template>
  <div class="service-page">
    <!-- Hero Section mit Parallax -->
    <section class="hero-section">
      <div class="hero-background">
        <div class="parallax-layer layer-1" :style="{ transform: `translateY(${scrollY * 0.5}px)` }">
          <img src="https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png" alt="Service">
        </div>
        <div class="hero-overlay"></div>
      </div>
      <div class="hero-content">
        <div class="hero-badge">PREMIUM SERVICE</div>
        <h1 class="hero-title">
          <span class="title-line">ALLE GEWERKE</span>
          <span class="title-line accent">AUS EINER HAND</span>
        </h1>
        <p class="hero-subtitle">
          Ihr Partner für exklusive und vollumfängliche Serviceleistungen im Bereich Naturstein, 
          High-Tech Feinsteinzeug, Design-Verlegung und schlüsselfertige Übergabe
        </p>
        <div class="hero-stats">
          <div class="stat-item" v-for="stat in heroStats" :key="stat.id">
            <div class="stat-number" :data-target="stat.value">0</div>
            <div class="stat-label">{{ stat.label }}</div>
          </div>
        </div>
        <div class="hero-cta">
          <button @click="scrollToSection('services')" class="cta-btn primary">
            UNSERE SERVICES
            <span class="material-icons">arrow_downward</span>
          </button>
          <NuxtLink to="/kontakt" class="cta-btn secondary">
            BERATUNG VEREINBAREN
          </NuxtLink>
        </div>
      </div>
    </section>

    <!-- Core Services Grid -->
    <section id="services" class="services-section">
      <div class="container">
        <div class="section-header">
          <span class="section-badge">KERNKOMPETENZEN</span>
          <h2 class="section-title">UNSERE PREMIUM SERVICES</h2>
          <p class="section-subtitle">Handwerkliche Perfektion, ästhetische Raffinesse und erstklassiger Kundenservice</p>
        </div>

        <div class="services-grid">
          <div 
            v-for="(service, index) in coreServices" 
            :key="service.id"
            class="service-card"
            :style="{ animationDelay: `${index * 0.1}s` }"
            @mouseenter="playHoverSound"
          >
            <div class="service-icon-wrapper">
              <div class="icon-glow"></div>
              <span class="material-icons service-icon">{{ service.icon }}</span>
            </div>
            <h3 class="service-title">{{ service.title }}</h3>
            <p class="service-description">{{ service.description }}</p>
            <ul class="service-features">
              <li v-for="feature in service.features" :key="feature">
                <span class="material-icons check-icon">check_circle</span>
                {{ feature }}
              </li>
            </ul>
            <button @click="openServiceModal(service)" class="service-btn">
              MEHR ERFAHREN
              <span class="material-icons">arrow_forward</span>
            </button>
          </div>
        </div>
      </div>
    </section>

    <!-- Process Timeline -->
    <section class="process-section">
      <div class="container">
        <div class="section-header">
          <span class="section-badge">ABLAUF</span>
          <h2 class="section-title">SO FUNKTIONIERT'S</h2>
          <p class="section-subtitle">Von der ersten Beratung bis zur finalen Übergabe</p>
        </div>

        <div class="process-timeline">
          <div class="timeline-line">
            <div class="timeline-progress" :style="{ height: `${timelineProgress}%` }"></div>
          </div>
          
          <div 
            v-for="(step, index) in processSteps" 
            :key="step.id"
            class="timeline-step"
            :class="{ active: visibleSteps.includes(index) }"
            :data-index="index"
          >
            <div class="step-marker">
              <span class="step-number">{{ toRoman(index + 1) }}</span>
              <div class="marker-pulse"></div>
            </div>
            
            <div class="step-content">
              <h3 class="step-title">{{ step.title }}</h3>
              <p class="step-description">{{ step.description }}</p>
            </div>
            
            <div class="step-image">
              <img :src="step.image" :alt="step.title">
              <div class="image-overlay"></div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Luxury Advantages Section -->
    <section class="advantages-section">
      <div class="container">
        <div class="section-header">
          <span class="section-badge">EXKLUSIVITÄT</span>
          <h2 class="section-title">WARUM ARCHITEKTUR GROUP?</h2>
          <p class="section-subtitle">Erstklassige Vorteile für anspruchsvolle Kunden</p>
        </div>

        <!-- Premium Advantages Grid -->
        <div class="premium-advantages">
          <div 
            v-for="(advantage, index) in advantages" 
            :key="advantage.id"
            class="premium-advantage-card"
            :style="{ animationDelay: `${index * 0.1}s` }"
            :class="{ 
              'expanded': expandedAdvantages.includes(advantage.id),
              'highlight': index < 4 
            }"
            @mouseenter="handleCardHover(advantage.id)"
            @mouseleave="handleCardLeave(advantage.id)"
          >
            <!-- Card Background Effects -->
            <div class="card-glow"></div>
            <div class="card-shine"></div>
            
            <!-- Card Header -->
            <div class="premium-card-header" @click="toggleAdvantage(advantage.id)">
              <div class="advantage-icon-wrapper">
                <div class="icon-ring"></div>
                <span class="material-icons advantage-icon">{{ advantage.icon }}</span>
              </div>
              <div class="advantage-info">
                <h3 class="advantage-title">{{ advantage.title }}</h3>
                <div class="advantage-indicator">
                  <span class="material-icons expand-arrow">
                    {{ expandedAdvantages.includes(advantage.id) ? 'keyboard_arrow_up' : 'keyboard_arrow_down' }}
                  </span>
                </div>
              </div>
            </div>
            
            <!-- Expandable Content -->
            <transition name="advantage-expand" @enter="onAdvantageEnter" @leave="onAdvantageLeave">
              <div v-if="expandedAdvantages.includes(advantage.id)" class="premium-advantage-content">
                <div class="content-divider"></div>
                <p class="advantage-description">{{ advantage.description }}</p>
                <div class="advantage-badge">
                  <span class="material-icons badge-icon">verified</span>
                  <span>PREMIUM VORTEIL</span>
                </div>
              </div>
            </transition>
          </div>
        </div>

        <!-- Luxury Special Features Showcase -->
        <div class="luxury-features-showcase">
          <div class="showcase-header">
            <h3 class="showcase-title">EXKLUSIVE SERVICELEISTUNGEN</h3>
            <p class="showcase-subtitle">Außergewöhnlicher Service für außergewöhnliche Kunden</p>
          </div>
          
          <div class="features-luxury-grid">
            <div 
              v-for="(feature, index) in specialFeatures" 
              :key="feature.id"
              class="luxury-feature-card"
              :style="{ animationDelay: `${index * 0.2}s` }"
              @mouseenter="playFeatureAnimation(feature.id)"
            >
              <div class="luxury-feature-background">
                <div class="feature-gradient"></div>
                <div class="feature-pattern"></div>
              </div>
              
              <div class="luxury-feature-content">
                <div class="luxury-feature-icon">
                  <div class="icon-backdrop"></div>
                  <span class="material-icons">{{ feature.icon }}</span>
                </div>
                <h4 class="luxury-feature-title">{{ feature.title }}</h4>
                <p class="luxury-feature-description">{{ feature.description }}</p>
                
                <div class="feature-highlight">
                  <div class="highlight-bar"></div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- FAQ Section -->
    <section class="faq-section">
      <div class="container">
        <div class="section-header">
          <span class="section-badge">HÄUFIGE FRAGEN</span>
          <h2 class="section-title">FRAGEN & ANTWORTEN</h2>
          <p class="section-subtitle">Alles was Sie über unsere Services wissen müssen</p>
        </div>

        <div class="faq-categories">
          <button 
            v-for="category in faqCategories" 
            :key="category.id"
            @click="activeFaqCategory = category.id"
            :class="['category-btn', { active: activeFaqCategory === category.id }]"
          >
            <span class="material-icons">{{ category.icon }}</span>
            {{ category.name }}
            <span class="count">{{ category.count }}</span>
          </button>
        </div>

        <div class="faq-list">
          <transition-group name="faq-transition">
            <div 
              v-for="(faq, index) in filteredFaqs" 
              :key="faq.id"
              class="faq-item"
              :style="{ animationDelay: `${index * 0.05}s` }"
            >
              <button 
                @click="toggleFaq(faq.id)"
                class="faq-question"
                :class="{ active: expandedFaqs.includes(faq.id) }"
              >
                <span class="question-text">{{ faq.question }}</span>
                <span class="faq-toggle">
                  <span class="material-icons">
                    {{ expandedFaqs.includes(faq.id) ? 'remove' : 'add' }}
                  </span>
                </span>
              </button>
              
              <transition name="answer">
                <div v-if="expandedFaqs.includes(faq.id)" class="faq-answer">
                  <div class="answer-content" v-html="faq.answer"></div>
                </div>
              </transition>
            </div>
          </transition-group>
        </div>
      </div>
    </section>

    <!-- Showroom CTA -->
    <section class="showroom-cta">
      <div class="container">
        <div class="cta-grid">
          <div class="cta-card munich">
            <div class="card-background">
              <img src="https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686576cf622e38e88f0236c5.png" alt="München">
              <div class="card-overlay"></div>
            </div>
            <div class="card-content">
              <span class="location-badge">SHOWROOM</span>
              <h3>MÜNCHEN / STARNBERG</h3>
              <p>Lassen Sie sich in unserem Showroom im Großraum München inspirieren!</p>
              <div class="card-features">
                <span><span class="material-icons">square_foot</span> 80.000 m² Lagerfläche</span>
                <span><span class="material-icons">inventory</span> 650+ Natursteinsorten</span>
              </div>
              <NuxtLink to="/kontakt" class="card-btn">
                TERMIN VEREINBAREN
                <span class="material-icons">calendar_today</span>
              </NuxtLink>
            </div>
          </div>
          
          <div class="cta-card dusseldorf">
            <div class="card-background">
              <img src="https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png" alt="Düsseldorf">
              <div class="card-overlay"></div>
            </div>
            <div class="card-content">
              <span class="location-badge">SHOWROOM</span>
              <h3>DÜSSELDORF / NEUSS</h3>
              <p>Besuchen Sie Europas größte Auswahl an Premium Natursteinen!</p>
              <div class="card-features">
                <span><span class="material-icons">visibility</span> Digitale Bildergalerie</span>
                <span><span class="material-icons">local_shipping</span> Europaweite Lieferung</span>
              </div>
              <NuxtLink to="/kontakt" class="card-btn">
                TERMIN VEREINBAREN
                <span class="material-icons">calendar_today</span>
              </NuxtLink>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Contact Section -->
    <section class="contact-section">
      <div class="container">
        <div class="contact-content">
          <div class="contact-info">
            <h2 class="contact-title">IMMER FÜR SIE ERREICHBAR</h2>
            <p class="contact-subtitle">Unser Expertenteam steht Ihnen zur Verfügung</p>
            
            <div class="contact-details">
              <div class="detail-item">
                <span class="material-icons">schedule</span>
                <div>
                  <h4>Öffnungszeiten</h4>
                  <p>Dienstag - Freitag: 09:00 - 17:00 Uhr</p>
                  <p>Samstag: 09:00 - 16:00 Uhr</p>
                </div>
              </div>
              
              <div class="detail-item">
                <span class="material-icons">phone</span>
                <div>
                  <h4>Telefon & Fax</h4>
                  <a href="tel:+498171386870">+49 8171 / 3868770</a>
                  <p>Fax: +49 8171 / 3868771</p>
                </div>
              </div>
              
              <div class="detail-item">
                <span class="material-icons">email</span>
                <div>
                  <h4>E-Mail</h4>
                  <a href="mailto:kontakt@group-ag.de">kontakt@group-ag.de</a>
                </div>
              </div>
            </div>
            
            <div class="service-badges">
              <div class="badge-item">
                <span class="material-icons">accessible</span>
                <span>Barrierefrei</span>
              </div>
              <div class="badge-item">
                <span class="material-icons">child_care</span>
                <span>Spielecke</span>
              </div>
              <div class="badge-item">
                <span class="material-icons">local_cafe</span>
                <span>Bewirtung</span>
              </div>
              <div class="badge-item">
                <span class="material-icons">local_taxi</span>
                <span>Abholservice Flughafen/HBF</span>
              </div>
            </div>
          </div>
          
          <div class="contact-form">
            <h3>SCHNELLANFRAGE</h3>
            <form @submit.prevent="submitForm">
              <div class="form-group">
                <input type="text" v-model="form.name" placeholder="Ihr Name" required>
              </div>
              <div class="form-group">
                <input type="email" v-model="form.email" placeholder="Ihre E-Mail" required>
              </div>
              <div class="form-group">
                <select v-model="form.service" required>
                  <option value="">Service wählen</option>
                  <option value="beratung">Beratung</option>
                  <option value="aufmass">Aufmaß</option>
                  <option value="verlegung">Verlegung</option>
                  <option value="sanitaer">Sanitärarbeiten</option>
                  <option value="komplett">Komplettservice</option>
                </select>
              </div>
              <div class="form-group">
                <textarea v-model="form.message" placeholder="Ihre Nachricht" rows="4"></textarea>
              </div>
              <button type="submit" class="submit-btn">
                ANFRAGE SENDEN
                <span class="material-icons">send</span>
              </button>
            </form>
          </div>
        </div>
      </div>
    </section>

    <!-- Service Modal -->
    <transition name="modal">
      <div v-if="selectedService" class="service-modal" @click="closeModal">
        <div class="modal-container" @click.stop>
          <button class="modal-close" @click="closeModal">
            <span class="material-icons">close</span>
          </button>
          
          <div class="modal-content">
            <div class="modal-icon">
              <span class="material-icons">{{ selectedService.icon }}</span>
            </div>
            <h2 class="modal-title">{{ selectedService.title }}</h2>
            <p class="modal-description">{{ selectedService.fullDescription }}</p>
            
            <div class="modal-features">
              <h3>LEISTUNGSUMFANG</h3>
              <div class="features-grid">
                <div v-for="feature in selectedService.detailedFeatures" :key="feature" class="feature-item">
                  <span class="material-icons">done</span>
                  {{ feature }}
                </div>
              </div>
            </div>
            
            <div class="modal-cta">
              <NuxtLink to="/kontakt" class="modal-btn primary">
                BERATUNG ANFRAGEN
              </NuxtLink>
              <button @click="closeModal" class="modal-btn secondary">
                SCHLIESSEN
              </button>
            </div>
          </div>
        </div>
      </div>
    </transition>
  </div>
</template>

<script setup>
// State Management
const scrollY = ref(0)
const timelineProgress = ref(0)
const visibleSteps = ref([])
const activeFaqCategory = ref('allgemein')
const expandedFaqs = ref([])
const expandedAdvantages = ref([]) // Separates Array für Bug-Fix
const selectedService = ref(null)
const hoveredCards = ref(new Set())

// Form
const form = reactive({
  name: '',
  email: '',
  service: '',
  message: ''
})

// Hero Stats
const heroStats = [
  { id: 1, value: 650, label: 'Natursteinsorten' },
  { id: 2, value: 80000, label: 'm² Lagerfläche' },
  { id: 3, value: 100, label: '% auf Lager' },
  { id: 4, value: 1, label: '. Wahl & Sortierung' }
]

// Core Services (aus dem Text)
const coreServices = [
  {
    id: 1,
    icon: 'construction',
    title: 'Design-Verlegung',
    description: 'Hochwertige Design-Verlegung mit jahrelanger Erfahrung',
    features: [
      'Fugenlose Design-Verlegung',
      'Großformatige Beläge',
      'Patentierte High-Tech Fuge'
    ],
    fullDescription: 'Mit jahrelanger Erfahrung in der durchgehend fugenlosen Design-Verlegung von Natursteinen und großformatigen High-Tech Feinsteinzeugbelägen schaffen wir ansprechende Gestaltungen, die Ihren Räumen eine unvergleichliche Note verleihen.',
    detailedFeatures: [
      'Veredelte Kantenübergänge',
      'Mamorkitt-Veredlung',
      'Innovative Kanten-Verhärtungstechnik',
      'Lebenslange Garantie auf High-Tech Fuge',
      'Spezielle Schulungen für Verleger',
      'Europaweite Verlegung'
    ]
  },
  {
    id: 2,
    icon: 'bathtub',
    title: 'Sanitärarbeiten',
    description: 'Fachgerechte Sanitärarbeiten für perfekte Bäder',
    features: [
      'Individuelle Sanitärlösungen',
      'Hochwertige Armaturen',
      'Modernste Technologien'
    ],
    fullDescription: 'Für das perfekte Zusammenspiel von Funktionalität und Ästhetik bieten wir Ihnen individuelle Sanitärlösungen. Unsere erfahrenen Sanitärprofis gestalten Badezimmer nach höchsten Standards.',
    detailedFeatures: [
      'Komplette Badrenovierung',
      'Waschtisch-Montage',
      'Sanitäranlagen-Installation',
      'Elektronik aus einer Hand',
      'Smart-Home Integration',
      'Wellness-Bereiche'
    ]
  },
  {
    id: 3,
    icon: 'straighten',
    title: 'Bemaßung',
    description: 'Präzises Aufmaß europaweit bei Ihnen vor Ort',
    features: [
      'Europaweit verfügbar',
      'Millimetergenaue Erfassung',
      'Schablonenerstellung'
    ],
    fullDescription: 'Wir übernehmen das Aufmaß bei Ihnen europaweit. Betonbelagtreppen und freitragende Bolzentreppen werden individuell ausgemessen und wie ein Maßanzug montiert.',
    detailedFeatures: [
      'Deutschlandweite Vermessung',
      'Schablonenerstellung vor Ort',
      'Treppen-Aufmaß',
      'SkyStairs (freitragende Treppen)',
      'Komplettpaket aus einer Hand',
      'Harmonisches Raumgefühl'
    ]
  },
  {
    id: 4,
    icon: 'local_shipping',
    title: 'Lieferung',
    description: 'Europaweite Lieferung bis zu Ihrer Haustür',
    features: [
      'Europaweite Lieferung',
      'Kostengünstiger Transport',
      'Haus-Spedition'
    ],
    fullDescription: 'Lieferung europaweit bis zu Ihnen nach Hause. Unser kostengünstiger Transport liegt bei ca. 50m² deutschlandweit bei nur ca. 90,00€.',
    detailedFeatures: [
      'Eigene Spedition',
      'Kontaktierung vor Anlieferung',
      'Versicherter Transport',
      'Klimatisierte Fahrzeuge',
      'Europaweite Verfügbarkeit',
      'Express-Lieferung möglich'
    ]
  }
]

// Process Steps
const processSteps = [
  {
    id: 1,
    title: 'Beratung',
    description: 'Persönliche Beratung in unseren Showrooms mit geschulten Innendesignern',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686576cf622e38e88f0236c5.png'
  },
  {
    id: 2,
    title: 'Auswahl',
    description: 'Auswahl aus über 650 Natursteinsorten und High-Tech Feinsteinzeug',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png'
  },
  {
    id: 3,
    title: 'Bestellung',
    description: 'Detailliertes Angebot und Auftragsbestätigung',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png'
  },
  {
    id: 4,
    title: 'Lieferung',
    description: 'Europaweite Lieferung durch unsere Haus-Spedition',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b70b0803723582ed6.png'
  }
]

// Advantages - fixed reactive structure
const advantages = [
  {
    id: 1,
    icon: 'inventory',
    title: 'Mehr als 650 Natursteinsorten',
    description: 'Europas größte Auswahl an Natursteinen in jeder Form. Spezialisierung auf Natursteine mit Top-Qualität, nur 1. Wahl und 1. Sortierung, alle Steine zertifiziert mit Blocknummer.'
  },
  {
    id: 2,
    icon: 'warehouse',
    title: 'Alle Artikel sind Lagerware',
    description: 'Auf über 80.000 m² Lagerfläche haben wir Europas größte Auswahl an Natursteinen in jeder Form vorrätig. Produkte aus unserem Sortiment sind für Sie sofort lieferbar.'
  },
  {
    id: 3,
    icon: 'architecture',
    title: 'Fachmännische Design Beratung',
    description: 'Ausgezeichnete Beratung durch Fachverkäufer in Gestaltung, Trends, Fliesen-Technologie, Verlegung, Pflege und Reinigung. Unser Verkaufsteam verfügt über eine renommierte Innenarchitektin.'
  },
  {
    id: 4,
    icon: 'handyman',
    title: 'Europaweite Verlegung und Montage',
    description: 'Unsere fachmännische Verlegung und Montage zeichnen uns aus! Europaweite Lieferung, Montage und Verlegung von unserem Werk.'
  },
  {
    id: 5,
    icon: 'savings',
    title: 'Firmenverbund-Vorteile',
    description: 'Wir arbeiten in einem Firmenverbund. Durch den gemeinsamen Einkauf haben wir günstige Einkaufskonditionen. Den dadurch erzielten Preisvorteil geben wir an unsere Kunden weiter.'
  },
  {
    id: 6,
    icon: 'wb_sunny',
    title: 'Spezielle Lichtverhältnisse',
    description: 'Aufgrund der speziellen Lichtverhältnisse in unserer Ausstellung, haben Sie die Möglichkeit, die Fliesen mittels unterschiedlicher Lichteffekte (Sonnenlicht, Tageslicht, Dämmerung, Wohnräumlichkeit) anzusehen.'
  },
  {
    id: 7,
    icon: 'collections',
    title: 'Digitale Bildergalerie',
    description: 'Inspirationen durch unsere digitale Bildergalerie in unserer Ausstellung für eine optimale Visualisierung Ihrer Projekte.'
  },
  {
    id: 8,
    icon: 'home_work',
    title: 'Badplanung nach Vereinbarung',
    description: 'Individuelle Badplanung mit 3D-Visualisierung nach Terminvereinbarung durch unsere Experten.'
  }
]

// Special Features (aus dem Text)
const specialFeatures = [
  {
    id: 1,
    icon: 'accessible',
    title: 'Barrierefrei',
    description: 'Unsere Ausstellung ist selbstverständlich behindertengerecht ausgestattet'
  },
  {
    id: 2,
    icon: 'child_care',
    title: 'Spielecke',
    description: 'Für Ihr Wohlbefinden bieten wir Ihren Kindern eine Spielecke'
  },
  {
    id: 3,
    icon: 'local_cafe',
    title: 'Bewirtung',
    description: 'Selbstverständlich versorgen wir Sie mit Cafe, Espresso oder Kaltgetränken'
  },
  {
    id: 4,
    icon: 'local_taxi',
    title: 'Abholservice',
    description: 'Auf Wunsch Abholung vom Flughafen Düsseldorf/München oder Hauptbahnhöfen'
  }
]

// FAQ Categories
const faqCategories = [
  { id: 'allgemein', name: 'Allgemein', icon: 'help', count: 10 },
  { id: 'material', name: 'Material & Oberflächen', icon: 'layers', count: 8 },
  { id: 'verlegung', name: 'Verlegung', icon: 'construction', count: 5 },
  { id: 'bestellung', name: 'Bestellung & Lieferung', icon: 'shopping_cart', count: 6 }
]

// Complete FAQ Data
const faqs = [
  // Allgemein
  {
    id: 1,
    category: 'allgemein',
    question: 'Was bedeutet Architektur Group?',
    answer: 'Die Architektur Group besteht aus einem Team an Partnern/Kooperationen & Beratern im Bereich Planung & Innenarchitektur, die während eines Projektes (Neubau, Kernsanierung, Badrenovierung, SkyStairs, Outdoorbereich) die gesamten Arbeitsschritte koordinieren.'
  },
  {
    id: 2,
    category: 'allgemein',
    question: 'Wie läuft ein Beratungstermin ab?',
    answer: 'Unsere Kunden kommen deutschland- und europaweit für eine persönliche Beratung in unsere Showrooms. Wir empfehlen einen Termin mit unseren geschulten Innendesignern zu vereinbaren. Die Beratung ist selbstverständlich kostenlos. Bringen Sie genaue Angaben (Quadratmeter, Treppenstufen, laufende Meter) oder Baupläne mit.'
  },
  {
    id: 3,
    category: 'allgemein',
    question: 'Kann ich mir die Produkte vor dem Kauf ansehen?',
    answer: 'Gerne können Sie sich die Natursteine oder Feinsteinzeugfliesen in unseren Ausstellungen in natura ansehen. Unser gesamtes Sortiment ist sofort verfügbar. Kunden aus ganz Europa besuchen uns.'
  },
  {
    id: 4,
    category: 'allgemein',
    question: 'Wie erfahre ich Preise?',
    answer: 'Preise erfahren Sie:<br>1. Persönlich in unserer Ausstellung<br>2. Per E-Mail an kontakt@group-ag.de<br>3. Über unser Kontaktformular<br>4. Im Produktbereich über unser Anfrageformular<br>Ihr individuelles Angebot erhalten Sie innerhalb kürzester Zeit.'
  },
  {
    id: 5,
    category: 'allgemein',
    question: 'Wann und wie erreiche ich die Architektur Group?',
    answer: '<strong>Öffnungszeiten:</strong><br>Dienstag – Freitag: 09:00 – 17:00 Uhr<br>Samstag: 09:00 – 16:00 Uhr<br><br><strong>Kontakt:</strong><br>Telefon: +49 8171 / 3868770<br>Fax: +49 8171 / 3868771<br>E-Mail: kontakt@group-ag.de'
  },
  {
    id: 6,
    category: 'allgemein',
    question: 'Sind alle Steine Lagerware?',
    answer: 'Ja! Die Architektur Group ist als Fachgroßhändler spezialisiert auf Endkunden. Auf über 80.000 m² Lagerfläche haben wir Europas größte Auswahl an Natursteinen in jeder Form vorrätig.'
  },
  {
    id: 7,
    category: 'allgemein',
    question: 'Bietet die Architektur Group den Umbau von Badezimmern an?',
    answer: 'Ja, wir bieten neben der Verlegung auch den Einbau von Sanitäranlagen und Elektronik aus einer Hand an. Unsere speziell geschulten Design-Verleger kommen deutschland- und europaweit zu Ihnen.'
  },
  {
    id: 8,
    category: 'allgemein',
    question: 'Verfügt die Architektur Group über einen Verlegservice?',
    answer: 'Ja, die Architektur Group verfügt über qualifiziertes Fachpersonal zur Verlegung von Böden, Wandverkleidungen und Treppenbelegen. Es werden die besten Verlegungsstoffe verwendet für beste ästhetische und funktionale Resultate.'
  },
  {
    id: 9,
    category: 'allgemein',
    question: 'Kann ich Musterfliesen bestellen?',
    answer: 'Nein, da Musterfliesen den Gesamteindruck verfälschen. Wir legen großen Wert auf fachmännisch fundierte Beratung im Hinblick auf Design & kompatible Verlegematerialien direkt vor Ort in unserem Showroom.'
  },
  {
    id: 10,
    category: 'allgemein',
    question: 'Architektur Group & Kooperation',
    answer: 'Die Architektur Group verfügt weltweit über Kooperationspartner und Lieferanten. Für erfolgreiche Kundenvermittlung bieten wir eine Tippgeberprovision von 10% bis 70% je nach Auftragsvolumen.'
  },
  // Material & Oberflächen
  {
    id: 11,
    category: 'material',
    question: 'Welche Oberflächen für Granitfliesen sind möglich?',
    answer: '<strong>Verfügbare Oberflächen:</strong><br>• <strong>Poliert:</strong> Glänzende Oberfläche, gute Reinigungsfähigkeit<br>• <strong>Geschliffen:</strong> Matt bis halbglänzend<br>• <strong>Satiniert:</strong> Geschliffen und gebürstet<br>• <strong>Geflammt:</strong> Raue Oberfläche für Rutschsicherheit<br>• <strong>Geflammt & Gebürstet:</strong> Samtweiche Oberfläche, echte Veredelung'
  },
  {
    id: 12,
    category: 'material',
    question: 'Welche Oberflächen bei Marmorfliesen sind möglich?',
    answer: '<strong>Marmoroberflächen:</strong><br>• <strong>Antik gebürstet:</strong> Seidiger Glanz, sehr widerstandsfähig<br>• <strong>Geschliffen:</strong> Matt bis halbglänzend, kann neu geschliffen werden<br>• <strong>Poliert:</strong> Attraktivste Seite, gute Reinigungsfähigkeit'
  },
  {
    id: 13,
    category: 'material',
    question: 'Was bedeutet Kalibrierung?',
    answer: 'Kalibrierung bezieht sich auf Formate und Stärken von Natursteinprodukten. Die Produkte müssen DIN-Normen erfüllen. Durch Kalibrierung wird z.B. die Stärke von 0,9-1,1 cm auf einheitlich 1 cm gebracht.'
  },
  {
    id: 14,
    category: 'material',
    question: 'Was bedeutet rektifiziert?',
    answer: 'Bei rektifiziertem Feinsteinzeug wird das Material nach dem Brennen in einheitliche Größe gebracht mit exakt 90 Grad Kantenneigung. Jede Fliese ist gleich groß, Verlegung mit 1,5-2mm Fugenbreite. Weniger Angriffsfläche für Bakterien und Schmutz.'
  },
  {
    id: 15,
    category: 'material',
    question: 'Nutzt sich High-Tech Feinsteinzeug ab?',
    answer: 'High-Tech Feinsteinzeug ist sehr robust und pflegeleicht mit der Härte von Granit. Mit der Zeit entstehen normale Gebrauchsspuren wie leichte Kratzer, je nach Belastungsgruppe und Reibungskoeffizient.'
  },
  {
    id: 16,
    category: 'material',
    question: 'Ist High-Tech Feinsteinzeug säurefest?',
    answer: 'Unser High-Tech Feinsteinzeug ist grundsätzlich säurefest und schimmelbeständig. Von stark säurehaltigen Reinigungsmitteln außerhalb unseres Sortiments raten wir ab.'
  },
  {
    id: 17,
    category: 'material',
    question: 'Was wiegen die verschiedenen Fliesen?',
    answer: '• 1 m² Naturstein Fliesenformat: ca. 29-30 kg<br>• 1 m² Feinsteinzeug Fliesenformat: ca. 22-24 kg'
  },
  {
    id: 18,
    category: 'material',
    question: 'Gibt es einheitliche Bodenbeläge für Innen und Außen?',
    answer: 'Ja, wir haben ein spezielles System zur Verlegung von großformatigen Belägen entwickelt. So ist es möglich, den Bodenbelag aus dem Innenbereich mit rutschfester Oberfläche auf Terrasse oder Balkon weiterzuverlegen.'
  },
  // Verlegung
  {
    id: 19,
    category: 'verlegung',
    question: 'Design-Verlegung und Verfugung',
    answer: 'Die Verlegung ist entscheidend für perfekte und langlebige Ergebnisse. Für unsere patentierte High-Tech Fuge bieten wir spezielle Schulungen an, damit die patentierten Eigenschaften erreicht und erhalten bleiben.'
  },
  {
    id: 20,
    category: 'verlegung',
    question: 'Veredelte Kantenübergänge',
    answer: 'Bei Kantenübergängen werden veredelte Übergänge mit Mamorkitt-Veredlung ausgeführt. Die Bearbeitung erfolgt von beiden Seiten für nahtlose Übergänge. Es wird eine innovative, bruchsichere Kanten-Verhärtungstechnik angewandt.'
  },
  {
    id: 21,
    category: 'verlegung',
    question: 'Fachgerechte Verarbeitung der High-Tech Fuge',
    answer: 'Der Fugenbereich muss frei von Verschmutzungen sein. Mit dem mitgelieferten Glättmittel muss die Fuge innerhalb von 5 Minuten abgezogen werden. Für die lebenslange Garantie ist die Verlegung durch unsere geschulten Design-Verleger Voraussetzung.'
  },
  {
    id: 22,
    category: 'verlegung',
    question: 'Sind besondere Klebstoffe notwendig?',
    answer: 'Unser AG-N Hochflexibel Spezial Kleber ist speziell für die Entkopplung entwickelt. Er enthält Kunststoffzusätze für hochflexible Verklebung von High-Tech Feinsteinzeug und Natursteinen in Großformaten. Der Kleber ist wasser- und frostfest.'
  },
  {
    id: 23,
    category: 'verlegung',
    question: 'Reinigung der High-Tech Fuge',
    answer: 'Patent innerhalb unserer Unternehmensgruppe. Verunreinigungen können mit unserem Premium Fleckenentferner entfernt werden. Nach der Verlegung wird Ihnen die Reinigung ausführlich vor Ort erklärt.'
  },
  // Bestellung & Lieferung
  {
    id: 24,
    category: 'bestellung',
    question: 'Wie läuft eine Bestellung ab?',
    answer: 'Der Ablauf ist einfach:<br>1. Bestellung aufgeben<br>2. Bestätigung erhalten<br>3. Lieferung erfolgt'
  },
  {
    id: 25,
    category: 'bestellung',
    question: 'Warum sollte ich mehr Material bestellen?',
    answer: 'Beim Verlegen kann es zu Verschnitt und Bruch kommen. Die Profi-Daumenregel: immer ca. 10% mehr Material mitbestellen. Eine Reserve ist auch sinnvoll für spätere Reparaturen oder Sanierungsarbeiten.'
  },
  {
    id: 26,
    category: 'bestellung',
    question: 'In welche Länder liefert die Architektur Group?',
    answer: 'Die Architektur Group liefert europaweit. Ihren Wünschen sind keine Grenzen gesetzt!'
  },
  {
    id: 27,
    category: 'bestellung',
    question: 'Werde ich vor der Anlieferung kontaktiert?',
    answer: 'Ja, vor der Anlieferung erfolgt eine Kontaktierung durch unsere Haus-Spedition.'
  },
  {
    id: 28,
    category: 'bestellung',
    question: 'Wie bekomme ich meine Wunschsteine?',
    answer: 'Wir liefern deutschland- und europaweit bis zu Ihnen nach Hause. Unser kostengünstiger Transport liegt bei ca. 50m² deutschlandweit bei nur ca. 90,00€.'
  },
  {
    id: 29,
    category: 'bestellung',
    question: 'Wie bekomme ich meine Betontreppe/Bolzentreppe?',
    answer: 'Sie kommen mit Ihrem Bauplan zu uns und erhalten eine fachmännische Beratung. Nach Auftragsbestätigung kommen wir deutschlandweit für Aufmaß und Schablonenerstellung zu Ihnen. Die Treppen werden wie ein Maßanzug montiert.'
  }
]

// Computed
const filteredFaqs = computed(() => {
  return faqs.filter(faq => faq.category === activeFaqCategory.value)
})

// Methods
const toRoman = (num) => {
  const romanNumerals = ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X']
  return romanNumerals[num - 1] || num.toString()
}

const scrollToSection = (id) => {
  const element = document.getElementById(id)
  if (element) {
    element.scrollIntoView({ behavior: 'smooth' })
  }
}

const openServiceModal = (service) => {
  selectedService.value = service
  document.body.style.overflow = 'hidden'
}

const closeModal = () => {
  selectedService.value = null
  document.body.style.overflow = 'auto'
}

const toggleFaq = (id) => {
  const index = expandedFaqs.value.indexOf(id)
  if (index > -1) {
    expandedFaqs.value.splice(index, 1)
  } else {
    expandedFaqs.value.push(id)
  }
}

// Fixed advantage methods
const toggleAdvantage = (id) => {
  const index = expandedAdvantages.value.indexOf(id)
  if (index > -1) {
    expandedAdvantages.value.splice(index, 1)
  } else {
    expandedAdvantages.value.push(id)
  }
}

const handleCardHover = (id) => {
  hoveredCards.value.add(id)
}

const handleCardLeave = (id) => {
  hoveredCards.value.delete(id)
}

const playFeatureAnimation = (id) => {
  // Animation placeholder
}

const onAdvantageEnter = (el) => {
  el.style.height = '0'
  el.style.opacity = '0'
  setTimeout(() => {
    el.style.height = 'auto'
    el.style.opacity = '1'
  }, 10)
}

const onAdvantageLeave = (el) => {
  el.style.height = '0'
  el.style.opacity = '0'
}

const submitForm = () => {
  console.log('Form submitted:', form)
  // Handle form submission
}

const playHoverSound = () => {
  // Sound effect placeholder
}

// Scroll handling
const handleScroll = () => {
  scrollY.value = window.scrollY
  
  // Timeline progress
  const timeline = document.querySelector('.process-timeline')
  if (timeline) {
    const rect = timeline.getBoundingClientRect()
    const viewportHeight = window.innerHeight
    const progress = Math.min(100, Math.max(0, 
      (viewportHeight - rect.top) / (rect.height + viewportHeight) * 100
    ))
    timelineProgress.value = progress
  }
}

// Number animation
const animateNumbers = () => {
  const numbers = document.querySelectorAll('.stat-number')
  numbers.forEach(num => {
    const target = parseInt(num.dataset.target)
    const duration = 2000
    const increment = target / (duration / 16)
    let current = 0
    
    const updateNumber = () => {
      current += increment
      if (current < target) {
        num.textContent = Math.floor(current).toLocaleString('de-DE')
        requestAnimationFrame(updateNumber)
      } else {
        num.textContent = target.toLocaleString('de-DE')
      }
    }
    
    updateNumber()
  })
}

// Lifecycle
onMounted(() => {
  window.addEventListener('scroll', handleScroll)
  
  // Animate numbers when in view
  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        animateNumbers()
        observer.unobserve(entry.target)
      }
    })
  }, { threshold: 0.5 })
  
  const heroSection = document.querySelector('.hero-stats')
  if (heroSection) {
    observer.observe(heroSection)
  }
  
  // Timeline steps observer
  const stepsObserver = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        const index = parseInt(entry.target.dataset.index)
        if (!visibleSteps.value.includes(index)) {
          setTimeout(() => {
            visibleSteps.value.push(index)
          }, index * 200)
        }
      }
    })
  }, { threshold: 0.3 })
  
  document.querySelectorAll('.timeline-step').forEach((step, index) => {
    step.dataset.index = index
    stepsObserver.observe(step)
  })
})

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll)
  document.body.style.overflow = 'auto'
})
</script>

<style scoped>
.service-page {
  min-height: 100vh;
  background: #000;
  color: #FAFAF8;
  overflow-x: hidden;
}

.hero-section {
  position: relative;
  min-height: calc(100vh - var(--header-height)); 
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
}

.hero-background {
  position: absolute;
  inset: 0;
}

.parallax-layer {
  position: absolute;
  inset: -10%;
  width: 120%;
  height: 120%;
}

.parallax-layer img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.hero-overlay {
  position: absolute;
  inset: 0;
  background: radial-gradient(
    circle at center,
    rgba(0,0,0,0.4) 0%,
    rgba(0,0,0,0.8) 100%
  );
}

.hero-content {
  position: relative;
  z-index: 2;
  text-align: center;
  max-width: 1200px;
  padding: 0 2rem;
  animation: heroFadeIn 2s ease-out;
}

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

.hero-badge {
  display: inline-block;
  padding: 0.5rem 1.5rem;
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  color: #000;
  font-size: 0.875rem;
  font-weight: 600;
  letter-spacing: 0.1em;
  margin-bottom: 2rem;
  animation: badgePulse 3s infinite;
}

@keyframes badgePulse {
  0%, 100% { transform: scale(1); }
  50% { transform: scale(1.05); }
}

.hero-title {
  font-size: clamp(3rem, 7vw, 5rem);
  font-weight: 300;
  line-height: 1.1;
  margin-bottom: 2rem;
}

.title-line {
  display: block;
  animation: titleSlideIn 1.5s ease-out backwards;
}

.title-line:nth-child(2) {
  animation-delay: 0.3s;
}

.title-line.accent {
  background: linear-gradient(135deg, #FAFAF8 0%, #a47148 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

@keyframes titleSlideIn {
  from {
    opacity: 0;
    transform: translateX(-50px);
  }
  to {
    opacity: 1;
    transform: translateX(0);
  }
}

.hero-subtitle {
  font-size: 1.25rem;
  line-height: 1.6;
  color: #ccc;
  max-width: 800px;
  margin: 0 auto 3rem;
  animation: fadeInUp 1.5s ease-out 0.6s backwards;
}

@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.hero-stats {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
  gap: 2rem;
  max-width: 600px;
  margin: 0 auto 3rem;
  animation: fadeInUp 1.5s ease-out 0.9s backwards;
}

.stat-item {
  padding: 1.5rem;
  background: rgba(255, 255, 255, 0.05);
  backdrop-filter: blur(10px);
  border-radius: 15px;
  border: 1px solid rgba(255, 255, 255, 0.1);
  transition: all 0.3s ease;
}

.stat-item:hover {
  transform: translateY(-5px);
  background: rgba(255, 255, 255, 0.08);
  box-shadow: 0 10px 30px rgba(164, 113, 72, 0.2);
}

.stat-number {
  font-size: 2.5rem;
  font-weight: 600;
  color: #a47148;
  margin-bottom: 0.5rem;
}

.stat-label {
  font-size: 0.875rem;
  color: #ccc;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.hero-cta {
  display: flex;
  gap: 1.5rem;
  justify-content: center;
  animation: fadeInUp 1.5s ease-out 1.2s backwards;
}

.cta-btn {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  padding: 1rem 2rem;
  font-size: 0.95rem;
  font-weight: 500;
  letter-spacing: 0.05em;
  text-decoration: none;
  cursor: pointer;
  transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  border-radius: 50px;
  position: relative;
  overflow: hidden;
}

.cta-btn.primary {
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  color: #000;
  border: none;
}

.cta-btn.secondary {
  background: transparent;
  color: #FAFAF8;
  border: 2px solid #FAFAF8;
}

.cta-btn:hover {
  transform: translateY(-3px);
  box-shadow: 0 15px 30px rgba(164, 113, 72, 0.3);
}

.cta-btn.secondary:hover {
  background: #FAFAF8;
  color: #000;
}

/* Common Section Styles */
.container {
  max-width: 1400px;
  margin: 0 auto;
  padding: 0 2rem;
}

.section-header {
  text-align: center;
  margin-bottom: 4rem;
}

.section-badge {
  display: inline-block;
  padding: 0.5rem 1rem;
  background: rgba(164, 113, 72, 0.1);
  border: 1px solid #a47148;
  color: #a47148;
  font-size: 0.75rem;
  letter-spacing: 0.1em;
  margin-bottom: 1rem;
  font-weight: 600;
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
  font-size: 1.15rem;
  color: #999;
}

/* Services Section */
.services-section {
  padding: 6rem 0;
  background: linear-gradient(135deg, #0a0a0a 0%, #1a1a1a 100%);
}

.services-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 3rem;
}

.service-card {
  background: rgba(255, 255, 255, 0.03);
  border-radius: 20px;
  padding: 3rem 2rem;
  text-align: center;
  transition: all 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  border: 1px solid rgba(255, 255, 255, 0.05);
  animation: serviceCardIn 0.8s ease-out backwards;
  position: relative;
  overflow: hidden;
}

@keyframes serviceCardIn {
  from {
    opacity: 0;
    transform: translateY(50px) rotateX(-10deg);
  }
  to {
    opacity: 1;
    transform: translateY(0) rotateX(0);
  }
}

.service-card::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 3px;
  background: linear-gradient(90deg, transparent, #a47148, transparent);
  transform: translateX(-100%);
  transition: transform 0.6s ease;
}

.service-card:hover::before {
  transform: translateX(100%);
}

.service-card:hover {
  transform: translateY(-10px) scale(1.02);
  background: rgba(255, 255, 255, 0.06);
  box-shadow: 
    0 30px 60px rgba(164, 113, 72, 0.3),
    inset 0 0 100px rgba(164, 113, 72, 0.1);
}

.service-icon-wrapper {
  position: relative;
  width: 100px;
  height: 100px;
  margin: 0 auto 2rem;
}

.icon-glow {
  position: absolute;
  inset: -20px;
  background: radial-gradient(circle, rgba(164, 113, 72, 0.3), transparent);
  filter: blur(20px);
  animation: glowPulse 3s infinite;
}

@keyframes glowPulse {
  0%, 100% { opacity: 0.5; }
  50% { opacity: 1; }
}

.service-icon {
  position: relative;
  width: 100px;
  height: 100px;
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  border-radius: 20px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 3rem;
  color: #000;
  transition: all 0.3s ease;
}

.service-card:hover .service-icon {
  transform: rotateY(180deg);
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
  display: flex;
  align-items: center;
  gap: 0.75rem;
  padding: 0.75rem 0;
  color: #ccc;
  font-size: 0.95rem;
}

.check-icon {
  color: #a47148;
  font-size: 1.25rem;
}

.service-btn {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.75rem 1.5rem;
  background: transparent;
  border: 1px solid #a47148;
  color: #a47148;
  font-size: 0.875rem;
  letter-spacing: 0.05em;
  cursor: pointer;
  transition: all 0.3s ease;
  border-radius: 50px;
}

.service-btn:hover {
  background: #a47148;
  color: #000;
  transform: scale(1.05);
}

/* Process Timeline */
.process-section {
  padding: 6rem 0;
  position: relative;
}

.process-timeline {
  position: relative;
  max-width: 1000px;
  margin: 0 auto;
}

.timeline-line {
  position: absolute;
  left: 60px;
  top: 0;
  bottom: 0;
  width: 2px;
  background: rgba(255, 255, 255, 0.1);
}

.timeline-progress {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  background: linear-gradient(180deg, #a47148, #FAFAF8);
  transition: height 0.3s ease;
}

.timeline-step {
  display: grid;
  grid-template-columns: 120px 1fr 300px;
  gap: 2rem;
  margin-bottom: 4rem;
  opacity: 0;
  transform: translateX(-50px);
  transition: all 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

.timeline-step.active {
  opacity: 1;
  transform: translateX(0);
}

.step-marker {
  position: relative;
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
  z-index: 2;
}

.marker-pulse {
  position: absolute;
  top: 50%;
  left: 50%;
  width: 60px;
  height: 60px;
  transform: translate(-50%, -50%);
  border: 2px solid #a47148;
  border-radius: 50%;
  animation: pulse 2s infinite;
}

@keyframes pulse {
  0% {
    transform: translate(-50%, -50%) scale(1);
    opacity: 1;
  }
  100% {
    transform: translate(-50%, -50%) scale(2);
    opacity: 0;
  }
}

.step-content {
  padding: 1rem 0;
}

.step-title {
  font-size: 1.5rem;
  font-weight: 400;
  margin-bottom: 1rem;
  color: #FAFAF8;
}

.step-description {
  font-size: 1rem;
  line-height: 1.6;
  color: #ccc;
}

.step-image {
  position: relative;
  height: 150px;
  border-radius: 15px;
  overflow: hidden;
}

.step-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.image-overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(45deg, rgba(0,0,0,0.4), rgba(164, 113, 72, 0.2));
}

/* Luxury Advantages Section */
.advantages-section {
  padding: 8rem 0;
  background: 
    radial-gradient(circle at 20% 80%, rgba(164, 113, 72, 0.1) 0%, transparent 50%),
    radial-gradient(circle at 80% 20%, rgba(164, 113, 72, 0.05) 0%, transparent 50%),
    linear-gradient(135deg, #0f0f0f 0%, #1a1a1a 50%, #0a0a0a 100%);
  position: relative;
  overflow: hidden;
}

.advantages-section::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 1px;
  background: linear-gradient(90deg, transparent, #a47148, transparent);
}

/* Premium Advantages Grid */
.premium-advantages {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
  gap: 2rem;
  margin-bottom: 6rem;
}

.premium-advantage-card {
  position: relative;
  background: linear-gradient(135deg, 
    rgba(255, 255, 255, 0.08) 0%, 
    rgba(255, 255, 255, 0.02) 100%);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 24px;
  padding: 2rem;
  overflow: hidden;
  cursor: pointer;
  transition: all 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  animation: premiumCardIn 0.8s ease-out backwards;
}

@keyframes premiumCardIn {
  from {
    opacity: 0;
    transform: translateY(60px) scale(0.9);
  }
  to {
    opacity: 1;
    transform: translateY(0) scale(1);
  }
}

.premium-advantage-card.highlight {
  border-image: linear-gradient(135deg, #a47148, transparent) 1;
}

.premium-advantage-card:hover {
  transform: translateY(-15px) scale(1.03);
  background: linear-gradient(135deg, 
    rgba(255, 255, 255, 0.12) 0%, 
    rgba(164, 113, 72, 0.05) 100%);
  box-shadow: 
    0 40px 80px rgba(164, 113, 72, 0.3),
    inset 0 0 0 1px rgba(164, 113, 72, 0.2);
}

.premium-advantage-card.expanded {
  border-color: rgba(164, 113, 72, 0.4);
  background: linear-gradient(135deg, 
    rgba(164, 113, 72, 0.1) 0%, 
    rgba(255, 255, 255, 0.05) 100%);
}

/* Card Effects */
.card-glow {
  position: absolute;
  top: -50%;
  left: -50%;
  width: 200%;
  height: 200%;
  background: radial-gradient(circle, rgba(164, 113, 72, 0.1), transparent);
  opacity: 0;
  transition: opacity 0.6s ease;
  pointer-events: none;
}

.premium-advantage-card:hover .card-glow {
  opacity: 1;
}

.card-shine {
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(
    90deg,
    transparent,
    rgba(255, 255, 255, 0.1),
    transparent
  );
  transition: left 0.6s ease;
  pointer-events: none;
}

.premium-advantage-card:hover .card-shine {
  left: 100%;
}

/* Card Header */
.premium-card-header {
  display: grid;
  grid-template-columns: auto 1fr auto;
  align-items: center;
  gap: 1.5rem;
  transition: all 0.3s ease;
}

.advantage-icon-wrapper {
  position: relative;
  width: 70px;
  height: 70px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.icon-ring {
  position: absolute;
  inset: 0;
  border: 2px solid rgba(164, 113, 72, 0.3);
  border-radius: 50%;
  animation: iconRingRotate 8s linear infinite;
}

@keyframes iconRingRotate {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}

.advantage-icon {
  font-size: 2rem;
  color: #a47148;
  background: linear-gradient(135deg, rgba(164, 113, 72, 0.2), rgba(255, 255, 255, 0.1));
  width: 60px;
  height: 60px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.4s ease;
  position: relative;
  z-index: 1;
}

.premium-advantage-card:hover .advantage-icon {
  color: #FAFAF8;
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  transform: scale(1.1) rotateY(180deg);
}

.advantage-info {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.advantage-title {
  font-size: 1.25rem;
  font-weight: 500;
  color: #FAFAF8;
  line-height: 1.3;
  transition: color 0.3s ease;
}

.premium-advantage-card:hover .advantage-title {
  color: #a47148;
}

.advantage-indicator {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 40px;
  height: 40px;
  background: rgba(164, 113, 72, 0.1);
  border-radius: 50%;
  transition: all 0.4s ease;
}

.expand-arrow {
  color: #a47148;
  font-size: 1.5rem;
  transition: all 0.4s ease;
}

.premium-advantage-card.expanded .expand-arrow {
  transform: rotate(180deg);
  color: #FAFAF8;
}

.premium-advantage-card:hover .advantage-indicator {
  background: rgba(164, 113, 72, 0.2);
  transform: scale(1.1);
}

/* Expandable Content */
.premium-advantage-content {
  margin-top: 2rem;
  overflow: hidden;
  transition: all 0.4s ease;
}

.content-divider {
  width: 100%;
  height: 1px;
  background: linear-gradient(90deg, transparent, #a47148, transparent);
  margin-bottom: 1.5rem;
}

.advantage-description {
  color: #ccc;
  line-height: 1.8;
  font-size: 1rem;
  margin-bottom: 1.5rem;
}

.advantage-badge {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.5rem 1rem;
  background: linear-gradient(135deg, rgba(164, 113, 72, 0.2), rgba(255, 255, 255, 0.05));
  border: 1px solid rgba(164, 113, 72, 0.3);
  border-radius: 20px;
  font-size: 0.75rem;
  font-weight: 600;
  letter-spacing: 0.1em;
  color: #a47148;
}

.badge-icon {
  font-size: 1rem;
}

/* Transitions */
.advantage-expand-enter-active,
.advantage-expand-leave-active {
  transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

.advantage-expand-enter-from,
.advantage-expand-leave-to {
  opacity: 0;
  max-height: 0;
  transform: translateY(-20px);
}

.advantage-expand-enter-to,
.advantage-expand-leave-from {
  opacity: 1;
  max-height: 300px;
  transform: translateY(0);
}

/* Luxury Features Showcase */
.luxury-features-showcase {
  padding: 4rem 0;
  position: relative;
}

.showcase-header {
  text-align: center;
  margin-bottom: 4rem;
}

.showcase-title {
  font-size: 2.5rem;
  font-weight: 300;
  margin-bottom: 1rem;
  background: linear-gradient(135deg, #FAFAF8 0%, #a47148 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.showcase-subtitle {
  font-size: 1.1rem;
  color: #999;
  font-style: italic;
}

.features-luxury-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 3rem;
}

.luxury-feature-card {
  position: relative;
  height: 300px;
  border-radius: 24px;
  overflow: hidden;
  cursor: pointer;
  animation: luxuryFeatureIn 0.8s ease-out backwards;
  transition: all 0.6s ease;
}

@keyframes luxuryFeatureIn {
  from {
    opacity: 0;
    transform: translateY(80px) rotateX(-15deg);
  }
  to {
    opacity: 1;
    transform: translateY(0) rotateX(0);
  }
}

.luxury-feature-card:hover {
  transform: translateY(-20px) scale(1.05);
}

.luxury-feature-background {
  position: absolute;
  inset: 0;
}

.feature-gradient {
  position: absolute;
  inset: 0;
  background: linear-gradient(135deg, 
    rgba(164, 113, 72, 0.8) 0%, 
    rgba(0, 0, 0, 0.9) 100%);
}

.feature-pattern {
  position: absolute;
  inset: 0;
  background: 
    radial-gradient(circle at 20% 20%, rgba(255, 255, 255, 0.1) 1px, transparent 1px),
    radial-gradient(circle at 80% 80%, rgba(255, 255, 255, 0.1) 1px, transparent 1px);
  background-size: 40px 40px;
  opacity: 0.3;
}

.luxury-feature-content {
  position: relative;
  z-index: 1;
  padding: 2rem;
  height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  text-align: center;
}

.luxury-feature-icon {
  position: relative;
  width: 80px;
  height: 80px;
  margin-bottom: 2rem;
  display: flex;
  align-items: center;
  justify-content: center;
}

.icon-backdrop {
  position: absolute;
  inset: 0;
  background: linear-gradient(135deg, rgba(255, 255, 255, 0.2), rgba(164, 113, 72, 0.3));
  border-radius: 50%;
  filter: blur(20px);
}

.luxury-feature-icon .material-icons {
  font-size: 3rem;
  color: #FAFAF8;
  position: relative;
  z-index: 1;
}

.luxury-feature-title {
  font-size: 1.5rem;
  font-weight: 500;
  margin-bottom: 1rem;
  color: #FAFAF8;
}

.luxury-feature-description {
  color: #ccc;
  line-height: 1.6;
  margin-bottom: 2rem;
}

.feature-highlight {
  width: 100%;
  height: 2px;
  background: rgba(255, 255, 255, 0.1);
  position: relative;
  overflow: hidden;
}

.highlight-bar {
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, #FAFAF8, transparent);
  animation: highlightSlide 3s ease-in-out infinite;
}

@keyframes highlightSlide {
  0%, 100% { left: -100%; }
  50% { left: 100%; }
}

/* FAQ Section */
.faq-section {
  padding: 6rem 0;
}

.faq-categories {
  display: flex;
  justify-content: center;
  gap: 1rem;
  flex-wrap: wrap;
  margin-bottom: 3rem;
}

.category-btn {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.75rem 1.5rem;
  background: rgba(255, 255, 255, 0.03);
  border: 1px solid rgba(255, 255, 255, 0.1);
  color: #FAFAF8;
  border-radius: 50px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.category-btn:hover {
  background: rgba(255, 255, 255, 0.05);
}

.category-btn.active {
  background: rgba(164, 113, 72, 0.2);
  border-color: #a47148;
  color: #a47148;
}

.category-btn .count {
  padding: 0.25rem 0.5rem;
  background: rgba(255, 255, 255, 0.1);
  border-radius: 15px;
  font-size: 0.75rem;
  font-weight: 600;
}

.faq-list {
  max-width: 900px;
  margin: 0 auto;
}

.faq-item {
  margin-bottom: 1rem;
  animation: faqIn 0.5s ease-out backwards;
}

@keyframes faqIn {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.faq-question {
  width: 100%;
  padding: 1.5rem;
  background: rgba(255, 255, 255, 0.03);
  border: 1px solid rgba(255, 255, 255, 0.05);
  border-radius: 15px;
  color: #FAFAF8;
  text-align: left;
  cursor: pointer;
  transition: all 0.3s ease;
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 1.1rem;
}

.faq-question:hover {
  background: rgba(255, 255, 255, 0.05);
}

.faq-question.active {
  background: rgba(164, 113, 72, 0.1);
  border-color: #a47148;
}

.faq-toggle {
  width: 30px;
  height: 30px;
  background: rgba(164, 113, 72, 0.2);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #a47148;
  transition: all 0.3s ease;
}

.faq-question:hover .faq-toggle {
  background: #a47148;
  color: #000;
}

.faq-answer {
  padding: 1.5rem;
  background: rgba(255, 255, 255, 0.02);
  border-radius: 0 0 15px 15px;
  margin-top: -1px;
  border: 1px solid rgba(255, 255, 255, 0.05);
  border-top: none;
}

.answer-content {
  color: #ccc;
  line-height: 1.8;
}

.answer-content strong {
  color: #FAFAF8;
}

/* Showroom CTA */
.showroom-cta {
  padding: 6rem 0;
  background: linear-gradient(135deg, #0a0a0a 0%, #1a1a1a 100%);
}

.cta-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
  gap: 3rem;
}

.cta-card {
  position: relative;
  border-radius: 20px;
  overflow: hidden;
  transition: all 0.4s ease;
}

.cta-card:hover {
  transform: translateY(-10px);
  box-shadow: 0 30px 60px rgba(164, 113, 72, 0.3);
}

.card-background {
  position: absolute;
  inset: 0;
}

.card-background img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.card-overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(180deg, rgba(0,0,0,0.3) 0%, rgba(0,0,0,0.9) 100%);
}

.card-content {
  position: relative;
  z-index: 1;
  padding: 3rem;
  min-height: 400px;
  display: flex;
  flex-direction: column;
  justify-content: flex-end;
}

.location-badge {
  display: inline-block;
  padding: 0.5rem 1rem;
  background: #a47148;
  color: #000;
  font-size: 0.75rem;
  letter-spacing: 0.1em;
  font-weight: 600;
  margin-bottom: 1rem;
}

.card-content h3 {
  font-size: 2rem;
  font-weight: 400;
  margin-bottom: 1rem;
  color: #FAFAF8;
}

.card-content p {
  color: #ccc;
  line-height: 1.6;
  margin-bottom: 1.5rem;
}

.card-features {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
  margin-bottom: 2rem;
}

.card-features span {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  color: #ccc;
  font-size: 0.9rem;
}

.card-features .material-icons {
  font-size: 1.25rem;
  color: #a47148;
}

.card-btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  padding: 0.875rem 1.75rem;
  background: transparent;
  border: 2px solid #FAFAF8;
  color: #FAFAF8;
  font-size: 0.875rem;
  letter-spacing: 0.05em;
  text-decoration: none;
  border-radius: 50px;
  transition: all 0.3s ease;
}

.card-btn:hover {
  background: #FAFAF8;
  color: #000;
}

/* Contact Section */
.contact-section {
  padding: 6rem 0;
}

.contact-content {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 4rem;
}

.contact-title {
  font-size: 2.5rem;
  font-weight: 300;
  margin-bottom: 1rem;
  background: linear-gradient(135deg, #FAFAF8 0%, #a47148 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.contact-subtitle {
  font-size: 1.15rem;
  color: #999;
  margin-bottom: 3rem;
}

.contact-details {
  display: flex;
  flex-direction: column;
  gap: 2rem;
  margin-bottom: 3rem;
}

.detail-item {
  display: flex;
  gap: 1rem;
}

.detail-item .material-icons {
  width: 50px;
  height: 50px;
  background: rgba(164, 113, 72, 0.1);
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #a47148;
  font-size: 1.5rem;
  flex-shrink: 0;
}

.detail-item h4 {
  font-size: 1.1rem;
  font-weight: 400;
  margin-bottom: 0.5rem;
  color: #FAFAF8;
}

.detail-item p,
.detail-item a {
  color: #ccc;
  text-decoration: none;
  transition: color 0.3s ease;
}

.detail-item a:hover {
  color: #a47148;
}

.service-badges {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 1rem;
}

.badge-item {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  padding: 1rem;
  background: rgba(255, 255, 255, 0.03);
  border-radius: 10px;
  border: 1px solid rgba(255, 255, 255, 0.05);
}

.badge-item .material-icons {
  color: #a47148;
  font-size: 1.5rem;
}

/* Contact Form */
.contact-form {
  background: rgba(255, 255, 255, 0.03);
  border-radius: 20px;
  padding: 3rem;
  border: 1px solid rgba(255, 255, 255, 0.05);
}

.contact-form h3 {
  font-size: 1.5rem;
  font-weight: 400;
  margin-bottom: 2rem;
  color: #FAFAF8;
}

.form-group {
  margin-bottom: 1.5rem;
}

.form-group input,
.form-group select,
.form-group textarea {
  width: 100%;
  padding: 1rem;
  background: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.1);
  color: #FAFAF8;
  font-size: 1rem;
  border-radius: 10px;
  transition: all 0.3s ease;
}

.form-group input::placeholder,
.form-group textarea::placeholder {
  color: #666;
}

.form-group input:focus,
.form-group select:focus,
.form-group textarea:focus {
  outline: none;
  background: rgba(255, 255, 255, 0.08);
  border-color: #a47148;
}

.form-group select option {
  background: #1a1a1a;
  color: #FAFAF8;
}

.form-group textarea {
  resize: vertical;
}

.submit-btn {
  width: 100%;
  padding: 1rem;
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  color: #000;
  border: none;
  font-size: 1rem;
  font-weight: 600;
  letter-spacing: 0.05em;
  border-radius: 10px;
  cursor: pointer;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
}

.submit-btn:hover {
  transform: translateY(-3px);
  box-shadow: 0 15px 30px rgba(164, 113, 72, 0.3);
}

/* Service Modal */
.service-modal {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.95);
  z-index: 1000;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 2rem;
  backdrop-filter: blur(20px);
}

.modal-container {
  max-width: 800px;
  width: 100%;
  background: linear-gradient(135deg, #1a1a1a 0%, #0a0a0a 100%);
  border-radius: 20px;
  overflow: hidden;
  border: 1px solid rgba(255, 255, 255, 0.1);
  animation: modalIn 0.4s ease-out;
}

@keyframes modalIn {
  from {
    opacity: 0;
    transform: scale(0.9);
  }
  to {
    opacity: 1;
    transform: scale(1);
  }
}

.modal-close {
  position: absolute;
  top: 2rem;
  right: 2rem;
  width: 50px;
  height: 50px;
  background: rgba(255, 255, 255, 0.1);
  border: none;
  border-radius: 50%;
  color: #FAFAF8;
  cursor: pointer;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  justify-content: center;
}

.modal-close:hover {
  background: rgba(255, 255, 255, 0.2);
  transform: rotate(90deg);
}

.modal-content {
  padding: 4rem;
  text-align: center;
}

.modal-icon {
  width: 100px;
  height: 100px;
  margin: 0 auto 2rem;
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  border-radius: 20px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 3rem;
  color: #000;
}

.modal-title {
  font-size: 2rem;
  font-weight: 400;
  margin-bottom: 1rem;
  color: #FAFAF8;
}

.modal-description {
  font-size: 1.1rem;
  line-height: 1.6;
  color: #ccc;
  margin-bottom: 3rem;
}

.modal-features h3 {
  font-size: 1.3rem;
  font-weight: 400;
  margin-bottom: 2rem;
  color: #FAFAF8;
}

.features-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 1rem;
  text-align: left;
  margin-bottom: 3rem;
}

.feature-item {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  color: #ccc;
}

.feature-item .material-icons {
  color: #a47148;
  font-size: 1.25rem;
}

.modal-cta {
  display: flex;
  justify-content: center;
  gap: 1rem;
}

.modal-btn {
  padding: 0.875rem 2rem;
  font-size: 0.95rem;
  font-weight: 500;
  letter-spacing: 0.05em;
  text-decoration: none;
  cursor: pointer;
  transition: all 0.3s ease;
  border-radius: 50px;
}

.modal-btn.primary {
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  color: #000;
  border: none;
}

.modal-btn.secondary {
  background: transparent;
  color: #FAFAF8;
  border: 2px solid #FAFAF8;
}

.modal-btn:hover {
  transform: translateY(-3px);
}

/* Transitions */
.answer-enter-active,
.answer-leave-active {
  transition: all 0.3s ease;
}

.answer-enter-from,
.answer-leave-to {
  opacity: 0;
  transform: translateY(-10px);
}

.faq-transition-enter-active,
.faq-transition-leave-active {
  transition: all 0.5s ease;
}

.faq-transition-enter-from {
  opacity: 0;
  transform: translateX(-30px);
}

.faq-transition-leave-to {
  opacity: 0;
  transform: translateX(30px);
}

.modal-enter-active,
.modal-leave-active {
  transition: opacity 0.3s ease;
}

.modal-enter-from,
.modal-leave-to {
  opacity: 0;
}

/* Responsive Design */
@media (max-width: 1024px) {
  .services-grid {
    grid-template-columns: repeat(2, 1fr);
  }
  
  .contact-content {
    grid-template-columns: 1fr;
  }
  
  .premium-advantages {
    grid-template-columns: 1fr;
  }
  
  .features-luxury-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (max-width: 768px) {
  .hero-title {
    font-size: 2.5rem;
  }
  
  .hero-stats {
    grid-template-columns: repeat(2, 1fr);
  }
  
  .services-grid {
    grid-template-columns: 1fr;
  }
  
  .timeline-step {
    grid-template-columns: 60px 1fr;
  }
  
  .step-image {
    display: none;
  }
  
  .cta-grid {
    grid-template-columns: 1fr;
  }
  
  .service-badges {
    grid-template-columns: 1fr;
  }
  
  .features-grid {
    grid-template-columns: 1fr;
  }
  
  .features-luxury-grid {
    grid-template-columns: 1fr;
  }
  
  .faq-categories {
    flex-direction: column;
  }
}

@media (max-width: 480px) {
  .hero-title {
    font-size: 2rem;
  }
  
  .section-title {
    font-size: 2rem;
  }
  
  .showcase-title {
    font-size: 2rem;
  }
  
  .hero-cta {
    flex-direction: column;
  }
  
  .modal-content {
    padding: 2rem;
  }
}
</style>