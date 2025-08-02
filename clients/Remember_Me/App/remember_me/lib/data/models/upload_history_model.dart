import 'package:remember_me/domain/enums.dart';

class UploadHistoryItem {
  final String id;
  final String fileName;
  final MediaType type;
  final int fileSize;
  final DateTime timestamp;
  final UploadStatus status;
  final double? progress;
  final String? errorMessage;
  final String? downloadUrl; 

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