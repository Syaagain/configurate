<template>
  <div>
    <!-- Hero Section -->
    <section class="gradient-bg hero-pattern relative overflow-hidden">
      <div class="container-custom py-24">
        <div class="max-w-4xl mx-auto text-center text-white">
          <h1 class="text-4xl md:text-6xl font-bold mb-6">
            Process <span class="text-success-400">Automatisierung</span>
          </h1>
          <p class="text-xl mb-8 text-blue-100 leading-relaxed">
            Verwandeln Sie repetitive Aufgaben in intelligente, selbstlaufende Systeme. 
            24/7 Effizienz ohne menschliche Eingriffe – das ist die Kraft der Automatisierung.
          </p>
          <div class="flex flex-col sm:flex-row gap-4 justify-center">
            <NuxtLink to="/kontakt" class="btn bg-success-600 text-white hover:bg-success-700 text-lg px-8 py-4">
              Automatisierungspotential analysieren
            </NuxtLink>
            <button @click="scrollToROI" class="btn-secondary bg-white/10 border-white/30 text-white hover:bg-white/20">
              ROI-Rechner nutzen
            </button>
          </div>
        </div>
      </div>
    </section>

    <!-- Pain Points -->
    <section class="section-padding">
      <div class="container-custom">
        <div class="text-center mb-16">
          <h2 class="text-3xl md:text-4xl font-bold mb-6">
            Schluss mit <span class="text-red-600">manueller Arbeit</span>
          </h2>
          <p class="text-xl text-neutral-600 max-w-3xl mx-auto">
            Repetitive Aufgaben rauben Ihrem Team wertvolle Zeit für strategische Arbeit.
          </p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
          <div class="text-center">
            <div class="w-16 h-16 bg-red-100 rounded-full flex items-center justify-center mx-auto mb-4">
              <ClockIcon class="w-8 h-8 text-red-600" />
            </div>
            <h3 class="text-lg font-semibold mb-2 text-red-700">Zeitverschwendung</h3>
            <p class="text-neutral-600 text-sm">
              Bis zu 60% der Arbeitszeit wird für repetitive, manuelle Aufgaben verschwendet
            </p>
          </div>

          <div class="text-center">
            <div class="w-16 h-16 bg-orange-100 rounded-full flex items-center justify-center mx-auto mb-4">
              <ExclamationTriangleIcon class="w-8 h-8 text-orange-600" />
            </div>
            <h3 class="text-lg font-semibold mb-2 text-orange-700">Fehleranfälligkeit</h3>
            <p class="text-neutral-600 text-sm">
              Manuelle Prozesse führen zu 15-25% mehr Fehlern als automatisierte Systeme
            </p>
          </div>

          <div class="text-center">
            <div class="w-16 h-16 bg-yellow-100 rounded-full flex items-center justify-center mx-auto mb-4">
              <UserIcon class="w-8 h-8 text-yellow-600" />
            </div>
            <h3 class="text-lg font-semibold mb-2 text-yellow-700">Mitarbeiter-Frust</h3>
            <p class="text-neutral-600 text-sm">
              Monotone Aufgaben demotivieren und führen zu höherer Fluktuation
            </p>
          </div>

          <div class="text-center">
            <div class="w-16 h-16 bg-red-100 rounded-full flex items-center justify-center mx-auto mb-4">
              <CurrencyEuroIcon class="w-8 h-8 text-red-600" />
            </div>
            <h3 class="text-lg font-semibold mb-2 text-red-700">Hohe Kosten</h3>
            <p class="text-neutral-600 text-sm">
              Manuelle Prozesse verursachen 3-5x höhere Betriebskosten als automatisierte
            </p>
          </div>
        </div>
      </div>
    </section>

    <!-- Benefits Section -->
    <section class="section-padding bg-neutral-50">
      <div class="container-custom">
        <div class="text-center mb-16">
          <h2 class="text-3xl md:text-4xl font-bold mb-6">
            Die Kraft der <span class="gradient-text">Automatisierung</span>
          </h2>
          <p class="text-xl text-neutral-600 max-w-3xl mx-auto">
            Intelligente Automatisierung verwandelt Ihr Unternehmen in eine effiziente, 
            selbstoptimierende Organisation.
          </p>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-2 gap-16 items-center">
          <div>
            <div class="space-y-8">
              <div class="flex items-start space-x-4">
                <div class="w-12 h-12 bg-success-100 rounded-lg flex items-center justify-center flex-shrink-0">
                  <RocketLaunchIcon class="w-6 h-6 text-success-600" />
                </div>
                <div>
                  <h3 class="text-xl font-semibold mb-2">Geschwindigkeit</h3>
                  <p class="text-neutral-600 leading-relaxed">
                    Automatisierte Prozesse laufen 10-100x schneller als manuelle Abläufe 
                    und arbeiten rund um die Uhr ohne Pausen.
                  </p>
                </div>
              </div>

              <div class="flex items-start space-x-4">
                <div class="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center flex-shrink-0">
                  <ShieldCheckIcon class="w-6 h-6 text-blue-600" />
                </div>
                <div>
                  <h3 class="text-xl font-semibold mb-2">Zuverlässigkeit</h3>
                  <p class="text-neutral-600 leading-relaxed">
                    Eliminierung menschlicher Fehler und konsistente Ausführung nach 
                    definierten Regeln – jeden Tag, zu jeder Zeit.
                  </p>
                </div>
              </div>

              <div class="flex items-start space-x-4">
                <div class="w-12 h-12 bg-purple-100 rounded-lg flex items-center justify-center flex-shrink-0">
                  <ChartBarIcon class="w-6 h-6 text-purple-600" />
                </div>
                <div>
                  <h3 class="text-xl font-semibold mb-2">Skalierbarkeit</h3>
                  <p class="text-neutral-600 leading-relaxed">
                    Automatisierte Systeme wachsen mit Ihrem Unternehmen mit, 
                    ohne proportional mehr Personal zu benötigen.
                  </p>
                </div>
              </div>

              <div class="flex items-start space-x-4">
                <div class="w-12 h-12 bg-green-100 rounded-lg flex items-center justify-center flex-shrink-0">
                  <CurrencyEuroIcon class="w-6 h-6 text-green-600" />
                </div>
                <div>
                  <h3 class="text-xl font-semibold mb-2">Kosteneinsparung</h3>
                  <p class="text-neutral-600 leading-relaxed">
                    ROI von 300-500% innerhalb des ersten Jahres durch reduzierte 
                    Personalkosten und erhöhte Effizienz.
                  </p>
                </div>
              </div>
            </div>
          </div>

          <div class="bg-white rounded-2xl p-8 shadow-xl">
            <h3 class="text-2xl font-bold mb-6 text-center">Typische Einsparungen</h3>
            <div class="space-y-6">
              <div class="flex items-center justify-between p-4 bg-success-50 rounded-lg">
                <div>
                  <div class="font-semibold text-success-800">Datenverarbeitung</div>
                  <div class="text-sm text-success-600">Von 8 Stunden auf 15 Minuten</div>
                </div>
                <div class="text-2xl font-bold text-success-600">-97%</div>
              </div>

              <div class="flex items-center justify-between p-4 bg-blue-50 rounded-lg">
                <div>
                  <div class="font-semibold text-blue-800">Rechnungsverarbeitung</div>
                  <div class="text-sm text-blue-600">Von 30 Min auf 2 Min pro Rechnung</div>
                </div>
                <div class="text-2xl font-bold text-blue-600">-93%</div>
              </div>

              <div class="flex items-center justify-between p-4 bg-purple-50 rounded-lg">
                <div>
                  <div class="font-semibold text-purple-800">Berichtserstellung</div>
                  <div class="text-sm text-purple-600">Von 4 Stunden auf 5 Minuten</div>
                </div>
                <div class="text-2xl font-bold text-purple-600">-98%</div>
              </div>

              <div class="flex items-center justify-between p-4 bg-orange-50 rounded-lg">
                <div>
                  <div class="font-semibold text-orange-800">E-Mail-Management</div>
                  <div class="text-sm text-orange-600">Vollständig automatisiert</div>
                </div>
                <div class="text-2xl font-bold text-orange-600">-100%</div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Technology Stack -->
    <section class="section-padding">
      <div class="container-custom">
        <div class="text-center mb-16">
          <h2 class="text-3xl md:text-4xl font-bold mb-6">
            Modernste <span class="gradient-text">Technologien</span>
          </h2>
          <p class="text-xl text-neutral-600 max-w-3xl mx-auto">
            Wir setzen auf bewährte und innovative Tools für maximale Automatisierungseffekte.
          </p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          <div class="card">
            <div class="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center mb-4">
              <CogIcon class="w-6 h-6 text-blue-600" />
            </div>
            <h3 class="text-xl font-semibold mb-3">RPA (Robotic Process Automation)</h3>
            <p class="text-neutral-600 mb-4">
              Software-Roboter übernehmen repetitive Aufgaben in bestehenden Systemen 
              ohne Änderungen an der IT-Infrastruktur.
            </p>
            <div class="text-sm text-neutral-500">
              Tools: UiPath, Automation Anywhere, Blue Prism
            </div>
          </div>

          <div class="card">
            <div class="w-12 h-12 bg-green-100 rounded-lg flex items-center justify-center mb-4">
              <LinkIcon class="w-6 h-6 text-green-600" />
            </div>
            <h3 class="text-xl font-semibold mb-3">API-Integration</h3>
            <p class="text-neutral-600 mb-4">
              Nahtlose Verbindung verschiedener Systeme für automatischen Datenaustausch 
              und synchronisierte Workflows.
            </p>
            <div class="text-sm text-neutral-500">
              Tools: Zapier, Microsoft Power Automate, Custom APIs
            </div>
          </div>

          <div class="card">
            <div class="w-12 h-12 bg-purple-100 rounded-lg flex items-center justify-center mb-4">
              <BoltIcon class="w-6 h-6 text-purple-600" />
            </div>
            <h3 class="text-xl font-semibold mb-3">Workflow-Engines</h3>
            <p class="text-neutral-600 mb-4">
              Intelligente Steuerung komplexer Geschäftsprozesse mit Entscheidungslogik 
              und dynamischen Workflows.
            </p>
            <div class="text-sm text-neutral-500">
              Tools: Microsoft Power Platform, Nintex, Custom Solutions
            </div>
          </div>

          <div class="card">
            <div class="w-12 h-12 bg-red-100 rounded-lg flex items-center justify-center mb-4">
              <DocumentTextIcon class="w-6 h-6 text-red-600" />
            </div>
            <h3 class="text-xl font-semibold mb-3">Document Processing</h3>
            <p class="text-neutral-600 mb-4">
              KI-gestützte Dokumentenerkennung und -verarbeitung für automatische 
              Datenextraktion aus Rechnungen, Verträgen und Formularen.
            </p>
            <div class="text-sm text-neutral-500">
              Tools: OCR, NLP, Azure AI, AWS Textract
            </div>
          </div>

          <div class="card">
            <div class="w-12 h-12 bg-yellow-100 rounded-lg flex items-center justify-center mb-4">
              <EnvelopeIcon class="w-6 h-6 text-yellow-600" />
            </div>
            <h3 class="text-xl font-semibold mb-3">E-Mail-Automatisierung</h3>
            <p class="text-neutral-600 mb-4">
              Intelligente E-Mail-Verarbeitung mit automatischer Kategorisierung, 
              Weiterleitung und Antwortgenerierung.
            </p>
            <div class="text-sm text-neutral-500">
              Tools: Microsoft Exchange, Gmail API, Custom Solutions
            </div>
          </div>

          <div class="card">
            <div class="w-12 h-12 bg-indigo-100 rounded-lg flex items-center justify-center mb-4">
              <ChartBarIcon class="w-6 h-6 text-indigo-600" />
            </div>
            <h3 class="text-xl font-semibold mb-3">Business Intelligence</h3>
            <p class="text-neutral-600 mb-4">
              Automatische Berichtserstellung und Datenanalyse mit Echtzeit-Dashboard 
              und proaktiven Benachrichtigungen.
            </p>
            <div class="text-sm text-neutral-500">
              Tools: Power BI, Tableau, Custom Dashboards
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- ROI Calculator -->
    <section id="roi-calculator" class="section-padding bg-neutral-50">
      <div class="container-custom">
        <div class="text-center mb-16">
          <h2 class="text-3xl md:text-4xl font-bold mb-6">
            ROI-<span class="gradient-text">Rechner</span>
          </h2>
          <p class="text-xl text-neutral-600 max-w-3xl mx-auto">
            Berechnen Sie das Einsparpotential durch Automatisierung in Ihrem Unternehmen.
          </p>
        </div>

        <div class="max-w-4xl mx-auto">
          <div class="grid grid-cols-1 lg:grid-cols-2 gap-12">
            <!-- Input Section -->
            <div class="card">
              <h3 class="text-xl font-semibold mb-6">Ihre Daten eingeben</h3>
              
              <div class="space-y-6">
                <div>
                  <label class="block text-sm font-medium text-neutral-700 mb-2">
                    Anzahl Mitarbeiter mit repetitiven Aufgaben
                  </label>
                  <input
                    type="number"
                    v-model="roiData.employees"
                    @input="calculateROI"
                    class="w-full px-4 py-3 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500"
                    placeholder="z.B. 10"
                  >
                </div>

                <div>
                  <label class="block text-sm font-medium text-neutral-700 mb-2">
                    Stunden pro Tag für repetitive Aufgaben (pro Mitarbeiter)
                  </label>
                  <input
                    type="number"
                    v-model="roiData.hoursPerDay"
                    @input="calculateROI"
                    step="0.5"
                    class="w-full px-4 py-3 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500"
                    placeholder="z.B. 4"
                  >
                </div>

                <div>
                  <label class="block text-sm font-medium text-neutral-700 mb-2">
                    Durchschnittlicher Stundenlohn (€)
                  </label>
                  <input
                    type="number"
                    v-model="roiData.hourlyRate"
                    @input="calculateROI"
                    class="w-full px-4 py-3 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500"
                    placeholder="z.B. 35"
                  >
                </div>

                <div>
                  <label class="block text-sm font-medium text-neutral-700 mb-2">
                    Automatisierungsgrad (%)
                  </label>
                  <input
                    type="range"
                    v-model="roiData.automationRate"
                    @input="calculateROI"
                    min="10"
                    max="95"
                    class="w-full"
                  >
                  <div class="text-center text-sm text-neutral-600 mt-1">
                    {{ roiData.automationRate }}% der Aufgaben automatisierbar
                  </div>
                </div>
              </div>
            </div>

            <!-- Results Section -->
            <div class="card bg-primary-50 border-primary-100">
              <h3 class="text-xl font-semibold mb-6 text-primary-900">Ihr Einsparpotential</h3>
              
              <div class="space-y-4">
                <div class="bg-white rounded-lg p-4">
                  <div class="text-sm text-neutral-600 mb-1">Jährliche Personalkosten (aktuell)</div>
                  <div class="text-2xl font-bold text-neutral-900">
                    {{ formatCurrency(roiResults.currentCosts) }}
                  </div>
                </div>

                <div class="bg-white rounded-lg p-4">
                  <div class="text-sm text-success-600 mb-1">Jährliche Einsparung</div>
                  <div class="text-2xl font-bold text-success-600">
                    {{ formatCurrency(roiResults.savings) }}
                  </div>
                </div>

                <div class="bg-white rounded-lg p-4">
                  <div class="text-sm text-primary-600 mb-1">ROI nach 12 Monaten</div>
                  <div class="text-3xl font-bold text-primary-600">
                    {{ roiResults.roi }}%
                  </div>
                </div>

                <div class="bg-white rounded-lg p-4">
                  <div class="text-sm text-neutral-600 mb-1">Gesparte Stunden pro Jahr</div>
                  <div class="text-xl font-bold text-neutral-900">
                    {{ roiResults.savedHours.toLocaleString() }} h
                  </div>
                </div>
              </div>

              <div class="mt-6 pt-6 border-t border-primary-200">
                <p class="text-sm text-primary-700 mb-4">
                  * Schätzung basierend auf durchschnittlichen Projekterfahrungen. 
                  Individuelle Ergebnisse können variieren.
                </p>
                <NuxtLink to="/kontakt" class="btn-primary w-full">
                  Kostenlose Detailanalyse anfragen
                </NuxtLink>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Use Cases -->
    <section class="section-padding">
      <div class="container-custom">
        <div class="text-center mb-16">
          <h2 class="text-3xl md:text-4xl font-bold mb-6">
            Typische <span class="gradient-text">Anwendungsfälle</span>
          </h2>
          <p class="text-xl text-neutral-600 max-w-3xl mx-auto">
            Diese Prozesse lassen sich besonders effektiv automatisieren
          </p>
        </div>

        <div class="space-y-8">
          <div v-for="useCase in useCases" :key="useCase.id" class="card">
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-8 items-center">
              <div>
                <div class="flex items-center mb-4">
                  <div class="w-12 h-12 rounded-lg flex items-center justify-center mr-4" :class="useCase.iconBg">
                    <component :is="useCase.icon" class="w-6 h-6" :class="useCase.iconColor" />
                  </div>
                  <h3 class="text-xl font-semibold">{{ useCase.title }}</h3>
                </div>
                <p class="text-neutral-600">{{ useCase.description }}</p>
              </div>
              
              <div class="lg:col-span-2">
                <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                  <div class="text-center">
                    <div class="text-2xl font-bold text-red-600 mb-1">{{ useCase.before.time }}</div>
                    <div class="text-sm text-neutral-600">Vorher</div>
                  </div>
                  <div class="flex items-center justify-center">
                    <ArrowRightIcon class="w-8 h-8 text-success-600" />
                  </div>
                  <div class="text-center">
                    <div class="text-2xl font-bold text-success-600 mb-1">{{ useCase.after.time }}</div>
                    <div class="text-sm text-neutral-600">Nachher</div>
                  </div>
                </div>
                <div class="mt-4 text-center">
                  <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-success-100 text-success-800">
                    {{ useCase.improvement }} Zeitersparnis
                  </span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- CTA Section -->
    <section class="section-padding gradient-bg hero-pattern">
      <div class="container-custom text-center">
        <div class="max-w-4xl mx-auto text-white">
          <h2 class="text-3xl md:text-5xl font-bold mb-6">
            Starten Sie Ihre Automatisierung
          </h2>
          <p class="text-xl mb-8 text-blue-100">
            Lassen Sie uns gemeinsam identifizieren, welche Prozesse in Ihrem Unternehmen 
            automatisiert werden können. Die Erstanalyse ist kostenlos.
          </p>
          <div class="flex flex-col sm:flex-row gap-4 justify-center">
            <NuxtLink to="/kontakt" class="btn bg-success-600 text-white hover:bg-success-700 text-lg px-8 py-4">
              Kostenlose Automatisierungsanalyse
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
import { ref, reactive, computed } from 'vue'
import {
  ClockIcon,
  ExclamationTriangleIcon,
  UserIcon,
  CurrencyEuroIcon,
  RocketLaunchIcon,
  ShieldCheckIcon,
  ChartBarIcon,
  CogIcon,
  LinkIcon,
  BoltIcon,
  DocumentTextIcon,
  EnvelopeIcon,
  ArrowRightIcon
} from '@heroicons/vue/24/outline'

