<template>
  <div class="europe-page">
    <!-- Hero Section -->
    <section class="hero-section">
      <div class="hero-background">
        <div class="hero-overlay"></div>
        <img 
          src="https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b097a8069ca3ac95a.png" 
          alt="Architektur Group Europe"
          class="hero-image"
        >
      </div>
      <div class="hero-content">
        <div class="hero-text">
          <h1 class="hero-title">ARCHITEKTUR GROUP EUROPE</h1>
          <p class="hero-subtitle">Spezialisiert auf Frankreich & Schweiz</p>
          <p class="hero-description">Höchste Expertise und ein europaweites Netzwerk – perfekt zugeschnitten auf exklusive Projekte in Frankreich und der Schweiz</p>
        </div>
      </div>
    </section>

    <!-- International Presence -->
    <section class="presence-section">
      <div class="container">
        <div class="section-header">
          <h2 class="section-title">EUROPÄISCHE PRÄSENZ</h2>
          <p class="section-subtitle">Lokale Expertise, internationale Standards</p>
        </div>

        <div class="interactive-map">
          <div class="map-container">
            <!-- Simplified SVG Map of Europe -->
            <svg viewBox="0 0 800 600" class="europe-map">
              <!-- Germany -->
              <path 
                d="M400 200 L450 180 L480 220 L460 260 L420 280 L400 240 Z" 
                :class="['country', 'germany', { active: activeCountry === 'germany' }]"
                @click="setActiveCountry('germany')"
                @mouseenter="showCountryInfo('germany')"
              />
              
              <!-- France -->
              <path 
                d="M320 240 L380 220 L400 280 L380 350 L320 380 L280 340 L300 280 Z" 
                :class="['country', 'france', { active: activeCountry === 'france' }]"
                @click="setActiveCountry('france')"
                @mouseenter="showCountryInfo('france')"
              />
              
              <!-- Switzerland -->
              <path 
                d="M400 280 L440 270 L460 290 L450 310 L420 320 L400 300 Z" 
                :class="['country', 'switzerland', { active: activeCountry === 'switzerland' }]"
                @click="setActiveCountry('switzerland')"
                @mouseenter="showCountryInfo('switzerland')"
              />
              
              <!-- Office Markers -->
              <circle cx="430" cy="230" r="8" class="office-marker main" data-office="headquarter">
                <animate attributeName="r" values="8;12;8" dur="2s" repeatCount="indefinite"/>
              </circle>
              <circle cx="350" cy="310" r="6" class="office-marker" data-office="france"/>
              <circle cx="420" cy="295" r="6" class="office-marker" data-office="switzerland"/>
            </svg>

            <div class="map-legend">
              <div class="legend-item">
                <div class="legend-color main"></div>
                <span>Hauptsitz Deutschland</span>
              </div>
              <div class="legend-item">
                <div class="legend-color partner"></div>
                <span>Partnerbüros</span>
              </div>
              <div class="legend-item">
                <div class="legend-color active"></div>
                <span>Aktive Projekte</span>
              </div>
            </div>
          </div>

          <div class="country-details">
            <transition name="country-fade" mode="out-in">
              <div :key="activeCountry" class="country-card">
                <div class="country-header">
                  <div class="country-flag">
                    <img :src="countries[activeCountry].flag" :alt="countries[activeCountry].name">
                  </div>
                  <div class="country-info">
                    <h3>{{ countries[activeCountry].name }}</h3>
                    <p>{{ countries[activeCountry].role }}</p>
                  </div>
                </div>
                
                <div class="country-stats">
                  <div class="stat-item">
                    <div class="stat-number">{{ countries[activeCountry].projects }}+</div>
                    <div class="stat-label">Projekte</div>
                  </div>
                  <div class="stat-item">
                    <div class="stat-number">{{ countries[activeCountry].partners }}</div>
                    <div class="stat-label">Partner</div>
                  </div>
                  <div class="stat-item">
                    <div class="stat-number">{{ countries[activeCountry].experience }}</div>
                    <div class="stat-label">Jahre</div>
                  </div>
                </div>

                <div class="country-specialties">
                  <h4>Spezialisierungen:</h4>
                  <div class="specialty-tags">
                    <span v-for="specialty in countries[activeCountry].specialties" :key="specialty" class="specialty-tag">
                      {{ specialty }}
                    </span>
                  </div>
                </div>

                <div class="country-office">
                  <h4>Kontakt:</h4>
                  <div class="office-info">
                    <div class="office-address">
                      <span class="material-icons">location_on</span>
                      <span>{{ countries[activeCountry].office.address }}</span>
                    </div>
                    <div class="office-contact">
                      <span class="material-icons">phone</span>
                      <a :href="`tel:${countries[activeCountry].office.phone}`">{{ countries[activeCountry].office.phone }}</a>
                    </div>
                  </div>
                </div>
              </div>
            </transition>
          </div>
        </div>
      </div>
    </section>

    <!-- Services by Region -->
    <section class="services-region">
      <div class="container">
        <div class="section-header">
          <h2 class="section-title">REGIONALE EXPERTISE</h2>
          <p class="section-subtitle">Maßgeschneiderte Lösungen für jeden Markt</p>
        </div>

        <div class="region-tabs">
          <button 
            v-for="region in regions" 
            :key="region.id"
            @click="activeRegion = region.id"
            :class="['tab-btn', { active: activeRegion === region.id }]"
          >
            <img :src="region.flag" :alt="region.name" class="tab-flag">
            {{ region.name }}
          </button>
        </div>

        <div class="region-content">
          <transition name="region-slide" mode="out-in">
            <div :key="activeRegion" class="region-panel">
              <div class="region-overview">
                <div class="overview-text">
                  <h3>{{ currentRegion.name }}</h3>
                  <p class="region-description">{{ currentRegion.description }}</p>
                  
                  <div class="region-advantages">
                    <h4>Unsere Vorteile:</h4>
                    <ul class="advantages-list">
                      <li v-for="advantage in currentRegion.advantages" :key="advantage">
                        <span class="material-icons">check_circle</span>
                        {{ advantage }}
                      </li>
                    </ul>
                  </div>
                </div>
                
                <div class="overview-visual">
                  <div class="visual-card">
                    <img :src="currentRegion.image" :alt="currentRegion.name">
                    <div class="visual-overlay">
                      <div class="overlay-content">
                        <h4>{{ currentRegion.highlight.title }}</h4>
                        <p>{{ currentRegion.highlight.description }}</p>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <div class="services-grid">
                <div 
                  v-for="(service, index) in currentRegion.services" 
                  :key="service.id"
                  class="service-card"
                  :style="{ animationDelay: `${index * 0.1}s` }"
                  @click="openServiceDetails(service)"
                >
                  <div class="service-icon">
                    <span class="material-icons">{{ service.icon }}</span>
                  </div>
                  <div class="service-content">
                    <h4>{{ service.title }}</h4>
                    <p>{{ service.description }}</p>
                    <div class="service-features">
                      <span v-for="feature in service.features.slice(0, 3)" :key="feature" class="feature-tag">
                        {{ feature }}
                      </span>
                    </div>
                  </div>
                  <div class="service-action">
                    <span class="material-icons">arrow_forward</span>
                  </div>
                </div>
              </div>
            </div>
          </transition>
        </div>
      </div>
    </section>

    <!-- Project Showcase -->
    <section class="projects-showcase">
      <div class="container">
        <div class="section-header">
          <h2 class="section-title">INTERNATIONALE REFERENZEN</h2>
          <p class="section-subtitle">Prestigeprojekte in Europa</p>
        </div>

        <div class="showcase-carousel">
          <div class="projects-track" :style="{ transform: `translateX(-${currentProject * 100}%)` }">
            <div 
              v-for="project in showcaseProjects" 
              :key="project.id"
              class="project-slide"
            >
              <div class="project-image">
                <img :src="project.image" :alt="project.title">
                <div class="project-badge">
                  <img :src="project.countryFlag" :alt="project.country">
                  <span>{{ project.country }}</span>
                </div>
              </div>
              
              <div class="project-content">
                <div class="project-category">{{ project.category }}</div>
                <h3 class="project-title">{{ project.title }}</h3>
                <p class="project-location">
                  <span class="material-icons">location_on</span>
                  {{ project.location }}
                </p>
                
                <div class="project-details">
                  <div class="detail-item">
                    <span class="detail-label">Projektvolumen:</span>
                    <span class="detail-value">{{ project.volume }}</span>
                  </div>
                  <div class="detail-item">
                    <span class="detail-label">Fertigstellung:</span>
                    <span class="detail-value">{{ project.completion }}</span>
                  </div>
                  <div class="detail-item">
                    <span class="detail-label">Fläche:</span>
                    <span class="detail-value">{{ project.area }}</span>
                  </div>
                </div>
                
                <div class="project-description">
                  <p>{{ project.description }}</p>
                </div>
                
                <div class="project-technologies">
                  <h5>Eingesetzte Technologien:</h5>
                  <div class="tech-tags">
                    <span v-for="tech in project.technologies" :key="tech" class="tech-tag">
                      {{ tech }}
                    </span>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div class="carousel-navigation">
            <button @click="prevProject" class="nav-btn prev">
              <span class="material-icons">chevron_left</span>
            </button>
            
            <div class="project-indicators">
              <button 
                v-for="(project, index) in showcaseProjects" 
                :key="index"
                @click="currentProject = index"
                :class="['indicator', { active: currentProject === index }]"
              >
                <img :src="project.countryFlag" :alt="project.country">
              </button>
            </div>
            
            <button @click="nextProject" class="nav-btn next">
              <span class="material-icons">chevron_right</span>
            </button>
          </div>
        </div>
      </div>
    </section>

    <!-- Cultural Expertise -->
    <section class="cultural-section">
      <div class="container">
        <div class="section-header">
          <h2 class="section-title">KULTURELLE KOMPETENZ</h2>
          <p class="section-subtitle">Verstehen der lokalen Besonderheiten</p>
        </div>

        <div class="cultural-grid">
          <div 
            v-for="(aspect, index) in culturalAspects" 
            :key="aspect.id"
            class="cultural-card"
            :style="{ animationDelay: `${index * 0.2}s` }"
          >
            <div class="cultural-icon">
              <span class="material-icons">{{ aspect.icon }}</span>
            </div>
            <div class="cultural-content">
              <h4>{{ aspect.title }}</h4>
              <p>{{ aspect.description }}</p>
              
              <div class="cultural-examples">
                <h5>Beispiele:</h5>
                <ul>
                  <li v-for="example in aspect.examples" :key="example">{{ example }}</li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Partnership Network -->
    <section class="network-section">
      <div class="container">
        <div class="section-header">
          <h2 class="section-title">PARTNERNETZWERK</h2>
          <p class="section-subtitle">Starke Allianzen für perfekte Ergebnisse</p>
        </div>

        <div class="network-visualization">
          <div class="network-center">
            <div class="center-node">
              <div class="node-content">
                <span class="material-icons">business</span>
                <span>Architektur Group</span>
              </div>
            </div>
          </div>
          
          <div class="partner-nodes">
            <div 
              v-for="(partner, index) in partners" 
              :key="partner.id"
              class="partner-node"
              :style="getPartnerPosition(index)"
              @click="selectPartner(partner)"
              :class="{ active: selectedPartner?.id === partner.id }"
            >
              <div class="node-content">
                <div class="partner-logo">
                  <span class="material-icons">{{ partner.icon }}</span>
                </div>
                <div class="partner-info">
                  <span class="partner-name">{{ partner.name }}</span>
                  <span class="partner-type">{{ partner.type }}</span>
                </div>
              </div>
              
              <div class="connection-line" :style="getConnectionStyle(index)"></div>
            </div>
          </div>
        </div>

        <div v-if="selectedPartner" class="partner-details">
          <div class="partner-detail-card">
            <div class="partner-header">
              <div class="partner-logo-large">
                <span class="material-icons">{{ selectedPartner.icon }}</span>
              </div>
              <div class="partner-meta">
                <h3>{{ selectedPartner.name }}</h3>
                <p class="partner-location">
                  <span class="material-icons">location_on</span>
                  {{ selectedPartner.location }}
                </p>
              </div>
            </div>
            
            <div class="partner-content">
              <div class="partner-description">
                <p>{{ selectedPartner.description }}</p>
              </div>
              
              <div class="partner-specialties">
                <h4>Spezialisierungen:</h4>
                <div class="specialty-list">
                  <span v-for="specialty in selectedPartner.specialties" :key="specialty" class="specialty-item">
                    {{ specialty }}
                  </span>
                </div>
              </div>
              
              <div class="collaboration-projects">
                <h4>Gemeinsame Projekte:</h4>
                <div class="project-count">{{ selectedPartner.projects }} erfolgreich abgeschlossen</div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Service Modal -->
    <transition name="modal">
      <div v-if="selectedService" class="modal-overlay" @click="closeServiceModal">
        <div class="modal-content" @click.stop>
          <button class="modal-close" @click="closeServiceModal">
            <span class="material-icons">close</span>
          </button>
          
          <div class="modal-header">
            <div class="service-icon-large">
              <span class="material-icons">{{ selectedService.icon }}</span>
            </div>
            <div class="service-meta">
              <h2>{{ selectedService.title }}</h2>
              <p>{{ selectedService.region }}</p>
            </div>
          </div>
          
          <div class="modal-body">
            <div class="service-full-description">
              <p>{{ selectedService.fullDescription }}</p>
            </div>
            
            <div class="service-process">
              <h3>Unser Vorgehen:</h3>
              <div class="process-timeline">
                <div 
                  v-for="(step, index) in selectedService.process" 
                  :key="index"
                  class="timeline-step"
                >
                  <div class="step-marker">{{ index + 1 }}</div>
                  <div class="step-content">
                    <h4>{{ step.title }}</h4>
                    <p>{{ step.description }}</p>
                  </div>
                </div>
              </div>
            </div>
            
            <div class="service-benefits">
              <h3>Ihre Vorteile:</h3>
              <div class="benefits-grid">
                <div v-for="benefit in selectedService.benefits" :key="benefit.title" class="benefit-item">
                  <span class="material-icons">{{ benefit.icon }}</span>
                  <div class="benefit-content">
                    <h4>{{ benefit.title }}</h4>
                    <p>{{ benefit.description }}</p>
                  </div>
                </div>
              </div>
            </div>
            
            <div class="modal-actions">
              <NuxtLink to="/kontakt" class="cta-button primary">PROJEKT BESPRECHEN</NuxtLink>
              <button @click="closeServiceModal" class="cta-button secondary">SCHLIEßEN</button>
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
          <h2 class="cta-title">BEREIT FÜR IHR EUROPÄISCHES PROJEKT?</h2>
          <p class="cta-text">
            Nutzen Sie unsere internationale Expertise und unser starkes Partnernetzwerk für Ihr nächstes Projekt.
            Von der ersten Beratung bis zur finalen Umsetzung – wir begleiten Sie grenzüberschreitend zum Erfolg.
          </p>
          
          <div class="cta-stats">
            <div class="cta-stat">
              <div class="stat-number">150+</div>
              <div class="stat-label">Internationale Projekte</div>
            </div>
            <div class="cta-stat">
              <div class="stat-number">3</div>
              <div class="stat-label">Länder-Expertise</div>
            </div>
            <div class="cta-stat">
              <div class="stat-number">25+</div>
              <div class="stat-label">Partnerbetriebe</div>
            </div>
          </div>
          
          <div class="cta-actions">
            <NuxtLink to="/kontakt" class="cta-button primary">
              <span class="material-icons">handshake</span>
              INTERNATIONALE BERATUNG
            </NuxtLink>
            <button @click="downloadBrochure" class="cta-button secondary">
              <span class="material-icons">download</span>
              BROSCHÜRE HERUNTERLADEN
            </button>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
