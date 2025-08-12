<template>
  <div class="mobile-contact-premium">
    <!-- Background Effects -->
    <div class="background-effects">
      <div class="gradient-orb orb-1"></div>
      <div class="gradient-orb orb-2"></div>
      <div class="floating-particles">
        <div v-for="n in 15" :key="n" class="particle" :style="{
          left: Math.random() * 100 + '%',
          animationDelay: Math.random() * 5 + 's',
          animationDuration: (3 + Math.random() * 4) + 's'
        }"></div>
      </div>
    </div>

    <!-- Header -->
    <div class="mobile-header">
      <div class="header-decoration">
        <div class="decoration-line"></div>
        <div class="header-badge">
          <span class="material-icons">diamond</span>
        </div>
        <div class="decoration-line"></div>
      </div>
      <h1 class="header-title">
        <span class="title-text">PERSÖNLICHE</span>
        <span class="title-text gradient-text">BERATUNG</span>
      </h1>
      <p class="header-subtitle">Lassen Sie sich von unseren Experten beraten</p>
    </div>

    <!-- Progress Indicator -->
    <div class="progress-container">
      <div class="progress-track">
        <div class="progress-fill" :style="{ width: progressWidth }"></div>
      </div>
      <div class="progress-dots">
        <div v-for="step in totalSteps" :key="step" 
             :class="['progress-dot', { 
               'active': step === currentStep, 
               'completed': step < currentStep 
             }]">
          <span v-if="step < currentStep" class="material-icons">check</span>
          <span v-else>{{ step }}</span>
        </div>
      </div>
      <div class="step-label">{{ getStepLabel(currentStep) }}</div>
    </div>

    <!-- Form Container -->
    <div class="form-container">
      <!-- Step 1: Personal Data -->
      <transition name="slide-fade" mode="out-in">
        <div v-if="currentStep === 1" class="form-step" key="step1">
          <div class="step-icon">
            <span class="material-icons">person</span>
          </div>
          <h2 class="step-title">Kontaktdaten</h2>
          <p class="step-subtitle">Wie dürfen wir Sie erreichen?</p>

          <div class="form-fields">
            <!-- Name Fields -->
            <div class="name-row">
              <div class="form-group half-width" :class="{ 'error': errors.firstName, 'success': formData.firstName && !errors.firstName }">
                <label for="firstName">
                  <span class="material-icons">badge</span>
                  Vorname *
                </label>
                <div class="input-container">
                  <input 
                    type="text" 
                    id="firstName" 
                    v-model="formData.firstName"
                    @input="validateField('firstName')"
                    @focus="handleFocus('firstName')"
                    @blur="handleBlur('firstName')"
                    placeholder="Vorname"
                    :class="{ 'error': errors.firstName, 'success': formData.firstName && !errors.firstName }"
                  >
                  <div class="input-highlight"></div>
                </div>
                <transition name="error-slide">
                  <div v-if="errors.firstName" class="error-message">
                    <span class="material-icons">error</span>
                    {{ getErrorMessage('firstName') }}
                  </div>
                </transition>
              </div>

              <div class="form-group half-width" :class="{ 'error': errors.lastName, 'success': formData.lastName && !errors.lastName }">
                <label for="lastName">
                  <span class="material-icons">badge</span>
                  Nachname *
                </label>
                <div class="input-container">
                  <input 
                    type="text" 
                    id="lastName" 
                    v-model="formData.lastName"
                    @input="validateField('lastName')"
                    @focus="handleFocus('lastName')"
                    @blur="handleBlur('lastName')"
                    placeholder="Nachname"
                    :class="{ 'error': errors.lastName, 'success': formData.lastName && !errors.lastName }"
                  >
                  <div class="input-highlight"></div>
                </div>
                <transition name="error-slide">
                  <div v-if="errors.lastName" class="error-message">
                    <span class="material-icons">error</span>
                    {{ getErrorMessage('lastName') }}
                  </div>
                </transition>
              </div>
            </div>

            <!-- Email -->
            <div class="form-group" :class="{ 'error': errors.email, 'success': formData.email && !errors.email }">
              <label for="email">
                <span class="material-icons">email</span>
                E-Mail-Adresse *
              </label>
              <div class="input-container">
                <input 
                  type="email" 
                  id="email" 
                  v-model="formData.email"
                  @input="validateField('email')"
                  @focus="handleFocus('email')"
                  @blur="handleBlur('email')"
                  placeholder="ihre.email@beispiel.de"
                  :class="{ 'error': errors.email, 'success': formData.email && !errors.email }"
                >
                <div class="input-highlight"></div>
              </div>
              <transition name="error-slide">
                <div v-if="errors.email" class="error-message">
                  <span class="material-icons">error</span>
                  {{ getErrorMessage('email') }}
                </div>
              </transition>
            </div>

            <!-- Phone -->
            <div class="form-group" :class="{ 'error': errors.phone, 'success': formData.phone && !errors.phone }">
              <label for="phone">
                <span class="material-icons">phone</span>
                Telefonnummer *
              </label>
              <div class="phone-input-row">
                <div class="country-select-container">
                  <select v-model="formData.countryCode" class="country-select">
                    <option value="+49">🇩🇪 +49</option>
                    <option value="+43">🇦🇹 +43</option>
                    <option value="+41">🇨🇭 +41</option>
                  </select>
                </div>
                <div class="input-container flex-1">
                  <input 
                    type="tel" 
                    id="phone" 
                    v-model="formData.phone"
                    @input="validateField('phone')"
                    @focus="handleFocus('phone')"
                    @blur="handleBlur('phone')"
                    placeholder="0123 456789"
                    :class="{ 'error': errors.phone, 'success': formData.phone && !errors.phone }"
                  >
                  <div class="input-highlight"></div>
                </div>
              </div>
              <transition name="error-slide">
                <div v-if="errors.phone" class="error-message">
                  <span class="material-icons">error</span>
                  {{ getErrorMessage('phone') }}
                </div>
              </transition>
            </div>

            <!-- Company -->
            <div class="form-group">
              <label for="company">
                <span class="material-icons">business</span>
                Unternehmen (optional)
              </label>
              <div class="input-container">
                <input 
                  type="text" 
                  id="company" 
                  v-model="formData.company"
                  @focus="handleFocus('company')"
                  @blur="handleBlur('company')"
                  placeholder="Ihr Unternehmen"
                >
                <div class="input-highlight"></div>
              </div>
            </div>
          </div>
        </div>
      </transition>

      <!-- Step 2: Project Details -->
      <transition name="slide-fade" mode="out-in">
        <div v-if="currentStep === 2" class="form-step" key="step2">
          <div class="step-icon">
            <span class="material-icons">home_work</span>
          </div>
          <h2 class="step-title">Projektdetails</h2>
          <p class="step-subtitle">Erzählen Sie uns von Ihrem Vorhaben</p>

          <div class="form-fields">
            <!-- Project Type -->
            <div class="form-group" :class="{ 'error': errors.projectType, 'success': formData.projectType && !errors.projectType }">
              <label for="projectType">
                <span class="material-icons">construction</span>
                Projekttyp *
              </label>
              <div class="select-container">
                <select 
                  id="projectType"
                  v-model="formData.projectType"
                  @change="validateField('projectType')"
                  :class="{ 'error': errors.projectType, 'success': formData.projectType && !errors.projectType }"
                >
                  <option value="">Bitte wählen...</option>
                  <option value="Neubau">Neubau</option>
                  <option value="Renovierung">Renovierung</option>
                  <option value="Sanierung">Sanierung</option>
                  <option value="Erweiterung">Erweiterung</option>
                </select>
                <span class="select-arrow material-icons">expand_more</span>
              </div>
              <transition name="error-slide">
                <div v-if="errors.projectType" class="error-message">
                  <span class="material-icons">error</span>
                  {{ getErrorMessage('projectType') }}
                </div>
              </transition>
            </div>

            <!-- Room -->
            <div class="form-group" :class="{ 'error': errors.room, 'success': formData.room && !errors.room }">
              <label for="room">
                <span class="material-icons">room</span>
                Bereich *
              </label>
              <div class="select-container">
                <select 
                  id="room"
                  v-model="formData.room"
                  @change="validateField('room')"
                  :class="{ 'error': errors.room, 'success': formData.room && !errors.room }"
                >
                  <option value="">Bitte wählen...</option>
                  <option value="Wohnzimmer">Wohnzimmer</option>
                  <option value="Küche">Küche</option>
                  <option value="Badezimmer">Badezimmer</option>
                  <option value="Schlafzimmer">Schlafzimmer</option>
                  <option value="Terrasse/Balkon">Terrasse/Balkon</option>
                  <option value="Treppe">Treppe</option>
                  <option value="Gesamtes Haus">Gesamtes Haus</option>
                  <option value="Sonstiges">Sonstiges</option>
                </select>
                <span class="select-arrow material-icons">expand_more</span>
              </div>
              <transition name="error-slide">
                <div v-if="errors.room" class="error-message">
                  <span class="material-icons">error</span>
                  {{ getErrorMessage('room') }}
                </div>
              </transition>
            </div>

            <!-- Size -->
            <div class="form-group" :class="{ 'error': errors.size, 'success': formData.size && !errors.size }">
              <label for="size">
                <span class="material-icons">square_foot</span>
                Ungefähre Fläche in m² *
              </label>
              <div class="input-container">
                <input 
                  type="number" 
                  id="size" 
                  v-model="formData.size"
                  @input="validateField('size')"
                  @focus="handleFocus('size')"
                  @blur="handleBlur('size')"
                  placeholder="z.B. 25"
                  min="1"
                  max="10000"
                  :class="{ 'error': errors.size, 'success': formData.size && !errors.size }"
                >
                <div class="input-suffix">m²</div>
                <div class="input-highlight"></div>
              </div>
              <transition name="error-slide">
                <div v-if="errors.size" class="error-message">
                  <span class="material-icons">error</span>
                  {{ getErrorMessage('size') }}
                </div>
              </transition>
            </div>

            <!-- Timeline -->
            <div class="form-group">
              <label for="timeline">
                <span class="material-icons">schedule</span>
                Gewünschter Zeitrahmen (optional)
              </label>
              <div class="select-container">
                <select id="timeline" v-model="formData.timeline">
                  <option value="">Keine Angabe</option>
                  <option value="sofort">So schnell wie möglich</option>
                  <option value="1-monat">Innerhalb 1 Monat</option>
                  <option value="3-monate">Innerhalb 3 Monate</option>
                  <option value="6-monate">Innerhalb 6 Monate</option>
                  <option value="planung">Noch in Planung</option>
                </select>
                <span class="select-arrow material-icons">expand_more</span>
              </div>
            </div>

            <!-- Message -->
            <div class="form-group">
              <label for="message">
                <span class="material-icons">message</span>
                Ihre Nachricht (optional)
              </label>
              <div class="textarea-container">
                <textarea 
                  id="message" 
                  v-model="formData.message"
                  @focus="handleFocus('message')"
                  @blur="handleBlur('message')"
                  rows="4"
                  placeholder="Beschreiben Sie Ihr Projekt oder stellen Sie Fragen..."
                ></textarea>
                <div class="textarea-highlight"></div>
              </div>
            </div>
          </div>
        </div>
      </transition>

      <!-- Step 3: Summary -->
      <transition name="slide-fade" mode="out-in">
        <div v-if="currentStep === 3" class="form-step" key="step3">
          <div class="step-icon">
            <span class="material-icons">check_circle</span>
          </div>
          <h2 class="step-title">Zusammenfassung</h2>
          <p class="step-subtitle">Bitte überprüfen Sie Ihre Angaben</p>

          <div class="summary-container">
            <!-- Personal Data Summary -->
            <div class="summary-card">
              <div class="summary-header">
                <div class="header-left">
                  <span class="material-icons">person</span>
                  <h3>Kontaktdaten</h3>
                </div>
                <button @click="goToStep(1)" class="edit-btn">
                  <span class="material-icons">edit</span>
                </button>
              </div>
              <div class="summary-content">
                <div class="summary-row">
                  <span class="label">Name:</span>
                  <span class="value">{{ formData.firstName }} {{ formData.lastName }}</span>
                </div>
                <div class="summary-row">
                  <span class="label">E-Mail:</span>
                  <span class="value">{{ formData.email }}</span>
                </div>
                <div class="summary-row">
                  <span class="label">Telefon:</span>
                  <span class="value">{{ formData.countryCode }} {{ formData.phone }}</span>
                </div>
                <div v-if="formData.company" class="summary-row">
                  <span class="label">Unternehmen:</span>
                  <span class="value">{{ formData.company }}</span>
                </div>
              </div>
            </div>

            <!-- Project Data Summary -->
            <div class="summary-card">
              <div class="summary-header">
                <div class="header-left">
                  <span class="material-icons">home_work</span>
                  <h3>Projektdetails</h3>
                </div>
                <button @click="goToStep(2)" class="edit-btn">
                  <span class="material-icons">edit</span>
                </button>
              </div>
              <div class="summary-content">
                <div class="summary-row">
                  <span class="label">Projekttyp:</span>
                  <span class="value">{{ formData.projectType }}</span>
                </div>
                <div class="summary-row">
                  <span class="label">Bereich:</span>
                  <span class="value">{{ formData.room }}</span>
                </div>
                <div class="summary-row">
                  <span class="label">Fläche:</span>
                  <span class="value">{{ formData.size }} m²</span>
                </div>
                <div v-if="formData.timeline" class="summary-row">
                  <span class="label">Zeitrahmen:</span>
                  <span class="value">{{ getTimelineLabel(formData.timeline) }}</span>
                </div>
                <div v-if="formData.message" class="summary-row">
                  <span class="label">Nachricht:</span>
                  <span class="value message-preview">{{ formData.message }}</span>
                </div>
              </div>
            </div>

            <!-- Privacy -->
            <div class="privacy-card">
              <div class="checkbox-container">
                <label class="checkbox-wrapper" @click="togglePrivacy">
                  <input type="checkbox" v-model="privacyAccepted" @change="validatePrivacy">
                  <span class="checkmark">
                    <span class="material-icons">check</span>
                  </span>
                  <span class="checkbox-text">
                    Ich habe die <a href="/datenschutz" target="_blank" @click.stop>Datenschutzerklärung</a> gelesen und akzeptiere diese.*
                  </span>
                </label>
              </div>
              <transition name="error-slide">
                <div v-if="errors.privacy" class="error-message">
                  <span class="material-icons">error</span>
                  {{ getErrorMessage('privacy') }}
                </div>
              </transition>
            </div>
          </div>
        </div>
      </transition>
    </div>

    <!-- Navigation -->
    <div class="navigation-container">
      <button 
        v-if="currentStep > 1"
        @click="previousStep"
        class="nav-btn back-btn"
      >
        <span class="material-icons">arrow_back</span>
        Zurück
      </button>

      <button 
        v-if="currentStep < totalSteps"
        @click="nextStep"
        :disabled="!canProceed"
        class="nav-btn next-btn"
      >
        Weiter
        <span class="material-icons">arrow_forward</span>
      </button>

      <button 
        v-if="currentStep === totalSteps"
        @click="submitForm"
        :disabled="isSubmitting || !canSubmit"
        class="nav-btn submit-btn"
      >
        <span v-if="!isSubmitting" class="submit-content">
          <span class="material-icons">send</span>
          Absenden
        </span>
        <div v-else class="submit-loading">
          <div class="loading-spinner"></div>
          Wird gesendet...
        </div>
      </button>
    </div>

    <!-- Success Modal -->
    <transition name="modal-fade">
      <div v-if="showSuccessModal" class="success-modal-overlay" @click="closeSuccessModal">
        <div class="success-modal" @click.stop>
          <div class="success-animation">
            <div class="success-circle">
              <span class="material-icons">check</span>
            </div>
            <div class="success-ripples">
              <div class="ripple"></div>
              <div class="ripple"></div>
              <div class="ripple"></div>
            </div>
          </div>
          <h3>Vielen Dank!</h3>
          <p>Ihre Anfrage wurde erfolgreich übermittelt. Wir melden uns innerhalb von 24 Stunden bei Ihnen.</p>
          <button @click="closeSuccessModal" class="success-close-btn">
            Schließen
          </button>
        </div>
      </div>
    </transition>
  </div>
