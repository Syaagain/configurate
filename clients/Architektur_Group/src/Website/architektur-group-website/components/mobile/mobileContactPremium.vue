<template>
  <div class="mobile-contact-premium">
    <!-- Animated Header -->
    <div class="form-header">
      <div class="header-bg">
        <div class="bg-pattern"></div>
        <div class="bg-gradient"></div>
      </div>
      <div class="header-content">
        <div class="header-icon">
          <span class="material-icons">mail</span>
          <div class="icon-pulse"></div>
        </div>
        <h1 class="header-title">Kontakt aufnehmen</h1>
        <p class="header-subtitle">Wir freuen uns auf Ihre Nachricht</p>
      </div>
    </div>

    <!-- Progress Steps -->
    <div class="progress-container">
      <div class="progress-track">
        <div class="progress-fill" :style="{ width: progressWidth }"></div>
      </div>
      <div class="progress-steps">
        <div 
          v-for="(step, index) in steps" 
          :key="step.id"
          :class="['step-dot', { 
            active: currentStep === index, 
            completed: currentStep > index 
          }]"
          @click="goToStep(index)"
        >
          <span class="step-number">{{ index + 1 }}</span>
          <span class="step-label">{{ step.label }}</span>
          <div class="step-ripple"></div>
        </div>
      </div>
    </div>

    <!-- Form Container -->
    <div class="form-container">
      <transition name="slide-fade" mode="out-in">
        <!-- Step 1: Personal Info -->
        <div v-if="currentStep === 0" key="step1" class="form-step">
          <div class="step-header">
            <h2 class="step-title">Persönliche Daten</h2>
            <p class="step-description">Wie dürfen wir Sie kontaktieren?</p>
          </div>

          <div class="form-fields">
            <!-- Name Input -->
            <div class="input-group" :class="{ focused: focusedField === 'name', filled: formData.name }">
              <div class="input-icon">
                <span class="material-icons">person</span>
              </div>
              <div class="input-wrapper">
                <input 
                  type="text" 
                  id="name"
                  v-model="formData.name"
                  @focus="handleFocus('name')"
                  @blur="handleBlur('name')"
                  required
                >
                <label for="name">Vollständiger Name</label>
                <div class="input-line"></div>
              </div>
              <transition name="error">
                <div v-if="errors.name" class="input-error">
                  <span class="material-icons">error</span>
                  {{ errors.name }}
                </div>
              </transition>
            </div>

            <!-- Email Input -->
            <div class="input-group" :class="{ focused: focusedField === 'email', filled: formData.email }">
              <div class="input-icon">
                <span class="material-icons">email</span>
              </div>
              <div class="input-wrapper">
                <input 
                  type="email" 
                  id="email"
                  v-model="formData.email"
                  @focus="handleFocus('email')"
                  @blur="handleBlur('email')"
                  required
                >
                <label for="email">E-Mail Adresse</label>
                <div class="input-line"></div>
              </div>
            </div>

            <!-- Phone Input -->
            <div class="input-group" :class="{ focused: focusedField === 'phone', filled: formData.phone }">
              <div class="input-icon">
                <span class="material-icons">phone</span>
              </div>
              <div class="input-wrapper">
                <input 
                  type="tel" 
                  id="phone"
                  v-model="formData.phone"
                  @focus="handleFocus('phone')"
                  @blur="handleBlur('phone')"
                  required
                >
                <label for="phone">Telefonnummer</label>
                <div class="input-line"></div>
              </div>
            </div>

            <!-- Company Input -->
            <div class="input-group" :class="{ focused: focusedField === 'company', filled: formData.company }">
              <div class="input-icon">
                <span class="material-icons">business</span>
              </div>
              <div class="input-wrapper">
                <input 
                  type="text" 
                  id="company"
                  v-model="formData.company"
                  @focus="handleFocus('company')"
                  @blur="handleBlur('company')"
                >
                <label for="company">Firma (optional)</label>
                <div class="input-line"></div>
              </div>
            </div>
          </div>
        </div>

        <!-- Step 2: Project Details -->
        <div v-else-if="currentStep === 1" key="step2" class="form-step">
          <div class="step-header">
            <h2 class="step-title">Projektdetails</h2>
            <p class="step-description">Erzählen Sie uns von Ihrem Vorhaben</p>
          </div>

          <div class="form-fields">
            <!-- Project Type -->
            <div class="selection-group">
              <label class="group-label">Projektart</label>
              <div class="selection-grid">
                <button 
                  v-for="type in projectTypes" 
                  :key="type.id"
                  @click="selectProjectType(type)"
                  :class="['selection-card', { selected: formData.projectType === type.id }]"
                >
                  <div class="card-icon">
                    <span class="material-icons">{{ type.icon }}</span>
                  </div>
                  <div class="card-content">
                    <h4>{{ type.name }}</h4>
                    <p>{{ type.description }}</p>
                  </div>
                  <div class="card-check">
                    <span class="material-icons">check_circle</span>
                  </div>
                </button>
              </div>
            </div>

            <!-- Budget Range -->
            <div class="range-group">
              <label class="group-label">Budget-Rahmen</label>
              <div class="range-display">
                <span class="range-value">€{{ formatNumber(budgetValue) }}</span>
                <span class="range-label">{{ getBudgetLabel(budgetValue) }}</span>
              </div>
              <div class="range-slider">
                <input 
                  type="range" 
                  v-model="budgetValue"
                  min="10000"
                  max="500000"
                  step="10000"
                  @input="handleBudgetChange"
                >
                <div class="range-track">
                  <div class="range-progress" :style="{ width: budgetProgress + '%' }"></div>
                </div>
                <div class="range-markers">
                  <span>10k</span>
                  <span>100k</span>
                  <span>250k</span>
                  <span>500k+</span>
                </div>
              </div>
            </div>

            <!-- Timeline -->
            <div class="timeline-group">
              <label class="group-label">Zeitrahmen</label>
              <div class="timeline-options">
                <button 
                  v-for="time in timelines" 
                  :key="time.id"
                  @click="selectTimeline(time.id)"
                  :class="['timeline-btn', { selected: formData.timeline === time.id }]"
                >
                  <span class="btn-icon material-icons">{{ time.icon }}</span>
                  <span class="btn-text">{{ time.label }}</span>
                </button>
              </div>
            </div>
          </div>
        </div>

        <!-- Step 3: Message & Attachments -->
        <div v-else-if="currentStep === 2" key="step3" class="form-step">
          <div class="step-header">
            <h2 class="step-title">Ihre Nachricht</h2>
            <p class="step-description">Beschreiben Sie Ihr Projekt im Detail</p>
          </div>

          <div class="form-fields">
            <!-- Message Textarea -->
            <div class="textarea-group" :class="{ focused: focusedField === 'message', filled: formData.message }">
              <div class="textarea-wrapper">
                <textarea 
                  id="message"
                  v-model="formData.message"
                  @focus="handleFocus('message')"
                  @blur="handleBlur('message')"
                  rows="6"
                  required
                ></textarea>
                <label for="message">Ihre Nachricht</label>
                <div class="char-counter">{{ formData.message.length }} / 1000</div>
              </div>
            </div>

            <!-- File Upload -->
            <div class="upload-group">
              <label class="group-label">Dateien anhängen</label>
              <div 
                class="upload-zone"
                :class="{ dragging: isDragging }"
                @drop="handleDrop"
                @dragover.prevent
                @dragenter.prevent="isDragging = true"
                @dragleave.prevent="isDragging = false"
              >
                <input 
                  type="file" 
                  ref="fileInput"
                  @change="handleFileSelect"
                  multiple
                  accept="image/*,.pdf,.doc,.docx"
                  hidden
                >
                
                <div class="upload-content" @click="$refs.fileInput.click()">
                  <div class="upload-icon">
                    <span class="material-icons">cloud_upload</span>
                  </div>
                  <p class="upload-text">Dateien hier ablegen oder klicken</p>
                  <p class="upload-hint">JPG, PNG, PDF, DOC bis 10MB</p>
                </div>

                <!-- Uploaded Files -->
                <transition-group name="file-list" tag="div" class="uploaded-files" v-if="uploadedFiles.length">
                  <div v-for="file in uploadedFiles" :key="file.id" class="file-item">
                    <div class="file-icon">
                      <span class="material-icons">{{ getFileIcon(file.type) }}</span>
                    </div>
                    <div class="file-info">
                      <p class="file-name">{{ file.name }}</p>
                      <p class="file-size">{{ formatFileSize(file.size) }}</p>
                    </div>
                    <button @click="removeFile(file.id)" class="file-remove">
                      <span class="material-icons">close</span>
                    </button>
                  </div>
                </transition-group>
              </div>
            </div>

            <!-- Additional Options -->
            <div class="options-group">
              <label class="checkbox-wrapper">
                <input type="checkbox" v-model="formData.newsletter">
                <span class="checkbox-custom">
                  <span class="material-icons">check</span>
                </span>
                <span class="checkbox-label">Newsletter abonnieren</span>
              </label>

              <label class="checkbox-wrapper">
                <input type="checkbox" v-model="formData.privacy" required>
                <span class="checkbox-custom">
                  <span class="material-icons">check</span>
                </span>
                <span class="checkbox-label">Datenschutz akzeptieren *</span>
              </label>
            </div>
          </div>
        </div>

        <!-- Step 4: Review & Submit -->
        <div v-else-if="currentStep === 3" key="step4" class="form-step">
          <div class="step-header">
            <h2 class="step-title">Zusammenfassung</h2>
            <p class="step-description">Bitte überprüfen Sie Ihre Angaben</p>
          </div>

          <div class="summary-container">
            <div class="summary-section">
              <h3 class="section-title">
                <span class="material-icons">person</span>
                Kontaktdaten
              </h3>
              <div class="summary-content">
                <div class="summary-item">
                  <span class="item-label">Name:</span>
                  <span class="item-value">{{ formData.name }}</span>
                </div>
                <div class="summary-item">
                  <span class="item-label">E-Mail:</span>
                  <span class="item-value">{{ formData.email }}</span>
                </div>
                <div class="summary-item">
                  <span class="item-label">Telefon:</span>
                  <span class="item-value">{{ formData.phone }}</span>
                </div>
                <div class="summary-item" v-if="formData.company">
                  <span class="item-label">Firma:</span>
                  <span class="item-value">{{ formData.company }}</span>
                </div>
              </div>
            </div>

            <div class="summary-section">
              <h3 class="section-title">
                <span class="material-icons">architecture</span>
                Projektdetails
              </h3>
              <div class="summary-content">
                <div class="summary-item">
                  <span class="item-label">Projektart:</span>
                  <span class="item-value">{{ getProjectTypeName(formData.projectType) }}</span>
                </div>
                <div class="summary-item">
                  <span class="item-label">Budget:</span>
                  <span class="item-value">€{{ formatNumber(budgetValue) }}</span>
                </div>
                <div class="summary-item">
                  <span class="item-label">Zeitrahmen:</span>
                  <span class="item-value">{{ getTimelineLabel(formData.timeline) }}</span>
                </div>
              </div>
            </div>

            <div class="summary-section">
              <h3 class="section-title">
                <span class="material-icons">message</span>
                Nachricht
              </h3>
              <div class="summary-content">
                <p class="message-preview">{{ formData.message }}</p>
                <div class="summary-item" v-if="uploadedFiles.length">
                  <span class="item-label">Anhänge:</span>
                  <span class="item-value">{{ uploadedFiles.length }} Datei(en)</span>
                </div>
              </div>
            </div>
          </div>

          <!-- Success Animation -->
          <transition name="success">
            <div v-if="isSubmitted" class="success-overlay">
              <div class="success-content">
                <div class="success-icon">
                  <span class="material-icons">check_circle</span>
                  <div class="success-ripple"></div>
                </div>
                <h3>Vielen Dank!</h3>
                <p>Ihre Nachricht wurde erfolgreich versendet.</p>
                <p>Wir melden uns innerhalb von 24 Stunden bei Ihnen.</p>
              </div>
            </div>
          </transition>
        </div>
      </transition>
    </div>

    <!-- Navigation -->
    <div class="form-navigation">
      <button 
        @click="previousStep" 
        v-if="currentStep > 0"
        class="nav-btn prev"
      >
        <span class="material-icons">arrow_back</span>
        Zurück
      </button>

      <button 
        @click="submitForm" 
        v-if="currentStep === 3 && !isSubmitted"
        :disabled="!canSubmit"
        class="nav-btn submit"
      >
        <span v-if="!isSubmitting">
          Absenden
          <span class="material-icons">send</span>
        </span>
        <div v-else class="submit-loader">
          <div class="loader-spinner"></div>
        </div>
      </button>
    </div>

    <!-- Floating Action Button -->
    <button @click="toggleQuickContact" class="fab">
      <span class="material-icons">{{ quickContactOpen ? 'close' : 'message' }}</span>
      <div class="fab-pulse"></div>
    </button>

    <!-- Quick Contact -->
    <transition name="quick-contact">
      <div v-if="quickContactOpen" class="quick-contact">
        <div class="quick-header">
          <h3>Schnellkontakt</h3>
          <p>Wir sind für Sie da!</p>
        </div>
        <div class="quick-options">
          <a href="tel:+4981713868770" class="quick-option">
            <span class="material-icons">phone</span>
            <span>Anrufen</span>
          </a>
          <a href="https://wa.me/4981713868770" class="quick-option">
            <span class="material-icons">chat</span>
            <span>WhatsApp</span>
          </a>
          <a href="mailto:info@architektur-group.de" class="quick-option">
            <span class="material-icons">email</span>
            <span>E-Mail</span>
          </a>
        </div>
      </div>
    </transition>
  </div>
