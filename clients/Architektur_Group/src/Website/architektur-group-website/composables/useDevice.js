export const useDevice = () => {
  const isMobile = ref(false)
  
  onMounted(() => {
    const checkDevice = () => {
      isMobile.value = window.innerWidth <= 768
    }
    
    checkDevice()
    window.addEventListener('resize', checkDevice)
    
    onUnmounted(() => {
      window.removeEventListener('resize', checkDevice)
    })
  })
  
  return { isMobile }
}