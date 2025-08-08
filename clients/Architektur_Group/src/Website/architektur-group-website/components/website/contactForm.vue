<template>
  <div class="contact-form">
    <div class="form-container">
      <!-- Progress -->
      <div class="progress-container mb-8">
        <p class="text-center text-sm mb-2">
          Schritt {{ currentStep }} von {{ totalSteps }}
        </p>
        <div class="progress-bar">
          <div class="progress-fill" :style="{ width: progressWidth }"></div>
        </div>
      </div>
      
      <!-- Step 1: Personal Data -->
      <div v-if="currentStep === 1" class="form-step">
        <h2 class="text-2xl font-light text-center mb-6">Willkommen</h2>
        <p class="text-sm text-gray-400 text-center mb-8">
          *Bitte füllen Sie alle Informationen aus, damit wir Ihre Anfrage bearbeiten können.
        </p>
        
        <div class="form-fields">
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div class="form-group">
              <label for="firstName">Vorname *</label>
              <input 
                type="text" 
                id="firstName" 
                v-model="formData.firstName"
                @blur="validateField('firstName')"
                :class="{ 'invalid': errors.firstName }"
                placeholder="Vorname..."
              >
            </div>
            
            <div class="form-group">
              <label for="lastName">Nachname *</label>
              <input 
                type="text" 
                id="lastName" 
                v-model="formData.lastName"
                @blur="validateField('lastName')"
                :class="{ 'invalid': errors.lastName }"
                placeholder="Nachname..."
              >
            </div>
          </div>
          
          <div class="form-group">
            <label for="email">E-Mail-Adresse *</label>
            <input 
              type="email" 
              id="email" 
              v-model="formData.email"
              @blur="validateField('email')"
              :class="{ 'invalid': errors.email }"
              placeholder="E-Mail..."
            >
          </div>
          
          <div class="form-group">
            <label for="phone">Telefonnummer *</label>
            <div class="phone-input-group">
              <select v-model="formData.countryCode" class="country-select">
                <option value="+49">DE +49</option>
                <option value="+43">AT +43</option>
                <option value="+41">CH +41</option>
              </select>
              <input 
                type="tel" 
                id="phone" 
                v-model="formData.phone"
                @blur="validateField('phone')"
                :class="{ 'invalid': errors.phone }"
                placeholder="Telefon..."
              >
            </div>
          </div>
        </div>
      </div>
      
      <!-- Step 2: Room Details -->
      <div v-if="currentStep === 2" class="form-step">
        <h2 class="text-2xl font-light text-center mb-6">Zimmerdetails</h2>
        
        <div class="form-group">
          <label for="room">Raum wählen *</label>
          <select v-model="roomData.room" class="form-select">
            <option value="">Bitte wählen...</option>
            <option value="Wohnzimmer">Wohnzimmer</option>
            <option value="Schlafzimmer">Schlafzimmer</option>
            <option value="Küche">Küche</option>
            <option value="Badezimmer">Badezimmer</option>
            <option value="Sonstiges">Sonstiges</option>
          </select>
        </div>
        
        <div class="form-group">
          <label for="size">Quadratmeter *</label>
          <input 
            type="number" 
            id="size" 
            v-model="roomData.size"
            placeholder="z. B. 25"
          >
        </div>
        
        <h3 class="text-lg font-light mb-4">Materialvorschläge *</h3>
        <div class="material-grid">
          <div 
            v-for="material in materials" 
            :key="material.name"
            @click="selectMaterial(material.name)"
            :class="['material-card', { 'selected': roomData.material === material.name }]"
          >
            <div class="material-image" :style="{ backgroundColor: material.color }"></div>
            <strong>{{ material.name }}</strong>
            <p>{{ material.description }}</p>
          </div>
        </div>
        
        <button 
          @click="addRoom" 
          :disabled="!isRoomValid"
          class="add-button mt-6"
        >
          Hinzufügen
        </button>
        
        <div v-if="formData.rooms.length > 0" class="room-list mt-6">
          <h4 class="font-light mb-2">Ausgewählte Räume:</h4>
          <div v-for="(room, index) in formData.rooms" :key="index" class="room-item">
            {{ room.room }} - {{ room.size }}m² - {{ room.material }}
          </div>
        </div>
      </div>
      
      <!-- Step 3: Image Upload -->
      <div v-if="currentStep === 3" class="form-step">
        <h2 class="text-2xl font-light text-center mb-6">Bilder hochladen</h2>
        
        <div 
          @drop="handleDrop"
          @dragover.prevent
          @dragenter.prevent
          class="drop-zone"
        >
          <p><strong>Ziehe deine Bilder hierher</strong><br>oder klicke zum Durchsuchen</p>
          <input 
            type="file" 
            ref="fileInput"
            @change="handleFileSelect"
            accept="image/*,.pdf"
            multiple
            hidden
          >
          <button @click="$refs.fileInput.click()" class="upload-button">
            Hochladen
          </button>
        </div>
        
        <div v-if="formData.images.length > 0" class="image-gallery mt-6">
          <h4 class="font-light mb-2">Hochgeladene Bilder:</h4>
          <div class="gallery-grid">
            <div v-for="(image, index) in formData.images" :key="index" class="gallery-item">
              <img v-if="image.type.startsWith('image')" :src="image.url" alt="">
              <div v-else class="pdf-icon">📄 {{ image.name }}</div>
            </div>
          </div>
        </div>
      </div>
      
      <!-- Step 4: Summary -->
      <div v-if="currentStep === 4" class="form-step">
        <h2 class="text-2xl font-light text-center mb-6">Anfrage überprüfen</h2>
        <p class="text-sm text-gray-400 text-center mb-8">
          Bitte überprüfen Sie alle Informationen nochmal gründlich.
        </p>
        
        <div class="summary-section">
          <h3 class="text-lg font-light mb-4">Persönliche Daten</h3>
          <div class="summary-content">
            <p><strong>Vorname:</strong> {{ formData.firstName }}</p>
            <p><strong>Nachname:</strong> {{ formData.lastName }}</p>
            <p><strong>E-Mail:</strong> {{ formData.email }}</p>
            <p><strong>Telefon:</strong> {{ formData.countryCode }} {{ formData.phone }}</p>
          </div>
        </div>
        
        <div class="summary-section">
          <h3 class="text-lg font-light mb-4">Zimmerdetails</h3>
          <div v-for="(room, index) in formData.rooms" :key="index" class="summary-content">
            <p>{{ room.room }} - {{ room.size }}m² - {{ room.material }}</p>
          </div>
        </div>
        
        <div v-if="formData.images.length > 0" class="summary-section">
          <h3 class="text-lg font-light mb-4">Hochgeladene Bilder</h3>
          <p>{{ formData.images.length }} Datei(en) hochgeladen</p>
        </div>
      </div>
      
      <!-- Navigation -->
      <div class="form-navigation mt-8">
        <button 
          v-if="currentStep < totalSteps"
          @click="nextStep"
          :disabled="!canProceed"
          class="next-button"
        >
          Weiter
        </button>
        
        <button 
          v-if="currentStep === totalSteps"
          @click="submitForm"
          class="submit-button"
        >
          <span v-if="!isSubmitting">Absenden</span>
          <span v-else class="loader"></span>
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
const currentStep = ref(1)
const totalSteps = 4
const isSubmitting = ref(false)

