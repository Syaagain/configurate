export default defineEventHandler(async (event) => {
  // Base URL - should be configured via environment variable
  const baseUrl = process.env.NUXT_PUBLIC_SITE_URL || 'https://www.configuraid.de'
  
  // Current date for lastmod
  const currentDate = new Date().toISOString().split('T')[0]
  
  // Static pages with their priorities and change frequencies
  const staticPages = [
    {
      url: '/',
      changefreq: 'weekly',
      priority: '1.0',
      lastmod: currentDate
    },
    {
      url: '/ueber-uns',
      changefreq: 'monthly',
      priority: '0.8',
      lastmod: currentDate
    },
    {
      url: '/kontakt',
      changefreq: 'monthly',
      priority: '0.9',
      lastmod: currentDate
    },
    {
      url: '/referenzen',
      changefreq: 'weekly',
      priority: '0.9',
      lastmod: currentDate
    },
    {
      url: '/blog',
      changefreq: 'daily',
      priority: '0.8',
      lastmod: currentDate
    },
    {
      url: '/loesungen',
      changefreq: 'monthly',
      priority: '0.8',
      lastmod: currentDate
    },
    
    // Service pages
    {
      url: '/leistungen/prozessoptimierung',
      changefreq: 'monthly',
      priority: '0.9',
      lastmod: currentDate
    },
    {
      url: '/leistungen/automatisierung',
      changefreq: 'monthly',
      priority: '0.9',
      lastmod: currentDate
    },
    {
      url: '/leistungen/webentwicklung',
      changefreq: 'monthly',
      priority: '0.9',
      lastmod: currentDate
    },
    {
      url: '/leistungen/beratung',
      changefreq: 'monthly',
      priority: '0.9',
      lastmod: currentDate
    },
    
    // Legal pages (lower priority)
    {
      url: '/impressum',
      changefreq: 'yearly',
      priority: '0.3',
      lastmod: currentDate
    },
    {
      url: '/datenschutz',
      changefreq: 'yearly',
      priority: '0.3',
      lastmod: currentDate
    },
    {
      url: '/agb',
      changefreq: 'yearly',
      priority: '0.3',
      lastmod: currentDate
    }
  ]
  
  // Blog articles (would normally come from a CMS or database)
  const blogArticles = [
    {
      url: '/blog/prozessoptimierung-guide-2024',
      changefreq: 'monthly',
      priority: '0.7',
      lastmod: '2024-12-15'
    },
    {
      url: '/blog/rpa-vs-traditionelle-automatisierung',
      changefreq: 'monthly',
      priority: '0.6',
      lastmod: '2024-12-10'
    },
    {
      url: '/blog/change-management-mitarbeiter-begeistern',
      changefreq: 'monthly',
      priority: '0.6',
      lastmod: '2024-12-05'
    },
    {
      url: '/blog/ki-prozessoptimierung-hype-oder-revolution',
      changefreq: 'monthly',
      priority: '0.6',
      lastmod: '2024-11-28'
    },
    {
      url: '/blog/fallstudie-rechnungsverarbeitung-zeitersparnis',
      changefreq: 'monthly',
      priority: '0.6',
      lastmod: '2024-11-20'
    }
  ]
  
  // Industry/solution pages (would normally be dynamic)
  const solutionPages = [
    {
      url: '/loesungen/produktion-fertigung',
      changefreq: 'monthly',
      priority: '0.7',
      lastmod: currentDate
    },
    {
      url: '/loesungen/handel-ecommerce',
      changefreq: 'monthly',
      priority: '0.7',
      lastmod: currentDate
    },
    {
      url: '/loesungen/dienstleistung',
      changefreq: 'monthly',
      priority: '0.7',
      lastmod: currentDate
    }
  ]
  
  // Combine all pages
  const allPages = [...staticPages, ...blogArticles, ...solutionPages]
  
  // Generate XML sitemap
  const sitemap = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9
                           http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd">
${allPages.map(page => `  <url>
    <loc>${baseUrl}${page.url}</loc>
    <lastmod>${page.lastmod}</lastmod>
    <changefreq>${page.changefreq}</changefreq>
    <priority>${page.priority}</priority>
  </url>`).join('\n')}
</urlset>`

  // Set appropriate headers
  setHeader(event, 'Content-Type', 'application/xml')
  setHeader(event, 'Cache-Control', 'max-age=3600') // Cache for 1 hour
  
  return sitemap
})