import 'package:dartz/dartz.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../core/errors/failures.dart';
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
      // Simulate delay
      await Future.delayed(Duration(seconds: 2));
      
      // Mock successful login
      final user = User(
        id: 'user_123',
        email: email,
        name: 'Test User',
        createdAt: DateTime.now(),
      );
      
      // Save login state to local storage
      await localStorage.saveBool('isLoggedIn', true);
      await localStorage.saveString('userEmail', email);
      
      return Right(user);
    } catch (e) {
      return Left(AuthFailure('Login failed: $e'));
    }
  }

  @override
  Future<Either<Failure, User>> register(String name, String email, String password) async {
    try {
      // Simulate delay
      await Future.delayed(Duration(seconds: 2));
      
      // Mock successful registration
      final user = User(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        name: name,
        createdAt: DateTime.now(),
      );
      
      // Save login state to local storage
      await localStorage.saveBool('isLoggedIn', true);
      await localStorage.saveString('userEmail', email);
      await localStorage.saveString('userName', name);
      
      return Right(user);
    } catch (e) {
      return Left(AuthFailure('Registration failed: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      // Simulate delay
      await Future.delayed(Duration(milliseconds: 500));
      
      // Call Firebase Auth logout
      await firebaseAuthService.signOut();
      
      // Clear local storage
      await localStorage.remove('isLoggedIn');
      await localStorage.remove('userEmail');
      await localStorage.remove('userName');
      await localStorage.remove('authToken');
      
      return Right(unit);
    } catch (e) {
      return Left(AuthFailure('Logout failed: $e'));
    }
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      // Check if user is logged in
      final isLoggedIn = await localStorage.getBool('isLoggedIn') ?? false;
      
      if (!isLoggedIn) {
        return Right(null);
      }
      
      // Get user data from local storage
      final email = await localStorage.getString('userEmail');
      final name = await localStorage.getString('userName');
      
      if (email != null) {
        final user = User(
          id: 'user_123',
          email: email,
          name: name,
          createdAt: DateTime.now().subtract(Duration(days: 30)), // Mock creation date
        );
        return Right(user);
      }
      
      return Right(null);
    } catch (e) {
      return Left(AuthFailure('Failed to get current user: $e'));
    }
  }
}