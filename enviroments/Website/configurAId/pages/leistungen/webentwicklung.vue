<template>
  <div>
    <!-- Hero Section -->
    <section class="gradient-bg hero-pattern relative overflow-hidden">
      <div class="container-custom py-24">
        <div class="max-w-4xl mx-auto text-center text-white">
          <h1 class="text-4xl md:text-6xl font-bold mb-6">
            <span class="text-success-400">Moderne</span> Webentwicklung
          </h1>
          <p class="text-xl mb-8 text-blue-100 leading-relaxed">
            Performante, responsive und benutzerfreundliche Weblösungen, die Ihre 
            Geschäftsprozesse optimal unterstützen und Ihre Kunden begeistern.
          </p>
          <div class="flex flex-col sm:flex-row gap-4 justify-center">
            <NuxtLink to="/kontakt" class="btn bg-success-600 text-white hover:bg-success-700 text-lg px-8 py-4">
              Projekt besprechen
            </NuxtLink>
            <button @click="scrollToPortfolio" class="btn-secondary bg-white/10 border-white/30 text-white hover:bg-white/20">
              Portfolio ansehen
            </button>
          </div>
        </div>
      </div>
    </section>

    <!-- Services Overview -->
    <section class="section-padding">
      <div class="container-custom">
        <div class="text-center mb-16">
          <h2 class="text-3xl md:text-4xl font-bold mb-6">
            Unsere <span class="gradient-text">Web-Services</span>
          </h2>
          <p class="text-xl text-neutral-600 max-w-3xl mx-auto">
            Von der Konzeption bis zur Wartung – wir bieten alle Leistungen aus einer Hand.
          </p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          <div class="card card-hover group">
            <div class="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center mb-4 group-hover:bg-blue-600 transition-colors duration-300">
              <GlobeAltIcon class="w-6 h-6 text-blue-600 group-hover:text-white transition-colors duration-300" />
            </div>
            <h3 class="text-xl font-semibold mb-3">Corporate Websites</h3>
            <p class="text-neutral-600 mb-4 leading-relaxed">
              Professionelle Unternehmenswebsites, die Vertrauen schaffen und 
              Ihre Marke optimal präsentieren.
            </p>
            <ul class="text-sm text-neutral-600 space-y-1">
              <li>• Responsive Design</li>
              <li>• SEO-Optimierung</li>
              <li>• Content Management</li>
              <li>• Performance-Optimierung</li>
            </ul>
          </div>

          <div class="card card-hover group">
            <div class="w-12 h-12 bg-green-100 rounded-lg flex items-center justify-center mb-4 group-hover:bg-green-600 transition-colors duration-300">
              <ShoppingCartIcon class="w-6 h-6 text-green-600 group-hover:text-white transition-colors duration-300" />
            </div>
            <h3 class="text-xl font-semibold mb-3">E-Commerce Lösungen</h3>
            <p class="text-neutral-600 mb-4 leading-relaxed">
              Vollständige Online-Shops mit modernem Design und 
              leistungsstarken Funktionen für maximale Conversions.
            </p>
            <ul class="text-sm text-neutral-600 space-y-1">
              <li>• Shopware/WooCommerce</li>
              <li>• Payment Integration</li>
              <li>• Inventory Management</li>
              <li>• Analytics & Reporting</li>
            </ul>
          </div>

          <div class="card card-hover group">
            <div class="w-12 h-12 bg-purple-100 rounded-lg flex items-center justify-center mb-4 group-hover:bg-purple-600 transition-colors duration-300">
              <CommandLineIcon class="w-6 h-6 text-purple-600 group-hover:text-white transition-colors duration-300" />
            </div>
            <h3 class="text-xl font-semibold mb-3">Web-Applikationen</h3>
            <p class="text-neutral-600 mb-4 leading-relaxed">
              Maßgeschneiderte Web-Apps für komplexe Geschäftsprozesse 
              und interne Workflows.
            </p>
            <ul class="text-sm text-neutral-600 space-y-1">
              <li>• Custom Development</li>
              <li>• API Integrationen</li>
              <li>• User Management</li>
              <li>• Real-time Features</li>
            </ul>
          </div>

          <div class="card card-hover group">
            <div class="w-12 h-12 bg-orange-100 rounded-lg flex items-center justify-center mb-4 group-hover:bg-orange-600 transition-colors duration-300">
              <DevicePhoneMobileIcon class="w-6 h-6 text-orange-600 group-hover:text-white transition-colors duration-300" />
            </div>
            <h3 class="text-xl font-semibold mb-3">Progressive Web Apps</h3>
            <p class="text-neutral-600 mb-4 leading-relaxed">
              App-ähnliche Erlebnisse im Browser mit Offline-Funktionalität 
              und Push-Benachrichtigungen.
            </p>
            <ul class="text-sm text-neutral-600 space-y-1">
              <li>• Offline-First Design</li>
              <li>• Push Notifications</li>
              <li>• App-like Experience</li>
              <li>• Cross-Platform</li>
            </ul>
          </div>

          <div class="card card-hover group">
            <div class="w-12 h-12 bg-red-100 rounded-lg flex items-center justify-center mb-4 group-hover:bg-red-600 transition-colors duration-300">
              <CloudIcon class="w-6 h-6 text-red-600 group-hover:text-white transition-colors duration-300" />
            </div>
            <h3 class="text-xl font-semibold mb-3">Cloud-Integration</h3>
            <p class="text-neutral-600 mb-4 leading-relaxed">
              Sichere und skalierbare Cloud-Lösungen für moderne 
              Webanwendungen und Datenmanagement.
            </p>
            <ul class="text-sm text-neutral-600 space-y-1">
              <li>• AWS/Azure Integration</li>
              <li>• Serverless Architecture</li>
              <li>• Auto-Scaling</li>
              <li>• Backup & Security</li>
            </ul>
          </div>

          <div class="card card-hover group">
            <div class="w-12 h-12 bg-indigo-100 rounded-lg flex items-center justify-center mb-4 group-hover:bg-indigo-600 transition-colors duration-300">
              <WrenchScrewdriverIcon class="w-6 h-6 text-indigo-600 group-hover:text-white transition-colors duration-300" />
            </div>
            <h3 class="text-xl font-semibold mb-3">Wartung & Support</h3>
            <p class="text-neutral-600 mb-4 leading-relaxed">
              Kontinuierliche Betreuung, Updates und Optimierungen 
              für langfristig erfolgreiche Web-Präsenzen.
            </p>
            <ul class="text-sm text-neutral-600 space-y-1">
              <li>• 24/7 Monitoring</li>
              <li>• Security Updates</li>
              <li>• Performance Monitoring</li>
              <li>• Content Updates</li>
            </ul>
          </div>
        </div>
      </div>
    </section>

    <!-- Technology Stack -->
    <section class="section-padding bg-neutral-50">
      <div class="container-custom">
        <div class="text-center mb-16">
          <h2 class="text-3xl md:text-4xl font-bold mb-6">
            Modernste <span class="gradient-text">Technologien</span>
          </h2>
          <p class="text-xl text-neutral-600 max-w-3xl mx-auto">
            Wir setzen auf bewährte und innovative Technologien für 
            performante und zukunftssichere Weblösungen.
          </p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-12">
          <!-- Frontend -->
          <div>
            <h3 class="text-xl font-semibold mb-6 text-center">Frontend</h3>
            <div class="space-y-4">
              <div class="flex items-center space-x-3 p-3 bg-white rounded-lg">
                <div class="w-8 h-8 bg-blue-100 rounded flex items-center justify-center">
                  <span class="text-xs font-bold text-blue-600">R</span>
                </div>
                <div>
                  <div class="font-medium">React/Next.js</div>
                  <div class="text-xs text-neutral-500">Modern JavaScript Framework</div>
                </div>
              </div>
              
              <div class="flex items-center space-x-3 p-3 bg-white rounded-lg">
                <div class="w-8 h-8 bg-green-100 rounded flex items-center justify-center">
                  <span class="text-xs font-bold text-green-600">V</span>
                </div>
                <div>
                  <div class="font-medium">Vue.js/Nuxt.js</div>
                  <div class="text-xs text-neutral-500">Progressive Framework</div>
                </div>
              </div>
              
              <div class="flex items-center space-x-3 p-3 bg-white rounded-lg">
                <div class="w-8 h-8 bg-purple-100 rounded flex items-center justify-center">
                  <span class="text-xs font-bold text-purple-600">T</span>
                </div>
                <div>
                  <div class="font-medium">TypeScript</div>
                  <div class="text-xs text-neutral-500">Type-safe JavaScript</div>
                </div>
              </div>
              
              <div class="flex items-center space-x-3 p-3 bg-white rounded-lg">
                <div class="w-8 h-8 bg-blue-100 rounded flex items-center justify-center">
                  <span class="text-xs font-bold text-blue-600">TW</span>
                </div>
                <div>
                  <div class="font-medium">Tailwind CSS</div>
                  <div class="text-xs text-neutral-500">Utility-first CSS</div>
                </div>
              </div>
            </div>
          </div>

          <!-- Backend -->
          <div>
            <h3 class="text-xl font-semibold mb-6 text-center">Backend</h3>
            <div class="space-y-4">
              <div class="flex items-center space-x-3 p-3 bg-white rounded-lg">
                <div class="w-8 h-8 bg-green-100 rounded flex items-center justify-center">
                  <span class="text-xs font-bold text-green-600">N</span>
                </div>
                <div>
                  <div class="font-medium">Node.js</div>
                  <div class="text-xs text-neutral-500">JavaScript Runtime</div>
                </div>
              </div>
              
              <div class="flex items-center space-x-3 p-3 bg-white rounded-lg">
                <div class="w-8 h-8 bg-blue-100 rounded flex items-center justify-center">
                  <span class="text-xs font-bold text-blue-600">P</span>
                </div>
                <div>
                  <div class="font-medium">Python/Django</div>
                  <div class="text-xs text-neutral-500">Rapid Development</div>
                </div>
              </div>
              
              <div class="flex items-center space-x-3 p-3 bg-white rounded-lg">
                <div class="w-8 h-8 bg-purple-100 rounded flex items-center justify-center">
                  <span class="text-xs font-bold text-purple-600">P</span>
                </div>
                <div>
                  <div class="font-medium">PHP/Laravel</div>
                  <div class="text-xs text-neutral-500">Web Artisans Framework</div>
                </div>
              </div>
              
              <div class="flex items-center space-x-3 p-3 bg-white rounded-lg">
                <div class="w-8 h-8 bg-gray-100 rounded flex items-center justify-center">
                  <span class="text-xs font-bold text-gray-600">API</span>
                </div>
                <div>
                  <div class="font-medium">REST/GraphQL</div>
                  <div class="text-xs text-neutral-500">API Development</div>
                </div>
              </div>
            </div>
          </div>

          <!-- Infrastructure -->
          <div>
            <h3 class="text-xl font-semibold mb-6 text-center">Infrastructure</h3>
            <div class="space-y-4">
              <div class="flex items-center space-x-3 p-3 bg-white rounded-lg">
                <div class="w-8 h-8 bg-orange-100 rounded flex items-center justify-center">
                  <span class="text-xs font-bold text-orange-600">AWS</span>
                </div>
                <div>
                  <div class="font-medium">Amazon Web Services</div>
                  <div class="text-xs text-neutral-500">Cloud Platform</div>
                </div>
              </div>
              
              <div class="flex items-center space-x-3 p-3 bg-white rounded-lg">
                <div class="w-8 h-8 bg-blue-100 rounded flex items-center justify-center">
                  <span class="text-xs font-bold text-blue-600">AZ</span>
                </div>
                <div>
                  <div class="font-medium">Microsoft Azure</div>
                  <div class="text-xs text-neutral-500">Enterprise Cloud</div>
                </div>
              </div>
              
              <div class="flex items-center space-x-3 p-3 bg-white rounded-lg">
                <div class="w-8 h-8 bg-blue-100 rounded flex items-center justify-center">
                  <span class="text-xs font-bold text-blue-600">D</span>
                </div>
                <div>
                  <div class="font-medium">Docker</div>
                  <div class="text-xs text-neutral-500">Containerization</div>
                </div>
              </div>
              
              <div class="flex items-center space-x-3 p-3 bg-white rounded-lg">
                <div class="w-8 h-8 bg-green-100 rounded flex items-center justify-center">
                  <span class="text-xs font-bold text-green-600">K8s</span>
                </div>
                <div>
                  <div class="font-medium">Kubernetes</div>
                  <div class="text-xs text-neutral-500">Container Orchestration</div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Development Process -->
    <section class="section-padding">
      <div class="container-custom">
        <div class="text-center mb-16">
          <h2 class="text-3xl md-text-4xl font-bold mb-6">
            Unser <span class="gradient-text">Entwicklungsprozess</span>
          </h2>
          <p class="text-xl text-neutral-600 max-w-3xl mx-auto">
            Agile Entwicklung mit kontinuierlicher Kommunikation und transparentem Projektmanagement.
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
                <h3 class="text-2xl font-bold">Discovery & Planung</h3>
              </div>
              <p class="text-neutral-600 mb-6 text-lg leading-relaxed">
                Wir analysieren Ihre Anforderungen, definieren Ziele und erstellen 
                ein detailliertes Konzept mit Wireframes und technischer Architektur.
              </p>
              <ul class="space-y-3">
                <li class="flex items-start space-x-3">
                  <CheckCircleIcon class="w-5 h-5 text-success-600 mt-1 flex-shrink-0" />
                  <span>Requirements-Analyse und Stakeholder-Interviews</span>
                </li>
                <li class="flex items-start space-x-3">
                  <CheckCircleIcon class="w-5 h-5 text-success-600 mt-1 flex-shrink-0" />
                  <span>User Experience Design und Wireframing</span>
                </li>
                <li class="flex items-start space-x-3">
                  <CheckCircleIcon class="w-5 h-5 text-success-600 mt-1 flex-shrink-0" />
                  <span>Technische Architektur und Projektplanung</span>
                </li>
              </ul>
            </div>
            <div class="lg:w-1/2">
              <div class="bg-neutral-50 rounded-2xl p-8">
                <div class="grid grid-cols-2 gap-4">
                  <div class="bg-white rounded-lg p-4 text-center">
                    <div class="text-2xl font-bold text-primary-900 mb-1">1-2</div>
                    <div class="text-sm text-primary-700">Wochen</div>
                  </div>
                  <div class="bg-white rounded-lg p-4 text-center">
                    <div class="text-2xl font-bold text-primary-900 mb-1">100%</div>
                    <div class="text-sm text-primary-700">Transparenz</div>
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
                <h3 class="text-2xl font-bold">Design & Prototyping</h3>
              </div>
              <p class="text-neutral-600 mb-6 text-lg leading-relaxed">
                Entwicklung von ansprechenden Designs und interaktiven Prototypen 
                für optimale User Experience und Conversion-Optimierung.
              </p>
              <ul class="space-y-3">
                <li class="flex items-start space-x-3">
                  <CheckCircleIcon class="w-5 h-5 text-success-600 mt-1 flex-shrink-0" />
                  <span>Visual Design und Corporate Identity</span>
                </li>
                <li class="flex items-start space-x-3">
                  <CheckCircleIcon class="w-5 h-5 text-success-600 mt-1 flex-shrink-0" />
                  <span>Interactive Prototypes und Usability Testing</span>
                </li>
                <li class="flex items-start space-x-3">
                  <CheckCircleIcon class="w-5 h-5 text-success-600 mt-1 flex-shrink-0" />
                  <span>Responsive Design für alle Geräte</span>
                </li>
              </ul>
            </div>
            <div class="lg:w-1/2">
              <div class="bg-neutral-50 rounded-2xl p-8">
                <div class="space-y-4">
                  <div class="flex items-center justify-between p-3 bg-white rounded-lg">
                    <span class="font-medium">Mockups</span>
                    <CheckIcon class="w-5 h-5 text-success-600" />
                  </div>
                  <div class="flex items-center justify-between p-3 bg-white rounded-lg">
                    <span class="font-medium">Prototyp</span>
                    <CheckIcon class="w-5 h-5 text-success-600" />
                  </div>
                  <div class="flex items-center justify-between p-3 bg-white rounded-lg">
                    <span class="font-medium">User Testing</span>
                    <div class="w-3 h-3 bg-primary-600 rounded-full"></div>
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
                <h3 class="text-2xl font-bold">Entwicklung & Testing</h3>
              </div>
              <p class="text-neutral-600 mb-6 text-lg leading-relaxed">
                Agile Entwicklung mit regelmäßigen Updates, kontinuierlichen Tests 
                und enger Abstimmung für optimale Ergebnisse.
              </p>
              <ul class="space-y-3">
                <li class="flex items-start space-x-3">
                  <CheckCircleIcon class="w-5 h-5 text-success-600 mt-1 flex-shrink-0" />
                  <span>Agile Entwicklung in 2-Wochen-Sprints</span>
                </li>
                <li class="flex items-start space-x-3">
                  <CheckCircleIcon class="w-5 h-5 text-success-600 mt-1 flex-shrink-0" />
                  <span>Automatisierte Tests und Quality Assurance</span>
                </li>
                <li class="flex items-start space-x-3">
                  <CheckCircleIcon class="w-5 h-5 text-success-600 mt-1 flex-shrink-0" />
                  <span>Regelmäßige Demos und Feedback-Zyklen</span>
                </li>
              </ul>
            </div>
            <div class="lg:w-1/2">
              <div class="bg-neutral-50 rounded-2xl p-8">
                <div class="space-y-3">
                  <div class="flex items-center space-x-3">
                    <div class="w-4 h-4 bg-success-500 rounded-full"></div>
                    <span class="text-sm">Sprint 1: Grundfunktionen</span>
                  </div>
                  <div class="flex items-center space-x-3">
                    <div class="w-4 h-4 bg-success-500 rounded-full"></div>
                    <span class="text-sm">Sprint 2: Erweiterte Features</span>
                  </div>
                  <div class="flex items-center space-x-3">
                    <div class="w-4 h-4 bg-primary-200 rounded-full"></div>
                    <span class="text-sm">Sprint 3: Integration & Testing</span>
                  </div>
                  <div class="flex items-center space-x-3">
                    <div class="w-4 h-4 bg-neutral-300 rounded-full"></div>
                    <span class="text-sm">Sprint 4: Polish & Launch</span>
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
                <h3 class="text-2xl font-bold">Launch & Support</h3>
              </div>
              <p class="text-neutral-600 mb-6 text-lg leading-relaxed">
                Erfolgreicher Go-Live mit anschließender Betreuung, Monitoring 
                und kontinuierlicher Optimierung für langfristigen Erfolg.
              </p>
              <ul class="space-y-3">
                <li class="flex items-start space-x-3">
                  <CheckCircleIcon class="w-5 h-5 text-success-600 mt-1 flex-shrink-0" />
                  <span>Deployment und Go-Live Unterstützung</span>
                </li>
                <li class="flex items-start space-x-3">
                  <CheckCircleIcon class="w-5 h-5 text-success-600 mt-1 flex-shrink-0" />
                  <span>Performance Monitoring und Analytics</span>
                </li>
                <li class="flex items-start space-x-3">
                  <CheckCircleIcon class="w-5 h-5 text-success-600 mt-1 flex-shrink-0" />
                  <span>Wartung, Updates und kontinuierliche Optimierung</span>
                </li>
              </ul>
            </div>
            <div class="lg:w-1/2">
              <div class="bg-neutral-50 rounded-2xl p-8">
                <div class="grid grid-cols-2 gap-4">
                  <div class="text-center">
                    <div class="text-3xl font-bold text-success-600 mb-2">99.9%</div>
                    <div class="text-sm text-neutral-600">Uptime</div>
                  </div>
                  <div class="text-center">
                    <div class="text-3xl font-bold text-success-600 mb-2">24/7</div>
                    <div class="text-sm text-neutral-600">Monitoring</div>
                  </div>
                  <div class="text-center">
                    <div class="text-3xl font-bold text-success-600 mb-2"><3s</div>
                    <div class="text-sm text-neutral-600">Ladezeit</div>
                  </div>
                  <div class="text-center">
                    <div class="text-3xl font-bold text-success-600 mb-2">100%</div>
                    <div class="text-sm text-neutral-600">Support</div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Portfolio Section -->
    <section id="portfolio" class="section-padding bg-neutral-50">
      <div class="container-custom">
        <div class="text-center mb-16">
          <h2 class="text-3xl md:text-4xl font-bold mb-6">
            Unser <span class="gradient-text">Portfolio</span>
          </h2>
          <p class="text-xl text-neutral-600 max-w-3xl mx-auto">
            Ausgewählte Projekte, die unsere Expertise und Leidenschaft für 
            exzellente Webentwicklung demonstrieren.
          </p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
          <div
            v-for="project in portfolioProjects"
            :key="project.id"
            class="bg-white rounded-2xl overflow-hidden shadow-xl hover:shadow-2xl transition-shadow duration-300"
          >
            <div class="bg-gradient-to-br from-neutral-200 to-neutral-300 h-48 flex items-center justify-center">
              <component :is="project.icon" class="w-16 h-16 text-neutral-500" />
            </div>
            <div class="p-6">
              <div class="flex items-center justify-between mb-4">
                <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-medium bg-primary-100 text-primary-800">
                  {{ project.category }}
                </span>
                <span class="text-sm text-neutral-500">{{ project.year }}</span>
              </div>
              <h3 class="text-xl font-semibold mb-3">{{ project.title }}</h3>
              <p class="text-neutral-600 mb-4 leading-relaxed">{{ project.description }}</p>
              <div class="flex flex-wrap gap-2 mb-4">
                <span
                  v-for="tech in project.technologies"
                  :key="tech"
                  class="inline-flex items-center px-2 py-1 rounded text-xs font-medium bg-neutral-100 text-neutral-800"
                >
                  {{ tech }}
                </span>
              </div>
              <div class="flex items-center justify-between">
                <div class="text-sm text-neutral-500">
                  {{ project.results }}
                </div>
                <button class="text-primary-600 hover:text-primary-800 font-medium text-sm transition-colors">
                  Details →
                </button>
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
            Lassen Sie uns Ihr Projekt realisieren
          </h2>
          <p class="text-xl mb-8 text-blue-100">
            Von der ersten Idee bis zum erfolgreichen Launch – wir begleiten Sie 
            mit Expertise und Leidenschaft auf dem gesamten Weg.
          </p>
          <div class="flex flex-col sm:flex-row gap-4 justify-center">
            <NuxtLink to="/kontakt" class="btn bg-success-600 text-white hover:bg-success-700 text-lg px-8 py-4">
              Projekt besprechen
            </NuxtLink>
            <NuxtLink to="/referenzen" class="btn-secondary bg-white/10 border-white/30 text-white hover:bg-white/20">
              Weitere Referenzen ansehen
            </NuxtLink>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
