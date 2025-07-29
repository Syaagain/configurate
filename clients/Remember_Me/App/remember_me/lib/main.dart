import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memorial Digital',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const MemorialHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MemorialHomePage extends StatefulWidget {
  const MemorialHomePage({super.key});

  @override
  State<MemorialHomePage> createState() => _MemorialHomePageState();
}

class _MemorialHomePageState extends State<MemorialHomePage> {
  bool isPrivate = false;
  int selectedIndex = 0;
  
  final List<Map<String, dynamic>> memorialPhotos = [
    {
      'id': 1,
      'url': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400',
      'caption': 'Heinrich in jungen Jahren'
    },
    {
      'id': 2,
      'url': 'https://images.unsplash.com/photo-1582750433449-648ed127bb54?w=400',
      'caption': 'Familienfoto 2020'
    },
    {
      'id': 3,
      'url': 'https://images.unsplash.com/photo-1609220136736-443140cffec6?w=400',
      'caption': 'Letzter Geburtstag'
    }
  ];

  final List<Map<String, dynamic>> memorialVideos = [
    {'id': 1, 'title': 'Heinrichs Lebensgeschichte', 'duration': '5:32'},
    {'id': 2, 'title': 'Familienfeier 2023', 'duration': '12:45'}
  ];

  final List<Map<String, dynamic>> memorialAudio = [
    {'id': 1, 'title': 'Heinrichs Stimme - Weihnachtsgruß 2023', 'duration': '2:15'}
  ];

  final Map<String, String> memorialInfo = {
    'name': 'Heinrich Mueller',
    'birth': '1945-03-15',
    'death': '2024-11-20',
    'location': 'Friedhof München-Ostfriedhof',
    'bio': 'Ein liebevoller Vater, Großvater und Freund. Heinrich widmete sein Leben der Familie und seinem Beruf als Lehrer.',
  };

  String formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return '${date.day}.${date.month}.${date.year}';
    } catch (e) {
      return dateStr;
    }
  }

  void onBottomNavTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    
    // Hier können Sie zu verschiedenen Seiten navigieren
    switch (index) {
      case 0:
        // Memorial Tab - bereits hier
        break;
      case 1:
        // Services Tab
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Services-Bereich wird geladen...')),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar mit Gradient
          SliverAppBar(
            expandedHeight: 250,
            floating: false,
            pinned: true,
            backgroundColor: Colors.purple,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF9C27B0), // Purple
                      Color(0xFFE91E63), // Pink
                      Color(0xFFFF9800), // Orange
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  isPrivate ? Icons.lock : Icons.public,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    isPrivate ? 'Privat' : 'Öffentlich',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  isPrivate = !isPrivate;
                                });
                              },
                              icon: const Icon(
                                Icons.settings,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          memorialInfo['name'] ?? 'Unbekannt',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${formatDate(memorialInfo['birth'] ?? '')} - ${formatDate(memorialInfo['death'] ?? '')}',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          memorialInfo['bio'] ?? '',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 14,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              title: const Text(
                'Memorial Digital',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          
          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Media Gallery Card
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.purple.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.purple,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'Erinnerungen',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          
                          // Photos Section
                          const Text(
                            'Fotos',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 200,
                            child: memorialPhotos.isNotEmpty
                                ? ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: memorialPhotos.length,
                                    itemBuilder: (context, index) {
                                      final photo = memorialPhotos[index];
                                      return Container(
                                        width: 160,
                                        margin: const EdgeInsets.only(right: 12),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              Image.network(
                                                photo['url'] ?? '',
                                                fit: BoxFit.cover,
                                                loadingBuilder: (context, child, loadingProgress) {
                                                  if (loadingProgress == null) return child;
                                                  return Container(
                                                    color: Colors.grey[300],
                                                    child: const Center(
                                                      child: CircularProgressIndicator(),
                                                    ),
                                                  );
                                                },
                                                errorBuilder: (context, error, stackTrace) {
                                                  return Container(
                                                    color: Colors.grey[300],
                                                    child: const Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Icon(
                                                          Icons.image_not_supported,
                                                          size: 50,
                                                          color: Colors.grey,
                                                        ),
                                                        Text(
                                                          'Bild kann nicht\ngeladen werden',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Colors.transparent,
                                                      Colors.black.withOpacity(0.7),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 12,
                                                left: 12,
                                                right: 12,
                                                child: Text(
                                                  photo['caption'] ?? 'Kein Titel',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : const Center(
                                    child: Text('Keine Fotos verfügbar'),
                                  ),
                          ),
                          
                          const SizedBox(height: 24),
                          
                          // Videos & Audio Section
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Videos
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color: Colors.purple.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: const Icon(
                                            Icons.play_arrow,
                                            color: Colors.purple,
                                            size: 16,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        const Text(
                                          'Videos',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    ...memorialVideos.map((video) {
                                      return Container(
                                        margin: const EdgeInsets.only(bottom: 8),
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[50],
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text('Video wird abgespielt: ${video['title']}'),
                                              ),
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      video['title'] ?? 'Unbekanntes Video',
                                                      style: const TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 12,
                                                      ),
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                    const SizedBox(height: 2),
                                                    Text(
                                                      video['duration'] ?? '0:00',
                                                      style: TextStyle(
                                                        color: Colors.grey[600],
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Icon(
                                                Icons.play_arrow,
                                                color: Colors.purple,
                                                size: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                              
                              const SizedBox(width: 16),
                              
                              // Audio
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color: Colors.pink.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: const Icon(
                                            Icons.favorite,
                                            color: Colors.pink,
                                            size: 16,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        const Text(
                                          'Audio',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    ...memorialAudio.map((audio) {
                                      return Container(
                                        margin: const EdgeInsets.only(bottom: 8),
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[50],
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text('Audio wird abgespielt: ${audio['title']}'),
                                              ),
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      audio['title'] ?? 'Unbekannte Aufnahme',
                                                      style: const TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 12,
                                                      ),
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                    const SizedBox(height: 2),
                                                    Text(
                                                      audio['duration'] ?? '0:00',
                                                      style: TextStyle(
                                                        color: Colors.grey[600],
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 24,
                                                height: 24,
                                                decoration: const BoxDecoration(
                                                  color: Colors.pink,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(
                                                  Icons.play_arrow,
                                                  color: Colors.white,
                                                  size: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      
      // Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        currentIndex: selectedIndex,
        onTap: onBottomNavTapped,
        elevation: 8,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Memorial',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Services',
          ),
        ],
      ),
    );
  }
}