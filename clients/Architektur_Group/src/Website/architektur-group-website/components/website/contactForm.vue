<template>
  <div class="luxury-contact-form">
    <div class="form-background">
      <div class="background-particles">
        <div v-for="n in 20" :key="n" class="bg-particle" :style="{
          left: Math.random() * 100 + '%',
          top: Math.random() * 100 + '%',
          animationDelay: Math.random() * 5 + 's',
          animationDuration: (3 + Math.random() * 4) + 's'
        }"></div>
      </div>
      
      <div class="morphing-shapes">
        <div class="shape shape-1"></div>
        <div class="shape shape-2"></div>
        <div class="shape shape-3"></div>
      </div>
    </div>

    <div class="form-container">
      <div class="form-header">
        <div class="header-decoration">
          <div class="decoration-line left"></div>
          <div class="form-badge">
            <span class="material-icons">diamond</span>
          </div>
          <div class="decoration-line right"></div>
        </div>
        <h1 class="form-title">
          <span class="title-gradient">PERSÖNLICHE BERATUNG</span>
        </h1>
        <p class="form-subtitle">Lassen Sie sich von unseren Experten individuell beraten</p>
      </div>

      <!-- Enhanced Progress -->
      <div class="progress-container">
        <div class="progress-steps">
          <div v-for="step in totalSteps" :key="step" 
               :class="['progress-step', { 
                 'active': step === currentStep, 
                 'completed': step < currentStep 
               }]">
            <div class="step-circle">
              <span v-if="step < currentStep" class="material-icons">check</span>
              <span v-else>{{ step }}</span>
            </div>
            <span class="step-label">{{ getStepLabel(step) }}</span>
          </div>
        </div>
      </div>
      
      <!-- Step 1: Personal Data -->
      <transition name="step" mode="out-in">
        <div v-if="currentStep === 1" class="form-step" key="step1">
          <div class="step-header">
            <div class="step-icon">
              <span class="material-icons">person</span>
            </div>
            <h2 class="step-title">Persönliche Angaben</h2>
            <p class="step-subtitle">
              Bitte geben Sie Ihre Kontaktdaten ein, damit wir Sie erreichen können.
            </p>
          </div>
          
          <div class="form-fields">
            <div class="field-grid">
              <div class="form-group" :class="{ 'has-error': errors.firstName, 'has-success': formData.firstName && !errors.firstName }">
                <label for="firstName">
                  <span class="material-icons">badge</span>
                  Vorname *
                </label>
                <div class="input-wrapper">
                  <input 
                    type="text" 
                    id="firstName" 
                    v-model="formData.firstName"
                    @input="validateField('firstName')"
                    @blur="validateField('firstName')"
                    @focus="clearError('firstName')"
                    :class="{ 'invalid': errors.firstName, 'valid': formData.firstName && !errors.firstName }"
                    placeholder="Ihr Vorname..."
                  >
                  <div class="input-border"></div>
                  <div class="field-particles">
                    <div v-for="n in 3" :key="n" class="field-particle"></div>
                  </div>
                </div>
                <transition name="error">
                  <div v-if="errors.firstName" class="error-message">
                    <span class="material-icons">error</span>
                    {{ errorMessages.firstName }}
                  </div>
                </transition>
              </div>
              
              <div class="form-group" :class="{ 'has-error': errors.lastName, 'has-success': formData.lastName && !errors.lastName }">
                <label for="lastName">
                  <span class="material-icons">badge</span>
                  Nachname *
                </label>
                <div class="input-wrapper">
                  <input 
                    type="text" 
                    id="lastName" 
                    v-model="formData.lastName"
                    @input="validateField('lastName')"
                    @blur="validateField('lastName')"
                    @focus="clearError('lastName')"
                    :class="{ 'invalid': errors.lastName, 'valid': formData.lastName && !errors.lastName }"
                    placeholder="Ihr Nachname..."
                  >
                  <div class="input-border"></div>
                  <div class="field-particles">
                    <div v-for="n in 3" :key="n" class="field-particle"></div>
                  </div>
                </div>
                <transition name="error">
                  <div v-if="errors.lastName" class="error-message">
                    <span class="material-icons">error</span>
                    {{ errorMessages.lastName }}
                  </div>
                </transition>
              </div>
            </div>
            
            <div class="form-group" :class="{ 'has-error': errors.email, 'has-success': formData.email && !errors.email }">
              <label for="email">
                <span class="material-icons">email</span>
                E-Mail-Adresse *
              </label>
              <div class="input-wrapper">
                <input 
                  type="email" 
                  id="email" 
                  v-model="formData.email"
                  @input="validateField('email')"
                  @blur="validateField('email')"
                  @focus="clearError('email')"
                  :class="{ 'invalid': errors.email, 'valid': formData.email && !errors.email }"
                  placeholder="ihre.email@beispiel.de"
                >
                <div class="input-border"></div>
                <div class="field-particles">
                  <div v-for="n in 3" :key="n" class="field-particle"></div>
                </div>
              </div>
              <transition name="error">
                <div v-if="errors.email" class="error-message">
                  <span class="material-icons">error</span>
                  {{ errorMessages.email }}
                </div>
              </transition>
            </div>
            
            <div class="form-group" :class="{ 'has-error': errors.phone, 'has-success': formData.phone && !errors.phone }">
              <label for="phone">
                <span class="material-icons">phone</span>
                Telefonnummer *
              </label>
              <div class="phone-input-group">
                <div class="country-select-wrapper">
                  <select v-model="formData.countryCode" class="country-select">
                    <option value="+49">🇩🇪 +49</option>
                    <option value="+43">🇦🇹 +43</option>
                    <option value="+41">🇨🇭 +41</option>
                  </select>
                </div>
                <div class="input-wrapper flex-1">
                  <input 
                    type="tel" 
                    id="phone" 
                    v-model="formData.phone"
                    @input="validateField('phone')"
                    @blur="validateField('phone')"
                    @focus="clearError('phone')"
                    :class="{ 'invalid': errors.phone, 'valid': formData.phone && !errors.phone }"
                    placeholder="0123 456789"
                  >
                  <div class="input-border"></div>
                  <div class="field-particles">
                    <div v-for="n in 3" :key="n" class="field-particle"></div>
                  </div>
                </div>
              </div>
              <transition name="error">
                <div v-if="errors.phone" class="error-message">
                  <span class="material-icons">error</span>
                  {{ errorMessages.phone }}
                </div>
              </transition>
            </div>

            <div class="form-group">
              <label for="company">
                <span class="material-icons">business</span>
                Unternehmen (optional)
              </label>
              <div class="input-wrapper">
                <input 
                  type="text" 
                  id="company" 
                  v-model="formData.company"
                  placeholder="Ihr Unternehmen..."
                >
                <div class="input-border"></div>
                <div class="field-particles">
                  <div v-for="n in 3" :key="n" class="field-particle"></div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </transition>
      
      <!-- Step 2: Project Details -->
      <transition name="step" mode="out-in">
        <div v-if="currentStep === 2" class="form-step" key="step2">
          <div class="step-header">
            <div class="step-icon">
              <span class="material-icons">home_work</span>
            </div>
            <h2 class="step-title">Projektdetails</h2>
            <p class="step-subtitle">
              Erzählen Sie uns mehr über Ihr Projekt, damit wir Sie optimal beraten können.
            </p>
          </div>
          
          <div class="form-fields">
            <div class="field-grid">
              <div class="form-group" :class="{ 'has-error': errors.projectType, 'has-success': formData.projectType && !errors.projectType }">
                <label for="projectType">
                  <span class="custom-icon project-icon"></span>
                  Projekttyp *
                </label>
                <div class="select-wrapper">
                  <select 
                    v-model="formData.projectType" 
                    @change="validateField('projectType')"
                    :class="{ 'invalid': errors.projectType, 'valid': formData.projectType && !errors.projectType }"
                    class="luxury-select"
                  >
                    <option value="">Bitte wählen...</option>
                    <option value="Neubau">Neubau</option>
                    <option value="Renovierung">Renovierung</option>
                    <option value="Sanierung">Sanierung</option>
                    <option value="Erweiterung">Erweiterung</option>
                  </select>
                  <div class="select-border"></div>
                  <span class="select-arrow material-icons">expand_more</span>
                </div>
                <transition name="error">
                  <div v-if="errors.projectType" class="error-message">
                    <span class="material-icons">error</span>
                    {{ errorMessages.projectType }}
                  </div>
                </transition>
              </div>

              <div class="form-group" :class="{ 'has-error': errors.room, 'has-success': formData.room && !errors.room }">
                <label for="room">
                  <span class="custom-icon room-icon"></span>
                  Bereich *
                </label>
                <div class="select-wrapper">
                  <select 
                    v-model="formData.room" 
                    @change="validateField('room')"
                    :class="{ 'invalid': errors.room, 'valid': formData.room && !errors.room }"
                    class="luxury-select"
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
                  <div class="select-border"></div>
                  <span class="select-arrow material-icons">expand_more</span>
                </div>
                <transition name="error">
                  <div v-if="errors.room" class="error-message">
                    <span class="material-icons">error</span>
                    {{ errorMessages.room }}
                  </div>
                </transition>
              </div>
            </div>
            
            <div class="form-group" :class="{ 'has-error': errors.size, 'has-success': formData.size && !errors.size }">
              <label for="size">
                <span class="material-icons">square_foot</span>
                Ungefähre Fläche in m² *
              </label>
              <div class="input-wrapper">
                <input 
                  type="number" 
                  id="size" 
                  v-model="formData.size"
                  @input="validateField('size')"
                  @blur="validateField('size')"
                  @focus="clearError('size')"
                  :class="{ 'invalid': errors.size, 'valid': formData.size && !errors.size }"
                  placeholder="z.B. 25"
                  min="1"
                  max="10000"
                >
                <div class="input-border"></div>
                <div class="input-suffix">m²</div>
                <div class="field-particles">
                  <div v-for="n in 3" :key="n" class="field-particle"></div>
                </div>
              </div>
              <transition name="error">
                <div v-if="errors.size" class="error-message">
                  <span class="material-icons">error</span>
                  {{ errorMessages.size }}
                </div>
              </transition>
            </div>

            
            <div class="form-group">
              <label for="message">
                <span class="material-icons">message</span>
                Ihre Nachricht (optional)
              </label>
              <div class="textarea-wrapper">
                <textarea 
                  id="message" 
                  v-model="formData.message"
                  rows="4"
                  placeholder="Beschreiben Sie Ihr Projekt oder stellen Sie uns Ihre Fragen..."
                ></textarea>
                <div class="textarea-border"></div>
                <div class="field-particles">
                  <div v-for="n in 5" :key="n" class="field-particle"></div>
                </div>
              </div>
            </div>

            <div class="form-group">
              <label for="timeline">
                <span class="material-icons">schedule</span>
                Gewünschter Zeitrahmen (optional)
              </label>
              <div class="select-wrapper">
                <select v-model="formData.timeline" class="luxury-select">
                  <option value="">Keine Angabe</option>
                  <option value="sofort">So schnell wie möglich</option>
                  <option value="1-monat">Innerhalb 1 Monat</option>
                  <option value="3-monate">Innerhalb 3 Monate</option>
                  <option value="6-monate">Innerhalb 6 Monate</option>
                  <option value="planung">Noch in Planung</option>
                </select>
                <div class="select-border"></div>
                <span class="select-arrow material-icons">expand_more</span>
              </div>
            </div>
          </div>
        </div>
      </transition>
      
      <!-- Step 3: Summary with Edit Capability -->
      <transition name="step" mode="out-in">
        <div v-if="currentStep === 3" class="form-step" key="step3">
          <div class="step-header">
            <div class="step-icon">
              <span class="material-icons">check_circle</span>
            </div>
            <h2 class="step-title">Anfrage überprüfen</h2>
            <p class="step-subtitle">
              Bitte überprüfen Sie Ihre Angaben vor dem Absenden. Sie können jederzeit Änderungen vornehmen.
            </p>
          </div>
          
          <div class="summary-container">
            <div class="summary-section" :class="{ 'editing': editingSection === 'personal' }">
              <div class="summary-header">
                <div class="header-left">
                  <span class="material-icons">person</span>
                  <h3>Persönliche Daten</h3>
                </div>
                <button 
                  @click="editSection('personal')" 
                  class="edit-button"
                  :class="{ 'active': editingSection === 'personal' }"
                >
                  <span class="material-icons">{{ editingSection === 'personal' ? 'close' : 'edit' }}</span>
                  {{ editingSection === 'personal' ? 'Schließen' : 'Bearbeiten' }}
                </button>
              </div>
              
              <transition name="edit-content" mode="out-in">
                <div v-if="editingSection !== 'personal'" class="summary-content" key="view">
                  <div class="summary-item">
                    <span class="summary-label">Name:</span>
                    <span class="summary-value">{{ formData.firstName }} {{ formData.lastName }}</span>
                  </div>
                  <div class="summary-item">
                    <span class="summary-label">E-Mail:</span>
                    <span class="summary-value">{{ formData.email }}</span>
                  </div>
                  <div class="summary-item">
                    <span class="summary-label">Telefon:</span>
                    <span class="summary-value">{{ formData.countryCode }} {{ formData.phone }}</span>
                  </div>
                  <div v-if="formData.company" class="summary-item">
                    <span class="summary-label">Unternehmen:</span>
                    <span class="summary-value">{{ formData.company }}</span>
                  </div>
                </div>
                
                <div v-else class="edit-content" key="edit">
                  <div class="edit-fields">
                    <div class="field-grid">
                      <div class="form-group" :class="{ 'has-error': errors.firstName, 'has-success': formData.firstName && !errors.firstName }">
                        <label for="edit-firstName">
                          <span class="material-icons">badge</span>
                          Vorname *
                        </label>
                        <div class="input-wrapper">
                          <input 
                            type="text" 
                            id="edit-firstName" 
                            v-model="formData.firstName"
                            @input="validateField('firstName')"
                            @blur="validateField('firstName')"
                            @focus="clearError('firstName')"
                            :class="{ 'invalid': errors.firstName, 'valid': formData.firstName && !errors.firstName }"
                            placeholder="Ihr Vorname..."
                          >
                          <div class="input-border"></div>
                        </div>
                        <transition name="error">
                          <div v-if="errors.firstName" class="error-message">
                            <span class="material-icons">error</span>
                            {{ errorMessages.firstName }}
                          </div>
                        </transition>
                      </div>
                      
                      <div class="form-group" :class="{ 'has-error': errors.lastName, 'has-success': formData.lastName && !errors.lastName }">
                        <label for="edit-lastName">
                          <span class="material-icons">badge</span>
                          Nachname *
                        </label>
                        <div class="input-wrapper">
                          <input 
                            type="text" 
                            id="edit-lastName" 
                            v-model="formData.lastName"
                            @input="validateField('lastName')"
                            @blur="validateField('lastName')"
                            @focus="clearError('lastName')"
                            :class="{ 'invalid': errors.lastName, 'valid': formData.lastName && !errors.lastName }"
                            placeholder="Ihr Nachname..."
                          >
                          <div class="input-border"></div>
                        </div>
                        <transition name="error">
                          <div v-if="errors.lastName" class="error-message">
                            <span class="material-icons">error</span>
                            {{ errorMessages.lastName }}
                          </div>
                        </transition>
                      </div>
                    </div>
                    
                    <div class="form-group" :class="{ 'has-error': errors.email, 'has-success': formData.email && !errors.email }">
                      <label for="edit-email">
                        <span class="material-icons">email</span>
                        E-Mail-Adresse *
                      </label>
                      <div class="input-wrapper">
                        <input 
                          type="email" 
                          id="edit-email" 
                          v-model="formData.email"
                          @input="validateField('email')"
                          @blur="validateField('email')"
                          @focus="clearError('email')"
                          :class="{ 'invalid': errors.email, 'valid': formData.email && !errors.email }"
                          placeholder="ihre.email@beispiel.de"
                        >
                        <div class="input-border"></div>
                      </div>
                      <transition name="error">
                        <div v-if="errors.email" class="error-message">
                          <span class="material-icons">error</span>
                          {{ errorMessages.email }}
                        </div>
                      </transition>
                    </div>
                    
                    <div class="form-group" :class="{ 'has-error': errors.phone, 'has-success': formData.phone && !errors.phone }">
                      <label for="edit-phone">
                        <span class="material-icons">phone</span>
                        Telefonnummer *
                      </label>
                      <div class="phone-input-group">
                        <div class="country-select-wrapper">
                          <select v-model="formData.countryCode" class="country-select">
                            <option value="+49">🇩🇪 +49</option>
                            <option value="+43">🇦🇹 +43</option>
                            <option value="+41">🇨🇭 +41</option>
                          </select>
                        </div>
                        <div class="input-wrapper flex-1">
                          <input 
                            type="tel" 
                            id="edit-phone" 
                            v-model="formData.phone"
                            @input="validateField('phone')"
                            @blur="validateField('phone')"
                            @focus="clearError('phone')"
                            :class="{ 'invalid': errors.phone, 'valid': formData.phone && !errors.phone }"
                            placeholder="0123 456789"
                          >
                          <div class="input-border"></div>
                        </div>
                      </div>
                      <transition name="error">
                        <div v-if="errors.phone" class="error-message">
                          <span class="material-icons">error</span>
                          {{ errorMessages.phone }}
                        </div>
                      </transition>
                    </div>

                    <div class="form-group">
                      <label for="edit-company">
                        <span class="material-icons">business</span>
                        Unternehmen (optional)
                      </label>
                      <div class="input-wrapper">
                        <input 
                          type="text" 
                          id="edit-company" 
                          v-model="formData.company"
                          placeholder="Ihr Unternehmen..."
                        >
                        <div class="input-border"></div>
                      </div>
                    </div>
                  </div>
                </div>
              </transition>
            </div>
            
            <div class="summary-section" :class="{ 'editing': editingSection === 'project' }">
              <div class="summary-header">
                <div class="header-left">
                  <span class="material-icons">home_work</span>
                  <h3>Projektdetails</h3>
                </div>
                <button 
                  @click="editSection('project')" 
                  class="edit-button"
                  :class="{ 'active': editingSection === 'project' }"
                >
                  <span class="material-icons">{{ editingSection === 'project' ? 'close' : 'edit' }}</span>
                  {{ editingSection === 'project' ? 'Schließen' : 'Bearbeiten' }}
                </button>
              </div>
              
              <transition name="edit-content" mode="out-in">
                <div v-if="editingSection !== 'project'" class="summary-content" key="view">
                  <div class="summary-item">
                    <span class="summary-label">Projekttyp:</span>
                    <span class="summary-value">{{ formData.projectType }}</span>
                  </div>
                  <div class="summary-item">
                    <span class="summary-label">Bereich:</span>
                    <span class="summary-value">{{ formData.room }}</span>
                  </div>
                  <div class="summary-item">
                    <span class="summary-label">Fläche:</span>
                    <span class="summary-value">{{ formData.size }} m²</span>
                  </div>
                  <div v-if="formData.timeline" class="summary-item">
                    <span class="summary-label">Zeitrahmen:</span>
                    <span class="summary-value">{{ getTimelineLabel(formData.timeline) }}</span>
                  </div>
                  <div v-if="formData.message" class="summary-item">
                    <span class="summary-label">Nachricht:</span>
                    <span class="summary-value message">{{ formData.message }}</span>
                  </div>
                </div>
                
                <div v-else class="edit-content" key="edit">
                  <div class="edit-fields">
                    <div class="field-grid">
                      <div class="form-group" :class="{ 'has-error': errors.projectType, 'has-success': formData.projectType && !errors.projectType }">
                        <label for="edit-projectType">
                          <span class="custom-icon project-icon"></span>
                          Projekttyp *
                        </label>
                        <div class="select-wrapper">
                          <select 
                            v-model="formData.projectType" 
                            @change="validateField('projectType')"
                            :class="{ 'invalid': errors.projectType, 'valid': formData.projectType && !errors.projectType }"
                            class="luxury-select"
                            id="edit-projectType"
                          >
                            <option value="">Bitte wählen...</option>
                            <option value="Neubau">Neubau</option>
                            <option value="Renovierung">Renovierung</option>
                            <option value="Sanierung">Sanierung</option>
                            <option value="Erweiterung">Erweiterung</option>
                          </select>
                          <div class="select-border"></div>
                          <span class="select-arrow material-icons">expand_more</span>
                        </div>
                        <transition name="error">
                          <div v-if="errors.projectType" class="error-message">
                            <span class="material-icons">error</span>
                            {{ errorMessages.projectType }}
                          </div>
                        </transition>
                      </div>

                      <div class="form-group" :class="{ 'has-error': errors.room, 'has-success': formData.room && !errors.room }">
                        <label for="edit-room">
                          <span class="custom-icon room-icon"></span>
                          Bereich *
                        </label>
                        <div class="select-wrapper">
                          <select 
                            v-model="formData.room" 
                            @change="validateField('room')"
                            :class="{ 'invalid': errors.room, 'valid': formData.room && !errors.room }"
                            class="luxury-select"
                            id="edit-room"
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
                          <div class="select-border"></div>
                          <span class="select-arrow material-icons">expand_more</span>
                        </div>
                        <transition name="error">
                          <div v-if="errors.room" class="error-message">
                            <span class="material-icons">error</span>
                            {{ errorMessages.room }}
                          </div>
                        </transition>
                      </div>
                    </div>
                    
                    <div class="form-group" :class="{ 'has-error': errors.size, 'has-success': formData.size && !errors.size }">
                      <label for="edit-size">
                        <span class="material-icons">square_foot</span>
                        Ungefähre Fläche in m² *
                      </label>
                      <div class="input-wrapper">
                        <input 
                          type="number" 
                          id="edit-size" 
                          v-model="formData.size"
                          @input="validateField('size')"
                          @blur="validateField('size')"
                          @focus="clearError('size')"
                          :class="{ 'invalid': errors.size, 'valid': formData.size && !errors.size }"
                          placeholder="z.B. 25"
                          min="1"
                          max="10000"
                        >
                        <div class="input-border"></div>
                        <div class="input-suffix">m²</div>
                      </div>
                      <transition name="error">
                        <div v-if="errors.size" class="error-message">
                          <span class="material-icons">error</span>
                          {{ errorMessages.size }}
                        </div>
                      </transition>
                    </div>

                    <div class="form-group">
                      <label for="edit-message">
                        <span class="material-icons">message</span>
                        Ihre Nachricht (optional)
                      </label>
                      <div class="textarea-wrapper">
                        <textarea 
                          id="edit-message" 
                          v-model="formData.message"
                          rows="4"
                          placeholder="Beschreiben Sie Ihr Projekt oder stellen Sie uns Ihre Fragen..."
                        ></textarea>
                        <div class="textarea-border"></div>
                      </div>
                    </div>

                    <div class="form-group">
                      <label for="edit-timeline">
                        <span class="material-icons">schedule</span>
                        Gewünschter Zeitrahmen (optional)
                      </label>
                      <div class="select-wrapper">
                        <select v-model="formData.timeline" class="luxury-select" id="edit-timeline">
                          <option value="">Keine Angabe</option>
                          <option value="sofort">So schnell wie möglich</option>
                          <option value="1-monat">Innerhalb 1 Monat</option>
                          <option value="3-monate">Innerhalb 3 Monate</option>
                          <option value="6-monate">Innerhalb 6 Monate</option>
                          <option value="planung">Noch in Planung</option>
                        </select>
                        <div class="select-border"></div>
                        <span class="select-arrow material-icons">expand_more</span>
                      </div>
                    </div>
                  </div>
                </div>
              </transition>
            </div>
          </div>

          <div class="privacy-section">
            <div class="privacy-checkbox">
              <label class="checkbox-wrapper">
                <input type="checkbox" v-model="privacyAccepted" @change="validatePrivacy">
                <span class="checkmark">
                  <span class="material-icons">check</span>
                </span>
                <span class="checkbox-text">
                  Ich habe die <a href="/datenschutz" target="_blank">Datenschutzerklärung</a> gelesen und akzeptiere diese.*
                </span>
              </label>
            </div>
            <transition name="error">
              <div v-if="errors.privacy" class="error-message">
                <span class="material-icons">error</span>
                {{ errorMessages.privacy }}
              </div>
            </transition>
          </div>
        </div>
      </transition>
      
      <!-- Navigation -->
      <div class="form-navigation">
        <button 
          v-if="currentStep > 1"
          @click="previousStep"
          class="nav-button back-button"
        >
          <span class="material-icons">arrow_back</span>
          Zurück
        </button>
        
        <button 
          v-if="currentStep < totalSteps"
          @click="nextStep"
          :disabled="!canProceed"
          class="nav-button next-button"
        >
          Weiter
          <span class="material-icons">arrow_forward</span>
        </button>
        
        <button 
          v-if="currentStep === totalSteps"
          @click="submitForm"
          :disabled="isSubmitting || !canSubmit"
          class="nav-button submit-button"
        >
          <span v-if="!isSubmitting" class="submit-content">
            <span class="material-icons">send</span>
            Anfrage absenden
          </span>
          <span v-else class="submit-loading">
            <div class="loader"></div>
            Wird gesendet...
          </span>
        </button>
      </div>
    </div>

    <!-- Success Modal -->
    <transition name="modal">
      <div v-if="showSuccessModal" class="success-modal-overlay" @click="closeSuccessModal">
        <div class="success-modal" @click.stop>
          <div class="success-animation">
            <div class="success-circle">
              <span class="material-icons">check</span>
            </div>
            <div class="success-particles">
              <div v-for="n in 8" :key="n" class="success-particle"></div>
            </div>
          </div>
          <h3>Vielen Dank!</h3>
          <p>Ihre Anfrage wurde erfolgreich übermittelt. Wir melden uns innerhalb von 24 Stunden bei Ihnen.</p>
          <button @click="closeSuccessModal" class="success-button">
            Schließen
          </button>
        </div>
      </div>
    </transition>
  </div>
