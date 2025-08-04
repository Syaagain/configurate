<template>
  <div>
    <!-- Hero Section -->
    <section class="gradient-bg hero-pattern">
      <div class="container-custom py-24">
        <div class="max-w-4xl mx-auto text-center text-white">
          <h1 class="text-4xl md:text-6xl font-bold mb-6">
            Über <span class="text-success-400">Configuraid</span>
          </h1>
          <p class="text-xl mb-8 text-blue-100 leading-relaxed">
            Ihr Partner für digitale Transformation. Wir verwandeln komplexe Herausforderungen 
            in einfache, automatisierte Lösungen – seit über 5 Jahren.
          </p>
        </div>
      </div>
    </section>

    <!-- Mission & Vision -->
    <section class="section-padding">
      <div class="container-custom">
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-16 items-center">
          <div>
            <h2 class="text-3xl md:text-4xl font-bold mb-6">
              Unsere <span class="gradient-text">Mission</span>
            </h2>
            <p class="text-lg text-neutral-600 mb-6 leading-relaxed">
              Wir glauben, dass jedes Unternehmen das Potenzial hat, durch optimierte Prozesse 
              und intelligente Automatisierung außergewöhnliche Ergebnisse zu erzielen.
            </p>
            <p class="text-lg text-neutral-600 mb-8 leading-relaxed">
              Unsere Mission ist es, diese Transformation zu ermöglichen – mit maßgeschneiderten 
              Lösungen, die echten Mehrwert schaffen und nachhaltig wirken.
            </p>
            
            <div class="space-y-4">
              <div class="flex items-start space-x-3">
                <CheckCircleIcon class="w-6 h-6 text-success-600 mt-1 flex-shrink-0" />
                <div>
                  <h3 class="font-semibold mb-1">Kundenzentrischer Ansatz</h3>
                  <p class="text-neutral-600">Ihre Ziele stehen im Mittelpunkt aller unserer Entscheidungen</p>
                </div>
              </div>
              
              <div class="flex items-start space-x-3">
                <CheckCircleIcon class="w-6 h-6 text-success-600 mt-1 flex-shrink-0" />
                <div>
                  <h3 class="font-semibold mb-1">Messbare Ergebnisse</h3>
                  <p class="text-neutral-600">Jede Optimierung wird durch klare KPIs validiert</p>
                </div>
              </div>
              
              <div class="flex items-start space-x-3">
                <CheckCircleIcon class="w-6 h-6 text-success-600 mt-1 flex-shrink-0" />
                <div>
                  <h3 class="font-semibold mb-1">Langfristige Partnerschaft</h3>
                  <p class="text-neutral-600">Wir begleiten Sie auch nach der Implementierung</p>
                </div>
              </div>
            </div>
          </div>
          
          <div class="bg-neutral-50 rounded-2xl p-8">
            <div class="space-y-8">
              <div class="text-center">
                <div class="text-4xl font-bold gradient-text mb-2">5+</div>
                <div class="text-neutral-600">Jahre Erfahrung</div>
              </div>
              
              <div class="grid grid-cols-2 gap-6 text-center">
                <div class="bg-white rounded-lg p-4">
                  <div class="text-2xl font-bold text-primary-900 mb-1">50+</div>
                  <div class="text-sm text-neutral-600">Projekte erfolgreich abgeschlossen</div>
                </div>
                <div class="bg-white rounded-lg p-4">
                  <div class="text-2xl font-bold text-primary-900 mb-1">98%</div>
                  <div class="text-sm text-neutral-600">Kundenzufriedenheit</div>
                </div>
                <div class="bg-white rounded-lg p-4">
                  <div class="text-2xl font-bold text-primary-900 mb-1">40%</div>
                  <div class="text-sm text-neutral-600">Ø Effizienzsteigerung</div>
                </div>
                <div class="bg-white rounded-lg p-4">
                  <div class="text-2xl font-bold text-primary-900 mb-1">24/7</div>
                  <div class="text-sm text-neutral-600">Support verfügbar</div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Values -->
    <section class="section-padding bg-neutral-50">
      <div class="container-custom">
        <div class="text-center mb-16">
          <h2 class="text-3xl md:text-4xl font-bold mb-6">
            Unsere <span class="gradient-text">Werte</span>
          </h2>
          <p class="text-xl text-neutral-600 max-w-3xl mx-auto">
            Diese Grundsätze leiten unser tägliches Handeln und prägen unsere Zusammenarbeit mit Kunden.
          </p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
          <div class="card text-center">
            <div class="w-16 h-16 bg-primary-100 rounded-full flex items-center justify-center mx-auto mb-6">
              <LightBulbIcon class="w-8 h-8 text-primary-600" />
            </div>
            <h3 class="text-xl font-semibold mb-4">Innovation</h3>
            <p class="text-neutral-600 leading-relaxed">
              Wir suchen stets nach neuen, kreativen Lösungsansätzen und setzen 
              modernste Technologien ein, um optimale Ergebnisse zu erzielen.
            </p>
          </div>

          <div class="card text-center">
            <div class="w-16 h-16 bg-success-100 rounded-full flex items-center justify-center mx-auto mb-6">
              <ShieldCheckIcon class="w-8 h-8 text-success-600" />
            </div>
            <h3 class="text-xl font-semibold mb-4">Vertrauen</h3>
            <p class="text-neutral-600 leading-relaxed">
              Transparenz, Zuverlässigkeit und Ehrlichkeit bilden das Fundament 
              unserer Kundenbeziehungen und internen Zusammenarbeit.
            </p>
          </div>

          <div class="card text-center">
            <div class="w-16 h-16 bg-blue-100 rounded-full flex items-center justify-center mx-auto mb-6">
              <AcademicCapIcon class="w-8 h-8 text-blue-600" />
            </div>
            <h3 class="text-xl font-semibold mb-4">Exzellenz</h3>
            <p class="text-neutral-600 leading-relaxed">
              Höchste Qualitätsansprüche an unsere Arbeit und kontinuierliche 
              Weiterbildung sichern erstklassige Projektergebnisse.
            </p>
          </div>
        </div>
      </div>
    </section>

    <!-- Team Section -->
    <section class="section-padding">
      <div class="container-custom">
        <div class="text-center mb-16">
          <h2 class="text-3xl md:text-4xl font-bold mb-6">
            Unser <span class="gradient-text">Team</span>
          </h2>
          <p class="text-xl text-neutral-600 max-w-3xl mx-auto">
            Erfahrene Experten mit Leidenschaft für Prozessoptimierung und 
            einem tiefen Verständnis für die Herausforderungen moderner Unternehmen.
          </p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          <!-- Team Member 1 -->
          <div class="card text-center card-hover">
            <div class="w-32 h-32 bg-neutral-300 rounded-full mx-auto mb-6"></div>
            <h3 class="text-xl font-semibold mb-2">Dr. Alexander Schmidt</h3>
            <p class="text-primary-600 font-medium mb-4">Geschäftsführer & Gründer</p>
            <p class="text-neutral-600 mb-4">
              15+ Jahre Erfahrung in Prozessoptimierung und Change Management. 
              Promovierter Wirtschaftsingenieur mit Fokus auf Digitalisierung.
            </p>
            <div class="flex justify-center space-x-3">
              <a href="#" class="text-neutral-400 hover:text-primary-600 transition-colors">
                <span class="sr-only">LinkedIn</span>
                <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
                  <path d="M19 0h-14c-2.761 0-5 2.239-5 5v14c0 2.761 2.239 5 5 5h14c2.762 0 5-2.239 5-5v-14c0-2.761-2.238-5-5-5zm-11 19h-3v-11h3v11zm-1.5-12.268c-.966 0-1.75-.79-1.75-1.764s.784-1.764 1.75-1.764 1.75.79 1.75 1.764-.783 1.764-1.75 1.764zm13.5 12.268h-3v-5.604c0-3.368-4-3.113-4 0v5.604h-3v-11h3v1.765c1.396-2.586 7-2.777 7 2.476v6.759z"/>
                </svg>
              </a>
              <a href="#" class="text-neutral-400 hover:text-primary-600 transition-colors">
                <span class="sr-only">XING</span>
                <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
                  <path d="M18.188 0c-.517 0-.741.325-.927.66 0 0-7.455 13.224-7.702 13.657.015.024 4.919 9.023 4.919 9.023.17.308.436.66.967.66h3.454c.211 0 .375-.078.463-.22.089-.151.089-.346-.009-.536l-4.879-8.916c-.004-.006-.004-.016 0-.022L22.139.756c.095-.191.097-.387.006-.535C22.056.078 21.894 0 21.686 0h-3.498z"/>
                </svg>
              </a>
            </div>
          </div>

          <!-- Team Member 2 -->
          <div class="card text-center card-hover">
            <div class="w-32 h-32 bg-neutral-300 rounded-full mx-auto mb-6"></div>
            <h3 class="text-xl font-semibold mb-2">Sarah Weber</h3>
            <p class="text-primary-600 font-medium mb-4">Senior Consultant</p>
            <p class="text-neutral-600 mb-4">
              10+ Jahre Beratungserfahrung in der Automobilindustrie. 
              Spezialist für Lean Management und Six Sigma Methoden.
            </p>
            <div class="flex justify-center space-x-3">
              <a href="#" class="text-neutral-400 hover:text-primary-600 transition-colors">
                <span class="sr-only">LinkedIn</span>
                <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
                  <path d="M19 0h-14c-2.761 0-5 2.239-5 5v14c0 2.761 2.239 5 5 5h14c2.762 0 5-2.239 5-5v-14c0-2.761-2.238-5-5-5zm-11 19h-3v-11h3v11zm-1.5-12.268c-.966 0-1.75-.79-1.75-1.764s.784-1.764 1.75-1.764 1.75.79 1.75 1.764-.783 1.764-1.75 1.764zm13.5 12.268h-3v-5.604c0-3.368-4-3.113-4 0v5.604h-3v-11h3v1.765c1.396-2.586 7-2.777 7 2.476v6.759z"/>
                </svg>
              </a>
            </div>
          </div>

          <!-- Team Member 3 -->
          <div class="card text-center card-hover">
            <div class="w-32 h-32 bg-neutral-300 rounded-full mx-auto mb-6"></div>
            <h3 class="text-xl font-semibold mb-2">Marcus Hoffmann</h3>
            <p class="text-primary-600 font-medium mb-4">Technical Lead</p>
            <p class="text-neutral-600 mb-4">
              Full-Stack Entwickler mit Expertise in Automatisierung und 
              Integration komplexer Systeme. 12+ Jahre Projekterfahrung.
            </p>
            <div class="flex justify-center space-x-3">
              <a href="#" class="text-neutral-400 hover:text-primary-600 transition-colors">
                <span class="sr-only">GitHub</span>
                <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
                  <path d="M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z"/>
                </svg>
              </a>
            </div>
          </div>
        </div>

        <!-- Join Team CTA -->
        <div class="text-center mt-12">
          <div class="card bg-primary-50 border-primary-100 max-w-2xl mx-auto">
            <h3 class="text-xl font-semibold text-primary-900 mb-4">Verstärken Sie unser Team!</h3>
            <p class="text-primary-700 mb-6">
              Wir suchen talentierte Berater und Entwickler, die unsere Mission teilen 
              und Unternehmen bei der digitalen Transformation unterstützen möchten.
            </p>
            <NuxtLink to="/karriere" class="btn-primary">
              Karriere-Möglichkeiten entdecken
            </NuxtLink>
          </div>
        </div>
      </div>
    </section>

    <!-- Company History -->
    <section class="section-padding bg-neutral-50">
      <div class="container-custom">
        <div class="max-w-4xl mx-auto">
          <div class="text-center mb-16">
            <h2 class="text-3xl md:text-4xl font-bold mb-6">
              Unsere <span class="gradient-text">Geschichte</span>
            </h2>
            <p class="text-xl text-neutral-600">
              Von der Vision zur führenden Beratung für Prozessoptimierung
            </p>
          </div>

          <div class="space-y-12">
            <div class="flex flex-col md:flex-row items-center gap-8">
              <div class="md:w-1/3">
                <div class="text-4xl font-bold gradient-text mb-2">2019</div>
                <h3 class="text-xl font-semibold mb-2">Gründung</h3>
              </div>
              <div class="md:w-2/3">
                <p class="text-neutral-600 leading-relaxed">
                  Dr. Alexander Schmidt gründet Configuraid aus der Überzeugung heraus, 
                  dass jedes Unternehmen von optimierten Prozessen profitieren kann. 
                  Die ersten Projekte fokussieren sich auf kleine und mittelständische Unternehmen.
                </p>
              </div>
            </div>

            <div class="flex flex-col md:flex-row items-center gap-8">
              <div class="md:w-1/3">
                <div class="text-4xl font-bold gradient-text mb-2">2020</div>
                <h3 class="text-xl font-semibold mb-2">Erste Erfolge</h3>
              </div>
              <div class="md:w-2/3">
                <p class="text-neutral-600 leading-relaxed">
                  Trotz der Herausforderungen der Pandemie wächst das Team auf 5 Mitarbeiter. 
                  Die Nachfrage nach Automatisierungslösungen steigt stark an, da Unternehmen 
                  ihre Resilienz durch digitale Prozesse stärken möchten.
                </p>
              </div>
            </div>

            <div class="flex flex-col md:flex-row items-center gap-8">
              <div class="md:w-1/3">
                <div class="text-4xl font-bold gradient-text mb-2">2022</div>
                <h3 class="text-xl font-semibold mb-2">Expansion</h3>
              </div>
              <div class="md:w-2/3">
                <p class="text-neutral-600 leading-relaxed">
                  Mit über 30 erfolgreich abgeschlossenen Projekten etabliert sich Configuraid 
                  als vertrauensvoller Partner. Das Leistungsspektrum wird um Webentwicklung 
                  und digitale Transformation erweitert.
                </p>
              </div>
            </div>

            <div class="flex flex-col md:flex-row items-center gap-8">
              <div class="md:w-1/3">
                <div class="text-4xl font-bold gradient-text mb-2">2024</div>
                <h3 class="text-xl font-semibold mb-2">Heute</h3>
              </div>
              <div class="md:w-2/3">
                <p class="text-neutral-600 leading-relaxed">
                  Configuraid betreut über 50 zufriedene Kunden und hat mehr als 500 Prozesse 
                  erfolgreich optimiert. Das Team besteht aus erfahrenen Beratern, Entwicklern 
                  und Projektmanagern mit einer gemeinsamen Vision: Die digitale Transformation 
                  für jedes Unternehmen möglich zu machen.
                </p>
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
            Bereit für Ihre Transformation?
          </h2>
          <p class="text-xl mb-8 text-blue-100">
            Lassen Sie uns gemeinsam die Potentiale in Ihrem Unternehmen entdecken 
            und eine maßgeschneiderte Lösung entwickeln.
          </p>
          <div class="flex flex-col sm:flex-row gap-4 justify-center">
            <NuxtLink to="/kontakt" class="btn bg-success-600 text-white hover:bg-success-700 text-lg px-8 py-4">
              Kostenlose Erstberatung vereinbaren
            </NuxtLink>
            <NuxtLink to="/referenzen" class="btn-secondary bg-white/10 border-white/30 text-white hover:bg-white/20">
              Unsere Referenzen ansehen
            </NuxtLink>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
import {
  CheckCircleIcon,
  LightBulbIcon,
  ShieldCheckIcon,
  AcademicCapIcon
} from '@heroicons/vue/24/outline'

// SEO
useHead({
  title: 'Über uns - Unser Team und unsere Mission | Configuraid',
  meta: [
    { name: 'description', content: 'Lernen Sie das Configuraid-Team kennen. Erfahrene Experten für Prozessoptimierung mit der Mission, Ihre digitale Transformation zu ermöglichen.' }
  ]
})
</script>