const formData = reactive({
  firstName: '',
  lastName: '',
  email: '',
  phone: '',
  countryCode: '+49',
  rooms: [],
  images: []
})

const roomData = reactive({
  room: '',
  size: '',
  material: ''
})

const errors = reactive({
  firstName: false,
  lastName: false,
  email: false,
  phone: false
})

const materials = [
  { name: 'Holzboden', description: 'Klassisch und langlebig', color: '#8B4513' },
  { name: 'Fliesen', description: 'Elegant und wasserfest', color: '#E0E0E0' },
  { name: 'Teppich', description: 'Weich und schallabsorbierend', color: '#696969' },
  { name: 'Laminat', description: 'Vielseitig und pflegeleicht', color: '#D2691E' },
  { name: 'Vinyl', description: 'Wasserfest und einfach zu reinigen', color: '#2F4F4F' }
]

const progressWidth = computed(() => {
  return `${(currentStep.value / totalSteps) * 100}%`
})

const canProceed = computed(() => {
  switch (currentStep.value) {
    case 1:
      return formData.firstName && formData.lastName && formData.email && formData.phone && 
             !errors.firstName && !errors.lastName && !errors.email && !errors.phone
    case 2:
      return formData.rooms.length > 0
    case 3:
      return true
    default:
      return true
  }
})

const isRoomValid = computed(() => {
  return roomData.room && roomData.size && roomData.material
})

const validateField = (field) => {
  switch (field) {
    case 'firstName':
    case 'lastName':
      errors[field] = !/^[A-Za-zÄÖÜäöüß\s-]{2,}$/.test(formData[field])
      break
    case 'email':
      errors[field] = !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(formData[field])
      break
    case 'phone':
      errors[field] = !/^\d{5,}$/.test(formData[field])
      break
  }
}

const selectMaterial = (material) => {
  roomData.material = material
}

const addRoom = () => {
  if (isRoomValid.value) {
    formData.rooms.push({ ...roomData })
    roomData.room = ''
    roomData.size = ''
    roomData.material = ''
  }
}

const handleDrop = (e) => {
  e.preventDefault()
  handleFiles(e.dataTransfer.files)
}

const handleFileSelect = (e) => {
  handleFiles(e.target.files)
}

