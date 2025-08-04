<template>
  <div>
    <!-- Hero Section -->
    <section class="gradient-bg hero-pattern relative overflow-hidden">
      <div class="container-custom py-24">
        <div class="max-w-4xl mx-auto text-center text-white">
          <h1 class="text-4xl md:text-6xl font-bold mb-6">
            Strategische <span class="text-success-400">Beratung</span>
          </h1>
          <p class="text-xl mb-8 text-blue-100 leading-relaxed">
            Maßgeschneiderte Beratung für Ihre digitale Transformation. Wir entwickeln 
            mit Ihnen die optimale Strategie für nachhaltige Prozessverbesserungen.
          </p>
          <div class="flex flex-col sm:flex-row gap-4 justify-center">
            <NuxtLink to="/kontakt" class="btn bg-success-600 text-white hover:bg-success-700 text-lg px-8 py-4">
              Kostenlose Erstberatung
            </NuxtLink>
            <button @click="scrollToApproach" class="btn-secondary bg-white/10 border-white/30 text-white hover:bg-white/20">
              Unser Ansatz kennenlernen
            </button>
          </div>
        </div>
      </div>
    </section>

    <!-- Why Consulting -->
    <section class="section-padding">
      <div class="container-custom">
        <div class="text-center mb-16">
          <h2 class="text-3xl md:text-4xl font-bold mb-6">
            Warum strategische <span class="gradient-text">Beratung</span> entscheidend ist
          </h2>
          <p class="text-xl text-neutral-600 max-w-3xl mx-auto">
            Erfolgreiche Digitalisierung beginnt mit der richtigen Strategie. 
            Wir helfen Ihnen, die komplexen Herausforderungen zu durchdringen.
          </p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          <div class="text-center">
            <div class="w-16 h-16 bg-red-100 rounded-full flex items-center justify-center mx-auto mb-6">
              <ExclamationTriangleIcon class="w-8 h-8 text-red-600" />
            </div>
            <h3 class="text-xl font-semibold mb-4">Komplexe Entscheidungen</h3>
            <p class="text-neutral-600 leading-relaxed">
              Digitale Transformation bringt viele schwierige Entscheidungen mit sich. 
              Welche Technologien? Welche Reihenfolge? Welche Prioritäten?
            </p>
          </div>

          <div class="text-center">
            <div class="w-16 h-16 bg-orange-100 rounded-full flex items-center justify-center mx-auto mb-6">
              <CurrencyEuroIcon class="w-8 h-8 text-orange-600" />
            </div>
            <h3 class="text-xl font-semibold mb-4">Hohe Investitionen</h3>
            <p class="text-neutral-600 leading-relaxed">
              Falsche Entscheidungen können teuer werden. Professionelle Beratung 
              hilft, Fehlinvestitionen zu vermeiden und ROI zu maximieren.
            </p>
          </div>

          <div class="text-center">
            <div class="w-16 h-16 bg-yellow-100 rounded-full flex items-center justify-center mx-auto mb-6">
              <ClockIcon class="w-8 h-8 text-yellow-600" />
            </div>
            <h3 class="text-xl font-semibold mb-4">Zeitdruck</h3>
            <p class="text-neutral-600 leading-relaxed">
              Der Wettbewerb schläft nicht. Eine durchdachte Strategie beschleunigt 
              die Umsetzung und verkürzt die Time-to-Market.
            </p>
          </div>
        </div>
      </div>
    </section>

    <!-- Our Approach -->
    <section id="approach" class="section-padding bg-neutral-50">
      <div class="container-custom">
        <div class="text-center mb-16">
          <h2 class="text-3xl md:text-4xl font-bold mb-6">
            Unser <span class="gradient-text">Beratungsansatz</span>
          </h2>
          <p class="text-xl text-neutral-600 max-w-3xl mx-auto">
            Strategisch, pragmatisch und immer mit Blick auf den messbaren Nutzen.
          </p>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-2 gap-16 items-center">
          <div>
            <div class="space-y-8">
              <div class="flex items-start space-x-4">
                <div class="w-12 h-12 bg-primary-100 rounded-lg flex items-center justify-center flex-shrink-0">
                  <MagnifyingGlassIcon class="w-6 h-6 text-primary-600" />
                </div>
                <div>
                  <h3 class="text-xl font-semibold mb-2">Tiefgehende Analyse</h3>
                  <p class="text-neutral-600 leading-relaxed">
                    Wir verstehen Ihr Geschäftsmodell, Ihre Prozesse und Ihre Ziele. 
                    Nur so können wir passgenaue Empfehlungen entwickeln.
                  </p>
                </div>
              </div>

              <div class="flex items-start space-x-4">
                <div class="w-12 h-12 bg-success-100 rounded-lg flex items-center justify-center flex-shrink-0">
                  <LightBulbIcon class="w-6 h-6 text-success-600" />
                </div>
                <div>
                  <h3 class="text-xl font-semibold mb-2">Innovative Lösungen</h3>
                  <p class="text-neutral-600 leading-relaxed">
                    Wir bringen bewährte Best Practices mit innovativen Ansätzen zusammen 
                    und entwickeln maßgeschneiderte Strategien.
                  </p>
                </div>
              </div>

              <div class="flex items-start space-x-4">
                <div class="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center flex-shrink-0">
                  <ChartBarIcon class="w-6 h-6 text-blue-600" />
                </div>
                <div>
                  <h3 class="text-xl font-semibold mb-2">Messbare Ergebnisse</h3>
                  <p class="text-neutral-600 leading-relaxed">
                    Jede Empfehlung wird durch konkrete KPIs und ROI-Prognosen untermauert. 
                    Sie wissen genau, was Sie erwartet.
                  </p>
                </div>
              </div>

              <div class="flex items-start space-x-4">
                <div class="w-12 h-12 bg-purple-100 rounded-lg flex items-center justify-center flex-shrink-0">
                  <UserGroupIcon class="w-6 h-6 text-purple-600" />
                </div>
                <div>
                  <h3 class="text-xl font-semibold mb-2">Begleitung bei der Umsetzung</h3>
                  <p class="text-neutral-600 leading-relaxed">
                    Wir lassen Sie nicht mit der Strategie allein. Auf Wunsch begleiten 
                    wir Sie bei der kompletten Implementierung.
                  </p>
                </div>
              </div>
            </div>
          </div>

          <div class="bg-white rounded-2xl p-8 shadow-xl">
            <h3 class="text-2xl font-bold mb-6 text-center">Unser Beratungsprozess</h3>
            <div class="space-y-4">
              <div class="flex items-center space-x-4 p-4 bg-primary-50 rounded-lg">
                <div class="w-8 h-8 bg-primary-600 text-white rounded-full flex items-center justify-center font-bold text-sm">
                  1
                </div>
                <div>
                  <div class="font-semibold">Ist-Analyse</div>
                  <div class="text-sm text-neutral-600">Umfassende Bestandsaufnahme</div>
                </div>
              </div>

              <div class="flex items-center space-x-4 p-4 bg-success-50 rounded-lg">
                <div class="w-8 h-8 bg-success-600 text-white rounded-full flex items-center justify-center font-bold text-sm">
                  2
                </div>
                <div>
                  <div class="font-semibold">Zieldefinition</div>
                  <div class="text-sm text-neutral-600">Klare Ziele und KPIs festlegen</div>
                </div>
              </div>

              <div class="flex items-center space-x-4 p-4 bg-blue-50 rounded-lg">
                <div class="w-8 h-8 bg-blue-600 text-white rounded-full flex items-center justify-center font-bold text-sm">
                  3
                </div>
                <div>
                  <div class="font-semibold">Strategieentwicklung</div>
                  <div class="text-sm text-neutral-600">Maßgeschneiderte Lösungsansätze</div>
                </div>
              </div>

              <div class="flex items-center space-x-4 p-4 bg-purple-50 rounded-lg">
                <div class="w-8 h-8 bg-purple-600 text-white rounded-full flex items-center justify-center font-bold text-sm">
                  4
                </div>
                <div>
                  <div class="font-semibold">Roadmap</div>
                  <div class="text-sm text-neutral-600">Priorisierung und Zeitplanung</div>
                </div>
              </div>

              <div class="flex items-center space-x-4 p-4 bg-orange-50 rounded-lg">
                <div class="w-8 h-8 bg-orange-600 text-white rounded-full flex items-center justify-center font-bold text-sm">
                  5
                </div>
                <div>
                  <div class="font-semibold">Umsetzungsbegleitung</div>
                  <div class="text-sm text-neutral-600">Kontinuierliche Unterstützung</div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Consulting Services -->
    <section class="section-padding">
      <div class="container-custom">
        <div class="text-center mb-16">
          <h2 class="text-3xl md:text-4xl font-bold mb-6">
            Unsere <span class="gradient-text">Beratungsleistungen</span>
          </h2>
          <p class="text-xl text-neutral-600 max-w-3xl mx-auto">
            Von der strategischen Beratung bis zur operativen Umsetzung.
          </p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-12">
          <div
            v-for="service in consultingServices"
            :key="service.id"
            class="card card-hover"
          >
            <div class="flex items-start space-x-4 mb-6">
              <div class="p-3 rounded-lg flex-shrink-0" :class="service.iconBg">
                <component :is="service.icon" class="w-8 h-8" :class="service.iconColor" />
              </div>
              <div>
                <h3 class="text-xl font-semibold mb-2">{{ service.title }}</h3>
                <p class="text-neutral-600 leading-relaxed">{{ service.description }}</p>
              </div>
            </div>

            <div class="space-y-3">
              <h4 class="font-semibold text-sm text-neutral-700 uppercase tracking-wide">
                Typische Themen:
              </h4>
              <ul class="space-y-2">
                <li
                  v-for="topic in service.topics"
                  :key="topic"
                  class="flex items-start space-x-2 text-sm text-neutral-600"
                >
                  <CheckIcon class="w-4 h-4 text-success-500 mt-0.5 flex-shrink-0" />
                  <span>{{ topic }}</span>
                </li>
              </ul>
            </div>

            <div class="mt-6 pt-6 border-t border-neutral-100">
              <div class="flex items-center justify-between">
                <span class="text-sm text-neutral-500">{{ service.duration }}</span>
                <NuxtLink to="/kontakt" class="text-primary-600 hover:text-primary-800 font-medium text-sm transition-colors">
                  Beratung anfragen →
                </NuxtLink>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Industries -->
    <section class="section-padding bg-neutral-50">
      <div class="container-custom">
        <div class="text-center mb-16">
          <h2 class="text-3xl md:text-4xl font-bold mb-6">
            Branchenspezifische <span class="gradient-text">Expertise</span>
          </h2>
          <p class="text-xl text-neutral-600 max-w-3xl mx-auto">
            Wir verstehen die spezifischen Herausforderungen verschiedener Branchen.
          </p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
          <div class="card text-center">
            <div class="w-16 h-16 bg-blue-100 rounded-full flex items-center justify-center mx-auto mb-6">
              <BuildingOfficeIcon class="w-8 h-8 text-blue-600" />
            </div>
            <h3 class="text-xl font-semibold mb-4">Produktion & Fertigung</h3>
            <div class="text-left space-y-2 text-sm text-neutral-600">
              <div>• Lean Production & Industry 4.0</div>
              <div>• Supply Chain Optimization</div>
              <div>• Predictive Maintenance</div>
              <div>• Quality Management</div>
              <div>• Digitale Zwillinge</div>
            </div>
          </div>

          <div class="card text-center">
            <div class="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-6">
              <ShoppingCartIcon class="w-8 h-8 text-green-600" />
            </div>
            <h3 class="text-xl font-semibold mb-4">Handel & E-Commerce</h3>
            <div class="text-left space-y-2 text-sm text-neutral-600">
              <div>• Omnichannel-Strategien</div>
              <div>• Customer Journey Optimization</div>
              <div>• Inventory Management</div>
              <div>• Personalisierung & AI</div>
              <div>• Mobile Commerce</div>
            </div>
          </div>

          <div class="card text-center">
            <div class="w-16 h-16 bg-purple-100 rounded-full flex items-center justify-center mx-auto mb-6">
              <UserGroupIcon class="w-8 h-8 text-purple-600" />
            </div>
            <h3 class="text-xl font-semibold mb-4">Dienstleistung</h3>
            <div class="text-left space-y-2 text-sm text-neutral-600">
              <div>• Service Excellence</div>
              <div>• Digital Customer Experience</div>
              <div>• Workflow Automation</div>
              <div>• Resource Planning</div>
              <div>• Performance Analytics</div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Testimonials -->
    <section class="section-padding">
      <div class="container-custom">
        <div class="text-center mb-16">
          <h2 class="text-3xl md:text-4xl font-bold mb-6">
            Was unsere <span class="gradient-text">Beratungskunden</span> sagen
          </h2>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
          <div class="card">
            <div class="flex items-center mb-4">
              <div class="flex text-yellow-400">
                <StarIcon v-for="i in 5" :key="i" class="w-5 h-5 fill-current" />
              </div>
            </div>
            <blockquote class="text-neutral-700 mb-6 leading-relaxed text-lg">
              "Die strategische Beratung von Configuraid war genau das, was wir brauchten. 
              Klare Empfehlungen, realistischer Zeitplan und exzellente Begleitung bei der Umsetzung."
            </blockquote>
            <div class="flex items-center">
              <div class="w-12 h-12 bg-neutral-300 rounded-full mr-4"></div>
              <div>
                <div class="font-semibold">Dr. Michael Hartmann</div>
                <div class="text-sm text-neutral-500">CEO, TechInnovate AG</div>
              </div>
            </div>
          </div>

          <div class="card">
            <div class="flex items-center mb-4">
              <div class="flex text-yellow-400">
                <StarIcon v-for="i in 5" :key="i" class="w-5 h-5 fill-current" />
              </div>
            </div>
            <blockquote class="text-neutral-700 mb-6 leading-relaxed text-lg">
              "Endlich ein Berater, der unsere Branche versteht! Die Empfehlungen waren praxisnah 
              und haben uns dabei geholfen, die Digitalisierung erfolgreich voranzutreiben."
            </blockquote>
            <div class="flex items-center">
              <div class="w-12 h-12 bg-neutral-300 rounded-full mr-4"></div>
              <div>
                <div class="font-semibold">Petra Schneider</div>
                <div class="text-sm text-neutral-500">Geschäftsführerin, LogistikPlus GmbH</div>
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
            Bereit für strategische Beratung?
          </h2>
          <p class="text-xl mb-8 text-blue-100">
            Lassen Sie uns gemeinsam die optimale Strategie für Ihre digitale Transformation entwickeln. 
            Die Erstberatung ist kostenlos und unverbindlich.
          </p>
          <div class="flex flex-col sm:flex-row gap-4 justify-center">
            <NuxtLink to="/kontakt" class="btn bg-success-600 text-white hover:bg-success-700 text-lg px-8 py-4">
              Kostenlose Strategieberatung vereinbaren
            </NuxtLink>
            <NuxtLink to="/referenzen" class="btn-secondary bg-white/10 border-white/30 text-white hover:bg-white/20">
              Beratungserfolge ansehen
            </NuxtLink>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
