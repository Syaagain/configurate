
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../../../domain/entities/user.dart' as domain;
import '../../../core/errors/exceptions.dart';

class FirebaseAuthService {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  FirebaseAuthService({firebase_auth.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  /// Sign in with email and password
  Future<domain.User> signInWithEmailAndPassword(
    String email, 
    String password,
  ) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      if (credential.user == null) {
        throw AuthException('Benutzer nicht gefunden');
      }
      
      return _mapFirebaseUserToDomainUser(credential.user!);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw AuthException(_mapFirebaseAuthErrorMessage(e.code));
    } catch (e) {
      throw AuthException('Ein unerwarteter Fehler ist aufgetreten');
    }
  }

  /// Create user with email and password
  Future<domain.User> createUserWithEmailAndPassword(
    String name,
    String email, 
    String password,
  ) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      if (credential.user == null) {
        throw AuthException('Benutzer konnte nicht erstellt werden');
      }

      // Update display name
      await credential.user!.updateDisplayName(name);
      await credential.user!.reload();
      
      return _mapFirebaseUserToDomainUser(credential.user!);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw AuthException(_mapFirebaseAuthErrorMessage(e.code));
    } catch (e) {
      throw AuthException('Ein unerwarteter Fehler ist aufgetreten');
    }
  }

  /// Sign out current user
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw AuthException('Abmeldung fehlgeschlagen');
    }
  }

  /// Get current user
  domain.User? getCurrentUser() {
    final firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) return null;
    
    return _mapFirebaseUserToDomainUser(firebaseUser);
  }

  /// Stream of auth state changes
  Stream<domain.User?> get authStateChanges {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser != null 
          ? _mapFirebaseUserToDomainUser(firebaseUser) 
          : null;
    });
  }

  /// Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw AuthException(_mapFirebaseAuthErrorMessage(e.code));
    } catch (e) {
      throw AuthException('Passwort-Reset E-Mail konnte nicht gesendet werden');
    }
  }

  /// Map Firebase User to Domain User
  domain.User _mapFirebaseUserToDomainUser(firebase_auth.User firebaseUser) {
    return domain.User(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      displayName: firebaseUser.displayName,
      photoURL: firebaseUser.photoURL,
      emailVerified: firebaseUser.emailVerified ? DateTime.now() : null,
      createdAt: firebaseUser.metadata.creationTime ?? DateTime.now(),
    );
  }

  /// Map Firebase Auth error codes to German messages
  String _mapFirebaseAuthErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return 'Kein Benutzer mit dieser E-Mail-Adresse gefunden';
      case 'wrong-password':
        return 'Falsches Passwort';
      case 'invalid-email':
        return 'Ungültige E-Mail-Adresse';
      case 'user-disabled':
        return 'Dieses Benutzerkonto wurde deaktiviert';
      case 'too-many-requests':
        return 'Zu viele Anmeldeversuche. Versuchen Sie es später erneut';
      case 'email-already-in-use':
        return 'Diese E-Mail-Adresse wird bereits verwendet';
      case 'operation-not-allowed':
        return 'Diese Anmeldeart ist nicht aktiviert';
      case 'weak-password':
        return 'Das Passwort ist zu schwach';
      case 'invalid-credential':
        return 'Ungültige Anmeldedaten';
      case 'account-exists-with-different-credential':
        return 'Ein Konto mit dieser E-Mail existiert bereits';
      case 'requires-recent-login':
        return 'Diese Aktion erfordert eine erneute Anmeldung';
      case 'network-request-failed':
        return 'Netzwerkfehler. Überprüfen Sie Ihre Internetverbindung';
      default:
        return 'Ein Authentifizierungsfehler ist aufgetreten: $errorCode';
    }
  }
}