import 'package:equatable/equatable.dart';
import 'package:remember_me/domain/enums.dart';
import '../../../domain/entities/upload_history_item.dart';

abstract class UploadEvent extends Equatable {
  const UploadEvent();

  @override
  List<Object?> get props => [];
}

class UploadHistoryLoadRequested extends UploadEvent {}

class UploadFileRequested extends UploadEvent {
  final String filePath;
  final MediaType type;

  const UploadFileRequested(this.filePath, this.type);

  @override
  List<Object?> get props => [filePath, type];
}

class UploadSimulationRequested extends UploadEvent {
  final MediaType type;

  const UploadSimulationRequested(this.type);

  @override
  List<Object?> get props => [type];
}

class UploadHistoryItemAdded extends UploadEvent {
  final UploadHistoryItem item;

  const UploadHistoryItemAdded(this.item);

  @override
  List<Object?> get props => [item];
}

class UploadHistoryItemUpdated extends UploadEvent {
  final UploadHistoryItem item;

  const UploadHistoryItemUpdated(this.item);

  @override
  List<Object?> get props => [item];
}

class UploadProgressUpdated extends UploadEvent {
  final String uploadId;
  final double progress;

  const UploadProgressUpdated(this.uploadId, this.progress);

  @override
  List<Object?> get props => [uploadId, progress];
}