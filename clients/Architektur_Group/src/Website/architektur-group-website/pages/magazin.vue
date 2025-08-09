<template>
  <div class="magazine-page">
    <!-- Hero Section mit Featured Article -->
    <section class="hero-section">
      <div class="hero-background">
        <div class="hero-overlay"></div>
        <img 
          :src="featuredArticle.image" 
          alt="Featured Article"
          class="hero-image"
        >
      </div>
      <div class="hero-content">
        <div class="hero-text">
          <span class="category-tag">{{ featuredArticle.category }}</span>
          <h1 class="hero-title">{{ featuredArticle.title }}</h1>
          <p class="hero-excerpt">{{ featuredArticle.excerpt }}</p>
          <div class="hero-meta">
            <span class="author">Von {{ featuredArticle.author }}</span>
            <span class="separator">•</span>
            <span class="date">{{ featuredArticle.date }}</span>
            <span class="separator">•</span>
            <span class="read-time">{{ featuredArticle.readTime }} Min. Lesezeit</span>
          </div>
          <button @click="openArticle(featuredArticle)" class="hero-cta">
            ARTIKEL LESEN
            <span class="material-icons">arrow_forward</span>
          </button>
        </div>
      </div>
    </section>

    <!-- Kategorien Navigation -->
    <section class="categories-section">
      <div class="container">
        <div class="categories-wrapper">
          <button 
            v-for="category in categories" 
            :key="category.id"
            @click="activeCategory = category.id"
            :class="['category-btn', { active: activeCategory === category.id }]"
            @mouseenter="playCategoryHover"
          >
            <span class="category-icon material-icons">{{ category.icon }}</span>
            <span class="category-name">{{ category.name }}</span>
            <span class="category-count">{{ category.count }}</span>
          </button>
        </div>
      </div>
    </section>

    <!-- Articles Grid -->
    <section class="articles-section">
      <div class="container">
        <div class="section-header">
          <h2 class="section-title">AKTUELLE ARTIKEL</h2>
          <div class="filter-controls">
            <button @click="viewMode = 'grid'" :class="['view-btn', { active: viewMode === 'grid' }]">
              <span class="material-icons">grid_view</span>
            </button>
            <button @click="viewMode = 'list'" :class="['view-btn', { active: viewMode === 'list' }]">
              <span class="material-icons">view_list</span>
            </button>
          </div>
        </div>

        <!-- Grid View -->
        <transition-group 
          name="article-transition" 
          tag="div" 
          :class="['articles-grid', viewMode]"
          v-if="viewMode === 'grid'"
        >
          <article 
            v-for="(article, index) in filteredArticles" 
            :key="article.id"
            class="article-card"
            :style="{ animationDelay: `${index * 0.1}s` }"
            @click="openArticle(article)"
            @mouseenter="playHoverSound"
          >
            <div class="article-image-wrapper">
              <img :src="article.image" :alt="article.title" class="article-image">
              <div class="article-overlay">
                <div class="overlay-content">
                  <span class="read-more">WEITERLESEN</span>
                </div>
              </div>
              <div class="article-badge" v-if="article.premium">
                <span class="material-icons">workspace_premium</span>
                PREMIUM
              </div>
            </div>
            
            <div class="article-content">
              <div class="article-meta">
                <span class="article-category">{{ article.category }}</span>
                <span class="article-date">{{ article.date }}</span>
              </div>
              <h3 class="article-title">{{ article.title }}</h3>
              <p class="article-excerpt">{{ article.excerpt }}</p>
              <div class="article-footer">
                <div class="author-info">
                  <span class="author-name">{{ article.author }}</span>
                </div>
                <div class="article-stats">
                  <span class="stat-item">
                    <span class="material-icons">visibility</span>
                    {{ article.views }}
                  </span>
                  <span class="stat-item">
                    <span class="material-icons">favorite</span>
                    {{ article.likes }}
                  </span>
                </div>
              </div>
            </div>
          </article>
        </transition-group>

        <!-- List View -->
        <transition-group 
          name="article-transition" 
          tag="div" 
          class="articles-list"
          v-else
        >
          <article 
            v-for="article in filteredArticles" 
            :key="article.id"
            class="article-list-item"
            @click="openArticle(article)"
          >
            <div class="list-item-image">
              <img :src="article.image" :alt="article.title">
            </div>
            <div class="list-item-content">
              <div class="list-item-header">
                <span class="article-category">{{ article.category }}</span>
                <span class="article-date">{{ article.date }}</span>
              </div>
              <h3 class="list-item-title">{{ article.title }}</h3>
              <p class="list-item-excerpt">{{ article.excerpt }}</p>
              <div class="list-item-footer">
                <div class="author-info">
                  <span class="author-name">{{ article.author }}</span>
                </div>
                <button class="read-btn">
                  ARTIKEL LESEN
                  <span class="material-icons">arrow_forward</span>
                </button>
              </div>
            </div>
          </article>
        </transition-group>

        <!-- Load More -->
        <div class="load-more-section" v-if="hasMoreArticles">
          <button @click="loadMoreArticles" class="load-more-btn">
            <span class="btn-text">MEHR ARTIKEL LADEN</span>
            <div class="loading-spinner" v-if="loading">
              <div class="spinner"></div>
            </div>
          </button>
        </div>
      </div>
    </section>

    <!-- Newsletter Section -->
    <section class="newsletter-section">
      <div class="newsletter-background">
        <div class="newsletter-pattern"></div>
      </div>
      <div class="container">
        <div class="newsletter-content">
          <div class="newsletter-icon">
            <span class="material-icons">mail_outline</span>
          </div>
          <h2 class="newsletter-title">EXKLUSIVE EINBLICKE</h2>
          <p class="newsletter-subtitle">
            Erhalten Sie monatlich die neuesten Trends, Inspirationen und exklusive Inhalte 
            aus der Welt des luxuriösen Wohnens direkt in Ihr Postfach.
          </p>
          
          <form @submit.prevent="subscribeNewsletter" class="newsletter-form">
            <div class="form-group">
              <input 
                type="email" 
                v-model="email" 
                placeholder="Ihre E-Mail-Adresse"
                class="email-input"
                required
              >
              <button type="submit" class="subscribe-btn">
                <span class="btn-text">ABONNIEREN</span>
                <span class="material-icons">send</span>
              </button>
            </div>
            <div class="form-checkbox">
              <input type="checkbox" id="consent" v-model="consent" required>
              <label for="consent">
                Ich stimme der Verarbeitung meiner Daten gemäß der 
                <a href="/datenschutz" class="link">Datenschutzerklärung</a> zu.
              </label>
            </div>
          </form>

          <div v-if="subscribed" class="success-message">
            <span class="material-icons">check_circle</span>
            Vielen Dank für Ihre Anmeldung!
          </div>
        </div>
      </div>
    </section>

    <!-- Article Modal -->
    <transition name="modal">
      <div v-if="selectedArticle" class="article-modal" @click="closeModal">
        <div class="modal-container" @click.stop>
          <button class="modal-close" @click="closeModal">
            <span class="material-icons">close</span>
          </button>
          
          <div class="modal-header">
            <img :src="selectedArticle.image" :alt="selectedArticle.title" class="modal-hero-image">
            <div class="modal-hero-overlay"></div>
            <div class="modal-hero-content">
              <span class="modal-category">{{ selectedArticle.category }}</span>
              <h1 class="modal-title">{{ selectedArticle.title }}</h1>
              <div class="modal-meta">
                <span class="modal-author">{{ selectedArticle.author }}</span>
                <span class="separator">•</span>
                <span class="modal-date">{{ selectedArticle.date }}</span>
                <span class="separator">•</span>
                <span class="modal-read-time">{{ selectedArticle.readTime }} Min.</span>
              </div>
            </div>
          </div>
          
          <div class="modal-body">
            <div class="modal-content" v-html="selectedArticle.content"></div>
            
            <div class="modal-footer">
              <div class="share-section">
                <h4>ARTIKEL TEILEN</h4>
                <div class="share-buttons">
                  <button class="share-btn">
                    <span class="material-icons">facebook</span>
                  </button>
                  <button class="share-btn">
                    <span class="material-icons">link</span>
                  </button>
                  <button class="share-btn">
                    <span class="material-icons">email</span>
                  </button>
                </div>
              </div>
              
              <div class="related-articles">
                <h4>ÄHNLICHE ARTIKEL</h4>
                <div class="related-grid">
                  <div 
                    v-for="related in relatedArticles" 
                    :key="related.id"
                    class="related-item"
                    @click="openArticle(related)"
                  >
                    <img :src="related.image" :alt="related.title">
                    <h5>{{ related.title }}</h5>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </transition>
  </div>
