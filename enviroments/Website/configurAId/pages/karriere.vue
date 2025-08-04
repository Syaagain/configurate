<template>
  <div>
    <!-- Hero Section -->
    <section class="gradient-bg hero-pattern">
      <div class="container-custom py-24">
        <div class="max-w-4xl mx-auto text-center text-white">
          <h1 class="text-4xl md:text-6xl font-bold mb-6">
            Karriere bei <span class="text-success-400">Configuraid</span>
          </h1>
          <p class="text-xl mb-8 text-blue-100 leading-relaxed">
            Gestalten Sie mit uns die Zukunft der Prozessoptimierung. 
            Werden Sie Teil eines innovativen Teams, das Unternehmen dabei hilft, effizienter zu werden.
          </p>
          <div class="flex flex-col sm:flex-row gap-4 justify-center">
            <NuxtLink to="#jobs" class="btn bg-success-600 text-white hover:bg-success-700 text-lg px-8 py-4">
              Offene Stellen entdecken
            </NuxtLink>
            <NuxtLink to="#culture" class="btn-secondary bg-white/10 border-white/30 text-white hover:bg-white/20">
              Unsere Kultur kennenlernen
            </NuxtLink>
          </div>
        </div>
      </div>
    </section>

    <!-- Why Work With Us -->
    <section class="section-padding">
      <div class="container-custom">
        <div class="text-center mb-16">
          <h2 class="text-3xl md:text-4xl font-bold mb-6">
            Warum <span class="gradient-text">Configuraid</span>?
          </h2>
          <p class="text-xl text-neutral-600 max-w-3xl mx-auto">
            Wir bieten mehr als nur einen Job – wir bieten eine Plattform für persönliches 
            und berufliches Wachstum in einer der spannendsten Branchen.
          </p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          <div class="card text-center">
            <div class="w-16 h-16 bg-primary-100 rounded-full flex items-center justify-center mx-auto mb-6">
              <RocketLaunchIcon class="w-8 h-8 text-primary-600" />
            </div>
            <h3 class="text-xl font-semibold mb-4">Innovation & Technologie</h3>
            <p class="text-neutral-600 leading-relaxed">
              Arbeiten Sie mit den neuesten Technologien und Tools. 
              Von KI bis Automatisierung – Sie gestalten die Zukunft mit.
            </p>
          </div>

          <div class="card text-center">
            <div class="w-16 h-16 bg-success-100 rounded-full flex items-center justify-center mx-auto mb-6">
              <AcademicCapIcon class="w-8 h-8 text-success-600" />
            </div>
            <h3 class="text-xl font-semibold mb-4">Persönliche Entwicklung</h3>
            <p class="text-neutral-600 leading-relaxed">
              Kontinuierliche Weiterbildung, Zertifizierungen und Mentoring. 
              Wir investieren in Ihr Wachstum und Ihre Karriere.
            </p>
          </div>

          <div class="card text-center">
            <div class="w-16 h-16 bg-blue-100 rounded-full flex items-center justify-center mx-auto mb-6">
              <UserGroupIcon class="w-8 h-8 text-blue-600" />
            </div>
            <h3 class="text-xl font-semibold mb-4">Starkes Team</h3>
            <p class="text-neutral-600 leading-relaxed">
              Ein kollegiales Umfeld mit erfahrenen Experten. 
              Wir arbeiten zusammen und unterstützen uns gegenseitig.
            </p>
          </div>

          <div class="card text-center">
            <div class="w-16 h-16 bg-purple-100 rounded-full flex items-center justify-center mx-auto mb-6">
              <ScaleIcon class="w-8 h-8 text-purple-600" />
            </div>
            <h3 class="text-xl font-semibold mb-4">Work-Life-Balance</h3>
            <p class="text-neutral-600 leading-relaxed">
              Flexible Arbeitszeiten, Homeoffice-Möglichkeiten und 
              30 Tage Urlaub für optimale Work-Life-Balance.
            </p>
          </div>

          <div class="card text-center">
            <div class="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-6">
              <StarIcon class="w-8 h-8 text-green-600" />
            </div>
            <h3 class="text-xl font-semibold mb-4">Attraktive Benefits</h3>
            <p class="text-neutral-600 leading-relaxed">
              Betriebliche Altersvorsorge, Gesundheitsförderung, 
              Jobticket und regelmäßige Team-Events.
            </p>
          </div>

          <div class="card text-center">
            <div class="w-16 h-16 bg-orange-100 rounded-full flex items-center justify-center mx-auto mb-6">
              <ChartBarIcon class="w-8 h-8 text-orange-600" />
            </div>
            <h3 class="text-xl font-semibold mb-4">Impact & Sinn</h3>
            <p class="text-neutral-600 leading-relaxed">
              Ihre Arbeit macht einen echten Unterschied. 
              Sie helfen Unternehmen dabei, effizienter und erfolgreicher zu werden.
            </p>
          </div>
        </div>
      </div>
    </section>

    <!-- Company Culture -->
    <section id="culture" class="section-padding bg-neutral-50">
      <div class="container-custom">
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-16 items-center">
          <div>
            <h2 class="text-3xl md:text-4xl font-bold mb-6">
              Unsere <span class="gradient-text">Unternehmenskultur</span>
            </h2>
            <p class="text-lg text-neutral-600 mb-6 leading-relaxed">
              Bei Configuraid steht der Mensch im Mittelpunkt. Wir glauben, dass die besten 
              Ergebnisse entstehen, wenn Menschen ihre Stärken entfalten können und dabei 
              Spaß an der Arbeit haben.
            </p>
            
            <div class="space-y-6">
              <div class="flex items-start space-x-4">
                <div class="w-8 h-8 bg-primary-600 rounded-full flex items-center justify-center flex-shrink-0">
                  <CheckIcon class="w-4 h-4 text-white" />
                </div>
                <div>
                  <h3 class="font-semibold mb-2">Offene Kommunikation</h3>
                  <p class="text-neutral-600">Flache Hierarchien und direkter Austausch auf allen Ebenen.</p>
                </div>
              </div>
              
              <div class="flex items-start space-x-4">
                <div class="w-8 h-8 bg-success-600 rounded-full flex items-center justify-center flex-shrink-0">
                  <CheckIcon class="w-4 h-4 text-white" />
                </div>
                <div>
                  <h3 class="font-semibold mb-2">Eigenverantwortung</h3>
                  <p class="text-neutral-600">Gestalten Sie Ihre Projekte selbständig und übernehmen Sie Verantwortung.</p>
                </div>
              </div>
              
              <div class="flex items-start space-x-4">
                <div class="w-8 h-8 bg-blue-600 rounded-full flex items-center justify-center flex-shrink-0">
                  <CheckIcon class="w-4 h-4 text-white" />
                </div>
                <div>
                  <h3 class="font-semibold mb-2">Kontinuierliches Lernen</h3>
                  <p class="text-neutral-600">Regelmäßige Schulungen, Konferenzen und interne Wissensaustausch.</p>
                </div>
              </div>
            </div>
          </div>
          
          <div class="bg-white rounded-2xl p-8 shadow-xl">
            <h3 class="text-xl font-bold mb-6 text-center">Was unsere Mitarbeiter sagen</h3>
            
            <div class="space-y-6">
              <blockquote class="border-l-4 border-primary-600 pl-4">
                <p class="text-neutral-700 italic mb-2">
                  "Die Möglichkeit, an innovativen Projekten zu arbeiten und dabei ständig 
                  neue Technologien zu lernen, macht jeden Tag spannend."
                </p>
                <footer class="text-sm text-neutral-500">
                  — Sarah M., Senior Consultant
                </footer>
              </blockquote>
              
              <blockquote class="border-l-4 border-success-600 pl-4">
                <p class="text-neutral-700 italic mb-2">
                  "Das Team ist fantastisch und die Work-Life-Balance stimmt wirklich. 
                  Hier wird man als Mensch geschätzt."
                </p>
                <footer class="text-sm text-neutral-500">
                  — Thomas K., Entwickler
                </footer>
              </blockquote>
              
              <blockquote class="border-l-4 border-blue-600 pl-4">
                <p class="text-neutral-700 italic mb-2">
                  "Die flachen Hierarchien ermöglichen es, eigene Ideen einzubringen 
                  und wirklich etwas zu bewegen."
                </p>
                <footer class="text-sm text-neutral-500">
                  — Lisa R., Projektmanagerin
                </footer>
              </blockquote>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Open Positions -->
    <section id="jobs" class="section-padding">
      <div class="container-custom">
        <div class="text-center mb-16">
          <h2 class="text-3xl md:text-4xl font-bold mb-6">
            Aktuelle <span class="gradient-text">Stellenausschreibungen</span>
          </h2>
          <p class="text-xl text-neutral-600 max-w-3xl mx-auto">
            Finden Sie Ihre nächste Herausforderung bei Configuraid. 
            Wir suchen leidenschaftliche Menschen, die mit uns wachsen möchten.
          </p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
          <!-- Job Position 1 -->
          <div class="card">
            <div class="flex items-start justify-between mb-4">
              <div>
                <h3 class="text-xl font-semibold mb-2">Senior Prozessberater (m/w/d)</h3>
                <div class="flex items-center space-x-4 text-sm text-neutral-600">
                  <span class="flex items-center">
                    <MapPinIcon class="w-4 h-4 mr-1" />
                    München / Remote
                  </span>
                  <span class="flex items-center">
                    <ClockIcon class="w-4 h-4 mr-1" />
                    Vollzeit
                  </span>
                </div>
              </div>
              <span class="inline-flex items-center px-2 py-1 rounded-full text-xs font-medium bg-success-100 text-success-800">
                Neu
              </span>
            </div>
            
            <p class="text-neutral-600 mb-4 leading-relaxed">
              Unterstützen Sie unsere Kunden bei der Optimierung ihrer Geschäftsprozesse. 
              Bringen Sie Ihre Erfahrung in Lean Management und Six Sigma ein.
            </p>
            
            <div class="mb-4">
              <h4 class="font-semibold mb-2 text-sm">Anforderungen:</h4>
              <ul class="text-sm text-neutral-600 space-y-1">
                <li>• 3+ Jahre Erfahrung in Prozessoptimierung</li>
                <li>• Betriebswirtschaftliche Ausbildung</li>
                <li>• Sehr gute Deutsch- und Englischkenntnisse</li>
              </ul>
            </div>
            
            <button class="btn-primary w-full">Jetzt bewerben</button>
          </div>

          <!-- Job Position 2 -->
          <div class="card">
            <div class="flex items-start justify-between mb-4">
              <div>
                <h3 class="text-xl font-semibold mb-2">Full-Stack Entwickler (m/w/d)</h3>
                <div class="flex items-center space-x-4 text-sm text-neutral-600">
                  <span class="flex items-center">
                    <MapPinIcon class="w-4 h-4 mr-1" />
                    München / Remote
                  </span>
                  <span class="flex items-center">
                    <ClockIcon class="w-4 h-4 mr-1" />
                    Vollzeit
                  </span>
                </div>
              </div>
              <span class="inline-flex items-center px-2 py-1 rounded-full text-xs font-medium bg-primary-100 text-primary-800">
                Dringend
              </span>
            </div>
            
            <p class="text-neutral-600 mb-4 leading-relaxed">
              Entwickeln Sie innovative Web-Anwendungen und Automatisierungslösungen 
              für unsere Kunden. Arbeiten Sie mit modernen Technologien wie Vue.js, Node.js und Python.
            </p>
            
            <div class="mb-4">
              <h4 class="font-semibold mb-2 text-sm">Anforderungen:</h4>
              <ul class="text-sm text-neutral-600 space-y-1">
                <li>• 2+ Jahre Erfahrung in Webentwicklung</li>
                <li>• Kenntnisse in Vue.js/React und Node.js</li>
                <li>• Interesse an Automatisierung und APIs</li>
              </ul>
            </div>
            
            <button class="btn-primary w-full">Jetzt bewerben</button>
          </div>

          <!-- Job Position 3 -->
          <div class="card">
            <div class="flex items-start justify-between mb-4">
              <div>
                <h3 class="text-xl font-semibold mb-2">Projektmanager (m/w/d)</h3>
                <div class="flex items-center space-x-4 text-sm text-neutral-600">
                  <span class="flex items-center">
                    <MapPinIcon class="w-4 h-4 mr-1" />
                    München
                  </span>
                  <span class="flex items-center">
                    <ClockIcon class="w-4 h-4 mr-1" />
                    Vollzeit
                  </span>
                </div>
              </div>
            </div>
            
            <p class="text-neutral-600 mb-4 leading-relaxed">
              Leiten Sie Digitalisierungsprojekte von der Konzeption bis zur Umsetzung. 
              Koordinieren Sie interdisziplinäre Teams und sorgen Sie für erfolgreiche Projektumsetzung.
            </p>
            
            <div class="mb-4">
              <h4 class="font-semibold mb-2 text-sm">Anforderungen:</h4>
              <ul class="text-sm text-neutral-600 space-y-1">
                <li>• 3+ Jahre Projektmanagement-Erfahrung</li>
                <li>• PMP oder PRINCE2 Zertifizierung erwünscht</li>
                <li>• Erfahrung mit agilen Methoden</li>
              </ul>
            </div>
            
            <button class="btn-primary w-full">Jetzt bewerben</button>
          </div>

          <!-- Job Position 4 -->
          <div class="card">
            <div class="flex items-start justify-between mb-4">
              <div>
                <h3 class="text-xl font-semibold mb-2">Praktikant Digitalisierung (m/w/d)</h3>
                <div class="flex items-center space-x-4 text-sm text-neutral-600">
                  <span class="flex items-center">
                    <MapPinIcon class="w-4 h-4 mr-1" />
                    München
                  </span>
                  <span class="flex items-center">
                    <ClockIcon class="w-4 h-4 mr-1" />
                    6 Monate
                  </span>
                </div>
              </div>
              <span class="inline-flex items-center px-2 py-1 rounded-full text-xs font-medium bg-blue-100 text-blue-800">
                Einstieg
              </span>
            </div>
            
            <p class="text-neutral-600 mb-4 leading-relaxed">
              Sammeln Sie erste Berufserfahrung in der Digitalisierungsberatung. 
              Unterstützen Sie unser Team bei Projekten und lernen Sie die Praxis kennen.
            </p>
            
            <div class="mb-4">
              <h4 class="font-semibold mb-2 text-sm">Anforderungen:</h4>
              <ul class="text-sm text-neutral-600 space-y-1">
                <li>• Studium BWL, Informatik oder ähnlich</li>
                <li>• Interesse an Prozessoptimierung</li>
                <li>• Eigeninitiative und Lernbereitschaft</li>
              </ul>
            </div>
            
            <button class="btn-primary w-full">Jetzt bewerben</button>
          </div>
        </div>

        <!-- No matching position -->
        <div class="mt-12 text-center">
          <div class="bg-neutral-50 rounded-2xl p-8 max-w-2xl mx-auto">
            <h3 class="text-xl font-semibold mb-4">Keine passende Stelle gefunden?</h3>
            <p class="text-neutral-600 mb-6 leading-relaxed">
              Wir sind immer auf der Suche nach talentierten Menschen. 
              Senden Sie uns gerne eine Initiativbewerbung!
            </p>
            <button class="btn-secondary">Initiativbewerbung senden</button>
          </div>
        </div>
      </div>
    </section>

    <!-- Application Process -->
    <section class="section-padding bg-neutral-50">
      <div class="container-custom">
        <div class="text-center mb-16">
          <h2 class="text-3xl md:text-4xl font-bold mb-6">
            Unser <span class="gradient-text">Bewerbungsprozess</span>
          </h2>
          <p class="text-xl text-neutral-600 max-w-3xl mx-auto">
            Transparent, fair und auf Augenhöhe – so läuft Ihr Bewerbungsprozess bei uns ab.
          </p>
        </div>

        <div class="max-w-4xl mx-auto">
          <div class="space-y-8">
            <div class="flex items-center space-x-6">
              <div class="w-12 h-12 bg-primary-600 text-white rounded-full flex items-center justify-center font-bold flex-shrink-0">
                1
              </div>
              <div class="flex-1">
                <h3 class="text-xl font-semibold mb-2">Online-Bewerbung</h3>
                <p class="text-neutral-600">
                  Senden Sie uns Ihre vollständigen Bewerbungsunterlagen. 
                  Wir melden uns innerhalb von 5 Werktagen bei Ihnen zurück.
                </p>
              </div>
              <div class="text-sm text-neutral-500 hidden md:block">5 Tage</div>
            </div>

            <div class="flex items-center space-x-6">
              <div class="w-12 h-12 bg-success-600 text-white rounded-full flex items-center justify-center font-bold flex-shrink-0">
                2
              </div>
              <div class="flex-1">
                <h3 class="text-xl font-semibold mb-2">Telefon-/Video-Interview</h3>
                <p class="text-neutral-600">
                  In einem 30-minütigen Gespräch lernen wir uns gegenseitig kennen 
                  und klären erste Fragen zu Ihrer Motivation und Ihren Erwartungen.
                </p>
              </div>
              <div class="text-sm text-neutral-500 hidden md:block">30 Min</div>
            </div>

            <div class="flex items-center space-x-6">
              <div class="w-12 h-12 bg-blue-600 text-white rounded-full flex items-center justify-center font-bold flex-shrink-0">
                3
              </div>
              <div class="flex-1">
                <h3 class="text-xl font-semibold mb-2">Persönliches Gespräch</h3>
                <p class="text-neutral-600">
                  Bei einem persönlichen Termin in München oder online vertiefen wir das Gespräch 
                  und Sie lernen Ihr zukünftiges Team kennen.
                </p>
              </div>
              <div class="text-sm text-neutral-500 hidden md:block">60 Min</div>
            </div>

            <div class="flex items-center space-x-6">
              <div class="w-12 h-12 bg-green-600 text-white rounded-full flex items-center justify-center font-bold flex-shrink-0">
                4
              </div>
              <div class="flex-1">
                <h3 class="text-xl font-semibold mb-2">Angebot & Vertragsverhandlung</h3>
                <p class="text-neutral-600">
                  Bei gegenseitigem Interesse erhalten Sie unser Angebot. 
                  Wir besprechen alle Details und finden eine Win-Win-Lösung.
                </p>
              </div>
              <div class="text-sm text-neutral-500 hidden md:block">Flexibel</div>
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
            Starten Sie Ihre Karriere bei Configuraid
          </h2>
          <p class="text-xl mb-8 text-blue-100">
            Werden Sie Teil eines Teams, das die Zukunft der Arbeit gestaltet. 
            Bewerben Sie sich noch heute!
          </p>
          <div class="flex flex-col sm:flex-row gap-4 justify-center">
            <button class="btn bg-success-600 text-white hover:bg-success-700 text-lg px-8 py-4">
              Jetzt bewerben
            </button>
            <NuxtLink to="/kontakt" class="btn-secondary bg-white/10 border-white/30 text-white hover:bg-white/20">
              Fragen stellen
            </NuxtLink>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
import {
  RocketLaunchIcon,
  AcademicCapIcon,
  UserGroupIcon,
  ScaleIcon,
  StarIcon,
  ChartBarIcon,
  CheckIcon,
  MapPinIcon,
  ClockIcon
} from '@heroicons/vue/24/outline'

// SEO
useHead({
  title: 'Karriere - Arbeiten Sie mit uns | Configuraid',
  meta: [
    { name: 'description', content: 'Starten Sie Ihre Karriere bei Configuraid. Offene Stellen in Prozessoptimierung, Entwicklung und Projektmanagement. Attraktive Benefits und Wachstumsmöglichkeiten.' }
  ]
})
</script>