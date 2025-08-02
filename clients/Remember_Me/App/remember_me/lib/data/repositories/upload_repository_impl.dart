import 'package:dartz/dartz.dart';
import '../../domain/entities/upload_history_item.dart';
import '../../domain/repositories/upload_repository.dart';
import '../../core/errors/failures.dart';
import '../datasources/remote/firebase_storage_service.dart';
import '../datasources/local/local_storage.dart';

class UploadRepositoryImpl implements UploadRepository {
  final FirebaseStorageService firebaseStorageService;
  final LocalStorage localStorage;

  UploadRepositoryImpl({
    required this.firebaseStorageService,
    required this.localStorage,
  });

  @override
  Future<Either<Failure, String>> uploadFile(String filePath) async {
    try {
      final fileName = filePath.split('/').last;
      final downloadUrl = await firebaseStorageService.uploadFile(filePath, fileName);
      return Right(downloadUrl);
    } catch (e) {
      return Left(UploadFailure('Failed to upload file: $e'));
    }
  }

  @override
  Future<Either<Failure, List<UploadHistoryItem>>> getUploadHistory() async {
    try {
      // Mock implementation - would load from local storage
      return Right([]);
    } catch (e) {
      return Left(CacheFailure('Failed to load upload history: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> addUploadHistoryItem(UploadHistoryItem item) async {
    try {
      // Mock implementation - would save to local storage
      return Right(unit);
    } catch (e) {
      return Left(CacheFailure('Failed to add upload history item: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateUploadHistoryItem(UploadHistoryItem item) async {
    try {
      // Mock implementation - would update in local storage
      return Right(unit);
    } catch (e) {
      return Left(CacheFailure('Failed to update upload history item: $e'));
    }
  }
}