import {
  GlobeAltIcon,
  ShoppingCartIcon,
  CommandLineIcon,
  DevicePhoneMobileIcon,
  CloudIcon,
  WrenchScrewdriverIcon,
  CheckCircleIcon,
  CheckIcon
} from '@heroicons/vue/24/outline'

// SEO
useHead({
  title: 'Webentwicklung - Moderne Web-Lösungen | Configuraid',
  meta: [
    { name: 'description', content: 'Professionelle Webentwicklung: Corporate Websites, E-Commerce, Web-Apps. Moderne Technologien, responsive Design, 99.9% Uptime. Kostenlose Beratung.' }
  ]
})

// Portfolio projects
const portfolioProjects = ref([
  {
    id: 1,
    title: 'E-Commerce Platform für Automobilzulieferer',
    description: 'Vollständige B2B E-Commerce Lösung mit Katalogmanagement, individuellen Preisen und ERP-Integration.',
    category: 'E-Commerce',
    year: '2024',
    technologies: ['React', 'Node.js', 'PostgreSQL', 'AWS'],
    results: '+150% Online-Umsatz',
    icon: ShoppingCartIcon
  },
  {
    id: 2,
    title: 'Intranet-Portal für Dienstleistungsunternehmen',
    description: 'Maßgeschneiderte Web-Applikation für Projektmanagement, Zeiterfassung und interne Kommunikation.',
    category: 'Web-App',
    year: '2024',
    technologies: ['Vue.js', 'Python', 'Django', 'PostgreSQL'],
    results: '40% effizientere Prozesse',
    icon: CommandLineIcon
  },
  {
    id: 3,
    title: 'Corporate Website für Beratungsunternehmen',
    description: 'Moderne, responsive Website mit CMS, Blog-System und Lead-Generierung-Funktionen.',
    category: 'Corporate',
    year: '2023',
    technologies: ['Nuxt.js', 'Tailwind', 'Strapi', 'Vercel'],
    results: '+200% Conversion Rate',
    icon: GlobeAltIcon
  },
  {
    id: 4,
    title: 'Progressive Web App für Immobilienverwalter',
    description: 'Mobile-optimierte PWA für Objektverwaltung mit Offline-Funktionalität und Push-Notifications.',
    category: 'PWA',
    year: '2023',
    technologies: ['React', 'PWA', 'IndexedDB', 'Service Worker'],
    results: '60% mobile Nutzung',
    icon: DevicePhoneMobileIcon
  }
])

// Scroll to portfolio
const scrollToPortfolio = () => {
  document.getElementById('portfolio').scrollIntoView({ 
    behavior: 'smooth' 
  })
}
</script>