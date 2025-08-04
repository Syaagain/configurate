<template>
  <div>
    <!-- Hero Section -->
    <section class="gradient-bg hero-pattern">
      <div class="container-custom py-24">
        <div class="max-w-4xl mx-auto text-center text-white">
          <h1 class="text-4xl md:text-6xl font-bold mb-6">
            Kontakt <span class="text-success-400">aufnehmen</span>
          </h1>
          <p class="text-xl mb-8 text-blue-100 leading-relaxed">
            Bereit für optimierte Prozesse? Lassen Sie uns über Ihre Herausforderungen sprechen. 
            Die Erstberatung ist kostenlos und unverbindlich.
          </p>
        </div>
      </div>
    </section>

    <!-- Contact Form Section -->
    <section class="section-padding">
      <div class="container-custom">
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-16">
          
          <!-- Contact Form -->
          <div>
            <div class="mb-8">
              <h2 class="text-3xl font-bold mb-4">Kostenlose Erstberatung vereinbaren</h2>
              <p class="text-neutral-600 text-lg">
                Füllen Sie das Formular aus und wir melden uns innerhalb von 24 Stunden bei Ihnen.
              </p>
            </div>

            <form @submit.prevent="submitForm" class="space-y-6">
              <!-- Personal Info -->
              <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div>
                  <label for="firstName" class="block text-sm font-medium text-neutral-700 mb-2">
                    Vorname *
                  </label>
                  <input
                    type="text"
                    id="firstName"
                    v-model="form.firstName"
                    required
                    class="w-full px-4 py-3 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 transition-colors"
                    placeholder="Max"
                  >
                </div>
                <div>
                  <label for="lastName" class="block text-sm font-medium text-neutral-700 mb-2">
                    Nachname *
                  </label>
                  <input
                    type="text"
                    id="lastName"
                    v-model="form.lastName"
                    required
                    class="w-full px-4 py-3 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 transition-colors"
                    placeholder="Mustermann"
                  >
                </div>
              </div>

              <!-- Contact Info -->
              <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div>
                  <label for="email" class="block text-sm font-medium text-neutral-700 mb-2">
                    E-Mail-Adresse *
                  </label>
                  <input
                    type="email"
                    id="email"
                    v-model="form.email"
                    required
                    class="w-full px-4 py-3 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 transition-colors"
                    placeholder="max.mustermann@unternehmen.de"
                  >
                </div>
                <div>
                  <label for="phone" class="block text-sm font-medium text-neutral-700 mb-2">
                    Telefon
                  </label>
                  <input
                    type="tel"
                    id="phone"
                    v-model="form.phone"
                    class="w-full px-4 py-3 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 transition-colors"
                    placeholder="+49 123 456 789"
                  >
                </div>
              </div>

              <!-- Company Info -->
              <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div>
                  <label for="company" class="block text-sm font-medium text-neutral-700 mb-2">
                    Unternehmen *
                  </label>
                  <input
                    type="text"
                    id="company"
                    v-model="form.company"
                    required
                    class="w-full px-4 py-3 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 transition-colors"
                    placeholder="Muster GmbH"
                  >
                </div>
                <div>
                  <label for="employees" class="block text-sm font-medium text-neutral-700 mb-2">
                    Mitarbeiteranzahl
                  </label>
                  <select
                    id="employees"
                    v-model="form.employees"
                    class="w-full px-4 py-3 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 transition-colors"
                  >
                    <option value="">Bitte wählen</option>
                    <option value="1-10">1-10 Mitarbeiter</option>
                    <option value="11-50">11-50 Mitarbeiter</option>
                    <option value="51-200">51-200 Mitarbeiter</option>
                    <option value="201-500">201-500 Mitarbeiter</option>
                    <option value="500+">Über 500 Mitarbeiter</option>
                  </select>
                </div>
              </div>

              <!-- Service Interest -->
              <div>
                <label class="block text-sm font-medium text-neutral-700 mb-3">
                  Interessensbereich *
                </label>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-3">
                  <label class="flex items-center space-x-3 p-3 border border-neutral-200 rounded-lg hover:border-primary-300 cursor-pointer transition-colors">
                    <input
                      type="checkbox"
                      v-model="form.interests"
                      value="prozessoptimierung"
                      class="w-4 h-4 text-primary-600 border-neutral-300 rounded focus:ring-primary-500"
                    >
                    <span>Prozessoptimierung</span>
                  </label>
                  <label class="flex items-center space-x-3 p-3 border border-neutral-200 rounded-lg hover:border-primary-300 cursor-pointer transition-colors">
                    <input
                      type="checkbox"
                      v-model="form.interests"
                      value="automatisierung"
                      class="w-4 h-4 text-primary-600 border-neutral-300 rounded focus:ring-primary-500"
                    >
                    <span>Automatisierung</span>
                  </label>
                  <label class="flex items-center space-x-3 p-3 border border-neutral-200 rounded-lg hover:border-primary-300 cursor-pointer transition-colors">
                    <input
                      type="checkbox"
                      v-model="form.interests"
                      value="webentwicklung"
                      class="w-4 h-4 text-primary-600 border-neutral-300 rounded focus:ring-primary-500"
                    >
                    <span>Webentwicklung</span>
                  </label>
                  <label class="flex items-center space-x-3 p-3 border border-neutral-200 rounded-lg hover:border-primary-300 cursor-pointer transition-colors">
                    <input
                      type="checkbox"
                      v-model="form.interests"
                      value="beratung"
                      class="w-4 h-4 text-primary-600 border-neutral-300 rounded focus:ring-primary-500"
                    >
                    <span>Strategische Beratung</span>
                  </label>
                </div>
              </div>

              <!-- Message -->
              <div>
                <label for="message" class="block text-sm font-medium text-neutral-700 mb-2">
                  Ihre Nachricht
                </label>
                <textarea
                  id="message"
                  v-model="form.message"
                  rows="5"
                  class="w-full px-4 py-3 border border-neutral-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 transition-colors"
                  placeholder="Beschreiben Sie kurz Ihre Herausforderungen oder Ziele..."
                ></textarea>
              </div>

              <!-- Privacy -->
              <div class="flex items-start space-x-3">
                <input
                  type="checkbox"
                  id="privacy"
                  v-model="form.privacy"
                  required
                  class="w-4 h-4 text-primary-600 border-neutral-300 rounded focus:ring-primary-500 mt-1"
                >
                <label for="privacy" class="text-sm text-neutral-600">
                  Ich stimme der <NuxtLink to="/datenschutz" class="text-primary-600 hover:text-primary-800">Datenschutzerklärung</NuxtLink> zu und bin damit einverstanden, dass meine Daten zur Bearbeitung meiner Anfrage gespeichert werden. *
                </label>
              </div>

              <!-- Submit Button -->
              <button
                type="submit"
                :disabled="isSubmitting"
                class="w-full btn-primary text-lg py-4 disabled:opacity-50 disabled:cursor-not-allowed"
              >
                <span v-if="!isSubmitting">Erstberatung anfragen</span>
                <span v-else>Wird gesendet...</span>
              </button>
            </form>
          </div>

          <!-- Contact Info & Benefits -->
          <div class="space-y-8">
            <!-- Contact Info -->
            <div class="card">
              <h3 class="text-xl font-semibold mb-6">Kontaktinformationen</h3>
              <div class="space-y-4">
                <div class="flex items-start space-x-3">
                  <MapPinIcon class="w-5 h-5 text-primary-600 mt-1 flex-shrink-0" />
                  <div>
                    <div class="font-medium">Configuraid GmbH</div>
                    <div class="text-neutral-600">Musterstraße 123</div>
                    <div class="text-neutral-600">12345 Musterstadt</div>
                  </div>
                </div>
                
                <div class="flex items-center space-x-3">
                  <PhoneIcon class="w-5 h-5 text-primary-600 flex-shrink-0" />
                  <a href="tel:+49123456789" class="text-neutral-600 hover:text-primary-600 transition-colors">
                    +49 (0) 123 456 789
                  </a>
                </div>
                
                <div class="flex items-center space-x-3">
                  <EnvelopeIcon class="w-5 h-5 text-primary-600 flex-shrink-0" />
                  <a href="mailto:info@configuraid.de" class="text-neutral-600 hover:text-primary-600 transition-colors">
                    info@configuraid.de
                  </a>
                </div>
                
                <div class="flex items-center space-x-3">
                  <ClockIcon class="w-5 h-5 text-primary-600 flex-shrink-0" />
                  <div class="text-neutral-600">
                    <div>Mo - Fr: 9:00 - 18:00 Uhr</div>
                    <div class="text-sm">Termine auch außerhalb der Geschäftszeiten möglich</div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Benefits -->
            <div class="card">
              <h3 class="text-xl font-semibold mb-6">Was Sie erwartet</h3>
              <div class="space-y-4">
                <div class="flex items-start space-x-3">
                  <CheckCircleIcon class="w-5 h-5 text-success-600 mt-1 flex-shrink-0" />
                  <div>
                    <div class="font-medium">Kostenlose Erstberatung</div>
                    <div class="text-neutral-600 text-sm">30-45 Minuten unverbindliches Gespräch</div>
                  </div>
                </div>
                
                <div class="flex items-start space-x-3">
                  <CheckCircleIcon class="w-5 h-5 text-success-600 mt-1 flex-shrink-0" />
                  <div>
                    <div class="font-medium">Schnelle Antwort</div>
                    <div class="text-neutral-600 text-sm">Rückmeldung innerhalb von 24 Stunden</div>
                  </div>
                </div>
                
                <div class="flex items-start space-x-3">
                  <CheckCircleIcon class="w-5 h-5 text-success-600 mt-1 flex-shrink-0" />
                  <div>
                    <div class="font-medium">Individuelle Beratung</div>
                    <div class="text-neutral-600 text-sm">Maßgeschneidert für Ihre Situation</div>
                  </div>
                </div>
                
                <div class="flex items-start space-x-3">
                  <CheckCircleIcon class="w-5 h-5 text-success-600 mt-1 flex-shrink-0" />
                  <div>
                    <div class="font-medium">Flexible Terminplanung</div>
                    <div class="text-neutral-600 text-sm">Vor Ort, online oder telefonisch</div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Social Proof -->
            <div class="card bg-primary-50 border-primary-100">
              <div class="text-center">
                <div class="text-3xl font-bold text-primary-900 mb-2">98%</div>
                <div class="text-sm text-primary-700 mb-4">Kundenzufriedenheit</div>
                <div class="text-sm text-primary-600">
                  "Die Beratung von Configuraid war der Schlüssel zu unserem Erfolg."
                </div>
                <div class="text-xs text-primary-500 mt-2">
                  - Über 50 zufriedene Kunden
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- FAQ Section -->
    <section class="section-padding bg-neutral-50">
      <div class="container-custom">
        <div class="text-center mb-12">
          <h2 class="text-3xl md:text-4xl font-bold mb-6">
            Häufig gestellte <span class="gradient-text">Fragen</span>
          </h2>
        </div>

        <div class="max-w-3xl mx-auto space-y-4">
          <div
            v-for="(faq, index) in faqs"
            :key="index"
            class="card"
          >
            <button
              @click="toggleFaq(index)"
              class="w-full text-left flex items-center justify-between"
            >
              <h3 class="font-semibold">{{ faq.question }}</h3>
              <ChevronDownIcon
                class="w-5 h-5 text-neutral-500 transition-transform"
                :class="{ 'rotate-180': faq.open }"
              />
            </button>
            <div
              v-show="faq.open"
              class="mt-4 text-neutral-600"
              v-html="faq.answer"
            ></div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
