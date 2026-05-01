import 'package:flutter/material.dart';
import '../../../shared/theme/app_theme.dart';

class TranscriptionScreen extends StatelessWidget {
  final String audioPath;
  const TranscriptionScreen({super.key, required this.audioPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transcript')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Transcription coming next...\n\nFile: $audioPath',
            style: const TextStyle(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}