</template>

<script setup>
import { ref, reactive, computed } from 'vue'

// State Management
const currentStep = ref(1)
const totalSteps = 3
const isSubmitting = ref(false)
const showSuccessModal = ref(false)
const privacyAccepted = ref(false)
const focusedField = ref(null)

// Form Data - Same structure as luxury-contact-form
const formData = reactive({
  firstName: '',
  lastName: '',
  email: '',
  phone: '',
  countryCode: '+49',
  company: '',
  projectType: '',
  room: '',
  size: '',
  timeline: '',
  message: ''
})

// Error Management
const errors = reactive({
  firstName: false,
  lastName: false,
  email: false,
  phone: false,
  projectType: false,
  room: false,
  size: false,
  privacy: false
})

const errorMessages = {
  firstName: 'Bitte geben Sie einen gültigen Vornamen ein (mindestens 2 Zeichen)',
  lastName: 'Bitte geben Sie einen gültigen Nachnamen ein (mindestens 2 Zeichen)',
  email: 'Bitte geben Sie eine gültige E-Mail-Adresse ein',
  phone: 'Bitte geben Sie eine gültige Telefonnummer ein (mindestens 5 Ziffern)',
  projectType: 'Bitte wählen Sie einen Projekttyp aus',
  room: 'Bitte wählen Sie einen Bereich aus',
  size: 'Bitte geben Sie eine gültige Fläche ein (1-10000 m²)',
  privacy: 'Bitte akzeptieren Sie die Datenschutzerklärung'
}

