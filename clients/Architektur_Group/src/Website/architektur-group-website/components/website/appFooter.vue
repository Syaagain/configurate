<template>
  <footer class="bg-black py-12 border-t border-gray-800">
    <div class="container mx-auto px-6">
      <!-- Main Footer Content -->
      <div class="footer-grid">
        <!-- Left Column (Showrooms) - Order 2 on mobile -->
        <div class="fade-in-left showrooms-column" style="--delay: 0.2s">
          <!-- Contact Information -->
          <div class="mb-12">
            <h3 class="text-lg font-light mb-6 uppercase showroom-header">Unsere Showrooms</h3>
            
            <div class="showroom-item mb-8">
              <h4 class="text-gray-400 mb-2">Düsseldorf</h4>
              <a href="tel:+4921314501055" class="showroom-phone">
                +49 2131 4501055
              </a>
            </div>

            <div class="showroom-item">
              <h4 class="text-gray-400 mb-2">Starnberg</h4>
              <a href="tel:+4981713868770" class="showroom-phone">
                +49 8171 3868770
              </a>
            </div>
          </div>

          <!-- Social Icons -->
          <div class="fade-in-left" style="--delay: 0.4s">
            <div class="flex flex-col gap-4">
              <h3 class="text-lg font-light uppercase mb-0">Folge uns</h3>
              <div class="social-icons-wrapper">
                <SocialIcons />
              </div>
            </div>
          </div>
        </div>

        <!-- Middle Column - Contact Form - Order 1 on mobile (appears first) -->
        <div class="fade-in-left contact-column" style="--delay: 0.6s">
          <div class="form-container">
            <form @submit.prevent="subscribeNewsletter">
              <h3 class="form-title">KONTAKT</h3>
              <p class="form-subtitle">Hinterlassen Sie Ihre Kontaktdaten, wir melden uns umgehend bei Ihnen.</p>
              
              <!-- Name Input -->
              <div class="input-group">
                <input 
                  type="text" 
                  v-model="name"
                  placeholder="Name"
                  required
                  class="form-input"
                ></input>
              </div>

              <!-- Email Input -->
              <div class="input-group">
                <input 
                  type="email" 
                  v-model="email"
                  placeholder="E-Mail Adresse"
                  required
                  class="form-input"
                >
              </div>

              <div class="checkbox-group">
                <label class="checkbox-label">
                  <input 
                    type="checkbox" 
                    v-model="wantsNewsletter"
                    required
                  >
                  <span>Ich möchte Newsletter erhalten.</span>
                </label>

                <label class="checkbox-label">
                  <input 
                    type="checkbox" 
                    v-model="acceptsPrivacy"
                    required
                  >
                  <span>Ich bin mit der Datenschutzbestimmung einverstanden.</span>
                </label>
              </div>

              <button type="submit" class="submit-btn">
                SENDEN
              </button>
            </form>
          </div>
        </div>

        <!-- Right Column - Empty - Order 3 on mobile -->
        <div class="fade-in-left empty-column" style="--delay: 0.8s"></div>
      </div>

      <!-- Legal Links -->
      <div class="mt-12 pt-8 border-t border-gray-800">
        <div class="flex flex-wrap justify-between items-center gap-4">
          <p class="text-gray-500 text-sm">
            &copy; {{ new Date().getFullYear() }} Architektur Group. Alle Rechte vorbehalten.
          </p>
          
          <div class="flex flex-wrap gap-6">
            <a href="#" class="text-sm text-gray-500 hover:text-[#a47148] transition-colors">Datenschutz</a>
            <a href="#" class="text-sm text-gray-500 hover:text-[#a47148] transition-colors">AGB</a>
            <a href="#" class="text-sm text-gray-500 hover:text-[#a47148] transition-colors">Impressum</a>
          </div>
        </div>
      </div>
    </div>
  </footer>
</template>

<script setup>
import SocialIcons from '~/components/website/socialIcons.vue'
import { ref, onMounted } from 'vue'

const email = ref('')
const name = ref('')
const wantsNewsletter = ref(false)
const acceptsPrivacy = ref(false)

const subscribeNewsletter = () => {
  console.log('Newsletter subscription:', email.value)
  email.value = ''
}

// Add intersection observer
onMounted(() => {
  const observer = new IntersectionObserver(
    (entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.classList.add('visible');
          observer.unobserve(entry.target);
        }
      });
    },
    { threshold: 0.1 }
  );

  document.querySelectorAll('.showroom-item').forEach(item => {
    observer.observe(item);
  });
});
</script>

<style scoped>
.fade-in-left {
  opacity: 0;
  transform: translateX(-20px);
  animation: fadeInLeft 0.8s ease-out forwards;
  animation-delay: var(--delay, 0s);
}

@keyframes fadeInLeft {
  from {
    opacity: 0;
    transform: translateX(-20px);
  }
  to {
    opacity: 1;
    transform: translateX(0);
  }
}

/* Preserve existing styles */
.container {
  max-width: 1400px;
}