</template>

<script setup>
import { ref, reactive, computed, onMounted } from 'vue'

const currentStep = ref(0)
const focusedField = ref(null)
const isDragging = ref(false)
const isSubmitting = ref(false)
const isSubmitted = ref(false)
const quickContactOpen = ref(false)
const budgetValue = ref(50000)
const uploadedFiles = ref([])

const formData = reactive({
  name: '',
  email: '',
  phone: '',
  company: '',
  projectType: null,
  timeline: null,
  message: '',
  newsletter: false,
  privacy: false
})

const errors = reactive({
  name: '',
  email: '',
  phone: ''
})

const steps = [
  { id: 1, label: 'Kontakt' },
  { id: 2, label: 'Projekt' },
  { id: 3, label: 'Nachricht' },
  { id: 4, label: 'Absenden' }
]

const projectTypes = [
  { id: 'bathroom', name: 'Badezimmer', description: 'Luxusbäder', icon: 'bathtub' },
  { id: 'tiles', name: 'Fliesen', description: 'Premium Design', icon: 'dashboard' },
  { id: 'garden', name: 'Garten', description: 'Landschaftsbau', icon: 'park' },
  { id: 'terrace', name: 'Terrasse', description: 'Außenbereich', icon: 'deck' }
]

const timelines = [
  { id: 'asap', label: 'Sofort', icon: 'bolt' },
  { id: '3months', label: '3 Monate', icon: 'schedule' },
  { id: '6months', label: '6 Monate', icon: 'event' },
  { id: 'planning', label: 'Planung', icon: 'architecture' }
]