// SEO
useHead({
  title: 'Automatisierung - Intelligente Prozess-Automatisierung | Configuraid',
  meta: [
    { name: 'description', content: 'Professionelle Prozess-Automatisierung für maximale Effizienz. ROI von 300-500% im ersten Jahr. Kostenlose Automatisierungsanalyse.' }
  ]
})

// ROI Calculator
const roiData = reactive({
  employees: 10,
  hoursPerDay: 4,
  hourlyRate: 35,
  automationRate: 70
})

const roiResults = computed(() => {
  const workingDaysPerYear = 250
  const totalHoursPerYear = roiData.employees * roiData.hoursPerDay * workingDaysPerYear
  const currentCosts = totalHoursPerYear * roiData.hourlyRate
  const automatedHours = totalHoursPerYear * (roiData.automationRate / 100)
  const savings = automatedHours * roiData.hourlyRate
  const implementationCost = 50000 // Estimated implementation cost
  const roi = ((savings - implementationCost) / implementationCost) * 100

  return {
    currentCosts,
    savings,
    roi: Math.round(roi),
    savedHours: automatedHours
  }
})

const calculateROI = () => {
  // Reactive computation handles this automatically
}

const formatCurrency = (amount) => {
  return new Intl.NumberFormat('de-DE', {
    style: 'currency',
    currency: 'EUR',
    minimumFractionDigits: 0,
    maximumFractionDigits: 0
  }).format(amount)
}

