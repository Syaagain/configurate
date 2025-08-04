<template>
  <div>
    <!-- Hero Section -->
    <section class="gradient-bg hero-pattern">
      <div class="container-custom py-24">
        <div class="max-w-4xl mx-auto text-center text-white">
          <h1 class="text-4xl md:text-6xl font-bold mb-6">
            Unsere <span class="text-success-400">Erfolgsgeschichten</span>
          </h1>
          <p class="text-xl mb-8 text-blue-100 leading-relaxed">
            Über 50 zufriedene Kunden vertrauen auf unsere Expertise. Entdecken Sie, 
            wie wir Unternehmen dabei geholfen haben, ihre Prozesse zu optimieren.
          </p>
          <div class="grid grid-cols-2 md:grid-cols-4 gap-8 mt-12">
            <div class="text-center">
              <div class="text-3xl font-bold mb-2">50+</div>
              <div class="text-blue-100">Zufriedene Kunden</div>
            </div>
            <div class="text-center">
              <div class="text-3xl font-bold mb-2">500+</div>
              <div class="text-blue-100">Optimierte Prozesse</div>
            </div>
            <div class="text-center">
              <div class="text-3xl font-bold mb-2">40%</div>
              <div class="text-blue-100">Ø Zeitersparnis</div>
            </div>
            <div class="text-center">
              <div class="text-3xl font-bold mb-2">98%</div>
              <div class="text-blue-100">Kundenzufriedenheit</div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Filter Section -->
    <section class="py-8 bg-white sticky top-20 z-40 border-b border-neutral-200">
      <div class="container-custom">
        <div class="flex flex-wrap items-center justify-center gap-4">
          <button
            v-for="filter in filters"
            :key="filter.id"
            @click="activeFilter = filter.id"
            class="px-4 py-2 rounded-full text-sm font-medium transition-colors"
            :class="activeFilter === filter.id 
              ? 'bg-primary-900 text-white' 
              : 'bg-neutral-100 text-neutral-700 hover:bg-neutral-200'"
          >
            {{ filter.label }}
          </button>
        </div>
      </div>
    </section>

    <!-- Case Studies -->
    <section class="section-padding">
      <div class="container-custom">
        <div class="space-y-16">
          <div
            v-for="caseStudy in filteredCaseStudies"
            :key="caseStudy.id"
            class="fade-in-up"
          >
            <div class="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
              <!-- Content -->
              <div class="order-2 lg:order-1" :class="{ 'lg:order-2': caseStudy.id % 2 === 0 }">
                <div class="mb-4">
                  <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-primary-100 text-primary-800">
                    {{ caseStudy.industry }}
                  </span>
                  <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-neutral-100 text-neutral-800 ml-2">
                    {{ caseStudy.company_size }}
                  </span>
                </div>
                
                <h2 class="text-3xl font-bold mb-4">{{ caseStudy.title }}</h2>
                
                <div class="mb-6">
                  <h3 class="text-lg font-semibold text-red-600 mb-2">Die Herausforderung</h3>
                  <p class="text-neutral-600 leading-relaxed">{{ caseStudy.challenge }}</p>
                </div>
                
                <div class="mb-6">
                  <h3 class="text-lg font-semibold text-primary-600 mb-2">Unsere Lösung</h3>
                  <p class="text-neutral-600 leading-relaxed">{{ caseStudy.solution }}</p>
                </div>
                
                <div class="mb-8">
                  <h3 class="text-lg font-semibold text-success-600 mb-4">Die Ergebnisse</h3>
                  <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div
                      v-for="result in caseStudy.results"
                      :key="result.metric"
                      class="bg-success-50 rounded-lg p-4 text-center"
                    >
                      <div class="text-2xl font-bold text-success-600 mb-1">{{ result.value }}</div>
                      <div class="text-sm text-success-700">{{ result.metric }}</div>
                    </div>
                  </div>
                </div>
                
                <blockquote class="border-l-4 border-primary-600 pl-6 italic text-neutral-700 mb-4">
                  "{{ caseStudy.testimonial.quote }}"
                </blockquote>
                <div class="text-sm text-neutral-500">
                  — {{ caseStudy.testimonial.author }}, {{ caseStudy.testimonial.position }}
                </div>
              </div>
              
              <!-- Visual -->
              <div class="order-1 lg:order-2" :class="{ 'lg:order-1': caseStudy.id % 2 === 0 }">
                <div class="bg-neutral-100 rounded-2xl p-8 h-80 flex items-center justify-center">
                  <div class="text-center text-neutral-500">
                    <component :is="caseStudy.icon" class="w-16 h-16 mx-auto mb-4 text-primary-600" />
                    <div class="text-lg font-medium">{{ caseStudy.visual_title }}</div>
                    <div class="text-sm">{{ caseStudy.visual_subtitle }}</div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Client Testimonials -->
    <section class="section-padding bg-neutral-50">
      <div class="container-custom">
        <div class="text-center mb-16">
          <h2 class="text-3xl md:text-4xl font-bold mb-6">
            Was unsere <span class="gradient-text">Kunden</span> sagen
          </h2>
          <p class="text-xl text-neutral-600 max-w-3xl mx-auto">
            Authentische Bewertungen von Unternehmen, die bereits von unseren Lösungen profitieren.
          </p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          <div
            v-for="testimonial in testimonials"
            :key="testimonial.id"
            class="card"
          >
            <div class="flex items-center mb-4">
              <div class="flex text-yellow-400">
                <StarIcon v-for="i in 5" :key="i" class="w-5 h-5 fill-current" />
              </div>
            </div>
            
            <blockquote class="text-neutral-700 mb-6 leading-relaxed">
              "{{ testimonial.quote }}"
            </blockquote>
            
            <div class="flex items-center">
              <div class="w-12 h-12 bg-neutral-300 rounded-full mr-4"></div>
              <div>
                <div class="font-semibold">{{ testimonial.author }}</div>
                <div class="text-sm text-neutral-500">{{ testimonial.position }}</div>
                <div class="text-sm text-neutral-400">{{ testimonial.company }}</div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Client Logos -->
    <section class="section-padding">
      <div class="container-custom">
        <div class="text-center mb-12">
          <h2 class="text-2xl font-bold mb-4">Vertrauen von führenden Unternehmen</h2>
          <p class="text-neutral-600">
            Einige unserer geschätzten Kunden aus verschiedenen Branchen
          </p>
        </div>

        <div class="grid grid-cols-2 md:grid-cols-4 lg:grid-cols-6 gap-8 items-center opacity-60">
          <div
            v-for="logo in clientLogos"
            :key="logo.id"
            class="bg-neutral-100 rounded-lg p-6 h-20 flex items-center justify-center hover:opacity-100 transition-opacity"
          >
            <div class="text-neutral-500 font-semibold text-sm">{{ logo.name }}</div>
          </div>
        </div>
      </div>
    </section>

    <!-- ROI Overview -->
    <section class="section-padding bg-primary-50">
      <div class="container-custom">
        <div class="text-center mb-12">
          <h2 class="text-3xl md:text-4xl font-bold mb-6 text-primary-900">
            Messbare Erfolge
          </h2>
          <p class="text-xl text-primary-700 max-w-3xl mx-auto">
            Durchschnittliche Verbesserungen unserer Kunden in den ersten 12 Monaten
          </p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
          <div class="bg-white rounded-xl p-6 text-center shadow-lg">
            <div class="text-4xl font-bold text-success-600 mb-2">40%</div>
            <div class="text-neutral-600">Zeitersparnis</div>
            <div class="text-sm text-neutral-500 mt-2">Durchschnittlich pro Prozess</div>
          </div>

          <div class="bg-white rounded-xl p-6 text-center shadow-lg">
            <div class="text-4xl font-bold text-blue-600 mb-2">25%</div>
            <div class="text-neutral-600">Kostensenkung</div>
            <div class="text-sm text-neutral-500 mt-2">Operationelle Kosten</div>
          </div>

          <div class="bg-white rounded-xl p-6 text-center shadow-lg">
            <div class="text-4xl font-bold text-purple-600 mb-2">90%</div>
            <div class="text-neutral-600">Weniger Fehler</div>
            <div class="text-sm text-neutral-500 mt-2">In automatisierten Prozessen</div>
          </div>

          <div class="bg-white rounded-xl p-6 text-center shadow-lg">
            <div class="text-4xl font-bold text-orange-600 mb-2">350%</div>
            <div class="text-neutral-600">ROI</div>
            <div class="text-sm text-neutral-500 mt-2">Return on Investment</div>
          </div>
        </div>
      </div>
    </section>

    <!-- CTA Section -->
    <section class="section-padding gradient-bg hero-pattern">
      <div class="container-custom text-center">
        <div class="max-w-4xl mx-auto text-white">
          <h2 class="text-3xl md:text-5xl font-bold mb-6">
            Werden Sie unser nächster Erfolg
          </h2>
          <p class="text-xl mb-8 text-blue-100">
            Lassen Sie uns gemeinsam eine Erfolgsgeschichte für Ihr Unternehmen schreiben. 
            Die kostenlose Erstberatung ist der erste Schritt.
          </p>
          <div class="flex flex-col sm:flex-row gap-4 justify-center">
            <NuxtLink to="/kontakt" class="btn bg-success-600 text-white hover:bg-success-700 text-lg px-8 py-4">
              Kostenlose Erstberatung vereinbaren
            </NuxtLink>
            <NuxtLink to="/ueber-uns" class="btn-secondary bg-white/10 border-white/30 text-white hover:bg-white/20">
              Unser Team kennenlernen
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
  ChartBarIcon,
  CogIcon,
  DocumentTextIcon,
  ShoppingCartIcon,
  BuildingOfficeIcon,
  UserGroupIcon,
  StarIcon
} from '@heroicons/vue/24/outline'

