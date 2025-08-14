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
          <a href="/kontakt" class="cta-btn secondary">
            BERATUNG VEREINBAREN
          </a>
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

        <div class="premium-advantages">
          <div 
            v-for="(advantage, index) in advantages" 
            :key="advantage.id"
            class="premium-advantage-card"
            :style="{ animationDelay: `${index * 0.1}s` }"
            :class="{ 
              'expanded': expandedAdvantages.includes(advantage.id)
            }"
            @mouseenter="handleCardHover(advantage.id)"
            @mouseleave="handleCardLeave(advantage.id)"
          >
            <div class="card-glow"></div>
            <div class="card-shine"></div>
            
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
            
            <transition name="advantage-expand">
              <div v-if="expandedAdvantages.includes(advantage.id)" class="premium-advantage-content">
                <div class="content-divider"></div>
                <p class="advantage-description">{{ advantage.description }}</p>
              </div>
            </transition>
          </div>
        </div>

        <div class="luxury-features-showcase">
          <div class="showcase-header">
            <div class="header-particle-system">
              <div v-for="n in 20" :key="n" class="floating-particle" 
                   :style="{ 
                     animationDelay: `${n * 0.3}s`,
                     left: `${Math.random() * 100}%`,
                     animationDuration: `${3 + Math.random() * 4}s`
                   }"></div>
            </div>
            <h3 class="showcase-title">
              <span class="title-word" v-for="(word, index) in showcaseTitleWords" :key="word" 
                    :style="{ animationDelay: `${index * 0.2}s` }">{{ word }}</span>
            </h3>
            <p class="showcase-subtitle">Außergewöhnlicher Service für außergewöhnliche Kunden</p>
            <div class="showcase-divider">
              <div class="divider-line"></div>
              <div class="divider-glow"></div>
            </div>
          </div>
          
          <div class="features-luxury-grid" ref="featuresGrid">
            <div 
              v-for="(feature, index) in specialFeatures" 
              :key="feature.id"
              class="luxury-feature-card"
              :class="{ 'hovered': hoveredFeature === feature.id, 'visible': visibleFeatures.includes(index) }"
              :style="{ 
                animationDelay: `${index * 0.3}s`,
                '--card-index': index
              }"
              @mouseenter="handleFeatureHover(feature.id, index)"
              @mouseleave="handleFeatureLeave(feature.id)"
              @click="triggerFeatureExplosion(feature.id)"
            >
              <div class="luxury-feature-background">
                <div class="feature-gradient" :style="{ background: feature.gradient }"></div>
                <div class="feature-pattern"></div>
                <div class="morphing-blob blob-1"></div>
                <div class="morphing-blob blob-2"></div>
                <div class="energy-waves">
                  <div v-for="n in 3" :key="n" class="wave" :style="{ animationDelay: `${n * 0.5}s` }"></div>
                </div>
              </div>

              <div class="card-particles">
                <div v-for="n in 15" :key="n" class="particle" 
                     :style="{ 
                       animationDelay: `${n * 0.1}s`,
                       '--start-pos': `${Math.random() * 360}deg`,
                       '--end-pos': `${Math.random() * 360}deg`
                     }"></div>
              </div>
              
              <div class="luxury-feature-content">
                <div class="luxury-feature-icon-3d">
                  <div class="icon-hologram">
                    <div class="hologram-layer layer-1"></div>
                    <div class="hologram-layer layer-2"></div>
                    <div class="hologram-layer layer-3"></div>
                  </div>
                  <div class="icon-glow-ring"></div>
                  <div class="icon-container">
                    <span class="material-icons feature-icon">{{ feature.icon }}</span>
                    <div class="icon-reflection"></div>
                  </div>
                  <div class="magnetic-field">
                    <div v-for="n in 5" :key="n" class="field-line" 
                         :style="{ transform: `rotate(${n * 72}deg)` }"></div>
                  </div>
                </div>

                <h4 class="luxury-feature-title">
                  <span v-for="(char, charIndex) in feature.title.split('')" :key="charIndex" 
                        class="title-char" 
                        :style="{ animationDelay: `${charIndex * 0.05}s` }">
                    {{ char === ' ' ? '&nbsp;' : char }}
                  </span>
                </h4>

                <p class="luxury-feature-description">
                  {{ feature.description }}
                </p>

                <div class="quantum-highlight">
                  <div class="quantum-particles">
                    <div v-for="n in 8" :key="n" class="quantum-particle" 
                         :style="{ animationDelay: `${n * 0.2}s` }"></div>
                  </div>
                  <div class="energy-beam"></div>
                </div>
              </div>

              <div class="interaction-ripples">
                <div class="ripple" v-for="n in rippleCount" :key="n"></div>
              </div>

              <div class="corner-accents">
                <div class="corner top-left"></div>
                <div class="corner top-right"></div>
                <div class="corner bottom-left"></div>
                <div class="corner bottom-right"></div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section class="faq-section">
      <div class="container">
        <!-- Enhanced Section Header -->
        <div class="section-header">
          <div class="header-decoration">
            <div class="decoration-line left"></div>
            <span class="section-badge premium">
              <span class="material-icons">help_center</span>
              HÄUFIGE FRAGEN
            </span>
            <div class="decoration-line right"></div>
          </div>
          <h2 class="section-title">
            <span class="title-gradient">FRAGEN & ANTWORTEN</span>
          </h2>
          <p class="section-subtitle">Alles was Sie über unsere Premium Services wissen müssen</p>
        </div>

        <!-- Search Bar -->
        <div class="faq-search-container">
          <div class="search-wrapper">
            <div class="search-icon">
              <span class="material-icons">search</span>
            </div>
            <input 
              v-model="searchQuery"
              type="text" 
              placeholder="Durchsuchen Sie unsere FAQs..."
              class="search-input"
              @input="handleSearch"
            />
            <div v-if="searchQuery" class="search-clear" @click="clearSearch">
              <span class="material-icons">close</span>
            </div>
          </div>
          <div v-if="searchQuery" class="search-results-info">
            {{ filteredFaqs.length }} Ergebnis{{ filteredFaqs.length !== 1 ? 'se' : '' }} für "{{ searchQuery }}"
          </div>
        </div>

        <!-- Luxury Category Filters -->
        <div class="faq-filter-container">
          <div class="filter-background-glow"></div>

          <div class="category-filters">
            <button 
              v-for="category in faqCategories" 
              :key="category.id"
              @click="setActiveFaqCategory(category.id)"
              :class="['luxury-category-btn', { 
                active: activeFaqCategory === category.id,
                'has-new': category.hasNew
              }]"
            >
              <div class="btn-background">
                <div class="bg-gradient"></div>
                <div class="bg-shine"></div>
              </div>
              
              <div class="btn-content">
                <div class="category-icon-wrapper">
                  <div class="icon-orbit"></div>
                  <span class="material-icons category-icon">{{ category.icon }}</span>
                </div>
                
                <div class="category-info">
                  <span class="category-name">{{ category.name }}</span>
                </div>
              </div>
              
              <div class="btn-particles">
                <div v-for="n in 6" :key="n" class="filter-particle"
                     :style="{ animationDelay: `${n * 0.2}s` }"></div>
              </div>
            </button>
          </div>
        </div>

        <!-- Enhanced FAQ List -->
        <div class="faq-container">
          <div class="faq-count-indicator">
            <span class="count-number">{{ filteredFaqs.length }}</span>
            <span class="count-label">{{ searchQuery ? 'Suchergebnisse' : 'Fragen in dieser Kategorie' }}</span>
          </div>
          
          <div class="luxury-faq-list">
            <transition-group name="faq-slide" tag="div">
              <div 
                v-for="(faq, index) in filteredFaqs" 
                :key="`${activeFaqCategory}-${faq.id}`"
                class="luxury-faq-item"
                :style="{ '--item-index': index }"
                :class="{ expanded: expandedFaqs.includes(faq.id) }"
              >
                <!-- FAQ Question Button -->
                <button 
                  @click="toggleFaq(faq.id)"
                  class="luxury-faq-question"
                  :class="{ active: expandedFaqs.includes(faq.id) }"
                >
                  <div class="question-background">
                    <div class="bg-pattern"></div>
                    <div class="bg-glow"></div>
                  </div>
                  
                  <div class="question-content">
                    <div class="question-number">
                      {{ String(index + 1).padStart(2, '0') }}
                    </div>
                    
                    <div class="question-text-wrapper">
                      <h3 class="question-text" v-html="highlightSearchTerm(faq.question)"></h3>
                      <div v-if="faq.tags" class="question-tags">
                        <span v-for="tag in faq.tags" :key="tag" class="tag">{{ tag }}</span>
                      </div>
                    </div>
                    
                    <div class="question-toggle-wrapper">
                      <div class="toggle-bg"></div>
                      <span class="material-icons toggle-icon">
                        {{ expandedFaqs.includes(faq.id) ? 'expand_less' : 'expand_more' }}
                      </span>
                    </div>
                  </div>
                  
                  <div class="question-hover-effects">
                    <div class="hover-glow"></div>
                    <div class="hover-border"></div>
                  </div>
                </button>
                
                <!-- FAQ Answer -->
                <transition name="answer-expand">
                  <div v-if="expandedFaqs.includes(faq.id)" class="luxury-faq-answer">
                    <div class="answer-background">
                      <div class="answer-pattern"></div>
                    </div>
                    
                    <div class="answer-content">
                      <div class="answer-decorator">
                        <div class="decorator-line"></div>
                        <span class="material-icons">lightbulb</span>
                        <div class="decorator-line"></div>
                      </div>
                      
                      <div class="answer-text" v-html="highlightSearchTerm(faq.answer)"></div>
                      
                      <div v-if="faq.relatedLinks" class="related-links">
                        <h5>Verwandte Informationen:</h5>
                        <div class="links-grid">
                          <a v-for="link in faq.relatedLinks" :key="link.title" 
                             :href="link.url" class="related-link">
                            <span class="material-icons">{{ link.icon }}</span>
                            {{ link.title }}
                          </a>
                        </div>
                      </div>
                      
                      <div class="answer-meta">
                        <div class="helpful-question">
                          <span>War diese Antwort hilfreich?</span>
                          <div class="helpful-buttons">
                            <button @click="markHelpful(faq.id, true)" class="helpful-btn positive">
                              <span class="material-icons">thumb_up</span>
                              Ja
                            </button>
                            <button @click="markHelpful(faq.id, false)" class="helpful-btn negative">
                              <span class="material-icons">thumb_down</span>
                              Nein
                            </button>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </transition>
              </div>
            </transition-group>
          </div>
          
          <!-- No Results State -->
          <div v-if="filteredFaqs.length === 0" class="no-results">
            <div class="no-results-icon">
              <span class="material-icons">{{ searchQuery ? 'search_off' : 'help_outline' }}</span>
            </div>
            <h3>{{ searchQuery ? 'Keine Suchergebnisse' : 'Keine Fragen gefunden' }}</h3>
            <p>
              {{ searchQuery 
                ? `Keine Fragen gefunden für "${searchQuery}". Versuchen Sie andere Suchbegriffe.`
                : 'Für diese Kategorie sind derzeit keine Fragen verfügbar.'
              }}
            </p>
            <div class="no-results-actions">
              <button v-if="searchQuery" @click="clearSearch" class="action-btn">
                <span class="material-icons">clear</span>
                Suche zurücksetzen
              </button>
              <button v-else @click="setActiveFaqCategory('allgemein')" class="action-btn">
                <span class="material-icons">arrow_back</span>
                Zurück zu Allgemein
              </button>
            </div>
          </div>
        </div>

        <!-- Enhanced Quick Actions -->
        <div class="faq-quick-actions">
          <div class="quick-action-card">
            <div class="action-icon">
              <span class="material-icons">contact_support</span>
            </div>
            <div class="action-content">
              <h4>Haben Sie weitere Fragen?</h4>
              <p>Unser Expertenteam steht Ihnen gerne zur Verfügung</p>
            </div>
            <a href="/kontakt" class="action-btn">
              KONTAKT AUFNEHMEN
              <span class="material-icons">arrow_forward</span>
            </a>
          </div>
          
          <div class="quick-action-card">
            <div class="action-icon">
              <span class="material-icons">calendar_today</span>
            </div>
            <div class="action-content">
              <h4>Persönliche Beratung</h4>
              <p>Vereinbaren Sie einen Termin in unserem Showroom</p>
            </div>
            <a href="/kontakt" class="action-btn">
              TERMIN BUCHEN
              <span class="material-icons">event</span>
            </a>
          </div>
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
              <a href="/kontakt" class="card-btn">
                TERMIN VEREINBAREN
                <span class="material-icons">calendar_today</span>
              </a>
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
              <a href="/kontakt" class="card-btn">
                TERMIN VEREINBAREN
                <span class="material-icons">calendar_today</span>
              </a>
            </div>
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
              <a href="/kontakt" class="modal-btn primary full-width">
                <span class="material-icons">phone</span>
                BERATUNG ANFRAGEN
              </a>
            </div>
          </div>
        </div>
      </div>
    </transition>
  </div>