</template>

<script setup>
const activeCategory = ref('alle')
const viewMode = ref('grid')
const selectedArticle = ref(null)
const email = ref('')
const consent = ref(false)
const subscribed = ref(false)
const loading = ref(false)
const hasMoreArticles = ref(true)

// Featured Article
const featuredArticle = {
  id: 'featured',
  title: 'DIE KUNST DES LUXURIÖSEN WOHNENS',
  excerpt: 'Entdecken Sie, wie zeitlose Eleganz und moderne Innovation in der Gestaltung exklusiver Lebensräume verschmelzen.',
  category: 'INTERIOR DESIGN',
  author: 'Alexandra Richter',
  date: '15. November 2024',
  readTime: 8,
  image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png'
}

// Categories
const categories = [
  { id: 'alle', name: 'Alle Artikel', icon: 'apps', count: 48 },
  { id: 'interior', name: 'Interior Design', icon: 'home', count: 18 },
  { id: 'architektur', name: 'Architektur', icon: 'architecture', count: 12 },
  { id: 'wellness', name: 'Wellness & Spa', icon: 'spa', count: 8 },
  { id: 'trends', name: 'Trends', icon: 'trending_up', count: 10 }
]

// Articles Data
const articles = [
  {
    id: 1,
    title: 'Minimalistische Eleganz im Baddesign',
    excerpt: 'Wie weniger zu mehr wird: Die Philosophie des minimalistischen Luxus in modernen Badezimmern.',
    category: 'INTERIOR DESIGN',
    author: 'Marcus Weber',
    date: '12. November 2024',
    readTime: 5,
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686576cf622e38e88f0236c5.png',
    views: '2.3k',
    likes: 145,
    premium: true,
    categoryId: 'interior',
    content: `
      <p>In der heutigen schnelllebigen Welt sehnen wir uns nach Ruhe und Klarheit. 
      Das minimalistische Baddesign verkörpert diese Sehnsucht perfekt...</p>
      <h3>Die Grundprinzipien</h3>
      <p>Minimalismus im Bad bedeutet nicht Verzicht, sondern bewusste Auswahl...</p>
    `
  },
  {
    id: 2,
    title: 'Naturstein: Zeitlose Schönheit',
    excerpt: 'Von Carrara-Marmor bis Granit: Ein Leitfaden zu den edelsten Natursteinen.',
    category: 'MATERIALIEN',
    author: 'Sophie Chen',
     date: '10. November 2024',
    readTime: 7,
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png',
    views: '1.8k',
    likes: 98,
    premium: false,
    categoryId: 'architektur',
    content: `
      <p>Naturstein ist seit Jahrtausenden das Material der Wahl für luxuriöse Räume...</p>
    `
  },
  {
    id: 3,
    title: 'Wellness-Oase zu Hause',
    excerpt: 'Verwandeln Sie Ihr Badezimmer in einen privaten Spa-Bereich mit diesen Expertentipps.',
    category: 'WELLNESS & SPA',
    author: 'Dr. Elena Fischer',
    date: '8. November 2024',
    readTime: 6,
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b1ceb7b78f5ed302d.png',
    views: '3.1k',
    likes: 203,
    premium: true,
    categoryId: 'wellness',
    content: `
      <p>Ein eigenes Spa zu Hause ist kein unerreichbarer Luxus mehr...</p>
    `
  },
  {
    id: 4,
    title: 'Smart Home im Badezimmer',
    excerpt: 'Intelligente Technologien für ultimativen Komfort und Effizienz.',
    category: 'TRENDS',
    author: 'Thomas Klein',
   date: '5. November 2024',
    readTime: 4,
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b70b0803723582ed6.png',
    views: '1.5k',
    likes: 87,
    premium: false,
    categoryId: 'trends',
    content: `
      <p>Die Digitalisierung hat längst Einzug in unsere Badezimmer gehalten...</p>
    `
  },
  {
    id: 5,
    title: 'Farbtrends 2025',
    excerpt: 'Die Farben, die nächstes Jahr die Luxusbäder dominieren werden.',
    category: 'TRENDS',
    author: 'Isabella Romano',
    date: '3. November 2024',
    readTime: 5,
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1c5b097a8069ca3ac95a.png',
    views: '2.7k',
    likes: 156,
    premium: false,
    categoryId: 'trends',
    content: `
      <p>Die Farbpalette für 2025 zeigt eine Rückkehr zu natürlichen Tönen...</p>
    `
  },
  {
    id: 6,
    title: 'Lichtdesign für Atmosphäre',
    excerpt: 'Wie die richtige Beleuchtung Ihr Bad in eine Wohlfühloase verwandelt.',
    category: 'INTERIOR DESIGN',
    author: 'Michael Braun',
    date: '1. November 2024',
    readTime: 6,
    image: 'https://storage.googleapis.com/msgsndr/1VKw2Q0PPRKRbEKpruef/media/686d1e976f2c95bfc4fb1f56.png',
    views: '1.9k',
    likes: 112,
    premium: true,
    categoryId: 'interior',
    content: `
      <p>Licht ist eines der wichtigsten Gestaltungselemente im Badezimmer...</p>
    `
  }
]