// Computed Properties
const progressWidth = computed(() => {
  return `${(currentStep.value / totalSteps) * 100}%`
})

const canProceed = computed(() => {
  switch (currentStep.value) {
    case 1:
      return formData.firstName && formData.lastName && formData.email && formData.phone && 
             !errors.firstName && !errors.lastName && !errors.email && !errors.phone
    case 2:
      return formData.projectType && formData.room && formData.size && 
             !errors.projectType && !errors.room && !errors.size
    case 3:
      return true
    default:
      return true
  }
})

const canSubmit = computed(() => {
  return privacyAccepted.value && !errors.privacy && 
         formData.firstName && formData.lastName && formData.email && formData.phone &&
         formData.projectType && formData.room && formData.size &&
         !errors.firstName && !errors.lastName && !errors.email && !errors.phone &&
         !errors.projectType && !errors.room && !errors.size
})

// Helper Functions
const getStepLabel = (step) => {
  const labels = {
    1: 'Kontaktdaten',
    2: 'Projektdetails', 
    3: 'Bestätigung'
  }
  return labels[step] || ''
}

const getTimelineLabel = (timeline) => {
  const labels = {
    'sofort': 'So schnell wie möglich',
    '1-monat': 'Innerhalb 1 Monat',
    '3-monate': 'Innerhalb 3 Monate',
    '6-monate': 'Innerhalb 6 Monate',
    'planung': 'Noch in Planung'
  }
  return labels[timeline] || timeline
}

