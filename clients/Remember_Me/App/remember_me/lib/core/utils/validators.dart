class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Bitte geben Sie Ihre E-Mail ein';
    }
    
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Bitte geben Sie eine gültige E-Mail ein';
    }
    
    return null;
  }

  static String? validatePassword(String? value, {bool isRegistration = false}) {
    if (value == null || value.isEmpty) {
      return 'Bitte geben Sie Ihr Passwort ein';
    }
    
    if (isRegistration && value.length < 6) {
      return 'Passwort muss mindestens 6 Zeichen haben';
    }
    
    return null;
  }

  static String? validateConfirmPassword(String? value, String? password) {
    if (value != password) {
      return 'Passwörter stimmen nicht überein';
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Bitte geben Sie Ihren Namen ein';
    }
    
    if (value.length < 2) {
      return 'Name muss mindestens 2 Zeichen haben';
    }
    
    return null;
  }

  static bool isValidFileSize(int fileSize, int maxSize) {
    return fileSize <= maxSize;
  }

  static bool isValidFileExtension(String fileName, List<String> allowedExtensions) {
    final extension = fileName.split('.').last.toLowerCase();
    return allowedExtensions.contains(extension);
  }
}