const activeCountry = ref('germany')
const activeRegion = ref('germany')
const currentProject = ref(0)
const selectedPartner = ref(null)
const selectedService = ref(null)

let projectInterval = null

const countries = {
  germany: {
    name: 'Deutschland',
    role: 'Hauptsitz & Zentrale',
    flag: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png',
    projects: 500,
    partners: 15,
    experience: 25,
    specialties: ['Naturstein', 'Keramik', 'Gartengestaltung', 'Badezimmer'],
    office: {
      address: 'Starnberg, Bayern',
      phone: '+49 8171 3868770'
    }
  },
  france: {
    name: 'Frankreich',
    role: 'Spezialist für Luxusimmobilien',
    flag: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png',
    projects: 120,
    partners: 8,
    experience: 15,
    specialties: ['Château-Renovierungen', 'Marmor', 'Französische Klassik', 'Terrassen'],
    office: {
      address: 'Lyon, Rhône-Alpes',
      phone: '+33 4 7842 1567'
    }
  },
  switzerland: {
    name: 'Schweiz',
    role: 'Premium Alpine Architektur',
    flag: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b70b0803723582ed6.png',
    projects: 80,
    partners: 6,
    experience: 12,
    specialties: ['Alpine Gestaltung', 'Wellness', 'Chalet-Design', 'Naturstein'],
    office: {
      address: 'Zermatt, Wallis',
      phone: '+41 27 967 3456'
    }
  }
}

