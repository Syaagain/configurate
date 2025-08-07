<template>
  <div class="baeder-page">
    <!-- Hero Section -->
    <section class="hero-section">
      <div class="hero-background">
        <div class="hero-overlay"></div>
        <img 
          src="https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686576cf622e38e88f0236c5.png" 
          alt="Exklusive Bädermanufaktur"
          class="hero-image"
        >
      </div>
      <div class="hero-content">
        <div class="hero-text">
          <h1 class="hero-title">EXKLUSIVE BÄDERMANUFAKTUR</h1>
          <p class="hero-subtitle">Individuelle Badträume, meisterhaft realisiert</p>
          <p class="hero-description">Maßgeschneiderte Bäder mit höchsten Ansprüchen an Design und Funktion – für ein unvergleichliches Wohlfühlerlebnis</p>
        </div>
      </div>
    </section>

    <!-- Philosophy Section -->
    <section class="philosophy-section">
      <div class="container">
        <div class="philosophy-content">
          <div class="philosophy-text">
            <h2 class="section-title">UNSERE PHILOSOPHIE</h2>
            <p class="philosophy-description">
              Ein Badezimmer ist mehr als nur ein funktionaler Raum – es ist Ihr persönlicher Rückzugsort, 
              ein Ort der Entspannung und Regeneration. Mit über zwei Jahrzehnten Erfahrung schaffen wir 
              Bäder, die Luxus, Komfort und Individualität perfekt vereinen.
            </p>
            <div class="philosophy-stats">
              <div class="stat-item">
                <div class="stat-number">500+</div>
                <div class="stat-label">Realisierte Projekte</div>
              </div>
              <div class="stat-item">
                <div class="stat-number">25+</div>
                <div class="stat-label">Jahre Erfahrung</div>
              </div>
              <div class="stat-item">
                <div class="stat-number">100%</div>
                <div class="stat-label">Zufriedenheitsgarantie</div>
              </div>
            </div>
          </div>
          <div class="philosophy-image">
            <div class="floating-element" :style="{ transform: `translateY(${scrollY * 0.1}px)` }">
              <img src="https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686576cf622e38e88f0236c5.png" alt="Luxus Bad">
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Styles Gallery -->
    <section class="styles-section">
      <div class="container">
        <div class="section-header">
          <h2 class="section-title">BADSTILE FÜR JEDEN GESCHMACK</h2>
          <p class="section-subtitle">Von klassisch elegant bis modern minimalistisch</p>
        </div>

        <div class="styles-gallery">
          <div 
            v-for="(style, index) in badStyles" 
            :key="style.id"
            class="style-card"
            :class="{ active: activeStyle === index }"
            @click="setActiveStyle(index)"
            @mouseenter="playHoverEffect"
          >
            <div class="style-image">
              <img :src="style.image" :alt="style.name">
              <div class="style-overlay">
                <div class="style-info">
                  <h3>{{ style.name }}</h3>
                  <p>{{ style.description }}</p>
                  <div class="style-features">
                    <span v-for="feature in style.features" :key="feature" class="feature-chip">
                      {{ feature }}
                    </span>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="style-details" v-if="badStyles[activeStyle]">
          <div class="details-content">
            <h3>{{ badStyles[activeStyle].name }}</h3>
            <p class="style-full-description">{{ badStyles[activeStyle].fullDescription }}</p>
            
            <div class="characteristics-grid">
              <div class="characteristic-item" v-for="char in badStyles[activeStyle].characteristics" :key="char.label">
                <div class="char-icon">
                  <span class="material-icons">{{ char.icon }}</span>
                </div>
                <div class="char-content">
                  <h4>{{ char.label }}</h4>
                  <p>{{ char.description }}</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Interactive Planning Tool -->
    <section class="planning-section">
      <div class="container">
        <div class="section-header">
          <h2 class="section-title">PLANUNGSTOOL</h2>
          <p class="section-subtitle">Konfigurieren Sie Ihr Traumbad interaktiv</p>
        </div>

        <div class="planning-tool">
          <div class="planning-controls">
            <div class="control-group">
              <label>Raumgröße</label>
              <div class="size-options">
                <button 
                  v-for="size in roomSizes" 
                  :key="size.id"
                  @click="selectedSize = size.id"
                  :class="['size-btn', { active: selectedSize === size.id }]"
                >
                  {{ size.label }}
                </button>
              </div>
            </div>

            <div class="control-group">
              <label>Badewanne</label>
              <div class="options-grid">
                <button 
                  v-for="tub in bathtubs" 
                  :key="tub.id"
                  @click="selectedTub = tub.id"
                  :class="['option-btn', { active: selectedTub === tub.id }]"
                >
                  <img :src="tub.image" :alt="tub.name">
                  <span>{{ tub.name }}</span>
                </button>
              </div>
            </div>

            <div class="control-group">
              <label>Dusche</label>
              <div class="options-grid">
                <button 
                  v-for="shower in showers" 
                  :key="shower.id"
                  @click="selectedShower = shower.id"
                  :class="['option-btn', { active: selectedShower === shower.id }]"
                >
                  <img :src="shower.image" :alt="shower.name">
                  <span>{{ shower.name }}</span>
                </button>
              </div>
            </div>

            <div class="control-group">
              <label>Waschtisch</label>
              <div class="options-grid">
                <button 
                  v-for="basin in basins" 
                  :key="basin.id"
                  @click="selectedBasin = basin.id"
                  :class="['option-btn', { active: selectedBasin === basin.id }]"
                >
                  <img :src="basin.image" :alt="basin.name">
                  <span>{{ basin.name }}</span>
                </button>
              </div>
            </div>
          </div>

          <div class="planning-preview">
            <div class="preview-container">
              <div class="bathroom-mockup">
                <div class="mockup-title">Ihre Badkonfiguration</div>
                <div class="mockup-elements">
                  <div class="element-item">
                    <strong>Raumgröße:</strong> 
                    {{ roomSizes.find(s => s.id === selectedSize)?.label }}
                  </div>
                  <div class="element-item">
                    <strong>Badewanne:</strong> 
                    {{ bathtubs.find(t => t.id === selectedTub)?.name }}
                  </div>
                  <div class="element-item">
                    <strong>Dusche:</strong> 
                    {{ showers.find(s => s.id === selectedShower)?.name }}
                  </div>
                  <div class="element-item">
                    <strong>Waschtisch:</strong> 
                    {{ basins.find(b => b.id === selectedBasin)?.name }}
                  </div>
                </div>
                <div class="estimated-price">
                  <div class="price-label">Geschätzter Preisbereich:</div>
                  <div class="price-range">{{ calculatedPrice }}</div>
                  <div class="price-note">*Unverbindliche Schätzung ohne Montage</div>
                </div>
              </div>
            </div>
            
            <div class="preview-actions">
              <NuxtLink to="/kontakt" class="cta-button primary">BERATUNG VEREINBAREN</NuxtLink>
              <button @click="resetConfiguration" class="cta-button secondary">NEU KONFIGURIEREN</button>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Services Process -->
    <section class="process-section">
      <div class="container">
        <div class="section-header">
          <h2 class="section-title">VON DER IDEE ZUM TRAUMBAD</h2>
          <p class="section-subtitle">Unser bewährter 7-Phasen-Prozess</p>
        </div>

        <div class="process-timeline">
          <div 
            v-for="(phase, index) in processPhases" 
            :key="phase.id"
            class="timeline-phase"
            :class="{ visible: visiblePhases.includes(index) }"
          >
            <div class="phase-marker">
              <div class="phase-number">{{ index + 1 }}</div>
              <div class="phase-icon">
                <span class="material-icons">{{ phase.icon }}</span>
              </div>
            </div>
            
            <div class="phase-content">
              <h3 class="phase-title">{{ phase.title }}</h3>
              <p class="phase-description">{{ phase.description }}</p>
              
              <div class="phase-details">
                <div class="phase-duration">
                  <span class="material-icons">schedule</span>
                  {{ phase.duration }}
                </div>
                <div class="phase-deliverables">
                  <h4>Leistungen:</h4>
                  <ul>
                    <li v-for="deliverable in phase.deliverables" :key="deliverable">
                      {{ deliverable }}
                    </li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Testimonials -->
    <section class="testimonials-section">
      <div class="container">
        <div class="section-header">
          <h2 class="section-title">KUNDENSTIMMEN</h2>
          <p class="section-subtitle">Was unsere Kunden über uns sagen</p>
        </div>

        <div class="testimonials-carousel">
          <div class="testimonials-track" :style="{ transform: `translateX(-${currentTestimonial * 100}%)` }">
            <div 
              v-for="testimonial in testimonials" 
              :key="testimonial.id"
              class="testimonial-card"
            >
              <div class="testimonial-content">
                <div class="testimonial-stars">
                  <span v-for="star in 5" :key="star" class="star">★</span>
                </div>
                <blockquote>{{ testimonial.quote }}</blockquote>
                <div class="testimonial-author">
                  <div class="author-avatar">
                    <img :src="testimonial.avatar" :alt="testimonial.name">
                  </div>
                  <div class="author-info">
                    <h4>{{ testimonial.name }}</h4>
                    <p>{{ testimonial.location }}</p>
                  </div>
                </div>
              </div>
              <div class="testimonial-project">
                <img :src="testimonial.projectImage" :alt="testimonial.projectName">
                <div class="project-overlay">
                  <h4>{{ testimonial.projectName }}</h4>
                  <p>{{ testimonial.projectDescription }}</p>
                </div>
              </div>
            </div>
          </div>

          <div class="carousel-controls">
            <button @click="prevTestimonial" class="control-btn">
              <span class="material-icons">chevron_left</span>
            </button>
            <div class="testimonial-indicators">
              <button 
                v-for="(testimonial, index) in testimonials" 
                :key="index"
                @click="currentTestimonial = index"
                :class="['indicator', { active: currentTestimonial === index }]"
              ></button>
            </div>
            <button @click="nextTestimonial" class="control-btn">
              <span class="material-icons">chevron_right</span>
            </button>
          </div>
        </div>
      </div>
    </section>

    <!-- CTA Section -->
    <section class="cta-section">
      <div class="cta-background">
        <div class="cta-overlay"></div>
      </div>
      <div class="container">
        <div class="cta-content">
          <h2 class="cta-title">BEREIT FÜR IHR TRAUMBAD?</h2>
          <p class="cta-text">Vereinbaren Sie noch heute einen kostenlosen Beratungstermin und lassen Sie sich von unserer Expertise überzeugen.</p>
          <div class="cta-actions">
            <NuxtLink to="/kontakt" class="cta-button primary">KOSTENLOSE BERATUNG</NuxtLink>
            <a href="tel:+4981713868770" class="cta-button secondary">
              <span class="material-icons">phone</span>
              +49 8171 / 3868770
            </a>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
