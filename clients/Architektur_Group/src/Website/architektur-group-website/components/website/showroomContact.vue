<template>
  <section class="showrooms-section py-20 bg-black">
    <div class="container mx-auto px-6">
      <h2 class="text-4xl font-light text-center mb-12">UNSERE SHOWROOMS</h2>
      
      <div class="showrooms">
        <div class="showroom-item">
          <p class="showroom-title">Showroom Düsseldorf</p>
          <a class="showroom-phone" href="tel:+4921314501055">+49 2131 4501055</a>
        </div>
        
        <div class="showroom-item">
          <p class="showroom-title">Showroom Starnberg</p>
          <a class="showroom-phone" href="tel:+4981713868770">+49 8171 3868770</a>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped>
.showrooms {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 3rem;
}

.showroom-item {
  text-align: center;
}

.showroom-title {
  font-size: 20px;
  font-weight: 300;
  color: var(--primary-white);
  text-transform: uppercase;
  margin: 0;
}

.showroom-phone {
  display: inline-block;
  margin-top: 16px;
  font-size: 32px;
  font-weight: 300;
  color: var(--primary-white);
  text-decoration: none;
  transition: opacity 0.3s;
}

.showroom-phone:hover {
  opacity: 0.8;
}
</style>