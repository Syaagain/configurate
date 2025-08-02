import 'package:equatable/equatable.dart';
import '../../../domain/entities/upload_history_item.dart';

abstract class UploadState extends Equatable {
  const UploadState();

  @override
  List<Object?> get props => [];
}

class UploadInitial extends UploadState {}

class UploadLoading extends UploadState {}

class UploadHistoryLoaded extends UploadState {
  final List<UploadHistoryItem> history;

  const UploadHistoryLoaded(this.history);

  @override
  List<Object?> get props => [history];
}

class UploadInProgress extends UploadState {
  final List<UploadHistoryItem> history;
  final String currentUploadId;
  final double progress;

  const UploadInProgress(this.history, this.currentUploadId, this.progress);

  @override
  List<Object?> get props => [history, currentUploadId, progress];
}

class UploadCompleted extends UploadState {
  final List<UploadHistoryItem> history;
  final String uploadId;

  const UploadCompleted(this.history, this.uploadId);

  @override
  List<Object?> get props => [history, uploadId];
}

class UploadError extends UploadState {
  final String message;
  final List<UploadHistoryItem> history;

  const UploadError(this.message, this.history);

  @override
  List<Object?> get props => [message, history];
}