const regions = [
  { 
    id: 'germany', 
    name: 'Deutschland', 
    flag: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png' 
  },
  { 
    id: 'france', 
    name: 'Frankreich', 
    flag: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png' 
  },
  { 
    id: 'switzerland', 
    name: 'Schweiz', 
    flag: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b70b0803723582ed6.png' 
  }
]

const regionData = {
  germany: {
    name: 'Deutschland',
    description: 'Als unser Hauptsitz bietet Deutschland die volle Bandbreite unserer Expertise. Von traditioneller Handwerkskunst bis zu modernster Technologie.',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png',
    advantages: [
      'Direkter Zugang zu deutschen Qualitätsstandards',
      'Umfassendes Partnernetzwerk',
      'Komplette Projektabwicklung vor Ort',
      'Kurze Lieferwege und schnelle Reaktionszeiten'
    ],
    highlight: {
      title: 'Deutsche Präzision',
      description: 'Höchste Qualitätsstandards und bewährte Handwerkskunst'
    },
    services: [
      {
        id: 'de-naturstein',
        title: 'Natursteinverarbeitung',
        description: 'Traditionelle deutsche Steinmetzkunst',
        icon: 'landscape',
        features: ['Handwerkstradition', 'Präzision', 'Qualität'],
        fullDescription: 'Unsere deutschen Steinmetze verbinden jahrhundertealte Handwerkskunst mit modernsten Technologien.',
        region: 'Deutschland',
        process: [
          { title: 'Materialauswahl', description: 'Auswahl aus deutschen und europäischen Steinbrüchen' },
          { title: 'Bearbeitung', description: 'Präzise Bearbeitung in deutschen Werkstätten' },
          { title: 'Qualitätskontrolle', description: 'Strenge deutsche Qualitätsstandards' }
        ],
        benefits: [
          { icon: 'precision_manufacturing', title: 'Deutsche Präzision', description: 'Millimetergenaue Bearbeitung' },
          { icon: 'verified', title: 'Qualitätssicherung', description: 'Umfassende Qualitätskontrollen' }
        ]
      },
      {
        id: 'de-innovation',
        title: 'Technologie & Innovation',
        description: 'Modernste Verfahren und Materialien',
        icon: 'science',
        features: ['Innovation', 'Technologie', 'Forschung'],
        fullDescription: 'Deutschland als Innovationsstandort ermöglicht uns den Einsatz neuester Technologien.',
        region: 'Deutschland'
      }
    ]
  },
  france: {
    name: 'Frankreich',
    description: 'Frankreich steht für Eleganz und Luxus. Unsere französischen Partner verstehen die besonderen Anforderungen an Stil und Raffinesse.',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png',
    advantages: [
      'Expertise in französischer Architektur',
      'Zugang zu exklusiven Materialien',
      'Verständnis für französischen Stil',
      'Lokale Behörden und Vorschriften'
    ],
    highlight: {
      title: 'Savoir-vivre',
      description: 'Französische Eleganz und Lebenskunst in jedem Detail'
    },
    services: [
      {
        id: 'fr-chateau',
        title: 'Château-Renovierungen',
        description: 'Denkmalgerechte Sanierung historischer Gebäude',
        icon: 'castle',
        features: ['Denkmalschutz', 'Historie', 'Authentizität'],
        fullDescription: 'Spezialisiert auf die Restaurierung französischer Schlösser und Herrenhäuser unter Berücksichtigung aller Denkmalschutzauflagen.'
      },
      {
        id: 'fr-luxury',
        title: 'Luxus-Residenzen',
        description: 'Exklusive Ausstattung für anspruchsvolle Kunden',
        icon: 'diamond',
        features: ['Luxus', 'Exklusivität', 'Perfektion']
      }
    ]
  },
  switzerland: {
    name: 'Schweiz',
    description: 'Die Schweiz verbindet alpine Tradition mit höchsten Qualitätsansprüchen. Perfekt für Wellness- und Chalet-Projekte.',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b70b0803723582ed6.png',
    advantages: [
      'Alpine Architektur-Expertise',
      'Schweizer Qualitätsstandards',
      'Wellness und Spa Spezialisierung',
      'Umgang mit extremen Witterungsbedingungen'
    ],
    highlight: {
      title: 'Alpine Perfektion',
      description: 'Höchste Schweizer Qualität für einzigartige Bergprojekte'
    },
    services: [
      {
        id: 'ch-chalet',
        title: 'Chalet-Design',
        description: 'Authentische alpine Gestaltung',
        icon: 'cabin',
        features: ['Tradition', 'Alpenstil', 'Gemütlichkeit']
      },
      {
        id: 'ch-wellness',
        title: 'Wellness & Spa',
        description: 'Luxuriöse Entspannungsbereiche',
        icon: 'spa',
        features: ['Wellness', 'Entspannung', 'Luxus']
      }
    ]
  }
}

