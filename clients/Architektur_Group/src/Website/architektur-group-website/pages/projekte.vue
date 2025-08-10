<template>
  <div class="projects-page">
    <!-- Hero Section mit Showcase -->
    <section class="hero-section">
      <div class="hero-slider">
        <transition-group name="slide" tag="div" class="slider-container">
          <div 
            v-for="(project, index) in showcaseProjects" 
            :key="project.id"
            v-show="currentSlide === index"
            class="slide-item"
          >
            <div class="slide-background">
              <img :src="project.heroImage" :alt="project.title" class="slide-image">
              <div class="slide-overlay"></div>
            </div>
            <div class="slide-content">
              <div class="project-number">{{ String(index + 1).padStart(2, '0') }}</div>
              <span class="project-category">{{ project.category }}</span>
              <h1 class="project-title">{{ project.title }}</h1>
              <p class="project-location">
                <span class="material-icons">location_on</span>
                {{ project.location }}
              </p>
              <div class="project-stats">
                <div class="stat">
                  <span class="stat-value">{{ project.area }}</span>
                  <span class="stat-label">Fläche</span>
                </div>
                <div class="stat">
                  <span class="stat-value">{{ project.duration }}</span>
                  <span class="stat-label">Bauzeit</span>
                </div>
                <div class="stat">
                  <span class="stat-value">{{ project.year }}</span>
                  <span class="stat-label">Jahr</span>
                </div>
              </div>
              <button @click="openProject(project)" class="view-project-btn">
                PROJEKT ANSEHEN
                <span class="material-icons">arrow_forward</span>
              </button>
            </div>
          </div>
        </transition-group>
        
        <!-- Slider Controls -->
        <div class="slider-controls">
          <button @click="prevSlide" class="control-btn prev">
            <span class="material-icons">chevron_left</span>
          </button>
          <div class="slider-indicators">
            <button 
              v-for="(project, index) in showcaseProjects" 
              :key="index"
              @click="currentSlide = index"
              :class="['indicator', { active: currentSlide === index }]"
            >
              <span class="indicator-line"></span>
            </button>
          </div>
          <button @click="nextSlide" class="control-btn next">
            <span class="material-icons">chevron_right</span>
          </button>
        </div>
      </div>
    </section>

    <!-- Filter Section -->
    <section class="filter-section">
      <div class="container">
        <div class="filter-header">
          <h2 class="filter-title">UNSERE REFERENZEN</h2>
          <p class="filter-subtitle">{{ filteredProjects.length }} Projekte</p>
        </div>
        
        <div class="filter-controls">
          <button 
            v-for="filter in filters" 
            :key="filter.id"
            @click="activeFilter = filter.id"
            :class="['filter-btn', { active: activeFilter === filter.id }]"
          >
            <span class="filter-icon material-icons">{{ filter.icon }}</span>
            <span class="filter-name">{{ filter.name }}</span>
            <span class="filter-count">{{ filter.count }}</span>
          </button>
        </div>

        <div class="sort-controls">
          <button @click="toggleSortMenu" class="sort-btn">
            <span class="material-icons">sort</span>
            <span>Sortieren: {{ sortOptions.find(s => s.id === currentSort)?.name }}</span>
          </button>
          <transition name="dropdown">
            <div v-if="sortMenuOpen" class="sort-dropdown">
              <button 
                v-for="option in sortOptions" 
                :key="option.id"
                @click="setSort(option.id)"
                :class="['sort-option', { active: currentSort === option.id }]"
              >
                {{ option.name }}
              </button>
            </div>
          </transition>
        </div>
      </div>
    </section>

    <!-- Projects Grid -->
    <section class="projects-section">
      <div class="container">
        <transition-group 
          name="project-transition" 
          tag="div" 
          class="projects-grid"
        >
          <div 
            v-for="(project, index) in paginatedProjects" 
            :key="project.id"
            class="project-card"
            :style="{ animationDelay: `${index * 0.1}s` }"
            @click="openProject(project)"
            @mouseenter="onProjectHover(project)"
            @mouseleave="onProjectLeave"
          >
            <div class="project-image-container">
              <div class="image-wrapper">
                <img :src="project.thumbnail" :alt="project.title" class="project-image">
                <img :src="project.hoverImage" :alt="project.title" class="project-hover-image">
              </div>
              
              <div class="project-overlay">
                <div class="overlay-content">
                  <div class="quick-stats">
                    <span><span class="material-icons">square_foot</span> {{ project.area }}</span>
                    <span><span class="material-icons">schedule</span> {{ project.duration }}</span>
                  </div>
                  <button class="explore-btn">
                    <span class="material-icons">visibility</span>
                    ERKUNDEN
                  </button>
                </div>
              </div>

              <div class="project-badges">
                <span v-if="project.award" class="badge award">
                  <span class="material-icons">emoji_events</span>
                  AUSGEZEICHNET
                </span>
                <span v-if="project.featured" class="badge featured">
                  <span class="material-icons">star</span>
                  HIGHLIGHT
                </span>
              </div>
            </div>
            
            <div class="project-info">
              <div class="info-header">
                <span class="project-category-tag">{{ project.category }}</span>
                <span class="project-year">{{ project.year }}</span>
              </div>
              <h3 class="project-name">{{ project.title }}</h3>
              <p class="project-description">{{ project.shortDescription }}</p>
              <div class="project-location-tag">
                <span class="material-icons">location_on</span>
                {{ project.location }}
              </div>
            </div>
          </div>
        </transition-group>

        <!-- Load More / Pagination -->
        <div class="pagination-section">
          <button 
            v-if="currentPage > 1" 
            @click="currentPage--" 
            class="pagination-btn"
          >
            <span class="material-icons">arrow_back</span>
            ZURÜCK
          </button>
          
          <div class="page-indicators">
            <button 
              v-for="page in totalPages" 
              :key="page"
              @click="currentPage = page"
              :class="['page-dot', { active: currentPage === page }]"
            >
              {{ page }}
            </button>
          </div>
          
          <button 
            v-if="currentPage < totalPages" 
            @click="currentPage++" 
            class="pagination-btn"
          >
            WEITER
            <span class="material-icons">arrow_forward</span>
          </button>
        </div>
      </div>
    </section>

    <!-- Awards Section -->
    <section class="awards-section">
      <div class="container">
        <div class="awards-header">
          <h2 class="awards-title">AUSZEICHNUNGEN & ANERKENNUNGEN</h2>
          <p class="awards-subtitle">Unsere Arbeit wurde mehrfach prämiert</p>
        </div>
        
        <div class="awards-grid">
          <div 
            v-for="award in awards" 
            :key="award.id"
            class="award-card"
            @mouseenter="playAwardSound"
          >
            <div class="award-icon">
              <span class="material-icons">{{ award.icon }}</span>
            </div>
            <h3 class="award-name">{{ award.name }}</h3>
            <p class="award-year">{{ award.year }}</p>
            <p class="award-description">{{ award.description }}</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Project Detail Modal -->
    <transition name="modal">
      <div v-if="selectedProject" class="project-modal" @click="closeModal">
        <div class="modal-container" @click.stop>
          <button class="modal-close" @click="closeModal">
            <span class="material-icons">close</span>
          </button>
          
          <!-- Modal Hero -->
          <div class="modal-hero">
            <img :src="selectedProject.heroImage" :alt="selectedProject.title" class="modal-hero-image">
            <div class="modal-hero-overlay"></div>
            <div class="modal-hero-content">
              <span class="modal-category">{{ selectedProject.category }}</span>
              <h1 class="modal-title">{{ selectedProject.title }}</h1>
              <div class="modal-location">
                <span class="material-icons">location_on</span>
                {{ selectedProject.location }}
              </div>
            </div>
          </div>
          
          <!-- Project Details -->
          <div class="modal-body">
            <!-- Project Stats -->
            <div class="project-details-grid">
              <div class="detail-item">
                <span class="detail-icon material-icons">square_foot</span>
                <div class="detail-content">
                  <span class="detail-label">Fläche</span>
                  <span class="detail-value">{{ selectedProject.area }}</span>
                </div>
              </div>
              <div class="detail-item">
                <span class="detail-icon material-icons">schedule</span>
                <div class="detail-content">
                  <span class="detail-label">Bauzeit</span>
                  <span class="detail-value">{{ selectedProject.duration }}</span>
                </div>
              </div>
              <div class="detail-item">
                <span class="detail-icon material-icons">euro</span>
                <div class="detail-content">
                  <span class="detail-label">Investition</span>
                  <span class="detail-value">{{ selectedProject.investment }}</span>
                </div>
              </div>
              <div class="detail-item">
                <span class="detail-icon material-icons">engineering</span>
                <div class="detail-content">
                  <span class="detail-label">Materialien</span>
                  <span class="detail-value">{{ selectedProject.materials }}</span>
                </div>
              </div>
            </div>

            <!-- Project Description -->
            <div class="project-story">
              <h2>DIE HERAUSFORDERUNG</h2>
              <p>{{ selectedProject.challenge }}</p>
              
              <h2>UNSERE LÖSUNG</h2>
              <p>{{ selectedProject.solution }}</p>
              
              <h2>DAS ERGEBNIS</h2>
              <p>{{ selectedProject.result }}</p>
            </div>

            <!-- Before/After Slider -->
            <div class="before-after-section" v-if="selectedProject.beforeImage">
              <h2>VORHER / NACHHER</h2>
              <div class="before-after-container">
                <div class="before-after-slider" ref="sliderContainer">
                  <div class="before-image">
                    <img :src="selectedProject.beforeImage" alt="Vorher">
                    <span class="image-label">VORHER</span>
                  </div>
                  <div class="after-image" :style="{ clipPath: `inset(0 ${100 - sliderPosition}% 0 0)` }">
                    <img :src="selectedProject.afterImage" alt="Nachher">
                    <span class="image-label">NACHHER</span>
                  </div>
                  <div 
                    class="slider-handle" 
                    :style="{ left: `${sliderPosition}%` }"
                    @mousedown="startSliding"
                    @touchstart="startSliding"
                  >
                    <span class="material-icons">code</span>
                  </div>
                </div>
              </div>
            </div>

            <!-- Gallery -->
            <div class="project-gallery">
              <h2>PROJEKT GALERIE</h2>
              <div class="gallery-grid">
                <div 
                  v-for="(image, index) in selectedProject.gallery" 
                  :key="index"
                  class="gallery-item"
                  @click="openLightbox(index)"
                >
                  <img :src="image.thumb" :alt="image.caption">
                  <div class="gallery-overlay">
                    <span class="material-icons">fullscreen</span>
                  </div>
                </div>
              </div>
            </div>

            <!-- Testimonial -->
            <div class="project-testimonial" v-if="selectedProject.testimonial">
              <div class="testimonial-content">
                <span class="quote-icon">"</span>
                <blockquote>{{ selectedProject.testimonial.quote }}</blockquote>
                <div class="testimonial-author">
                  <img :src="selectedProject.testimonial.avatar" :alt="selectedProject.testimonial.name">
                  <div class="author-info">
                    <h4>{{ selectedProject.testimonial.name }}</h4>
                    <p>{{ selectedProject.testimonial.title }}</p>
                  </div>
                </div>
              </div>
            </div>

            <!-- Project Timeline -->
            <div class="project-timeline">
              <h2>PROJEKTVERLAUF</h2>
              <div class="timeline">
                <div 
                  v-for="(phase, index) in selectedProject.timeline" 
                  :key="index"
                  class="timeline-item"
                  :class="{ completed: phase.completed }"
                >
                  <div class="timeline-marker">
                    <span class="material-icons">{{ phase.completed ? 'check_circle' : 'radio_button_unchecked' }}</span>
                  </div>
                  <div class="timeline-content">
                    <h4>{{ phase.title }}</h4>
                    <p class="timeline-date">{{ phase.date }}</p>
                    <p>{{ phase.description }}</p>
                  </div>
                </div>
              </div>
            </div>

            <!-- Call to Action -->
            <div class="modal-cta">
              <h2>IHR TRAUMPROJEKT WARTET</h2>
              <p>Lassen Sie uns gemeinsam Ihre Vision verwirklichen</p>
              <div class="cta-buttons">
                <a href="/kontakt" class="cta-btn primary">
                  <span class="material-icons">phone</span>
                  BERATUNG VEREINBAREN
                </a>
                <button @click="downloadBrochure" class="cta-btn secondary">
                  <span class="material-icons">download</span>
                  PROJEKT-BROSCHÜRE
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </transition>

    <!-- Lightbox -->
    <transition name="lightbox">
      <div v-if="lightboxOpen" class="lightbox" @click="closeLightbox">
        <button class="lightbox-close" @click="closeLightbox">
          <span class="material-icons">close</span>
        </button>
        <button class="lightbox-nav prev" @click.stop="prevImage">
          <span class="material-icons">chevron_left</span>
        </button>
        <img 
          :src="selectedProject?.gallery[currentImageIndex]?.full" 
          :alt="selectedProject?.gallery[currentImageIndex]?.caption"
          @click.stop
        >
        <button class="lightbox-nav next" @click.stop="nextImage">
          <span class="material-icons">chevron_right</span>
        </button>
        <div class="lightbox-caption">
          {{ selectedProject?.gallery[currentImageIndex]?.caption }}
        </div>
      </div>
    </transition>

    <!-- CTA Section -->
    <section class="cta-section">
      <div class="cta-background">
        <!-- Ersetzt Video mit statischem Hintergrundbild -->
        <div class="cta-bg-image"></div>
        <div class="cta-overlay"></div>
      </div>
      <div class="container">
        <div class="cta-content">
          <h2 class="cta-title">STARTEN SIE IHR PROJEKT</h2>
          <p class="cta-text">
            Von der ersten Idee bis zur finalen Umsetzung – wir begleiten Sie auf dem Weg zu Ihrem Traumbad
          </p>
          <div class="cta-actions">
            <a href="/kontakt" class="cta-button primary">
              KOSTENLOSES ERSTGESPRÄCH
            </a>
            <button @click="openVirtualShowroom" class="cta-button secondary">
              <span class="material-icons">view_in_ar</span>
              VIRTUELLER SHOWROOM
            </button>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
