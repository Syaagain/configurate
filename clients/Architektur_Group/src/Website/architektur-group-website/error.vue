<template>
  <div class="error-page">
    <div class="error-container">
      <h1 class="error-code">{{ error.statusCode || 500 }}</h1>
      <h2 class="error-message">{{ error.statusMessage || 'Ein Fehler ist aufgetreten' }}</h2>
      <p class="error-description">{{ error.message }}</p>
      <NuxtLink to="/" class="error-button">
        Zurück zur Startseite
      </NuxtLink>
    </div>
  </div>
</template>

<script setup>
defineProps({
  error: Object
})
</script>

<style scoped>
.error-page {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: #000;
  color: #FAFAF8;
}

.error-container {
  text-align: center;
  padding: 2rem;
}

.error-code {
  font-size: 6rem;
  font-weight: 700;
  margin-bottom: 1rem;
  background: linear-gradient(135deg, #a47148 0%, #FAFAF8 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.error-message {
  font-size: 2rem;
  font-weight: 300;
  margin-bottom: 1rem;
}

.error-description {
  font-size: 1rem;
  color: #999;
  margin-bottom: 2rem;
}

.error-button {
  display: inline-block;
  padding: 0.75rem 2rem;
  background: transparent;
  color: #FAFAF8;
  border: 2px solid #FAFAF8;
  text-decoration: none;
  border-radius: 4px;
  transition: all 0.3s;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.error-button:hover {
  background: #FAFAF8;
  color: #000;
}
</style>