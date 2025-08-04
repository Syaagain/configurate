/**
 * Global utility composable for Configuraid website
 * Provides commonly used functions across components
 */

export const useUtils = () => {
  
  /**
   * Format currency in EUR
   */
  const formatCurrency = (amount: number): string => {
    return new Intl.NumberFormat('de-DE', {
      style: 'currency',
      currency: 'EUR',
      minimumFractionDigits: 0,
      maximumFractionDigits: 0
    }).format(amount)
  }

  /**
   * Format percentage
   */
  const formatPercentage = (value: number, decimals: number = 0): string => {
    return new Intl.NumberFormat('de-DE', {
      style: 'percent',
      minimumFractionDigits: decimals,
      maximumFractionDigits: decimals
    }).format(value / 100)
  }

  /**
   * Format number with German locale
   */
  const formatNumber = (value: number): string => {
    return new Intl.NumberFormat('de-DE').format(value)
  }

  /**
   * Format date in German format
   */
  const formatDate = (date: Date | string): string => {
    const dateObj = typeof date === 'string' ? new Date(date) : date
    return new Intl.DateTimeFormat('de-DE', {
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    }).format(dateObj)
  }

  /**
   * Format relative time (e.g., "vor 3 Tagen")
   */
  const formatRelativeTime = (date: Date | string): string => {
    const dateObj = typeof date === 'string' ? new Date(date) : date
    const now = new Date()
    const diffInSeconds = Math.floor((now.getTime() - dateObj.getTime()) / 1000)

    if (diffInSeconds < 60) return 'vor wenigen Sekunden'
    if (diffInSeconds < 3600) return `vor ${Math.floor(diffInSeconds / 60)} Minuten`
    if (diffInSeconds < 86400) return `vor ${Math.floor(diffInSeconds / 3600)} Stunden`
    if (diffInSeconds < 2592000) return `vor ${Math.floor(diffInSeconds / 86400)} Tagen`
    if (diffInSeconds < 31536000) return `vor ${Math.floor(diffInSeconds / 2592000)} Monaten`
    return `vor ${Math.floor(diffInSeconds / 31536000)} Jahren`
  }

  /**
   * Estimate reading time for text
   */
  const estimateReadingTime = (text: string, wordsPerMinute: number = 200): string => {
    const wordCount = text.trim().split(/\s+/).length
    const minutes = Math.ceil(wordCount / wordsPerMinute)
    return `${minutes} Min. Lesezeit`
  }

  /**
   * Debounce function for search inputs
   */
  const debounce = <T extends (...args: any[]) => any>(
    func: T,
    delay: number
  ): ((...args: Parameters<T>) => void) => {
    let timeoutId: NodeJS.Timeout
    return (...args: Parameters<T>) => {
      clearTimeout(timeoutId)
      timeoutId = setTimeout(() => func(...args), delay)
    }
  }

  /**
   * Scroll to element smoothly
   */
  const scrollToElement = (elementId: string, offset: number = 0): void => {
    const element = document.getElementById(elementId)
    if (element) {
      const elementPosition = element.getBoundingClientRect().top + window.pageYOffset
      const offsetPosition = elementPosition - offset

      window.scrollTo({
        top: offsetPosition,
        behavior: 'smooth'
      })
    }
  }

  /**
   * Generate SEO-friendly slug from text
   */
  const generateSlug = (text: string): string => {
    return text
      .toLowerCase()
      .normalize('NFD')
      .replace(/[\u0300-\u036f]/g, '') // Remove diacritics
      .replace(/[^a-z0-9]+/g, '-') // Replace non-alphanumeric with hyphens
      .replace(/^-+|-+$/g, '') // Remove leading/trailing hyphens
  }

  /**
   * Validate email address
   */
  const isValidEmail = (email: string): boolean => {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
    return emailRegex.test(email)
  }

  /**
   * Validate German phone number
   */
  const isValidPhoneNumber = (phone: string): boolean => {
    // Basic German phone number validation
    const phoneRegex = /^(\+49|0)[1-9]\d{1,14}$/
    return phoneRegex.test(phone.replace(/\s/g, ''))
  }

  /**
   * Get URL-friendly query parameters
   */
  const getQueryParams = (url?: string): Record<string, string> => {
    if (typeof window === 'undefined') return {}
    
    const urlObj = new URL(url || window.location.href)
    const params: Record<string, string> = {}
    
    urlObj.searchParams.forEach((value, key) => {
      params[key] = value
    })
    
    return params
  }

  /**
   * Track analytics event (Google Analytics)
   */
  const trackEvent = (
    eventName: string, 
    category: string = 'engagement',
    label?: string,
    value?: number
  ): void => {
    if (typeof gtag !== 'undefined') {
      gtag('event', eventName, {
        event_category: category,
        event_label: label,
        value: value
      })
    }
    
    // Console log for development
    if (process.env.NODE_ENV === 'development') {
      console.log('Analytics Event:', { eventName, category, label, value })
    }
  }

  /**
   * Copy text to clipboard
   */
  const copyToClipboard = async (text: string): Promise<boolean> => {
    try {
      if (navigator.clipboard && typeof navigator.clipboard.writeText === 'function') {
        await navigator.clipboard.writeText(text)
        return true
      } else {
        // Fallback for older browsers
        const textArea = document.createElement('textarea')
        textArea.value = text
        document.body.appendChild(textArea)
        textArea.select()
        document.execCommand('copy')
        document.body.removeChild(textArea)
        return true
      }
    } catch (error) {
      console.error('Failed to copy to clipboard:', error)
      return false
    }
  }

  /**
   * Check if user is on mobile device
   */
  const isMobile = (): boolean => {
    if (typeof window === 'undefined') return false
    return window.innerWidth < 768
  }

  /**
   * Get device type based on screen size
   */
  const getDeviceType = (): 'mobile' | 'tablet' | 'desktop' => {
    if (typeof window === 'undefined') return 'desktop'
    
    const width = window.innerWidth
    if (width < 768) return 'mobile'
    if (width < 1024) return 'tablet'
    return 'desktop'
  }

  /**
   * Lazy load images with intersection observer
   */
  const lazyLoadImage = (img: HTMLImageElement, src: string): void => {
    const imageObserver = new IntersectionObserver((entries, observer) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          const image = entry.target as HTMLImageElement
          image.src = src
          image.classList.remove('lazy')
          observer.unobserve(image)
        }
      })
    })

    imageObserver.observe(img)
  }

  /**
   * Generate random ID
   */
  const generateId = (prefix: string = 'id'): string => {
    return `${prefix}-${Math.random().toString(36).substr(2, 9)}`
  }

  /**
   * Sleep function for async operations
   */
  const sleep = (ms: number): Promise<void> => {
    return new Promise(resolve => setTimeout(resolve, ms))
  }

  /**
   * Calculate ROI percentage
   */
  const calculateROI = (
    investment: number, 
    returns: number, 
    timeMonths: number = 12
  ): number => {
    const annualizedReturns = returns * (12 / timeMonths)
    return ((annualizedReturns - investment) / investment) * 100
  }

  /**
   * Format file size in human readable format
   */
  const formatFileSize = (bytes: number): string => {
    if (bytes === 0) return '0 Bytes'
    
    const k = 1024
    const sizes = ['Bytes', 'KB', 'MB', 'GB']
    const i = Math.floor(Math.log(bytes) / Math.log(k))
    
    return parseFloat((bytes / Math.pow(k, i)).toFixed(1)) + ' ' + sizes[i]
  }

  /**
   * Truncate text to specified length
   */
  const truncateText = (text: string, maxLength: number, suffix: string = '...'): string => {
    if (text.length <= maxLength) return text
    return text.substring(0, maxLength - suffix.length) + suffix
  }

  return {
    // Formatting
    formatCurrency,
    formatPercentage,
    formatNumber,
    formatDate,
    formatRelativeTime,
    formatFileSize,
    
    // Text utilities
    estimateReadingTime,
    generateSlug,
    truncateText,
    
    // Validation
    isValidEmail,
    isValidPhoneNumber,
    
    // DOM utilities
    debounce,
    scrollToElement,
    copyToClipboard,
    lazyLoadImage,
    
    // Device detection
    isMobile,
    getDeviceType,
    
    // URL utilities
    getQueryParams,
    
    // Analytics
    trackEvent,
    
    // Calculations
    calculateROI,
    
    // Utilities
    generateId,
    sleep
  }
}