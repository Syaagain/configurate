<template>
  <div class="min-h-screen bg-white">
    <!-- Navigation -->
    <nav class="fixed w-full bg-white/95 backdrop-blur-sm border-b border-gray-200 z-50">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between items-center py-4">
          <div class="flex items-center">
            <h1 class="text-2xl font-bold text-primary-blue">Configuraid</h1>
          </div>
          
          <div class="hidden md:flex items-center space-x-8">
            <a href="#leistungen" class="text-gray-700 hover:text-primary-blue transition-colors">Leistungen</a>
            <a href="#loesungen" class="text-gray-700 hover:text-primary-blue transition-colors">Lösungen</a>
            <a href="#referenzen" class="text-gray-700 hover:text-primary-blue transition-colors">Referenzen</a>
            <a href="#ueber-uns" class="text-gray-700 hover:text-primary-blue transition-colors">Über uns</a>
            <a href="#blog" class="text-gray-700 hover:text-primary-blue transition-colors">Blog</a>
            <a href="#kontakt" class="bg-primary-blue text-white px-6 py-2 rounded-lg hover:bg-blue-800 transition-colors">Kontakt</a>
          </div>

          <!-- Mobile menu button -->
          <button @click="mobileMenuOpen = !mobileMenuOpen" class="md:hidden">
            <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
            </svg>
          </button>
        </div>

        <!-- Mobile menu -->
        <div v-if="mobileMenuOpen" class="md:hidden pb-4">
          <div class="flex flex-col space-y-4">
            <a href="#leistungen" class="text-gray-700 hover:text-primary-blue transition-colors">Leistungen</a>
            <a href="#loesungen" class="text-gray-700 hover:text-primary-blue transition-colors">Lösungen</a>
            <a href="#referenzen" class="text-gray-700 hover:text-primary-blue transition-colors">Referenzen</a>
            <a href="#ueber-uns" class="text-gray-700 hover:text-primary-blue transition-colors">Über uns</a>
            <a href="#blog" class="text-gray-700 hover:text-primary-blue transition-colors">Blog</a>
            <a href="#kontakt" class="bg-primary-blue text-white px-6 py-2 rounded-lg hover:bg-blue-800 transition-colors text-center">Kontakt</a>
          </div>
        </div>
      </div>
    </nav>

    <!-- Hero Section -->
    <section class="pt-20 pb-16 bg-gradient-to-br from-blue-50 to-indigo-100">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="grid lg:grid-cols-2 gap-12 items-center">
          <div class="animate-fade-in-up">
            <h1 class="text-4xl md:text-6xl font-bold text-gray-900 leading-tight mb-6">
              Ihre Geschäftsprozesse.<br>
              <span class="text-primary-blue">Optimiert.</span><br>
              <span class="text-success-green">Automatisiert.</span><br>
              <span class="text-primary-blue">Erfolgreich.</span>
            </h1>
            <p class="text-xl text-gray-600 mb-8 leading-relaxed">
              Configuraid verwandelt komplexe Prozesse in effiziente, automatisierte Workflows – maßgeschneidert für Ihr Unternehmen.
            </p>
            <div class="flex flex-col sm:flex-row gap-4">
              <button class="bg-primary-blue text-white px-8 py-4 rounded-lg text-lg font-semibold hover:bg-blue-800 transition-all transform hover:scale-105 shadow-lg">
                Kostenlose Erstberatung vereinbaren
              </button>
              <button class="border-2 border-primary-blue text-primary-blue px-8 py-4 rounded-lg text-lg font-semibold hover:bg-primary-blue hover:text-white transition-all">
                Erfolgsgeschichten ansehen
              </button>
            </div>
          </div>
          <div class="lg:order-last animate-fade-in-right">
            <div class="relative">
              <div class="bg-white rounded-2xl shadow-2xl p-8 transform rotate-3 hover:rotate-0 transition-transform duration-500">
                <div class="text-center">
                  <div class="text-4xl font-bold text-success-green mb-2">40%</div>
                  <div class="text-gray-600">Zeitersparnis</div>
                </div>
              </div>
              <div class="absolute -top-4 -right-4 bg-primary-blue text-white rounded-xl p-6 transform -rotate-6 hover:rotate-0 transition-transform duration-500">
                <div class="text-center">
                  <div class="text-2xl font-bold mb-1">100+</div>
                  <div class="text-sm">Optimierte Prozesse</div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Value Proposition -->
    <section class="py-16 bg-white">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="grid md:grid-cols-3 gap-8 text-center">
          <div class="animate-fade-in-up">
            <div class="w-16 h-16 bg-red-100 rounded-full flex items-center justify-center mx-auto mb-4">
              <svg class="w-8 h-8 text-red-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
              </svg>
            </div>
            <h3 class="text-xl font-bold text-gray-900 mb-2">Problem</h3>
            <p class="text-gray-600">Ineffiziente Prozesse kosten Zeit und Geld</p>
          </div>
          <div class="animate-fade-in-up" style="animation-delay: 0.2s">
            <div class="w-16 h-16 bg-blue-100 rounded-full flex items-center justify-center mx-auto mb-4">
              <svg class="w-8 h-8 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.663 17h4.673M12 3v1m6.364 1.636l-.707.707M21 12h-1M4 12H3m3.343-5.657l-.707-.707m2.828 9.9a5 5 0 117.072 0l-.548.547A3.374 3.374 0 0014 18.469V19a2 2 0 11-4 0v-.531c0-.895-.356-1.754-.988-2.386l-.548-.547z" />
              </svg>
            </div>
            <h3 class="text-xl font-bold text-gray-900 mb-2">Lösung</h3>
            <p class="text-gray-600">Maßgeschneiderte Optimierung und Automatisierung</p>
          </div>
          <div class="animate-fade-in-up" style="animation-delay: 0.4s">
            <div class="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4">
              <svg class="w-8 h-8 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6" />
              </svg>
            </div>
            <h3 class="text-xl font-bold text-gray-900 mb-2">Nutzen</h3>
            <p class="text-gray-600">Bis zu 40% Zeitersparnis bei höherer Qualität</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Services Section -->
    <section id="leistungen" class="py-20 bg-gray-50">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="text-center mb-16">
          <h2 class="text-4xl font-bold text-gray-900 mb-4">Unsere Leistungen</h2>
          <p class="text-xl text-gray-600 max-w-3xl mx-auto">Vier Säulen für Ihren digitalen Erfolg</p>
        </div>

        <div class="grid md:grid-cols-2 lg:grid-cols-4 gap-8">
          <div class="bg-white rounded-xl p-8 shadow-lg hover:shadow-xl transition-all transform hover:-translate-y-2 group">
            <div class="w-16 h-16 bg-blue-100 rounded-full flex items-center justify-center mb-6 group-hover:bg-primary-blue transition-colors">
              <svg class="w-8 h-8 text-blue-600 group-hover:text-white transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z" />
              </svg>
            </div>
            <h3 class="text-xl font-bold text-gray-900 mb-4">Prozessoptimierung</h3>
            <ul class="text-gray-600 space-y-2 mb-6">
              <li>• Analyse bestehender Workflows</li>
              <li>• Identifikation von Verbesserungspotenzialen</li>
              <li>• Implementierung optimierter Prozesse</li>
            </ul>
            <button class="text-primary-blue font-semibold hover:text-blue-800 transition-colors">Mehr erfahren →</button>
          </div>

          <div class="bg-white rounded-xl p-8 shadow-lg hover:shadow-xl transition-all transform hover:-translate-y-2 group">
            <div class="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center mb-6 group-hover:bg-success-green transition-colors">
              <svg class="w-8 h-8 text-green-600 group-hover:text-white transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z" />
              </svg>
            </div>
            <h3 class="text-xl font-bold text-gray-900 mb-4">Automatisierung</h3>
            <ul class="text-gray-600 space-y-2 mb-6">
              <li>• Digitale Transformation manueller Prozesse</li>
              <li>• Integration verschiedener Systeme</li>
              <li>• Workflow-Automatisierung</li>
            </ul>
            <button class="text-success-green font-semibold hover:text-green-800 transition-colors">Mehr erfahren →</button>
          </div>

          <div class="bg-white rounded-xl p-8 shadow-lg hover:shadow-xl transition-all transform hover:-translate-y-2 group">
            <div class="w-16 h-16 bg-purple-100 rounded-full flex items-center justify-center mb-6 group-hover:bg-purple-600 transition-colors">
              <svg class="w-8 h-8 text-purple-600 group-hover:text-white transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 20l4-16m4 4l4 4-4 4M6 16l-4-4 4-4" />
              </svg>
            </div>
            <h3 class="text-xl font-bold text-gray-900 mb-4">Webentwicklung</h3>
            <ul class="text-gray-600 space-y-2 mb-6">
              <li>• Maßgeschneiderte digitale Lösungen</li>
              <li>• Responsive und performante Websites</li>
              <li>• E-Commerce und Web-Applikationen</li>
            </ul>
            <button class="text-purple-600 font-semibold hover:text-purple-800 transition-colors">Mehr erfahren →</button>
          </div>

          <div class="bg-white rounded-xl p-8 shadow-lg hover:shadow-xl transition-all transform hover:-translate-y-2 group">
            <div class="w-16 h-16 bg-orange-100 rounded-full flex items-center justify-center mb-6 group-hover:bg-orange-600 transition-colors">
              <svg class="w-8 h-8 text-orange-600 group-hover:text-white transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
              </svg>
            </div>
            <h3 class="text-xl font-bold text-gray-900 mb-4">Individuelle Beratung</h3>
            <ul class="text-gray-600 space-y-2 mb-6">
              <li>• Analyse spezifischer Anforderungen</li>
              <li>• Strategische Beratung und Roadmap</li>
              <li>• Kontinuierliche Betreuung</li>
            </ul>
            <button class="text-orange-600 font-semibold hover:text-orange-800 transition-colors">Mehr erfahren →</button>
          </div>
        </div>
      </div>
    </section>

    <!-- Social Proof Section -->
    <section class="py-20 bg-white">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="text-center mb-16">
          <h2 class="text-4xl font-bold text-gray-900 mb-4">Vertrauen Sie unserem Erfolg</h2>
          <p class="text-xl text-gray-600">Über 100 zufriedene Kunden vertrauen bereits auf unsere Expertise</p>
        </div>

        <!-- Stats -->
        <div class="grid md:grid-cols-4 gap-8 mb-16">
          <div class="text-center">
            <div class="text-4xl font-bold text-primary-blue mb-2" data-count="250">250+</div>
            <div class="text-gray-600">Kunden betreut</div>
          </div>
          <div class="text-center">
            <div class="text-4xl font-bold text-success-green mb-2" data-count="500">500+</div>
            <div class="text-gray-600">Prozesse optimiert</div>
          </div>
          <div class="text-center">
            <div class="text-4xl font-bold text-primary-blue mb-2" data-count="40">40%</div>
            <div class="text-gray-600">Durchschnittliche Zeitersparnis</div>
          </div>
          <div class="text-center">
            <div class="text-4xl font-bold text-success-green mb-2" data-count="98">98%</div>
            <div class="text-gray-600">Kundenzufriedenheit</div>
          </div>
        </div>

        <!-- Testimonials -->
        <div class="grid md:grid-cols-3 gap-8">
          <div class="bg-gray-50 rounded-xl p-8">
            <div class="flex items-center mb-4">
              <div class="flex text-yellow-400">
                <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" v-for="i in 5" :key="i">
                  <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                </svg>
              </div>
            </div>
            <p class="text-gray-600 mb-4">"Configuraid hat unsere Produktionsprozesse revolutioniert. Wir sparen jetzt 35% Zeit und haben deutlich weniger Fehler."</p>
            <div class="font-semibold text-gray-900">Thomas Müller</div>
            <div class="text-gray-500">Geschäftsführer, Müller GmbH</div>
          </div>

          <div class="bg-gray-50 rounded-xl p-8">
            <div class="flex items-center mb-4">
              <div class="flex text-yellow-400">
                <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" v-for="i in 5" :key="i">
                  <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                </svg>
              </div>
            </div>
            <p class="text-gray-600 mb-4">"Die Automatisierung unserer Kundenbetreuung war ein Gamechanger. Professionalität und Kompetenz auf höchstem Niveau."</p>
            <div class="font-semibold text-gray-900">Sarah Weber</div>
            <div class="text-gray-500">Marketing Leiterin, TechCorp</div>
          </div>

          <div class="bg-gray-50 rounded-xl p-8">
            <div class="flex items-center mb-4">
              <div class="flex text-yellow-400">
                <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" v-for="i in 5" :key="i">
                  <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                </svg>
              </div>
            </div>
            <p class="text-gray-600 mb-4">"Schnelle Umsetzung, durchdachte Lösungen und exzellenter Support. Unsere Effizienz ist um 45% gestiegen."</p>
            <div class="font-semibold text-gray-900">Michael Schmidt</div>
            <div class="text-gray-500">IT-Leiter, Schmidt & Partner</div>
          </div>
        </div>
      </div>
    </section>

    <!-- CTA Section -->
    <section class="py-20 bg-gradient-to-r from-primary-blue to-blue-800">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
        <h2 class="text-4xl font-bold text-white mb-6">Bereit für die digitale Transformation?</h2>
        <p class="text-xl text-blue-100 mb-8 max-w-3xl mx-auto">
          Lassen Sie uns gemeinsam Ihre Geschäftsprozesse optimieren und automatisieren. 
          Vereinbaren Sie noch heute Ihre kostenlose Erstberatung.
        </p>
        <div class="flex flex-col sm:flex-row gap-4 justify-center">
          <button class="bg-white text-primary-blue px-8 py-4 rounded-lg text-lg font-semibold hover:bg-gray-100 transition-all transform hover:scale-105 shadow-lg">
            Kostenlose Prozessanalyse anfordern
          </button>
          <button class="border-2 border-white text-white px-8 py-4 rounded-lg text-lg font-semibold hover:bg-white hover:text-primary-blue transition-all">
            Whitepaper herunterladen
          </button>
        </div>
      </div>
    </section>

    <!-- Footer -->
    <footer class="bg-gray-900 text-white py-16">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="grid md:grid-cols-4 gap-8 mb-8">
          <div>
            <h3 class="text-2xl font-bold mb-4">Configuraid</h3>
            <p class="text-gray-400 mb-4">Ihr Partner für Prozessoptimierung und Automatisierung</p>
            <div class="flex space-x-4">
              <a href="#" class="text-gray-400 hover:text-white transition-colors">
                <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24">
                  <path d="M24 4.557c-.883.392-1.832.656-2.828.775 1.017-.609 1.798-1.574 2.165-2.724-.951.564-2.005.974-3.127 1.195-.897-.957-2.178-1.555-3.594-1.555-3.179 0-5.515 2.966-4.797 6.045-4.091-.205-7.719-2.165-10.148-5.144-1.29 2.213-.669 5.108 1.523 6.574-.806-.026-1.566-.247-2.229-.616-.054 2.281 1.581 4.415 3.949 4.89-.693.188-1.452.232-2.224.084.626 1.956 2.444 3.379 4.6 3.419-2.07 1.623-4.678 2.348-7.29 2.04 2.179 1.397 4.768 2.212 7.548 2.212 9.142 0 14.307-7.721 13.995-14.646.962-.695 1.797-1.562 2.457-2.549z"/>
                </svg>
              </a>
              <a href="#" class="text-gray-400 hover:text-white transition-colors">
                <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24">
                  <path d="M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433c-1.144 0-2.063-.926-2.063-2.065 0-1.138.92-2.063 2.063-2.063 1.14 0 2.064.925 2.064 2.063 0 1.139-.925 2.065-2.064 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z"/>
                </svg>
              </a>
              <a href="#" class="text-gray-400 hover:text-white transition-colors">
                <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24">
                  <path d="M12.017 0C5.396 0 .029 5.367.029 11.987c0 5.079 3.158 9.417 7.618 11.174-.105-.949-.199-2.403.041-3.439.219-.937 1.406-5.957 1.406-5.957s-.359-.72-.359-1.781c0-1.663.967-2.911 2.168-2.911 1.024 0 1.518.769 1.518 1.688 0 1.029-.653 2.567-.992 3.992-.285 1.193.6 2.165 1.775 2.165 2.128 0 3.768-2.245 3.768-5.487 0-2.861-2.063-4.869-5.008-4.869-3.41 0-5.409 2.562-5.409 5.199 0 1.033.394 2.143.889 2.741.097.118.112.222.083.343-.09.375-.293 1.199-.334 1.363-.053.225-.172.271-.402.165-1.495-.69-2.433-2.878-2.433-4.646 0-3.776 2.748-7.252 7.92-7.252 4.158 0 7.392 2.967 7.392 6.923 0 4.135-2.607 7.462-6.233 7.462-1.214 0-2.357-.629-2.746-1.378 0 0-.599 2.282-.744 2.840-.282 1.084-1.064 2.456-1.549 3.235C9.584 23.815 10.77 24.001 12.017 24.001c6.624 0 11.99-5.367 11.99-11.988C24.007 5.367 18.641.001 12.017.001z"/>
                </svg>
              </a>
            </div>
          </div>

          <div>
            <h4 class="text-lg font-semibold mb-4">Leistungen</h4>
            <ul class="space-y-2 text-gray-400">
              <li><a href="#" class="hover:text-white transition-colors">Prozessoptimierung</a></li>
              <li><a href="#" class="hover:text-white transition-colors">Automatisierung</a></li>
              <li><a href="#" class="hover:text-white transition-colors">Webentwicklung</a></li>
              <li><a href="#" class="hover:text-white transition-colors">Beratung</a></li>
            </ul>
          </div>

          <div>
            <h4 class="text-lg font-semibold mb-4">Unternehmen</h4>
            <ul class="space-y-2 text-gray-400">
              <li><a href="#" class="hover:text-white transition-colors">Über uns</a></li>
              <li><a href="#" class="hover:text-white transition-colors">Team</a></li>
              <li><a href="#" class="hover:text-white transition-colors">Karriere</a></li>
              <li><a href="#" class="hover:text-white transition-colors">Blog</a></li>
            </ul>
          </div>

          <div>
            <h4 class="text-lg font-semibold mb-4">Kontakt</h4>
            <div class="space-y-2 text-gray-400">
              <p>📧 info@configuraid.de</p>
              <p>📞 +49 (0) 123 456 789</p>
              <p>📍 Musterstraße 123<br>80331 München</p>
            </div>
          </div>
        </div>

        <div class="border-t border-gray-800 pt-8 flex flex-col md:flex-row justify-between items-center">
          <p class="text-gray-400">© 2024 Configuraid. Alle Rechte vorbehalten.</p>
          <div class="flex space-x-6 mt-4 md:mt-0">
            <a href="#" class="text-gray-400 hover:text-white transition-colors">Impressum</a>
            <a href="#" class="text-gray-400 hover:text-white transition-colors">Datenschutz</a>
            <a href="#" class="text-gray-400 hover:text-white transition-colors">AGB</a>
          </div>
        </div>
      </div>
    </footer>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const mobileMenuOpen = ref(false)
</script>

<style scoped>
.text-primary-blue {
  color: var(--primary-blue);
}

.bg-primary-blue {
  background-color: var(--primary-blue);
}

.text-success-green {
  color: var(--success-green);
}

.bg-success-green {
  background-color: var(--success-green);
}

.border-primary-blue {
  border-color: var(--primary-blue);
}

.hover\:bg-primary-blue:hover {
  background-color: var(--primary-blue);
}

.hover\:text-primary-blue:hover {
  color: var(--primary-blue);
}

@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

@keyframes fadeInRight {
  from {
    opacity: 0;
    transform: translateX(30px);
  }
  to {
    opacity: 1;
    transform: translateX(0);
  }
}

.animate-fade-in-up {
  animation: fadeInUp 0.8s ease-out forwards;
}

.animate-fade-in-right {
  animation: fadeInRight 0.8s ease-out forwards;
}
</style>