// SEO
useHead({
  title: 'Referenzen & Erfolgsgeschichten - Configuraid',
  meta: [
    { name: 'description', content: 'Entdecken Sie unsere Erfolgsgeschichten: 50+ zufriedene Kunden, 40% durchschnittliche Zeitersparnis, 98% Kundenzufriedenheit. Echte Projekte, messbare Ergebnisse.' }
  ]
})

// Filter system
const activeFilter = ref('alle')

const filters = ref([
  { id: 'alle', label: 'Alle Projekte' },
  { id: 'prozessoptimierung', label: 'Prozessoptimierung' },
  { id: 'automatisierung', label: 'Automatisierung' },
  { id: 'produktion', label: 'Produktion' },
  { id: 'handel', label: 'Handel' },
  { id: 'dienstleistung', label: 'Dienstleistung' }
])

// Case Studies Data
const caseStudies = ref([
  {
    id: 1,
    title: 'Bestellabwicklung um 60% beschleunigt',
    industry: 'E-Commerce',
    company_size: '50-200 Mitarbeiter',
    category: ['automatisierung', 'handel'],
    challenge: 'TechTrade GmbH kämpfte mit einer zeitaufwändigen manuellen Bestellabwicklung. Von der Bestellung bis zur Auslieferung vergingen durchschnittlich 3-4 Tage, was zu Kundenunzufriedenheit und verlorenen Aufträgen führte.',
    solution: 'Wir implementierten ein vollautomatisiertes Bestellsystem mit direkter ERP-Integration, automatischer Lagerprüfung und intelligenter Versandoptimierung. Zusätzlich wurde ein Kundenportal für Echtzeit-Tracking eingerichtet.',
    results: [
      { metric: 'Zeitersparnis', value: '60%' },
      { metric: 'Kundenzufriedenheit', value: '+35%' },
      { metric: 'Fehlerreduktion', value: '85%' },
      { metric: 'ROI nach 8 Monaten', value: '280%' }
    ],
    testimonial: {
      quote: 'Dank Configuraid konnten wir unsere Bestellabwicklung revolutionieren. Die Automatisierung funktioniert einwandfrei und unsere Kunden sind begeistert von der Geschwindigkeit.',
      author: 'Maria Schmidt',
      position: 'Geschäftsführerin'
    },
    icon: ShoppingCartIcon,
    visual_title: 'E-Commerce Automatisierung',
    visual_subtitle: 'From Order to Delivery'
  },
  {
    id: 2,
    title: 'Produktionsplanung digitalisiert',
    industry: 'Fertigung',
    company_size: '200-500 Mitarbeiter',
    category: ['prozessoptimierung', 'produktion'],
    challenge: 'ProduktionsPlus AG verlor durch ineffiziente Produktionsplanung täglich 8 Stunden produktive Zeit. Manuelle Excel-Listen führten zu Fehlern und Engpässen in der Fertigung.',
    solution: 'Implementierung eines digitalen Produktionsplanungssystems mit Echtzeit-Monitoring, automatischer Ressourcenoptimierung und vorausschauender Wartungsplanung.',
    results: [
      { metric: 'Produktivitätssteigerung', value: '45%' },
      { metric: 'Gesparte Zeit/Tag', value: '8h' },
      { metric: 'Reduzierte Ausfallzeiten', value: '70%' },
      { metric: 'Kosteneinsparung', value: '180k€/Jahr' }
    ],
    testimonial: {
      quote: 'Die Digitalisierung unserer Produktionsplanung war ein Gamechanger. Wir haben jetzt volle Transparenz und können viel effizienter produzieren.',
      author: 'Thomas Müller',
      position: 'IT-Leiter'
    },
    icon: CogIcon,
    visual_title: 'Smart Manufacturing',
    visual_subtitle: 'Digital Production Planning'
  },
  {
    id: 3,
    title: 'Rechnungsverarbeitung automatisiert',
    industry: 'Dienstleistung',
    company_size: '10-50 Mitarbeiter',
    category: ['automatisierung', 'dienstleistung'],
    challenge: 'ServiceExcellence Ltd. verarbeitete monatlich 500+ Eingangsrechnungen komplett manuell. Dies band zwei Vollzeitkräfte und führte regelmäßig zu Zahlungsverzögerungen.',
    solution: 'Einführung einer KI-gestützten Rechnungsverarbeitung mit OCR-Technologie, automatischer Datenextraktion und intelligentem Workflow-Routing für Freigabeprozesse.',
    results: [
      { metric: 'Bearbeitungszeit', value: '-95%' },
      { metric: 'Freigesetzte Kapazität', value: '1.8 FTE' },
      { metric: 'Fehlerrate', value: '-98%' },
      { metric: 'Liquiditätsverbesserung', value: '25%' }
    ],
    testimonial: {
      quote: 'Unglaublich, wie viel Zeit wir durch die Automatisierung der Rechnungsverarbeitung gewonnen haben. Unsere Mitarbeiter können sich endlich auf wertschöpfende Tätigkeiten konzentrieren.',
      author: 'Sarah Weber',
      position: 'COO'
    },
    icon: DocumentTextIcon,
    visual_title: 'Document Automation',
    visual_subtitle: 'AI-Powered Processing'
  }
])

