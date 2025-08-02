import 'package:flutter/material.dart';
import 'package:remember_me/Core/Constants/app_constants.dart';
import 'package:remember_me/domain/enums.dart';

class Helpers {
  static Color getColorForMediaType(MediaType type) {
    switch (type) {
      case MediaType.video:
        return Colors.red.shade400;
      case MediaType.image:
        return Colors.green.shade400;
      case MediaType.audio:
        return Colors.purple.shade400;
      case MediaType.document:
        return Colors.blue.shade400;
    }
  }

  static IconData getIconForMediaType(MediaType type) {
    switch (type) {
      case MediaType.video:
        return Icons.play_circle_rounded;
      case MediaType.image:
        return Icons.image_rounded;
      case MediaType.audio:
        return Icons.music_note_rounded;
      case MediaType.document:
        return Icons.description_rounded;
    }
  }

  static Color getStatusColor(UploadStatus status) {
    switch (status) {
      case UploadStatus.completed:
        return Colors.green.shade400;
      case UploadStatus.uploading:
        return Colors.blue.shade400;
      case UploadStatus.failed:
        return Colors.red.shade400;
      case UploadStatus.pending:
        return Colors.orange.shade400;
    }
  }

  static IconData getStatusIcon(UploadStatus status) {
    switch (status) {
      case UploadStatus.completed:
        return Icons.check_circle_rounded;
      case UploadStatus.uploading:
        return Icons.upload_rounded;
      case UploadStatus.failed:
        return Icons.error_rounded;
      case UploadStatus.pending:
        return Icons.schedule_rounded;
    }
  }

  static String getStatusText(UploadStatus status) {
    switch (status) {
      case UploadStatus.pending:
        return 'Wartend';
      case UploadStatus.uploading:
        return 'Wird hochgeladen';
      case UploadStatus.completed:
        return 'Abgeschlossen';
      case UploadStatus.failed:
        return 'Fehlgeschlagen';
    }
  }

  static String getSectionIdForType(MediaType type) {
    switch (type) {
      case MediaType.video:
        return 'videos';
      case MediaType.image:
        return 'images';
      case MediaType.audio:
        return 'audio';
      case MediaType.document:
        return 'documents';
    }
  }

  static String generateFileName(MediaType type) {
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    switch (type) {
      case MediaType.video:
        return 'Video_$timestamp.mp4';
      case MediaType.image:
        return 'Photo_$timestamp.jpg';
      case MediaType.audio:
        return 'Audio_$timestamp.mp3';
      case MediaType.document:
        return 'Document_$timestamp.pdf';
    }
  }

  static int generateFileSize(MediaType type) {
    switch (type) {
      case MediaType.video:
        return 25165824; // 24 MB
      case MediaType.image:
        return 3145728; // 3 MB
      case MediaType.audio:
        return 8388608; // 8 MB
      case MediaType.document:
        return 2097152; // 2 MB
    }
  }

  static List<String> getSupportedExtensions(MediaType type) {
    switch (type) {
      case MediaType.video:
        return AppConstants.videoExtensions;
      case MediaType.image:
        return AppConstants.imageExtensions;
      case MediaType.audio:
        return AppConstants.audioExtensions;
      case MediaType.document:
        return AppConstants.documentExtensions;
    }
  }

  static int getMaxFileSize(MediaType type) {
    switch (type) {
      case MediaType.video:
        return AppConstants.maxVideoSize;
      case MediaType.image:
        return AppConstants.maxImageSize;
      case MediaType.audio:
        return AppConstants.maxAudioSize;
      case MediaType.document:
        return AppConstants.maxDocumentSize;
    }
  }
}