// State Management
const currentSlide = ref(0)
const activeFilter = ref('alle')
const currentSort = ref('newest')
const sortMenuOpen = ref(false)
const selectedProject = ref(null)
const lightboxOpen = ref(false)
const currentImageIndex = ref(0)
const sliderPosition = ref(50)
const currentPage = ref(1)
const itemsPerPage = 6

// Showcase Projects (für Hero Slider)
const showcaseProjects = [
  {
    id: 'showcase1',
    title: 'VILLA AM STARNBERGER SEE',
    category: 'LUXUS RESIDENZ',
    location: 'Starnberg, Bayern',
    heroImage: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png',
    area: '280 m²',
    duration: '6 Monate',
    year: '2024'
  },
  {
    id: 'showcase2',
    title: 'PENTHOUSE MÜNCHEN',
    category: 'URBAN LUXURY',
    location: 'München, Maximilianstraße',
    heroImage: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686576cf622e38e88f0236c5.png',
    area: '180 m²',
    duration: '4 Monate',
    year: '2024'
  },
  {
    id: 'showcase3',
    title: 'WELLNESS HOTEL ALLGÄU',
    category: 'HOSPITALITY',
    location: 'Oberstdorf, Allgäu',
    heroImage: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png',
    area: '500 m²',
    duration: '8 Monate',
    year: '2023'
  }
]