const scrollY = ref(0)
const activeStyle = ref(0)
const selectedSize = ref('medium')
const selectedTub = ref('freistehend')
const selectedShower = ref('walk-in')
const selectedBasin = ref('doppel')
const visiblePhases = ref([])
const currentTestimonial = ref(0)

let testimonialInterval = null

const badStyles = [
  {
    id: 1,
    name: 'Modern Minimalist',
    description: 'Klare Linien, reduzierte Formen',
    fullDescription: 'Der moderne minimalistische Stil zeichnet sich durch klare geometrische Formen, neutrale Farben und hochwertige Materialien aus. Weniger ist mehr – jedes Element hat seinen Zweck und trägt zur harmonischen Gesamtwirkung bei.',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686576cf622e38e88f0236c5.png',
    features: ['Großformat Fliesen', 'LED Beleuchtung', 'Versteckter Stauraum'],
    characteristics: [
      {
        icon: 'architecture',
        label: 'Design',
        description: 'Geometrische Formen und klare Kanten dominieren das Erscheinungsbild'
      },
      {
        icon: 'palette',
        label: 'Farbgebung',
        description: 'Neutrale Töne wie Weiß, Grau und Schwarz schaffen Ruhe'
      },
      {
        icon: 'texture',
        label: 'Materialien',
        description: 'Hochglänzende Oberflächen und moderne Keramik'
      },
      {
        icon: 'lightbulb',
        label: 'Beleuchtung',
        description: 'Indirektes LED-Licht für stimmungsvolle Atmosphäre'
      }
    ]
  },
  {
    id: 2,
    name: 'Luxus Klassik',
    description: 'Zeitlose Eleganz mit edlen Materialien',
    fullDescription: 'Klassische Eleganz trifft auf modernen Komfort. Naturstein, edle Hölzer und goldene Akzente schaffen eine luxuriöse Atmosphäre, die zeitlos schön bleibt.',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png',
    features: ['Marmor', 'Gold Armaturen', 'Freistehende Wanne'],
    characteristics: [
      {
        icon: 'diamond',
        label: 'Luxus',
        description: 'Edle Materialien wie Marmor und Gold schaffen Exklusivität'
      },
      {
        icon: 'history',
        label: 'Zeitlosigkeit',
        description: 'Klassische Formen, die niemals aus der Mode kommen'
      },
      {
        icon: 'star',
        label: 'Qualität',
        description: 'Höchste Handwerkskunst und Premium-Materialien'
      },
      {
        icon: 'spa',
        label: 'Komfort',
        description: 'Wellness-Feeling durch durchdachte Gestaltung'
      }
    ]
  },
  {
    id: 3,
    name: 'Industrial Chic',
    description: 'Rohe Materialien, urbaner Style',
    fullDescription: 'Industrial Chic kombiniert rohe Materialien wie Beton und Metall mit warmen Holzakzenten. Der urbane Look ist perfekt für alle, die das Außergewöhnliche lieben.',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png',
    features: ['Betonoptik', 'Schwarze Armaturen', 'Freiliegende Rohre'],
    characteristics: [
      {
        icon: 'construction',
        label: 'Materialien',
        description: 'Beton, Stahl und Holz in perfekter Harmonie'
      },
      {
        icon: 'color_lens',
        label: 'Farben',
        description: 'Erdige Töne mit markanten schwarzen Akzenten'
      },
      {
        icon: 'build',
        label: 'Details',
        description: 'Funktionale Elemente als Gestaltungsmittel'
      },
      {
        icon: 'trending_up',
        label: 'Trend',
        description: 'Urbaner Style für moderne Individualisten'
      }
    ]
  }
]

