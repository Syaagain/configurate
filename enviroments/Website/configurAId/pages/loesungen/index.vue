<template>
  <div>
    <!-- Hero Section -->
    <section class="gradient-bg hero-pattern">
      <div class="container-custom py-24">
        <div class="max-w-4xl mx-auto text-center text-white">
          <h1 class="text-4xl md:text-6xl font-bold mb-6">
            Maßgeschneiderte <span class="text-success-400">Lösungen</span>
          </h1>
          <p class="text-xl mb-8 text-blue-100 leading-relaxed">
            Branchen- und größenspezifische Lösungen für optimale Prozesse. 
            Entdecken Sie, wie andere Unternehmen erfolgreich optimiert haben.
          </p>
          <div class="grid grid-cols-2 md:grid-cols-4 gap-8 mt-12">
            <div class="text-center">
              <div class="text-3xl font-bold mb-2">15+</div>
              <div class="text-blue-100">Branchen</div>
            </div>
            <div class="text-center">
              <div class="text-3xl font-bold mb-2">50+</div>
              <div class="text-blue-100">Erfolgreiche Projekte</div>
            </div>
            <div class="text-center">
              <div class="text-3xl font-bold mb-2">40%</div>
              <div class="text-blue-100">Ø Effizienzsteigerung</div>
            </div>
            <div class="text-center">
              <div class="text-3xl font-bold mb-2">98%</div>
              <div class="text-blue-100">Kundenzufriedenheit</div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Filter Tabs -->
    <section class="py-8 bg-white sticky top-20 z-40 border-b border-neutral-200">
      <div class="container-custom">
        <div class="flex justify-center">
          <div class="flex bg-neutral-100 rounded-lg p-1">
            <button
              @click="activeTab = 'branchen'"
              class="px-6 py-2 rounded-md text-sm font-medium transition-colors"
              :class="activeTab === 'branchen' 
                ? 'bg-white text-primary-900 shadow-sm' 
                : 'text-neutral-600 hover:text-neutral-900'"
            >
              Nach Branchen
            </button>
            <button
              @click="activeTab = 'groesse'"
              class="px-6 py-2 rounded-md text-sm font-medium transition-colors"
              :class="activeTab === 'groesse' 
                ? 'bg-white text-primary-900 shadow-sm' 
                : 'text-neutral-600 hover:text-neutral-900'"
            >
              Nach Unternehmensgröße
            </button>
          </div>
        </div>
      </div>
    </section>

    <!-- Industry Solutions -->
    <section v-show="activeTab === 'branchen'" class="section-padding">
      <div class="container-custom">
        <div class="text-center mb-16">
          <h2 class="text-3xl md:text-4xl font-bold mb-6">
            Lösungen nach <span class="gradient-text">Branchen</span>
          </h2>
          <p class="text-xl text-neutral-600 max-w-3xl mx-auto">
            Jede Branche hat ihre eigenen Herausforderungen. Wir kennen sie und haben passende Lösungen.
          </p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          <div
            v-for="industry in industries"
            :key="industry.id"
            class="card card-hover group"
          >
            <div class="flex items-center mb-6">
              <div class="p-3 rounded-lg mr-4" :class="industry.iconBg">
                <component :is="industry.icon" class="w-8 h-8" :class="industry.iconColor" />
              </div>
              <h3 class="text-xl font-semibold">{{ industry.name }}</h3>
            </div>

            <p class="text-neutral-600 mb-6 leading-relaxed">{{ industry.description }}</p>

            <div class="mb-6">
              <h4 class="font-semibold mb-3 text-sm text-neutral-700 uppercase tracking-wide">
                Typische Herausforderungen:
              </h4>
              <ul class="space-y-2">
                <li
                  v-for="challenge in industry.challenges"
                  :key="challenge"
                  class="flex items-start space-x-2 text-sm text-neutral-600"
                >
                  <ExclamationTriangleIcon class="w-4 h-4 text-orange-500 mt-0.5 flex-shrink-0" />
                  <span>{{ challenge }}</span>
                </li>
              </ul>
            </div>

            <div class="mb-6">
              <h4 class="font-semibold mb-3 text-sm text-success-700 uppercase tracking-wide">
                Unsere Lösungsansätze:
              </h4>
              <ul class="space-y-2">
                <li
                  v-for="solution in industry.solutions"
                  :key="solution"
                  class="flex items-start space-x-2 text-sm text-neutral-600"
                >
                  <CheckCircleIcon class="w-4 h-4 text-success-500 mt-0.5 flex-shrink-0" />
                  <span>{{ solution }}</span>
                </li>
              </ul>
            </div>

            <!-- Success Metrics -->
            <div class="bg-neutral-50 rounded-lg p-4 mb-4">
              <h4 class="font-semibold mb-2 text-sm">Typische Verbesserungen:</h4>
              <div class="grid grid-cols-2 gap-2 text-sm">
                <div class="text-center">
                  <div class="font-bold text-success-600">{{ industry.metrics.efficiency }}</div>
                  <div class="text-xs text-neutral-600">Effizienz</div>
                </div>
                <div class="text-center">
                  <div class="font-bold text-success-600">{{ industry.metrics.cost }}</div>
                  <div class="text-xs text-neutral-600">Kosten</div>
                </div>
              </div>
            </div>

            <div class="flex items-center justify-between">
              <span class="text-sm text-neutral-500">{{ industry.projects }} Projekte</span>
              <NuxtLink to="/kontakt" class="text-primary-600 hover:text-primary-800 font-medium text-sm transition-colors">
                Beratung anfragen →
              </NuxtLink>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Company Size Solutions -->
    <section v-show="activeTab === 'groesse'" class="section-padding">
      <div class="container-custom">
        <div class="text-center mb-16">
          <h2 class="text-3xl md:text-4xl font-bold mb-6">
            Lösungen nach <span class="gradient-text">Unternehmensgröße</span>
          </h2>
          <p class="text-xl text-neutral-600 max-w-3xl mx-auto">
            Die richtige Lösung für Ihre Unternehmensgröße - von Start-up bis Konzern.
          </p>
        </div>

        <div class="space-y-16">
          <div
            v-for="(size, index) in companySizes"
            :key="size.id"
            class="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center"
          >
            <!-- Content -->
            <div :class="{ 'lg:order-2': index % 2 === 0 }">
              <div class="mb-4">
                <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-primary-100 text-primary-800">
                  {{ size.range }}
                </span>
              </div>
              
              <h3 class="text-3xl font-bold mb-4">{{ size.name }}</h3>
              <p class="text-lg text-neutral-600 mb-6 leading-relaxed">{{ size.description }}</p>

              <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-8">
                <div>
                  <h4 class="font-semibold mb-3 text-success-700">Fokusthemen</h4>
                  <ul class="space-y-2">
                    <li
                      v-for="focus in size.focus"
                      :key="focus"
                      class="flex items-start space-x-2 text-sm text-neutral-600"
                    >
                      <CheckCircleIcon class="w-4 h-4 text-success-500 mt-0.5 flex-shrink-0" />
                      <span>{{ focus }}</span>
                    </li>
                  </ul>
                </div>
                
                <div>
                  <h4 class="font-semibold mb-3 text-primary-700">Lösungsansätze</h4>
                  <ul class="space-y-2">
                    <li
                      v-for="approach in size.approaches"
                      :key="approach"
                      class="flex items-start space-x-2 text-sm text-neutral-600"
                    >
                      <ArrowRightIcon class="w-4 h-4 text-primary-500 mt-0.5 flex-shrink-0" />
                      <span>{{ approach }}</span>
                    </li>
                  </ul>
                </div>
              </div>

              <div class="flex flex-col sm:flex-row gap-4">
                <NuxtLink to="/kontakt" class="btn-primary">
                  Beratung für {{ size.name }} anfragen
                </NuxtLink>
                <button @click="openCaseStudy(size.caseStudy)" class="btn-secondary">
                  Erfolgsgeschichte ansehen
                </button>
              </div>
            </div>

            <!-- Visual/Stats -->
            <div :class="{ 'lg:order-1': index % 2 === 0 }">
              <div class="bg-neutral-50 rounded-2xl p-8">
                <div class="grid grid-cols-2 gap-6">
                  <div class="text-center">
                    <div class="text-3xl font-bold text-primary-600 mb-2">{{ size.stats.projects }}</div>
                    <div class="text-sm text-neutral-600">Projekte</div>
                  </div>
                  <div class="text-center">
                    <div class="text-3xl font-bold text-success-600 mb-2">{{ size.stats.avgImprovement }}</div>
                    <div class="text-sm text-neutral-600">Ø Verbesserung</div>
                  </div>
                  <div class="text-center">
                    <div class="text-3xl font-bold text-blue-600 mb-2">{{ size.stats.timeToValue }}</div>
                    <div class="text-sm text-neutral-600">Time to Value</div>
                  </div>
                  <div class="text-center">
                    <div class="text-3xl font-bold text-purple-600 mb-2">{{ size.stats.satisfaction }}</div>
                    <div class="text-sm text-neutral-600">Zufriedenheit</div>
                  </div>
                </div>

                <div class="mt-6 p-4 bg-white rounded-lg">
                  <h4 class="font-semibold mb-2 text-center">Typische Projektdauer</h4>
                  <div class="text-center">
                    <span class="text-2xl font-bold text-neutral-900">{{ size.duration }}</span>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Case Study Modal -->
    <div v-if="selectedCaseStudy" class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black bg-opacity-50" @click="closeCaseStudy">
      <div class="bg-white rounded-2xl max-w-2xl w-full max-h-[90vh] overflow-y-auto" @click.stop>
        <div class="p-6">
          <div class="flex items-center justify-between mb-6">
            <h3 class="text-2xl font-bold">{{ selectedCaseStudy.title }}</h3>
            <button @click="closeCaseStudy" class="text-neutral-400 hover:text-neutral-600">
              <XMarkIcon class="w-6 h-6" />
            </button>
          </div>
          
          <div class="space-y-6">
            <div>
              <h4 class="font-semibold mb-2 text-red-600">Herausforderung</h4>
              <p class="text-neutral-700 leading-relaxed">{{ selectedCaseStudy.challenge }}</p>
            </div>
            
            <div>
              <h4 class="font-semibold mb-2 text-primary-600">Lösung</h4>
              <p class="text-neutral-700 leading-relaxed">{{ selectedCaseStudy.solution }}</p>
            </div>
            
            <div>
              <h4 class="font-semibold mb-4 text-success-600">Ergebnisse</h4>
              <div class="grid grid-cols-2 gap-4">
                <div
                  v-for="result in selectedCaseStudy.results"
                  :key="result.metric"
                  class="bg-success-50 rounded-lg p-4 text-center"
                >
                  <div class="text-xl font-bold text-success-600 mb-1">{{ result.value }}</div>
                  <div class="text-sm text-success-700">{{ result.metric }}</div>
                </div>
              </div>
            </div>
            
            <div class="border-t pt-4">
              <blockquote class="italic text-neutral-700 mb-2">
                "{{ selectedCaseStudy.testimonial.quote }}"
              </blockquote>
              <div class="text-sm text-neutral-500">
                — {{ selectedCaseStudy.testimonial.author }}, {{ selectedCaseStudy.testimonial.position }}
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- CTA Section -->
    <section class="section-padding gradient-bg hero-pattern">
      <div class="container-custom text-center">
        <div class="max-w-4xl mx-auto text-white">
          <h2 class="text-3xl md:text-5xl font-bold mb-6">
            Finden Sie Ihre passende Lösung
          </h2>
          <p class="text-xl mb-8 text-blue-100">
            Lassen Sie uns gemeinsam die optimale Lösung für Ihre Branche und 
            Unternehmensgröße entwickeln. Die Erstberatung ist kostenlos.
          </p>
          <div class="flex flex-col sm:flex-row gap-4 justify-center">
            <NuxtLink to="/kontakt" class="btn bg-success-600 text-white hover:bg-success-700 text-lg px-8 py-4">
              Kostenlose Lösungsberatung
            </NuxtLink>
            <NuxtLink to="/referenzen" class="btn-secondary bg-white/10 border-white/30 text-white hover:bg-white/20">
              Weitere Erfolgsgeschichten
            </NuxtLink>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import {
  BuildingOfficeIcon,
  ShoppingCartIcon,
  UserGroupIcon,
  HeartIcon,
  TruckIcon,
  BanknotesIcon,
  AcademicCapIcon,
  HomeIcon,
  ExclamationTriangleIcon,
  CheckCircleIcon,
  ArrowRightIcon,
  XMarkIcon
} from '@heroicons/vue/24/outline'