const handleFiles = (files) => {
  Array.from(files).forEach(file => {
    const reader = new FileReader()
    reader.onload = (e) => {
      formData.images.push({
        name: file.name,
        type: file.type,
        url: e.target.result
      })
    }
    reader.readAsDataURL(file)
  })
}

const nextStep = () => {
  if (canProceed.value && currentStep.value < totalSteps) {
    currentStep.value++
  }
}

const submitForm = async () => {
  isSubmitting.value = true
  
  // Simulate API call
  await new Promise(resolve => setTimeout(resolve, 2000))
  
  console.log('Form submitted:', formData)
  
  // Reset form or redirect
  isSubmitting.value = false
  alert('Vielen Dank für Ihre Anfrage! Wir melden uns umgehend bei Ihnen.')
}
</script>

<style scoped>
.contact-form {
  max-width: 800px;
  margin: 0 auto;
}

.progress-bar {
  width: 100%;
  height: 8px;
  background-color: #333;
  border-radius: 20px;
  overflow: hidden;
}

.progress-fill {
  height: 100%;
  background: linear-gradient(120deg, #ffffff 10%, #999999 50%, #ffffff 90%);
  box-shadow: 0 0 20px #ffffff88;
  transition: width 0.3s ease;
}

.form-group {
  margin-bottom: 1.5rem;
}

.form-group label {
  display: block;
  margin-bottom: 0.5rem;
  font-weight: 300;
  color: var(--primary-white);
}

.form-group input,
.form-group select,
.form-select {
  width: 100%;
  background-color: rgba(255, 255, 255, 0.1);
  border: none;
  border-bottom: 2px solid #666;
  color: white;
  padding: 0.75rem 0.5rem;
  font-size: 1rem;
  transition: border-color 0.3s;
}

.form-group input:focus,
.form-group select:focus {
  outline: none;
  border-bottom-color: var(--primary-white);
}

.form-group input.invalid {
  border-bottom-color: #e74c3c;
}

.phone-input-group {
  display: flex;
  gap: 1rem;
}

.country-select {
  flex: 0 0 120px;
}

.material-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
  gap: 1rem;
}

.material-card {
  text-align: center;
  padding: 1rem;
  border: 2px solid transparent;
  border-radius: 8px;
  cursor: pointer;
  background: rgba(255, 255, 255, 0.05);
  transition: all 0.3s;
}

.material-card:hover {
  background: rgba(255, 255, 255, 0.1);
}

.material-card.selected {
  border-color: var(--primary-white);
  background: rgba(255, 255, 255, 0.15);
}

.material-image {
  width: 100%;
  height: 80px;
  border-radius: 4px;
  margin-bottom: 0.5rem;
}

.material-card p {
  font-size: 0.875rem;
  color: #999;
}

.drop-zone {
  border: 2px dashed #666;
  border-radius: 8px;
  padding: 3rem;
  text-align: center;
  transition: all 0.3s;
  cursor: pointer;
}

.drop-zone:hover {
  border-color: var(--primary-white);
  background: rgba(255, 255, 255, 0.05);
}

.upload-button,
.add-button,
.next-button,
.submit-button {
  background: transparent;
  color: var(--primary-white);
  border: 2px solid var(--primary-white);
  padding: 0.75rem 2rem;
  border-radius: 4px;
  cursor: pointer;
  transition: all 0.3s;
  font-size: 1rem;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.upload-button:hover,
.add-button:hover,
.next-button:hover,
.submit-button:hover {
  background: var(--primary-white);
  color: black;
}

.upload-button:disabled,
.add-button:disabled,
.next-button:disabled {
  opacity: 0.3;
  cursor: not-allowed;
}

.room-list,
.image-gallery {
  background: rgba(255, 255, 255, 0.05);
  padding: 1rem;
  border-radius: 8px;
}

.room-item {
  padding: 0.5rem 0;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.room-item:last-child {
  border-bottom: none;
}

.gallery-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(100px, 1fr));
  gap: 1rem;
}

.gallery-item img {
  width: 100%;
  height: 100px;
  object-fit: cover;
  border-radius: 4px;
}

.pdf-icon {
  width: 100%;
  height: 100px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: rgba(255, 255, 255, 0.1);
  border-radius: 4px;
  font-size: 0.875rem;
}

.summary-section {
  background: rgba(255, 255, 255, 0.05);
  padding: 1.5rem;
  border-radius: 8px;
  margin-bottom: 1.5rem;
}

.summary-content p {
  margin-bottom: 0.5rem;
}

.form-navigation {
  display: flex;
  justify-content: center;
}

.loader {
  display: inline-block;
  width: 20px;
  height: 20px;
  border: 3px solid rgba(255, 255, 255, 0.3);
  border-radius: 50%;
  border-top-color: white;
  animation: spin 0.8s ease-in-out infinite;
}

@keyframes spin {
  to { transform: rotate(360deg); }
}
</style>