</template>

<script setup>

import { ref, computed, onMounted, nextTick } from 'vue'
// State Management
const searchQuery = ref('')
const scrollY = ref(0)
const timelineProgress = ref(0)
const visibleSteps = ref([])
const activeFaqCategory = ref('allgemein')
const expandedFaqs = ref([])
const expandedAdvantages = ref([])
const selectedService = ref(null)
const hoveredCards = ref(new Set())

// Features Showcase States
const hoveredFeature = ref(null)
const visibleFeatures = ref([])
const rippleCount = ref(0)
const featuresGrid = ref(null)

// Hero Stats
const heroStats = [
  { id: 1, value: 650, label: 'Steinsorten' },
  { id: 2, value: 80000, label: 'm² Lagerfläche' },
  { id: 3, value: 100, label: '% auf Lager' }
]

// Core Services
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

// Advantages
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
  }
]

// Enhanced Special Features
const specialFeatures = [
  {
    id: 1,
    icon: 'accessible',
    title: 'Barrierefrei',
    description: 'Unsere Ausstellung ist selbstverständlich behindertengerecht ausgestattet',
    gradient: 'linear-gradient(135deg, rgba(139, 69, 19, 0.9) 0%, rgba(160, 82, 45, 0.8) 50%, rgba(210, 180, 140, 0.7) 100%)'
  },
  {
    id: 2,
    icon: 'child_care',
    title: 'Spielecke',
    description: 'Für Ihr Wohlbefinden bieten wir Ihren Kindern eine Spielecke',
    gradient: 'linear-gradient(135deg, rgba(139, 69, 19, 0.9) 0%, rgba(160, 82, 45, 0.8) 50%, rgba(210, 180, 140, 0.7) 100%)'
  },
  {
    id: 3,
    icon: 'local_taxi',
    title: 'Abholservice',
    description: 'Auf Wunsch Abholung vom Flughafen Düsseldorf/München oder Hauptbahnhöfen',
    gradient: 'linear-gradient(135deg, rgba(139, 69, 19, 0.9) 0%, rgba(160, 82, 45, 0.8) 50%, rgba(210, 180, 140, 0.7) 100%)'
  }
]

// Showcase Title Words
const showcaseTitleWords = ['PREMIUM', 'FEATURES']

// Enhanced FAQ Categories with detailed descriptions
const faqCategories = [
  { 
    id: 'allgemein', 
    name: 'Allgemein', 
    icon: 'help', 
    description: 'Grundlegende Informationen über die Architektur Group und unsere Services',
    hasNew: false
  },
  { 
    id: 'material', 
    name: 'Material & Oberflächen', 
    icon: 'layers', 
    description: 'Alles über Natursteine, Feinsteinzeug und Oberflächenbehandlungen',
    hasNew: true
  },
  { 
    id: 'verlegung', 
    name: 'Verlegung & Montage', 
    icon: 'construction', 
    description: 'Fragen zur professionellen Verlegung und Installationsverfahren',
    hasNew: false
  },
  { 
    id: 'bestellung', 
    name: 'Bestellung & Lieferung', 
    icon: 'shopping_cart', 
    description: 'Informationen zu Bestellprozess, Preisen und europaweiter Lieferung',
    hasNew: false
  }
]