// SEO
useHead({
  title: 'Lösungen nach Branchen & Unternehmensgröße | Configuraid',
  meta: [
    { name: 'description', content: 'Maßgeschneiderte Lösungen für jede Branche und Unternehmensgröße. Von Start-ups bis Konzerne, von Produktion bis Dienstleistung. Kostenlose Beratung.' }
  ]
})

// State
const activeTab = ref('branchen')
const selectedCaseStudy = ref(null)

// Industry data
const industries = ref([
  {
    id: 1,
    name: 'Produktion & Fertigung',
    description: 'Optimierung von Produktionsprozessen, Supply Chain Management und Qualitätssicherung.',
    icon: BuildingOfficeIcon,
    iconBg: 'bg-blue-100',
    iconColor: 'text-blue-600',
    challenges: [
      'Komplexe Produktionsabläufe',
      'Hohe Materialkosten',
      'Qualitätsschwankungen',
      'Lange Durchlaufzeiten'
    ],
    solutions: [
      'Lean Production Implementierung',
      'Predictive Maintenance',
      'Supply Chain Automation',
      'Quality Management Systeme'
    ],
    metrics: {
      efficiency: '+35%',
      cost: '-25%'
    },
    projects: '15+'
  },
  {
    id: 2,
    name: 'Handel & E-Commerce',
    description: 'Digitale Transformation im Handel mit Fokus auf Customer Experience und Operations.',
    icon: ShoppingCartIcon,
    iconBg: 'bg-green-100',
    iconColor: 'text-green-600',
    challenges: [
      'Omnichannel Integration',
      'Inventory Management',
      'Customer Journey Optimization',
      'Skalierung der IT-Systeme'
    ],
    solutions: [
      'E-Commerce Plattformen',
      'Automatisierte Bestellabwicklung',
      'Customer Data Platforms',
      'Personalisierung & AI'
    ],
    metrics: {
      efficiency: '+45%',
      cost: '-20%'
    },
    projects: '12+'
  },
  {
    id: 3,
    name: 'Dienstleistung',
    description: 'Prozessoptimierung für serviceorientierte Unternehmen und Beratungen.',
    icon: UserGroupIcon,
    iconBg: 'bg-purple-100',
    iconColor: 'text-purple-600',
    challenges: [
      'Manuelle Workflows',
      'Kundenservice-Effizienz',
      'Ressourcenplanung',
      'Projektmanagement'
    ],
    solutions: [
      'Workflow Automation',
      'CRM Integration',
      'Service Desk Optimization',
      'Performance Analytics'
    ],
    metrics: {
      efficiency: '+40%',
      cost: '-30%'
    },
    projects: '18+'
  },
  {
    id: 4,
    name: 'Gesundheitswesen',
    description: 'Digitale Lösungen für Kliniken, Praxen und Gesundheitsdienstleister.',
    icon: HeartIcon,
    iconBg: 'bg-red-100',
    iconColor: 'text-red-600',
    challenges: [
      'Patientendaten-Management',
      'Compliance & Datenschutz',
      'Terminplanung',
      'Dokumentation'
    ],
    solutions: [
      'Digitale Patientenakte',
      'Terminmanagement-Systeme',
      'Workflow-Digitalisierung',
      'DSGVO-konforme Lösungen'
    ],
    metrics: {
      efficiency: '+30%',
      cost: '-15%'
    },
    projects: '8+'
  },
  {
    id: 5,
    name: 'Logistik & Transport',
    description: 'Optimierung von Logistikprozessen und Transportmanagement.',
    icon: TruckIcon,
    iconBg: 'bg-yellow-100',
    iconColor: 'text-yellow-600',
    challenges: [
      'Routenoptimierung',
      'Warehouse Management',
      'Tracking & Tracing',
      'Last-Mile Delivery'
    ],
    solutions: [
      'Transport Management Systeme',
      'Warehouse Automation',
      'Real-time Tracking',
      'Predictive Analytics'
    ],
    metrics: {
      efficiency: '+50%',
      cost: '-35%'
    },
    projects: '10+'
  },
  {
    id: 6,
    name: 'Finanzdienstleistung',
    description: 'Digitalisierung von Finanzprozessen und Compliance-Management.',
    icon: BanknotesIcon,
    iconBg: 'bg-indigo-100',
    iconColor: 'text-indigo-600',
    challenges: [
      'Regulatory Compliance',
      'Risikomanagement',
      'Customer Onboarding',
      'Prozessautomatisierung'
    ],
    solutions: [
      'RegTech Lösungen',
      'Automated Underwriting',
      'Digital Onboarding',
      'RPA für Backoffice'
    ],
    metrics: {
      efficiency: '+60%',
      cost: '-40%'
    },
    projects: '6+'
  }
])

