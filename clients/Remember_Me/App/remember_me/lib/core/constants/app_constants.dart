class AppConstants {
  static const String appName = 'Remember Me';
  static const String appVersion = '1.0.0';
  static const String appSlogan = 'Verwalte deine Medien smart & sicher';
  
  // Animation Durations
  static const Duration fastAnimation = Duration(milliseconds: 300);
  static const Duration normalAnimation = Duration(milliseconds: 600);
  static const Duration slowAnimation = Duration(milliseconds: 800);
  static const Duration backgroundAnimation = Duration(seconds: 20);
  static const Duration uploadAnimation = Duration(seconds: 25);
  
  // File Size Limits (in bytes)
  static const int maxVideoSize = 100 * 1024 * 1024; 
  static const int maxImageSize = 10 * 1024 * 1024; 
  static const int maxAudioSize = 50 * 1024 * 1024; 
  static const int maxDocumentSize = 25 * 1024 * 1024;
  
  // Supported File Extensions
  static const List<String> videoExtensions = ['mp4', 'avi', 'mov', 'wmv'];
  static const List<String> imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'webp'];
  static const List<String> audioExtensions = ['mp3', 'wav', 'aac', 'flac'];
  static const List<String> documentExtensions = ['pdf', 'doc', 'docx', 'txt', 'xls', 'xlsx'];
  
  // UI Constants
  static const double defaultPadding = 16.0;
  static const double largePadding = 24.0;
  static const double smallPadding = 8.0;
  static const double borderRadius = 12.0;
  static const double largeBorderRadius = 20.0;
  static const double cardElevation = 8.0;
}