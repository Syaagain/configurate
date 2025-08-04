<template>
  <div>
    <!-- Hero Section -->
    <section class="gradient-bg hero-pattern relative overflow-hidden">
      <div class="container-custom section-padding relative z-10">
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
          <div class="text-white">
            <h1 class="text-4xl md:text-6xl font-bold mb-6 leading-tight fade-in-up">
              Ihre Geschäftsprozesse.<br>
              <span class="text-success-400">Optimiert.</span><br>
              <span class="text-success-400">Automatisiert.</span><br>
              <span class="text-success-400">Erfolgreich.</span>
            </h1>
            <p class="text-xl mb-8 text-blue-100 leading-relaxed fade-in-up" style="animation-delay: 0.2s;">
              Configuraid verwandelt komplexe Prozesse in effiziente, automatisierte Workflows – maßgeschneidert für Ihr Unternehmen.
            </p>
            <div class="flex flex-col sm:flex-row gap-4 fade-in-up" style="animation-delay: 0.4s;">
              <NuxtLink to="/kontakt" class="btn bg-success-600 text-white hover:bg-success-700 text-lg px-8 py-4">
                Kostenlose Erstberatung vereinbaren
              </NuxtLink>
              <NuxtLink to="/referenzen" class="btn-secondary bg-white/10 border-white/30 text-white hover:bg-white/20">
                Erfolgsgeschichten ansehen
              </NuxtLink>
            </div>
          </div>
          
          <!-- Hero Illustration -->
          <div class="relative">
            <div class="floating-animation">
              <div class="bg-white/10 backdrop-blur-sm rounded-2xl p-8 border border-white/20">
                <div class="grid grid-cols-2 gap-4">
                  <div class="bg-success-500/20 rounded-lg p-4 text-center">
                    <div class="text-3xl font-bold text-white">40%</div>
                    <div class="text-sm text-blue-100">Zeitersparnis</div>
                  </div>
                  <div class="bg-success-500/20 rounded-lg p-4 text-center">
                    <div class="text-3xl font-bold text-white">500+</div>
                    <div class="text-sm text-blue-100">Optimierte Prozesse</div>
                  </div>
                  <div class="bg-success-500/20 rounded-lg p-4 text-center">
                    <div class="text-3xl font-bold text-white">50+</div>
                    <div class="text-sm text-blue-100">Zufriedene Kunden</div>
                  </div>
                  <div class="bg-success-500/20 rounded-lg p-4 text-center">
                    <div class="text-3xl font-bold text-white">24/7</div>
                    <div class="text-sm text-blue-100">Automatisierung</div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      
      <!-- Background Elements -->
      <div class="absolute top-0 right-0 w-1/2 h-full opacity-10">
        <svg viewBox="0 0 404 404" fill="none" xmlns="http://www.w3.org/2000/svg">
          <defs>
            <pattern id="pattern" x="0" y="0" width="20" height="20" patternUnits="userSpaceOnUse">
              <rect x="0" y="0" width="4" height="4" fill="currentColor" />
            </pattern>
          </defs>
          <rect width="404" height="404" fill="url(#pattern)" />
        </svg>
      </div>
    </section>

    <!-- Value Proposition -->
    <section class="section-padding bg-neutral-50">
      <div class="container-custom">
        <div class="text-center mb-12">
          <h2 class="text-3xl md:text-4xl font-bold mb-6 gradient-text">
            Warum Configuraid der richtige Partner für Sie ist
          </h2>
          <p class="text-xl text-neutral-600 max-w-3xl mx-auto">
            Ineffiziente Prozesse kosten Zeit und Geld. Wir verwandeln sie in Ihre größten Wettbewerbsvorteile.
          </p>
        </div>
        
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
          <div class="text-center fade-in-up stagger-animation">
            <div class="w-16 h-16 bg-red-100 rounded-full flex items-center justify-center mx-auto mb-4">
              <ExclamationTriangleIcon class="w-8 h-8 text-red-600" />
            </div>
            <h3 class="text-xl font-semibold mb-2">Das Problem</h3>
            <p class="text-neutral-600">
              Manuelle Prozesse verlangsamen Ihr Unternehmen und führen zu Fehlern, Verzögerungen und unnötigen Kosten.
            </p>
          </div>
          
          <div class="text-center fade-in-up stagger-animation">
            <div class="w-16 h-16 bg-primary-100 rounded-full flex items-center justify-center mx-auto mb-4">
              <CogIcon class="w-8 h-8 text-primary-600" />
            </div>
            <h3 class="text-xl font-semibold mb-2">Unsere Lösung</h3>
            <p class="text-neutral-600">
              Maßgeschneiderte Prozessoptimierung und Automatisierung, die perfekt zu Ihrem Unternehmen passt.
            </p>
          </div>
          
          <div class="text-center fade-in-up stagger-animation">
            <div class="w-16 h-16 bg-success-100 rounded-full flex items-center justify-center mx-auto mb-4">
              <ChartBarIcon class="w-8 h-8 text-success-600" />
            </div>
            <h3 class="text-xl font-semibold mb-2">Ihr Nutzen</h3>
            <p class="text-neutral-600">
              Bis zu 40% Zeitersparnis bei gleichzeitig höherer Qualität und Zuverlässigkeit Ihrer Prozesse.
            </p>
          </div>
        </div>
      </div>
    </section>

    <!-- Services Section -->
    <section class="section-padding">
      <div class="container-custom">
        <div class="text-center mb-16">
          <h2 class="text-3xl md:text-4xl font-bold mb-6">
            Unsere <span class="gradient-text">4 Säulen</span> für Ihren Erfolg
          </h2>
          <p class="text-xl text-neutral-600 max-w-3xl mx-auto">
            Von der Analyse bis zur Implementierung – wir begleiten Sie auf dem gesamten Weg zur digitalen Transformation.
          </p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
          <!-- Prozessoptimierung -->
          <div class="card card-hover fade-in-up stagger-animation group">
            <div class="w-12 h-12 bg-primary-100 rounded-lg flex items-center justify-center mb-4 group-hover:bg-primary-600 transition-colors duration-300">
              <ChartBarIcon class="w-6 h-6 text-primary-600 group-hover:text-white transition-colors duration-300" />
            </div>
            <h3 class="text-xl font-semibold mb-3">Prozessoptimierung</h3>
            <ul class="text-neutral-600 space-y-2 mb-6">
              <li class="flex items-start space-x-2">
                <CheckIcon class="w-4 h-4 text-success-500 mt-1 flex-shrink-0" />
                <span>Analyse bestehender Workflows</span>
              </li>
              <li class="flex items-start space-x-2">
                <CheckIcon class="w-4 h-4 text-success-500 mt-1 flex-shrink-0" />
                <span>Identifikation von Verbesserungspotenzialen</span>
              </li>
              <li class="flex items-start space-x-2">
                <CheckIcon class="w-4 h-4 text-success-500 mt-1 flex-shrink-0" />
                <span>Implementierung optimierter Prozesse</span>
              </li>
            </ul>
            <NuxtLink to="/leistungen/prozessoptimierung" class="text-primary-600 font-medium hover:text-primary-800 transition-colors">
              Mehr erfahren →
            </NuxtLink>
          </div>

          <!-- Automatisierung -->
          <div class="card card-hover fade-in-up stagger-animation group">
            <div class="w-12 h-12 bg-success-100 rounded-lg flex items-center justify-center mb-4 group-hover:bg-success-600 transition-colors duration-300">
              <CogIcon class="w-6 h-6 text-success-600 group-hover:text-white transition-colors duration-300" />
            </div>
            <h3 class="text-xl font-semibold mb-3">Automatisierung</h3>
            <ul class="text-neutral-600 space-y-2 mb-6">
              <li class="flex items-start space-x-2">
                <CheckIcon class="w-4 h-4 text-success-500 mt-1 flex-shrink-0" />
                <span>Digitale Transformation von manuellen Prozessen</span>
              </li>
              <li class="flex items-start space-x-2">
                <CheckIcon class="w-4 h-4 text-success-500 mt-1 flex-shrink-0" />
                <span>Integration verschiedener Systeme</span>
              </li>
              <li class="flex items-start space-x-2">
                <CheckIcon class="w-4 h-4 text-success-500 mt-1 flex-shrink-0" />
                <span>Workflow-Automatisierung</span>
              </li>
            </ul>
            <NuxtLink to="/leistungen/automatisierung" class="text-primary-600 font-medium hover:text-primary-800 transition-colors">
              Mehr erfahren →
            </NuxtLink>
          </div>

          <!-- Webentwicklung -->
          <div class="card card-hover fade-in-up stagger-animation group">
            <div class="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center mb-4 group-hover:bg-blue-600 transition-colors duration-300">
              <CodeBracketIcon class="w-6 h-6 text-blue-600 group-hover:text-white transition-colors duration-300" />
            </div>
            <h3 class="text-xl font-semibold mb-3">Webentwicklung</h3>
            <ul class="text-neutral-600 space-y-2 mb-6">
              <li class="flex items-start space-x-2">
                <CheckIcon class="w-4 h-4 text-success-500 mt-1 flex-shrink-0" />
                <span>Maßgeschneiderte digitale Lösungen</span>
              </li>
              <li class="flex items-start space-x-2">
                <CheckIcon class="w-4 h-4 text-success-500 mt-1 flex-shrink-0" />
                <span>Responsive und performante Websites</span>
              </li>
              <li class="flex items-start space-x-2">
                <CheckIcon class="w-4 h-4 text-success-500 mt-1 flex-shrink-0" />
                <span>E-Commerce und Web-Applikationen</span>
              </li>
            </ul>
            <NuxtLink to="/leistungen/webentwicklung" class="text-primary-600 font-medium hover:text-primary-800 transition-colors">
              Mehr erfahren →
            </NuxtLink>
          </div>

          <!-- Beratung -->
          <div class="card card-hover fade-in-up stagger-animation group">
            <div class="w-12 h-12 bg-purple-100 rounded-lg flex items-center justify-center mb-4 group-hover:bg-purple-600 transition-colors duration-300">
              <UserGroupIcon class="w-6 h-6 text-purple-600 group-hover:text-white transition-colors duration-300" />
            </div>
            <h3 class="text-xl font-semibold mb-3">Individuelle Beratung</h3>
            <ul class="text-neutral-600 space-y-2 mb-6">
              <li class="flex items-start space-x-2">
                <CheckIcon class="w-4 h-4 text-success-500 mt-1 flex-shrink-0" />
                <span>Analyse Ihrer spezifischen Anforderungen</span>
              </li>
              <li class="flex items-start space-x-2">
                <CheckIcon class="w-4 h-4 text-success-500 mt-1 flex-shrink-0" />
                <span>Strategische Beratung und Roadmap-Entwicklung</span>
              </li>
              <li class="flex items-start space-x-2">
                <CheckIcon class="w-4 h-4 text-success-500 mt-1 flex-shrink-0" />
                <span>Kontinuierliche Betreuung und Support</span>
              </li>
            </ul>
            <NuxtLink to="/leistungen/beratung" class="text-primary-600 font-medium hover:text-primary-800 transition-colors">
              Mehr erfahren →
            </NuxtLink>
          </div>
        </div>
      </div>
    </section>

    <!-- Social Proof -->
    <section class="section-padding bg-neutral-50">
      <div class="container-custom">
        <div class="text-center mb-16">
          <h2 class="text-3xl md:text-4xl font-bold mb-6">
            Was unsere <span class="gradient-text">Kunden</span> sagen
          </h2>
          <p class="text-xl text-neutral-600">
            Über 50 zufriedene Kunden vertrauen bereits auf unsere Expertise
          </p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-8 mb-16">
          <!-- Testimonial 1 -->
          <div class="card fade-in-up stagger-animation">
            <div class="flex items-center mb-4">
              <div class="flex text-yellow-400">
                <StarIcon class="w-5 h-5 fill-current" />
                <StarIcon class="w-5 h-5 fill-current" />
                <StarIcon class="w-5 h-5 fill-current" />
                <StarIcon class="w-5 h-5 fill-current" />
                <StarIcon class="w-5 h-5 fill-current" />
              </div>
            </div>
            <blockquote class="text-neutral-700 mb-4">
              "Dank Configuraid konnten wir unsere Bestellabwicklung um 60% beschleunigen. Die Automatisierung funktioniert einwandfrei!"
            </blockquote>
            <div class="flex items-center">
              <div class="w-12 h-12 bg-neutral-300 rounded-full mr-4"></div>
              <div>
                <div class="font-semibold">Maria Schmidt</div>
                <div class="text-sm text-neutral-500">Geschäftsführerin, TechTrade GmbH</div>
              </div>
            </div>
          </div>

          <!-- Testimonial 2 -->
          <div class="card fade-in-up stagger-animation">
            <div class="flex items-center mb-4">
              <div class="flex text-yellow-400">
                <StarIcon class="w-5 h-5 fill-current" />
                <StarIcon class="w-5 h-5 fill-current" />
                <StarIcon class="w-5 h-5 fill-current" />
                <StarIcon class="w-5 h-5 fill-current" />
                <StarIcon class="w-5 h-5 fill-current" />
              </div>
            </div>
            <blockquote class="text-neutral-700 mb-4">
              "Die Prozessoptimierung hat unsere Produktivität drastisch gesteigert. Wir sparen jetzt 8 Stunden pro Woche!"
            </blockquote>
            <div class="flex items-center">
              <div class="w-12 h-12 bg-neutral-300 rounded-full mr-4"></div>
              <div>
                <div class="font-semibold">Thomas Müller</div>
                <div class="text-sm text-neutral-500">IT-Leiter, ProduktionsPlus AG</div>
              </div>
            </div>
          </div>

          <!-- Testimonial 3 -->
          <div class="card fade-in-up stagger-animation">
            <div class="flex items-center mb-4">
              <div class="flex text-yellow-400">
                <StarIcon class="w-5 h-5 fill-current" />
                <StarIcon class="w-5 h-5 fill-current" />
                <StarIcon class="w-5 h-5 fill-current" />
                <StarIcon class="w-5 h-5 fill-current" />
                <StarIcon class="w-5 h-5 fill-current" />
              </div>
            </div>
            <blockquote class="text-neutral-700 mb-4">
              "Professionelle Beratung und exzellente Umsetzung. Configuraid ist ein echter Partner auf Augenhöhe."
            </blockquote>
            <div class="flex items-center">
              <div class="w-12 h-12 bg-neutral-300 rounded-full mr-4"></div>
              <div>
                <div class="font-semibold">Sarah Weber</div>
                <div class="text-sm text-neutral-500">COO, ServiceExcellence Ltd.</div>
              </div>
            </div>
          </div>
        </div>

        <!-- Stats -->
        <div class="grid grid-cols-2 md:grid-cols-4 gap-8 text-center">
          <div class="fade-in-up stagger-animation">
            <div class="text-4xl font-bold gradient-text mb-2">50+</div>
            <div class="text-neutral-600">Zufriedene Kunden</div>
          </div>
          <div class="fade-in-up stagger-animation">
            <div class="text-4xl font-bold gradient-text mb-2">500+</div>
            <div class="text-neutral-600">Optimierte Prozesse</div>
          </div>
          <div class="fade-in-up stagger-animation">
            <div class="text-4xl font-bold gradient-text mb-2">40%</div>
            <div class="text-neutral-600">Durchschnittliche Zeitersparnis</div>
          </div>
          <div class="fade-in-up stagger-animation">
            <div class="text-4xl font-bold gradient-text mb-2">98%</div>
            <div class="text-neutral-600">Kundenzufriedenheit</div>
          </div>
        </div>
      </div>
    </section>

    <!-- CTA Section -->
    <section class="section-padding gradient-bg hero-pattern">
      <div class="container-custom text-center">
        <div class="max-w-4xl mx-auto text-white">
          <h2 class="text-3xl md:text-5xl font-bold mb-6">
            Bereit für den nächsten Schritt?
          </h2>
          <p class="text-xl mb-8 text-blue-100">
            Lassen Sie uns gemeinsam Ihre Prozesse analysieren und das Optimierungspotential in Ihrem Unternehmen entdecken.
          </p>
          <div class="flex flex-col sm:flex-row gap-4 justify-center">
            <NuxtLink to="/kontakt" class="btn bg-success-600 text-white hover:bg-success-700 text-lg px-8 py-4">
              Kostenlose Prozessanalyse anfordern
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
import { 
  ChartBarIcon, 
  CogIcon, 
  CodeBracketIcon, 
  UserGroupIcon, 
  CheckIcon, 
  ExclamationTriangleIcon,
  StarIcon
} from '@heroicons/vue/24/outline'

// SEO
useHead({
  title: 'Configuraid - Prozessoptimierung und Automatisierung',
  meta: [
    { name: 'description', content: 'Configuraid verwandelt komplexe Prozesse in effiziente, automatisierte Workflows – maßgeschneidert für Ihr Unternehmen. Bis zu 40% Zeitersparnis.' }
  ]
})
</script>