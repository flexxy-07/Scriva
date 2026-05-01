import 'package:flutter/material.dart';
import '../../../shared/theme/app_theme.dart';

class RecordingScreen extends StatelessWidget {
  const RecordingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scriva')),
      body: const Center(
        child: Text(
          'Recording screen coming next...',
          style: TextStyle(color: AppColors.textSecondary),
        ),
      ),
    );
  }
}