import { ref, reactive } from 'vue'
import {
  MapPinIcon,
  PhoneIcon,
  EnvelopeIcon,
  ClockIcon,
  CheckCircleIcon,
  ChevronDownIcon
} from '@heroicons/vue/24/outline'

// SEO
useHead({
  title: 'Kontakt - Kostenlose Erstberatung | Configuraid',
  meta: [
    { name: 'description', content: 'Kontaktieren Sie uns für eine kostenlose Erstberatung zur Prozessoptimierung. Schnelle Antwort innerhalb von 24 Stunden.' }
  ]
})

// Form state
const form = reactive({
  firstName: '',
  lastName: '',
  email: '',
  phone: '',
  company: '',
  employees: '',
  interests: [],
  message: '',
  privacy: false
})

const isSubmitting = ref(false)

// Form submission
const submitForm = async () => {
  if (!form.privacy) {
    alert('Bitte stimmen Sie der Datenschutzerklärung zu.')
    return
  }
  
  if (form.interests.length === 0) {
    alert('Bitte wählen Sie mindestens einen Interessensbereich aus.')
    return
  }

  isSubmitting.value = true
  
  // Simulate form submission
  setTimeout(() => {
    alert('Vielen Dank für Ihre Anfrage! Wir melden uns innerhalb von 24 Stunden bei Ihnen.')
    
    // Reset form
    Object.keys(form).forEach(key => {
      if (Array.isArray(form[key])) {
        form[key] = []
      } else if (typeof form[key] === 'boolean') {
        form[key] = false
      } else {
        form[key] = ''
      }
    })
    
    isSubmitting.value = false
  }, 1500)
}