const relatedArticles = computed(() => {
  if (!selectedArticle.value) return []
  return articles
    .filter(a => a.id !== selectedArticle.value.id)
    .slice(0, 3)
})

const filteredArticles = computed(() => {
  if (activeCategory.value === 'alle') {
    return articles
  }
  return articles.filter(article => article.categoryId === activeCategory.value)
})

const openArticle = (article) => {
  selectedArticle.value = article
  document.body.style.overflow = 'hidden'
}

const closeModal = () => {
  selectedArticle.value = null
  document.body.style.overflow = 'auto'
}

const subscribeNewsletter = () => {
  if (email.value && consent.value) {
    subscribed.value = true
    setTimeout(() => {
      subscribed.value = false
      email.value = ''
      consent.value = false
    }, 3000)
  }
}

const loadMoreArticles = () => {
  loading.value = true
  setTimeout(() => {
    loading.value = false
    // Hier würden weitere Artikel geladen werden
  }, 1500)
}

const playHoverSound = () => {
  // Placeholder für Hover-Sound
}

const playCategoryHover = () => {
  // Placeholder für Category-Hover-Sound
}

onUnmounted(() => {
  document.body.style.overflow = 'auto'
})
</script>

<style scoped>
.magazine-page {
  min-height: 100vh;
  background: #000;
  color: #FAFAF8;
  padding-top: 80px;
}