const showcaseProjects = [
  {
    id: 1,
    title: 'Château de Versailles Privat-Residenz',
    category: 'Luxus-Sanierung',
    location: 'Versailles, Frankreich',
    country: 'Frankreich',
    countryFlag: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png',
    volume: '€ 2.8 Mio.',
    completion: '2023',
    area: '1.200 m²',
    description: 'Denkmalgerechte Sanierung eines historischen Anwesens mit modernster Technik bei Erhalt der ursprünglichen Eleganz.',
    technologies: ['Carrara Marmor', 'Historische Techniken', 'Denkmalschutz', 'Moderne Integration']
  },
  {
    id: 2,
    title: 'Alpine Wellness Resort',
    category: 'Wellness & Spa',
    location: 'Zermatt, Schweiz',
    country: 'Schweiz',
    countryFlag: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b70b0803723582ed6.png',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b70b0803723582ed6.png',
    volume: '€ 4.2 Mio.',
    completion: '2024',
    area: '2.500 m²',
    description: 'Exklusives Wellness-Resort mit natürlichen Materialien und atemberaubendem Matterhorn-Blick.',
    technologies: ['Naturstein', 'Wellness-Technik', 'Alpine Integration', 'Nachhaltigkeit']
  },
  {
    id: 3,
    title: 'Villa am Starnberger See',
    category: 'Privatvilla',
    location: 'Starnberg, Deutschland',
    country: 'Deutschland',
    countryFlag: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png',
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png',
    volume: '€ 1.9 Mio.',
    completion: '2023',
    area: '800 m²',
    description: 'Moderne Seevilla mit deutscher Präzision und italienischen Designelementen.',
    technologies: ['Feinsteinzeug', 'Smart Home', 'Seeblick-Optimierung', 'Deutsche Technik']
  }
]

const culturalAspects = [
  {
    id: 1,
    icon: 'gavel',
    title: 'Rechtliche Expertise',
    description: 'Umfassende Kenntnis der lokalen Bauvorschriften, Genehmigungsverfahren und Denkmalschutzbestimmungen.',
    examples: [
      'Französische ABF (Architectes des Bâtiments de France) Verfahren',
      'Schweizer Bauzonenordnungen',
      'Deutsche DIN-Normen und EnEV-Bestimmungen'
    ]
  },
  {
    id: 2,
    icon: 'language',
    title: 'Sprachkompetenz',
    description: 'Muttersprachliche Projektabwicklung und kulturelle Sensibilität in allen Geschäftsbereichen.',
    examples: [
      'Verhandlungen mit lokalen Behörden',
      'Koordination internationaler Teams',
      'Technische Dokumentation in Landessprache'
    ]
  },
  {
    id: 3,
    icon: 'handshake',
    title: 'Geschäftskulturen',
    description: 'Tiefes Verständnis für regionale Geschäftspraktiken und Kommunikationsstile.',
    examples: [
      'Deutsche Gründlichkeit und Pünktlichkeit',
      'Französische Eleganz und Savoir-vivre',
      'Schweizer Präzision und Diskretion'
    ]
  },
  {
    id: 4,
    icon: 'architecture',
    title: 'Architekturstile',
    description: 'Expertise in regionaltypischen Baustilen und traditionellen Handwerkstechniken.',
    examples: [
      'Barocke französische Schlossarchitektur',
      'Alpine Chaletbauweise',
      'Deutsche Fachwerktradition'
    ]
  }
]