const getErrorMessage = (field) => {
  return errorMessages[field] || 'Fehler'
}

// Validation Functions
const validateField = (field) => {
  switch (field) {
    case 'firstName':
    case 'lastName':
      errors[field] = !formData[field] || !/^[A-Za-zÄÖÜäöüß\s-]{2,}$/.test(formData[field])
      break
    case 'email':
      errors[field] = !formData[field] || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(formData[field])
      break
    case 'phone':
      errors[field] = !formData[field] || !/^\d{5,}$/.test(formData[field])
      break
    case 'projectType':
    case 'room':
      errors[field] = !formData[field]
      break
    case 'size':
      const size = parseInt(formData[field])
      errors[field] = !formData[field] || isNaN(size) || size < 1 || size > 10000
      break
  }
  
  // Haptic feedback on mobile
  if (navigator.vibrate && errors[field]) {
    navigator.vibrate(50)
  }
}

const validatePrivacy = () => {
  errors.privacy = !privacyAccepted.value
}

// Event Handlers
const handleFocus = (field) => {
  focusedField.value = field
  // Light haptic feedback
  if (navigator.vibrate) {
    navigator.vibrate(10)
  }
}

const handleBlur = (field) => {
  focusedField.value = null
  if (['firstName', 'lastName', 'email', 'phone', 'size'].includes(field)) {
    validateField(field)
  }
}

const togglePrivacy = () => {
  privacyAccepted.value = !privacyAccepted.value
  validatePrivacy()
  if (navigator.vibrate) {
    navigator.vibrate(20)
  }
}

// Navigation Functions
const nextStep = () => {
  if (canProceed.value && currentStep.value < totalSteps) {
    currentStep.value++
    // Haptic feedback
    if (navigator.vibrate) {
      navigator.vibrate(30)
    }
  }
}

const previousStep = () => {
  if (currentStep.value > 1) {
    currentStep.value--
    if (navigator.vibrate) {
      navigator.vibrate(20)
    }
  }
}

