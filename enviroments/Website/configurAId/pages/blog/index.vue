<template>
  <div>
    <!-- Hero Section -->
    <section class="gradient-bg hero-pattern">
      <div class="container-custom py-24">
        <div class="max-w-4xl mx-auto text-center text-white">
          <h1 class="text-4xl md:text-6xl font-bold mb-6">
            Blog & <span class="text-success-400">Insights</span>
          </h1>
          <p class="text-xl mb-8 text-blue-100 leading-relaxed">
            Aktuelle Trends, Best Practices und Expertenwissen rund um 
            Prozessoptimierung, Automatisierung und digitale Transformation.
          </p>
        </div>
      </div>
    </section>

    <!-- Search & Filter -->
    <section class="py-8 bg-white sticky top-20 z-40 border-b border-neutral-200">
      <div class="container-custom">
        <div class="flex flex-col md:flex-row gap-4 items-center justify-between">
          <!-- Search -->
          <div class="relative flex-1 max-w-md">
            <MagnifyingGlassIcon class="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-neutral-400" />
            <input
              v-model="searchQuery"
              type="text"
              placeholder="Artikel durchsuchen..."
              class="w-full pl-10 pr-4 py-2 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500"
            >
          </div>

          <!-- Category Filter -->
          <div class="flex flex-wrap gap-2">
            <button
              v-for="category in categories"
              :key="category.id"
              @click="activeCategory = category.id"
              class="px-4 py-2 rounded-full text-sm font-medium transition-colors"
              :class="activeCategory === category.id 
                ? 'bg-primary-900 text-white' 
                : 'bg-neutral-100 text-neutral-700 hover:bg-neutral-200'"
            >
              {{ category.label }}
            </button>
          </div>
        </div>
      </div>
    </section>

    <!-- Featured Article -->
    <section class="section-padding bg-neutral-50">
      <div class="container-custom">
        <div class="mb-8">
          <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-success-100 text-success-800">
            Featured Article
          </span>
        </div>
        
        <div class="bg-white rounded-2xl shadow-xl overflow-hidden">
          <div class="grid grid-cols-1 lg:grid-cols-2">
            <div class="bg-gradient-to-br from-primary-600 to-primary-800 p-8 lg:p-12 text-white">
              <div class="mb-4">
                <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-white/20 text-white">
                  {{ featuredArticle.category }}
                </span>
              </div>
              <h2 class="text-3xl font-bold mb-4">{{ featuredArticle.title }}</h2>
              <p class="text-blue-100 mb-6 leading-relaxed">{{ featuredArticle.excerpt }}</p>
              <div class="flex items-center justify-between">
                <div class="flex items-center space-x-3">
                  <div class="w-10 h-10 bg-white/20 rounded-full"></div>
                  <div>
                    <div class="font-medium">{{ featuredArticle.author }}</div>
                    <div class="text-sm text-blue-200">{{ featuredArticle.date }}</div>
                  </div>
                </div>
                <div class="text-sm text-blue-200">{{ featuredArticle.readTime }}</div>
              </div>
            </div>
            <div class="p-8 lg:p-12">
              <div class="h-full flex flex-col justify-center">
                <div class="space-y-4 mb-8">
                  <div class="flex items-start space-x-3">
                    <CheckCircleIcon class="w-6 h-6 text-success-600 mt-1 flex-shrink-0" />
                    <div>
                      <h3 class="font-semibold mb-1">Praxiserprobte Strategien</h3>
                      <p class="text-neutral-600 text-sm">Bewährte Methoden aus 50+ Projekten</p>
                    </div>
                  </div>
                  <div class="flex items-start space-x-3">
                    <CheckCircleIcon class="w-6 h-6 text-success-600 mt-1 flex-shrink-0" />
                    <div>
                      <h3 class="font-semibold mb-1">Konkrete Handlungsempfehlungen</h3>
                      <p class="text-neutral-600 text-sm">Schritt-für-Schritt Anleitungen</p>
                    </div>
                  </div>
                  <div class="flex items-start space-x-3">
                    <CheckCircleIcon class="w-6 h-6 text-success-600 mt-1 flex-shrink-0" />
                    <div>
                      <h3 class="font-semibold mb-1">ROI-Kalkulation inklusive</h3>
                      <p class="text-neutral-600 text-sm">Messbare Erfolgsmetriken</p>
                    </div>
                  </div>
                </div>
                <NuxtLink :to="`/blog/${featuredArticle.slug}`" class="btn-primary">
                  Artikel lesen
                </NuxtLink>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Blog Articles -->
    <section class="section-padding">
      <div class="container-custom">
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          <article
            v-for="article in filteredArticles"
            :key="article.id"
            class="card card-hover group"
          >
            <!-- Article Image -->
            <div class="bg-neutral-200 rounded-lg mb-4 h-48 overflow-hidden">
              <div class="w-full h-full bg-gradient-to-br from-neutral-300 to-neutral-400 flex items-center justify-center">
                <component :is="article.icon" class="w-12 h-12 text-neutral-500" />
              </div>
            </div>

            <!-- Article Content -->
            <div class="mb-4">
              <span class="inline-flex items-center px-2 py-1 rounded text-xs font-medium bg-primary-100 text-primary-800">
                {{ article.category }}
              </span>
            </div>

            <h3 class="text-xl font-semibold mb-3 group-hover:text-primary-600 transition-colors">
              {{ article.title }}
            </h3>

            <p class="text-neutral-600 mb-4 leading-relaxed">
              {{ article.excerpt }}
            </p>

            <!-- Article Meta -->
            <div class="flex items-center justify-between text-sm text-neutral-500 mb-4">
              <div class="flex items-center space-x-2">
                <div class="w-6 h-6 bg-neutral-300 rounded-full"></div>
                <span>{{ article.author }}</span>
              </div>
              <span>{{ article.readTime }}</span>
            </div>

            <div class="flex items-center justify-between">
              <span class="text-sm text-neutral-500">{{ article.date }}</span>
              <NuxtLink 
                :to="`/blog/${article.slug}`" 
                class="text-primary-600 hover:text-primary-800 font-medium text-sm transition-colors"
              >
                Weiterlesen →
              </NuxtLink>
            </div>
          </article>
        </div>

        <!-- Load More Button -->
        <div class="text-center mt-12" v-if="hasMoreArticles">
          <button
            @click="loadMoreArticles"
            class="btn-secondary"
            :disabled="loading"
          >
            <span v-if="!loading">Weitere Artikel laden</span>
            <span v-else>Lädt...</span>
          </button>
        </div>
      </div>
    </section>

    <!-- Newsletter Signup -->
    <section class="section-padding bg-primary-50">
      <div class="container-custom">
        <div class="max-w-2xl mx-auto text-center">
          <h2 class="text-3xl font-bold mb-4 text-primary-900">
            Bleiben Sie auf dem Laufenden
          </h2>
          <p class="text-primary-700 mb-8">
            Erhalten Sie die neuesten Artikel und Insights direkt in Ihr Postfach. 
            Kostenlos und jederzeit abbestellbar.
          </p>
          
          <form @submit.prevent="subscribeNewsletter" class="flex flex-col sm:flex-row gap-4 max-w-md mx-auto">
            <input
              v-model="newsletterEmail"
              type="email"
              required
              placeholder="Ihre E-Mail-Adresse"
              class="flex-1 px-4 py-3 border border-primary-200 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500"
            >
            <button
              type="submit"
              :disabled="subscribing"
              class="btn-primary px-8"
            >
              <span v-if="!subscribing">Abonnieren</span>
              <span v-else>Lädt...</span>
            </button>
          </form>
          
          <p class="text-xs text-primary-600 mt-4">
            Mit der Anmeldung stimmen Sie unserer 
            <NuxtLink to="/datenschutz" class="underline">Datenschutzerklärung</NuxtLink> zu.
          </p>
        </div>
      </div>
    </section>

    <!-- CTA Section -->
    <section class="section-padding gradient-bg hero-pattern">
      <div class="container-custom text-center">
        <div class="max-w-4xl mx-auto text-white">
          <h2 class="text-3xl md:text-5xl font-bold mb-6">
            Bereit für Ihre Transformation?
          </h2>
          <p class="text-xl mb-8 text-blue-100">
            Lassen Sie uns gemeinsam Ihre Prozesse optimieren. 
            Die kostenlose Erstberatung ist der erste Schritt.
          </p>
          <div class="flex flex-col sm:flex-row gap-4 justify-center">
            <NuxtLink to="/kontakt" class="btn bg-success-600 text-white hover:bg-success-700 text-lg px-8 py-4">
              Kostenlose Erstberatung vereinbaren
            </NuxtLink>
            <NuxtLink to="/referenzen" class="btn-secondary bg-white/10 border-white/30 text-white hover:bg-white/20">
              Erfolgsgeschichten ansehen
            </NuxtLink>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import {
  MagnifyingGlassIcon,
  CheckCircleIcon,
  ChartBarIcon,
  CogIcon,
  LightBulbIcon,
  DocumentTextIcon,
  RocketLaunchIcon,
  ShieldCheckIcon
} from '@heroicons/vue/24/outline'

