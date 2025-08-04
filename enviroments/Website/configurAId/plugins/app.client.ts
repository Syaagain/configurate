/**
 * Client-side app initialization plugin
 * Handles global settings, analytics, and performance optimizations
 */

export default defineNuxtPlugin(() => {
  // Initialize Google Analytics if ID is provided
  const config = useRuntimeConfig()
  const analyticsId = config.public.googleAnalyticsId
  
  if (analyticsId && typeof window !== 'undefined') {
    // Initialize Google Analytics
    const script = document.createElement('script')
    script.async = true
    script.src = `https://www.googletagmanager.com/gtag/js?id=${analyticsId}`
    document.head.appendChild(script)
    
    window.dataLayer = window.dataLayer || []
    window.gtag = function gtag() {
      window.dataLayer.push(arguments)
    }
    
    window.gtag('js', new Date())
    window.gtag('config', analyticsId, {
      anonymize_ip: true, // DSGVO compliance
      allow_google_signals: false, // Disable Google Signals for privacy
      cookie_expires: 63072000, // 2 years in seconds
    })
    
    console.log('Google Analytics initialized:', analyticsId)
  }
  
  // Performance monitoring
  if (typeof window !== 'undefined' && 'performance' in window) {
    // Track Core Web Vitals
    const trackWebVitals = () => {
      // First Contentful Paint
      const paintEntries = performance.getEntriesByType('paint')
      const fcp = paintEntries.find(entry => entry.name === 'first-contentful-paint')
      
      if (fcp && window.gtag) {
        window.gtag('event', 'web_vitals', {
          event_category: 'performance',
          event_label: 'first_contentful_paint',
          value: Math.round(fcp.startTime)
        })
      }
      
      // Largest Contentful Paint
      if ('LargestContentfulPaint' in window) {
        new PerformanceObserver((entryList) => {
          const entries = entryList.getEntries()
          const lastEntry = entries[entries.length - 1]
          
          if (window.gtag) {
            window.gtag('event', 'web_vitals', {
              event_category: 'performance',
              event_label: 'largest_contentful_paint',
              value: Math.round(lastEntry.startTime)
            })
          }
        }).observe({ entryTypes: ['largest-contentful-paint'] })
      }
      
      // Cumulative Layout Shift
      if ('LayoutShift' in window) {
        let cumulativeLayoutShiftScore = 0
        
        new PerformanceObserver((entryList) => {
          for (const entry of entryList.getEntries()) {
            if (!entry.hadRecentInput) {
              cumulativeLayoutShiftScore += entry.value
            }
          }
          
          if (window.gtag) {
            window.gtag('event', 'web_vitals', {
              event_category: 'performance',
              event_label: 'cumulative_layout_shift',
              value: Math.round(cumulativeLayoutShiftScore * 1000)
            })
          }
        }).observe({ entryTypes: ['layout-shift'] })
      }
    }
    
    // Run performance tracking after page load
    if (document.readyState === 'complete') {
      trackWebVitals()
    } else {
      window.addEventListener('load', trackWebVitals)
    }
  }
  
  // Service Worker registration for PWA features
  if (typeof window !== 'undefined' && 'serviceWorker' in navigator) {
    window.addEventListener('load', async () => {
      try {
        const registration = await navigator.serviceWorker.register('/sw.js')
        console.log('Service Worker registered:', registration)
      } catch (error) {
        console.log('Service Worker registration failed:', error)
      }
    })
  }
  
  // Error tracking
  if (typeof window !== 'undefined') {
    window.addEventListener('error', (event) => {
      console.error('Global error:', event.error)
      
      // Track errors in Google Analytics
      if (window.gtag) {
        window.gtag('event', 'exception', {
          description: event.error?.message || 'Unknown error',
          fatal: false
        })
      }
    })
    
    // Track unhandled promise rejections
    window.addEventListener('unhandledrejection', (event) => {
      console.error('Unhandled promise rejection:', event.reason)
      
      if (window.gtag) {
        window.gtag('event', 'exception', {
          description: event.reason?.message || 'Unhandled promise rejection',
          fatal: false
        })
      }
    })
  }
  
  // Initialize scroll tracking for user engagement
  if (typeof window !== 'undefined') {
    let scrollDepth = 0
    const trackScrollDepth = () => {
      const windowHeight = window.innerHeight
      const documentHeight = document.documentElement.scrollHeight
      const scrollTop = window.pageYOffset || document.documentElement.scrollTop
      
      const newScrollDepth = Math.round(((scrollTop + windowHeight) / documentHeight) * 100)
      
      // Track scroll milestones (25%, 50%, 75%, 100%)
      const milestones = [25, 50, 75, 100]
      for (const milestone of milestones) {
        if (newScrollDepth >= milestone && scrollDepth < milestone) {
          if (window.gtag) {
            window.gtag('event', 'scroll_depth', {
              event_category: 'engagement',
              event_label: `${milestone}%`,
              value: milestone
            })
          }
          break
        }
      }
      
      scrollDepth = Math.max(scrollDepth, newScrollDepth)
    }
    
    // Throttled scroll tracking
    let scrollTimeout: NodeJS.Timeout
    window.addEventListener('scroll', () => {
      clearTimeout(scrollTimeout)
      scrollTimeout = setTimeout(trackScrollDepth, 150)
    })
  }
  
  // Initialize theme detection
  if (typeof window !== 'undefined') {
    // Detect user's preferred color scheme
    const prefersDarkMode = window.matchMedia('(prefers-color-scheme: dark)')
    
    // Listen for changes in color scheme preference
    prefersDarkMode.addEventListener('change', (event) => {
      if (window.gtag) {
        window.gtag('event', 'theme_preference', {
          event_category: 'user_preference',
          event_label: event.matches ? 'dark' : 'light'
        })
      }
    })
  }
  
  // Page visibility tracking for engagement metrics
  if (typeof document !== 'undefined' && typeof window !== 'undefined') {
    let pageStartTime = Date.now()
    let isVisible = !document.hidden
    
    const trackEngagementTime = () => {
      if (isVisible) {
        const timeOnPage = Date.now() - pageStartTime
        
        if (window.gtag && timeOnPage > 10000) { // Only track if user spent more than 10 seconds
          window.gtag('event', 'page_engagement', {
            event_category: 'engagement',
            event_label: 'time_on_page',
            value: Math.round(timeOnPage / 1000) // Convert to seconds
          })
        }
      }
    }
    
    document.addEventListener('visibilitychange', () => {
      const wasVisible = isVisible
      isVisible = !document.hidden
      
      if (wasVisible && !isVisible) {
        // Page became hidden, track engagement time
        trackEngagementTime()
      } else if (!wasVisible && isVisible) {
        // Page became visible again, reset timer
        pageStartTime = Date.now()
      }
    })
    
    // Track engagement time when user leaves the page
    window.addEventListener('beforeunload', trackEngagementTime)
  }
  
  // Initialize performance budget warnings (development only)
  if (process.env.NODE_ENV === 'development' && typeof window !== 'undefined') {
    window.addEventListener('load', () => {
      setTimeout(() => {
        const navigation = performance.getEntriesByType('navigation')[0] as PerformanceNavigationTiming
        
        if (navigation) {
          const loadTime = navigation.loadEventEnd - navigation.loadEventStart
          const domContentLoaded = navigation.domContentLoadedEventEnd - navigation.domContentLoadedEventStart
          
          console.group('🚀 Performance Metrics')
          console.log(`Load Time: ${Math.round(loadTime)}ms`)
          console.log(`DOM Content Loaded: ${Math.round(domContentLoaded)}ms`)
          console.log(`DNS Lookup: ${Math.round(navigation.domainLookupEnd - navigation.domainLookupStart)}ms`)
          console.log(`Server Response: ${Math.round(navigation.responseEnd - navigation.requestStart)}ms`)
          
          // Performance budget warnings
          if (loadTime > 3000) {
            console.warn('⚠️ Page load time exceeds 3 seconds')
          }
          if (domContentLoaded > 1500) {
            console.warn('⚠️ DOM Content Loaded exceeds 1.5 seconds')
          }
          
          console.groupEnd()
        }
      }, 1000)
    })
  }
  
  console.log('🎯 Configuraid app initialized successfully')
})