const partners = [
  {
    id: 1,
    name: 'Marmor Français',
    type: 'Natursteinlieferant',
    location: 'Lyon, France',
    icon: 'diamond',
    description: 'Führender französischer Marmorlieferant mit eigenen Steinbrüchen.',
    specialties: ['Carrara Marmor', 'Französischer Kalkstein', 'Antike Restaurierung'],
    projects: 45
  },
  {
    id: 2,
    name: 'Alpine Wellness Tech',
    type: 'Wellnesstechnik',
    location: 'Zürich, Switzerland',
    icon: 'spa',
    description: 'Spezialist für hochwertige Wellness- und Spa-Installationen.',
    specialties: ['Spa-Technik', 'Saunabau', 'Wassertechnik'],
    projects: 28
  },
  {
    id: 3,
    name: 'Deutsche Steinmetz AG',
    type: 'Handwerk',
    location: 'München, Deutschland',
    icon: 'construction',
    description: 'Traditioneller Steinmetzbetrieb mit moderner Technologie.',
    specialties: ['Natursteinbearbeitung', 'Denkmalpflege', 'Skulpturen'],
    projects: 67
  },
  {
    id: 4,
    name: 'Château Restauration',
    type: 'Denkmalpflege',
    location: 'Paris, France',
    icon: 'castle',
    description: 'Spezialisiert auf die Restaurierung historischer Gebäude.',
    specialties: ['Denkmalschutz', 'Historische Techniken', 'Authentizität'],
    projects: 23
  },
  {
    id: 5,
    name: 'Swiss Precision Ceramics',
    type: 'Keramiklieferant',
    location: 'Basel, Switzerland',
    icon: 'ceramic',
    description: 'Hochpräzise Keramikprodukte für anspruchsvolle Projekte.',
    specialties: ['Präzisionskeramik', 'Großformat', 'Spezialanfertigungen'],
    projects: 34
  },
  {
    id: 6,
    name: 'European Logistics',
    type: 'Logistik',
    location: 'Frankfurt, Deutschland',
    icon: 'local_shipping',
    description: 'Spezialisiert auf Schwertransporte und internationale Logistik.',
    specialties: ['Schwertransport', 'Zollabwicklung', 'Lagerung'],
    projects: 89
  }
]

const currentRegion = computed(() => regionData[activeRegion])

const setActiveCountry = (country) => {
  activeCountry.value = country
}

const showCountryInfo = (country) => {
  if (activeCountry.value !== country) {
    setActiveCountry(country)
  }
}

const openServiceDetails = (service) => {
  selectedService.value = service
  document.body.style.overflow = 'hidden'
}

const closeServiceModal = () => {
  selectedService.value = null
  document.body.style.overflow = 'auto'
}

const selectPartner = (partner) => {
  selectedPartner.value = selectedPartner.value?.id === partner.id ? null : partner
}

const getPartnerPosition = (index) => {
  const angle = (index * 60) * (Math.PI / 180)
  const radius = 200
  const x = Math.cos(angle) * radius
  const y = Math.sin(angle) * radius
  
  return {
    transform: `translate(${x}px, ${y}px)`
  }
}

const getConnectionStyle = (index) => {
  const angle = (index * 60) * (Math.PI / 180)
  const length = 200
  
  return {
    width: `${length}px`,
    transform: `rotate(${angle + Math.PI}rad)`,
    transformOrigin: '100% 50%'
  }
}

const prevProject = () => {
  currentProject.value = currentProject.value === 0 ? showcaseProjects.length - 1 : currentProject.value - 1
}

const nextProject = () => {
  currentProject.value = (currentProject.value + 1) % showcaseProjects.length
}

const downloadBrochure = () => {
  console.log('Downloading Europe brochure...')
  // Hier könnte eine echte Download-Funktion implementiert werden
}

onMounted(() => {
  // Auto-cycle through projects
  projectInterval = setInterval(() => {
    nextProject()
  }, 8000)
})

onUnmounted(() => {
  if (projectInterval) {
    clearInterval(projectInterval)
  }
  document.body.style.overflow = 'auto'
})
</script>

<style scoped>
.europe-page {
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

/* Presence Section */
.presence-section {
  padding: 6rem 0;
  background: linear-gradient(135deg, #0a0a0a 0%, #1a1a1a 100%);
}

.interactive-map {
  display: grid;
  grid-template-columns: 1fr 400px;
  gap: 4rem;
  align-items: start;
}

.map-container {
  background: rgba(255, 255, 255, 0.05);
  border-radius: 20px;
  padding: 2rem;
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.1);
  position: relative;
}

.europe-map {
  width: 100%;
  height: 400px;
}

.country {
  fill: rgba(255, 255, 255, 0.1);
  stroke: rgba(255, 255, 255, 0.3);
  stroke-width: 2;
  cursor: pointer;
  transition: all 0.3s ease;
}

.country:hover,
.country.active {
  fill: rgba(164, 113, 72, 0.3);
  stroke: #a47148;
}

.office-marker {
  fill: #a47148;
  cursor: pointer;
  transition: all 0.3s ease;
}

.office-marker:hover {
  fill: #FAFAF8;
  transform: scale(1.2);
}

.office-marker.main {
  fill: #FAFAF8;
  stroke: #a47148;
  stroke-width: 2;
}

.map-legend {
  position: absolute;
  bottom: 1rem;
  left: 1rem;
  background: rgba(0, 0, 0, 0.7);
  padding: 1rem;
  border-radius: 10px;
  backdrop-filter: blur(10px);
}

.legend-item {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  margin-bottom: 0.5rem;
  font-size: 0.8rem;
}

.legend-color {
  width: 12px;
  height: 12px;
  border-radius: 50%;
}

.legend-color.main {
  background: #FAFAF8;
  border: 2px solid #a47148;
}

.legend-color.partner {
  background: #a47148;
}

.legend-color.active {
  background: rgba(164, 113, 72, 0.5);
}

.country-details {
  background: rgba(255, 255, 255, 0.05);
  border-radius: 20px;
  padding: 2rem;
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.1);
  height: fit-content;
}

