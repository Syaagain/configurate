/*import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:remember_me/domain/enums.dart';
// TODO: Für echte Implementation hinzufügen:
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Media Manager Pro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
      ),
      home: LoginScreen(), // Start mit Login Screen
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late AnimationController _backgroundController;
  late AnimationController _formController;
  late AnimationController _buttonController;
  
  late Animation<double> _backgroundAnimation;
  late Animation<double> _formAnimation;
  late Animation<double> _buttonAnimation;
  late Animation<Offset> _slideAnimation;
  
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  
  bool _isLogin = true;
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  
  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startAnimations();
  }
  
  void _setupAnimations() {
    _backgroundController = AnimationController(
      duration: Duration(seconds: 20),
      vsync: this,
    );
    
    _formController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    
    _buttonController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    
    _backgroundAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _backgroundController,
      curve: Curves.linear,
    ));
    
    _formAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _formController,
      curve: Curves.elasticOut,
    ));
    
    _buttonAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _buttonController,
      curve: Curves.easeInOut,
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _formController,
      curve: Curves.easeOutCubic,
    ));
  }
  
  void _startAnimations() {
    _backgroundController.repeat();
    _formController.forward();
  }
  
  @override
  void dispose() {
    _backgroundController.dispose();
    _formController.dispose();
    _buttonController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }
  
  void _toggleMode() {
    setState(() {
      _isLogin = !_isLogin;
    });
    _formController.reset();
    _formController.forward();
    HapticFeedback.lightImpact();
  }
  
  Future<void> _handleAuth() async {
    if (!_formKey.currentState!.validate()) return;
    
    _buttonController.forward();
    setState(() {
      _isLoading = true;
    });
    
    HapticFeedback.mediumImpact();
    
    // Simuliere Authentication
    await Future.delayed(Duration(seconds: 2));
    
    // TODO: Hier wird später Firebase Auth implementiert
    // if (_isLogin) {
    //   await FirebaseAuth.instance.signInWithEmailAndPassword(
    //     email: _emailController.text,
    //     password: _passwordController.text,
    //   );
    // } else {
    //   await FirebaseAuth.instance.createUserWithEmailAndPassword(
    //     email: _emailController.text,
    //     password: _passwordController.text,
    //   );
    // }
    
    _buttonController.reverse();
    setState(() {
      _isLoading = false;
    });
    
    // Erfolgreiche Anmeldung - zur App navigieren
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => MainPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: Duration(milliseconds: 800),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _backgroundAnimation,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.deepPurple.shade800,
                  Colors.purple.shade600,
                  Colors.pink.shade400,
                  Colors.orange.shade300,
                ],
                stops: [
                  0.0,
                  0.3 + (_backgroundAnimation.value * 0.2),
                  0.7 + (_backgroundAnimation.value * 0.2),
                  1.0,
                ],
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(
                    -0.5 + (_backgroundAnimation.value * 1.0),
                    -0.5 + (_backgroundAnimation.value * 0.5),
                  ),
                  radius: 1.5,
                  colors: [
                    Colors.white.withOpacity(0.1),
                    Colors.transparent,
                  ],
                ),
              ),
              child: SafeArea(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: Column(
                          children: [
                            _buildHeader(),
                            _buildLoginForm(),
                            _buildFooter(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildHeader() {
    return AnimatedBuilder(
      animation: _formAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, -50 * (1 - _formAnimation.value)),
          child: Opacity(
            opacity: _formAnimation.value.clamp(0.0, 1.0),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Column(
                children: [
                  // Logo Animation
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.3),
                          Colors.white.withOpacity(0.1),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.cloud_circle,
                      size: 80,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Media Manager Pro',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Verwalte deine Medien smart & sicher',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  
  Widget _buildLoginForm() {
    return SlideTransition(
      position: _slideAnimation,
      child: AnimatedBuilder(
        animation: _formAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: 0.8 + (_formAnimation.value * 0.2),
            child: Opacity(
              opacity: _formAnimation.value.clamp(0.0, 1.0),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                padding: EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildModeToggle(),
                      SizedBox(height: 32),
                      if (!_isLogin) _buildNameField(),
                      _buildEmailField(),
                      SizedBox(height: 16),
                      _buildPasswordField(),
                      if (!_isLogin) ...[
                        SizedBox(height: 16),
                        _buildConfirmPasswordField(),
                      ],
                      SizedBox(height: 32),
                      _buildAuthButton(),
                      SizedBox(height: 16),
                      _buildForgotPassword(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildModeToggle() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: _isLogin ? null : _toggleMode,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: _isLogin 
                    ? Colors.white.withOpacity(0.2)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _isLogin 
                      ? Colors.white.withOpacity(0.4)
                      : Colors.transparent,
                ),
              ),
              child: Text(
                'Anmelden',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: _isLogin ? FontWeight.bold : FontWeight.normal,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: !_isLogin ? null : _toggleMode,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: !_isLogin 
                    ? Colors.white.withOpacity(0.2)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: !_isLogin 
                      ? Colors.white.withOpacity(0.4)
                      : Colors.transparent,
                ),
              ),
              child: Text(
                'Registrieren',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: !_isLogin ? FontWeight.bold : FontWeight.normal,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildNameField() {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: _nameController,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: 'Vollständiger Name',
          labelStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
          prefixIcon: Icon(Icons.person, color: Colors.white.withOpacity(0.8)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.red.shade300),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.red.shade300, width: 2),
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.1),
        ),
        validator: (value) {
          if (!_isLogin && (value == null || value.isEmpty)) {
            return 'Bitte geben Sie Ihren Namen ein';
          }
          return null;
        },
      ),
    );
  }
  
  Widget _buildEmailField() {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: 'E-Mail',
          labelStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
          prefixIcon: Icon(Icons.email, color: Colors.white.withOpacity(0.8)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.red.shade300),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.red.shade300, width: 2),
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.1),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Bitte geben Sie Ihre E-Mail ein';
          }
          if (!value.contains('@')) {
            return 'Bitte geben Sie eine gültige E-Mail ein';
          }
          return null;
        },
      ),
    );
  }
  
  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: !_isPasswordVisible,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: 'Passwort',
        labelStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
        prefixIcon: Icon(Icons.lock, color: Colors.white.withOpacity(0.8)),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.white.withOpacity(0.8),
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
            HapticFeedback.lightImpact();
          },
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red.shade300),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red.shade300, width: 2),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Bitte geben Sie Ihr Passwort ein';
        }
        if (!_isLogin && value.length < 6) {
          return 'Passwort muss mindestens 6 Zeichen haben';
        }
        return null;
      },
    );
  }
  
  Widget _buildConfirmPasswordField() {
    return TextFormField(
      obscureText: !_isPasswordVisible,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: 'Passwort bestätigen',
        labelStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
        prefixIcon: Icon(Icons.lock_outline, color: Colors.white.withOpacity(0.8)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red.shade300),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red.shade300, width: 2),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
      ),
      validator: (value) {
        if (!_isLogin && value != _passwordController.text) {
          return 'Passwörter stimmen nicht überein';
        }
        return null;
      },
    );
  }
  
  Widget _buildAuthButton() {
    return AnimatedBuilder(
      animation: _buttonAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _buttonAnimation.value,
          child: Container(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _handleAuth,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.deepPurple.shade700,
                elevation: 8,
                shadowColor: Colors.black.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: _isLoading
                  ? SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(Colors.deepPurple.shade700),
                      ),
                    )
                  : Text(
                      _isLogin ? 'Anmelden' : 'Registrieren',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
  
  Widget _buildForgotPassword() {
    if (!_isLogin) return SizedBox.shrink();
    
    return TextButton(
      onPressed: () {
        // TODO: Passwort reset implementieren
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Passwort-Reset wird später implementiert'),
            backgroundColor: Colors.orange,
          ),
        );
      },
      child: Text(
        'Passwort vergessen?',
        style: TextStyle(
          color: Colors.white.withOpacity(0.9),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
  
  Widget _buildFooter() {
    return AnimatedBuilder(
      animation: _formAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - _formAnimation.value)),
          child: Opacity(
            opacity: _formAnimation.value.clamp(0.0, 1.0),
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Divider(color: Colors.white.withOpacity(0.3))),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'oder',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.white.withOpacity(0.3))),
                    ],
                  ),
                  SizedBox(height: 20),
                  _buildSocialLogins(),
                  SizedBox(height: 20),
                  Text(
                    '© 2024 Media Manager Pro',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  
  Widget _buildSocialLogins() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildSocialButton(
          icon: Icons.g_mobiledata,
          label: 'Google',
          color: Colors.red,
          onTap: () {
            // TODO: Google Sign-In implementieren
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Google Sign-In wird später implementiert'),
                backgroundColor: Colors.red,
              ),
            );
          },
        ),
        _buildSocialButton(
          icon: Icons.apple,
          label: 'Apple',
          color: Colors.white,
          onTap: () {
            // TODO: Apple Sign-In implementieren
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Apple Sign-In wird später implementiert'),
                backgroundColor: Colors.black,
              ),
            );
          },
        ),
        _buildSocialButton(
          icon: Icons.facebook,
          label: 'Facebook',
          color: Colors.blue,
          onTap: () {
            // TODO: Facebook Sign-In implementieren
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Facebook Sign-In wird später implementiert'),
                backgroundColor: Colors.blue,
              ),
            );
          },
        ),
      ],
    );
  }
  
  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Bestehende App-Logic bleibt unverändert
class MediaItem {
  final String id;
  final String title;
  final MediaType type;
  final String? description;
  final IconData icon;
  final Color color;
  final String? filePath;
  final int? fileSize;
  final DateTime dateAdded;

  MediaItem({
    required this.id,
    required this.title,
    required this.type,
    this.description,
    required this.icon,
    required this.color,
    this.filePath,
    this.fileSize,
    required this.dateAdded,
  });
}


class UploadHistoryItem {
  final String id;
  final String fileName;
  final MediaType type;
  final int fileSize;
  final DateTime timestamp;
  final UploadStatus status;
  final double? progress;
  final String? errorMessage;
  final String? downloadUrl; // Für Firebase Storage URL

  UploadHistoryItem({
    required this.id,
    required this.fileName,
    required this.type,
    required this.fileSize,
    required this.timestamp,
    required this.status,
    this.progress,
    this.errorMessage,
    this.downloadUrl,
  });

  UploadHistoryItem copyWith({
    UploadStatus? status,
    double? progress,
    String? errorMessage,
    String? downloadUrl,
  }) {
    return UploadHistoryItem(
      id: this.id,
      fileName: this.fileName,
      type: this.type,
      fileSize: this.fileSize,
      timestamp: this.timestamp,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      errorMessage: errorMessage ?? this.errorMessage,
      downloadUrl: downloadUrl ?? this.downloadUrl,
    );
  }
}

class Section {
  final String id;
  final String title;
  final Color color;
  final Color backgroundColor;
  final IconData icon;
  List<MediaItem> items;

  Section({
    required this.id,
    required this.title,
    required this.color,
    required this.backgroundColor,
    required this.icon,
    required this.items,
  });
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  List<Section> sections = [];
  List<UploadHistoryItem> uploadHistory = [];

  @override
  void initState() {
    super.initState();
    _initializeSections();
    _loadUploadHistory();
  }

  void _initializeSections() {
    sections = [
      Section(
        id: 'videos',
        title: 'Videos',
        color: Colors.red.shade600,
        backgroundColor: Colors.red.shade50,
        icon: Icons.video_library,
        items: [
          MediaItem(
            id: '1',
            title: 'Intro Video.mp4',
            type: MediaType.video,
            description: 'Willkommensvideo für neue Nutzer',
            icon: Icons.play_circle,
            color: Colors.red.shade400,
            fileSize: 15728640, // 15 MB
            dateAdded: DateTime.now().subtract(Duration(days: 2)),
          ),
          MediaItem(
            id: '2',
            title: 'Tutorial Basics.mp4',
            type: MediaType.video,
            description: 'Grundlagen Tutorial',
            icon: Icons.play_circle,
            color: Colors.red.shade400,
            fileSize: 25165824, // 24 MB
            dateAdded: DateTime.now().subtract(Duration(days: 1)),
          ),
        ],
      ),
      Section(
        id: 'images',
        title: 'Bilder',
        color: Colors.green.shade600,
        backgroundColor: Colors.green.shade50,
        icon: Icons.photo_library,
        items: [
          MediaItem(
            id: '3',
            title: 'Company_Logo.png',
            type: MediaType.image,
            description: 'Hauptlogo der Firma',
            icon: Icons.image,
            color: Colors.green.shade400,
            fileSize: 245760, // 240 KB
            dateAdded: DateTime.now().subtract(Duration(days: 5)),
          ),
          MediaItem(
            id: '4',
            title: 'Header_Banner.jpg',
            type: MediaType.image,
            description: 'Website Header',
            icon: Icons.image,
            color: Colors.green.shade400,
            fileSize: 1048576, // 1 MB
            dateAdded: DateTime.now().subtract(Duration(days: 3)),
          ),
        ],
      ),
      Section(
        id: 'audio',
        title: 'Audio',
        color: Colors.purple.shade600,
        backgroundColor: Colors.purple.shade50,
        icon: Icons.audiotrack,
        items: [
          MediaItem(
            id: '5',
            title: 'Background_Music.mp3',
            type: MediaType.audio,
            description: 'Hintergrundmusik für Videos',
            icon: Icons.music_note,
            color: Colors.purple.shade400,
            fileSize: 5242880, // 5 MB
            dateAdded: DateTime.now().subtract(Duration(days: 4)),
          ),
        ],
      ),
    ];
  }

  void _loadUploadHistory() {
    // TODO: Aus lokalem Storage oder Firebase laden
    uploadHistory = [
      UploadHistoryItem(
        id: 'hist_1',
        fileName: 'Beispiel_Video.mp4',
        type: MediaType.video,
        fileSize: 12582912,
        timestamp: DateTime.now().subtract(Duration(hours: 2)),
        status: UploadStatus.completed,
        downloadUrl: 'https://firebase-storage-url...',
      ),
      UploadHistoryItem(
        id: 'hist_2',
        fileName: 'Test_Bild.jpg',
        type: MediaType.image,
        fileSize: 1048576,
        timestamp: DateTime.now().subtract(Duration(days: 1)),
        status: UploadStatus.completed,
        downloadUrl: 'https://firebase-storage-url...',
      ),
    ];
  }

  void addMediaItem(MediaItem item) {
    setState(() {
      Section targetSection = sections.firstWhere((s) => s.id == _getSectionIdForType(item.type));
      targetSection.items.add(item);
    });
  }

  void addUploadHistoryItem(UploadHistoryItem item) {
    setState(() {
      uploadHistory.insert(0, item); // Neueste zuerst
    });
  }

  void updateUploadHistoryItem(String id, UploadHistoryItem updatedItem) {
    setState(() {
      int index = uploadHistory.indexWhere((item) => item.id == id);
      if (index != -1) {
        uploadHistory[index] = updatedItem;
      }
    });
  }

  String _getSectionIdForType(MediaType type) {
    switch (type) {
      case MediaType.video:
        return 'videos';
      case MediaType.image:
        return 'images';
      case MediaType.audio:
        return 'audio';
      case MediaType.document:
        return 'videos'; // Fallback
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          MediaSectionsPage(sections: sections),
          FileUploadPage(
            onFileAdded: addMediaItem, 
            uploadHistory: uploadHistory,
            onUploadHistoryAdded: addUploadHistoryItem,
            onUploadHistoryUpdated: updateUploadHistoryItem,
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: Colors.white,
          selectedItemColor: Colors.deepPurple.shade600,
          unselectedItemColor: Colors.grey.shade500,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_rounded),
              activeIcon: Icon(Icons.dashboard_rounded),
              label: 'Medien',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cloud_upload_rounded),
              activeIcon: Icon(Icons.cloud_upload_rounded),
              label: 'Upload',
            ),
          ],
        ),
      ),
    );
  }
}

// Alle anderen Klassen bleiben unverändert...
// (MediaSectionsPage, FileUploadPage, etc. - der Code ist zu lang für ein Artifact)
// Hier ist nur der Login-Screen und die Main-Struktur gezeigt.

class MediaSectionsPage extends StatefulWidget {
  final List<Section> sections;

  MediaSectionsPage({required this.sections});

  @override
  _MediaSectionsPageState createState() => _MediaSectionsPageState();
}

class _MediaSectionsPageState extends State<MediaSectionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          'Media Manager',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple.shade700,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Logout zur Login-Seite
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.shade700,
              Colors.grey.shade50,
            ],
            stops: [0.0, 0.2],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Willkommen zurück! Verwalte deine Medien einfach per Drag & Drop.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: ReorderableListView.builder(
                buildDefaultDragHandles: false, // Entfernt das Standard-Icon
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: widget.sections.length,
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (newIndex > oldIndex) {
                      newIndex--;
                    }
                    final Section section = widget.sections.removeAt(oldIndex);
                    widget.sections.insert(newIndex, section);
                  });
                },
                itemBuilder: (context, index) {
                  return ReorderableDragStartListener(
                    key: ValueKey(widget.sections[index].id),
                    index: index,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 16),
                      child: _buildSection(widget.sections[index]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(Section section) {
    return Card(
      elevation: 8,
      shadowColor: section.color.withOpacity(0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              section.backgroundColor,
              Colors.white,
            ],
          ),
        ),
        child: Column(
          children: [
            // Section Header
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: section.color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Icon(section.icon, color: Colors.white, size: 24),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      section.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${section.items.length}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  // Drag-Indikator
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 20,
                          height: 2,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                        SizedBox(height: 3),
                        Container(
                          width: 20,
                          height: 2,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                        SizedBox(height: 3),
                        Container(
                          width: 20,
                          height: 2,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Items List
            Container(
              constraints: BoxConstraints(
                minHeight: 120,
                maxHeight: section.items.isEmpty ? 120 : 300,
              ),
              child: DragTarget<Map<String, dynamic>>(
                onAccept: (data) {
                  setState(() {
                    String sourceId = data['sourceSection'];
                    MediaItem item = data['item'];
                    
                    Section? sourceSection = widget.sections.firstWhere(
                      (s) => s.id == sourceId,
                    );
                    sourceSection.items.removeWhere((i) => i.id == item.id);
                    section.items.add(item);
                  });
                },
                builder: (context, candidateData, rejectedData) {
                  return Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: candidateData.isNotEmpty 
                          ? section.color.withOpacity(0.1)
                          : Colors.transparent,
                      border: candidateData.isNotEmpty
                          ? Border.all(color: section.color, width: 2)
                          : null,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: section.items.isEmpty
                        ? _buildEmptyState(section)
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.all(8),
                            itemCount: section.items.length,
                            itemBuilder: (context, index) {
                              return _buildMediaItem(section.items[index], section);
                            },
                          ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(Section section) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            section.icon,
            size: 48,
            color: section.color.withOpacity(0.3),
          ),
          SizedBox(height: 12),
          Text(
            'Keine ${section.title}',
            style: TextStyle(
              color: section.color.withOpacity(0.6),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Ziehe Items hierher oder nutze Upload',
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMediaItem(MediaItem item, Section section) {
    return Draggable<Map<String, dynamic>>(
      data: {
        'item': item,
        'sourceSection': section.id,
      },
      feedback: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 320,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: item.color, width: 2),
          ),
          child: Row(
            children: [
              Icon(item.icon, color: item.color, size: 24),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    if (item.description != null)
                      Text(
                        item.description!,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      childWhenDragging: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        height: 80,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300, style: BorderStyle.none),
        ),
        child: Center(
          child: Text(
            'Wird verschoben...',
            style: TextStyle(
              color: Colors.grey.shade500,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: item.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(item.icon, color: item.color, size: 24),
          ),
          title: Text(
            item.title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (item.description != null)
                Text(
                  item.description!,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),
              SizedBox(height: 4),
              Row(
                children: [
                  if (item.fileSize != null)
                    Text(
                      _formatFileSize(item.fileSize!),
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  if (item.fileSize != null) Text(' • ', style: TextStyle(color: Colors.grey.shade400)),
                  Text(
                    _formatDate(item.dateAdded),
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
          trailing: PopupMenuButton(
            icon: Icon(Icons.more_vert, color: Colors.grey.shade400),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.info_outline, size: 20),
                    SizedBox(width: 8),
                    Text('Details'),
                  ],
                ),
                value: 'info',
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.download, size: 20),
                    SizedBox(width: 8),
                    Text('Download'),
                  ],
                ),
                value: 'download',
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.delete, size: 20, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Löschen', style: TextStyle(color: Colors.red)),
                  ],
                ),
                value: 'delete',
              ),
            ],
            onSelected: (value) {
              if (value == 'delete') {
                setState(() {
                  section.items.removeWhere((i) => i.id == item.id);
                });
              }
            },
          ),
        ),
      ),
    );
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;
    
    if (difference == 0) return 'Heute';
    if (difference == 1) return 'Gestern';
    if (difference < 7) return 'vor $difference Tagen';
    return '${date.day}.${date.month}.${date.year}';
  }
}

class FileUploadPage extends StatefulWidget {
  final Function(MediaItem) onFileAdded;
  final List<UploadHistoryItem> uploadHistory;
  final Function(UploadHistoryItem) onUploadHistoryAdded;
  final Function(String, UploadHistoryItem) onUploadHistoryUpdated;

  FileUploadPage({
    required this.onFileAdded,
    required this.uploadHistory,
    required this.onUploadHistoryAdded,
    required this.onUploadHistoryUpdated,
  });

  @override
  _FileUploadPageState createState() => _FileUploadPageState();
}

class _FileUploadPageState extends State<FileUploadPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _backgroundController;
  late AnimationController _uploadController;
  late AnimationController _cardController;
  
  late Animation<double> _backgroundAnimation;
  late Animation<double> _uploadAnimation;
  late Animation<double> _cardAnimation;
  
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _setupAnimations();
    _startAnimations();
  }

  void _setupAnimations() {
    _backgroundController = AnimationController(
      duration: Duration(seconds: 25),
      vsync: this,
    );
    
    _uploadController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );
    
    _cardController = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );
    
    _backgroundAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _backgroundController,
      curve: Curves.linear,
    ));
    
    _uploadAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _uploadController,
      curve: Curves.easeOutCubic,
    ));
    
    _cardAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _cardController,
      curve: Curves.easeOutCubic,
    ));
  }
  
  void _startAnimations() {
    _backgroundController.repeat();
    _uploadController.forward();
    _cardController.forward();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _backgroundController.dispose();
    _uploadController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _backgroundAnimation,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.deepPurple.shade700,
                  Colors.purple.shade500,
                  Colors.pink.shade300,
                  Colors.orange.shade200,
                ],
                stops: [
                  0.0,
                  0.3 + (_backgroundAnimation.value * 0.15),
                  0.7 + (_backgroundAnimation.value * 0.15),
                  1.0,
                ],
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(
                    -0.3 + (_backgroundAnimation.value * 0.8),
                    -0.3 + (_backgroundAnimation.value * 0.4),
                  ),
                  radius: 1.2,
                  colors: [
                    Colors.white.withOpacity(0.08),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  title: Text(
                    'Datei Upload',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  centerTitle: true,
                  bottom: TabBar(
                    controller: _tabController,
                    onTap: (index) {
                      setState(() {
                        _selectedTabIndex = index;
                      });
                      HapticFeedback.lightImpact();
                    },
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white60,
                    indicatorColor: Colors.white,
                    indicatorWeight: 3,
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    tabs: [
                      Tab(
                        icon: Icon(Icons.cloud_upload_rounded, size: 24),
                        text: 'Upload',
                      ),
                      Tab(
                        icon: Icon(Icons.history_rounded, size: 24),
                        text: 'Verlauf',
                      ),
                    ],
                  ),
                ),
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildUploadTab(),
                    _buildHistoryTab(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildUploadTab() {
    return AnimatedBuilder(
      animation: _uploadAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: 0.9 + (_uploadAnimation.value * 0.1),
          child: Opacity(
            opacity: _uploadAnimation.value.clamp(0.0, 1.0),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  _buildMobileUploadOptions(),
                  SizedBox(height: 24),
                  _buildQuickAccessGrid(),
                  SizedBox(height: 24),
                  _buildSupportedFormats(),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMobileUploadOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mobile Upload',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildUploadCard(
                'Kamera',
                Icons.camera_alt_rounded,
                'Foto/Video aufnehmen',
                Colors.blue.shade400,
                () => _openCamera(),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _buildUploadCard(
                'Galerie',
                Icons.photo_library_rounded,
                'Aus Galerie wählen',
                Colors.green.shade400,
                () => _openGallery(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUploadCard(String title, IconData icon, String subtitle, Color color, VoidCallback onTap) {
    return AnimatedBuilder(
      animation: _cardAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - _cardAnimation.value)),
          child: Opacity(
            opacity: _cardAnimation.value.clamp(0.0, 1.0),
            child: Container(
              height: 140, // Erhöht von 120 auf 140
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                  BoxShadow(
                    color: color.withOpacity(0.1),
                    blurRadius: 30,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    onTap();
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.1),
                          Colors.white.withOpacity(0.05),
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min, // Hinzugefügt
                      children: [
                        Container(
                          padding: EdgeInsets.all(12), // Erhöht von 10 auf 12
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(16), // Erhöht von 14 auf 16
                            boxShadow: [
                              BoxShadow(
                                color: color.withOpacity(0.4),
                                blurRadius: 12,
                                offset: Offset(0, 6),
                              ),
                              BoxShadow(
                                color: Colors.white.withOpacity(0.2),
                                blurRadius: 8,
                                offset: Offset(0, -2),
                              ),
                            ],
                          ),
                          child: Icon(icon, color: Colors.white, size: 26), // Erhöht von 24 auf 26
                        ),
                        SizedBox(height: 12), // Erhöht von 10 auf 12
                        Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15, // Erhöht von 14 auf 15
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.3),
                                offset: Offset(0, 1),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 4), // Erhöht von 2 auf 4
                        Flexible( // Wrapper hinzugefügt
                          child: Text(
                            subtitle,
                            style: TextStyle(
                              fontSize: 11, // Erhöht von 10 auf 11
                              color: Colors.white.withOpacity(0.9),
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2, // Erhöht von 1 auf 2
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuickAccessGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Schnell-Zugriff',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 2.2,
          children: [
            _buildQuickAccessButton('Videos', Icons.videocam_rounded, Colors.red.shade400, MediaType.video),
            _buildQuickAccessButton('Fotos', Icons.image_rounded, Colors.green.shade400, MediaType.image),
            _buildQuickAccessButton('Audio', Icons.audiotrack_rounded, Colors.purple.shade400, MediaType.audio),
            _buildQuickAccessButton('Dokumente', Icons.description_rounded, Colors.blue.shade400, MediaType.document),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickAccessButton(String label, IconData icon, Color color, MediaType type) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: color.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () => _pickSpecificMediaType(type),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(icon, color: Colors.white, size: 24),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSupportedFormats() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline_rounded, color: Colors.white, size: 24),
              SizedBox(width: 12),
              Text(
                'Unterstützte Formate',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          _buildFormatRow(Icons.videocam_rounded, 'Videos', 'MP4, AVI, MOV, WMV', Colors.red.shade300),
          SizedBox(height: 12),
          _buildFormatRow(Icons.image_rounded, 'Bilder', 'JPG, PNG, GIF, WEBP', Colors.green.shade300),
          SizedBox(height: 12),
          _buildFormatRow(Icons.audiotrack_rounded, 'Audio', 'MP3, WAV, AAC, FLAC', Colors.purple.shade300),
          SizedBox(height: 12),
          _buildFormatRow(Icons.description_rounded, 'Dokumente', 'PDF, DOC, TXT, XLS', Colors.blue.shade300),
        ],
      ),
    );
  }

  Widget _buildFormatRow(IconData icon, String title, String formats, Color color) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 2),
              Text(
                formats,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

Widget _buildHistoryTab() {
    return AnimatedBuilder(
      animation: _cardAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: 0.95 + (_cardAnimation.value * 0.05),
          child: Opacity(
            opacity: _cardAnimation.value.clamp(0.0, 1.0),
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.history_rounded, color: Colors.white, size: 28),
                      SizedBox(width: 12),
                      Text(
                        'Upload Verlauf',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: widget.uploadHistory.isEmpty
                        ? _buildEmptyHistory()
                        : ListView.builder(
                            itemCount: widget.uploadHistory.length,
                            itemBuilder: (context, index) {
                              return _buildHistoryItem(widget.uploadHistory[index], index);
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyHistory() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.history_rounded,
              size: 64,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
          SizedBox(height: 24),
          Text(
            'Keine Upload History',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Deine hochgeladenen Dateien\nerscheinen hier',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(UploadHistoryItem item, int index) {
    Color statusColor = _getStatusColor(item.status);
    IconData statusIcon = _getStatusIcon(item.status);
    
    return AnimatedBuilder(
      animation: _cardAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - _cardAnimation.value.clamp(0.0, 1.0)) * (index + 1) * 0.1),
          child: Container(
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 15,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => _showHistoryItemDetails(item),
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: _getColorForMediaType(item.type).withOpacity(0.8),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: _getColorForMediaType(item.type).withOpacity(0.3),
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(
                          _getIconForMediaType(item.type),
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              item.fileName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 6),
                            Row(
                              children: [
                                Text(
                                  _formatFileSize(item.fileSize),
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  ' • ',
                                  style: TextStyle(color: Colors.white.withOpacity(0.5)),
                                ),
                                Text(
                                  _formatDate(item.timestamp),
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            if (item.status == UploadStatus.uploading && item.progress != null) ...[
                              SizedBox(height: 8),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: item.progress,
                                  backgroundColor: Colors.white.withOpacity(0.2),
                                  valueColor: AlwaysStoppedAnimation(Colors.blue.shade300),
                                  minHeight: 6,
                                ),
                              ),
                            ],
                            if (item.status == UploadStatus.failed && item.errorMessage != null) ...[
                              SizedBox(height: 6),
                              Text(
                                item.errorMessage!,
                                style: TextStyle(
                                  color: Colors.red.shade300,
                                  fontSize: 12,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ],
                        ),
                      ),
                      SizedBox(width: 12),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: statusColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(statusIcon, color: statusColor, size: 20),
                          ),
                          if (item.status == UploadStatus.uploading && item.progress != null) ...[
                            SizedBox(height: 4),
                            Text(
                              '${(item.progress! * 100).toInt()}%',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white.withOpacity(0.7),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Upload-Methoden
  void _openCamera() => _simulateFileUpload(MediaType.image);
  void _openGallery() => _simulateFileUpload(MediaType.image);
  void _openFileExplorer() => _simulateFileUpload(MediaType.document);
  void _pickSpecificMediaType(MediaType type) => _simulateFileUpload(type);

  void _simulateFileUpload(MediaType type) {
    String fileName = _generateFileName(type);
    int fileSize = _generateFileSize(type);
    
    UploadHistoryItem historyItem = UploadHistoryItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      fileName: fileName,
      type: type,
      fileSize: fileSize,
      timestamp: DateTime.now(),
      status: UploadStatus.pending,
    );

    widget.onUploadHistoryAdded(historyItem);
    _startUploadAnimation(historyItem);
    
    // Wechsel zum History Tab
    setState(() {
      _selectedTabIndex = 1;
    });
    _tabController.animateTo(1);
  }

  String _generateFileName(MediaType type) {
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    switch (type) {
      case MediaType.video:
        return 'Video_$timestamp.mp4';
      case MediaType.image:
        return 'Photo_$timestamp.jpg';
      case MediaType.audio:
        return 'Audio_$timestamp.mp3';
      case MediaType.document:
        return 'Document_$timestamp.pdf';
    }
  }

  int _generateFileSize(MediaType type) {
    switch (type) {
      case MediaType.video:
        return 25165824; // 24 MB
      case MediaType.image:
        return 3145728; // 3 MB
      case MediaType.audio:
        return 8388608; // 8 MB
      case MediaType.document:
        return 2097152; // 2 MB
    }
  }

  void _startUploadAnimation(UploadHistoryItem historyItem) async {
    // Update Status zu "uploading"
    widget.onUploadHistoryUpdated(
      historyItem.id,
      historyItem.copyWith(status: UploadStatus.uploading, progress: 0.0),
    );

    // Simuliere Upload mit Progress
    for (int i = 0; i <= 100; i += 2) {
      await Future.delayed(Duration(milliseconds: 50));
      
      if (mounted) {
        widget.onUploadHistoryUpdated(
          historyItem.id,
          historyItem.copyWith(
            status: UploadStatus.uploading,
            progress: i / 100.0,
          ),
        );
      }
    }

    // Simuliere erfolgreichen Upload
    String downloadUrl = 'https://firebasestorage.googleapis.com/v0/b/project/o/${historyItem.fileName}';
    
    widget.onUploadHistoryUpdated(
      historyItem.id,
      historyItem.copyWith(
        status: UploadStatus.completed,
        progress: 1.0,
        downloadUrl: downloadUrl,
      ),
    );

    // Füge das neue Media Item hinzu
    MediaItem newItem = MediaItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: historyItem.fileName,
      type: historyItem.type,
      description: 'Mobile Upload - ${_formatDate(DateTime.now())}',
      icon: _getIconForMediaType(historyItem.type),
      color: _getColorForMediaType(historyItem.type),
      fileSize: historyItem.fileSize,
      dateAdded: DateTime.now(),
    );

    widget.onFileAdded(newItem);

    // Zeige Erfolgs-Snackbar
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 12),
              Expanded(
                child: Text('${historyItem.fileName} erfolgreich hochgeladen!'),
              ),
            ],
          ),
          backgroundColor: Colors.green.shade600,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: EdgeInsets.all(16),
        ),
      );
    }
  }

  void _showHistoryItemDetails(UploadHistoryItem item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.deepPurple.shade800,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Upload Details',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Datei:', item.fileName),
            _buildDetailRow('Größe:', _formatFileSize(item.fileSize)),
            _buildDetailRow('Typ:', item.type.toString().split('.').last),
            _buildDetailRow('Datum:', _formatDate(item.timestamp)),
            _buildDetailRow('Status:', _getStatusText(item.status)),
            if (item.downloadUrl != null) ...[
              SizedBox(height: 8),
              Text(
                'Download URL:',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 4),
              Text(
                item.downloadUrl!,
                style: TextStyle(fontSize: 12, color: Colors.blue.shade300),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
        actions: [
          if (item.status == UploadStatus.completed && item.downloadUrl != null)
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Teilen', style: TextStyle(color: Colors.blue.shade300)),
            ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Schließen', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 60,
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }

  void _clearHistory() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.deepPurple.shade800,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'History löschen',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Möchtest du die gesamte Upload-History löschen?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Abbrechen', style: TextStyle(color: Colors.white70)),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                widget.uploadHistory.clear();
              });
              Navigator.pop(context);
            },
            child: Text('Löschen', style: TextStyle(color: Colors.red.shade300)),
          ),
        ],
      ),
    );
  }

  // Helper Methoden
  Color _getStatusColor(UploadStatus status) {
    switch (status) {
      case UploadStatus.completed:
        return Colors.green.shade400;
      case UploadStatus.uploading:
        return Colors.blue.shade400;
      case UploadStatus.failed:
        return Colors.red.shade400;
      case UploadStatus.pending:
        return Colors.orange.shade400;
    }
  }

  IconData _getStatusIcon(UploadStatus status) {
    switch (status) {
      case UploadStatus.completed:
        return Icons.check_circle_rounded;
      case UploadStatus.uploading:
        return Icons.upload_rounded;
      case UploadStatus.failed:
        return Icons.error_rounded;
      case UploadStatus.pending:
        return Icons.schedule_rounded;
    }
  }

  Color _getColorForMediaType(MediaType type) {
    switch (type) {
      case MediaType.video:
        return Colors.red.shade400;
      case MediaType.image:
        return Colors.green.shade400;
      case MediaType.audio:
        return Colors.purple.shade400;
      case MediaType.document:
        return Colors.blue.shade400;
    }
  }

  IconData _getIconForMediaType(MediaType type) {
    switch (type) {
      case MediaType.video:
        return Icons.play_circle_rounded;
      case MediaType.image:
        return Icons.image_rounded;
      case MediaType.audio:
        return Icons.music_note_rounded;
      case MediaType.document:
        return Icons.description_rounded;
    }
  }

  String _getStatusText(UploadStatus status) {
    switch (status) {
      case UploadStatus.pending:
        return 'Wartend';
      case UploadStatus.uploading:
        return 'Wird hochgeladen';
      case UploadStatus.completed:
        return 'Abgeschlossen';
      case UploadStatus.failed:
        return 'Fehlgeschlagen';
    }
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;
    
    if (difference == 0) return 'Heute ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    if (difference == 1) return 'Gestern';
    if (difference < 7) return 'vor $difference Tagen';
    return '${date.day}.${date.month}.${date.year}';
  }
}*/