const roomSizes = [
  { id: 'small', label: 'Gäste-WC (bis 4m²)', multiplier: 0.6 },
  { id: 'medium', label: 'Familienbad (4-8m²)', multiplier: 1.0 },
  { id: 'large', label: 'Master Suite (8-15m²)', multiplier: 1.8 },
  { id: 'luxury', label: 'Spa-Bad (ab 15m²)', multiplier: 2.5 }
]

const bathtubs = [
  { id: 'freistehend', name: 'Freistehend', image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686576cf622e38e88f0236c5.png', price: 3500 },
  { id: 'einbau', name: 'Einbau-Wanne', image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png', price: 2000 },
  { id: 'eckwanne', name: 'Eck-Wanne', image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png', price: 2500 },
  { id: 'keine', name: 'Ohne Wanne', image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b70b0803723582ed6.png', price: 0 }
]

const showers = [
  { id: 'walk-in', name: 'Walk-In Dusche', image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686576cf622e38e88f0236c5.png', price: 2800 },
  { id: 'kabine', name: 'Duschkabine', image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png', price: 1500 },
  { id: 'nische', name: 'Nischenlösung', image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png', price: 2200 }
]

const basins = [
  { id: 'doppel', name: 'Doppel-Waschtisch', image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686576cf622e38e88f0236c5.png', price: 3200 },
  { id: 'einzel', name: 'Einzel-Waschtisch', image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png', price: 1800 },
  { id: 'aufsatz', name: 'Aufsatz-Waschbecken', image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png', price: 2400 }
]

const processPhases = [
  {
    id: 1,
    title: 'Erstberatung & Bestandsaufnahme',
    description: 'Persönliche Beratung vor Ort zur Erfassung Ihrer Wünsche und der räumlichen Gegebenheiten.',
    icon: 'home',
    duration: '2-3 Stunden',
    deliverables: [
      'Ausführliche Bedarfsanalyse',
      'Aufmaß der bestehenden Räumlichkeiten',
      'Erste Ideensammlung und Inspiration',
      'Grobe Budgetschätzung'
    ]
  },
  {
    id: 2,
    title: '3D-Planung & Design',
    description: 'Entwicklung eines individuellen Badkonzepts mit fotorealistischer 3D-Visualisierung.',
    icon: 'view_in_ar',
    duration: '1-2 Wochen',
    deliverables: [
      'Detaillierte 3D-Visualisierung',
      'Technische Planungsunterlagen',
      'Materialvorschläge mit Mustern',
      'Beleuchtungskonzept'
    ]
  },
  {
    id: 3,
    title: 'Angebot & Vertragsabschluss',
    description: 'Transparente Kostenaufstellung und Vertragsabschluss mit Festpreisgarantie.',
    icon: 'description',
    duration: '3-5 Tage',
    deliverables: [
      'Detailliertes Festpreisangebot',
      'Leistungsverzeichnis',
      'Zeitplan für die Umsetzung',
      'Vertragsunterlagen'
    ]
  },
  {
    id: 4,
    title: 'Vorbereitung & Materialbeschaffung',
    description: 'Bestellung der Materialien und Koordination aller beteiligten Gewerke.',
    icon: 'inventory',
    duration: '2-4 Wochen',
    deliverables: [
      'Materialbestellung und -koordination',
      'Terminplanung mit allen Gewerken',
      'Vorbereitung der Baustelle',
      'Qualitätskontrolle der Materialien'
    ]
  },
  {
    id: 5,
    title: 'Demontage & Rohbauarbeiten',
    description: 'Fachgerechte Demontage der alten Ausstattung und Vorbereitung für die Neuinstallation.',
    icon: 'construction',
    duration: '3-5 Tage',
    deliverables: [
      'Vollständige Demontage',
      'Entsorgung des Altmaterials',
      'Rohbauarbeiten und Leitungsverlegung',
      'Grundierung und Vorbereitung'
    ]
  },
  {
    id: 6,
    title: 'Installation & Verlegung',
    description: 'Professionelle Umsetzung aller Arbeiten durch unsere Fachbetriebe.',
    icon: 'build',
    duration: '1-2 Wochen',
    deliverables: [
      'Fliesenlegerarbeiten',
      'Sanitärinstallation',
      'Elektroarbeiten und Beleuchtung',
      'Malerarbeiten'
    ]
  },
  {
    id: 7,
    title: 'Abschluss & Übergabe',
    description: 'Finale Abnahme, Einweisung und Übergabe Ihres neuen Traumbads.',
    icon: 'done_all',
    duration: '1 Tag',
    deliverables: [
      'Gründliche Endreinigung',
      'Gemeinsame Abnahme',
      'Einweisung in alle Funktionen',
      'Übergabe der Garantieunterlagen'
    ]
  }
]

const testimonials = [
  {
    id: 1,
    quote: 'Das Team hat unsere Vorstellungen perfekt umgesetzt. Die Qualität der Arbeiten und die Beratung waren außergewöhnlich.',
    name: 'Familie Müller',
    location: 'München',
    avatar: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686576cf622e38e88f0236c5.png',
    projectName: 'Master Suite Renovation',
    projectDescription: 'Luxuriöse Badgestaltung mit freistehender Wanne',
    projectImage: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png'
  },
  {
    id: 2,
    quote: 'Von der Planung bis zur Umsetzung war alles perfekt organisiert. Unser Badezimmer ist jetzt unser Lieblingsraum!',
    name: 'Dr. Schmidt',
    location: 'Düsseldorf',
    avatar: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png',
    projectName: 'Wellness-Oase',
    projectDescription: 'Spa-Badezimmer mit begehbarer Dusche',
    projectImage: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b70b0803723582ed6.png'
  },
  {
    id: 3,
    quote: 'Herausragende Handwerkskunst und ein Service, der keine Wünsche offen lässt. Absolut empfehlenswert!',
    name: 'Familie Weber',
    location: 'Starnberg',
    avatar: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b097a8069ca3ac95a.png',
    projectName: 'Familienbad Deluxe',
    projectDescription: 'Funktionales Design für die ganze Familie',
    projectImage: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686576cf622e38e88f0236c5.png'
  }
]

const calculatedPrice = computed(() => {
  const sizeMultiplier = roomSizes.find(s => s.id === selectedSize.value)?.multiplier || 1
  const tubPrice = bathtubs.find(t => t.id === selectedTub.value)?.price || 0
  const showerPrice = showers.find(s => s.id === selectedShower.value)?.price || 0
  const basinPrice = basins.find(b => b.id === selectedBasin.value)?.price || 0
  
  const basePrice = (tubPrice + showerPrice + basinPrice) * sizeMultiplier
  const minPrice = Math.round(basePrice * 0.8)
  const maxPrice = Math.round(basePrice * 1.3)
  
  return `${minPrice.toLocaleString('de-DE')} - ${maxPrice.toLocaleString('de-DE')} €`
})

const setActiveStyle = (index) => {
  activeStyle.value = index
}

const playHoverEffect = () => {
  // Placeholder for hover sound effect
  console.log('Style hover effect')
}

const resetConfiguration = () => {
  selectedSize.value = 'medium'
  selectedTub.value = 'freistehend'
  selectedShower.value = 'walk-in'
  selectedBasin.value = 'doppel'
}

const prevTestimonial = () => {
  currentTestimonial.value = currentTestimonial.value === 0 ? testimonials.length - 1 : currentTestimonial.value - 1
}

const nextTestimonial = () => {
  currentTestimonial.value = (currentTestimonial.value + 1) % testimonials.length
}

const handleScroll = () => {
  scrollY.value = window.scrollY
}

onMounted(() => {
  window.addEventListener('scroll', handleScroll)
  
  // Auto-cycle testimonials
  testimonialInterval = setInterval(() => {
    nextTestimonial()
  }, 6000)
  
  // Intersection Observer for phases
  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        const index = parseInt(entry.target.dataset.index)
        if (!visiblePhases.value.includes(index)) {
          setTimeout(() => {
            visiblePhases.value.push(index)
          }, index * 200)
        }
      }
    })
  }, { threshold: 0.3 })
  
  nextTick(() => {
    document.querySelectorAll('.timeline-phase').forEach((item, index) => {
      item.dataset.index = index
      observer.observe(item)
    })
  })
})

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll)
  if (testimonialInterval) {
    clearInterval(testimonialInterval)
  }
})
</script>

<style scoped>
.baeder-page {
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

/* Philosophy Section */
.philosophy-section {
  padding: 6rem 0;
  background: linear-gradient(135deg, #0a0a0a 0%, #1a1a1a 100%);
}

.philosophy-content {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 4rem;
  align-items: center;
}

.philosophy-description {
  font-size: 1.2rem;
  line-height: 1.8;
  color: #ccc;
  margin-bottom: 3rem;
}

.philosophy-stats {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 2rem;
}

.stat-item {
  text-align: center;
  padding: 2rem 1rem;
  background: rgba(255, 255, 255, 0.05);
  border-radius: 15px;
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.1);
  transition: all 0.3s ease;
}

.stat-item:hover {
  transform: translateY(-5px);
  background: rgba(255, 255, 255, 0.08);
}

.stat-number {
  font-size: 2.5rem;
  font-weight: 600;
  color: #a47148;
  margin-bottom: 0.5rem;
}

.stat-label {
  font-size: 1rem;
  color: #ccc;
}

.philosophy-image {
  position: relative;
  height: 500px;
}

.floating-element {
  position: relative;
  width: 100%;
  height: 100%;
  border-radius: 20px;
  overflow: hidden;
  box-shadow: 0 20px 40px rgba(164, 113, 72, 0.3);
}

.floating-element img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

/* Styles Section */
.styles-section {
  padding: 6rem 0;
}

.styles-gallery {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
  gap: 2rem;
  margin-bottom: 3rem;
}

.style-card {
  border-radius: 20px;
  overflow: hidden;
  cursor: pointer;
  transition: all 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  transform-origin: center;
}

.style-card:hover,
.style-card.active {
  transform: scale(1.05);
  box-shadow: 0 25px 50px rgba(164, 113, 72, 0.4);
}

.style-image {
  position: relative;
  height: 300px;
  overflow: hidden;
}

.style-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.6s ease;
}

.style-card:hover .style-image img {
  transform: scale(1.1);
}

.style-overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(45deg, rgba(0,0,0,0.8), rgba(164, 113, 72, 0.4));
  display: flex;
  align-items: end;
  padding: 2rem;
  opacity: 0;
  transition: opacity 0.5s ease;
}

.style-card:hover .style-overlay,
.style-card.active .style-overlay {
  opacity: 1;
}

.style-info h3 {
  font-size: 1.5rem;
  font-weight: 400;
  margin-bottom: 0.5rem;
  color: #FAFAF8;
}

.style-info p {
  color: #ccc;
  margin-bottom: 1rem;
}

.style-features {
  display: flex;
  gap: 0.5rem;
  flex-wrap: wrap;
}

.feature-chip {
  padding: 0.25rem 0.75rem;
  background: rgba(164, 113, 72, 0.3);
  color: #a47148;
  font-size: 0.875rem;
  border-radius: 15px;
  border: 1px solid rgba(164, 113, 72, 0.5);
}

.style-details {
  background: rgba(255, 255, 255, 0.05);
  border-radius: 20px;
  padding: 3rem;
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.details-content h3 {
  font-size: 2rem;
  font-weight: 400;
  margin-bottom: 1rem;
  color: #FAFAF8;
}

.style-full-description {
  font-size: 1.1rem;
  line-height: 1.6;
  color: #ccc;
  margin-bottom: 2rem;
}

.characteristics-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 2rem;
}

.characteristic-item {
  display: flex;
  gap: 1rem;
  padding: 1.5rem;
  background: rgba(255, 255, 255, 0.05);
  border-radius: 15px;
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.char-icon {
  width: 50px;
  height: 50px;
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #000;
  font-size: 1.5rem;
  flex-shrink: 0;
}

.char-content h4 {
  font-size: 1.1rem;
  font-weight: 400;
  margin-bottom: 0.5rem;
  color: #FAFAF8;
}

.char-content p {
  font-size: 0.9rem;
  color: #ccc;
  line-height: 1.4;
}

/* Planning Section */
.planning-section {
  padding: 6rem 0;
  background: linear-gradient(135deg, #1a1a1a 0%, #0a0a0a 100%);
}

.planning-tool {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 4rem;
  max-width: 1200px;
  margin: 0 auto;
}

.planning-controls {
  background: rgba(255, 255, 255, 0.05);
  border-radius: 20px;
  padding: 2rem;
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.control-group {
  margin-bottom: 2rem;
}

.control-group label {
  display: block;
  font-size: 1.2rem;
  font-weight: 400;
  margin-bottom: 1rem;
  color: #FAFAF8;
}

.size-options {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 1rem;
}

.size-btn,
.option-btn {
  padding: 1rem;
  background: rgba(255, 255, 255, 0.05);
  border: 2px solid rgba(255, 255, 255, 0.1);
  color: #FAFAF8;
  border-radius: 10px;
  cursor: pointer;
  transition: all 0.3s ease;
  font-size: 0.9rem;
}

.size-btn:hover,
.option-btn:hover {
  background: rgba(255, 255, 255, 0.08);
  border-color: rgba(164, 113, 72, 0.5);
}

.size-btn.active,
.option-btn.active {
  background: rgba(164, 113, 72, 0.2);
  border-color: #a47148;
  color: #a47148;
}

.options-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 1rem;
}

.option-btn {
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  padding: 1rem 0.5rem;
}

.option-btn img {
  width: 60px;
  height: 40px;
  object-fit: cover;
  border-radius: 5px;
  margin-bottom: 0.5rem;
}

.planning-preview {
  background: rgba(255, 255, 255, 0.05);
  border-radius: 20px;
  padding: 2rem;
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.1);
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

.bathroom-mockup {
  flex: 1;
}

.mockup-title {
  font-size: 1.5rem;
  font-weight: 400;
  margin-bottom: 2rem;
  color: #FAFAF8;
  text-align: center;
}

.mockup-elements {
  margin-bottom: 2rem;
}

.element-item {
  display: flex;
  justify-content: space-between;
  padding: 1rem 0;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
  color: #ccc;
}

.element-item strong {
  color: #FAFAF8;
}

.estimated-price {
  background: rgba(164, 113, 72, 0.1);
  border: 1px solid rgba(164, 113, 72, 0.3);
  border-radius: 15px;
  padding: 1.5rem;
  text-align: center;
  margin-bottom: 2rem;
}

.price-label {
  font-size: 1rem;
  color: #ccc;
  margin-bottom: 0.5rem;
}

.price-range {
  font-size: 1.8rem;
  font-weight: 600;
  color: #a47148;
  margin-bottom: 0.5rem;
}

.price-note {
  font-size: 0.8rem;
  color: #999;
}

.preview-actions {
  display: flex;
  gap: 1rem;
}

/* Process Section */
.process-section {
  padding: 6rem 0;
}

.process-timeline {
  max-width: 1000px;
  margin: 0 auto;
}

.timeline-phase {
  display: flex;
  gap: 3rem;
  margin-bottom: 4rem;
  opacity: 0;
  transform: translateX(-50px);
  transition: all 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

.timeline-phase.visible {
  opacity: 1;
  transform: translateX(0);
}

.phase-marker {
  flex: 0 0 120px;
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
}

.phase-number {
  width: 40px;
  height: 40px;
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 600;
  color: #000;
  margin-bottom: 1rem;
}

.phase-icon {
  width: 60px;
  height: 60px;
  background: rgba(255, 255, 255, 0.1);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #a47148;
  font-size: 1.5rem;
  border: 2px solid rgba(164, 113, 72, 0.3);
}

.phase-content {
  flex: 1;
  background: rgba(255, 255, 255, 0.05);
  border-radius: 20px;
  padding: 2rem;
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.phase-title {
  font-size: 1.5rem;
  font-weight: 400;
  margin-bottom: 1rem;
  color: #FAFAF8;
}

.phase-description {
  font-size: 1.1rem;
  line-height: 1.6;
  color: #ccc;
  margin-bottom: 2rem;
}

.phase-details {
  display: grid;
  grid-template-columns: auto 1fr;
  gap: 2rem;
}

.phase-duration {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  color: #a47148;
  font-weight: 500;
  white-space: nowrap;
}

.phase-deliverables h4 {
  font-size: 1.1rem;
  color: #FAFAF8;
  margin-bottom: 1rem;
}

.phase-deliverables ul {
  list-style: none;
  padding: 0;
}

.phase-deliverables li {
  padding: 0.5rem 0;
  color: #ccc;
  position: relative;
  padding-left: 1.5rem;
}

.phase-deliverables li:before {
  content: '✓';
  position: absolute;
  left: 0;
  color: #a47148;
  font-weight: bold;
}

/* Testimonials Section */
.testimonials-section {
  padding: 6rem 0;
  background: linear-gradient(135deg, #0a0a0a 0%, #1a1a1a 100%);
}

.testimonials-carousel {
  position: relative;
  overflow: hidden;
  border-radius: 20px;
}

.testimonials-track {
  display: flex;
  transition: transform 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

.testimonial-card {
  min-width: 100%;
  display: grid;
  grid-template-columns: 1fr 1fr;
  background: rgba(255, 255, 255, 0.05);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.testimonial-content {
  padding: 3rem;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.testimonial-stars {
  display: flex;
  gap: 0.25rem;
  margin-bottom: 2rem;
}

.star {
  color: #a47148;
  font-size: 1.5rem;
}

.testimonial-content blockquote {
  font-size: 1.3rem;
  line-height: 1.6;
  color: #FAFAF8;
  font-style: italic;
  margin-bottom: 2rem;
  quotes: '„' '"';
}

.testimonial-content blockquote:before {
  content: open-quote;
}

.testimonial-content blockquote:after {
  content: close-quote;
}

.testimonial-author {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.author-avatar {
  width: 60px;
  height: 60px;
  border-radius: 50%;
  overflow: hidden;
  border: 2px solid #a47148;
}

.author-avatar img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.author-info h4 {
  font-size: 1.1rem;
  font-weight: 400;
  color: #FAFAF8;
  margin-bottom: 0.25rem;
}

.author-info p {
  color: #999;
  font-size: 0.9rem;
}

.testimonial-project {
  position: relative;
  overflow: hidden;
}

.testimonial-project img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.project-overlay {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  background: linear-gradient(transparent, rgba(0,0,0,0.8));
  padding: 2rem;
  color: #FAFAF8;
}

.project-overlay h4 {
  font-size: 1.2rem;
  font-weight: 400;
  margin-bottom: 0.5rem;
}

.project-overlay p {
  color: #ccc;
  font-size: 0.9rem;
}

.carousel-controls {
  position: absolute;
  bottom: 2rem;
  left: 50%;
  transform: translateX(-50%);
  display: flex;
  align-items: center;
  gap: 2rem;
  background: rgba(0, 0, 0, 0.7);
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

.testimonial-indicators {
  display: flex;
  gap: 0.5rem;
}

.testimonial-indicators .indicator {
  width: 12px;
  height: 12px;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.3);
  border: none;
  cursor: pointer;
  transition: all 0.3s ease;
}

.testimonial-indicators .indicator.active {
  background: #a47148;
  transform: scale(1.2);
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
  background: url('https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686576cf622e38e88f0236c5.png') center/cover;
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
.cta-button {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
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

.cta-button:hover {
  transform: translateY(-3px);
}

.cta-button.primary:hover {
  box-shadow: 0 15px 30px rgba(164, 113, 72, 0.4);
}

.cta-button.secondary:hover {
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

/* Responsive Design */
@media (max-width: 1024px) {
  .philosophy-content,
  .planning-tool {
    grid-template-columns: 1fr;
    gap: 3rem;
  }
  
  .styles-gallery {
    grid-template-columns: 1fr;
  }
  
  .testimonial-card {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 768px) {
  .hero-title {
    font-size: 2.5rem;
  }
  
  .philosophy-stats {
    grid-template-columns: 1fr;
    gap: 1rem;
  }
  
  .characteristics-grid {
    grid-template-columns: 1fr;
  }
  
  .size-options,
  .options-grid {
    grid-template-columns: 1fr;
  }
  
  .phase-details {
    grid-template-columns: 1fr;
    gap: 1rem;
  }
  
  .timeline-phase {
    gap: 2rem;
  }
  
  .preview-actions {
    flex-direction: column;
  }
  
  .cta-title {
    font-size: 2.5rem;
  }
  
  .cta-actions {
    flex-direction: column;
    align-items: center;
  }
}
</style>