const progressWidth = computed(() => {
  return `${((currentStep.value + 1) / steps.length) * 100}%`
})

const budgetProgress = computed(() => {
  return ((budgetValue.value - 10000) / (500000 - 10000)) * 100
})

const canProceed = computed(() => {
  switch (currentStep.value) {
    case 0:
      return formData.name && formData.email && formData.phone
    case 1:
      return formData.projectType && formData.timeline
    case 2:
      return formData.message && formData.privacy
    default:
      return true
  }
})

const canSubmit = computed(() => {
  return formData.privacy && !isSubmitted.value
})

const handleFocus = (field) => {
  focusedField.value = field
  vibrate(10)
}

const handleBlur = (field) => {
  focusedField.value = null
  validateField(field)
}

const validateField = (field) => {
  switch (field) {
    case 'name':
      errors.name = formData.name.length < 2 ? 'Name ist zu kurz' : ''
      break
    case 'email':
      const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
      errors.email = !emailRegex.test(formData.email) ? 'Ungültige E-Mail' : ''
      break
    case 'phone':
      errors.phone = formData.phone.length < 6 ? 'Telefonnummer ist zu kurz' : ''
      break
  }
}

const selectProjectType = (type) => {
  formData.projectType = type.id
  vibrate(20)
}

const selectTimeline = (id) => {
  formData.timeline = id
  vibrate(20)
}