/* Hero Section */
.hero-section {
  position: relative;
  height: 90vh;
  overflow: hidden;
}

.hero-background {
  position: absolute;
  inset: 0;
}

.hero-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.hero-overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(
    to bottom,
    rgba(0,0,0,0.3) 0%,
    rgba(0,0,0,0.5) 50%,
    rgba(0,0,0,0.9) 100%
  );
}

.hero-content {
  position: absolute;
  inset: 0;
  display: flex;
  align-items: flex-end;
  padding: 6rem 2rem;
}

@keyframes pulse {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.8; }
}

.hero-text {
  max-width: 800px;
  animation: heroSlideUp 1.5s ease-out;
}

.category-tag {
  display: inline-block;
  color: #a47148;
  font-size: 0.875rem;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  margin-bottom: 1rem;
}

.hero-title {
  font-size: clamp(2.5rem, 6vw, 4.5rem);
  font-weight: 300;
  line-height: 1.1;
  margin-bottom: 1.5rem;
  background: linear-gradient(135deg, #FAFAF8 0%, #a47148 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.hero-excerpt {
  font-size: 1.25rem;
  line-height: 1.6;
  color: #ccc;
  margin-bottom: 2rem;
  max-width: 600px;
}

.hero-meta {
  display: flex;
  align-items: center;
  gap: 1rem;
  margin-bottom: 2rem;
  color: #999;
  font-size: 0.95rem;
}

.separator {
  color: #666;
}

.hero-cta {
  display: inline-flex;
  align-items: center;
  gap: 0.75rem;
  padding: 1rem 2.5rem;
  background: transparent;
  border: 2px solid #FAFAF8;
  color: #FAFAF8;
  font-size: 0.95rem;
  font-weight: 500;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  cursor: pointer;
  transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  position: relative;
  overflow: hidden;
}

.hero-cta::before {
  content: '';
  position: absolute;
  inset: 0;
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  transform: translateX(-100%);
  transition: transform 0.4s ease;
}

.hero-cta:hover {
  color: #000;
  border-color: #a47148;
}

.hero-cta:hover::before {
  transform: translateX(0);
}

.hero-cta span {
  position: relative;
  z-index: 1;
}

/* Categories Section */
.categories-section {
  padding: 4rem 0;
  background: linear-gradient(135deg, #0a0a0a 0%, #1a1a1a 100%);
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.container {
  max-width: 1400px;
  margin: 0 auto;
  padding: 0 2rem;
}

.categories-wrapper {
  display: flex;
  justify-content: center;
  gap: 2rem;
  flex-wrap: wrap;
}

.category-btn {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  padding: 1rem 2rem;
  background: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.1);
  color: #FAFAF8;
  border-radius: 50px;
  cursor: pointer;
  transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  backdrop-filter: blur(10px);
}

.category-btn:hover {
  background: rgba(255, 255, 255, 0.1);
  transform: translateY(-3px);
  box-shadow: 0 10px 30px rgba(164, 113, 72, 0.2);
}

.category-btn.active {
  background: linear-gradient(135deg, rgba(164, 113, 72, 0.3), rgba(250, 250, 248, 0.1));
  border-color: #a47148;
  color: #a47148;
}

.category-icon {
  font-size: 1.25rem;
}

.category-name {
  font-size: 0.95rem;
  font-weight: 400;
  letter-spacing: 0.05em;
}

.category-count {
  padding: 0.25rem 0.5rem;
  background: rgba(255, 255, 255, 0.1);
  border-radius: 20px;
  font-size: 0.75rem;
  font-weight: 600;
}

/* Articles Section */
.articles-section {
  padding: 5rem 0;
}

.section-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 3rem;
}

.section-title {
  font-size: 2.5rem;
  font-weight: 300;
  background: linear-gradient(135deg, #FAFAF8 0%, #a47148 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.filter-controls {
  display: flex;
  gap: 0.5rem;
}

.view-btn {
  width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.1);
  color: #FAFAF8;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.view-btn:hover,
.view-btn.active {
  background: rgba(164, 113, 72, 0.2);
  border-color: #a47148;
  color: #a47148;
}

/* Grid View */
.articles-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(380px, 1fr));
  gap: 3rem;
}

