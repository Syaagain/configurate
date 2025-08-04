<template>
  <footer class="bg-neutral-900 text-white">
    <!-- Hauptbereich -->
    <div class="container-custom py-16">
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
        
        <!-- Unternehmen -->
        <div>
          <div class="flex items-center space-x-3 mb-6">
            <div class="w-10 h-10 bg-gradient-to-br from-primary-600 to-primary-400 rounded-lg flex items-center justify-center">
              <span class="text-white font-bold text-xl">C</span>
            </div>
            <span class="text-2xl font-bold">Configuraid</span>
          </div>
          <p class="text-neutral-300 mb-6 leading-relaxed">
            Ihr Partner für Prozessoptimierung und Automatisierung. Verwandeln Sie komplexe Prozesse in effiziente, automatisierte Workflows.
          </p>
          <div class="flex space-x-4">
            <a href="#" class="text-neutral-400 hover:text-white transition-colors">
              <span class="sr-only">LinkedIn</span>
              <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24">
                <path d="M19 0h-14c-2.761 0-5 2.239-5 5v14c0 2.761 2.239 5 5 5h14c2.762 0 5-2.239 5-5v-14c0-2.761-2.238-5-5-5zm-11 19h-3v-11h3v11zm-1.5-12.268c-.966 0-1.75-.79-1.75-1.764s.784-1.764 1.75-1.764 1.75.79 1.75 1.764-.783 1.764-1.75 1.764zm13.5 12.268h-3v-5.604c0-3.368-4-3.113-4 0v5.604h-3v-11h3v1.765c1.396-2.586 7-2.777 7 2.476v6.759z"/>
              </svg>
            </a>
            <a href="#" class="text-neutral-400 hover:text-white transition-colors">
              <span class="sr-only">XING</span>
              <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24">
                <path d="M18.188 0c-.517 0-.741.325-.927.66 0 0-7.455 13.224-7.702 13.657.015.024 4.919 9.023 4.919 9.023.17.308.436.66.967.66h3.454c.211 0 .375-.078.463-.22.089-.151.089-.346-.009-.536l-4.879-8.916c-.004-.006-.004-.016 0-.022L22.139.756c.095-.191.097-.387.006-.535C22.056.078 21.894 0 21.686 0h-3.498zM3.648 4.74c-.211 0-.385.074-.473.216-.09.149-.078.339.02.531l2.34 4.05c.004.01.004.016 0 .021L1.86 16.051c-.099.188-.093.381 0 .529.085.142.239.234.45.234h3.461c.518 0 .766-.348.945-.667l3.734-6.609-2.378-4.155c-.172-.315-.434-.659-.962-.659H3.648v.016z"/>
              </svg>
            </a>
          </div>
        </div>

        <!-- Leistungen -->
        <div>
          <h3 class="text-lg font-semibold mb-6">Leistungen</h3>
          <ul class="space-y-3">
            <li>
              <NuxtLink to="/leistungen/prozessoptimierung" class="text-neutral-300 hover:text-white transition-colors">
                Prozessoptimierung
              </NuxtLink>
            </li>
            <li>
              <NuxtLink to="/leistungen/automatisierung" class="text-neutral-300 hover:text-white transition-colors">
                Automatisierung
              </NuxtLink>
            </li>
            <li>
              <NuxtLink to="/leistungen/webentwicklung" class="text-neutral-300 hover:text-white transition-colors">
                Webentwicklung
              </NuxtLink>
            </li>
            <li>
              <NuxtLink to="/leistungen/beratung" class="text-neutral-300 hover:text-white transition-colors">
                Beratung
              </NuxtLink>
            </li>
          </ul>
        </div>

        <!-- Unternehmen -->
        <div>
          <h3 class="text-lg font-semibold mb-6">Unternehmen</h3>
          <ul class="space-y-3">
            <li>
              <NuxtLink to="/ueber-uns" class="text-neutral-300 hover:text-white transition-colors">
                Über uns
              </NuxtLink>
            </li>
            <li>
              <NuxtLink to="/referenzen" class="text-neutral-300 hover:text-white transition-colors">
                Referenzen
              </NuxtLink>
            </li>
            <li>
              <NuxtLink to="/blog" class="text-neutral-300 hover:text-white transition-colors">
                Blog
              </NuxtLink>
            </li>
            <li>
              <NuxtLink to="/ueber-uns" class="text-neutral-300 hover:text-white transition-colors">
                Team
              </NuxtLink>
            </li>
          </ul>
        </div>

        <!-- Kontakt -->
        <div>
          <h3 class="text-lg font-semibold mb-6">Kontakt</h3>
          <div class="space-y-4">
            <div>
              <p class="text-neutral-300">Configuraid GmbH</p>
              <p class="text-neutral-400 text-sm">Musterstraße 123</p>
              <p class="text-neutral-400 text-sm">12345 Musterstadt</p>
            </div>
            <div>
              <p class="text-neutral-300">
                <a href="tel:+49123456789" class="hover:text-white transition-colors">
                  +49 (0) 123 456 789
                </a>
              </p>
              <p class="text-neutral-300">
                <a href="mailto:info@configuraid.de" class="hover:text-white transition-colors">
                  info@configuraid.de
                </a>
              </p>
            </div>
            <div class="pt-4">
              <NuxtLink to="/kontakt" class="btn-success">
                Erstberatung vereinbaren
              </NuxtLink>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Newsletter -->
    <div class="border-t border-neutral-800">
      <div class="container-custom py-8">
        <div class="max-w-md mx-auto text-center">
          <h3 class="text-lg font-semibold mb-2">Newsletter abonnieren</h3>
          <p class="text-neutral-400 text-sm mb-4">
            Bleiben Sie auf dem Laufenden über neue Trends in der Prozessoptimierung
          </p>
          <form class="flex gap-2">
            <input 
              type="email" 
              placeholder="Ihre E-Mail-Adresse"
              class="flex-1 px-4 py-2 bg-neutral-800 border border-neutral-700 rounded-lg text-white placeholder-neutral-500 focus:outline-none focus:ring-2 focus:ring-primary-500"
            >
            <button type="submit" class="btn-primary px-6">
              Abonnieren
            </button>
          </form>
        </div>
      </div>
    </div>

    <!-- Copyright -->
    <div class="border-t border-neutral-800">
      <div class="container-custom py-6">
        <div class="flex flex-col md:flex-row justify-between items-center">
          <p class="text-neutral-400 text-sm">
            © {{ new Date().getFullYear() }} Configuraid GmbH. Alle Rechte vorbehalten.
          </p>
          <div class="flex space-x-6 mt-4 md:mt-0">
            <NuxtLink to="/impressum" class="text-neutral-400 hover:text-white text-sm transition-colors">
              Impressum
            </NuxtLink>
            <NuxtLink to="/datenschutz" class="text-neutral-400 hover:text-white text-sm transition-colors">
              Datenschutz
            </NuxtLink>
            <NuxtLink to="/agb" class="text-neutral-400 hover:text-white text-sm transition-colors">
              AGB
            </NuxtLink>
          </div>
        </div>
      </div>
    </div>
  </footer>
</template>

<script setup>
// Footer Component
</script>