import {
  ExclamationTriangleIcon,
  CurrencyEuroIcon,
  ClockIcon,
  MagnifyingGlassIcon,
  LightBulbIcon,
  ChartBarIcon,
  UserGroupIcon,
  CheckIcon,
  BuildingOfficeIcon,
  ShoppingCartIcon,
  RocketLaunchIcon,
  CogIcon,
  DocumentTextIcon,
  AcademicCapIcon,
  StarIcon
} from '@heroicons/vue/24/outline'

// SEO
useHead({
  title: 'Strategische Beratung - Digitale Transformation | Configuraid',
  meta: [
    { name: 'description', content: 'Strategische Beratung für digitale Transformation. Maßgeschneiderte Strategien, messbare Ergebnisse, branchenspezifische Expertise. Kostenlose Erstberatung.' }
  ]
})

// Consulting Services
const consultingServices = ref([
  {
    id: 1,
    title: 'Digitalisierungsstrategie',
    description: 'Entwicklung einer umfassenden Strategie für die digitale Transformation Ihres Unternehmens.',
    icon: RocketLaunchIcon,
    iconBg: 'bg-blue-100',
    iconColor: 'text-blue-600',
    duration: '4-8 Wochen',
    topics: [
      'Digital Readiness Assessment',
      'Technologie-Roadmap Entwicklung',
      'Change Management Strategie',
      'ROI-Planung und Business Case',
      'Risikobewertung und Mitigation'
    ]
  },
  {
    id: 2,
    title: 'Prozessanalyse & -design',
    description: 'Tiefgehende Analyse bestehender Prozesse und Entwicklung optimierter Workflows.',
    icon: CogIcon,
    iconBg: 'bg-green-100',
    iconColor: 'text-green-600',
    duration: '3-6 Wochen',
    topics: [
      'End-to-End Prozessanalyse',
      'Bottleneck-Identifikation',
      'Prozess-Redesign',
      'KPI-Definition und Monitoring',
      'Continuous Improvement Setup'
    ]
  },
  {
    id: 3,
    title: 'Technologie-Beratung',
    description: 'Auswahl der richtigen Technologien und Tools für Ihre spezifischen Anforderungen.',
    icon: DocumentTextIcon,
    iconBg: 'bg-purple-100',
    iconColor: 'text-purple-600',
    duration: '2-4 Wochen',
    topics: [
      'Technology Stack Evaluation',
      'Vendor Selection & Assessment',
      'Integration Architecture',
      'Security & Compliance Review',
      'Total Cost of Ownership (TCO)'
    ]
  },
  {
    id: 4,
    title: 'Organisationsentwicklung',
    description: 'Begleitung bei der organisatorischen Transformation und Kompetenzentwicklung.',
    icon: AcademicCapIcon,
    iconBg: 'bg-orange-100',
    iconColor: 'text-orange-600',
    duration: '6-12 Wochen',
    topics: [
      'Organisationsdesign',
      'Skill Gap Analyse',
      'Schulungskonzepte',
      'Change Management',
      'Führungskräfteentwicklung'
    ]
  }
])

// Scroll to approach section
const scrollToApproach = () => {
  document.getElementById('approach').scrollIntoView({ 
    behavior: 'smooth' 
  })
}
</script>