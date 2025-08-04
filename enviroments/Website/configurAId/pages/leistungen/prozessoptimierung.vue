<template>
  <div>
    <!-- Hero Section -->
    <section class="gradient-bg hero-pattern relative overflow-hidden">
      <div class="container-custom py-24">
        <div class="max-w-4xl mx-auto text-center text-white">
          <h1 class="text-4xl md:text-6xl font-bold mb-6">
            Prozess<span class="text-success-400">optimierung</span>
          </h1>
          <p class="text-xl mb-8 text-blue-100 leading-relaxed">
            Verwandeln Sie ineffiziente Workflows in Ihre größten Wettbewerbsvorteile. 
            Wir analysieren, optimieren und implementieren – für messbare Ergebnisse.
          </p>
          <div class="flex flex-col sm:flex-row gap-4 justify-center">
            <NuxtLink to="/kontakt" class="btn bg-success-600 text-white hover:bg-success-700 text-lg px-8 py-4">
              Kostenlose Prozessanalyse
            </NuxtLink>
            <button @click="scrollToMethod" class="btn-secondary bg-white/10 border-white/30 text-white hover:bg-white/20">
              Methodik kennenlernen
            </button>
          </div>
        </div>
      </div>
    </section>

    <!-- Benefits Section -->
    <section class="section-padding">
      <div class="container-custom">
        <div class="text-center mb-16">
          <h2 class="text-3xl md:text-4xl font-bold mb-6">
            Warum <span class="gradient-text">Prozessoptimierung</span> so wichtig ist
          </h2>
          <p class="text-xl text-neutral-600 max-w-3xl mx-auto">
            Ineffiziente Prozesse sind versteckte Kostentreiber, die Ihr Unternehmen täglich Geld kosten.
          </p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
          <div class="text-center fade-in-up stagger-animation">
            <div class="w-16 h-16 bg-red-100 rounded-full flex items-center justify-center mx-auto mb-6">
              <ClockIcon class="w-8 h-8 text-red-600" />
            </div>
            <h3 class="text-xl font-semibold mb-4">Zeitverschwendung</h3>
            <p class="text-neutral-600">
              Manuelle Prozesse verlangsamen Ihr Team und führen zu unnötigen Wartezeiten und Verzögerungen.
            </p>
          </div>

          <div class="text-center fade-in-up stagger-animation">
            <div class="w-16 h-16 bg-orange-100 rounded-full flex items-center justify-center mx-auto mb-6">
              <XCircleIcon class="w-8 h-8 text-orange-600" />
            </div>
            <h3 class="text-xl font-semibold mb-4">Fehleranfälligkeit</h3>
            <p class="text-neutral-600">
              Komplexe manuelle Abläufe sind fehleranfällig und können zu kostspieligen Nacharbeiten führen.
            </p>
          </div>

          <div class="text-center fade-in-up stagger-animation">
            <div class="w-16 h-16 bg-red-100 rounded-full flex items-center justify-center mx-auto mb-6">
              <CurrencyEuroIcon class="w-8 h-8 text-red-600" />
            </div>
            <h3 class="text-xl font-semibel mb-4">Versteckte Kosten</h3>
            <p class="text-neutral-600">
              Ineffiziente Prozesse verursachen höhere Personalkosten und reduzieren die Wettbewerbsfähigkeit.
            </p>
          </div>
        </div>
      </div>
    </section>

    <!-- Methodology Section -->
    <section id="methodology" class="section-padding bg-neutral-50">
      <div class="container-custom">
        <div class="text-center mb-16">
          <h2 class="text-3xl md:text-4xl font-bold mb-6">
            Unsere bewährte <span class="gradient-text">Methodik</span>
          </h2>
          <p class="text-xl text-neutral-600 max-w-3xl mx-auto">
            In 4 strukturierten Phasen führen wir Sie zu optimierten, effizienten Prozessen.
          </p>
        </div>

        <div class="space-y-12">
          <!-- Phase 1 -->
          <div class="flex flex-col lg:flex-row items-center gap-12">
            <div class="lg:w-1/2">
              <div class="flex items-center mb-6">
                <div class="w-12 h-12 bg-primary-900 text-white rounded-full flex items-center justify-center font-bold text-xl mr-4">
                  1
                </div>
                <h3 class="text-2xl font-bold">Analyse & Assessment</h3>
              </div>
              <p class="text-neutral-600 mb-6 text-lg leading-relaxed">
                Wir analysieren Ihre bestehenden Prozesse im Detail und identifizieren Schwachstellen, 
                Engpässe und Optimierungspotentiale. Dabei betrachten wir sowohl technische als auch 
                organisatorische Aspekte.
              </p>
              <ul class="space-y-3">
                <li class="flex items-start space-x-3">
                  <CheckCircleIcon class="w-5 h-5 text-success-600 mt-1 flex-shrink-0" />
                  <span>Ist-Zustand-Analyse aller relevanten Workflows</span>
                </li>
                <li class="flex items-start space-x-3">
                  <CheckCircleIcon class="w-5 h-5 text-success-600 mt-1 flex-shrink-0" />
                  <span>Identifikation von Bottlenecks und Ineffizienzen</span>
                </li>
                <li class="flex items-start space-x-3">
                  <CheckCircleIcon class="w-5 h-5 text-success-600 mt-1 flex-shrink-0" />
                  <span>Stakeholder-Interviews und Prozess-Mapping</span>
                </li>
              </ul>
            </div>
            <div class="lg:w-1/2">
              <div class="bg-white rounded-2xl p-8 shadow-lg border border-neutral-100">
                <div class="grid grid-cols-2 gap-4">
                  <div class="bg-primary-50 rounded-lg p-4 text-center">
                    <div class="text-2xl font-bold text-primary-900">2-3</div>
                    <div class="text-sm text-primary-700">Wochen Analyse</div>
                  </div>
                  <div class="bg-success-50 rounded-lg p-4 text-center">
                    <div class="text-2xl font-bold text-success-700">100%</div>
                    <div class="text-sm text-success-600">Transparenz</div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Phase 2 -->
          <div class="flex flex-col lg:flex-row-reverse items-center gap-12">
            <div class="lg:w-1/2">
              <div class="flex items-center mb-6">
                <div class="w-12 h-12 bg-primary-900 text-white rounded-full flex items-center justify-center font-bold text-xl mr-4">
                  2
                </div>
                <h3 class="text-2xl font-bold">Konzeption & Design</h3>
              </div>
              <p class="text-neutral-600 mb-6 text-lg leading-relaxed">
                Basierend auf den Analyseergebnissen entwickeln wir maßgeschneiderte Lösungskonzepte. 
                Dabei berücksichtigen wir Ihre spezifischen Anforderungen und Unternehmensziele.
              </p>
              <ul class="space-y-3">
                <li class="flex items-start space-x-3">
                  <CheckCircleIcon class="w-5 h-5 text-success-600 mt-1 flex-shrink-0" />
                  <span>Entwicklung optimierter Prozess-Designs</span>
                </li>
                <li class="flex items-start space-x-3">
                  <CheckCircleIcon class="w-5 h-5 text-success-600 mt-1 flex-shrink-0" />
                  <span>ROI-Kalkulation und Kosten-Nutzen-Analyse</span>
                </li>
                <li class="flex items-start space-x-3">
                  <CheckCircleIcon class="w-5 h-5 text-success-600 mt-1 flex-shrink-0" />
                  <span>Roadmap-Erstellung mit Priorisierung</span>
                </li>
              </ul>
            </div>
            <div class="lg:w-1/2">
              <div class="bg-white rounded-2xl p-8 shadow-lg border border-neutral-100">
                <div class="space-y-4">
                  <div class="flex items-center justify-between p-3 bg-neutral-50 rounded-lg">
                    <span class="font-medium">Prozess A</span>
                    <span class="text-success-600 font-bold">+45% Effizienz</span>
                  </div>
                  <div class="flex items-center justify-between p-3 bg-neutral-50 rounded-lg">
                    <span class="font-medium">Prozess B</span>
                    <span class="text-success-600 font-bold">+30% Geschwindigkeit</span>
                  </div>
                  <div class="flex items-center justify-between p-3 bg-neutral-50 rounded-lg">
                    <span class="font-medium">Prozess C</span>
                    <span class="text-success-600 font-bold">-60% Fehler</span>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Phase 3 -->
          <div class="flex flex-col lg:flex-row items-center gap-12">
            <div class="lg:w-1/2">
              <div class="flex items-center mb-6">
                <div class="w-12 h-12 bg-primary-900 text-white rounded-full flex items-center justify-center font-bold text-xl mr-4">
                  3
                </div>
                <h3 class="text-2xl font-bold">Implementierung</h3>
              </div>
              <p class="text-neutral-600 mb-6 text-lg leading-relaxed">
                Wir setzen die optimierten Prozesse schrittweise um und begleiten Ihr Team während 
                der gesamten Implementierungsphase. Change Management inklusive.
              </p>
              <ul class="space-y-3">
                <li class="flex items-start space-x-3">
                  <CheckCircleIcon class="w-5 h-5 text-success-600 mt-1 flex-shrink-0" />
                  <span>Schrittweise Einführung der neuen Prozesse</span>
                </li>
                <li class="flex items-start space-x-3">
                  <CheckCircleIcon class="w-5 h-5 text-success-600 mt-1 flex-shrink-0" />
                  <span>Mitarbeiterschulungen und Change Management</span>
                </li>
                <li class="flex items-start space-x-3">
                  <CheckCircleIcon class="w-5 h-5 text-success-600 mt-1 flex-shrink-0" />
                  <span>Kontinuierliche Betreuung und Anpassungen</span>
                </li>
              </ul>
            </div>
            <div class="lg:w-1/2">
              <div class="bg-white rounded-2xl p-8 shadow-lg border border-neutral-100">
                <div class="space-y-4">
                  <div class="flex items-center space-x-3">
                    <div class="w-8 h-8 bg-success-500 rounded-full flex items-center justify-center">
                      <CheckIcon class="w-4 h-4 text-white" />
                    </div>
                    <span>Phase 1: Pilotprojekt</span>
                  </div>
                  <div class="flex items-center space-x-3">
                    <div class="w-8 h-8 bg-success-500 rounded-full flex items-center justify-center">
                      <CheckIcon class="w-4 h-4 text-white" />
                    </div>
                    <span>Phase 2: Rollout Abteilung A</span>
                  </div>
                  <div class="flex items-center space-x-3">
                    <div class="w-8 h-8 bg-primary-200 rounded-full flex items-center justify-center">
                      <div class="w-3 h-3 bg-primary-600 rounded-full"></div>
                    </div>
                    <span>Phase 3: Vollständiger Rollout</span>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Phase 4 -->
          <div class="flex flex-col lg:flex-row-reverse items-center gap-12">
            <div class="lg:w-1/2">
              <div class="flex items-center mb-6">
                <div class="w-12 h-12 bg-primary-900 text-white rounded-full flex items-center justify-center font-bold text-xl mr-4">
                  4
                </div>
                <h3 class="text-2xl font-bold">Monitoring & Optimierung</h3>
              </div>
              <p class="text-neutral-600 mb-6 text-lg leading-relaxed">
                Nach der Implementierung überwachen wir die Performance der neuen Prozesse und 
                optimieren kontinuierlich für maximale Effizienz.
              </p>
              <ul class="space-y-3">
                <li class="flex items-start space-x-3">
                  <CheckCircleIcon class="w-5 h-5 text-success-600 mt-1 flex-shrink-0" />
                  <span>KPI-Tracking und Performance-Monitoring</span>
                </li>
                <li class="flex items-start space-x-3">
                  <CheckCircleIcon class="w-5 h-5 text-success-600 mt-1 flex-shrink-0" />
                  <span>Regelmäßige Reviews und Anpassungen</span>
                </li>
                <li class="flex items-start space-x-3">
                  <CheckCircleIcon class="w-5 h-5 text-success-600 mt-1 flex-shrink-0" />
                  <span>Kontinuierliche Verbesserung (KVP)</span>
                </li>
              </ul>
            </div>
            <div class="lg:w-1/2">
              <div class="bg-white rounded-2xl p-8 shadow-lg border border-neutral-100">
                <div class="grid grid-cols-2 gap-4">
                  <div class="text-center">
                    <div class="text-3xl font-bold text-success-600 mb-2">40%</div>
                    <div class="text-sm text-neutral-600">Zeitersparnis</div>
                  </div>
                  <div class="text-center">
                    <div class="text-3xl font-bold text-success-600 mb-2">25%</div>
                    <div class="text-sm text-neutral-600">Kostensenkung</div>
                  </div>
                  <div class="text-center">
                    <div class="text-3xl font-bold text-success-600 mb-2">90%</div>
                    <div class="text-sm text-neutral-600">Weniger Fehler</div>
                  </div>
                  <div class="text-center">
                    <div class="text-3xl font-bold text-success-600 mb-2">95%</div>
                    <div class="text-sm text-neutral-600">Mitarbeiterzufriedenheit</div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Industries Section -->
    <section class="section-padding">
      <div class="container-custom">
        <div class="text-center mb-16">
          <h2 class="text-3xl md:text-4xl font-bold mb-6">
            Branchenspezifische <span class="gradient-text">Expertise</span>
          </h2>
          <p class="text-xl text-neutral-600 max-w-3xl mx-auto">
            Wir kennen die spezifischen Herausforderungen verschiedener Branchen und entwickeln passgenaue Lösungen.
          </p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
          <div class="card card-hover">
            <div class="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center mb-4">
              <BuildingOfficeIcon class="w-6 h-6 text-blue-600" />
            </div>
            <h3 class="text-xl font-semibold mb-3">Produktion & Fertigung</h3>
            <p class="text-neutral-600 mb-4">
              Optimierung von Produktionsabläufen, Supply Chain Management und Qualitätssicherung.
            </p>
            <div class="text-sm text-neutral-500">
              Typische Verbesserungen: 30-50% Durchlaufzeitreduktion
            </div>
          </div>

          <div class="card card-hover">
            <div class="w-12 h-12 bg-green-100 rounded-lg flex items-center justify-center mb-4">
              <ShoppingCartIcon class="w-6 h-6 text-green-600" />
            </div>
            <h3 class="text-xl font-semibold mb-3">Handel & E-Commerce</h3>
            <p class="text-neutral-600 mb-4">
              Bestellabwicklung, Lagermanagement und Kundenservice-Prozesse.
            </p>
            <div class="text-sm text-neutral-500">
              Typische Verbesserungen: 40-60% schnellere Bestellabwicklung
            </div>
          </div>

          <div class="card card-hover">
            <div class="w-12 h-12 bg-purple-100 rounded-lg flex items-center justify-center mb-4">
              <UserGroupIcon class="w-6 h-6 text-purple-600" />
            </div>
            <h3 class="text-xl font-semibold mb-3">Dienstleistung</h3>
            <p class="text-neutral-600 mb-4">
              Kundenbetreuung, Projektmanagement und administrative Abläufe.
            </p>
            <div class="text-sm text-neutral-500">
              Typische Verbesserungen: 35-45% Effizienzsteigerung
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
            Starten Sie Ihre Prozessoptimierung
          </h2>
          <p class="text-xl mb-8 text-blue-100">
            Lassen Sie uns gemeinsam das Optimierungspotential in Ihren Prozessen entdecken. 
            Die kostenlose Erstanalyse zeigt Ihnen, wo Sie ansetzen können.
          </p>
          <div class="flex flex-col sm:flex-row gap-4 justify-center">
            <NuxtLink to="/kontakt" class="btn bg-success-600 text-white hover:bg-success-700 text-lg px-8 py-4">
              Kostenlose Prozessanalyse vereinbaren
            </NuxtLink>
            <NuxtLink to="/referenzen" class="btn-secondary bg-white/10 border-white/30 text-white hover:bg-white/20">
              Referenzen ansehen
            </NuxtLink>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
import { 
  ClockIcon, 
  XCircleIcon, 
  CurrencyEuroIcon,
  CheckCircleIcon,
  CheckIcon,
  BuildingOfficeIcon,
  ShoppingCartIcon,
  UserGroupIcon
} from '@heroicons/vue/24/outline'

// SEO
useHead({
  title: 'Prozessoptimierung - Configuraid',
  meta: [
    { name: 'description', content: 'Professionelle Prozessoptimierung für maximale Effizienz. Bis zu 40% Zeitersparnis durch optimierte Workflows. Kostenlose Erstanalyse.' }
  ]
})

// Smooth scroll to methodology
const scrollToMethod = () => {
  document.getElementById('methodology').scrollIntoView({ 
    behavior: 'smooth' 
  })
}
</script>