// SEO
useHead({
  title: 'Blog & Insights - Prozessoptimierung Expertenwissen | Configuraid',
  meta: [
    { name: 'description', content: 'Expertenwissen zu Prozessoptimierung, Automatisierung und digitaler Transformation. Praktische Tipps, Trends und Best Practices aus über 50 Projekten.' }
  ]
})

// Search and filter state
const searchQuery = ref('')
const activeCategory = ref('alle')
const loading = ref(false)
const subscribing = ref(false)
const newsletterEmail = ref('')
const hasMoreArticles = ref(true)

// Categories
const categories = ref([
  { id: 'alle', label: 'Alle Artikel' },
  { id: 'trends', label: 'Trends' },
  { id: 'praxis-tipps', label: 'Praxis-Tipps' },
  { id: 'fallstudien', label: 'Fallstudien' },
  { id: 'tools', label: 'Tools & Technologie' }
])

// Featured Article
const featuredArticle = ref({
  id: 'featured',
  title: 'Der ultimative Guide zur Prozessoptimierung 2024',
  excerpt: 'Entdecken Sie die bewährtesten Strategien und modernsten Tools für nachhaltige Prozessverbesserungen. Mit praktischen Checklisten und ROI-Kalkulationen.',
  category: 'Praxis-Guide',
  author: 'Dr. Alexander Schmidt',
  date: '15. Dezember 2024',
  readTime: '12 Min. Lesezeit',
  slug: 'prozessoptimierung-guide-2024'
})

