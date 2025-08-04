// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  devtools: { enabled: true },
  modules: [
    '@nuxtjs/tailwindcss',
    '@vueuse/nuxt'
  ],
  css: ['~/assets/css/main.css'],
  app: {
    head: {
      title: 'Configuraid - Prozessoptimierung und Automatisierung',
      meta: [
        { charset: 'utf-8' },
        { name: 'viewport', content: 'width=device-width, initial-scale=1' },
        { 
          name: 'description', 
          content: 'Configuraid verwandelt komplexe Prozesse in effiziente, automatisierte Workflows – maßgeschneidert für Ihr Unternehmen. Bis zu 40% Zeitersparnis.' 
        },
        { name: 'keywords', content: 'Prozessoptimierung, Automatisierung, Webentwicklung, Geschäftsprozesse, Workflow-Optimierung, Digitale Transformation' },
        { name: 'author', content: 'Configuraid' },
        { property: 'og:title', content: 'Configuraid - Prozessoptimierung und Automatisierung' },
        { property: 'og:description', content: 'Verwandeln Sie komplexe Prozesse in effiziente, automatisierte Workflows' },
        { property: 'og:type', content: 'website' },
        { property: 'og:url', content: 'https://configuraid.de' },
        { name: 'twitter:card', content: 'summary_large_image' },
        { name: 'twitter:title', content: 'Configuraid - Prozessoptimierung und Automatisierung' },
        { name: 'twitter:description', content: 'Verwandeln Sie komplexe Prozesse in effiziente, automatisierte Workflows' }
      ],
      link: [
        { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' },
        { rel: 'preconnect', href: 'https://fonts.googleapis.com' },
        { rel: 'preconnect', href: 'https://fonts.gstatic.com', crossorigin: '' },
        { rel: 'stylesheet', href: 'https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Source+Sans+Pro:wght@300;400;600;700&display=swap' }
      ]
    }
  },
  tailwindcss: {
    config: {
      theme: {
        extend: {
          colors: {
            primary: {
              50: '#eff6ff',
              100: '#dbeafe',
              200: '#bfdbfe',
              300: '#93c5fd',
              400: '#60a5fa',
              500: '#3b82f6',
              600: '#2563eb',
              700: '#1d4ed8',
              800: '#1e40af',
              900: '#1e3a8a',
            },
            success: {
              50: '#ecfdf5',
              100: '#d1fae5',
              200: '#a7f3d0',
              300: '#6ee7b7',
              400: '#34d399',
              500: '#10b981',
              600: '#059669',
              700: '#047857',
              800: '#065f46',
              900: '#064e3b',
            },
            neutral: {
              50: '#f9fafb',
              100: '#f3f4f6',
              200: '#e5e7eb',
              300: '#d1d5db',
              400: '#9ca3af',
              500: '#6b7280',
              600: '#4b5563',
              700: '#374151',
              800: '#1f2937',
              900: '#111827',
            }
          },
          fontFamily: {
            'sans': ['Inter', 'sans-serif'],
            'body': ['Source Sans Pro', 'sans-serif']
          },
          animation: {
            'fade-in': 'fadeIn 0.5s ease-in-out',
            'slide-up': 'slideUp 0.5s ease-out',
            'bounce-subtle': 'bounceSubtle 2s infinite'
          },
          keyframes: {
            fadeIn: {
              '0%': { opacity: '0' },
              '100%': { opacity: '1' }
            },
            slideUp: {
              '0%': { transform: 'translateY(30px)', opacity: '0' },
              '100%': { transform: 'translateY(0)', opacity: '1' }
            },
            bounceSubtle: {
              '0%, 20%, 50%, 80%, 100%': { transform: 'translateY(0)' },
              '40%': { transform: 'translateY(-10px)' },
              '60%': { transform: 'translateY(-5px)' }
            }
          }
        }
      }
    }
  },
  nitro: {
    prerender: {
      routes: ['/sitemap.xml']
    }
  }
})