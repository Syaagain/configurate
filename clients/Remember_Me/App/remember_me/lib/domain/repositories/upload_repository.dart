import 'package:dartz/dartz.dart';
import '../entities/upload_history_item.dart';
import '../../core/errors/failures.dart';

abstract class UploadRepository {
  Future<Either<Failure, String>> uploadFile(String filePath);
  Future<Either<Failure, List<UploadHistoryItem>>> getUploadHistory();
  Future<Either<Failure, Unit>> addUploadHistoryItem(UploadHistoryItem item);
  Future<Either<Failure, Unit>> updateUploadHistoryItem(UploadHistoryItem item);
}