const goToStep = (step) => {
  if (step >= 1 && step <= totalSteps) {
    currentStep.value = step
    if (navigator.vibrate) {
      navigator.vibrate(20)
    }
  }
}

// Form Submission
const submitForm = async () => {
  // Final validation
  validatePrivacy()
  Object.keys(formData).forEach(key => {
    if (['firstName', 'lastName', 'email', 'phone', 'projectType', 'room', 'size'].includes(key)) {
      validateField(key)
    }
  })
  
  if (!canSubmit.value) {
    if (navigator.vibrate) {
      navigator.vibrate(100)
    }
    return
  }
  
  isSubmitting.value = true
  
  try {
    // Simulate API call
    await new Promise(resolve => setTimeout(resolve, 2000))
    
    console.log('Form submitted:', formData)
    
    showSuccessModal.value = true
    
    // Haptic success feedback
    if (navigator.vibrate) {
      navigator.vibrate([100, 50, 100])
    }
    
    // Reset form after successful submission
    setTimeout(() => {
      resetForm()
    }, 3000)
    
  } catch (error) {
    console.error('Error submitting form:', error)
    alert('Es ist ein Fehler aufgetreten. Bitte versuchen Sie es erneut.')
    if (navigator.vibrate) {
      navigator.vibrate(200)
    }
  } finally {
    isSubmitting.value = false
  }
}

const resetForm = () => {
  Object.keys(formData).forEach(key => {
    if (typeof formData[key] === 'string') {
      formData[key] = ''
    }
  })
  formData.countryCode = '+49'
  
  Object.keys(errors).forEach(key => {
    errors[key] = false
  })
  
  privacyAccepted.value = false
  currentStep.value = 1
}

const closeSuccessModal = () => {
  showSuccessModal.value = false
}
</script>

<style scoped>
@import url('https://fonts.googleapis.com/icon?family=Material+Icons');

