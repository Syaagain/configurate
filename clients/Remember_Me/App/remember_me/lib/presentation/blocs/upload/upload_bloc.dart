import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remember_me/domain/enums.dart';
import 'upload_event.dart';
import 'upload_state.dart';
import '../../../domain/entities/upload_history_item.dart';
import '../../../core/utils/helpers.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  List<UploadHistoryItem> _uploadHistory = [];

  UploadBloc() : super(UploadInitial()) {
    on<UploadHistoryLoadRequested>(_onHistoryLoadRequested);
    on<UploadSimulationRequested>(_onSimulationRequested);
    on<UploadHistoryItemAdded>(_onHistoryItemAdded);
    on<UploadHistoryItemUpdated>(_onHistoryItemUpdated);
    on<UploadProgressUpdated>(_onProgressUpdated);
  }

  Future<void> _onHistoryLoadRequested(
    UploadHistoryLoadRequested event,
    Emitter<UploadState> emit,
  ) async {
    emit(UploadLoading());
    
    // Initialize with sample data
    _uploadHistory = [
      UploadHistoryItem(
        id: 'hist_1',
        fileName: 'Beispiel_Video.mp4',
        type: MediaType.video,
        fileSize: 12582912,
        timestamp: DateTime.now().subtract(Duration(hours: 2)),
        status: UploadStatus.completed,
        downloadUrl: 'https://firebase-storage-url...',
      ),
      UploadHistoryItem(
        id: 'hist_2',
        fileName: 'Test_Bild.jpg',
        type: MediaType.image,
        fileSize: 1048576,
        timestamp: DateTime.now().subtract(Duration(days: 1)),
        status: UploadStatus.completed,
        downloadUrl: 'https://firebase-storage-url...',
      ),
    ];
    
    emit(UploadHistoryLoaded(_uploadHistory));
  }

  Future<void> _onSimulationRequested(
    UploadSimulationRequested event,
    Emitter<UploadState> emit,
  ) async {
    final fileName = Helpers.generateFileName(event.type);
    final fileSize = Helpers.generateFileSize(event.type);
    
    final historyItem = UploadHistoryItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      fileName: fileName,
      type: event.type,
      fileSize: fileSize,
      timestamp: DateTime.now(),
      status: UploadStatus.pending,
    );

    _uploadHistory.insert(0, historyItem);
    emit(UploadHistoryLoaded(_uploadHistory));

    // Start upload simulation
    await _simulateUpload(historyItem, emit);
  }

  Future<void> _onHistoryItemAdded(
    UploadHistoryItemAdded event,
    Emitter<UploadState> emit,
  ) async {
    _uploadHistory.insert(0, event.item);
    emit(UploadHistoryLoaded(_uploadHistory));
  }

  Future<void> _onHistoryItemUpdated(
    UploadHistoryItemUpdated event,
    Emitter<UploadState> emit,
  ) async {
    final index = _uploadHistory.indexWhere((item) => item.id == event.item.id);
    if (index != -1) {
      _uploadHistory[index] = event.item;
      
      if (event.item.status == UploadStatus.uploading) {
        emit(UploadInProgress(_uploadHistory, event.item.id, event.item.progress ?? 0.0));
      } else if (event.item.status == UploadStatus.completed) {
        emit(UploadCompleted(_uploadHistory, event.item.id));
      } else {
        emit(UploadHistoryLoaded(_uploadHistory));
      }
    }
  }

  Future<void> _onProgressUpdated(
    UploadProgressUpdated event,
    Emitter<UploadState> emit,
  ) async {
    final index = _uploadHistory.indexWhere((item) => item.id == event.uploadId);
    if (index != -1) {
      _uploadHistory[index] = _uploadHistory[index].copyWith(
        progress: event.progress,
        status: event.progress >= 1.0 ? UploadStatus.completed : UploadStatus.uploading,
      );
      
      if (event.progress >= 1.0) {
        emit(UploadCompleted(_uploadHistory, event.uploadId));
      } else {
        emit(UploadInProgress(_uploadHistory, event.uploadId, event.progress));
      }
    }
  }

  Future<void> _simulateUpload(UploadHistoryItem item, Emitter<UploadState> emit) async {
    // Update to uploading status
    add(UploadHistoryItemUpdated(item.copyWith(
      status: UploadStatus.uploading,
      progress: 0.0,
    )));

    // Simulate upload progress
    for (int i = 0; i <= 100; i += 2) {
      await Future.delayed(Duration(milliseconds: 50));
      add(UploadProgressUpdated(item.id, i / 100.0));
    }

    // Complete upload
    final downloadUrl = 'https://firebasestorage.googleapis.com/v0/b/project/o/${item.fileName}';
    add(UploadHistoryItemUpdated(item.copyWith(
      status: UploadStatus.completed,
      progress: 1.0,
      downloadUrl: downloadUrl,
    )));
  }
}