// Complete Enhanced FAQ Data
const faqs = [
  // Allgemein (10 Fragen)
  {
    id: 1,
    category: 'allgemein',
    question: 'Was bedeutet Architektur Group?',
    answer: 'Die <strong>Architektur Group</strong> besteht aus einem Team an Partnern, Kooperationen & Beratern im Bereich Planung & Innenarchitektur, die während eines Projektes (Neubau, Kernsanierung, Badrenovierung, SkyStairs, Outdoorbereich) die gesamten Arbeitsschritte koordinieren.',
    tags: ['Unternehmen', 'Services'],
    relatedLinks: [
      { title: 'Über uns', url: '/ueber-uns', icon: 'info' },
      { title: 'Unsere Partner', url: '/partner', icon: 'group' }
    ]
  },
  {
    id: 2,
    category: 'allgemein',
    question: 'Wie läuft ein Beratungstermin ab?',
    answer: 'Unsere Kunden kommen deutschland- und europaweit für eine persönliche Beratung in unsere Showrooms. Wir empfehlen einen Termin mit unseren <strong>geschulten Innendesignern</strong> zu vereinbaren. Die Beratung ist selbstverständlich <strong>kostenlos</strong>. Bringen Sie genaue Angaben (Quadratmeter, Treppenstufen, laufende Meter) oder Baupläne mit.',
    tags: ['Beratung', 'Termin'],
    relatedLinks: [
      { title: 'Termin buchen', url: '/kontakt', icon: 'calendar_today' }
    ]
  },
  {
    id: 3,
    category: 'allgemein',
    question: 'Kann ich mir die Produkte vor dem Kauf ansehen?',
    answer: 'Gerne können Sie sich die Natursteine oder Feinsteinzeugfliesen in unseren Ausstellungen <strong>in natura</strong> ansehen. Unser gesamtes Sortiment ist sofort verfügbar. Kunden aus ganz Europa besuchen uns.',
    tags: ['Showroom', 'Besichtigung']
  },
  {
    id: 4,
    category: 'allgemein',
    question: 'Wie erfahre ich Preise?',
    answer: 'Preise erfahren Sie:<br>1. Persönlich in unserer Ausstellung<br>2. Per E-Mail an kontakt@group-ag.de<br>3. Über unser Kontaktformular<br>4. Im Produktbereich über unser Anfrageformular<br><br>Ihr individuelles Angebot erhalten Sie <strong>innerhalb kürzester Zeit</strong>.',
    tags: ['Preise', 'Angebot']
  },
  {
    id: 5,
    category: 'allgemein',
    question: 'Wann und wie erreiche ich die Architektur Group?',
    answer: '<strong>Öffnungszeiten:</strong><br>Dienstag – Freitag: 09:00 – 17:00 Uhr<br>Samstag: 09:00 – 16:00 Uhr<br><br><strong>Kontakt:</strong><br>Telefon: +49 8171 / 3868770<br>Fax: +49 8171 / 3868771<br>E-Mail: kontakt@group-ag.de',
    tags: ['Kontakt', 'Öffnungszeiten']
  },
  {
    id: 6,
    category: 'allgemein',
    question: 'Sind alle Steine Lagerware?',
    answer: 'Ja! Die Architektur Group ist als <strong>Fachgroßhändler</strong> spezialisiert auf Endkunden. Auf über <strong>80.000 m² Lagerfläche</strong> haben wir Europas größte Auswahl an Natursteinen in jeder Form vorrätig.',
    tags: ['Lager', 'Verfügbarkeit']
  },
  {
    id: 7,
    category: 'allgemein',
    question: 'Bietet die Architektur Group den Umbau von Badezimmern an?',
    answer: 'Ja, wir bieten neben der Verlegung auch den <strong>Einbau von Sanitäranlagen und Elektronik aus einer Hand</strong> an. Unsere speziell geschulten Design-Verleger kommen deutschland- und europaweit zu Ihnen.',
    tags: ['Badezimmer', 'Umbau', 'Sanitär']
  },
  {
    id: 8,
    category: 'allgemein',
    question: 'Verfügt die Architektur Group über einen Verlegservice?',
    answer: 'Ja, die Architektur Group verfügt über <strong>qualifiziertes Fachpersonal</strong> zur Verlegung von Böden, Wandverkleidungen und Treppenbelegen. Es werden die besten Verlegungsstoffe verwendet für beste ästhetische und funktionale Resultate.',
    tags: ['Verlegung', 'Service']
  },
  {
    id: 9,
    category: 'allgemein',
    question: 'Kann ich Musterfliesen bestellen?',
    answer: 'Nein, da Musterfliesen den <strong>Gesamteindruck verfälschen</strong>. Wir legen großen Wert auf fachmännisch fundierte Beratung im Hinblick auf Design & kompatible Verlegematerialien direkt vor Ort in unserem Showroom.',
    tags: ['Muster', 'Beratung']
  },
  {
    id: 10,
    category: 'allgemein',
    question: 'Architektur Group & Kooperation',
    answer: 'Die Architektur Group verfügt weltweit über <strong>Kooperationspartner und Lieferanten</strong>. Für erfolgreiche Kundenvermittlung bieten wir eine <strong>Tippgeberprovision von 10% bis 70%</strong> je nach Auftragsvolumen.',
    tags: ['Kooperation', 'Partner']
  },

  // Material & Oberflächen (8 Fragen)
  {
    id: 11,
    category: 'material',
    question: 'Welche Natursteinarten bieten Sie an?',
    answer: 'Wir führen über <strong>650 verschiedene Natursteinsorten</strong> in unserem Sortiment, darunter Marmor, Granit, Travertin, Kalkstein, Schiefer und Quarzit. Alle Steine sind <strong>1. Wahl und 1. Sortierung</strong>, zertifiziert mit Blocknummer.',
    tags: ['Naturstein', 'Sortiment', 'Qualität'],
    relatedLinks: [
      { title: 'Naturstein-Katalog', url: '/natursteine', icon: 'book' }
    ]
  },
  {
    id: 12,
    category: 'material',
    question: 'Was ist High-Tech Feinsteinzeug?',
    answer: '<strong>High-Tech Feinsteinzeug</strong> ist ein hochwertiges keramisches Material mit außergewöhnlichen technischen Eigenschaften. Es bietet höchste Abriebfestigkeit, geringe Wasseraufnahme und ist praktisch unverwüstlich. Ideal für stark beanspruchte Bereiche.',
    tags: ['Feinsteinzeug', 'Technologie']
  },
  {
    id: 13,
    category: 'material',
    question: 'Welche Oberflächenbehandlungen gibt es?',
    answer: 'Wir bieten verschiedene Oberflächenbehandlungen: <strong>poliert, geschliffen, sandgestrahlt, gebürstet, antik und getrommelt</strong>. Jede Oberfläche verleiht dem Stein einen einzigartigen Charakter und eignet sich für unterschiedliche Anwendungen.',
    tags: ['Oberfläche', 'Bearbeitung']
  },
  {
    id: 14,
    category: 'material',
    question: 'Sind die Natursteine frostbeständig?',
    answer: 'Die meisten unserer Natursteine sind <strong>frostbeständig</strong> und für den Außenbereich geeignet. Wir beraten Sie gerne über die spezifischen Eigenschaften jedes Steins und empfehlen die optimale Auswahl für Ihr Projekt.',
    tags: ['Frostbeständigkeit', 'Außenbereich']
  },
  {
    id: 15,
    category: 'material',
    question: 'Wie pflege ich Natursteine richtig?',
    answer: 'Die Pflege hängt von der Steinart ab. Grundsätzlich empfehlen wir <strong>pH-neutrale Reinigungsmittel</strong> und regelmäßige Imprägnierung. Unser Team berät Sie ausführlich über die optimale Pflege für Ihren spezifischen Stein.',
    tags: ['Pflege', 'Reinigung', 'Wartung']
  },
  {
    id: 16,
    category: 'material',
    question: 'Können Natursteine individuell zugeschnitten werden?',
    answer: 'Ja, wir bieten <strong>individuelle Zuschnitte</strong> nach Ihren Wünschen. Unsere moderne Bearbeitungsanlage ermöglicht präzise Schnitte, Bohrungen und Kantenbearbeitungen für maßgeschneiderte Lösungen.',
    tags: ['Zuschnitt', 'Individuell']
  },
  {
    id: 17,
    category: 'material',
    question: 'Was sind die Vorteile von Quarzkomposit?',
    answer: '<strong>Quarzkomposit</strong> verbindet die Schönheit von Naturstein mit technischen Vorteilen: keine Poren, fleckenresistent, pflegeleicht und in gleichmäßiger Qualität verfügbar. Ideal für Küchenarbeitsplatten.',
    tags: ['Quarzkomposit', 'Vorteile']
  },
  {
    id: 18,
    category: 'material',
    question: 'Welche Stärken sind verfügbar?',
    answer: 'Unsere Natursteine sind in verschiedenen Stärken erhältlich: <strong>10mm, 12mm, 15mm, 20mm, 30mm und 40mm</strong>. Die Wahl der Stärke hängt von der geplanten Anwendung und der gewünschten Optik ab.',
    tags: ['Stärke', 'Dimensionen']
  },

  // Verlegung & Montage (6 Fragen)
  {
    id: 19,
    category: 'verlegung',
    question: 'Was ist fugenlose Design-Verlegung?',
    answer: 'Bei der <strong>fugenlosen Design-Verlegung</strong> werden die Natursteine ohne sichtbare Fugen verlegt. Dies schaffen wir durch präzise Kantenbearbeitung und unsere <strong>patentierte High-Tech Fuge</strong>, die optisch unsichtbar ist.',
    tags: ['Fugenlos', 'Design', 'Patent']
  },
  {
    id: 20,
    category: 'verlegung',
    question: 'Wie lange dauert eine Verlegung?',
    answer: 'Die Dauer hängt von der Projektgröße ab. Ein <strong>Badezimmer (15m²)</strong> benötigt ca. 2-3 Tage, eine <strong>Küche (25m²)</strong> ca. 3-4 Tage. Große Flächen werden entsprechend kalkuliert. Wir erstellen einen detaillierten Zeitplan.',
    tags: ['Dauer', 'Zeitplanung']
  },
  {
    id: 21,
    category: 'verlegung',
    question: 'Verlegen Sie auch im Außenbereich?',
    answer: 'Ja, wir verlegen auch <strong>Terrassen, Balkone und Fassaden</strong>. Dabei verwenden wir spezielle frostbeständige Materialien und Verlegeverfahren, die den Witterungseinflüssen standhalten.',
    tags: ['Außenbereich', 'Terrasse', 'Fassade']
  },
  {
    id: 22,
    category: 'verlegung',
    question: 'Was ist die High-Tech Fuge?',
    answer: 'Unsere <strong>patentierte High-Tech Fuge</strong> ist eine innovative 2-Komponenten-Masse, die nach der Aushärtung die gleiche Härte wie Naturstein erreicht. Sie ist wasserdicht, fleckenresistent und praktisch unsichtbar.',
    tags: ['High-Tech', 'Patent', 'Innovation']
  },
  {
    id: 23,
    category: 'verlegung',
    question: 'Können Sie auch auf Fußbodenheizung verlegen?',
    answer: 'Ja, <strong>Natursteine sind ideal für Fußbodenheizungen</strong> geeignet. Sie leiten die Wärme optimal und speichern sie lange. Wir verwenden spezielle Kleber und Verlegeverfahren für beheizte Untergründe.',
    tags: ['Fußbodenheizung', 'Wärmeleitung']
  },
  {
    id: 24,
    category: 'verlegung',
    question: 'Bieten Sie eine Garantie auf die Verlegung?',
    answer: 'Wir geben <strong>5 Jahre Garantie</strong> auf unsere Verlegungsarbeiten und <strong>lebenslange Garantie</strong> auf die High-Tech Fuge. Bei Problemen stehen wir zu unserem Wort und sorgen für eine professionelle Lösung.',
    tags: ['Garantie', 'Gewährleistung']
  },

  // Bestellung & Lieferung (7 Fragen)
  {
    id: 25,
    category: 'bestellung',
    question: 'Wie läuft der Bestellprozess ab?',
    answer: 'Nach der <strong>kostenlosen Beratung</strong> erstellen wir ein detailliertes Angebot. Nach Ihrer Zusage erfolgt die Auftragsbestätigung, dann wird das Material kommissioniert und termingerecht geliefert.',
    tags: ['Bestellprozess', 'Angebot']
  },
  {
    id: 26,
    category: 'bestellung',
    question: 'Was kostet die Lieferung?',
    answer: 'Deutschlandweite Lieferung kostet bei ca. <strong>50m² nur etwa 90,00€</strong>. Für andere Mengen und europäische Länder erstellen wir gerne ein individuelles Angebot. Die Lieferung erfolgt durch unsere eigene Spedition.',
    tags: ['Lieferkosten', 'Versand']
  },
  {
    id: 27,
    category: 'bestellung',
    question: 'Liefern Sie auch nach Österreich und in die Schweiz?',
    answer: 'Ja, wir liefern <strong>europaweit</strong>! Neben Deutschland beliefern wir auch Österreich, Schweiz, Frankreich, Italien und andere EU-Länder. Die Lieferzeiten betragen je nach Land 3-10 Werktage.',
    tags: ['Europa', 'International']
  },
  {
    id: 28,
    category: 'bestellung',
    question: 'Kann ich Material zurückgeben?',
    answer: 'Nicht verwendetes Material in <strong>Originalverpackung</strong> kann binnen 14 Tagen zurückgegeben werden. Maßangefertigte Zuschnitte sind vom Umtausch ausgeschlossen. Die Rückgabe erfolgt auf Kosten des Kunden.',
    tags: ['Rückgabe', 'Umtausch']
  },
  {
    id: 29,
    category: 'bestellung',
    question: 'Welche Zahlungsmöglichkeiten gibt es?',
    answer: 'Wir akzeptieren <strong>Banküberweisung, Kreditkarte, PayPal und Ratenzahlung</strong>. Bei größeren Projekten bieten wir auch individuelle Zahlungspläne an. Anzahlung meist 30-50% bei Bestellung.',
    tags: ['Zahlung', 'Finanzierung']
  },
  {
    id: 30,
    category: 'bestellung',
    question: 'Wie wird das Material angeliefert?',
    answer: 'Die Anlieferung erfolgt durch unsere <strong>eigene Spedition mit speziellen Fahrzeugen</strong>. Wir kontaktieren Sie vor der Anlieferung zur Terminabstimmung. Das Material wird bis zur Bordsteinkante oder nach Absprache auch ins Haus geliefert.',
    tags: ['Anlieferung', 'Spedition']
  },
  {
    id: 31,
    category: 'bestellung',
    question: 'Was ist bei der Anlieferung zu beachten?',
    answer: 'Bitte stellen Sie sicher, dass die <strong>Zufahrt für LKW möglich</strong> ist und ausreichend Lagerplatz vorhanden ist. Schwere Platten benötigen ggf. einen Kran. Wir besichtigen die Örtlichkeiten gerne vorab.',
    tags: ['Zufahrt', 'Lagerung']
  }
]