.country-card {
  animation: countryCardFadeIn 0.5s ease-out;
}

.country-header {
  display: flex;
  align-items: center;
  gap: 1rem;
  margin-bottom: 2rem;
}

.country-flag {
  width: 60px;
  height: 60px;
  border-radius: 50%;
  overflow: hidden;
  border: 2px solid #a47148;
}

.country-flag img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.country-info h3 {
  font-size: 1.5rem;
  font-weight: 400;
  color: #FAFAF8;
  margin-bottom: 0.5rem;
}

.country-info p {
  color: #a47148;
  font-size: 1rem;
}

.country-stats {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 1rem;
  margin-bottom: 2rem;
}

.stat-item {
  text-align: center;
  padding: 1rem;
  background: rgba(255, 255, 255, 0.05);
  border-radius: 10px;
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.stat-number {
  font-size: 1.5rem;
  font-weight: 600;
  color: #a47148;
  margin-bottom: 0.5rem;
}

.stat-label {
  font-size: 0.9rem;
  color: #ccc;
}

.country-specialties,
.country-office {
  margin-bottom: 1.5rem;
}

.country-specialties h4,
.country-office h4 {
  font-size: 1.1rem;
  font-weight: 400;
  color: #FAFAF8;
  margin-bottom: 1rem;
}

.specialty-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 0.5rem;
}

.specialty-tag {
  padding: 0.4rem 0.8rem;
  background: rgba(164, 113, 72, 0.2);
  color: #a47148;
  font-size: 0.8rem;
  border-radius: 12px;
  border: 1px solid rgba(164, 113, 72, 0.3);
}

.office-info {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.office-address,
.office-contact {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  color: #ccc;
}

.office-contact a {
  color: #FAFAF8;
  text-decoration: none;
  transition: color 0.3s ease;
}

.office-contact a:hover {
  color: #a47148;
}

/* Services by Region */
.services-region {
  padding: 6rem 0;
}

.region-tabs {
  display: flex;
  justify-content: center;
  gap: 1rem;
  margin-bottom: 3rem;
}

.tab-btn {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  padding: 1rem 2rem;
  background: rgba(255, 255, 255, 0.05);
  border: 2px solid rgba(255, 255, 255, 0.2);
  color: #FAFAF8;
  border-radius: 25px;
  cursor: pointer;
  transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  font-size: 1rem;
}

.tab-flag {
  width: 24px;
  height: 24px;
  border-radius: 50%;
  object-fit: cover;
}

.tab-btn:hover {
  background: rgba(255, 255, 255, 0.08);
  border-color: rgba(164, 113, 72, 0.5);
}

.tab-btn.active {
  background: rgba(164, 113, 72, 0.2);
  border-color: #a47148;
  color: #a47148;
}

.region-content {
  max-width: 1200px;
  margin: 0 auto;
}

.region-panel {
  animation: regionSlideIn 0.6s ease-out;
}

.region-overview {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 3rem;
  margin-bottom: 4rem;
}

.overview-text h3 {
  font-size: 2rem;
  font-weight: 400;
  margin-bottom: 1rem;
  color: #FAFAF8;
}

.region-description {
  font-size: 1.1rem;
  line-height: 1.6;
  color: #ccc;
  margin-bottom: 2rem;
}

.region-advantages h4 {
  font-size: 1.2rem;
  font-weight: 400;
  color: #FAFAF8;
  margin-bottom: 1rem;
}

.advantages-list {
  list-style: none;
  padding: 0;
}

.advantages-list li {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  margin-bottom: 0.75rem;
  color: #ccc;
}

.advantages-list .material-icons {
  color: #a47148;
  font-size: 1.2rem;
}

.overview-visual {
  position: relative;
}

.visual-card {
  position: relative;
  height: 300px;
  border-radius: 15px;
  overflow: hidden;
  box-shadow: 0 15px 30px rgba(164, 113, 72, 0.2);
}

.visual-card img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.visual-overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(45deg, rgba(0,0,0,0.7), transparent);
  display: flex;
  align-items: end;
  padding: 2rem;
}

.overlay-content h4 {
  font-size: 1.3rem;
  font-weight: 400;
  color: #FAFAF8;
  margin-bottom: 0.5rem;
}

.overlay-content p {
  color: #ccc;
  font-size: 1rem;
}

.services-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
}

.service-card {
  background: rgba(255, 255, 255, 0.05);
  border-radius: 20px;
  padding: 2rem;
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.1);
  cursor: pointer;
  transition: all 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  animation: serviceCardFadeIn 0.8s ease-out forwards;
  opacity: 0;
  transform: translateY(30px);
  display: flex;
  flex-direction: column;
}

.service-card:hover {
  transform: translateY(-10px);
  background: rgba(255, 255, 255, 0.08);
  box-shadow: 0 20px 40px rgba(164, 113, 72, 0.3);
}

.service-icon {
  width: 60px;
  height: 60px;
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #000;
  font-size: 1.5rem;
  margin-bottom: 1.5rem;
}

.service-content {
  flex: 1;
}

.service-content h4 {
  font-size: 1.3rem;
  font-weight: 400;
  margin-bottom: 1rem;
  color: #FAFAF8;
}

.service-content p {
  font-size: 1rem;
  line-height: 1.6;
  color: #ccc;
  margin-bottom: 1.5rem;
}

.service-features {
  display: flex;
  flex-wrap: wrap;
  gap: 0.5rem;
  margin-bottom: 1rem;
}

.feature-tag {
  padding: 0.3rem 0.7rem;
  background: rgba(164, 113, 72, 0.2);
  color: #a47148;
  font-size: 0.8rem;
  border-radius: 10px;
  border: 1px solid rgba(164, 113, 72, 0.3);
}

.service-action {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 40px;
  height: 40px;
  background: rgba(255, 255, 255, 0.1);
  border-radius: 50%;
  color: #a47148;
  transition: all 0.3s ease;
  margin-top: auto;
}

.service-card:hover .service-action {
  background: #a47148;
  color: #000;
  transform: translateX(5px);
}

