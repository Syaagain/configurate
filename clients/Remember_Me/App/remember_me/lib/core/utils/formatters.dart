class Formatters {
  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  static String formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;
    
    if (difference == 0) return 'Heute ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    if (difference == 1) return 'Gestern';
    if (difference < 7) return 'vor $difference Tagen';
    return '${date.day}.${date.month}.${date.year}';
  }

  static String formatDateSimple(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;
    
    if (difference == 0) return 'Heute';
    if (difference == 1) return 'Gestern';
    if (difference < 7) return 'vor $difference Tagen';
    return '${date.day}.${date.month}.${date.year}';
  }

  static String formatProgress(double progress) {
    return '${(progress * 100).toInt()}%';
  }
}