// Filtered case studies based on active filter
const filteredCaseStudies = computed(() => {
  if (activeFilter.value === 'alle') {
    return caseStudies.value
  }
  return caseStudies.value.filter(study => 
    study.category.includes(activeFilter.value)
  )
})

// Testimonials
const testimonials = ref([
  {
    id: 1,
    quote: 'Configuraid hat unser Unternehmen transformiert. Die Effizienzsteigerung ist beeindruckend und das Team ist hochprofessionell.',
    author: 'Dr. Andreas Müller',
    position: 'Geschäftsführer',
    company: 'InnovaTech GmbH'
  },
  {
    id: 2,
    quote: 'Endlich ein Partner, der versteht was wir brauchen. Die maßgeschneiderte Lösung funktioniert perfekt.',
    author: 'Lisa Wagner',
    position: 'Operations Manager',
    company: 'FlexiServices AG'
  },
  {
    id: 3,
    quote: 'ROI bereits nach 6 Monaten erreicht. Die Investition in Configuraid war die beste Entscheidung des Jahres.',
    author: 'Michael Schmidt',
    position: 'CFO',
    company: 'OptimalFlow Ltd.'
  },
  {
    id: 4,
    quote: 'Von der Beratung bis zur Umsetzung - alles aus einer Hand und in höchster Qualität.',
    author: 'Sandra Klein',
    position: 'Prokuristen',
    company: 'EffizienzPlus GmbH'
  },
  {
    id: 5,
    quote: 'Unsere Prozesse laufen jetzt wie ein Schweizer Uhrwerk. Danke an das gesamte Configuraid-Team!',
    author: 'Robert Hoffmann',
    position: 'Head of Operations',
    company: 'AutomationPro AG'
  },
  {
    id: 6,
    quote: 'Auch nach Projektabschluss ein zuverlässiger Partner. Der Support ist erstklassig.',
    author: 'Julia Richter',
    position: 'IT-Leiterin',
    company: 'TechSolutions GmbH'
  }
])

// Client logos (placeholder data)
const clientLogos = ref([
  { id: 1, name: 'TechTrade' },
  { id: 2, name: 'ProduktionsPlus' },
  { id: 3, name: 'ServiceExcellence' },
  { id: 4, name: 'InnovaTech' },
  { id: 5, name: 'FlexiServices' },
  { id: 6, name: 'OptimalFlow' },
  { id: 7, name: 'EffizienzPlus' },
  { id: 8, name: 'AutomationPro' },
  { id: 9, name: 'TechSolutions' },
  { id: 10, name: 'SmartProcess' },
  { id: 11, name: 'DigitalFlow' },
  { id: 12, name: 'ProcessMax' }
])
</script>