import 'package:equatable/equatable.dart';
import 'package:remember_me/domain/enums.dart';

class UploadHistoryItem extends Equatable {
  final String id;
  final String fileName;
  final MediaType type;
  final int fileSize;
  final DateTime timestamp;
  final UploadStatus status;
  final double? progress;
  final String? errorMessage;
  final String? downloadUrl;

  const UploadHistoryItem({
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
    String? id,
    String? fileName,
    MediaType? type,
    int? fileSize,
    DateTime? timestamp,
    UploadStatus? status,
    double? progress,
    String? errorMessage,
    String? downloadUrl,
  }) {
    return UploadHistoryItem(
      id: id ?? this.id,
      fileName: fileName ?? this.fileName,
      type: type ?? this.type,
      fileSize: fileSize ?? this.fileSize,
      timestamp: timestamp ?? this.timestamp,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      errorMessage: errorMessage ?? this.errorMessage,
      downloadUrl: downloadUrl ?? this.downloadUrl,
    );
  }

  @override
  List<Object?> get props => [
        id,
        fileName,
        type,
        fileSize,
        timestamp,
        status,
        progress,
        errorMessage,
        downloadUrl,
      ];
}