const handleBudgetChange = () => {
  vibrate(5)
}

const handleDrop = (e) => {
  e.preventDefault()
  isDragging.value = false
  handleFiles(e.dataTransfer.files)
}

const handleFileSelect = (e) => {
  handleFiles(e.target.files)
}

const handleFiles = (files) => {
  Array.from(files).forEach(file => {
    if (file.size <= 10485760) { // 10MB
      uploadedFiles.value.push({
        id: Date.now() + Math.random(),
        name: file.name,
        size: file.size,
        type: file.type
      })
      vibrate(30)
    }
  })
}

const removeFile = (id) => {
  uploadedFiles.value = uploadedFiles.value.filter(f => f.id !== id)
  vibrate(20)
}

const goToStep = (index) => {
  if (index < currentStep.value || canProceed.value) {
    currentStep.value = index
    vibrate(20)
  }
}

const previousStep = () => {
  if (currentStep.value > 0) {
    currentStep.value--
    vibrate(20)
  }
}

const nextStep = () => {
  if (canProceed.value && currentStep.value < 3) {
    currentStep.value++
    vibrate(20)
  }
}

const submitForm = async () => {
  if (!canSubmit.value) return
  
  isSubmitting.value = true
  vibrate(30)
  
  // Simulate API call
  await new Promise(resolve => setTimeout(resolve, 2000))
  
  isSubmitting.value = false
  isSubmitted.value = true
  vibrate([50, 100, 50])
  
  // Reset after success
  setTimeout(() => {
    resetForm()
  }, 5000)
}

const resetForm = () => {
  currentStep.value = 0
  isSubmitted.value = false
  Object.keys(formData).forEach(key => {
    formData[key] = typeof formData[key] === 'boolean' ? false : ''
  })
  uploadedFiles.value = []
}

const toggleQuickContact = () => {
  quickContactOpen.value = !quickContactOpen.value
  vibrate(20)
}

const vibrate = (pattern) => {
  if (navigator.vibrate) {
    navigator.vibrate(pattern)
  }
}

const formatNumber = (num) => {
  return num.toLocaleString('de-DE')
}

const formatFileSize = (bytes) => {
  if (bytes < 1024) return bytes + ' B'
  if (bytes < 1048576) return (bytes / 1024).toFixed(1) + ' KB'
  return (bytes / 1048576).toFixed(1) + ' MB'
}

const getFileIcon = (type) => {
  if (type.startsWith('image/')) return 'image'
  if (type === 'application/pdf') return 'picture_as_pdf'
  return 'description'
}

const getBudgetLabel = (value) => {
  if (value < 50000) return 'Klein'
  if (value < 150000) return 'Mittel'
  if (value < 300000) return 'Groß'
  return 'Premium'
}

const getProjectTypeName = (id) => {
  return projectTypes.find(t => t.id === id)?.name || ''
}

const getTimelineLabel = (id) => {
  return timelines.find(t => t.id === id)?.label || ''
}
</script>