// Use Cases
const useCases = ref([
  {
    id: 1,
    title: 'Rechnungsverarbeitung',
    description: 'Automatische Erfassung, Prüfung und Weiterleitung von Eingangsrechnungen',
    icon: DocumentTextIcon,
    iconBg: 'bg-blue-100',
    iconColor: 'text-blue-600',
    before: { time: '30 Min' },
    after: { time: '2 Min' },
    improvement: '93%'
  },
  {
    id: 2,
    title: 'Bestellabwicklung',
    description: 'End-to-End Automatisierung vom Auftrag bis zur Auslieferung',
    icon: CogIcon,
    iconBg: 'bg-green-100',
    iconColor: 'text-green-600',
    before: { time: '2 Stunden' },
    after: { time: '15 Min' },
    improvement: '87%'
  },
  {
    id: 3,
    title: 'Datenmigration',
    description: 'Automatischer Transfer und Synchronisation zwischen verschiedenen Systemen',
    icon: LinkIcon,
    iconBg: 'bg-purple-100',
    iconColor: 'text-purple-600',
    before: { time: '8 Stunden' },
    after: { time: '30 Min' },
    improvement: '94%'
  },
  {
    id: 4,
    title: 'E-Mail-Management',
    description: 'Intelligente Kategorisierung und automatische Bearbeitung von E-Mails',
    icon: EnvelopeIcon,
    iconBg: 'bg-yellow-100',
    iconColor: 'text-yellow-600',
    before: { time: '3 Stunden' },
    after: { time: '10 Min' },
    improvement: '94%'
  }
])

// Scroll to ROI calculator
const scrollToROI = () => {
  document.getElementById('roi-calculator').scrollIntoView({ 
    behavior: 'smooth' 
  })
}
</script>