// Filter Options
const filters = [
  { id: 'alle', name: 'Alle Projekte', icon: 'apps', count: 48 },
  { id: 'residenz', name: 'Private Residenzen', icon: 'home', count: 22 },
  { id: 'hotel', name: 'Hotels & Spas', icon: 'hotel', count: 12 },
  { id: 'gewerbe', name: 'Gewerbeobjekte', icon: 'business', count: 8 },
  { id: 'sanierung', name: 'Sanierungen', icon: 'construction', count: 6 }
]

// Sort Options
const sortOptions = [
  { id: 'newest', name: 'Neueste zuerst' },
  { id: 'oldest', name: 'Älteste zuerst' },
  { id: 'size', name: 'Nach Größe' },
  { id: 'location', name: 'Nach Standort' }
]

// Projects Data
const projects = [
  {
    id: 1,
    title: 'Moderne Villa mit Spa-Bereich',
    category: 'PRIVATE RESIDENZ',
    location: 'München, Bogenhausen',
    thumbnail: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686576cf622e38e88f0236c5.png',
    hoverImage: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png',
    heroImage: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686576cf622e38e88f0236c5.png',
    shortDescription: 'Luxuriöse Badgestaltung mit freistehender Wanne und Walk-In Dusche',
    area: '45 m²',
    duration: '3 Monate',
    year: '2024',
    investment: '150.000€+',
    materials: 'Carrara Marmor, Teakholz',
    featured: true,
    award: true,
    categoryId: 'residenz',
    challenge: 'Die Herausforderung bestand darin, ein kompaktes Badezimmer in eine luxuriöse Wellness-Oase zu verwandeln, ohne die architektonische Integrität des Hauses zu beeinträchtigen.',
    solution: 'Durch geschickte Raumplanung und den Einsatz hochwertiger Materialien schufen wir einen harmonischen Raum, der Funktionalität und Luxus perfekt vereint.',
    result: 'Ein atemberaubendes Badezimmer, das als privater Spa-Bereich dient und den Wert der Immobilie erheblich steigert.',
    beforeImage: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b70b0803723582ed6.png',
    afterImage: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686576cf622e38e88f0236c5.png',
    gallery: [
      { 
        thumb: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686576cf622e38e88f0236c5.png',
        full: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686576cf622e38e88f0236c5.png',
        caption: 'Hauptbadezimmer mit freistehender Wanne'
      },
      { 
        thumb: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png',
        full: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png',
        caption: 'Walk-In Dusche mit Regenduschkopf'
      },
      { 
        thumb: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png',
        full: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png',
        caption: 'Doppelwaschtisch aus Naturstein'
      }
    ],
    testimonial: {
      quote: 'Die Transformation unseres Badezimmers übertraf alle Erwartungen. Es ist jetzt unser Lieblingsraum im Haus.',
      name: 'Familie Weber',
      title: 'Bauherr',
      avatar: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b097a8069ca3ac95a.png'
    },
    timeline: [
      {
        title: 'Konzeptphase',
        date: 'Januar 2024',
        description: 'Entwicklung des Designkonzepts und 3D-Visualisierung',
        completed: true
      },
      {
        title: 'Materialauswahl',
        date: 'Februar 2024',
        description: 'Auswahl von Carrara Marmor und Teakholz-Elementen',
        completed: true
      },
      {
        title: 'Bauphase',
        date: 'März - April 2024',
        description: 'Komplette Neugestaltung und Installation',
        completed: true
      },
      {
        title: 'Fertigstellung',
        date: 'Mai 2024',
        description: 'Finale Details und Übergabe',
        completed: true
      }
    ]
  },
  {
    id: 2,
    title: 'Boutique Hotel Badezimmer',
    category: 'HOSPITALITY',
    location: 'Garmisch-Partenkirchen',
    thumbnail: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png',
    hoverImage: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png',
    heroImage: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png',
    shortDescription: '12 Luxus-Suiten mit individuellen Spa-Badezimmern',
    area: '35 m² pro Suite',
    duration: '6 Monate',
    year: '2024',
    investment: '500.000€+',
    materials: 'Schwarzer Granit, Gold-Armaturen',
    featured: false,
    award: true,
    categoryId: 'hotel',
    challenge: 'Gestaltung von 12 einzigartigen Badezimmern, die Luxus und Funktionalität für anspruchsvolle Hotelgäste bieten.',
    solution: 'Individuelle Designs mit Premium-Materialien und modernster Technik für jede Suite.',
    result: 'Ein preisgekröntes Hotelprojekt mit außergewöhnlichen Gästebewertungen.',
    gallery: [
      { 
        thumb: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png',
        full: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png',
        caption: 'Master Suite Badezimmer'
      }
    ],
    timeline: [
      {
        title: 'Planung',
        date: 'Oktober 2023',
        description: 'Konzeptentwicklung für alle 12 Suiten',
        completed: true
      },
      {
        title: 'Umsetzung',
        date: 'Januar - Mai 2024',
        description: 'Bauphase und Installation',
        completed: true
      }
    ]
  },
  {
    id: 3,
    title: 'Penthouse mit Panoramablick',
    category: 'URBAN LUXURY',
    location: 'Frankfurt, Westend',
    thumbnail: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png',
    hoverImage: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b70b0803723582ed6.png',
    heroImage: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png',
    shortDescription: 'Minimalistisches Design mit atemberaubender Skyline-Aussicht',
    area: '60 m²',
    duration: '4 Monate',
    year: '2023',
    investment: '200.000€+',
    materials: 'Weißer Marmor, Glas',
    featured: true,
    award: false,
    categoryId: 'residenz',
    challenge: 'Integration eines großzügigen Badezimmers in ein modernes Penthouse mit Panoramafenstern.',
    solution: 'Transparente Elemente und helle Materialien für ein offenes Raumgefühl.',
    result: 'Ein lichtdurchflutetes Luxusbadezimmer mit spektakulärer Aussicht.',
    beforeImage: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b097a8069ca3ac95a.png',
    afterImage: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png',
    gallery: [
      { 
        thumb: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png',
        full: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png',
        caption: 'Badezimmer mit Skyline-Blick'
      }
    ],
    testimonial: {
      quote: 'Ein Meisterwerk der modernen Badarchitektur. Jeden Morgen ein Erlebnis!',
      name: 'Dr. Michael Braun',
      title: 'Eigentümer',
      avatar: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686576cf622e38e88f0236c5.png'
    },
    timeline: [
      {
        title: 'Design',
        date: 'August 2023',
        description: 'Entwicklung des minimalistischen Konzepts',
        completed: true
      },
      {
        title: 'Bauphase',
        date: 'September - November 2023',
        description: 'Umsetzung und Installation',
        completed: true
      },
      {
        title: 'Abschluss',
        date: 'Dezember 2023',
        description: 'Fertigstellung und Übergabe',
        completed: true
      }
    ]
  },
  {
    id: 4,
    title: 'Historische Villa Sanierung',
    category: 'DENKMALSCHUTZ',
    location: 'Baden-Baden',
    thumbnail: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b70b0803723582ed6.png',
    hoverImage: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b097a8069ca3ac95a.png',
    heroImage: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b70b0803723582ed6.png',
    shortDescription: 'Behutsame Modernisierung unter Bewahrung historischer Elemente',
    area: '40 m²',
    duration: '5 Monate',
    year: '2023',
    investment: '180.000€+',
    materials: 'Restaurierter Originalmarmor',
    featured: false,
    award: false,
    categoryId: 'sanierung',
    challenge: 'Modernisierung eines denkmalgeschützten Badezimmers ohne Verlust des historischen Charakters.',
    solution: 'Sorgfältige Restaurierung originaler Elemente kombiniert mit versteckter moderner Technik.',
    result: 'Perfekte Balance zwischen Historie und modernem Komfort.',
    gallery: [
      { 
        thumb: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b70b0803723582ed6.png',
        full: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b70b0803723582ed6.png',
        caption: 'Restauriertes historisches Bad'
      }
    ],
    timeline: [
      {
        title: 'Bestandsaufnahme',
        date: 'Mai 2023',
        description: 'Dokumentation historischer Elemente',
        completed: true
      },
      {
        title: 'Restaurierung',
        date: 'Juni - Oktober 2023',
        description: 'Sorgfältige Wiederherstellung',
        completed: true
      }
    ]
  },
  {
    id: 5,
    title: 'Wellness Center München',
    category: 'GEWERBE',
    location: 'München, Schwabing',
    thumbnail: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b097a8069ca3ac95a.png',
    hoverImage: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686576cf622e38e88f0236c5.png',
    heroImage: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b097a8069ca3ac95a.png',
    shortDescription: 'Komplettes Spa mit 8 Behandlungsräumen und Wellness-Bereich',
    area: '320 m²',
    duration: '7 Monate',
    year: '2024',
    investment: '750.000€+',
    materials: 'Naturstein, Holz, Glas',
    featured: true,
    award: true,
    categoryId: 'gewerbe',
    challenge: 'Schaffung einer beruhigenden Wellness-Oase im Herzen der Stadt.',
    solution: 'Natürliche Materialien und durchdachte Beleuchtung für maximale Entspannung.',
    result: 'Ein preisgekröntes Wellness-Center mit außergewöhnlichem Ambiente.',
    gallery: [
      { 
        thumb: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b097a8069ca3ac95a.png',
        full: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b097a8069ca3ac95a.png',
        caption: 'Wellness-Bereich'
      }
    ],
    testimonial: {
      quote: 'Die Gestaltung übertrifft alle Erwartungen. Unsere Kunden sind begeistert!',
      name: 'Sarah Chen',
      title: 'Spa-Managerin',
      avatar: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b70b0803723582ed6.png'
    },
    timeline: [
      {
        title: 'Konzeption',
        date: 'September 2023',
        description: 'Entwicklung des Wellness-Konzepts',
        completed: true
      },
      {
        title: 'Bauphase',
        date: 'Oktober 2023 - März 2024',
        description: 'Komplette Neugestaltung',
        completed: true
      },
      {
        title: 'Eröffnung',
        date: 'April 2024',
        description: 'Feierliche Eröffnung',
        completed: true
      }
    ]
  },
  {
    id: 6,
    title: 'Alpenchalet Badezimmer',
    category: 'PRIVATE RESIDENZ',
    location: 'Kitzbühel, Österreich',
    thumbnail: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686576cf622e38e88f0236c5.png',
    hoverImage: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png',
    heroImage: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686576cf622e38e88f0236c5.png',
    shortDescription: 'Rustikaler Luxus mit Bergpanorama',
    area: '55 m²',
    duration: '4 Monate',
    year: '2024',
    investment: '220.000€+',
    materials: 'Altholz, Naturstein',
    featured: false,
    award: false,
    categoryId: 'residenz',
    challenge: 'Verbindung von alpinem Charme mit modernem Luxus.',
    solution: 'Verwendung lokaler Materialien und traditioneller Handwerkskunst.',
    result: 'Ein authentisches Alpenbad mit höchstem Komfort.',
    gallery: [
      { 
        thumb: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686576cf622e38e88f0236c5.png',
        full: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686576cf622e38e88f0236c5.png',
        caption: 'Alpines Luxusbad'
      }
    ],
    timeline: [
      {
        title: 'Planung',
        date: 'Dezember 2023',
        description: 'Entwicklung des alpinen Konzepts',
        completed: true
      },
      {
        title: 'Umsetzung',
        date: 'Januar - April 2024',
        description: 'Handwerkliche Ausführung',
        completed: true
      }
    ]
  }
]