.article-card {
  background: rgba(255, 255, 255, 0.03);
  border-radius: 20px;
  overflow: hidden;
  cursor: pointer;
  transition: all 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  animation: fadeInUp 0.8s ease-out forwards;
  opacity: 0;
  border: 1px solid rgba(255, 255, 255, 0.05);
}

@keyframes fadeInUp {
  to {
    opacity: 1;
    transform: translateY(0);
  }
  from {
    opacity: 0;
    transform: translateY(30px);
  }
}

.article-card:hover {
  transform: translateY(-10px) scale(1.02);
  box-shadow: 0 30px 60px rgba(164, 113, 72, 0.3);
  background: rgba(255, 255, 255, 0.06);
}

.article-image-wrapper {
  position: relative;
  height: 250px;
  overflow: hidden;
}

.article-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

.article-card:hover .article-image {
  transform: scale(1.15);
}

.article-overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(45deg, rgba(0,0,0,0.8), rgba(164, 113, 72, 0.4));
  display: flex;
  align-items: center;
  justify-content: center;
  opacity: 0;
  transition: opacity 0.4s ease;
}

.article-card:hover .article-overlay {
  opacity: 1;
}

.overlay-content {
  text-align: center;
}

.read-more {
  padding: 0.75rem 2rem;
  border: 2px solid #FAFAF8;
  color: #FAFAF8;
  font-size: 0.875rem;
  letter-spacing: 0.1em;
  font-weight: 500;
  transition: all 0.3s ease;
}