</template>

<script setup>
import { ref, reactive, computed, watch } from 'vue'

const currentStep = ref(1)
const totalSteps = 3
const isSubmitting = ref(false)
const showSuccessModal = ref(false)
const privacyAccepted = ref(false)
const editingSection = ref(null) // 'personal', 'project', or null

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
  budget: '',
  timeline: '',
  message: ''
})

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

const errorMessages = reactive({
  firstName: 'Bitte geben Sie einen gültigen Vornamen ein (mindestens 2 Zeichen)',
  lastName: 'Bitte geben Sie einen gültigen Nachnamen ein (mindestens 2 Zeichen)',
  email: 'Bitte geben Sie eine gültige E-Mail-Adresse ein',
  phone: 'Bitte geben Sie eine gültige Telefonnummer ein (mindestens 5 Ziffern)',
  projectType: 'Bitte wählen Sie einen Projekttyp aus',
  room: 'Bitte wählen Sie einen Bereich aus',
  size: 'Bitte geben Sie eine gültige Fläche ein (1-10000 m²)',
  privacy: 'Bitte akzeptieren Sie die Datenschutzerklärung'
})

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

const getStepLabel = (step) => {
  const labels = {
    1: 'Kontaktdaten',
    2: 'Projektdetails', 
    3: 'Bestätigung'
  }
  return labels[step] || ''
}