// Awards Data
const awards = [
  {
    id: 1,
    name: 'German Design Award',
    year: '2024',
    icon: 'emoji_events',
    description: 'Gold für innovatives Baddesign'
  },
  {
    id: 2,
    name: 'Luxury Lifestyle Award',
    year: '2023',
    icon: 'star',
    description: 'Best Bathroom Design Europe'
  },
  {
    id: 3,
    name: 'Architecture Excellence',
    year: '2023',
    icon: 'architecture',
    description: 'Herausragende Raumgestaltung'
  },
  {
    id: 4,
    name: 'Sustainability Award',
    year: '2024',
    icon: 'eco',
    description: 'Nachhaltige Luxusprojekte'
  }
]

// Computed Properties
const filteredProjects = computed(() => {
  let filtered = activeFilter.value === 'alle' 
    ? projects 
    : projects.filter(p => p.categoryId === activeFilter.value)
  
  // Sorting
  switch (currentSort.value) {
    case 'oldest':
      return filtered.sort((a, b) => a.year.localeCompare(b.year))
    case 'size':
      return filtered.sort((a, b) => parseInt(b.area) - parseInt(a.area))
    case 'location':
      return filtered.sort((a, b) => a.location.localeCompare(b.location))
    default: // newest
      return filtered.sort((a, b) => b.year.localeCompare(a.year))
  }
})

const totalPages = computed(() => 
  Math.ceil(filteredProjects.value.length / itemsPerPage)
)