/* Mobile-responsive footer grid */
.footer-grid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 4rem; /* Increased gap for mobile */
}

/* Mobile: Contact first, then Showrooms */
.contact-column {
  order: 1;
}

.showrooms-column {
  order: 2;
  margin-top: 2rem; /* Additional spacing on mobile */
}

.empty-column {
  order: 3;
  display: none; /* Hide empty column on mobile */
}

/* Desktop: Original order */
@media (min-width: 768px) {
  .footer-grid {
    grid-template-columns: 1fr 1fr 1fr;
    gap: 1rem;
  }
  
  .showrooms-column {
    order: 1;
    margin-top: 0; /* Reset margin for desktop */
  }
  
  .contact-column {
    order: 2;
  }
  
  .empty-column {
    order: 3;
    display: block;
  }
}

/* Mobile-specific adjustments */
@media (max-width: 767px) {
  .form-title {
    font-size: 28px;
    margin-bottom: 1.5rem;
  }
  
  .form-subtitle {
    font-size: 0.9rem;
    margin-bottom: 1.5rem;
  }
  
  .showroom-phone {
    font-size: 28px;
  }
  
  .showroom-header {
    margin-bottom: 1.5rem;
  }
  
  .mb-12 {
    margin-bottom: 2rem;
  }
  
  .checkbox-label {
    font-size: 0.85rem;
  }
  
  .submit-btn {
    width: 100%;
    min-width: unset;
  }
}

/* Enhanced hover effects */
a {
  position: relative;
  display: inline-block;
}

a::after {
  content: '';
  position: absolute;
  bottom: -2px;
  left: 0;
  width: 0;
  height: 1px;
  background: #a47148;
  transition: width 0.3s ease;
}

a:hover::after {
  width: 100%;
}

/* Form enhancements */
input::placeholder {
  color: #666;
}

input:focus {
  border-color: #a47148;
}

button {
  position: relative;
  overflow: hidden;
}

button::before {
  content: '';
  position: absolute;
  inset: 0;
  background: linear-gradient(90deg, transparent, rgba(164, 113, 72, 0.2), transparent);
  transform: translateX(-100%);
  transition: transform 0.6s ease;
}

button:hover::before {
  transform: translateX(100%);
}

.social-icons-wrapper {
  display: flex;
  align-items: flex-start;
  margin-top: 0.1rem;
}

.showroom-item {
  overflow: hidden;
  clip-path: inset(0 70% 0 0);
  -webkit-clip-path: inset(0 70% 0 0);
  transition: clip-path 2s ease-out, -webkit-clip-path 2s ease-out;
}

.showroom-item.visible {
  clip-path: inset(0 0 0 0);
  -webkit-clip-path: inset(0 0 0 0);
}

.showroom-phone {
  font-size: 32px;
  font-weight: 300;
  color: #FAFAF8;
  text-decoration: none;
  transition: color 0.3s ease;
  display: inline-block;
}

.showroom-phone:hover {
  color: #a47148;
}

/* New styles for the form section */
.form-container {
  width: 100%;
  padding: 0;
  box-shadow: none;
  background: transparent;
}

.form-title {
  color: white;
  font-size: 32px;
  font-weight: 300;
  margin-bottom: 2rem;
  text-transform: uppercase;
}

.form-subtitle {
  color: #999;
  font-size: 1rem;
  margin-bottom: 2rem;
  line-height: 1.5;
}

.input-group {
  margin-bottom: 1.5rem;
}

.form-input {
  width: 100%;
  height: 35px;
  background: none;
  border: none;
  border-bottom: 1px solid rgb(143, 143, 143);
  color: rgba(255, 255, 255, 0.555);
  padding: 0.5rem 0;
  transition: all 0.3s ease;
  margin-bottom: 1.5rem;
  outline: none; /* Remove focus outline */
}

.form-input:focus {
  border-bottom-color: white;
  outline: none; /* Remove focus outline */
}

.form-input::placeholder {
  color: rgba(255, 255, 255, 0.4); /* Increased placeholder visibility */
}

.checkbox-group {
  margin-bottom: 2rem;
}

.checkbox-label {
  display: flex;
  align-items: flex-start;
  gap: 0.75rem;
  margin-bottom: 1rem;
  cursor: pointer;
  color: rgba(255, 255, 255, 0.555);
  font-size: 0.9rem;
}

.checkbox-label input[type="checkbox"] {
  width: auto;
  height: auto;
  margin: 0.25rem 0 0 0;
}

.submit-btn {
  background: black;
  color: white;
  border: solid 1px white;
  border-radius: 8px;
  padding: 0.75rem 2rem;
  font-size: 0.9rem;
  letter-spacing: 0.1em;
  transition: all 0.3s ease;
  display: block; /* Make button block level */
  margin: 0 auto; /* Center the button */
  min-width: 200px; /* Give button a minimum width */
}

.submit-btn:hover {
  background: rgba(255, 255, 255, 0.9);
  transform: translateY(-2px);
}
</style>