.article-badge {
  position: absolute;
  top: 1rem;
  right: 1rem;
  padding: 0.5rem 1rem;
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  color: #000;
  font-size: 0.75rem;
  font-weight: 600;
  letter-spacing: 0.05em;
  border-radius: 20px;
  display: flex;
  align-items: center;
  gap: 0.25rem;
}

.article-badge .material-icons {
  font-size: 0.875rem;
}

.article-content {
  padding: 2rem;
}

.article-meta {
  display: flex;
  justify-content: space-between;
  margin-bottom: 1rem;
  font-size: 0.875rem;
  color: #999;
}

.article-category {
  color: #a47148;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  font-weight: 500;
}

.article-title {
  font-size: 1.5rem;
  font-weight: 400;
  line-height: 1.3;
  margin-bottom: 1rem;
  color: #FAFAF8;
  transition: color 0.3s ease;
}

.article-card:hover .article-title {
  color: #a47148;
}

.article-excerpt {
  font-size: 1rem;
  line-height: 1.6;
  color: #ccc;
  margin-bottom: 1.5rem;
}

.article-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.author-info {
  display: flex;
  align-items: center;
  gap: 0.75rem;
}


.author-name {
  font-size: 0.875rem;
  color: #ccc;
}

.article-stats {
  display: flex;
  gap: 1rem;
}

.stat-item {
  display: flex;
  align-items: center;
  gap: 0.25rem;
  color: #999;
  font-size: 0.875rem;
}

.stat-item .material-icons {
  font-size: 1rem;
}

/* List View */
.articles-list {
  display: flex;
  flex-direction: column;
  gap: 2rem;
}

.article-list-item {
  display: grid;
  grid-template-columns: 300px 1fr;
  gap: 2rem;
  background: rgba(255, 255, 255, 0.03);
  border-radius: 20px;
  overflow: hidden;
  cursor: pointer;
  transition: all 0.4s ease;
  border: 1px solid rgba(255, 255, 255, 0.05);
}

.article-list-item:hover {
  background: rgba(255, 255, 255, 0.06);
  transform: translateX(10px);
}

.list-item-image {
  height: 200px;
  overflow: hidden;
}

.list-item-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.6s ease;
}

.article-list-item:hover .list-item-image img {
  transform: scale(1.1);
}