const getBudgetLabel = (budget) => {
  const labels = {
    'bis-5000': 'Bis 5.000 €',
    '5000-15000': '5.000 - 15.000 €',
    '15000-30000': '15.000 - 30.000 €',
    '30000-50000': '30.000 - 50.000 €',
    'ab-50000': 'Ab 50.000 €'
  }
  return labels[budget] || budget
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

const editSection = (section) => {
  if (editingSection.value === section) {
    editingSection.value = null
  } else {
    editingSection.value = section
  }
}

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
}

const validatePrivacy = () => {
  errors.privacy = !privacyAccepted.value
}

const clearError = (field) => {
  errors[field] = false
}

const nextStep = () => {
  if (canProceed.value && currentStep.value < totalSteps) {
    editingSection.value = null // Close any editing sections when moving to next step
    currentStep.value++
  }
}

const previousStep = () => {
  if (currentStep.value > 1) {
    editingSection.value = null // Close any editing sections when moving back
    currentStep.value--
  }
}

const goToStep = (step) => {
  if (step >= 1 && step <= totalSteps) {
    editingSection.value = null
    currentStep.value = step
  }
}

const submitForm = async () => {
  // Final validation
  validatePrivacy()
  Object.keys(formData).forEach(key => {
    if (['firstName', 'lastName', 'email', 'phone', 'projectType', 'room', 'size'].includes(key)) {
      validateField(key)
    }
  })
  
  if (!canSubmit.value) {
    return
  }
  
  isSubmitting.value = true
  
  try {
    // Simulate API call
    await new Promise(resolve => setTimeout(resolve, 2000))
    
    console.log('Form submitted:', formData)
    
    showSuccessModal.value = true
    
    // Reset form
    Object.keys(formData).forEach(key => {
      if (typeof formData[key] === 'string') {
        formData[key] = ''
      }
    })
    formData.countryCode = '+49'
    privacyAccepted.value = false
    editingSection.value = null
    currentStep.value = 1
    
  } catch (error) {
    console.error('Error submitting form:', error)
    alert('Es ist ein Fehler aufgetreten. Bitte versuchen Sie es erneut.')
  } finally {
    isSubmitting.value = false
  }
}