/* Project Showcase */
.projects-showcase {
  padding: 6rem 0;
  background: linear-gradient(135deg, #1a1a1a 0%, #0a0a0a 100%);
}

.showcase-carousel {
  position: relative;
  overflow: hidden;
  border-radius: 20px;
  background: rgba(255, 255, 255, 0.05);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.projects-track {
  display: flex;
  transition: transform 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

.project-slide {
  min-width: 100%;
  display: grid;
  grid-template-columns: 1fr 1fr;
  min-height: 500px;
}

.project-image {
  position: relative;
  overflow: hidden;
}

.project-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.project-badge {
  position: absolute;
  top: 1rem;
  left: 1rem;
  display: flex;
  align-items: center;
  gap: 0.5rem;
  background: rgba(0, 0, 0, 0.7);
  padding: 0.5rem 1rem;
  border-radius: 20px;
  backdrop-filter: blur(10px);
}

.project-badge img {
  width: 20px;
  height: 20px;
  border-radius: 50%;
  object-fit: cover;
}

.project-badge span {
  color: #FAFAF8;
  font-size: 0.9rem;
}

.project-content {
  padding: 3rem;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.project-category {
  color: #a47148;
  font-size: 0.9rem;
  text-transform: uppercase;
  letter-spacing: 0.1em;
  margin-bottom: 1rem;
}

.project-title {
  font-size: 2rem;
  font-weight: 400;
  color: #FAFAF8;
  margin-bottom: 1rem;
}

.project-location {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  color: #ccc;
  margin-bottom: 2rem;
}

.project-details {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 1rem;
  margin-bottom: 2rem;
}

.detail-item {
  display: flex;
  flex-direction: column;
  gap: 0.25rem;
}

.detail-label {
  font-size: 0.8rem;
  color: #999;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.detail-value {
  font-size: 1rem;
  color: #FAFAF8;
  font-weight: 500;
}

.project-description {
  margin-bottom: 2rem;
}

.project-description p {
  font-size: 1rem;
  line-height: 1.6;
  color: #ccc;
}

.project-technologies h5 {
  font-size: 1rem;
  color: #FAFAF8;
  margin-bottom: 1rem;
}

.tech-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 0.5rem;
}

.tech-tag {
  padding: 0.4rem 0.8rem;
  background: rgba(164, 113, 72, 0.2);
  color: #a47148;
  font-size: 0.8rem;
  border-radius: 12px;
  border: 1px solid rgba(164, 113, 72, 0.3);
}

.carousel-navigation {
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

.nav-btn {
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

.nav-btn:hover {
  background: #a47148;
  transform: scale(1.1);
}

.project-indicators {
  display: flex;
  gap: 0.75rem;
}

.project-indicators .indicator {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  border: 2px solid rgba(255, 255, 255, 0.3);
  cursor: pointer;
  transition: all 0.3s ease;
  overflow: hidden;
  display: flex;
  align-items: center;
  justify-content: center;
  background: none;
}

.project-indicators .indicator img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.project-indicators .indicator.active {
  border-color: #a47148;
  transform: scale(1.2);
}

/* Cultural Expertise */
.cultural-section {
  padding: 6rem 0;
}

.cultural-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
  max-width: 1200px;
  margin: 0 auto;
}

.cultural-card {
  background: rgba(255, 255, 255, 0.05);
  border-radius: 20px;
  padding: 2.5rem;
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.1);
  transition: all 0.6s ease;
  animation: culturalFadeIn 0.8s ease-out forwards;
  opacity: 0;
  transform: translateY(30px);
}

.cultural-card:hover {
  transform: translateY(-5px);
  background: rgba(255, 255, 255, 0.08);
}

.cultural-icon {
  width: 60px;
  height: 60px;
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #000;
  font-size: 1.5rem;
  margin-bottom: 1.5rem;
}

.cultural-content h4 {
  font-size: 1.3rem;
  font-weight: 400;
  margin-bottom: 1rem;
  color: #FAFAF8;
}

.cultural-content p {
  font-size: 1rem;
  line-height: 1.6;
  color: #ccc;
  margin-bottom: 2rem;
}

.cultural-examples h5 {
  font-size: 1rem;
  color: #a47148;
  margin-bottom: 0.75rem;
}

.cultural-examples ul {
  list-style: none;
  padding: 0;
}

.cultural-examples li {
  font-size: 0.9rem;
  color: #999;
  margin-bottom: 0.5rem;
  position: relative;
  padding-left: 1rem;
}

.cultural-examples li:before {
  content: '•';
  position: absolute;
  left: 0;
  color: #a47148;
  font-weight: bold;
}

/* Partnership Network */
.network-section {
  padding: 6rem 0;
  background: linear-gradient(135deg, #0a0a0a 0%, #1a1a1a 100%);
}

.network-visualization {
  position: relative;
  width: 100%;
  height: 500px;
  margin-bottom: 3rem;
}

.network-center {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  z-index: 10;
}

.center-node {
  width: 120px;
  height: 120px;
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 10px 30px rgba(164, 113, 72, 0.4);
}

.center-node .node-content {
  text-align: center;
  color: #000;
}

.center-node .material-icons {
  font-size: 2rem;
  margin-bottom: 0.5rem;
}

.center-node span {
  font-size: 0.8rem;
  font-weight: 600;
}

.partner-nodes {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}

.partner-node {
  position: absolute;
  width: 80px;
  height: 80px;
  background: rgba(255, 255, 255, 0.05);
  border: 2px solid rgba(255, 255, 255, 0.2);
  border-radius: 50%;
  cursor: pointer;
  transition: all 0.4s ease;
  backdrop-filter: blur(10px);
}

.partner-node:hover,
.partner-node.active {
  background: rgba(164, 113, 72, 0.2);
  border-color: #a47148;
  transform: translate(var(--x, 0), var(--y, 0)) scale(1.1);
}

.partner-node .node-content {
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  text-align: center;
  padding: 0.5rem;
}

.partner-logo .material-icons {
  font-size: 1.5rem;
  color: #a47148;
  margin-bottom: 0.25rem;
}

.partner-name {
  font-size: 0.7rem;
  color: #FAFAF8;
  margin-bottom: 0.125rem;
}

.partner-type {
  font-size: 0.6rem;
  color: #999;
}

.connection-line {
  position: absolute;
  top: 50%;
  left: 50%;
  height: 1px;
  background: linear-gradient(90deg, rgba(164, 113, 72, 0.5), transparent);
  pointer-events: none;
  z-index: -1;
}

.partner-details {
  max-width: 800px;
  margin: 0 auto;
}

.partner-detail-card {
  background: rgba(255, 255, 255, 0.05);
  border-radius: 20px;
  padding: 2.5rem;
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.1);
  animation: partnerDetailSlideIn 0.5s ease-out;
}

.partner-header {
  display: flex;
  align-items: center;
  gap: 2rem;
  margin-bottom: 2rem;
}

.partner-logo-large {
  width: 80px;
  height: 80px;
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #000;
  font-size: 2rem;
}

.partner-meta h3 {
  font-size: 1.8rem;
  font-weight: 400;
  color: #FAFAF8;
  margin-bottom: 0.5rem;
}

.partner-location {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  color: #ccc;
}

.partner-content {
  display: grid;
  grid-template-columns: 1fr;
  gap: 2rem;
}

.partner-description p {
  font-size: 1.1rem;
  line-height: 1.6;
  color: #ccc;
}

.partner-specialties h4,
.collaboration-projects h4 {
  font-size: 1.2rem;
  color: #FAFAF8;
  margin-bottom: 1rem;
}

.specialty-list {
  display: flex;
  flex-wrap: wrap;
  gap: 0.5rem;
}

.specialty-item {
  padding: 0.4rem 0.8rem;
  background: rgba(164, 113, 72, 0.2);
  color: #a47148;
  font-size: 0.8rem;
  border-radius: 12px;
  border: 1px solid rgba(164, 113, 72, 0.3);
}

.project-count {
  font-size: 1.5rem;
  font-weight: 600;
  color: #a47148;
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

.modal-header {
  display: flex;
  align-items: center;
  gap: 2rem;
  padding: 3rem 3rem 2rem;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.service-icon-large {
  width: 80px;
  height: 80px;
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #000;
  font-size: 2rem;
}

.service-meta h2 {
  font-size: 2rem;
  font-weight: 400;
  color: #FAFAF8;
  margin-bottom: 0.5rem;
}

.service-meta p {
  color: #a47148;
  font-size: 1rem;
}

.modal-body {
  padding: 2rem 3rem 3rem;
}

.service-full-description {
  margin-bottom: 3rem;
}

.service-full-description p {
  font-size: 1.1rem;
  line-height: 1.6;
  color: #ccc;
}

.service-process,
.service-benefits {
  margin-bottom: 3rem;
}

.service-process h3,
.service-benefits h3 {
  font-size: 1.5rem;
  font-weight: 400;
  color: #FAFAF8;
  margin-bottom: 2rem;
}

.process-timeline {
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
}

.timeline-step {
  display: flex;
  gap: 1rem;
  align-items: flex-start;
}

.step-marker {
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

.step-content h4 {
  font-size: 1.1rem;
  font-weight: 400;
  color: #FAFAF8;
  margin-bottom: 0.5rem;
}

.step-content p {
  font-size: 1rem;
  color: #ccc;
  line-height: 1.6;
}

.benefits-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 1.5rem;
}

.benefit-item {
  display: flex;
  gap: 1rem;
  padding: 1.5rem;
  background: rgba(255, 255, 255, 0.05);
  border-radius: 15px;
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.benefit-item .material-icons {
  color: #a47148;
  font-size: 1.5rem;
  flex-shrink: 0;
}

.benefit-content h4 {
  font-size: 1rem;
  font-weight: 400;
  color: #FAFAF8;
  margin-bottom: 0.5rem;
}

.benefit-content p {
  font-size: 0.9rem;
  color: #ccc;
  line-height: 1.4;
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
  background: linear-gradient(135deg, #1a1a1a 0%, #0a0a0a 100%);
}

.cta-overlay {
  position: absolute;
  inset: 0;
  background: radial-gradient(circle at center, rgba(164, 113, 72, 0.15) 0%, transparent 70%);
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

.cta-stats {
  display: flex;
  justify-content: center;
  gap: 3rem;
  margin-bottom: 3rem;
}

.cta-stat {
  text-align: center;
}

.cta-stat .stat-number {
  font-size: 2.5rem;
  font-weight: 600;
  color: #a47148;
  margin-bottom: 0.5rem;
}

.cta-stat .stat-label {
  font-size: 1rem;
  color: #999;
}

.cta-actions {
  display: flex;
  gap: 2rem;
  justify-content: center;
  flex-wrap: wrap;
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

/* Transitions */
.country-fade-enter-active,
.country-fade-leave-active {
  transition: opacity 0.3s ease;
}

.country-fade-enter-from,
.country-fade-leave-to {
  opacity: 0;
}

.region-slide-enter-active,
.region-slide-leave-active {
  transition: all 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

.region-slide-enter-from {
  opacity: 0;
  transform: translateX(50px);
}

.region-slide-leave-to {
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

@keyframes countryCardFadeIn {
  from {
    opacity: 0;
    transform: translateX(30px);
  }
  to {
    opacity: 1;
    transform: translateX(0);
  }
}

@keyframes regionSlideIn {
  from {
    opacity: 0;
    transform: translateY(30px);
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

@keyframes culturalFadeIn {
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

@keyframes partnerDetailSlideIn {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* Responsive Design */
@media (max-width: 1024px) {
  .interactive-map,
  .region-overview,
  .project-slide {
    grid-template-columns: 1fr;
    gap: 2rem;
  }
  
  .interactive-map .map-container {
    order: 2;
  }
  
  .partner-header {
    flex-direction: column;
    text-align: center;
  }
}

@media (max-width: 768px) {
  .hero-title {
    font-size: 2.5rem;
  }
  
  .region-tabs {
    flex-direction: column;
    align-items: center;
  }
  
  .services-grid,
  .cultural-grid {
    grid-template-columns: 1fr;
  }
  
  .project-details {
    grid-template-columns: 1fr;
    gap: 0.5rem;
  }
  
  .cta-stats {
    flex-direction: column;
    gap: 1.5rem;
  }
  
  .cta-title {
    font-size: 2.5rem;
  }
  
  .cta-actions {
    flex-direction: column;
    align-items: center;
  }
  
  .modal-header,
  .modal-body {
    padding: 2rem;
  }
  
  .modal-header {
    flex-direction: column;
    text-align: center;
  }
  
  .benefits-grid {
    grid-template-columns: 1fr;
  }
  
  .modal-actions {
    flex-direction: column;
  }
  
  .network-visualization {
    height: 300px;
  }
  
  .partner-node {
    width: 60px;
    height: 60px;
  }
  
  .partner-name {
    font-size: 0.6rem;
  }
  
  .partner-type {
    font-size: 0.5rem;
  }
}
</style>