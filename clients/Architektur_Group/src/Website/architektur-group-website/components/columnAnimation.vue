<template>
  <section class="columns-section py-20">
    <div class="container mx-auto px-6">
      <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
        <div 
          v-for="(column, index) in columns" 
          :key="index"
          :id="column.id"
          class="column-item"
          :class="{ 'visible': column.visible }"
        >
          <div class="column-content">
            <h3 class="text-2xl font-light mb-4">{{ column.title }}</h3>
            <p class="text-gray-300">{{ column.description }}</p>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
const columns = ref([
  {
    id: 'col-wLM7mHCqtG',
    title: 'Exklusives Design',
    description: 'Maßgeschneiderte Natursteinlösungen für anspruchsvolle Architektur',
    visible: false
  },
  {
    id: 'col-Ih9DXcWvV6',
    title: 'Meisterhafte Verarbeitung',
    description: 'Präzision und Handwerkskunst in jedem Detail',
    visible: false
  },
  {
    id: 'col-YdIXzZFRP3',
    title: 'Zeitlose Eleganz',
    description: 'Naturstein, der Generationen überdauert',
    visible: false
  }
])

onMounted(() => {
  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        const index = columns.value.findIndex(col => col.id === entry.target.id)
        if (index !== -1) {
          columns.value[index].visible = true
        }
      }
    })
  }, {
    threshold: 0.1
  })

  columns.value.forEach(col => {
    const element = document.getElementById(col.id)
    if (element) observer.observe(element)
  })
})
</script>

<style scoped>
.column-item {
  overflow: hidden;
  clip-path: inset(0 70% 0 0);
  -webkit-clip-path: inset(0 70% 0 0);
  transition: clip-path 2s ease-out;
}

.column-item.visible {
  clip-path: inset(0 0 0 0);
  -webkit-clip-path: inset(0 0 0 0);
}

.column-content {
  background: linear-gradient(135deg, #1a1a1a 0%, #000 100%);
  padding: 3rem;
  border-radius: 8px;
  min-height: 300px;
  display: flex;
  flex-direction: column;
  justify-content: center;
}
</style>