// Company size data
const companySizes = ref([
  {
    id: 1,
    name: 'Start-ups & kleine Unternehmen',
    range: '1-50 Mitarbeiter',
    description: 'Schnelle, kostengünstige Lösungen für wachsende Unternehmen mit begrenzten Ressourcen.',
    focus: [
      'Grundlegende Prozessstrukturen',
      'Skalierbare Systeme',
      'Cost-effective Tools',
      'Rapid Implementation'
    ],
    approaches: [
      'Cloud-first Strategien',
      'No-Code/Low-Code Lösungen',
      'Standardisierte Workflows',
      'Outsourcing-Optionen'
    ],
    stats: {
      projects: '20+',
      avgImprovement: '+55%',
      timeToValue: '4-8 Wo.',
      satisfaction: '96%'
    },
    duration: '2-8 Wochen',
    caseStudy: {
      title: 'Start-up skaliert Kundenservice um 300%',
      challenge: 'Ein wachsendes SaaS-Start-up kämpfte mit überlasteten manuellen Kundenservice-Prozessen.',
      solution: 'Implementierung eines automatisierten Ticket-Systems mit KI-gestützter Kategorisierung.',
      results: [
        { metric: 'Antwortzeit', value: '-75%' },
        { metric: 'Kapazität', value: '+300%' },
        { metric: 'Kundenzufriedenheit', value: '+40%' },
        { metric: 'Kosten pro Ticket', value: '-60%' }
      ],
      testimonial: {
        quote: 'Innerhalb von 6 Wochen konnten wir unseren Kundenservice komplett transformieren.',
        author: 'Lisa Weber',
        position: 'CEO, TechStart GmbH'
      }
    }
  },
  {
    id: 2,
    name: 'Mittelständische Unternehmen',
    range: '50-500 Mitarbeiter',
    description: 'Ausgewogene Lösungen zwischen Innovation und Stabilität für etablierte Mittelständler.',
    focus: [
      'Prozessintegration',
      'Systemkonsolidierung',
      'Change Management',
      'ROI Optimierung'
    ],
    approaches: [
      'Hybride Cloud-Strategien',
      'Schrittweise Digitalisierung',
      'Integration bestehender Systeme',
      'Mitarbeiter-Enablement'
    ],
    stats: {
      projects: '25+',
      avgImprovement: '+42%',
      timeToValue: '8-16 Wo.',
      satisfaction: '98%'
    },
    duration: '3-6 Monate',
    caseStudy: {
      title: 'Mittelständler digitalisiert komplette Auftragsabwicklung',
      challenge: 'Traditioneller Maschinenbauer mit veralteten ERP-Systemen und manuellen Prozessen.',
      solution: 'Moderne ERP-Integration mit automatisierten Workflows und digitalem Dokumentenmanagement.',
      results: [
        { metric: 'Durchlaufzeit', value: '-45%' },
        { metric: 'Fehlerrate', value: '-80%' },
        { metric: 'Produktivität', value: '+35%' },
        { metric: 'Kundenzufriedenheit', value: '+25%' }
      ],
      testimonial: {
        quote: 'Die Digitalisierung hat uns einen entscheidenden Wettbewerbsvorteil verschafft.',
        author: 'Thomas Müller',
        position: 'Geschäftsführer, MaschinenbauPlus AG'
      }
    }
  },
  {
    id: 3,
    name: 'Große Unternehmen & Konzerne',
    range: '500+ Mitarbeiter',
    description: 'Enterprise-Lösungen für komplexe Organisationen mit höchsten Sicherheits- und Compliance-Anforderungen.',
    focus: [
      'Enterprise Architecture',
      'Governance & Compliance',
      'Skalierbarkeit',
      'Change Leadership'
    ],
    approaches: [
      'Multi-Cloud Strategien',
      'Agile Transformation',
      'Center of Excellence',
      'Global Rollout Strategien'
    ],
    stats: {
      projects: '12+',
      avgImprovement: '+38%',
      timeToValue: '3-9 Mon.',
      satisfaction: '95%'
    },
    duration: '6-18 Monate',
    caseStudy: {
      title: 'Konzern optimiert globale Supply Chain',
      challenge: 'Internationaler Konzern mit fragmentierten Prozessen und mangelnder Transparenz.',
      solution: 'Globale Prozessstandardisierung mit einheitlicher Plattform und Real-time Analytics.',
      results: [
        { metric: 'Transparenz', value: '+90%' },
        { metric: 'Lagerkosten', value: '-22%' },
        { metric: 'Lieferzeit', value: '-30%' },
        { metric: 'Effizienz', value: '+28%' }
      ],
      testimonial: {
        quote: 'Erstmals haben wir vollständige Transparenz über unsere globalen Prozesse.',
        author: 'Dr. Sarah Klein',
        position: 'Chief Operations Officer, Global Corp'
      }
    }
  }
])

// Methods
const openCaseStudy = (caseStudy) => {
  selectedCaseStudy.value = caseStudy
}

const closeCaseStudy = () => {
  selectedCaseStudy.value = null
}
</script>