const closeSuccessModal = () => {
  showSuccessModal.value = false
}
</script>

<style scoped>
@import url('https://fonts.googleapis.com/icon?family=Material+Icons');

.luxury-contact-form {
  min-height: 100vh;
  background: linear-gradient(135deg, #0a0a0a 0%, #1a1a1a 50%, #0f0f0f 100%);
  color: #FAFAF8;
  position: relative;
  overflow: hidden;
  padding: 6rem 2rem;
}

.form-background {
  position: fixed;
  inset: 0;
  pointer-events: none;
  z-index: 1;
}

.background-particles {
  position: absolute;
  inset: 0;
  overflow: hidden;
}

.bg-particle {
  position: absolute;
  width: 4px;
  height: 4px;
  background: radial-gradient(circle, #a47148, transparent);
  border-radius: 50%;
  animation: particleFloat 5s ease-in-out infinite;
}

@keyframes particleFloat {
  0%, 100% {
    transform: translateY(0) translateX(0) scale(0);
    opacity: 0;
  }
  10% {
    opacity: 1;
    transform: translateY(-20px) translateX(10px) scale(1);
  }
  90% {
    opacity: 1;
    transform: translateY(-100px) translateX(-10px) scale(0.5);
  }
  100% {
    opacity: 0;
  }
}

.morphing-shapes {
  position: absolute;
  inset: 0;
}

.shape {
  position: absolute;
  border-radius: 50%;
  filter: blur(60px);
  animation: shapeMorph 12s ease-in-out infinite;
  opacity: 0.1;
}

.shape-1 {
  width: 300px;
  height: 300px;
  background: radial-gradient(circle, #a47148, transparent);
  top: 10%;
  left: 10%;
}

.shape-2 {
  width: 200px;
  height: 200px;
  background: radial-gradient(circle, #FAFAF8, transparent);
  top: 60%;
  right: 20%;
  animation-delay: -4s;
}

.shape-3 {
  width: 250px;
  height: 250px;
  background: radial-gradient(circle, #a47148, transparent);
  bottom: 10%;
  left: 30%;
  animation-delay: -8s;
}

@keyframes shapeMorph {
  0%, 100% {
    transform: scale(1) rotate(0deg);
    border-radius: 50%;
  }
  25% {
    transform: scale(1.2) rotate(90deg);
    border-radius: 30% 70% 70% 30% / 30% 30% 70% 70%;
  }
  50% {
    transform: scale(0.8) rotate(180deg);
    border-radius: 70% 30% 30% 70% / 70% 70% 30% 30%;
  }
  75% {
    transform: scale(1.1) rotate(270deg);
    border-radius: 40% 60% 60% 40% / 60% 40% 60% 40%;
  }
}

.form-container {
  max-width: 800px;
  margin: 0 auto;
  position: relative;
  z-index: 2;
}

.form-header {
  text-align: center;
  margin-bottom: 4rem;
}

.header-decoration {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 2rem;
  margin-bottom: 2rem;
}

.decoration-line {
  width: 100px;
  height: 1px;
  background: linear-gradient(90deg, transparent, #a47148);
}

.decoration-line.left {
  background: linear-gradient(90deg, transparent, #a47148);
}

.decoration-line.right {
  background: linear-gradient(90deg, #a47148, transparent);
}

.form-badge {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.75rem 1.5rem;
  background: linear-gradient(135deg, rgba(164, 113, 72, 0.2), rgba(255, 255, 255, 0.05));
  border: 1px solid rgba(164, 113, 72, 0.3);
  border-radius: 50px;
  backdrop-filter: blur(20px);
  animation: badgeGlow 3s ease-in-out infinite;
  font-size: 0.75rem;
  letter-spacing: 0.1em;
  font-weight: 600;
  color: #a47148;
}

@keyframes badgeGlow {
  0%, 100% { box-shadow: 0 0 0 rgba(164, 113, 72, 0.5); }
  50% { box-shadow: 0 0 30px rgba(164, 113, 72, 0.4); }
}

.form-title {
  font-size: 3rem;
  font-weight: 300;
  margin-bottom: 1rem;
  line-height: 1.2;
}

.title-gradient {
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

.form-subtitle {
  font-size: 1.2rem;
  color: #ccc;
  font-weight: 300;
}

/* Progress Bar */
.progress-container {
  margin-bottom: 4rem;
}

.progress-steps {
  display: flex;
  justify-content: space-between;
  margin-bottom: 2rem;
  position: relative;
}

.progress-step {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.5rem;
  flex: 1;
  position: relative;
}

.step-circle {
  width: 50px;
  height: 50px;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.1);
  border: 2px solid rgba(255, 255, 255, 0.2);
  display: flex;
  align-items: center;
  justify-content: center;
  color: #ccc;
  font-weight: 600;
  transition: all 0.6s ease;
  position: relative;
  overflow: hidden;
}

.progress-step::before {
  content: '';
  position: absolute;
  top: 50%;
  left: 75%;
  right: -25%;
  height: 2px;
  background: rgba(255, 255, 255, 0.2);
  transform: translateY(-50%);
  z-index: -1;
}

.progress-step:last-child::before {
  display: none;
}

.progress-step.active .step-circle {
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  border-color: #a47148;
  color: #000;
  box-shadow: 0 0 30px rgba(164, 113, 72, 0.6);
  animation: stepPulse 2s ease-in-out infinite;
}

.progress-step.completed .step-circle {
  background: #a47148;
  border-color: #a47148;
  color: #FAFAF8;
}

.progress-step.completed::before {
  background: #a47148;
}

@keyframes stepPulse {
  0%, 100% { transform: scale(1); }
  50% { transform: scale(1.1); }
}

.step-label {
  font-size: 0.875rem;
  color: #ccc;
  text-align: center;
  transition: color 0.3s ease;
}

.progress-step.active .step-label,
.progress-step.completed .step-label {
  color: #a47148;
  font-weight: 500;
}

/* Form Steps */
.form-step {
  background: linear-gradient(135deg, rgba(255, 255, 255, 0.05) 0%, rgba(255, 255, 255, 0.02) 100%);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 24px;
  padding: 3rem;
  backdrop-filter: blur(20px);
  margin-bottom: 3rem;
  position: relative;
  overflow: hidden;
}

.form-step::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 1px;
  background: linear-gradient(90deg, transparent, #a47148, transparent);
}

.step-header {
  text-align: center;
  margin-bottom: 3rem;
}

.step-icon {
  width: 80px;
  height: 80px;
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 2rem;
  animation: iconFloat 3s ease-in-out infinite;
}

@keyframes iconFloat {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(-10px); }
}

.step-icon .material-icons {
  font-size: 2.5rem;
  color: #000;
}

.step-title {
  font-size: 2rem;
  font-weight: 400;
  margin-bottom: 1rem;
  background: linear-gradient(135deg, #FAFAF8 0%, #a47148 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.step-subtitle {
  font-size: 1.1rem;
  color: #ccc;
  line-height: 1.6;
}

/* Form Fields */
.form-fields,
.edit-fields {
  display: flex;
  flex-direction: column;
  gap: 2rem;
}

.field-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 2rem;
}

.form-group {
  position: relative;
}

.form-group label {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  margin-bottom: 1rem;
  font-weight: 500;
  color: #FAFAF8;
  font-size: 1rem;
}

.form-group label .material-icons {
  color: #a47148;
  font-size: 1.25rem;
}

.input-wrapper {
  position: relative;
  display: flex;
  align-items: center;
}

.input-wrapper.flex-1 {
  flex: 1;
}

.form-group input,
.luxury-select {
  width: 100%;
  background: rgba(255, 255, 255, 0.05);
  border: 2px solid rgba(255, 255, 255, 0.1);
  border-radius: 12px;
  color: #FAFAF8;
  padding: 1rem 1.5rem;
  font-size: 1rem;
  transition: all 0.4s ease;
  position: relative;
  z-index: 2;
}

.form-group input:focus,
.luxury-select:focus {
  outline: none;
  border-color: #a47148;
  background: rgba(255, 255, 255, 0.08);
  box-shadow: 0 0 30px rgba(164, 113, 72, 0.3);
}

.form-group input.valid {
  border-color: #4CAF50;
  box-shadow: 0 0 20px rgba(76, 175, 80, 0.2);
}

.form-group input.invalid,
.luxury-select.invalid {
  border-color: #e74c3c;
  box-shadow: 0 0 20px rgba(231, 76, 60, 0.2);
  animation: shake 0.5s ease-in-out;
}

@keyframes shake {
  0%, 100% { transform: translateX(0); }
  25% { transform: translateX(-5px); }
  75% { transform: translateX(5px); }
}

.input-border {
  position: absolute;
  inset: 0;
  border-radius: 12px;
  background: linear-gradient(45deg, transparent, rgba(164, 113, 72, 0.3), transparent);
  opacity: 0;
  transition: opacity 0.4s ease;
  z-index: 1;
}

.form-group.has-success .input-border {
  background: linear-gradient(45deg, transparent, rgba(76, 175, 80, 0.3), transparent);
  opacity: 1;
}

.input-suffix {
  position: absolute;
  right: 1rem;
  color: #a47148;
  font-weight: 500;
  z-index: 3;
}

.field-particles {
  position: absolute;
  inset: 0;
  border-radius: 12px;
  overflow: hidden;
  pointer-events: none;
}

.field-particle {
  position: absolute;
  width: 3px;
  height: 3px;
  background: #a47148;
  border-radius: 50%;
  opacity: 0;
  animation: fieldParticleFloat 3s ease-out infinite;
}

.field-particle:nth-child(1) { top: 20%; left: 20%; animation-delay: 0s; }
.field-particle:nth-child(2) { top: 40%; left: 80%; animation-delay: 0.5s; }
.field-particle:nth-child(3) { top: 70%; left: 30%; animation-delay: 1s; }
.field-particle:nth-child(4) { top: 80%; left: 70%; animation-delay: 1.5s; }
.field-particle:nth-child(5) { top: 30%; left: 50%; animation-delay: 2s; }

@keyframes fieldParticleFloat {
  0%, 100% {
    opacity: 0;
    transform: translateY(0) scale(0);
  }
  50% {
    opacity: 1;
    transform: translateY(-10px) scale(1);
  }
}

.form-group.has-success .field-particle {
  background: #4CAF50;
  animation-duration: 2s;
}

/* Phone Input */
.phone-input-group {
  display: flex;
  gap: 1rem;
  align-items: stretch;
}

.country-select-wrapper {
  flex: 0 0 120px;
}

.country-select {
  width: 100%;
  background: rgba(255, 255, 255, 0.05);
  border: 2px solid rgba(255, 255, 255, 0.1);
  border-radius: 12px;
  color: #FAFAF8;
  padding: 1rem;
  font-size: 0.875rem;
  cursor: pointer;
}

/* Select Styling */
.select-wrapper {
  position: relative;
}

.luxury-select {
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
  background-image: none;
  cursor: pointer;
}

.select-arrow {
  position: absolute;
  right: 1rem;
  top: 50%;
  transform: translateY(-50%);
  color: #a47148;
  pointer-events: none;
  z-index: 3;
  transition: transform 0.3s ease;
}

.luxury-select:focus + .select-border + .select-arrow {
  transform: translateY(-50%) rotate(180deg);
}
.select-border {
  position: absolute;
  inset: 0;
  border-radius: 12px;
  background: linear-gradient(45deg, transparent, rgba(164, 113, 72, 0.3), transparent);
  opacity: 0;
  transition: opacity 0.4s ease;
  z-index: 1;
}

.luxury-select:focus + .select-border {
  opacity: 1;
}

/* Textarea */
.textarea-wrapper {
  position: relative;
}

.form-group textarea {
  width: 100%;
  background: rgba(255, 255, 255, 0.05);
  border: 2px solid rgba(255, 255, 255, 0.1);
  border-radius: 12px;
  color: #FAFAF8;
  padding: 1rem 1.5rem;
  font-size: 1rem;
  resize: vertical;
  min-height: 120px;
  transition: all 0.4s ease;
  font-family: inherit;
}

.form-group textarea:focus {
  outline: none;
  border-color: #a47148;
  background: rgba(255, 255, 255, 0.08);
  box-shadow: 0 0 30px rgba(164, 113, 72, 0.3);
}

.textarea-border {
  position: absolute;
  inset: 0;
  border-radius: 12px;
  background: linear-gradient(45deg, transparent, rgba(164, 113, 72, 0.3), transparent);
  opacity: 0;
  transition: opacity 0.4s ease;
  z-index: 1;
}

.form-group textarea:focus + .textarea-border {
  opacity: 1;
}

/* Error Messages */
.error-message {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  color: #e74c3c;
  font-size: 0.875rem;
  margin-top: 0.5rem;
  animation: errorSlideIn 0.3s ease-out;
}

@keyframes errorSlideIn {
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
  font-size: 1rem;
}

/* Summary */
.summary-container {
  display: flex;
  flex-direction: column;
  gap: 2rem;
}

.summary-section {
  background: rgba(255, 255, 255, 0.03);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 16px;
  padding: 2rem;
  transition: all 0.3s ease;
  position: relative;
  overflow: hidden;
}

.summary-section:hover {
  background: rgba(255, 255, 255, 0.05);
  transform: translateY(-2px);
}

.summary-section.editing {
  background: rgba(164, 113, 72, 0.05);
  border-color: rgba(164, 113, 72, 0.3);
  box-shadow: 0 0 30px rgba(164, 113, 72, 0.2);
}

.summary-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 1.5rem;
  padding-bottom: 1rem;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.header-left {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.summary-header .material-icons {
  color: #a47148;
  font-size: 1.5rem;
}

.summary-header h3 {
  font-size: 1.25rem;
  font-weight: 500;
  color: #FAFAF8;
}

.edit-button {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.75rem 1.5rem;
  background: transparent;
  border: 2px solid rgba(164, 113, 72, 0.3);
  border-radius: 50px;
  color: #a47148;
  font-size: 0.875rem;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.3s ease;
}

.edit-button:hover {
  background: rgba(164, 113, 72, 0.1);
  border-color: #a47148;
  transform: translateY(-2px);
  box-shadow: 0 5px 15px rgba(164, 113, 72, 0.2);
}

.edit-button.active {
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  border-color: #a47148;
  color: #000;
}

.edit-button .material-icons {
  font-size: 1rem;
}

.summary-content {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.summary-item {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  gap: 1rem;
}

.summary-label {
  color: #ccc;
  font-weight: 500;
  min-width: 120px;
}

.summary-value {
  color: #FAFAF8;
  text-align: right;
  flex: 1;
}

.summary-value.message {
  text-align: left;
  font-style: italic;
  line-height: 1.5;
}

.edit-content {
  padding-top: 1rem;
}

/* Privacy Section */
.privacy-section {
  margin-top: 2rem;
  padding: 2rem;
  background: rgba(255, 255, 255, 0.03);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 16px;
}

.checkbox-wrapper {
  display: flex;
  align-items: flex-start;
  gap: 1rem;
  cursor: pointer;
  position: relative;
}

.checkbox-wrapper input[type="checkbox"] {
  display: none;
}

.checkmark {
  width: 24px;
  height: 24px;
  border: 2px solid rgba(255, 255, 255, 0.3);
  border-radius: 6px;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.3s ease;
  flex-shrink: 0;
  margin-top: 2px;
}

.checkmark .material-icons {
  font-size: 16px;
  color: #FAFAF8;
  opacity: 0;
  transform: scale(0);
  transition: all 0.3s ease;
}

.checkbox-wrapper input:checked + .checkmark {
  background: #a47148;
  border-color: #a47148;
  box-shadow: 0 0 20px rgba(164, 113, 72, 0.4);
}

.checkbox-wrapper input:checked + .checkmark .material-icons {
  opacity: 1;
  transform: scale(1);
}

.checkbox-text {
  color: #ccc;
  line-height: 1.5;
  font-size: 0.95rem;
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
.form-navigation {
  display: flex;
  gap: 1rem;
  justify-content: center;
  margin-top: 3rem;
}

.nav-button {
  display: inline-flex;
  align-items: center;
  gap: 0.75rem;
  padding: 1rem 2.5rem;
  font-size: 1rem;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  border-radius: 50px;
  cursor: pointer;
  transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  position: relative;
  overflow: hidden;
  border: none;
}

.back-button {
  background: transparent;
  color: #FAFAF8;
  border: 2px solid rgba(255, 255, 255, 0.3);
}

.back-button:hover {
  border-color: #FAFAF8;
  background: rgba(255, 255, 255, 0.1);
  transform: translateY(-3px);
}

.next-button,
.submit-button {
  background: linear-gradient(135deg, #a47148, #FAFAF8);
  color: #000;
  border: none;
}

.next-button:hover,
.submit-button:hover:not(:disabled) {
  transform: translateY(-3px);
  box-shadow: 0 15px 30px rgba(164, 113, 72, 0.4);
}

.nav-button:disabled {
  opacity: 0.5;
  cursor: not-allowed;
  transform: none !important;
  box-shadow: none !important;
}

.submit-content,
.submit-loading {
  display: flex;
  align-items: center;
  gap: 0.75rem;
}

.loader {
  width: 20px;
  height: 20px;
  border: 3px solid rgba(0, 0, 0, 0.3);
  border-radius: 50%;
  border-top-color: #000;
  animation: spin 0.8s ease-in-out infinite;
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
}

.success-modal {
  background: linear-gradient(135deg, #1a1a1a 0%, #0a0a0a 100%);
  border-radius: 24px;
  padding: 3rem;
  text-align: center;
  max-width: 500px;
  width: 90%;
  border: 1px solid rgba(255, 255, 255, 0.1);
  position: relative;
}

.success-animation {
  position: relative;
  margin-bottom: 2rem;
}

.success-circle {
  width: 100px;
  height: 100px;
  background: linear-gradient(135deg, #4CAF50, #8BC34A);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto;
  animation: successBounce 0.6s ease-out;
}

@keyframes successBounce {
  0% { transform: scale(0); }
  50% { transform: scale(1.2); }
  100% { transform: scale(1); }
}

.success-circle .material-icons {
  font-size: 3rem;
  color: #FAFAF8;
}

.success-particles {
  position: absolute;
  inset: -50px;
}

.success-particle {
  position: absolute;
  width: 6px;
  height: 6px;
  background: #4CAF50;
  border-radius: 50%;
  animation: successParticleExplode 1s ease-out infinite;
}

.success-particle:nth-child(1) { top: 50%; left: 50%; animation-delay: 0s; }
.success-particle:nth-child(2) { top: 30%; left: 70%; animation-delay: 0.1s; }
.success-particle:nth-child(3) { top: 70%; left: 30%; animation-delay: 0.2s; }
.success-particle:nth-child(4) { top: 20%; left: 50%; animation-delay: 0.3s; }
.success-particle:nth-child(5) { top: 80%; left: 50%; animation-delay: 0.4s; }
.success-particle:nth-child(6) { top: 50%; left: 20%; animation-delay: 0.5s; }
.success-particle:nth-child(7) { top: 50%; left: 80%; animation-delay: 0.6s; }
.success-particle:nth-child(8) { top: 40%; left: 40%; animation-delay: 0.7s; }

@keyframes successParticleExplode {
  0% {
    transform: translate(-50%, -50%) scale(0);
    opacity: 1;
  }
  100% {
    transform: translate(-50%, -50%) translateX(var(--random-x, 50px)) translateY(var(--random-y, -50px)) scale(1);
    opacity: 0;
  }
}

.success-modal h3 {
  font-size: 2rem;
  font-weight: 400;
  margin-bottom: 1rem;
  color: #4CAF50;
}

.success-modal p {
  font-size: 1.1rem;
  color: #ccc;
  line-height: 1.6;
  margin-bottom: 2rem;
}

.success-button {
  background: linear-gradient(135deg, #4CAF50, #8BC34A);
  color: #FAFAF8;
  border: none;
  padding: 1rem 2rem;
  border-radius: 50px;
  font-size: 1rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
}

.success-button:hover {
  transform: translateY(-3px);
  box-shadow: 0 15px 30px rgba(76, 175, 80, 0.4);
}

/* Transitions */
.step-enter-active,
.step-leave-active {
  transition: all 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

.step-enter-from {
  opacity: 0;
  transform: translateX(50px) scale(0.95);
}

.step-leave-to {
  opacity: 0;
  transform: translateX(-50px) scale(0.95);
}

.edit-content-enter-active,
.edit-content-leave-active {
  transition: all 0.4s ease;
}

.edit-content-enter-from {
  opacity: 0;
  transform: translateY(20px);
}

.edit-content-leave-to {
  opacity: 0;
  transform: translateY(-20px);
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

.modal-enter-active,
.modal-leave-active {
  transition: opacity 0.4s ease;
}

.modal-enter-from,
.modal-leave-to {
  opacity: 0;
}

.modal-enter-active .success-modal,
.modal-leave-active .success-modal {
  transition: transform 0.4s ease;
}

.modal-enter-from .success-modal,
.modal-leave-to .success-modal {
  transform: scale(0.8) rotateX(-15deg);
}

/* Custom CSS Icons */
.custom-icon {
  display: inline-block;
  width: 20px;
  height: 20px;
  position: relative;
  color: #a47148;
  flex-shrink: 0;
}

.project-icon::before {
  content: '';
  position: absolute;
  top: 2px;
  left: 3px;
  width: 14px;
  height: 10px;
  border: 2px solid currentColor;
  border-radius: 2px;
  background: transparent;
}

.project-icon::after {
  content: '';
  position: absolute;
  top: 8px;
  left: 8px;
  width: 4px;
  height: 4px;
  background: currentColor;
  border-radius: 50%;
}

.room-icon::before {
  content: '';
  position: absolute;
  top: 3px;
  left: 4px;
  width: 12px;
  height: 10px;
  border: 2px solid currentColor;
  border-bottom: none;
  border-radius: 6px 6px 0 0;
  background: transparent;
}

.room-icon::after {
  content: '';
  position: absolute;
  bottom: 3px;
  left: 2px;
  width: 16px;
  height: 6px;
  border: 2px solid currentColor;
  border-top: none;
  border-radius: 0 0 3px 3px;
  background: transparent;
}

/* Responsive */
@media (max-width: 768px) {
  .luxury-contact-form {
    padding: 3rem 1rem;
  }
  
  .form-container {
    max-width: 100%;
  }
  
  .form-title {
    font-size: 2.5rem;
  }
  
  .form-step {
    padding: 2rem;
  }
  
  .field-grid {
    grid-template-columns: 1fr;
    gap: 1.5rem;
  }
  
  .phone-input-group {
    flex-direction: column;
    gap: 1rem;
  }
  
  .country-select-wrapper {
    flex: none;
  }
  
  .form-navigation {
    flex-direction: column;
    align-items: center;
  }
  
  .nav-button {
    width: 100%;
    max-width: 300px;
    justify-content: center;
  }
  
  .progress-steps {
    gap: 1rem;
  }
  
  .step-label {
    font-size: 0.75rem;
  }
  
  .summary-item {
    flex-direction: column;
    gap: 0.5rem;
    align-items: flex-start;
  }
  
  .summary-value {
    text-align: left;
  }
  
  .summary-header {
    flex-direction: column;
    gap: 1rem;
    align-items: flex-start;
  }
  
  .edit-button {
    align-self: flex-start;
  }
}

@media (max-width: 480px) {
  .form-title {
    font-size: 2rem;
  }
  
  .step-title {
    font-size: 1.5rem;
  }
  
  .form-step {
    padding: 1.5rem;
  }
  
  .header-decoration {
    gap: 1rem;
  }
  
  .decoration-line {
    width: 50px;
  }
  
  .success-modal {
    padding: 2rem;
    margin: 1rem;
  }
}
</style>