// FAQ
const faqs = ref([
  {
    question: 'Wie läuft die kostenlose Erstberatung ab?',
    answer: 'In einem 30-45 minütigen Gespräch (vor Ort, online oder telefonisch) analysieren wir Ihre aktuelle Situation und identifizieren erste Optimierungspotentiale. Sie erhalten konkrete Handlungsempfehlungen – völlig unverbindlich.',
    open: false
  },
  {
    question: 'Wie schnell können Sie mit der Umsetzung beginnen?',
    answer: 'Je nach Projektumfang können wir meist innerhalb von 2-4 Wochen nach Projektstart mit der Analyse beginnen. Kleinere Optimierungen lassen sich oft schon während der Analysephase umsetzen.',
    open: false
  },
  {
    question: 'Arbeiten Sie auch mit kleinen Unternehmen?',
    answer: 'Ja, wir arbeiten mit Unternehmen aller Größen zusammen – von Start-ups bis hin zu Konzernen. Unsere Lösungen skalieren entsprechend Ihrer Anforderungen und Ihres Budgets.',
    open: false
  },
  {
    question: 'Wie messen Sie den Erfolg der Optimierung?',
    answer: 'Wir definieren gemeinsam klare KPIs wie Durchlaufzeiten, Fehlerquoten oder Kosteneinsparungen. Diese werden vor und nach der Optimierung gemessen, so dass der Erfolg quantifizierbar ist.',
    open: false
  },
  {
    question: 'Bieten Sie auch Schulungen für unsere Mitarbeiter an?',
    answer: 'Ja, Change Management und Mitarbeiterschulungen sind ein wichtiger Bestandteil unserer Projekte. Wir sorgen dafür, dass Ihr Team die neuen Prozesse versteht und optimal nutzen kann.',
    open: false
  }
])

const toggleFaq = (index) => {
  faqs.value[index].open = !faqs.value[index].open
}
</script>