// Blog Articles
const articles = ref([
  {
    id: 1,
    title: 'RPA vs. traditionelle Automatisierung: Was ist besser?',
    excerpt: 'Ein detaillierter Vergleich der verschiedenen Automatisierungsansätze mit konkreten Anwendungsbeispielen und Kostenanalyse.',
    category: 'Tools & Technologie',
    categorySlug: 'tools',
    author: 'Marcus Hoffmann',
    date: '10. Dezember 2024',
    readTime: '8 Min.',
    slug: 'rpa-vs-traditionelle-automatisierung',
    icon: CogIcon
  },
  {
    id: 2,
    title: 'Change Management: Mitarbeiter für neue Prozesse begeistern',
    excerpt: 'Bewährte Strategien, um Widerstände zu überwinden und Ihr Team erfolgreich durch Veränderungsprozesse zu führen.',
    category: 'Praxis-Tipps',
    categorySlug: 'praxis-tipps',
    author: 'Sarah Weber',
    date: '5. Dezember 2024',
    readTime: '6 Min.',
    slug: 'change-management-mitarbeiter-begeistern',
    icon: LightBulbIcon
  },
  {
    id: 3,
    title: 'KI in der Prozessoptimierung: Hype oder Revolution?',
    excerpt: 'Realistische Einschätzung der aktuellen KI-Möglichkeiten in der Prozessverbesserung mit konkreten Einsatzszenarien.',
    category: 'Trends',
    categorySlug: 'trends',
    author: 'Dr. Alexander Schmidt',
    date: '28. November 2024',
    readTime: '10 Min.',
    slug: 'ki-prozessoptimierung-hype-oder-revolution',
    icon: RocketLaunchIcon
  },
  {
    id: 4,
    title: 'Fallstudie: 40% Zeitersparnis bei der Rechnungsverarbeitung',
    excerpt: 'Wie ServiceExcellence Ltd. durch intelligente Automatisierung ihre Buchhaltung revolutionierte - mit allen Details und Zahlen.',
    category: 'Fallstudien',
    categorySlug: 'fallstudien',
    author: 'Marcus Hoffmann',
    date: '20. November 2024',
    readTime: '7 Min.',
    slug: 'fallstudie-rechnungsverarbeitung-zeitersparnis',
    icon: DocumentTextIcon
  },
  {
    id: 5,
    title: 'Die 5 häufigsten Fehler bei der Prozessoptimierung',
    excerpt: 'Vermeiden Sie diese typischen Stolperfallen und lernen Sie aus den Erfahrungen anderer Unternehmen.',
    category: 'Praxis-Tipps',
    categorySlug: 'praxis-tipps',
    author: 'Sarah Weber',
    date: '15. November 2024',
    readTime: '5 Min.',
    slug: 'haeufigste-fehler-prozessoptimierung',
    icon: ShieldCheckIcon
  },
  {
    id: 6,
    title: 'Prozess-Mining: Versteckte Ineffizienzen aufdecken',
    excerpt: 'Moderne Analysemethoden zur Identifikation von Optimierungspotenzialen in komplexen Geschäftsprozessen.',
    category: 'Tools & Technologie',
    categorySlug: 'tools',
    author: 'Dr. Alexander Schmidt',
    date: '8. November 2024',
    readTime: '9 Min.',
    slug: 'prozess-mining-ineffizienzen-aufdecken',
    icon: ChartBarIcon
  }
])

// Filtered articles based on search and category
const filteredArticles = computed(() => {
  let filtered = articles.value

  // Filter by category
  if (activeCategory.value !== 'alle') {
    filtered = filtered.filter(article => article.categorySlug === activeCategory.value)
  }

  // Filter by search query
  if (searchQuery.value) {
    const query = searchQuery.value.toLowerCase()
    filtered = filtered.filter(article => 
      article.title.toLowerCase().includes(query) ||
      article.excerpt.toLowerCase().includes(query) ||
      article.category.toLowerCase().includes(query)
    )
  }

  return filtered
})

// Load more articles (placeholder function)
const loadMoreArticles = () => {
  loading.value = true
  
  // Simulate API call
  setTimeout(() => {
    loading.value = false
    hasMoreArticles.value = false // No more articles to load
  }, 1000)
}

// Newsletter subscription
const subscribeNewsletter = () => {
  if (!newsletterEmail.value) return
  
  subscribing.value = true
  
  // Simulate API call
  setTimeout(() => {
    alert('Vielen Dank! Sie wurden erfolgreich für unseren Newsletter angemeldet.')
    newsletterEmail.value = ''
    subscribing.value = false
  }, 1000)
}
</script>