.mobile-contact-premium {
  min-height: 100vh;
  background: linear-gradient(135deg, #0a0a0a 0%, #1a1a1a 50%, #0f0f0f 100%);
  color: #FAFAF8;
  position: relative;
  overflow: hidden;
  padding: 0;
}

/* Background Effects */
.background-effects {
  position: fixed;
  inset: 0;
  pointer-events: none;
  z-index: 1;
}

.gradient-orb {
  position: absolute;
  border-radius: 50%;
  filter: blur(80px);
  opacity: 0.3;
  animation: orbFloat 8s ease-in-out infinite;
}

.orb-1 {
  width: 200px;
  height: 200px;
  background: radial-gradient(circle, #a47148, transparent);
  top: 10%;
  left: -10%;
}

.orb-2 {
  width: 300px;
  height: 300px;
  background: radial-gradient(circle, #FAFAF8, transparent);
  bottom: 10%;
  right: -15%;
  animation-delay: -4s;
}

@keyframes orbFloat {
  0%, 100% { transform: translateY(0) scale(1); }
  50% { transform: translateY(-30px) scale(1.1); }
}

.floating-particles {
  position: absolute;
  inset: 0;
}

.particle {
  position: absolute;
  width: 3px;
  height: 3px;
  background: #a47148;
  border-radius: 50%;
  animation: particleFloat 6s linear infinite;
}

@keyframes particleFloat {
  0% {
    transform: translateY(100vh) rotate(0deg);
    opacity: 0;
  }
  10% {
    opacity: 1;
  }
  90% {
    opacity: 1;
  }
  100% {
    transform: translateY(-100px) rotate(360deg);
    opacity: 0;
  }
}

/* Header */
.mobile-header {
  padding: 3rem 1.5rem 2rem;
  text-align: center;
  position: relative;
  z-index: 2;
}

.header-decoration {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 1rem;
  margin-bottom: 2rem;
}

.decoration-line {
  width: 60px;
  height: 1px;
  background: linear-gradient(90deg, transparent, #a47148, transparent);
}

.header-badge {
  padding: 0.5rem 1rem;
  background: linear-gradient(135deg, rgba(164, 113, 72, 0.2), rgba(255, 255, 255, 0.05));
  border: 1px solid rgba(164, 113, 72, 0.3);
  border-radius: 50px;
  backdrop-filter: blur(20px);
  animation: badgeGlow 3s ease-in-out infinite;
}

.header-badge .material-icons {
  color: #a47148;
  font-size: 1.2rem;
}

@keyframes badgeGlow {
  0%, 100% { box-shadow: 0 0 0 rgba(164, 113, 72, 0.5); }
  50% { box-shadow: 0 0 20px rgba(164, 113, 72, 0.4); }
}

.header-title {
  font-size: 2rem;
  font-weight: 300;
  line-height: 1.2;
  margin-bottom: 1rem;
}

.title-text {
  display: block;
}

.gradient-text {
  background: linear-gradient(135deg, #FAFAF8 0%, #a47148 50%, #FAFAF8 100%);
  background-size: 200% 100%;
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  animation: titleShimmer 4s ease-in-out infinite;
}

@keyframes titleShimmer {
  0%, 100% { background-position: 200% 0; }
  50% { background-position: -200% 0; }
}

.header-subtitle {
  font-size: 1rem;
  color: #ccc;
  font-weight: 300;
}

/* Progress Indicator */
.progress-container {
  padding: 2rem 1.5rem;
  position: relative;
  z-index: 2;
}

.progress-track {
  height: 4px;
  background: rgba(255, 255, 255, 0.1);
  border-radius: 2px;
  overflow: hidden;
  margin-bottom: 1.5rem;
}

.progress-fill {
  height: 100%;
  background: linear-gradient(90deg, #a47148, #FAFAF8);
  transition: width 0.5s cubic-bezier(0.4, 0, 0.2, 1);
  box-shadow: 0 0 10px rgba(164, 113, 72, 0.5);
}

.progress-dots {
  display: flex;
  justify-content: space-between;
  margin-bottom: 1rem;
}

.progress-dot {
  width: 36px;
  height: 36px;
  background: rgba(255, 255, 255, 0.1);
  border: 2px solid rgba(255, 255, 255, 0.2);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 0.875rem;
  font-weight: 600;
  transition: all 0.4s ease;
  color: #ccc;
}

.progress-dot.active {
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  border-color: #a47148;
  color: #000;
  transform: scale(1.15);
  box-shadow: 0 0 20px rgba(164, 113, 72, 0.6);
}

.progress-dot.completed {
  background: #a47148;
  border-color: #a47148;
  color: #FAFAF8;
}

.progress-dot .material-icons {
  font-size: 1rem;
}

.step-label {
  text-align: center;
  font-size: 0.875rem;
  color: #a47148;
  font-weight: 500;
}

/* Form Container */
.form-container {
  padding: 0 1.5rem;
  position: relative;
  z-index: 2;
  min-height: 60vh;
}

.form-step {
  background: linear-gradient(135deg, rgba(255, 255, 255, 0.05) 0%, rgba(255, 255, 255, 0.02) 100%);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 20px;
  padding: 2rem 1.5rem;
  backdrop-filter: blur(20px);
  position: relative;
  overflow: hidden;
}

.step-icon {
  width: 60px;
  height: 60px;
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 1.5rem;
  animation: iconPulse 2s ease-in-out infinite;
}

.step-icon .material-icons {
  font-size: 1.8rem;
  color: #000;
}

@keyframes iconPulse {
  0%, 100% { transform: scale(1); }
  50% { transform: scale(1.05); }
}

.step-title {
  font-size: 1.5rem;
  font-weight: 400;
  text-align: center;
  margin-bottom: 0.5rem;
  background: linear-gradient(135deg, #FAFAF8 0%, #a47148 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.step-subtitle {
  font-size: 0.95rem;
  color: #ccc;
  text-align: center;
  margin-bottom: 2rem;
  line-height: 1.5;
}

/* Form Fields */
.form-fields {
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
}

.name-row {
  display: flex;
  gap: 1rem;
}

.form-group {
  position: relative;
}

.form-group.half-width {
  flex: 1;
}

.form-group label {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  margin-bottom: 0.75rem;
  font-weight: 500;
  color: #FAFAF8;
  font-size: 0.9rem;
}

.form-group label .material-icons {
  color: #a47148;
  font-size: 1.1rem;
}

.input-container,
.textarea-container {
  position: relative;
}

.input-container.flex-1 {
  flex: 1;
}

.form-group input,
.form-group textarea {
  width: 100%;
  background: rgba(255, 255, 255, 0.05);
  border: 2px solid rgba(255, 255, 255, 0.1);
  border-radius: 12px;
  color: #FAFAF8;
  padding: 1rem;
  font-size: 1rem;
  transition: all 0.3s ease;
  outline: none;
}

.form-group input:focus,
.form-group textarea:focus {
  border-color: #a47148;
  background: rgba(255, 255, 255, 0.08);
  box-shadow: 0 0 20px rgba(164, 113, 72, 0.3);
}

.form-group input.success {
  border-color: #4CAF50;
  box-shadow: 0 0 15px rgba(76, 175, 80, 0.2);
}

.form-group input.error,
.form-group textarea.error {
  border-color: #e74c3c;
  box-shadow: 0 0 15px rgba(231, 76, 60, 0.2);
  animation: inputShake 0.5s ease-in-out;
}

@keyframes inputShake {
  0%, 100% { transform: translateX(0); }
  25% { transform: translateX(-5px); }
  75% { transform: translateX(5px); }
}

.input-highlight,
.textarea-highlight {
  position: absolute;
  inset: 0;
  border-radius: 12px;
  background: linear-gradient(45deg, transparent, rgba(164, 113, 72, 0.3), transparent);
  opacity: 0;
  transition: opacity 0.3s ease;
  pointer-events: none;
}

.form-group.success .input-highlight {
  background: linear-gradient(45deg, transparent, rgba(76, 175, 80, 0.3), transparent);
  opacity: 1;
}

.input-suffix {
  position: absolute;
  right: 1rem;
  top: 50%;
  transform: translateY(-50%);
  color: #a47148;
  font-weight: 500;
  pointer-events: none;
}

/* Phone Input */
.phone-input-row {
  display: flex;
  gap: 1rem;
  align-items: stretch;
}

.country-select-container {
  flex: 0 0 100px;
}

.country-select {
  width: 100%;
  background: rgba(255, 255, 255, 0.05);
  border: 2px solid rgba(255, 255, 255, 0.1);
  border-radius: 12px;
  color: #FAFAF8;
  padding: 1rem 0.75rem;
  font-size: 0.85rem;
  outline: none;
  cursor: pointer;
}

/* Select Styling */
.select-container {
  position: relative;
}

.form-group select {
  width: 100%;
  background: rgba(255, 255, 255, 0.05);
  border: 2px solid rgba(255, 255, 255, 0.1);
  border-radius: 12px;
  color: #FAFAF8;
  padding: 1rem;
  font-size: 1rem;
  outline: none;
  cursor: pointer;
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
}

.form-group select:focus {
  border-color: #a47148;
  background: rgba(255, 255, 255, 0.08);
  box-shadow: 0 0 20px rgba(164, 113, 72, 0.3);
}

.form-group select.success {
  border-color: #4CAF50;
  box-shadow: 0 0 15px rgba(76, 175, 80, 0.2);
}

.form-group select.error {
  border-color: #e74c3c;
  box-shadow: 0 0 15px rgba(231, 76, 60, 0.2);
}

.select-arrow {
  position: absolute;
  right: 1rem;
  top: 50%;
  transform: translateY(-50%);
  color: #a47148;
  pointer-events: none;
  transition: transform 0.3s ease;
}

.form-group select:focus + .select-arrow {
  transform: translateY(-50%) rotate(180deg);
}

/* Textarea */
.form-group textarea {
  resize: vertical;
  min-height: 100px;
  font-family: inherit;
}

/* Error Messages */
.error-message {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  color: #e74c3c;
  font-size: 0.8rem;
  margin-top: 0.5rem;
  animation: errorSlideDown 0.3s ease-out;
}

@keyframes errorSlideDown {
  from {
    opacity: 0;
    transform: translateY(-10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.error-message .material-icons {
  font-size: 0.9rem;
}

/* Summary */
.summary-container {
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
}

.summary-card {
  background: rgba(255, 255, 255, 0.03);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 16px;
  padding: 1.5rem;
  transition: all 0.3s ease;
}

.summary-card:hover {
  background: rgba(255, 255, 255, 0.05);
  transform: translateY(-2px);
}

.summary-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 1rem;
  padding-bottom: 1rem;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.header-left {
  display: flex;
  align-items: center;
  gap: 0.75rem;
}

.summary-header .material-icons {
  color: #a47148;
  font-size: 1.3rem;
}

.summary-header h3 {
  font-size: 1.1rem;
  font-weight: 500;
  color: #FAFAF8;
}

.edit-btn {
  width: 36px;
  height: 36px;
  background: transparent;
  border: 2px solid rgba(164, 113, 72, 0.3);
  border-radius: 50%;
  color: #a47148;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.3s ease;
}

.edit-btn:hover,
.edit-btn:active {
  background: rgba(164, 113, 72, 0.1);
  border-color: #a47148;
  transform: scale(1.1);
}

.edit-btn .material-icons {
  font-size: 1rem;
}

.summary-content {
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
}

.summary-row {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  gap: 1rem;
}

.summary-row .label {
  color: #ccc;
  font-size: 0.9rem;
  min-width: 80px;
  flex-shrink: 0;
}

.summary-row .value {
  color: #FAFAF8;
  text-align: right;
  font-size: 0.9rem;
  flex: 1;
}

.message-preview {
  text-align: left !important;
  font-style: italic;
  line-height: 1.4;
  font-size: 0.85rem !important;
  color: #ccc !important;
}

/* Privacy */
.privacy-card {
  background: rgba(164, 113, 72, 0.05);
  border: 1px solid rgba(164, 113, 72, 0.2);
  border-radius: 16px;
  padding: 1.5rem;
}

.checkbox-container {
  display: flex;
  align-items: flex-start;
}

.checkbox-wrapper {
  display: flex;
  align-items: flex-start;
  gap: 1rem;
  cursor: pointer;
  width: 100%;
}

.checkbox-wrapper input[type="checkbox"] {
  display: none;
}

.checkmark {
  width: 20px;
  height: 20px;
  border: 2px solid rgba(255, 255, 255, 0.3);
  border-radius: 4px;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.3s ease;
  flex-shrink: 0;
  margin-top: 2px;
}

.checkmark .material-icons {
  font-size: 14px;
  color: #FAFAF8;
  opacity: 0;
  transform: scale(0);
  transition: all 0.3s ease;
}

.checkbox-wrapper input:checked + .checkmark {
  background: #a47148;
  border-color: #a47148;
  box-shadow: 0 0 15px rgba(164, 113, 72, 0.4);
}

.checkbox-wrapper input:checked + .checkmark .material-icons {
  opacity: 1;
  transform: scale(1);
}

.checkbox-text {
  color: #ccc;
  line-height: 1.4;
  font-size: 0.85rem;
}

.checkbox-text a {
  color: #a47148;
  text-decoration: none;
  border-bottom: 1px solid transparent;
  transition: border-color 0.3s ease;
}

.checkbox-text a:hover {
  border-bottom-color: #a47148;
}

/* Navigation */
.navigation-container {
  padding: 2rem 1.5rem;
  display: flex;
  gap: 1rem;
  position: relative;
  z-index: 2;
}

.nav-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  padding: 1rem;
  font-size: 0.95rem;
  font-weight: 600;
  border-radius: 12px;
  cursor: pointer;
  transition: all 0.3s ease;
  border: none;
  flex: 1;
  min-height: 50px;
}

.back-btn {
  background: transparent;
  color: #FAFAF8;
  border: 2px solid rgba(255, 255, 255, 0.3);
}

.back-btn:hover,
.back-btn:active {
  border-color: #FAFAF8;
  background: rgba(255, 255, 255, 0.1);
  transform: translateY(-2px);
}

.next-btn,
.submit-btn {
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  color: #000;
}

.next-btn:hover:not(:disabled),
.submit-btn:hover:not(:disabled) {
  transform: translateY(-2px);
  box-shadow: 0 8px 20px rgba(164, 113, 72, 0.4);
}

.nav-btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
  transform: none !important;
  box-shadow: none !important;
}

.submit-content,
.submit-loading {
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.loading-spinner {
  width: 18px;
  height: 18px;
  border: 2px solid rgba(0, 0, 0, 0.3);
  border-radius: 50%;
  border-top-color: #000;
  animation: spin 0.8s linear infinite;
}

@keyframes spin {
  to { transform: rotate(360deg); }
}

/* Success Modal */
.success-modal-overlay {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.95);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
  backdrop-filter: blur(20px);
  padding: 2rem;
}

.success-modal {
  background: linear-gradient(135deg, #1a1a1a 0%, #0a0a0a 100%);
  border-radius: 20px;
  padding: 2.5rem 2rem;
  text-align: center;
  max-width: 400px;
  width: 100%;
  border: 1px solid rgba(255, 255, 255, 0.1);
  position: relative;
}

.success-animation {
  position: relative;
  margin-bottom: 2rem;
}

.success-circle {
  width: 80px;
  height: 80px;
  background: linear-gradient(135deg, #4CAF50, #8BC34A);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto;
  animation: successScale 0.6s ease-out;
}

@keyframes successScale {
  0% { transform: scale(0); }
  50% { transform: scale(1.2); }
  100% { transform: scale(1); }
}

.success-circle .material-icons {
  font-size: 2.5rem;
  color: #FAFAF8;
}

.success-ripples {
  position: absolute;
  inset: -40px;
}

.ripple {
  position: absolute;
  inset: 0;
  border: 2px solid #4CAF50;
  border-radius: 50%;
  animation: rippleExpand 2s ease-out infinite;
}

.ripple:nth-child(2) { animation-delay: 0.5s; }
.ripple:nth-child(3) { animation-delay: 1s; }

@keyframes rippleExpand {
  0% {
    transform: scale(0.8);
    opacity: 1;
  }
  100% {
    transform: scale(2);
    opacity: 0;
  }
}

.success-modal h3 {
  font-size: 1.5rem;
  font-weight: 400;
  margin-bottom: 1rem;
  color: #4CAF50;
}

.success-modal p {
  font-size: 0.95rem;
  color: #ccc;
  line-height: 1.5;
  margin-bottom: 2rem;
}

.success-close-btn {
  background: linear-gradient(135deg, #4CAF50, #8BC34A);
  color: #FAFAF8;
  border: none;
  padding: 0.75rem 2rem;
  border-radius: 12px;
  font-size: 1rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
}

.success-close-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 20px rgba(76, 175, 80, 0.4);
}

/* Transitions */
.slide-fade-enter-active,
.slide-fade-leave-active {
  transition: all 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

.slide-fade-enter-from {
  opacity: 0;
  transform: translateX(30px) scale(0.95);
}

.slide-fade-leave-to {
  opacity: 0;
  transform: translateX(-30px) scale(0.95);
}

.error-slide-enter-active,
.error-slide-leave-active {
  transition: all 0.3s ease;
}

.error-slide-enter-from,
.error-slide-leave-to {
  opacity: 0;
  transform: translateY(-10px);
}

.modal-fade-enter-active,
.modal-fade-leave-active {
  transition: opacity 0.4s ease;
}

.modal-fade-enter-from,
.modal-fade-leave-to {
  opacity: 0;
}

.modal-fade-enter-active .success-modal,
.modal-fade-leave-active .success-modal {
  transition: transform 0.4s ease;
}

.modal-fade-enter-from .success-modal,
.modal-fade-leave-to .success-modal {
  transform: scale(0.8) rotateX(-15deg);
}

/* Responsive Adjustments */
@media (max-width: 480px) {
  .mobile-header {
    padding: 2rem 1rem 1.5rem;
  }
  
  .header-title {
    font-size: 1.75rem;
  }
  
  .progress-container {
    padding: 1.5rem 1rem;
  }
  
  .form-container {
    padding: 0 1rem;
  }
  
  .form-step {
    padding: 1.5rem 1rem;
  }
  
  .name-row {
    flex-direction: column;
    gap: 1rem;
  }
  
  .phone-input-row {
    flex-direction: column;
    gap: 1rem;
  }
  
  .country-select-container {
    flex: none;
  }
  
  .navigation-container {
    padding: 1.5rem 1rem;
  }
  
  .summary-row {
    flex-direction: column;
    gap: 0.25rem;
    align-items: flex-start;
  }
  
  .summary-row .value {
    text-align: left;
  }
  
  .success-modal {
    padding: 2rem 1.5rem;
    margin: 1rem;
  }
}

@media (max-width: 360px) {
  .header-title {
    font-size: 1.5rem;
  }
  
  .step-title {
    font-size: 1.25rem;
  }
  
  .form-group label {
    font-size: 0.85rem;
  }
  
  .form-group input,
  .form-group textarea,
  .form-group select {
    padding: 0.875rem;
    font-size: 0.95rem;
  }
}
</style>