const paginatedProjects = computed(() => {
  const start = (currentPage.value - 1) * itemsPerPage
  const end = start + itemsPerPage
  return filteredProjects.value.slice(start, end)
})

// Methods
const prevSlide = () => {
  currentSlide.value = currentSlide.value === 0 
    ? showcaseProjects.length - 1 
    : currentSlide.value - 1
}

const nextSlide = () => {
  currentSlide.value = (currentSlide.value + 1) % showcaseProjects.length
}

const toggleSortMenu = () => {
  sortMenuOpen.value = !sortMenuOpen.value
}

const setSort = (sortId) => {
  currentSort.value = sortId
  sortMenuOpen.value = false
}

const openProject = (project) => {
  selectedProject.value = project
  document.body.style.overflow = 'hidden'
}

const closeModal = () => {
  selectedProject.value = null
  document.body.style.overflow = 'auto'
}

const openLightbox = (index) => {
  currentImageIndex.value = index
  lightboxOpen.value = true
}

const closeLightbox = () => {
  lightboxOpen.value = false
}

const prevImage = () => {
  if (selectedProject.value) {
    currentImageIndex.value = currentImageIndex.value === 0 
      ? selectedProject.value.gallery.length - 1 
      : currentImageIndex.value - 1
  }
}

const nextImage = () => {
  if (selectedProject.value) {
    currentImageIndex.value = 
      (currentImageIndex.value + 1) % selectedProject.value.gallery.length
  }
}

const startSliding = (event) => {
  const container = document.querySelector('.before-after-slider')
  if (!container) return
  
  const rect = container.getBoundingClientRect()
  
  const handleMove = (e) => {
    const clientX = e.type.includes('touch') ? e.touches[0].clientX : e.clientX
    const x = clientX - rect.left
    const percentage = (x / rect.width) * 100
    sliderPosition.value = Math.max(0, Math.min(100, percentage))
  }
  
  const handleEnd = () => {
    document.removeEventListener('mousemove', handleMove)
    document.removeEventListener('touchmove', handleMove)
    document.removeEventListener('mouseup', handleEnd)
    document.removeEventListener('touchend', handleEnd)
  }
  
  document.addEventListener('mousemove', handleMove)
  document.addEventListener('touchmove', handleMove)
  document.addEventListener('mouseup', handleEnd)
  document.addEventListener('touchend', handleEnd)
  
  handleMove(event)
}

const onProjectHover = (project) => {
  // Animation trigger
}

const onProjectLeave = () => {
  // Animation reset
}

const playAwardSound = () => {
  // Sound effect placeholder
}

const downloadBrochure = () => {
  // Download functionality
  console.log('Downloading brochure...')
}

const openVirtualShowroom = () => {
  // Virtual showroom functionality
  console.log('Opening virtual showroom...')
}

// Auto-play slider
let sliderInterval
onMounted(() => {
  sliderInterval = setInterval(() => {
    nextSlide()
  }, 5000)
})

onUnmounted(() => {
  clearInterval(sliderInterval)
  document.body.style.overflow = 'auto'
})

// Reset page when filter changes
watch(activeFilter, () => {
  currentPage.value = 1
})
</script>

<style scoped>
.projects-page {
  min-height: 100vh;
  background: #000;
  color: #FAFAF8;
  padding-top: 80px;
}

/* Hero Section */
.hero-section {
  position: relative;
  height: 85vh;
  overflow: hidden;
}

.hero-slider {
  position: relative;
  width: 100%;
  height: 100%;
}

.slider-container {
  position: relative;
  width: 100%;
  height: 100%;
}

.slide-item {
  position: absolute;
  inset: 0;
}

.slide-background {
  position: absolute;
  inset: 0;
}

.slide-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.slide-overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(
    135deg,
    rgba(0,0,0,0.7) 0%,
    rgba(0,0,0,0.3) 50%,
    rgba(164, 113, 72, 0.2) 100%
  );
}

.slide-content {
  position: absolute;
  inset: 0;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  text-align: center;
  padding: 2rem;
  z-index: 1;
  animation: slideContentIn 1s ease-out;
}

