import 'package:get_it/get_it.dart';
import '../../presentation/blocs/auth/auth_bloc.dart';
import '../../presentation/blocs/media/media_bloc.dart';
import '../../presentation/blocs/upload/upload_bloc.dart';
import '../../domain/usecases/auth/login_user.dart';
import '../../domain/usecases/auth/register_user.dart';
import '../../domain/usecases/auth/logout_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/media_repository.dart';
import '../../domain/repositories/upload_repository.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/media_repository_impl.dart';
import '../../data/repositories/upload_repository_impl.dart';
import '../../data/datasources/remote/firebase_auth_service.dart';
import '../../data/datasources/remote/firebase_storage_service.dart';
import '../../data/datasources/local/local_storage.dart';

final sl = GetIt.instance;

Future<void> init() async {
  print('🚀 Initializing dependency injection...');

  // ========================
  // External Dependencies
  // ========================
  print('📱 Initializing external dependencies...');
  // Initialize Local Storage
  await LocalStorage.init();

  // ========================
  // Data Sources - LazySingleton
  // ========================
  print('📱 Registering data sources...');
  sl.registerLazySingleton(() => FirebaseAuthService());
  sl.registerLazySingleton(() => FirebaseStorageService());
  sl.registerLazySingleton(() => LocalStorage());

  // ========================
  // Repositories - LazySingleton
  // ========================
  print('🗄️ Registering repositories...');
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        firebaseAuthService: sl(),
        localStorage: sl(),
      ));

  sl.registerLazySingleton<MediaRepository>(() => MediaRepositoryImpl(
        localStorage: sl(),
      ));

  sl.registerLazySingleton<UploadRepository>(() => UploadRepositoryImpl(
        firebaseStorageService: sl(),
        localStorage: sl(),
      ));

  // ========================
  // Use Cases - LazySingleton
  // ========================
  print('⚙️ Registering use cases...');
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => RegisterUser(sl()));
  sl.registerLazySingleton(() => LogoutUser(sl()));

  // ========================
  // BLoCs - Factory (neue Instanz bei jedem Aufruf)
  // ========================
  print('🧠 Registering BLoCs...');
  sl.registerFactory(() => AuthBloc(
        loginUser: sl(),
        registerUser: sl(),
        logoutUser: sl(),
        authRepository: sl(),
      ));

  sl.registerFactory(() => MediaBloc());
  sl.registerFactory(() => UploadBloc());

  print('✅ Dependency injection initialized successfully!');
}

Future<void> reset() async {
  await sl.reset();
}