
class Validators {
  static const String _emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

  /// Validate email address
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'E-Mail-Adresse ist erforderlich';
    }
    
    final trimmedValue = value.trim();
    if (trimmedValue.isEmpty) {
      return 'E-Mail-Adresse ist erforderlich';
    }
    
    if (!RegExp(_emailPattern).hasMatch(trimmedValue)) {
      return 'Bitte geben Sie eine gültige E-Mail-Adresse ein';
    }
    
    if (trimmedValue.length > 320) {
      return 'E-Mail-Adresse ist zu lang';
    }
    
    return null;
  }

  /// Validate password
  static String? validatePassword(String? value, {bool isRegistration = false}) {
    if (value == null || value.isEmpty) {
      return 'Passwort ist erforderlich';
    }
    
    if (isRegistration) {
      // Stricter validation for registration
      if (value.length < 8) {
        return 'Passwort muss mindestens 8 Zeichen lang sein';
      }
      
      if (value.length > 128) {
        return 'Passwort ist zu lang (max. 128 Zeichen)';
      }
      
      // Check for at least one uppercase letter
      if (!RegExp(r'[A-Z]').hasMatch(value)) {
        return 'Passwort muss mindestens einen Großbuchstaben enthalten';
      }
      
      // Check for at least one lowercase letter
      if (!RegExp(r'[a-z]').hasMatch(value)) {
        return 'Passwort muss mindestens einen Kleinbuchstaben enthalten';
      }
      
      // Check for at least one digit
      if (!RegExp(r'[0-9]').hasMatch(value)) {
        return 'Passwort muss mindestens eine Zahl enthalten';
      }
      
      // Check for at least one special character
      if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
        return 'Passwort muss mindestens ein Sonderzeichen enthalten';
      }
    } else {
      // Less strict validation for login
      if (value.length < 6) {
        return 'Passwort muss mindestens 6 Zeichen lang sein';
      }
    }
    
    return null;
  }

  /// Validate password confirmation
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Passwort-Bestätigung ist erforderlich';
    }
    
    if (value != password) {
      return 'Passwörter stimmen nicht überein';
    }
    
    return null;
  }

  /// Validate full name
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name ist erforderlich';
    }
    
    final trimmedValue = value.trim();
    if (trimmedValue.isEmpty) {
      return 'Name ist erforderlich';
    }
    
    if (trimmedValue.length < 2) {
      return 'Name muss mindestens 2 Zeichen lang sein';
    }
    
    if (trimmedValue.length > 50) {
      return 'Name ist zu lang (max. 50 Zeichen)';
    }
    
    // Check for valid characters (letters, spaces, hyphens, apostrophes)
    if (!RegExp(r"^[a-zA-ZäöüÄÖÜß\s\-']+$").hasMatch(trimmedValue)) {
      return 'Name enthält ungültige Zeichen';
    }
    
    // Check for at least one letter
    if (!RegExp(r'[a-zA-ZäöüÄÖÜß]').hasMatch(trimmedValue)) {
      return 'Name muss mindestens einen Buchstaben enthalten';
    }
    
    return null;
  }

  /// Validate phone number (optional, for future use)
  static String? validatePhoneNumber(String? value, {bool isRequired = false}) {
    if (value == null || value.isEmpty) {
      return isRequired ? 'Telefonnummer ist erforderlich' : null;
    }
    
    final trimmedValue = value.trim();
    if (trimmedValue.isEmpty) {
      return isRequired ? 'Telefonnummer ist erforderlich' : null;
    }
    
    // Remove all non-digit characters except + at the beginning
    final cleanedValue = trimmedValue.replaceAll(RegExp(r'[^\d+]'), '');
    
    // Check for valid phone number pattern
    if (!RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(cleanedValue)) {
      return 'Bitte geben Sie eine gültige Telefonnummer ein';
    }
    
    return null;
  }

  /// Check if string contains only whitespace
  static bool isWhitespace(String? value) {
    return value == null || value.trim().isEmpty;
  }

  /// Sanitize string input
  static String sanitizeString(String input) {
    return input.trim().replaceAll(RegExp(r'\s+'), ' ');
  }
}