@keyframes slideContentIn {
  from {
    opacity: 0;
    transform: translateY(30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.project-number {
  position: absolute;
  top: 3rem;
  right: 3rem;
  font-size: 5rem;
  font-weight: 100;
  opacity: 0.3;
  color: #a47148;
}

.project-category {
  display: inline-block;
  padding: 0.5rem 1.5rem;
  background: rgba(164, 113, 72, 0.2);
  border: 1px solid #a47148;
  color: #a47148;
  font-size: 0.875rem;
  letter-spacing: 0.1em;
  margin-bottom: 2rem;
  backdrop-filter: blur(10px);
}

.project-title {
  font-size: clamp(2.5rem, 5vw, 4rem);
  font-weight: 300;
  margin-bottom: 1rem;
  background: linear-gradient(135deg, #FAFAF8 0%, #a47148 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  max-width: 800px;
}

.project-location {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  font-size: 1.1rem;
  color: #ccc;
  margin-bottom: 3rem;
}

.project-stats {
  display: flex;
  gap: 4rem;
  margin-bottom: 3rem;
}

.stat {
  text-align: center;
}

.stat-value {
  display: block;
  font-size: 1.5rem;
  font-weight: 400;
  color: #FAFAF8;
  margin-bottom: 0.5rem;
}

.stat-label {
  font-size: 0.875rem;
  color: #999;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.view-project-btn {
  padding: 1rem 2.5rem;
  background: transparent;
  border: 2px solid #FAFAF8;
  color: #FAFAF8;
  font-size: 0.95rem;
  letter-spacing: 0.1em;
  cursor: pointer;
  transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  display: inline-flex;
  align-items: center;
  gap: 0.75rem;
  position: relative;
  overflow: hidden;
}

.view-project-btn::before {
  content: '';
  position: absolute;
  inset: 0;
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  transform: translateY(100%);
  transition: transform 0.4s ease;
}

.view-project-btn:hover {
  color: #000;
}

.view-project-btn:hover::before {
  transform: translateY(0);
}

.view-project-btn span {
  position: relative;
  z-index: 1;
}

/* Slider Controls */
.slider-controls {
  position: absolute;
  bottom: 3rem;
  left: 50%;
  transform: translateX(-50%);
  display: flex;
  align-items: center;
  gap: 2rem;
  z-index: 2;
}

.control-btn {
  width: 50px;
  height: 50px;
  background: rgba(255, 255, 255, 0.1);
  border: 1px solid rgba(255, 255, 255, 0.3);
  border-radius: 50%;
  color: #FAFAF8;
  cursor: pointer;
  transition: all 0.3s ease;
  backdrop-filter: blur(10px);
  display: flex;
  align-items: center;
  justify-content: center;
}

.control-btn:hover {
  background: rgba(164, 113, 72, 0.3);
  border-color: #a47148;
  transform: scale(1.1);
}

.slider-indicators {
  display: flex;
  gap: 1rem;
}

.indicator {
  width: 60px;
  height: 3px;
  background: rgba(255, 255, 255, 0.3);
  border: none;
  cursor: pointer;
  position: relative;
  transition: all 0.3s ease;
}

.indicator-line {
  position: absolute;
  inset: 0;
  background: #a47148;
  transform-origin: left;
  transform: scaleX(0);
  transition: transform 5s linear;
}

.indicator.active .indicator-line {
  transform: scaleX(1);
}

/* Slide Transitions */
.slide-enter-active,
.slide-leave-active {
  transition: all 1s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

.slide-enter-from {
  opacity: 0;
  transform: translateX(100px);
}

.slide-leave-to {
  opacity: 0;
  transform: translateX(-100px);
}

/* Filter Section */
.filter-section {
  padding: 4rem 0;
  background: linear-gradient(135deg, #0a0a0a 0%, #1a1a1a 100%);
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.container {
  max-width: 1400px;
  margin: 0 auto;
  padding: 0 2rem;
}

.filter-header {
  display: flex;
  justify-content: space-between;
  align-items: baseline;
  margin-bottom: 3rem;
}

.filter-title {
  font-size: 2.5rem;
  font-weight: 300;
  background: linear-gradient(135deg, #FAFAF8 0%, #a47148 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.filter-subtitle {
  color: #999;
  font-size: 1.1rem;
}

.filter-controls {
  display: flex;
  justify-content: center;
  gap: 1.5rem;
  flex-wrap: wrap;
  margin-bottom: 2rem;
}

.filter-btn {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  padding: 0.875rem 1.75rem;
  background: rgba(255, 255, 255, 0.03);
  border: 1px solid rgba(255, 255, 255, 0.1);
  color: #FAFAF8;
  border-radius: 50px;
  cursor: pointer;
  transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  backdrop-filter: blur(10px);
}

.filter-btn:hover {
  background: rgba(255, 255, 255, 0.08);
  transform: translateY(-3px);
  box-shadow: 0 10px 30px rgba(164, 113, 72, 0.2);
}

.filter-btn.active {
  background: linear-gradient(135deg, rgba(164, 113, 72, 0.3), rgba(250, 250, 248, 0.1));
  border-color: #a47148;
  color: #a47148;
}

.filter-icon {
  font-size: 1.25rem;
}

.filter-name {
  font-size: 0.95rem;
  font-weight: 400;
  letter-spacing: 0.05em;
}

.filter-count {
  padding: 0.25rem 0.5rem;
  background: rgba(255, 255, 255, 0.1);
  border-radius: 20px;
  font-size: 0.75rem;
  font-weight: 600;
}

.sort-controls {
  position: relative;
  display: flex;
  justify-content: center;
}

.sort-btn {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  padding: 0.75rem 1.5rem;
  background: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.2);
  color: #FAFAF8;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.sort-btn:hover {
  background: rgba(255, 255, 255, 0.08);
}

.sort-dropdown {
  position: absolute;
  top: calc(100% + 0.5rem);
  background: #1a1a1a;
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 12px;
  overflow: hidden;
  z-index: 10;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
}

.sort-option {
  display: block;
  width: 100%;
  padding: 0.75rem 1.5rem;
  background: transparent;
  border: none;
  color: #FAFAF8;
  text-align: left;
  cursor: pointer;
  transition: all 0.2s ease;
  white-space: nowrap;
}

.sort-option:hover {
  background: rgba(255, 255, 255, 0.05);
}

.sort-option.active {
  background: rgba(164, 113, 72, 0.2);
  color: #a47148;
}

/* Projects Grid */
.projects-section {
  padding: 5rem 0;
}

.projects-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(400px, 1fr));
  gap: 3rem;
  margin-bottom: 4rem;
}

.project-card {
  background: rgba(255, 255, 255, 0.02);
  border-radius: 20px;
  overflow: hidden;
  cursor: pointer;
  transition: all 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  animation: projectFadeIn 0.8s ease-out forwards;
  opacity: 0;
  border: 1px solid rgba(255, 255, 255, 0.05);
  transform-style: preserve-3d;
}

@keyframes projectFadeIn {
  to {
    opacity: 1;
    transform: translateY(0);
  }
  from {
    opacity: 0;
    transform: translateY(30px);
  }
}

.project-card:hover {
  transform: translateY(-10px) rotateX(5deg);
  box-shadow: 
    0 30px 60px rgba(164, 113, 72, 0.3),
    0 0 100px rgba(164, 113, 72, 0.1);
  background: rgba(255, 255, 255, 0.05);
}

.project-image-container {
  position: relative;
  height: 280px;
  overflow: hidden;
}

.image-wrapper {
  position: relative;
  width: 100%;
  height: 100%;
}

.project-image,
.project-hover-image {
  position: absolute;
  inset: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: all 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

.project-hover-image {
  opacity: 0;
  transform: scale(1.1);
}

.project-card:hover .project-image {
  opacity: 0;
  transform: scale(1.2);
}

.project-card:hover .project-hover-image {
  opacity: 1;
  transform: scale(1);
}

.project-overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(
    180deg,
    transparent 0%,
    rgba(0,0,0,0.8) 100%
  );
  display: flex;
  align-items: flex-end;
  padding: 2rem;
  opacity: 0;
  transition: opacity 0.4s ease;
}

.project-card:hover .project-overlay {
  opacity: 1;
}

.overlay-content {
  width: 100%;
}

.quick-stats {
  display: flex;
  gap: 1.5rem;
  margin-bottom: 1rem;
  color: #ccc;
  font-size: 0.875rem;
}

.quick-stats span {
  display: flex;
  align-items: center;
  gap: 0.25rem;
}

.quick-stats .material-icons {
  font-size: 1rem;
}

.explore-btn {
  padding: 0.75rem 1.5rem;
  background: transparent;
  border: 2px solid #FAFAF8;
  color: #FAFAF8;
  font-size: 0.875rem;
  letter-spacing: 0.05em;
  cursor: pointer;
  transition: all 0.3s ease;
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  width: 100%;
  justify-content: center;
}

.explore-btn:hover {
  background: #FAFAF8;
  color: #000;
}

.project-badges {
  position: absolute;
  top: 1rem;
  right: 1rem;
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.badge {
  padding: 0.5rem 1rem;
  font-size: 0.75rem;
  font-weight: 600;
  letter-spacing: 0.05em;
  border-radius: 20px;
  display: inline-flex;
  align-items: center;
  gap: 0.25rem;
  backdrop-filter: blur(10px);
}

.badge.award {
  background: linear-gradient(135deg, #FFD700, #FFA500);
  color: #000;
}

.badge.featured {
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  color: #000;
}

.badge .material-icons {
  font-size: 0.875rem;
}

.project-info {
  padding: 2rem;
}

.info-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1rem;
}

.project-category-tag {
  color: #a47148;
  font-size: 0.875rem;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  font-weight: 500;
}

.project-year {
  color: #999;
  font-size: 0.875rem;
}

.project-name {
  font-size: 1.5rem;
  font-weight: 400;
  line-height: 1.3;
  margin-bottom: 1rem;
  color: #FAFAF8;
  transition: color 0.3s ease;
}

.project-card:hover .project-name {
  color: #a47148;
}

.project-description {
  font-size: 1rem;
  line-height: 1.6;
  color: #ccc;
  margin-bottom: 1.5rem;
}

.project-location-tag {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  color: #999;
  font-size: 0.875rem;
}

.project-location-tag .material-icons {
  font-size: 1rem;
  color: #a47148;
}

/* Pagination */
.pagination-section {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 2rem;
}

.pagination-btn {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.75rem 1.5rem;
  background: transparent;
  border: 1px solid #FAFAF8;
  color: #FAFAF8;
  font-size: 0.875rem;
  letter-spacing: 0.05em;
  cursor: pointer;
  transition: all 0.3s ease;
  border-radius: 50px;
}

.pagination-btn:hover {
  background: #FAFAF8;
  color: #000;
}

.page-indicators {
  display: flex;
  gap: 0.5rem;
}

.page-dot {
  width: 40px;
  height: 40px;
  background: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.2);
  color: #FAFAF8;
  border-radius: 50%;
  cursor: pointer;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 0.875rem;
}

.page-dot:hover {
  background: rgba(255, 255, 255, 0.1);
}

.page-dot.active {
  background: #a47148;
  border-color: #a47148;
  color: #000;
}

/* Awards Section */
.awards-section {
  padding: 6rem 0;
  background: linear-gradient(135deg, #1a1a1a 0%, #0a0a0a 100%);
}

.awards-header {
  text-align: center;
  margin-bottom: 4rem;
}

.awards-title {
  font-size: 2.5rem;
  font-weight: 300;
  margin-bottom: 1rem;
  background: linear-gradient(135deg, #FAFAF8 0%, #a47148 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.awards-subtitle {
  font-size: 1.15rem;
  color: #ccc;
}

.awards-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 2rem;
}

.award-card {
  text-align: center;
  padding: 2rem;
  background: rgba(255, 255, 255, 0.03);
  border-radius: 20px;
  border: 1px solid rgba(255, 255, 255, 0.05);
  transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  cursor: pointer;
}

.award-card:hover {
  transform: translateY(-10px);
  background: rgba(255, 255, 255, 0.06);
  box-shadow: 0 20px 40px rgba(164, 113, 72, 0.2);
}

.award-icon {
  width: 80px;
  height: 80px;
  margin: 0 auto 1.5rem;
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
}

.award-icon .material-icons {
  font-size: 2.5rem;
  color: #000;
}

.award-name {
  font-size: 1.25rem;
  font-weight: 400;
  margin-bottom: 0.5rem;
  color: #FAFAF8;
}

.award-year {
  font-size: 1rem;
  color: #a47148;
  margin-bottom: 1rem;
}

.award-description {
  font-size: 0.95rem;
  color: #ccc;
  line-height: 1.4;
}

/* Project Modal */
.project-modal {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.95);
  z-index: 1000;
  overflow-y: auto;
  backdrop-filter: blur(20px);
}

.modal-container {
  max-width: 1400px;
  margin: 2rem auto;
  background: linear-gradient(135deg, #1a1a1a 0%, #0a0a0a 100%);
  border-radius: 20px;
  overflow: hidden;
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.modal-close {
  position: fixed;
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
  backdrop-filter: blur(10px);
  z-index: 1001;
  display: flex;
  align-items: center;
  justify-content: center;
}

.modal-close:hover {
  background: rgba(255, 255, 255, 0.2);
  transform: rotate(90deg);
}

.modal-hero {
  position: relative;
  height: 500px;
}

.modal-hero-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.modal-hero-overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(
    to bottom,
    transparent 0%,
    rgba(0,0,0,0.8) 100%
  );
}

.modal-hero-content {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  padding: 3rem;
  color: #FAFAF8;
}

.modal-category {
  display: inline-block;
  color: #a47148;
  font-size: 0.875rem;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  margin-bottom: 1rem;
}

.modal-title {
  font-size: 3rem;
  font-weight: 300;
  line-height: 1.2;
  margin-bottom: 1rem;
}

.modal-location {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  font-size: 1.1rem;
  color: #ccc;
}

.modal-body {
  padding: 4rem;
}

/* Project Details Grid */
.project-details-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 2rem;
  padding: 2rem;
  background: rgba(255, 255, 255, 0.03);
  border-radius: 15px;
  margin-bottom: 3rem;
}

.detail-item {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.detail-icon {
  width: 50px;
  height: 50px;
  background: rgba(164, 113, 72, 0.1);
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #a47148;
  font-size: 1.5rem;
}

.detail-content {
  flex: 1;
}

.detail-label {
  display: block;
  font-size: 0.875rem;
  color: #999;
  margin-bottom: 0.25rem;
}

.detail-value {
  font-size: 1.1rem;
  font-weight: 400;
  color: #FAFAF8;
}

/* Project Story */
.project-story {
  margin-bottom: 4rem;
}

.project-story h2 {
  font-size: 1.5rem;
  font-weight: 400;
  margin: 2rem 0 1rem;
  color: #a47148;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.project-story p {
  font-size: 1.1rem;
  line-height: 1.8;
  color: #ccc;
  margin-bottom: 1.5rem;
}

/* Before/After Section */
.before-after-section {
  margin-bottom: 4rem;
}

.before-after-section h2 {
  font-size: 1.5rem;
  font-weight: 400;
  margin-bottom: 2rem;
  color: #a47148;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.before-after-container {
  position: relative;
  max-width: 1000px;
  margin: 0 auto;
}

.before-after-slider {
  position: relative;
  height: 500px;
  overflow: hidden;
  border-radius: 15px;
  user-select: none;
}

.before-image,
.after-image {
  position: absolute;
  inset: 0;
  width: 100%;
  height: 100%;
}

.before-image img,
.after-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.after-image {
  clip-path: inset(0 50% 0 0);
}

.image-label {
  position: absolute;
  top: 2rem;
  padding: 0.5rem 1rem;
  background: rgba(0, 0, 0, 0.7);
  color: #FAFAF8;
  font-size: 0.875rem;
  letter-spacing: 0.1em;
  backdrop-filter: blur(10px);
}

.before-image .image-label {
  left: 2rem;
}

.after-image .image-label {
  right: 2rem;
}

.slider-handle {
  position: absolute;
  top: 0;
  bottom: 0;
  width: 4px;
  background: #a47148;
  cursor: ew-resize;
  display: flex;
  align-items: center;
  justify-content: center;
}

.slider-handle::before,
.slider-handle::after {
  content: '';
  position: absolute;
  top: 50%;
  width: 40px;
  height: 40px;
  background: #a47148;
  border-radius: 50%;
  transform: translateY(-50%);
}

.slider-handle::before {
  left: -18px;
}

.slider-handle::after {
  right: -18px;
}

.slider-handle .material-icons {
  position: relative;
  z-index: 1;
  color: #000;
  font-size: 1.5rem;
  background: #a47148;
  width: 40px;
  height: 40px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
}

/* Gallery */
.project-gallery {
  margin-bottom: 4rem;
}

.project-gallery h2 {
  font-size: 1.5rem;
  font-weight: 400;
  margin-bottom: 2rem;
  color: #a47148;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.gallery-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
  gap: 1rem;
}

.gallery-item {
  position: relative;
  height: 200px;
  border-radius: 10px;
  overflow: hidden;
  cursor: pointer;
  transition: all 0.3s ease;
}

.gallery-item:hover {
  transform: scale(1.05);
}

.gallery-item img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.gallery-overlay {
  position: absolute;
  inset: 0;
  background: rgba(0, 0, 0, 0.6);
  display: flex;
  align-items: center;
  justify-content: center;
  opacity: 0;
  transition: opacity 0.3s ease;
}

.gallery-item:hover .gallery-overlay {
  opacity: 1;
}

.gallery-overlay .material-icons {
  font-size: 2rem;
  color: #FAFAF8;
}

/* Testimonial */
.project-testimonial {
  padding: 3rem;
  background: rgba(255, 255, 255, 0.03);
  border-radius: 20px;
  margin-bottom: 4rem;
  border-left: 4px solid #a47148;
}

.testimonial-content {
  max-width: 800px;
  margin: 0 auto;
}

.quote-icon {
  font-size: 4rem;
  color: #a47148;
  opacity: 0.3;
  line-height: 1;
}

.testimonial-content blockquote {
  font-size: 1.5rem;
  line-height: 1.6;
  color: #FAFAF8;
  font-style: italic;
  margin: 1rem 0 2rem;
}

.testimonial-author {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.testimonial-author img {
  width: 60px;
  height: 60px;
  border-radius: 50%;
  object-fit: cover;
  border: 2px solid #a47148;
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

/* Timeline */
.project-timeline {
  margin-bottom: 4rem;
}

.project-timeline h2 {
  font-size: 1.5rem;
  font-weight: 400;
  margin-bottom: 2rem;
  color: #a47148;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.timeline {
  position: relative;
  padding-left: 3rem;
}

.timeline::before {
  content: '';
  position: absolute;
  left: 1rem;
  top: 0;
  bottom: 0;
  width: 2px;
  background: rgba(255, 255, 255, 0.1);
}

.timeline-item {
  position: relative;
  padding-bottom: 2rem;
}

.timeline-marker {
  position: absolute;
  left: -2rem;
  width: 32px;
  height: 32px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.timeline-marker .material-icons {
  font-size: 1.5rem;
  color: #666;
}

.timeline-item.completed .timeline-marker .material-icons {
  color: #a47148;
}

.timeline-content h4 {
  font-size: 1.2rem;
  font-weight: 400;
  color: #FAFAF8;
  margin-bottom: 0.5rem;
}

.timeline-date {
  font-size: 0.875rem;
  color: #a47148;
  margin-bottom: 0.5rem;
}

.timeline-content p {
  color: #ccc;
  line-height: 1.6;
}

/* Modal CTA */
.modal-cta {
  text-align: center;
  padding: 3rem;
  background: linear-gradient(135deg, rgba(164, 113, 72, 0.1), transparent);
  border-radius: 20px;
}

.modal-cta h2 {
  font-size: 2rem;
  font-weight: 300;
  margin-bottom: 1rem;
  color: #FAFAF8;
}

.modal-cta p {
  font-size: 1.1rem;
  color: #ccc;
  margin-bottom: 2rem;
}

.cta-buttons {
  display: flex;
  justify-content: center;
  gap: 1rem;
  flex-wrap: wrap;
}

.cta-btn {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  padding: 1rem 2rem;
  font-size: 0.95rem;
  letter-spacing: 0.05em;
  text-decoration: none;
  cursor: pointer;
  transition: all 0.4s ease;
  border-radius: 50px;
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

/* Lightbox */
.lightbox {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.95);
  z-index: 2000;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 2rem;
}

.lightbox img {
  max-width: 90%;
  max-height: 90vh;
  object-fit: contain;
}

.lightbox-close {
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

.lightbox-close:hover {
  background: rgba(255, 255, 255, 0.2);
  transform: rotate(90deg);
}

.lightbox-nav {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
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

.lightbox-nav:hover {
  background: rgba(255, 255, 255, 0.2);
}

.lightbox-nav.prev {
  left: 2rem;
}

.lightbox-nav.next {
  right: 2rem;
}

.lightbox-caption {
  position: absolute;
  bottom: 2rem;
  left: 50%;
  transform: translateX(-50%);
  padding: 1rem 2rem;
  background: rgba(0, 0, 0, 0.7);
  color: #FAFAF8;
  border-radius: 50px;
  backdrop-filter: blur(10px);
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
}

.cta-bg-image {
  width: 100%;
  height: 100%;
  background-image: url('https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png');
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
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

/* Transitions */
.project-transition-enter-active,
.project-transition-leave-active {
  transition: all 0.5s ease;
}

.project-transition-enter-from {
  opacity: 0;
  transform: translateY(30px);
}

.project-transition-leave-to {
  opacity: 0;
  transform: translateY(-30px);
}

.dropdown-enter-active,
.dropdown-leave-active {
  transition: all 0.3s ease;
}

.dropdown-enter-from,
.dropdown-leave-to {
  opacity: 0;
  transform: translateY(-10px);
}

.modal-enter-active,
.modal-leave-active {
  transition: opacity 0.4s ease;
}

.modal-enter-from,
.modal-leave-to {
  opacity: 0;
}

.modal-enter-active .modal-container,
.modal-leave-active .modal-container {
  transition: transform 0.4s ease;
}

.modal-enter-from .modal-container,
.modal-leave-to .modal-container {
  transform: scale(0.9);
}

.lightbox-enter-active,
.lightbox-leave-active {
  transition: opacity 0.3s ease;
}

.lightbox-enter-from,
.lightbox-leave-to {
  opacity: 0;
}

/* Responsive Design */
@media (max-width: 1024px) {
  .projects-grid {
    grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
    gap: 2rem;
  }
  
  .project-details-grid {
    grid-template-columns: repeat(2, 1fr);
  }
  
  .gallery-grid {
    grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
  }
}

@media (max-width: 768px) {
  .slide-content {
    padding: 1rem;
  }
  
  .project-title {
    font-size: 2.5rem;
  }
  
  .project-stats {
    gap: 2rem;
  }
  
  .filter-header {
    flex-direction: column;
    gap: 1rem;
    align-items: center;
  }
  
  .filter-controls {
    gap: 1rem;
  }
  
  .filter-btn {
    padding: 0.75rem 1.25rem;
    font-size: 0.875rem;
  }
  
  .projects-grid {
    grid-template-columns: 1fr;
  }
  
  .modal-body {
    padding: 2rem;
  }
  
  .modal-title {
    font-size: 2rem;
  }
  
  .project-details-grid {
    grid-template-columns: 1fr;
  }
  
  .before-after-slider {
    height: 300px;
  }
  
  .gallery-grid {
    grid-template-columns: repeat(2, 1fr);
  }
  
  .cta-title {
    font-size: 2.5rem;
  }
  
  .cta-actions {
    flex-direction: column;
    align-items: center;
  }
  
  .awards-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (max-width: 480px) {
  .project-title {
    font-size: 2rem;
  }
  
  .filter-icon {
    display: none;
  }
  
  .pagination-btn span:not(.material-icons) {
    display: none;
  }
  
  .testimonial-content blockquote {
    font-size: 1.2rem;
  }
  
  .gallery-grid {
    grid-template-columns: 1fr;
  }
}
</style>