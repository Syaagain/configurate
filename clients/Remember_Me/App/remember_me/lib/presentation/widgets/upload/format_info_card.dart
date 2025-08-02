import 'package:flutter/material.dart';
import '../../../core/constants/strings.dart';
import '../../../core/constants/app_constants.dart';

class FormatInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppConstants.largePadding),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline_rounded, color: Colors.white, size: 24),
              SizedBox(width: 12),
              Text(
                AppStrings.supportedFormats,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          _buildFormatRow(Icons.videocam_rounded, AppStrings.videos, 'MP4, AVI, MOV, WMV', Colors.red.shade300),
          SizedBox(height: 12),
          _buildFormatRow(Icons.image_rounded, 'Bilder', 'JPG, PNG, GIF, WEBP', Colors.green.shade300),
          SizedBox(height: 12),
          _buildFormatRow(Icons.audiotrack_rounded, AppStrings.audio, 'MP3, WAV, AAC, FLAC', Colors.purple.shade300),
          SizedBox(height: 12),
          _buildFormatRow(Icons.description_rounded, AppStrings.documents, 'PDF, DOC, TXT, XLS', Colors.blue.shade300),
        ],
      ),
    );
  }

  Widget _buildFormatRow(IconData icon, String title, String formats, Color color) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 2),
              Text(
                formats,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}