// Computed Properties
const filteredFaqs = computed(() => {
  let filtered = faqs.filter(faq => {
    const matchesCategory = activeFaqCategory.value === 'alle' || faq.category === activeFaqCategory.value
    const matchesSearch = !searchQuery.value || 
      faq.question.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
      faq.answer.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
      (faq.tags && faq.tags.some(tag => tag.toLowerCase().includes(searchQuery.value.toLowerCase())))
    
    return matchesCategory && matchesSearch
  })
  
  return filtered
})

const activeCategoryData = computed(() => {
  return faqCategories.find(cat => cat.id === activeFaqCategory.value) || faqCategories[0]
})

const totalFaqs = computed(() => faqs.length)

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

const handleFeatureHover = (id, index) => {
  hoveredFeature.value = id
}

const handleFeatureLeave = (id) => {
  hoveredFeature.value = null
}

const triggerFeatureExplosion = (id) => {
  rippleCount.value += 1
  setTimeout(() => {
    rippleCount.value -= 1
  }, 1000)
}

const setActiveFaqCategory = (categoryId) => {
  activeFaqCategory.value = categoryId
  // Close all expanded FAQs when switching categories
  expandedFaqs.value = []
}

const markHelpful = (faqId, isHelpful) => {
  console.log('FAQ', faqId, 'marked as', isHelpful ? 'helpful' : 'not helpful')
  // Here you could implement tracking logic
}

const playHoverSound = () => {
  // Sound effect placeholder
}

// Scroll handling
const handleScroll = () => {
  scrollY.value = window.scrollY
  
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

const getCategoryCount = (categoryId) => {
  return faqs.filter(faq => faq.category === categoryId).length
}

const handleSearch = () => {
  // Debounce search if needed
  // expandedFaqs.value = [] // Optionally close all expanded FAQs on search
}

// Lifecycle
onMounted(() => {
  // Any initialization logic
})

const clearSearch = () => {
  searchQuery.value = ''
  expandedFaqs.value = []
}

const highlightSearchTerm = (text) => {
  if (!searchQuery.value || !text) return text
  
  const regex = new RegExp(`(${searchQuery.value})`, 'gi')
  return text.replace(regex, '<mark class="search-highlight">$1</mark>')
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
  if (heroSection) observer.observe(heroSection)
  
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

  // Features visibility observer
  const featuresObserver = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        const index = parseInt(entry.target.dataset.index)
        if (!visibleFeatures.value.includes(index)) {
          setTimeout(() => {
            visibleFeatures.value.push(index)
          }, index * 100)
        }
      }
    })
  }, { threshold: 0.2 })
  
  nextTick(() => {
    document.querySelectorAll('.luxury-feature-card').forEach((card, index) => {
      card.dataset.index = index
      featuresObserver.observe(card)
    })
  })
})

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll)
  document.body.style.overflow = 'auto'
})
</script>

<style scoped>
/* Basis Styles */
.service-page {
  min-height: 100vh;
  background: #000;
  color: #FAFAF8;
  overflow-x: hidden;
}

/* Hero Section Styles */
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

.section-subtitle {
  font-size: 1.15rem;
  color: #999;
}

/* Search Bar */
.faq-search-container {
  max-width: 600px;
  margin: 0 auto 4rem;
}

.search-wrapper {
  position: relative;
  display: flex;
  align-items: center;
  background: linear-gradient(135deg, rgba(255, 255, 255, 0.08), rgba(164, 113, 72, 0.05));
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 50px;
  padding: 0.75rem 1.5rem;
  transition: all 0.3s ease;
  backdrop-filter: blur(20px);
}

.search-wrapper:focus-within {
  border-color: #a47148;
  box-shadow: 0 0 20px rgba(164, 113, 72, 0.3);
  transform: translateY(-2px);
}

.search-icon {
  color: #a47148;
  margin-right: 1rem;
  font-size: 1.25rem;
}

.search-input {
  flex: 1;
  background: transparent;
  border: none;
  outline: none;
  color: #FAFAF8;
  font-size: 1rem;
  padding: 0.5rem 0;
}

.search-input::placeholder {
  color: #999;
}

.search-clear {
  cursor: pointer;
  color: #999;
  margin-left: 1rem;
  padding: 0.25rem;
  border-radius: 50%;
  transition: all 0.3s ease;
}

.search-clear:hover {
  color: #a47148;
  background: rgba(164, 113, 72, 0.1);
}

.search-results-info {
  text-align: center;
  margin-top: 1rem;
  color: #a47148;
  font-size: 0.9rem;
  font-weight: 500;
}

