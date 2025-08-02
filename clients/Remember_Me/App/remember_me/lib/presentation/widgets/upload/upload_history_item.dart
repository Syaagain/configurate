import 'package:flutter/material.dart';
import 'package:remember_me/domain/enums.dart';
import '../../../domain/entities/upload_history_item.dart';
import '../../../core/utils/helpers.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/strings.dart';
import 'upload_progress_indicator.dart';

class UploadHistoryItemWidget extends StatelessWidget {
  final UploadHistoryItem item;
  final int index;
  final Animation<double> animation;

  const UploadHistoryItemWidget({
    Key? key,
    required this.item,
    required this.index,
    required this.animation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final statusColor = Helpers.getStatusColor(item.status);
    final statusIcon = Helpers.getStatusIcon(item.status);
    
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - animation.value.clamp(0.0, 1.0)) * (index + 1) * 0.1),
          child: Container(
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(AppConstants.largeBorderRadius),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 15,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => _showHistoryItemDetails(context),
                borderRadius: BorderRadius.circular(AppConstants.largeBorderRadius),
                child: Padding(
                  padding: EdgeInsets.all(AppConstants.largePadding),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Helpers.getColorForMediaType(item.type).withOpacity(0.8),
                          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                          boxShadow: [
                            BoxShadow(
                              color: Helpers.getColorForMediaType(item.type).withOpacity(0.3),
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(
                          Helpers.getIconForMediaType(item.type),
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              item.fileName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 6),
                            Row(
                              children: [
                                Text(
                                  Formatters.formatFileSize(item.fileSize),
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  ' • ',
                                  style: TextStyle(color: Colors.white.withOpacity(0.5)),
                                ),
                                Text(
                                  Formatters.formatDate(item.timestamp),
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            if (item.status == UploadStatus.uploading && item.progress != null) ...[
                              SizedBox(height: 8),
                              UploadProgressIndicator(progress: item.progress!),
                            ],
                            if (item.status == UploadStatus.failed && item.errorMessage != null) ...[
                              SizedBox(height: 6),
                              Text(
                                item.errorMessage!,
                                style: TextStyle(
                                  color: Colors.red.shade300,
                                  fontSize: 12,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ],
                        ),
                      ),
                      SizedBox(width: 12),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: statusColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                            ),
                            child: Icon(statusIcon, color: statusColor, size: 20),
                          ),
                          if (item.status == UploadStatus.uploading && item.progress != null) ...[
                            SizedBox(height: 4),
                            Text(
                              Formatters.formatProgress(item.progress!),
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white.withOpacity(0.7),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showHistoryItemDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.deepPurple.shade800,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.largeBorderRadius)),
        title: Text(
          'Upload Details',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Datei:', item.fileName),
            _buildDetailRow('Größe:', Formatters.formatFileSize(item.fileSize)),
            _buildDetailRow('Typ:', item.type.toString().split('.').last),
            _buildDetailRow('Datum:', Formatters.formatDate(item.timestamp)),
            _buildDetailRow('Status:', Helpers.getStatusText(item.status)),
            if (item.downloadUrl != null) ...[
              SizedBox(height: 8),
              Text(
                'Download URL:',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 4),
              Text(
                item.downloadUrl!,
                style: TextStyle(fontSize: 12, color: Colors.blue.shade300),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
        actions: [
          if (item.status == UploadStatus.completed && item.downloadUrl != null)
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppStrings.share, style: TextStyle(color: Colors.blue.shade300)),
            ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppStrings.close, style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 60,
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}