<style scoped>
.mobile-contact-premium {
  min-height: 100vh;
  background: #000;
  color: #FAFAF8;
  padding-bottom: 100px;
}

/* Form Header */
.form-header {
  position: relative;
  height: 250px;
  overflow: hidden;
}

.header-bg {
  position: absolute;
  inset: 0;
}

.bg-pattern {
  position: absolute;
  inset: 0;
  background-image: 
    repeating-linear-gradient(45deg, transparent, transparent 35px, rgba(164, 113, 72, 0.03) 35px, rgba(164, 113, 72, 0.03) 70px);
  animation: patternSlide 20s linear infinite;
}

@keyframes patternSlide {
  from { transform: translateX(0); }
  to { transform: translateX(70px); }
}

.bg-gradient {
  position: absolute;
  inset: 0;
  background: radial-gradient(circle at 50% 50%, rgba(164, 113, 72, 0.2) 0%, transparent 70%);
}

.header-content {
  position: relative;
  height: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  text-align: center;
  padding: 2rem;
}

.header-icon {
  position: relative;
  width: 80px;
  height: 80px;
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 1rem;
}

.header-icon .material-icons {
  font-size: 36px;
  color: #000;
}

.icon-pulse {
  position: absolute;
  inset: -10px;
  border: 2px solid #a47148;
  border-radius: 50%;
  animation: pulse 2s ease-out infinite;
}

@keyframes pulse {
  0% {
    transform: scale(1);
    opacity: 1;
  }
  100% {
    transform: scale(1.3);
    opacity: 0;
  }
}