.search-highlight {
  background: rgba(164, 113, 72, 0.3);
  color: #FAFAF8;
  padding: 0.1rem 0.25rem;
  border-radius: 3px;
  font-weight: 600;
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

/* Advantages Section */
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

.premium-advantage-content {
  margin-top: 2rem;
  overflow: hidden;
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

/* Luxury Features Showcase - KOMPAKTE VERSION */
.luxury-features-showcase {
  padding: 4rem 0; /* Reduziert von 8rem */
  position: relative;
  background: 
    radial-gradient(circle at 25% 25%, rgba(164, 113, 72, 0.15) 0%, transparent 60%),
    radial-gradient(circle at 75% 75%, rgba(255, 215, 0, 0.08) 0%, transparent 50%),
    linear-gradient(135deg, #0a0a0a 0%, #1a1a1a 50%, #0f0f0f 100%);
  overflow: hidden;
}

.luxury-features-showcase::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: 
    url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23a47148' fill-opacity='0.03'%3E%3Cpolygon points='30,0 60,30 30,60 0,30'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
  animation: patternShift 20s linear infinite;
}

@keyframes patternShift {
  0% { transform: translateX(0) translateY(0); }
  100% { transform: translateX(-60px) translateY(-60px); }
}

.showcase-header {
  text-align: center;
  margin-bottom: 3rem; /* Reduziert von 6rem */
  position: relative;
  z-index: 2;
}

.header-particle-system {
  position: absolute;
  top: -50px; /* Reduziert von -100px */
  left: 0;
  right: 0;
  height: 100px; /* Reduziert von 200px */
  overflow: hidden;
  pointer-events: none;
}

.floating-particle {
  position: absolute;
  width: 4px;
  height: 4px;
  background: radial-gradient(circle, #a47148, transparent);
  border-radius: 50%;
  animation: floatParticle 4s ease-in-out infinite;
}

@keyframes floatParticle {
  0%, 100% {
    transform: translateY(100px) translateX(0) scale(0);
    opacity: 0;
  }
  10% {
    opacity: 1;
    transform: translateY(80px) translateX(10px) scale(1);
  }
  90% {
    opacity: 1;
    transform: translateY(-50px) translateX(-10px) scale(0.5);
  }
  100% {
    opacity: 0;
  }
}

.showcase-title {
  font-size: 2.5rem; /* Reduziert von 3.5rem */
  font-weight: 300;
  margin-bottom: 1rem; /* Reduziert von 1.5rem */
  line-height: 1.2;
}

.title-word {
  display: inline-block;
  margin-right: 1rem;
  opacity: 0;
  transform: translateY(50px) rotateX(-90deg);
  animation: titleWordReveal 1.2s cubic-bezier(0.25, 0.46, 0.45, 0.94) forwards;
  background: linear-gradient(135deg, #FAFAF8 0%, #a47148 50%, #FAFAF8 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-size: 200% 100%;
  animation: titleWordReveal 1.2s cubic-bezier(0.25, 0.46, 0.45, 0.94) forwards,
             shimmerEffect 3s ease-in-out infinite 1.5s;
}

@keyframes titleWordReveal {
  to {
    opacity: 1;
    transform: translateY(0) rotateX(0);
  }
}

@keyframes shimmerEffect {
  0%, 100% { background-position: 200% 0; }
  50% { background-position: -200% 0; }
}

.showcase-subtitle {
  font-size: 1.1rem; /* Reduziert von 1.3rem */
  color: #999;
  font-style: italic;
  margin-bottom: 1.5rem; /* Reduziert von 2rem */
  animation: fadeInUp 1s ease-out 0.8s backwards;
}

.showcase-divider {
  position: relative;
  width: 150px; /* Reduziert von 200px */
  margin: 0 auto;
  height: 2px;
}

.divider-line {
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, #a47148, transparent);
  animation: dividerExpand 1.5s ease-out 1s forwards;
  transform: scaleX(0);
}

.divider-glow {
  position: absolute;
  top: -5px;
  left: 0;
  right: 0;
  height: 12px;
  background: radial-gradient(ellipse, rgba(164, 113, 72, 0.5), transparent);
  filter: blur(8px);
  animation: glowPulse 2s ease-in-out infinite 2s;
}

@keyframes dividerExpand {
  to { transform: scaleX(1); }
}

.features-luxury-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); /* Reduziert von 400px */
  gap: 2rem; /* Reduziert von 4rem */
  max-width: 1400px; /* Reduziert von 1600px */
  margin: 0 auto;
  perspective: 1000px;
}

.luxury-feature-card {
  position: relative;
  min-height: 350px; /* Reduziert von 600px */
  border-radius: 24px; /* Reduziert von 32px */
  overflow: hidden;
  cursor: pointer;
  transform-style: preserve-3d;
  transition: all 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  opacity: 0;
  transform: translateY(100px) rotateX(-15deg) scale(0.8);
  animation: luxuryCardReveal 1.2s cubic-bezier(0.25, 0.46, 0.45, 0.94) forwards;
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.luxury-feature-card.visible {
  opacity: 1;
  transform: translateY(0) rotateX(0) scale(1);
}

@keyframes luxuryCardReveal {
  to {
    opacity: 1;
    transform: translateY(0) rotateX(0) scale(1);
  }
}

.luxury-feature-card:hover {
  transform: translateY(-20px) rotateX(5deg) scale(1.03); /* Reduziert von -30px */
  box-shadow: 
    0 30px 60px rgba(164, 113, 72, 0.4), /* Reduziert von 50px 100px */
    0 0 0 1px rgba(164, 113, 72, 0.3),
    inset 0 0 30px rgba(164, 113, 72, 0.1); /* Reduziert von 50px */
}

.luxury-feature-card.hovered {
  z-index: 10;
}

.luxury-feature-background {
  position: absolute;
  inset: 0;
  overflow: hidden;
}

.feature-gradient {
  position: absolute;
  inset: 0;
  transition: all 0.8s ease;
}

.feature-pattern {
  position: absolute;
  inset: 0;
  background: 
    radial-gradient(circle at 25% 25%, rgba(255, 255, 255, 0.1) 2px, transparent 2px),
    radial-gradient(circle at 75% 75%, rgba(255, 255, 255, 0.05) 1px, transparent 1px);
  background-size: 50px 50px, 25px 25px;
  animation: patternDrift 15s linear infinite;
  opacity: 0.6;
}

@keyframes patternDrift {
  0% { transform: translate(0, 0); }
  100% { transform: translate(-50px, -25px); }
}

.morphing-blob {
  position: absolute;
  border-radius: 50%;
  filter: blur(30px); /* Reduziert von 40px */
  animation: blobMorph 8s ease-in-out infinite;
  opacity: 0.3;
}

.blob-1 {
  width: 120px; /* Reduziert von 200px */
  height: 120px;
  background: radial-gradient(circle, rgba(164, 113, 72, 0.8), transparent);
  top: 20%;
  left: 10%;
}

.blob-2 {
  width: 100px; /* Reduziert von 150px */
  height: 100px;
  background: radial-gradient(circle, rgba(255, 215, 0, 0.6), transparent);
  bottom: 20%;
  right: 15%;
  animation-delay: -4s;
}

@keyframes blobMorph {
  0%, 100% {
    transform: scale(1) rotate(0deg);
    border-radius: 50%;
  }
  25% {
    transform: scale(1.2) rotate(90deg);
    border-radius: 30% 70% 70% 30% / 30% 30% 70% 70%;
  }
  50% {
    transform: scale(0.8) rotate(180deg);
    border-radius: 70% 30% 30% 70% / 70% 70% 30% 30%;
  }
  75% {
    transform: scale(1.1) rotate(270deg);
    border-radius: 40% 60% 60% 40% / 60% 40% 60% 40%;
  }
}

.energy-waves {
  position: absolute;
  inset: 0;
  overflow: hidden;
}

.wave {
  position: absolute;
  top: 50%;
  left: 50%;
  width: 20px;
  height: 20px;
  border: 2px solid rgba(164, 113, 72, 0.3);
  border-radius: 50%;
  transform: translate(-50%, -50%);
  animation: waveExpand 3s ease-out infinite;
}

@keyframes waveExpand {
  0% {
    width: 20px;
    height: 20px;
    opacity: 1;
  }
  100% {
    width: 400px; /* Reduziert von 600px */
    height: 400px;
    opacity: 0;
  }
}

.card-particles {
  position: absolute;
  inset: 0;
  overflow: hidden;
  pointer-events: none;
}

.particle {
  position: absolute;
  width: 3px;
  height: 3px;
  background: linear-gradient(45deg, #a47148, #FAFAF8);
  border-radius: 50%;
  top: 50%;
  left: 50%;
  animation: particleOrbit 4s linear infinite;
}

@keyframes particleOrbit {
  from {
    transform: translate(-50%, -50%) rotate(var(--start-pos)) translateX(80px) scale(0); /* Reduziert von 100px */
    opacity: 0;
  }
  10%, 90% {
    opacity: 1;
    transform: translate(-50%, -50%) rotate(var(--start-pos)) translateX(80px) scale(1);
  }
  to {
    transform: translate(-50%, -50%) rotate(var(--end-pos)) translateX(150px) scale(0); /* Reduziert von 200px */
    opacity: 0;
  }
}

.luxury-feature-icon-3d {
  position: relative;
  width: 80px; /* Reduziert von 120px */
  height: 80px;
  margin: 0 auto 1.5rem; /* Reduziert von 2rem */
  display: flex;
  align-items: center;
  justify-content: center;
}

.icon-hologram {
  position: absolute;
  inset: 0;
}

.hologram-layer {
  position: absolute;
  inset: 0;
  border-radius: 50%;
  border: 1px solid rgba(164, 113, 72, 0.3);
  animation: hologramSpin 6s linear infinite;
}

.layer-1 { animation-delay: 0s; }
.layer-2 { 
  animation-delay: -2s; 
  transform: rotateY(60deg);
}
.layer-3 { 
  animation-delay: -4s; 
  transform: rotateY(120deg);
}

@keyframes hologramSpin {
  from { transform: rotateZ(0deg) rotateX(60deg); }
  to { transform: rotateZ(360deg) rotateX(60deg); }
}

.icon-glow-ring {
  position: absolute;
  inset: -15px; /* Reduziert von -20px */
  border-radius: 50%;
  background: conic-gradient(transparent, rgba(164, 113, 72, 0.3), transparent);
  animation: ringRotate 3s linear infinite;
  filter: blur(8px); /* Reduziert von 10px */
}

@keyframes ringRotate {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}

.icon-container {
  position: relative;
  width: 60px; /* Reduziert von 80px */
  height: 60px;
  background: linear-gradient(135deg, rgba(164, 113, 72, 0.2), rgba(255, 255, 255, 0.1));
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  backdrop-filter: blur(20px);
  border: 1px solid rgba(164, 113, 72, 0.3);
  transition: all 0.6s ease;
  z-index: 2;
}

.luxury-feature-card:hover .icon-container {
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  transform: scale(1.2) rotateY(180deg);
  box-shadow: 0 0 30px rgba(164, 113, 72, 0.8); /* Reduziert von 50px */
}

.feature-icon {
  font-size: 1.8rem; /* Reduziert von 2.5rem */
  color: #a47148;
  transition: all 0.6s ease;
  z-index: 1;
}

.luxury-feature-card:hover .feature-icon {
  color: #000;
  transform: scale(1.1);
}

.icon-reflection {
  position: absolute;
  inset: 0;
  background: linear-gradient(135deg, transparent 40%, rgba(255, 255, 255, 0.2) 50%, transparent 60%);
  border-radius: 50%;
  animation: reflectionSweep 4s ease-in-out infinite;
}

@keyframes reflectionSweep {
  0%, 100% { transform: rotate(0deg); opacity: 0; }
  50% { opacity: 1; transform: rotate(180deg); }
}

.magnetic-field {
  position: absolute;
  inset: -30px; /* Reduziert von -40px */
}

.field-line {
  position: absolute;
  top: 50%;
  left: 50%;
  width: 2px;
  height: 60px; /* Reduziert von 80px */
  background: linear-gradient(to bottom, transparent, rgba(164, 113, 72, 0.4), transparent);
  transform-origin: center bottom;
  animation: fieldPulse 2s ease-in-out infinite;
}

@keyframes fieldPulse {
  0%, 100% { opacity: 0.3; transform: translate(-50%, -100%) scaleY(1); }
  50% { opacity: 1; transform: translate(-50%, -100%) scaleY(1.5); }
}

.luxury-feature-content {
  position: relative;
  z-index: 3;
  padding: 2rem 1.5rem; /* Reduziert von 3rem 2rem */
  height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  text-align: center;
  backdrop-filter: blur(10px);
}

.luxury-feature-title {
  font-size: 1.4rem; /* Reduziert von 1.8rem */
  font-weight: 500;
  margin-bottom: 1rem; /* Reduziert von 1.5rem */
  color: #FAFAF8;
  overflow: hidden;
}

.title-char {
  display: inline-block;
  opacity: 0;
  transform: translateY(30px) rotateX(-90deg);
  animation: charReveal 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94) forwards;
}

@keyframes charReveal {
  to {
    opacity: 1;
    transform: translateY(0) rotateX(0);
  }
}

.luxury-feature-description {
  color: #ccc;
  line-height: 1.6; /* Reduziert von 1.8 */
  font-size: 0.95rem; /* Reduziert von 1.1rem */
  margin-bottom: 1.5rem; /* Reduziert von 2rem */
  flex-grow: 1;
}

.quantum-highlight {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 2px;
  overflow: hidden;
}

.quantum-particles {
  position: relative;
  width: 100%;
  height: 100%;
}

.quantum-particle {
  position: absolute;
  width: 3px; /* Reduziert von 4px */
  height: 3px;
  background: #a47148;
  border-radius: 50%;
  animation: quantumMove 4s linear infinite;
}

@keyframes quantumMove {
  0% {
    left: -10px;
    opacity: 0;
    transform: scale(0);
  }
  10%, 90% {
    opacity: 1;
    transform: scale(1);
  }
  100% {
    left: 110%;
    opacity: 0;
    transform: scale(0);
  }
}

.energy-beam {
  position: absolute;
  top: 0;
  left: 0;
  width: 0;
  height: 2px;
  background: linear-gradient(90deg, transparent, #a47148, transparent);
  animation: beamSweep 3s ease-in-out infinite;
}

@keyframes beamSweep {
  0%, 100% { width: 0; left: 0; }
  50% { width: 100%; left: 0; }
}

.interaction-ripples {
  position: absolute;
  inset: 0;
  pointer-events: none;
  border-radius: 24px; /* Reduziert von 32px */
  overflow: hidden;
}

.ripple {
  position: absolute;
  border-radius: 50%;
  background: radial-gradient(circle, rgba(164, 113, 72, 0.3), transparent);
  animation: rippleExpand 1s ease-out;
  pointer-events: none;
}

@keyframes rippleExpand {
  from {
    width: 0;
    height: 0;
    opacity: 1;
  }
  to {
    width: 200px; /* Reduziert von 300px */
    height: 200px;
    opacity: 0;
  }
}

.corner-accents {
  position: absolute;
  inset: 0;
  pointer-events: none;
  border-radius: 24px; /* Reduziert von 32px */
}

.corner {
  position: absolute;
  width: 15px; /* Reduziert von 20px */
  height: 15px;
  border: 2px solid #a47148;
  opacity: 0;
  transition: all 0.6s ease;
}

.corner.top-left {
  top: 10px; /* Reduziert von 15px */
  left: 10px;
  border-right: none;
  border-bottom: none;
}

.corner.top-right {
  top: 10px;
  right: 10px;
  border-left: none;
  border-bottom: none;
}

.corner.bottom-left {
  bottom: 10px;
  left: 10px;
  border-right: none;
  border-top: none;
}

.corner.bottom-right {
  bottom: 10px;
  right: 10px;
  border-left: none;
  border-top: none;
}

.luxury-feature-card:hover .corner {
  opacity: 1;
  transform: scale(1.2);
}

/* Enhanced Luxury FAQ Section */
.faq-section {
  padding: 8rem 0;
  background: 
    radial-gradient(circle at 30% 20%, rgba(164, 113, 72, 0.08) 0%, transparent 60%),
    radial-gradient(circle at 70% 80%, rgba(164, 113, 72, 0.05) 0%, transparent 50%),
    linear-gradient(135deg, #0a0a0a 0%, #1a1a1a 50%, #0f0f0f 100%);
  position: relative;
  overflow: hidden;
}

.faq-section::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 1px;
  background: linear-gradient(90deg, transparent, #a47148, transparent);
}

/* Enhanced Section Header */
.header-decoration {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 2rem;
  margin-bottom: 2rem;
}

.decoration-line {
  width: 100px;
  height: 1px;
  background: linear-gradient(90deg, transparent, #a47148);
}

.decoration-line.left {
  background: linear-gradient(90deg, transparent, #a47148);
}

.decoration-line.right {
  background: linear-gradient(90deg, #a47148, transparent);
}

.section-badge.premium {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.75rem 1.5rem;
  background: linear-gradient(135deg, rgba(164, 113, 72, 0.2), rgba(255, 255, 255, 0.05));
  border: 1px solid rgba(164, 113, 72, 0.3);
  border-radius: 50px;
  backdrop-filter: blur(20px);
  animation: badgeGlow 3s ease-in-out infinite;
  font-size: 0.75rem;
  letter-spacing: 0.1em;
  font-weight: 600;
  color: #a47148;
}

@keyframes badgeGlow {
  0%, 100% { box-shadow: 0 0 0 rgba(164, 113, 72, 0.5); }
  50% { box-shadow: 0 0 20px rgba(164, 113, 72, 0.3); }
}

.section-title {
  font-size: 3rem;
  font-weight: 300;
  margin-bottom: 1rem;
}

.title-gradient {
  background: linear-gradient(135deg, #FAFAF8 0%, #a47148 50%, #FAFAF8 100%);
  background-size: 200% 100%;
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  animation: titleShimmer 4s ease-in-out infinite;
}

@keyframes titleShimmer {
  0%, 100% { background-position: 200% 0; }
  50% { background-position: -200% 0; }
}

/* Luxury Category Filters */
.faq-filter-container {
  position: relative;
  margin-bottom: 4rem;
}

.filter-background-glow {
  position: absolute;
  inset: -20px;
  background: radial-gradient(ellipse, rgba(164, 113, 72, 0.1), transparent);
  filter: blur(30px);
  opacity: 0.7;
}

.category-filters {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 1.5rem;
  margin-bottom: 3rem;
}

.luxury-category-btn {
  position: relative;
  background: transparent;
  border: none;
  cursor: pointer;
  overflow: hidden;
  border-radius: 20px;
  transition: all 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  animation: filterBtnIn 0.8s ease-out backwards;
}

@keyframes filterBtnIn {
  from {
    opacity: 0;
    transform: translateY(30px) scale(0.9);
  }
  to {
    opacity: 1;
    transform: translateY(0) scale(1);
  }
}

.btn-background {
  position: absolute;
  inset: 0;
  border-radius: 20px;
  transition: all 0.6s ease;
}

.bg-gradient {
  position: absolute;
  inset: 0;
  background: linear-gradient(135deg, 
    rgba(255, 255, 255, 0.05) 0%, 
    rgba(255, 255, 255, 0.02) 100%);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 20px;
  transition: all 0.6s ease;
}

.luxury-category-btn.active .bg-gradient {
  background: linear-gradient(135deg, 
    rgba(164, 113, 72, 0.3) 0%, 
    rgba(164, 113, 72, 0.1) 100%);
  border-color: #a47148;
  box-shadow: 
    0 10px 30px rgba(164, 113, 72, 0.3),
    inset 0 0 50px rgba(164, 113, 72, 0.1);
}

.bg-shine {
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.1), transparent);
  transition: left 0.6s ease;
  border-radius: 20px;
}

.luxury-category-btn:hover .bg-shine {
  left: 100%;
}

.btn-content {
  position: relative;
  z-index: 2;
  display: grid;
  grid-template-columns: auto 1fr;
  align-items: center;
  gap: 1.5rem;
  padding: 2rem;
  text-align: left;
}

.category-icon-wrapper {
  position: relative;
  width: 60px;
  height: 60px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.icon-orbit {
  position: absolute;
  inset: -5px;
  border: 1px solid rgba(164, 113, 72, 0.3);
  border-radius: 50%;
  animation: iconOrbit 10s linear infinite;
}

@keyframes iconOrbit {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}

.category-icon {
  font-size: 1.8rem;
  color: #a47148;
  background: linear-gradient(135deg, rgba(164, 113, 72, 0.2), rgba(255, 255, 255, 0.1));
  width: 50px;
  height: 50px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.6s ease;
  position: relative;
  z-index: 1;
}

.luxury-category-btn.active .category-icon {
  color: #FAFAF8;
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  transform: scale(1.1);
  box-shadow: 0 0 30px rgba(164, 113, 72, 0.6);
}

.category-info {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.category-name {
  font-size: 1.1rem;
  font-weight: 500;
  color: #FAFAF8;
  transition: all 0.3s ease;
}

.luxury-category-btn.active .category-name {
  color: #a47148;
}

.category-meta {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.question-count {
  font-size: 0.85rem;
  color: #999;
  transition: color 0.3s ease;
}

.luxury-category-btn.active .question-count {
  color: #a47148;
}

.btn-particles {
  position: absolute;
  inset: 0;
  overflow: hidden;
  border-radius: 20px;
  pointer-events: none;
}

.filter-particle {
  position: absolute;
  width: 3px;
  height: 3px;
  background: #a47148;
  border-radius: 50%;
  opacity: 0;
  animation: filterParticleFloat 3s ease-out infinite;
}

.filter-particle:nth-child(1) { top: 20%; left: 20%; animation-delay: 0s; }
.filter-particle:nth-child(2) { top: 40%; left: 80%; animation-delay: 0.5s; }
.filter-particle:nth-child(3) { top: 70%; left: 30%; animation-delay: 1s; }
.filter-particle:nth-child(4) { top: 80%; left: 70%; animation-delay: 1.5s; }
.filter-particle:nth-child(5) { top: 30%; left: 50%; animation-delay: 2s; }
.filter-particle:nth-child(6) { top: 60%; left: 10%; animation-delay: 2.5s; }

@keyframes filterParticleFloat {
  0%, 100% {
    opacity: 0;
    transform: translateY(0) scale(0);
  }
  50% {
    opacity: 1;
    transform: translateY(-20px) scale(1);
  }
}

.luxury-category-btn.active .filter-particle {
  animation-duration: 2s;
  background: #FAFAF8;
}

.luxury-category-btn:hover {
  transform: translateY(-5px) scale(1.02);
}

/* Enhanced FAQ List */
.faq-container {
  max-width: 1000px;
  margin: 0 auto;
}

.faq-count-indicator {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 1rem;
  margin-bottom: 3rem;
  padding: 1rem 2rem;
  background: rgba(255, 255, 255, 0.03);
  border: 1px solid rgba(255, 255, 255, 0.05);
  border-radius: 50px;
  backdrop-filter: blur(10px);
  animation: countIndicatorIn 0.8s ease-out;
}

@keyframes countIndicatorIn {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.count-number {
  font-size: 1.5rem;
  font-weight: 600;
  color: #a47148;
}

.count-label {
  color: #ccc;
  font-size: 0.9rem;
}

.luxury-faq-list {
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
}

.luxury-faq-item {
  position: relative;
  background: linear-gradient(135deg, 
    rgba(255, 255, 255, 0.05) 0%, 
    rgba(255, 255, 255, 0.02) 100%);
  border: 1px solid rgba(255, 255, 255, 0.08);
  border-radius: 24px;
  overflow: hidden;
  transition: all 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  animation: faqItemSlideIn 0.8s ease-out backwards;
  animation-delay: calc(var(--item-index) * 0.1s);
}

@keyframes faqItemSlideIn {
  from {
    opacity: 0;
    transform: translateX(-50px) scale(0.95);
  }
  to {
    opacity: 1;
    transform: translateX(0) scale(1);
  }
}

.luxury-faq-item:hover {
  transform: translateY(-5px) scale(1.01);
  border-color: rgba(164, 113, 72, 0.3);
  box-shadow: 0 20px 40px rgba(164, 113, 72, 0.15);
}

.luxury-faq-item.expanded {
  border-color: rgba(164, 113, 72, 0.4);
  background: linear-gradient(135deg, 
    rgba(164, 113, 72, 0.08) 0%, 
    rgba(255, 255, 255, 0.03) 100%);
}

/* FAQ Question Button */
.luxury-faq-question {
  width: 100%;
  background: transparent;
  border: none;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}

.question-background {
  position: absolute;
  inset: 0;
}

.bg-pattern {
  position: absolute;
  inset: 0;
  background: 
    radial-gradient(circle at 25% 25%, rgba(164, 113, 72, 0.1) 2px, transparent 2px),
    radial-gradient(circle at 75% 75%, rgba(164, 113, 72, 0.05) 1px, transparent 1px);
  background-size: 30px 30px, 15px 15px;
  opacity: 0;
  transition: opacity 0.6s ease;
}

.luxury-faq-question:hover .bg-pattern {
  opacity: 1;
  animation: patternShift 10s linear infinite;
}

.bg-glow {
  position: absolute;
  inset: 0;
  background: radial-gradient(ellipse at center, rgba(164, 113, 72, 0.1), transparent);
  opacity: 0;
  transition: opacity 0.6s ease;
}

.luxury-faq-question.active .bg-glow {
  opacity: 1;
}

.question-content {
  position: relative;
  z-index: 2;
  display: grid;
  grid-template-columns: auto 1fr auto;
  align-items: center;
  gap: 2rem;
  padding: 2rem 2.5rem;
  transition: all 0.6s ease;
}

.question-number {
  width: 50px;
  height: 50px;
  background: linear-gradient(135deg, rgba(164, 113, 72, 0.2), rgba(255, 255, 255, 0.1));
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.1rem;
  font-weight: 600;
  color: #a47148;
  transition: all 0.6s ease;
  position: relative;
  overflow: hidden;
}

.luxury-faq-question.active .question-number {
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  color: #000;
  transform: scale(1.1);
  box-shadow: 0 0 30px rgba(164, 113, 72, 0.5);
}

.question-number::before {
  content: '';
  position: absolute;
  inset: 0;
  background: linear-gradient(45deg, transparent, rgba(255, 255, 255, 0.3), transparent);
  transform: translateX(-100%);
  transition: transform 0.6s ease;
}

.luxury-faq-question:hover .question-number::before {
  transform: translateX(100%);
}

.question-text-wrapper {
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
  text-align: left;
}

.question-text {
  font-size: 1.2rem;
  font-weight: 500;
  color: #FAFAF8;
  line-height: 1.4;
  margin: 0;
  transition: all 0.3s ease;
}

.luxury-faq-question:hover .question-text {
  color: #a47148;
}

.luxury-faq-question.active .question-text {
  color: #a47148;
}

.question-tags {
  display: flex;
  gap: 0.5rem;
  flex-wrap: wrap;
}

.tag {
  padding: 0.25rem 0.75rem;
  background: rgba(164, 113, 72, 0.1);
  border: 1px solid rgba(164, 113, 72, 0.3);
  border-radius: 15px;
  font-size: 0.75rem;
  color: #a47148;
  transition: all 0.3s ease;
}

.luxury-faq-question:hover .tag {
  background: rgba(164, 113, 72, 0.2);
  transform: scale(1.05);
}

.question-toggle-wrapper {
  position: relative;
  width: 50px;
  height: 50px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.toggle-bg {
  position: absolute;
  inset: 0;
  background: rgba(164, 113, 72, 0.1);
  border: 1px solid rgba(164, 113, 72, 0.2);
  border-radius: 50%;
  transition: all 0.6s ease;
}

.luxury-faq-question.active .toggle-bg {
  background: rgba(164, 113, 72, 0.3);
  border-color: #a47148;
  box-shadow: 0 0 20px rgba(164, 113, 72, 0.3);
}

.toggle-icon {
  font-size: 1.5rem;
  color: #a47148;
  transition: all 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  position: relative;
  z-index: 1;
}

.luxury-faq-question.active .toggle-icon {
  color: #FAFAF8;
  transform: rotate(180deg);
}

.question-hover-effects {
  position: absolute;
  inset: 0;
  pointer-events: none;
}

.hover-glow {
  position: absolute;
  inset: -20px;
  background: radial-gradient(ellipse, rgba(164, 113, 72, 0.2), transparent);
  opacity: 0;
  filter: blur(20px);
  transition: opacity 0.6s ease;
}

.luxury-faq-question:hover .hover-glow {
  opacity: 1;
}

.hover-border {
  position: absolute;
  inset: 0;
  border: 1px solid transparent;
  border-radius: 24px;
  background: linear-gradient(135deg, rgba(164, 113, 72, 0.3), transparent, rgba(164, 113, 72, 0.3));
  background-clip: padding-box;
  opacity: 0;
  transition: opacity 0.6s ease;
}

.luxury-faq-question:hover .hover-border {
  opacity: 1;
}

/* FAQ Answer */
.luxury-faq-answer {
  position: relative;
  overflow: hidden;
}

.answer-background {
  position: absolute;
  inset: 0;
}

.answer-pattern {
  position: absolute;
  inset: 0;
  background: 
    linear-gradient(45deg, transparent 49%, rgba(164, 113, 72, 0.05) 49%, rgba(164, 113, 72, 0.05) 51%, transparent 51%);
  background-size: 20px 20px;
  opacity: 0.3;
}

.answer-content {
  position: relative;
  z-index: 2;
  padding: 0 2.5rem 2.5rem 2.5rem;
}

.answer-decorator {
  display: flex;
  align-items: center;
  gap: 1rem;
  margin-bottom: 2rem;
  padding: 1rem 0;
}

.decorator-line {
  flex: 1;
  height: 1px;
  background: linear-gradient(90deg, transparent, #a47148, transparent);
}

.answer-decorator .material-icons {
  color: #a47148;
  font-size: 1.2rem;
  animation: decoratorPulse 2s ease-in-out infinite;
}

@keyframes decoratorPulse {
  0%, 100% { transform: scale(1); opacity: 0.7; }
  50% { transform: scale(1.2); opacity: 1; }
}

.answer-text {
  color: #ccc;
  line-height: 1.8;
  font-size: 1rem;
  margin-bottom: 2rem;
}

.answer-text strong {
  color: #FAFAF8;
  font-weight: 600;
}

.related-links {
  margin-bottom: 2rem;
}

.related-links h5 {
  color: #a47148;
  font-size: 0.9rem;
  font-weight: 600;
  margin-bottom: 1rem;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.links-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 1rem;
}

.related-link {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  padding: 1rem;
  background: rgba(255, 255, 255, 0.03);
  border: 1px solid rgba(255, 255, 255, 0.05);
  border-radius: 12px;
  color: #ccc;
  text-decoration: none;
  font-size: 0.9rem;
  transition: all 0.3s ease;
}

.related-link:hover {
  background: rgba(164, 113, 72, 0.1);
  border-color: #a47148;
  color: #a47148;
  transform: translateY(-2px);
}

.related-link .material-icons {
  color: #a47148;
  font-size: 1.2rem;
}

.answer-meta {
  border-top: 1px solid rgba(255, 255, 255, 0.1);
  padding-top: 1.5rem;
}

.helpful-question {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 2rem;
  flex-wrap: wrap;
}

.helpful-question span {
  color: #999;
  font-size: 0.9rem;
}

.helpful-buttons {
  display: flex;
  gap: 1rem;
}

.helpful-btn {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.5rem 1rem;
  background: transparent;
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 20px;
  color: #ccc;
  font-size: 0.85rem;
  cursor: pointer;
  transition: all 0.3s ease;
}

.helpful-btn.positive:hover {
  background: rgba(34, 197, 94, 0.1);
  border-color: rgba(34, 197, 94, 0.3);
  color: #22c55e;
}

.helpful-btn.negative:hover {
  background: rgba(239, 68, 68, 0.1);
  border-color: rgba(239, 68, 68, 0.3);
  color: #ef4444;
}

.helpful-btn .material-icons {
  font-size: 1rem;
}

/* Answer Expand Transition */
.answer-expand-enter-active,
.answer-expand-leave-active {
  transition: all 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

.answer-expand-enter-from,
.answer-expand-leave-to {
  opacity: 0;
  max-height: 0;
  transform: translateY(-20px);
}

.answer-expand-enter-to,
.answer-expand-leave-from {
  opacity: 1;
  max-height: 1000px;
  transform: translateY(0);
}

/* FAQ Slide Transition */
.faq-slide-enter-active,
.faq-slide-leave-active {
  transition: all 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

.faq-slide-enter-from {
  opacity: 0;
  transform: translateX(-50px) scale(0.9);
}

.faq-slide-leave-to {
  opacity: 0;
  transform: translateX(50px) scale(0.9);
}

/* No Results State */
.no-results {
  text-align: center;
  padding: 4rem 2rem;
  background: rgba(255, 255, 255, 0.03);
  border: 1px solid rgba(255, 255, 255, 0.05);
  border-radius: 20px;
  animation: noResultsIn 0.8s ease-out;
}

@keyframes noResultsIn {
  from {
    opacity: 0;
    transform: translateY(30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.no-results-icon {
  width: 80px;
  height: 80px;
  background: rgba(164, 113, 72, 0.1);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 2rem;
}

.no-results-icon .material-icons {
  font-size: 2.5rem;
  color: #a47148;
}

.no-results h3 {
  font-size: 1.5rem;
  font-weight: 400;
  color: #FAFAF8;
  margin-bottom: 1rem;
}

.no-results p {
  color: #999;
  margin-bottom: 2rem;
  line-height: 1.6;
}

.no-results-actions {
  display: flex;
  justify-content: center;
  gap: 1rem;
}

.action-btn {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.75rem 1.5rem;
  background: transparent;
  border: 2px solid #a47148;
  color: #a47148;
  border-radius: 50px;
  cursor: pointer;
  transition: all 0.3s ease;
  font-size: 0.9rem;
  text-decoration: none;
}

.action-btn:hover {
  background: #a47148;
  color: #000;
  transform: translateY(-2px);
}

/* Quick Actions */
.faq-quick-actions {
  margin-top: 6rem;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
  gap: 2rem;
}

.quick-action-card {
  position: relative;
  display: grid;
  grid-template-columns: auto 1fr auto;
  align-items: center;
  gap: 2rem;
  padding: 2.5rem;
  background: linear-gradient(135deg, 
    rgba(164, 113, 72, 0.1) 0%, 
    rgba(255, 255, 255, 0.05) 100%);
  border: 1px solid rgba(164, 113, 72, 0.2);
  border-radius: 24px;
  transition: all 0.6s ease;
  overflow: hidden;
}

.quick-action-card::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 3px;
  background: linear-gradient(90deg, transparent, #a47148, transparent);
  transform: translateX(-100%);
  transition: transform 0.8s ease;
}

.quick-action-card:hover::before {
  transform: translateX(100%);
}

.quick-action-card:hover {
  transform: translateY(-10px) scale(1.02);
  box-shadow: 0 30px 60px rgba(164, 113, 72, 0.3);
  border-color: #a47148;
}

.action-icon {
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
  transition: all 0.6s ease;
}

.quick-action-card:hover .action-icon {
  transform: scale(1.1) rotateY(180deg);
  box-shadow: 0 0 30px rgba(164, 113, 72, 0.6);
}

.action-content {
  text-align: left;
}

.action-content h4 {
  font-size: 1.1rem;
  font-weight: 500;
  color: #FAFAF8;
  margin-bottom: 0.5rem;
}

.action-content p {
  color: #ccc;
  line-height: 1.6;
  font-size: 0.9rem;
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
  position: relative;
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
  top: 1.5rem;
  right: 1.5rem;
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
  z-index: 10;
  backdrop-filter: blur(10px);
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
}

.modal-btn {
  padding: 1rem 3rem;
  font-size: 1rem;
  font-weight: 600;
  letter-spacing: 0.05em;
  text-decoration: none;
  cursor: pointer;
  transition: all 0.3s ease;
  border-radius: 50px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 0.75rem;
  border: none;
}

.modal-btn.primary {
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  color: #000;
}

.modal-btn.full-width {
  width: 100%;
  max-width: 400px;
}

.modal-btn:hover {
  transform: translateY(-3px);
  box-shadow: 0 15px 30px rgba(164, 113, 72, 0.3);
}

/* Transitions */
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
  
  .premium-advantages {
    grid-template-columns: 1fr;
  }
  
  .features-luxury-grid {
    grid-template-columns: repeat(2, 1fr);
    gap: 1.5rem;
  }

  .category-filters {
    grid-template-columns: repeat(2, 1fr);
  }

  .faq-quick-actions {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 768px) {
  .hero-cta {
    flex-direction: column;
  }
  
  .modal-content {
    padding: 2rem;
  }

  .luxury-feature-content {
    padding: 1.5rem 1rem;
  }

  .luxury-feature-icon-3d {
    width: 60px;
    height: 60px;
  }

  .luxury-feature-title {
    font-size: 1.2rem;
  }

  .category-filters {
    grid-template-columns: 1fr;
  }

  .question-content {
    grid-template-columns: auto 1fr;
    gap: 1rem;
  }

  .question-toggle-wrapper {
    grid-column: 1 / -1;
    justify-self: center;
    margin-top: 1rem;
  }

  .helpful-question {
    flex-direction: column;
    align-items: center;
    gap: 1rem;
  }

  .features-grid {
    grid-template-columns: 1fr;
  }

  .features-luxury-grid {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 480px) {
  .section-title {
    font-size: 2rem;
  }

  .luxury-feature-card {
    min-height: 280px;
  }

  .features-luxury-grid {
    gap: 1rem;
  }

  .luxury-feature-icon-3d {
    width: 50px;
    height: 50px;
  }

  .showcase-title {
    font-size: 1.8rem;
  }

  .question-content {
    padding: 1.5rem;
    gap: 1rem;
  }

  .answer-content {
    padding: 0 1.5rem 1.5rem 1.5rem;
  }

  .luxury-faq-question {
    border-radius: 15px;
  }

  .luxury-faq-item {
    border-radius: 15px;
  }

  .quick-action-card {
    padding: 2rem;
    border-radius: 15px;
    grid-template-columns: auto 1fr;
    grid-template-rows: auto auto;
    gap: 1rem;
  }

  .action-btn {
    grid-column: 1 / -1;
    justify-self: center;
  }

  .btn-content {
    padding: 1.5rem;
  }
}

/* Performance Optimizations */
@media (prefers-reduced-motion: reduce) {
  *,
  *::before,
  *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
  }
}
</style>