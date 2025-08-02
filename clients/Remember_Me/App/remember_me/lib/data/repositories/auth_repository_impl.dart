import 'package:dartz/dartz.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../core/errors/failures.dart';
import '../../core/errors/exceptions.dart';
import '../datasources/remote/firebase_auth_service.dart';
import '../datasources/local/local_storage.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthService firebaseAuthService;
  final LocalStorage localStorage;

  AuthRepositoryImpl({
    required this.firebaseAuthService,
    required this.localStorage,
  });

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final user = await firebaseAuthService.signInWithEmailAndPassword(
        email,
        password,
      );
      
      // Save user data locally for offline access
      await _saveUserToLocalStorage(user);
      
      return Right(user);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Ein unerwarteter Fehler ist aufgetreten'));
    }
  }

  @override
  Future<Either<Failure, User>> register(
    String name, 
    String email, 
    String password,
  ) async {
    try {
      final user = await firebaseAuthService.createUserWithEmailAndPassword(
        name,
        email,
        password,
      );
      
      // Save user data locally
      await _saveUserToLocalStorage(user);
      
      return Right(user);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Ein unerwarteter Fehler ist aufgetreten'));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await firebaseAuthService.signOut();
      await _clearUserFromLocalStorage();
      return Right(unit);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Abmeldung fehlgeschlagen'));
    }
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      // Try to get current user from Firebase first
      final user = firebaseAuthService.getCurrentUser();
      
      if (user != null) {
        await _saveUserToLocalStorage(user);
        return Right(user);
      }
      
      // If no Firebase user, try to get from local storage
      final localUser = await _getUserFromLocalStorage();
      return Right(localUser);
      
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Benutzer konnte nicht abgerufen werden'));
    }
  }

  @override
  Future<Either<Failure, Unit>> sendPasswordResetEmail(String email) async {
    try {
      await firebaseAuthService.sendPasswordResetEmail(email);
      return Right(unit);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Passwort-Reset E-Mail konnte nicht gesendet werden'));
    }
  }

  /// Save user to local storage
  Future<void> _saveUserToLocalStorage(User user) async {
    try {
      await localStorage.saveString('user_id', user.id);
      await localStorage.saveString('user_email', user.email);
      if (user.displayName != null) {
        await localStorage.saveString('user_display_name', user.displayName!);
      }
      if (user.photoURL != null) {
        await localStorage.saveString('user_photo_url', user.photoURL!);
      }
      await localStorage.saveString('user_created_at', user.createdAt.toIso8601String());
    } catch (e) {
      // Local storage save failed, but don't fail the main operation
      print('Failed to save user to local storage: $e');
    }
  }

  /// Get user from local storage
  Future<User?> _getUserFromLocalStorage() async {
    try {
      final userId = await localStorage.getString('user_id');
      final userEmail = await localStorage.getString('user_email');
      
      if (userId == null || userEmail == null) return null;
      
      final displayName = await localStorage.getString('user_display_name');
      final photoURL = await localStorage.getString('user_photo_url');
      final createdAtString = await localStorage.getString('user_created_at');
      
      final createdAt = createdAtString != null
          ? DateTime.parse(createdAtString)
          : DateTime.now();
      
      return User(
        id: userId,
        email: userEmail,
        displayName: displayName,
        photoURL: photoURL,
        createdAt: createdAt,
      );
    } catch (e) {
      return null;
    }
  }

  Future<void> _clearUserFromLocalStorage() async {
    try {
      await localStorage.remove('user_id');
      await localStorage.remove('user_email');
      await localStorage.remove('user_display_name');
      await localStorage.remove('user_photo_url');
      await localStorage.remove('user_created_at');
    } catch (e) {
      print('Failed to clear user from local storage: $e');
    }
  }
}