.header-title {
  font-size: 2rem;
  font-weight: 600;
  margin-bottom: 0.5rem;
  background: linear-gradient(135deg, #FAFAF8 0%, #a47148 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.header-subtitle {
  font-size: 1rem;
  color: #999;
  font-weight: 300;
}

/* Progress Container */
.progress-container {
  padding: 2rem 1rem;
  background: rgba(255, 255, 255, 0.02);
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
  box-shadow: 0 0 20px rgba(164, 113, 72, 0.5);
}

.progress-steps {
  display: flex;
  justify-content: space-between;
}

.step-dot {
  position: relative;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.5rem;
  cursor: pointer;
  transition: all 0.3s ease;
}

.step-number {
  width: 32px;
  height: 32px;
  background: rgba(255, 255, 255, 0.1);
  border: 2px solid rgba(255, 255, 255, 0.2);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 0.875rem;
  font-weight: 600;
  transition: all 0.3s ease;
}

.step-dot.active .step-number {
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  border-color: transparent;
  color: #000;
  transform: scale(1.2);
}

.step-dot.completed .step-number {
  background: #a47148;
  border-color: #a47148;
  color: #000;
}

.step-label {
  font-size: 0.75rem;
  color: #666;
  transition: color 0.3s ease;
}

.step-dot.active .step-label,
.step-dot.completed .step-label {
  color: #a47148;
}

.step-ripple {
  position: absolute;
  top: 0;
  left: 50%;
  transform: translateX(-50%);
  width: 32px;
  height: 32px;
  border: 2px solid #a47148;
  border-radius: 50%;
  opacity: 0;
}

.step-dot.active .step-ripple {
  animation: stepRipple 1.5s ease-out infinite;
}

@keyframes stepRipple {
  0% {
    transform: translateX(-50%) scale(1);
    opacity: 1;
  }
  100% {
    transform: translateX(-50%) scale(2);
    opacity: 0;
  }
}

/* Form Container */
.form-container {
  padding: 2rem 1rem;
  min-height: 400px;
}

.form-step {
  animation: stepFadeIn 0.5s ease-out;
}

@keyframes stepFadeIn {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.step-header {
  text-align: center;
  margin-bottom: 2rem;
}

.step-title {
  font-size: 1.5rem;
  font-weight: 500;
  color: #FAFAF8;
  margin-bottom: 0.5rem;
}

.step-description {
  font-size: 0.875rem;
  color: #999;
}

/* Input Groups */
.input-group {
  display: flex;
  align-items: flex-start;
  gap: 1rem;
  margin-bottom: 2rem;
  position: relative;
}

.input-icon {
  width: 40px;
  height: 40px;
  background: rgba(255, 255, 255, 0.05);
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #666;
  transition: all 0.3s ease;
}

.input-group.focused .input-icon {
  background: rgba(164, 113, 72, 0.1);
  color: #a47148;
}

.input-wrapper {
  flex: 1;
  position: relative;
}

.input-wrapper input,
.textarea-wrapper textarea {
  width: 100%;
  padding: 1rem 0;
  background: transparent;
  border: none;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
  color: #FAFAF8;
  font-size: 1rem;
  transition: all 0.3s ease;
}

.input-wrapper label,
.textarea-wrapper label {
  position: absolute;
  top: 1rem;
  left: 0;
  color: #666;
  font-size: 1rem;
  pointer-events: none;
  transition: all 0.3s ease;
}

.input-group.focused .input-wrapper label,
.input-group.filled .input-wrapper label,
.textarea-group.focused label,
.textarea-group.filled label {
  top: -0.5rem;
  font-size: 0.75rem;
  color: #a47148;
}

.input-line {
  position: absolute;
  bottom: 0;
  left: 0;
  width: 0;
  height: 2px;
  background: linear-gradient(90deg, #a47148, #FAFAF8);
  transition: width 0.3s ease;
}

.input-group.focused .input-line {
  width: 100%;
}

.input-error {
  position: absolute;
  bottom: -1.5rem;
  left: 0;
  display: flex;
  align-items: center;
  gap: 0.25rem;
  color: #e74c3c;
  font-size: 0.75rem;
}

/* Selection Group */
.selection-group {
  margin-bottom: 2rem;
}

.group-label {
  display: block;
  font-size: 0.875rem;
  color: #999;
  margin-bottom: 1rem;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.selection-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 1rem;
}

.selection-card {
  position: relative;
  padding: 1.5rem;
  background: rgba(255, 255, 255, 0.03);
  border: 2px solid rgba(255, 255, 255, 0.1);
  border-radius: 16px;
  cursor: pointer;
  transition: all 0.3s ease;
  overflow: hidden;
}

.selection-card:active {
  transform: scale(0.98);
}

.selection-card.selected {
  background: rgba(164, 113, 72, 0.1);
  border-color: #a47148;
}

.card-icon {
  width: 48px;
  height: 48px;
  background: rgba(255, 255, 255, 0.05);
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 1rem;
  transition: all 0.3s ease;
}

.selection-card.selected .card-icon {
  background: linear-gradient(135deg, #a47148, #FAFAF8);
}

.card-icon .material-icons {
  font-size: 24px;
  color: #666;
  transition: color 0.3s ease;
}

.selection-card.selected .card-icon .material-icons {
  color: #000;
}

.card-content h4 {
  font-size: 1rem;
  font-weight: 500;
  color: #FAFAF8;
  margin-bottom: 0.25rem;
}

.card-content p {
  font-size: 0.75rem;
  color: #666;
}

.card-check {
  position: absolute;
  top: 1rem;
  right: 1rem;
  opacity: 0;
  transform: scale(0);
  transition: all 0.3s ease;
}

.selection-card.selected .card-check {
  opacity: 1;
  transform: scale(1);
}

.card-check .material-icons {
  font-size: 20px;
  color: #a47148;
}

/* Range Slider */
.range-group {
  margin-bottom: 2rem;
}

.range-display {
  display: flex;
  justify-content: space-between;
  align-items: baseline;
  margin-bottom: 1rem;
}

.range-value {
  font-size: 1.5rem;
  font-weight: 600;
  color: #a47148;
}

.range-label {
  font-size: 0.875rem;
  color: #666;
  padding: 0.25rem 0.75rem;
  background: rgba(164, 113, 72, 0.1);
  border-radius: 12px;
}

.range-slider {
  position: relative;
}

.range-slider input[type="range"] {
  width: 100%;
  height: 40px;
  background: transparent;
  cursor: pointer;
  -webkit-appearance: none;
  position: relative;
  z-index: 2;
}

.range-slider input[type="range"]::-webkit-slider-thumb {
  -webkit-appearance: none;
  width: 24px;
  height: 24px;
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  border-radius: 50%;
  cursor: pointer;
  box-shadow: 0 4px 12px rgba(164, 113, 72, 0.3);
}

.range-track {
  position: absolute;
  top: 18px;
  left: 0;
  right: 0;
  height: 4px;
  background: rgba(255, 255, 255, 0.1);
  border-radius: 2px;
  overflow: hidden;
}

.range-progress {
  height: 100%;
  background: linear-gradient(90deg, #a47148, #FAFAF8);
  transition: width 0.1s ease;
}

.range-markers {
  display: flex;
  justify-content: space-between;
  margin-top: 0.5rem;
  padding: 0 0.5rem;
}

.range-markers span {
  font-size: 0.75rem;
  color: #666;
}

/* Timeline Options */
.timeline-options {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 1rem;
}

.timeline-btn {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.5rem;
  padding: 1rem;
  background: rgba(255, 255, 255, 0.03);
  border: 2px solid rgba(255, 255, 255, 0.1);
  border-radius: 16px;
  color: #666;
  cursor: pointer;
  transition: all 0.3s ease;
}

.timeline-btn.selected {
  background: rgba(164, 113, 72, 0.1);
  border-color: #a47148;
  color: #a47148;
}

.btn-icon {
  font-size: 24px;
}

.btn-text {
  font-size: 0.875rem;
  font-weight: 500;
}

/* Textarea Group */
.textarea-group {
  margin-bottom: 2rem;
  position: relative;
}

.textarea-wrapper {
  position: relative;
}

.textarea-wrapper textarea {
  resize: vertical;
  min-height: 120px;
  padding: 1rem;
  border: 2px solid rgba(255, 255, 255, 0.1);
  border-radius: 12px;
}

.textarea-group.focused textarea {
  border-color: #a47148;
}

.char-counter {
  position: absolute;
  bottom: 0.5rem;
  right: 0.5rem;
  font-size: 0.75rem;
  color: #666;
}

/* Upload Zone */
.upload-zone {
  padding: 2rem;
  background: rgba(255, 255, 255, 0.03);
  border: 2px dashed rgba(255, 255, 255, 0.2);
  border-radius: 16px;
  transition: all 0.3s ease;
  cursor: pointer;
}

.upload-zone.dragging {
  background: rgba(164, 113, 72, 0.1);
  border-color: #a47148;
}

.upload-content {
  text-align: center;
}

.upload-icon {
  width: 60px;
  height: 60px;
  background: rgba(255, 255, 255, 0.05);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 1rem;
}

.upload-icon .material-icons {
  font-size: 32px;
  color: #666;
}

.upload-text {
  font-size: 1rem;
  color: #FAFAF8;
  margin-bottom: 0.5rem;
}

.upload-hint {
  font-size: 0.75rem;
  color: #666;
}

/* Uploaded Files */
.uploaded-files {
  margin-top: 1rem;
  padding-top: 1rem;
  border-top: 1px solid rgba(255, 255, 255, 0.1);
}

.file-item {
  display: flex;
  align-items: center;
  gap: 1rem;
  padding: 0.75rem;
  background: rgba(255, 255, 255, 0.05);
  border-radius: 12px;
  margin-bottom: 0.5rem;
}

.file-icon {
  width: 40px;
  height: 40px;
  background: rgba(164, 113, 72, 0.1);
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #a47148;
}

.file-info {
  flex: 1;
}

.file-name {
  font-size: 0.875rem;
  color: #FAFAF8;
  margin-bottom: 0.25rem;
}

.file-size {
  font-size: 0.75rem;
  color: #666;
}

.file-remove {
  width: 32px;
  height: 32px;
  background: rgba(255, 255, 255, 0.05);
  border: none;
  border-radius: 50%;
  color: #666;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.3s ease;
}

.file-remove:active {
  background: rgba(231, 76, 60, 0.2);
  color: #e74c3c;
}

/* Checkbox */
.checkbox-wrapper {
  display: flex;
  align-items: center;
  gap: 1rem;
  margin-bottom: 1rem;
  cursor: pointer;
}

.checkbox-wrapper input {
  display: none;
}

.checkbox-custom {
  width: 24px;
  height: 24px;
  border: 2px solid rgba(255, 255, 255, 0.2);
  border-radius: 6px;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.3s ease;
}

.checkbox-wrapper input:checked + .checkbox-custom {
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  border-color: transparent;
}

.checkbox-custom .material-icons {
  font-size: 16px;
  color: #000;
  opacity: 0;
  transform: scale(0);
  transition: all 0.3s ease;
}

.checkbox-wrapper input:checked + .checkbox-custom .material-icons {
  opacity: 1;
  transform: scale(1);
}

.checkbox-label {
  font-size: 0.875rem;
  color: #FAFAF8;
}

/* Summary */
.summary-container {
  background: rgba(255, 255, 255, 0.03);
  border-radius: 16px;
  padding: 1.5rem;
}

.summary-section {
  margin-bottom: 2rem;
  padding-bottom: 2rem;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.summary-section:last-child {
  margin-bottom: 0;
  padding-bottom: 0;
  border-bottom: none;
}

.section-title {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  font-size: 1.125rem;
  font-weight: 500;
  color: #FAFAF8;
  margin-bottom: 1rem;
}

.section-title .material-icons {
  font-size: 20px;
  color: #a47148;
}

.summary-item {
  display: flex;
  justify-content: space-between;
  padding: 0.5rem 0;
}

.item-label {
  font-size: 0.875rem;
  color: #666;
}

.item-value {
  font-size: 0.875rem;
  color: #FAFAF8;
  font-weight: 500;
}

.message-preview {
  font-size: 0.875rem;
  line-height: 1.6;
  color: #ccc;
  padding: 1rem;
  background: rgba(255, 255, 255, 0.02);
  border-radius: 8px;
  margin-bottom: 1rem;
}

/* Success Overlay */
.success-overlay {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.95);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 100;
}

.success-content {
  text-align: center;
  padding: 2rem;
}

.success-icon {
  position: relative;
  width: 100px;
  height: 100px;
  background: linear-gradient(135deg, #4caf50, #8bc34a);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 2rem;
  animation: successBounce 0.6s ease-out;
}

@keyframes successBounce {
  0% { transform: scale(0); }
  50% { transform: scale(1.2); }
  100% { transform: scale(1); }
}

.success-icon .material-icons {
  font-size: 48px;
  color: #fff;
}

.success-ripple {
  position: absolute;
  inset: -20px;
  border: 3px solid #4caf50;
  border-radius: 50%;
  animation: successRipple 1.5s ease-out;
}

@keyframes successRipple {
  from {
    transform: scale(1);
    opacity: 1;
  }
  to {
    transform: scale(1.5);
    opacity: 0;
  }
}

.success-content h3 {
  font-size: 1.5rem;
  color: #FAFAF8;
  margin-bottom: 1rem;
}

.success-content p {
  font-size: 1rem;
  color: #ccc;
  margin-bottom: 0.5rem;
}

/* Navigation */
.form-navigation {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  padding: 1rem;
  background: rgba(0, 0, 0, 0.95);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border-top: 1px solid rgba(255, 255, 255, 0.1);
  display: flex;
  gap: 1rem;
  z-index: 10;
}

.nav-btn {
  flex: 1;
  padding: 1rem;
  background: rgba(255, 255, 255, 0.05);
  border: 2px solid rgba(255, 255, 255, 0.1);
  border-radius: 16px;
  color: #FAFAF8;
  font-size: 1rem;
  font-weight: 500;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  cursor: pointer;
  transition: all 0.3s ease;
}

.nav-btn:disabled {
  opacity: 0.3;
  cursor: not-allowed;
}

.nav-btn.prev {
  flex: 0 0 120px;
}

.nav-btn.next,
.nav-btn.submit {
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  border-color: transparent;
  color: #000;
}

.nav-btn:active:not(:disabled) {
  transform: scale(0.95);
}

.submit-loader {
  display: flex;
  align-items: center;
  justify-content: center;
}

.loader-spinner {
  width: 24px;
  height: 24px;
  border: 3px solid rgba(0, 0, 0, 0.2);
  border-top-color: #000;
  border-radius: 50%;
  animation: spin 0.8s linear infinite;
}

@keyframes spin {
  to { transform: rotate(360deg); }
}

/* FAB */
.fab {
  position: fixed;
  bottom: 100px;
  right: 20px;
  width: 56px;
  height: 56px;
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 4px 20px rgba(164, 113, 72, 0.4);
  cursor: pointer;
  z-index: 9;
  border: none;
  color: #000;
}

.fab .material-icons {
  font-size: 24px;
}

.fab-pulse {
  position: absolute;
  inset: -8px;
  border: 2px solid #a47148;
  border-radius: 50%;
  animation: fabPulse 2s ease-out infinite;
}

@keyframes fabPulse {
  0% {
    transform: scale(1);
    opacity: 1;
  }
  100% {
    transform: scale(1.3);
    opacity: 0;
  }
}

/* Quick Contact */
.quick-contact {
  position: fixed;
  bottom: 170px;
  right: 20px;
  width: 280px;
  background: rgba(0, 0, 0, 0.95);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 16px;
  padding: 1.5rem;
  box-shadow: 0 10px 40px rgba(0, 0, 0, 0.5);
  z-index: 8;
}

.quick-header {
  text-align: center;
  margin-bottom: 1.5rem;
}

.quick-header h3 {
  font-size: 1.125rem;
  color: #FAFAF8;
  margin-bottom: 0.25rem;
}

.quick-header p {
  font-size: 0.875rem;
  color: #666;
}

.quick-options {
  display: flex;
  gap: 1rem;
}

.quick-option {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.5rem;
  padding: 1rem 0.5rem;
  background: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 12px;
  color: #FAFAF8;
  text-decoration: none;
  font-size: 0.75rem;
  transition: all 0.3s ease;
}

.quick-option:active {
  background: rgba(164, 113, 72, 0.2);
  transform: scale(0.95);
}

.quick-option .material-icons {
  font-size: 20px;
  color: #a47148;
}

/* Animations */
.slide-fade-enter-active,
.slide-fade-leave-active {
  transition: all 0.3s ease;
}

.slide-fade-enter-from {
  opacity: 0;
  transform: translateX(20px);
}

.slide-fade-leave-to {
  opacity: 0;
  transform: translateX(-20px);
}

.error-enter-active,
.error-leave-active {
  transition: all 0.3s ease;
}

.error-enter-from,
.error-leave-to {
  opacity: 0;
  transform: translateY(-10px);
}

.file-list-enter-active,
.file-list-leave-active {
  transition: all 0.3s ease;
}

.file-list-enter-from,
.file-list-leave-to {
  opacity: 0;
  transform: scale(0.8);
}

.success-enter-active {
  animation: fadeIn 0.3s ease;
}

.success-leave-active {
  animation: fadeIn 0.3s ease reverse;
}

@keyframes fadeIn {
  from { opacity: 0; }
  to { opacity: 1; }
}

.quick-contact-enter-active,
.quick-contact-leave-active {
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.quick-contact-enter-from,
.quick-contact-leave-to {
  opacity: 0;
  transform: scale(0.8) translateY(20px);
}

/* Responsive */
@media (min-width: 768px) {
  .selection-grid {
    grid-template-columns: repeat(4, 1fr);
  }
  
  .timeline-options {
    grid-template-columns: repeat(4, 1fr);
  }
}
</style>