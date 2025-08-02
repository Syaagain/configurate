import 'package:flutter/material.dart';

class UploadProgressIndicator extends StatelessWidget {
  final double progress;

  const UploadProgressIndicator({Key? key, required this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: LinearProgressIndicator(
        value: progress,
        backgroundColor: Colors.white.withOpacity(0.2),
        valueColor: AlwaysStoppedAnimation(Colors.blue.shade300),
        minHeight: 6,
      ),
    );
  }
}