.list-item-content {
  padding: 2rem;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

.list-item-header {
  display: flex;
  justify-content: space-between;
  margin-bottom: 1rem;
  font-size: 0.875rem;
  color: #999;
}

.list-item-title {
  font-size: 1.75rem;
  font-weight: 400;
  line-height: 1.3;
  margin-bottom: 1rem;
  color: #FAFAF8;
}

.list-item-excerpt {
  font-size: 1.05rem;
  line-height: 1.6;
  color: #ccc;
  margin-bottom: 1.5rem;
}

.list-item-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.read-btn {
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

.read-btn:hover {
  background: #a47148;
  color: #000;
}

/* Load More */
.load-more-section {
  text-align: center;
  margin-top: 4rem;
}

.load-more-btn {
  padding: 1rem 3rem;
  background: transparent;
  border: 2px solid #FAFAF8;
  color: #FAFAF8;
  font-size: 0.95rem;
  letter-spacing: 0.1em;
  cursor: pointer;
  transition: all 0.4s ease;
  position: relative;
}

.load-more-btn:hover {
  background: #FAFAF8;
  color: #000;
}

.loading-spinner {
  position: absolute;
  inset: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  background: rgba(0, 0, 0, 0.9);
}

.spinner {
  width: 24px;
  height: 24px;
  border: 2px solid #FAFAF8;
  border-top-color: transparent;
  border-radius: 50%;
  animation: spin 1s linear infinite;
}

@keyframes spin {
  to { transform: rotate(360deg); }
}

/* Newsletter Section */
.newsletter-section {
  position: relative;
  padding: 8rem 0;
  overflow: hidden;
}

.newsletter-background {
  position: absolute;
  inset: 0;
  background: linear-gradient(135deg, #1a1a1a 0%, #0a0a0a 100%);
}

.newsletter-pattern {
  position: absolute;
  inset: 0;
  opacity: 0.1;
  background-image: 
    repeating-linear-gradient(45deg, #a47148 0, #a47148 1px, transparent 1px, transparent 15px),
    repeating-linear-gradient(-45deg, #a47148 0, #a47148 1px, transparent 1px, transparent 15px);
}

.newsletter-content {
  position: relative;
  z-index: 1;
  text-align: center;
  max-width: 700px;
  margin: 0 auto;
}

.newsletter-icon {
  width: 80px;
  height: 80px;
  margin: 0 auto 2rem;
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
}

.newsletter-icon .material-icons {
  font-size: 2.5rem;
  color: #000;
}

.newsletter-title {
  font-size: 3rem;
  font-weight: 300;
  margin-bottom: 1rem;
  background: linear-gradient(135deg, #FAFAF8 0%, #a47148 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.newsletter-subtitle {
  font-size: 1.15rem;
  line-height: 1.6;
  color: #ccc;
  margin-bottom: 3rem;
}

.newsletter-form {
  max-width: 500px;
  margin: 0 auto;
}

.form-group {
  display: flex;
  gap: 1rem;
  margin-bottom: 1.5rem;
}

.email-input {
  flex: 1;
  padding: 1rem 1.5rem;
  background: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.2);
  color: #FAFAF8;
  font-size: 1rem;
  border-radius: 50px;
  transition: all 0.3s ease;
}

.email-input::placeholder {
  color: #666;
}

.email-input:focus {
  outline: none;
  background: rgba(255, 255, 255, 0.08);
  border-color: #a47148;
}

.subscribe-btn {
  padding: 1rem 2rem;
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  color: #000;
  border: none;
  border-radius: 50px;
  font-weight: 600;
  letter-spacing: 0.05em;
  cursor: pointer;
  transition: all 0.4s ease;
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.subscribe-btn:hover {
  transform: translateY(-3px);
  box-shadow: 0 15px 30px rgba(164, 113, 72, 0.4);
}

.form-checkbox {
  display: flex;
  align-items: flex-start;
  gap: 0.75rem;
  text-align: left;
}

.form-checkbox input[type="checkbox"] {
  margin-top: 0.25rem;
}

.form-checkbox label {
  font-size: 0.875rem;
  color: #999;
  line-height: 1.4;
}

.form-checkbox .link {
  color: #a47148;
  text-decoration: underline;
}

.success-message {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.75rem;
  padding: 1rem 2rem;
  background: rgba(76, 175, 80, 0.1);
  border: 1px solid #4CAF50;
  color: #4CAF50;
  border-radius: 50px;
  font-weight: 500;
  animation: slideInUp 0.5s ease;
}

@keyframes slideInUp {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* Article Modal */
.article-modal {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.95);
  z-index: 1000;
  overflow-y: auto;
  backdrop-filter: blur(20px);
}

.modal-container {
  max-width: 1200px;
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
}

.modal-close:hover {
  background: rgba(255, 255, 255, 0.2);
  transform: rotate(90deg);
}

.modal-header {
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
    rgba(0,0,0,0.7) 100%
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
  font-size: 2.5rem;
  font-weight: 300;
  line-height: 1.2;
  margin-bottom: 1.5rem;
}

.modal-meta {
  display: flex;
  align-items: center;
  gap: 1rem;
  font-size: 0.95rem;
  color: #ccc;
}


.modal-body {
  padding: 3rem;
}

.modal-content {
  max-width: 800px;
  margin: 0 auto 4rem;
  font-size: 1.1rem;
  line-height: 1.8;
  color: #ccc;
}

.modal-content h3 {
  font-size: 1.75rem;
  font-weight: 400;
  margin: 2rem 0 1rem;
  color: #FAFAF8;
}

.modal-content p {
  margin-bottom: 1.5rem;
}

.modal-footer {
  border-top: 1px solid rgba(255, 255, 255, 0.1);
  padding-top: 3rem;
}

.share-section {
  margin-bottom: 3rem;
}

.share-section h4 {
  font-size: 1rem;
  letter-spacing: 0.1em;
  margin-bottom: 1.5rem;
  color: #FAFAF8;
}

.share-buttons {
  display: flex;
  gap: 1rem;
}

.share-btn {
  width: 50px;
  height: 50px;
  background: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 50%;
  color: #FAFAF8;
  cursor: pointer;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  justify-content: center;
}

.share-btn:hover {
  background: #a47148;
  border-color: #a47148;
  color: #000;
}

.related-articles h4 {
  font-size: 1rem;
  letter-spacing: 0.1em;
  margin-bottom: 1.5rem;
  color: #FAFAF8;
}

.related-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 2rem;
}

.related-item {
  cursor: pointer;
  transition: all 0.3s ease;
}

.related-item:hover {
  transform: translateY(-5px);
}

.related-item img {
  width: 100%;
  height: 150px;
  object-fit: cover;
  border-radius: 10px;
  margin-bottom: 1rem;
}

.related-item h5 {
  font-size: 1rem;
  font-weight: 400;
  color: #FAFAF8;
  line-height: 1.3;
}

/* Animations */
@keyframes heroSlideUp {
  from {
    opacity: 0;
    transform: translateY(50px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* Transitions */
.article-transition-enter-active,
.article-transition-leave-active {
  transition: all 0.5s ease;
}

.article-transition-enter-from {
  opacity: 0;
  transform: translateY(30px);
}

.article-transition-leave-to {
  opacity: 0;
  transform: translateY(-30px);
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

/* Responsive Design */
@media (max-width: 1024px) {
  .articles-grid {
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
    gap: 2rem;
  }
  
  .article-list-item {
    grid-template-columns: 1fr;
  }
  
  .list-item-image {
    height: 250px;
  }
  
  .related-grid {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 768px) {
  .hero-content {
    padding: 3rem 1.5rem;
  }
  
  .hero-title {
    font-size: 2.5rem;
  }
  
  .hero-excerpt {
    font-size: 1.1rem;
  }
  
  .hero-meta {
    flex-wrap: wrap;
  }
  
  .categories-wrapper {
    gap: 1rem;
  }
  
  .category-btn {
    padding: 0.75rem 1.5rem;
  }
  
  .articles-grid {
    grid-template-columns: 1fr;
  }
  
  .section-header {
    flex-direction: column;
    gap: 1.5rem;
    align-items: flex-start;
  }
  
  .form-group {
    flex-direction: column;
  }
  
  .modal-hero-content {
    padding: 2rem;
  }
  
  .modal-title {
    font-size: 2rem;
  }
  
  .modal-body {
    padding: 2rem;
  }
}

@media (max-width: 480px) {
  .hero-title {
    font-size: 2rem;
  }
  
  .newsletter-title {
    font-size: 2rem;
  }
  
  .category-btn {
    padding: 0.5rem 1rem;
    font-size: 0.875rem;
  }
  
  .category-icon {
    display: none;
  }
}
</style>