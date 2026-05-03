import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scriva/features/transcription/domain/transcription.dart';
import 'transcription_controller.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../shared/widgets/app_button.dart';
import '../../cleanup/presentation/cleanup_screen.dart';

part 'views/transcription_transcribing_view.dart';
part 'views/transcription_done_view.dart';
part 'views/transcription_error_view.dart';

void _copyToClipboard(BuildContext context, String text) {
  Clipboard.setData(ClipboardData(text: text));
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Copied to clipboard'),
      backgroundColor: AppColors.surface2,
      duration: Duration(seconds: 2),
    ),
  );
}

class TranscriptionScreen extends ConsumerWidget {
  final String audioPath;
  const TranscriptionScreen({super.key, required this.audioPath});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(transcriptionControllerProvider(audioPath));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transcript'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          if (state.isDone)
            IconButton(
              icon: const Icon(
                Icons.copy_rounded,
                color: AppColors.textSecondary,
              ),
              onPressed: () => _copyToClipboard(context, state.rawTranscript!),
            ),
        ],
      ),
      body: SafeArea(
        child: switch (state.status) {
          TranscriptionStatus.idle => const SizedBox.shrink(),
          TranscriptionStatus.transcribing => const _TranscribingView(),
          TranscriptionStatus.done => _DoneView(audioPath: audioPath, state: state),
          TranscriptionStatus.error => _ErrorView(audioPath: audioPath, state: state),
        },
      ),
    );
  }
}


// Animated transcribing indicator
class _TranscribingAnimation extends StatefulWidget {
  const _TranscribingAnimation();

  @override
  State<_TranscribingAnimation> createState() => _TranscribingAnimationState();
}

class _TranscribingAnimationState extends State<_TranscribingAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    _rotation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _rotation,
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.primary, width: 3),
          gradient: SweepGradient(
            colors: [AppColors.primary.withOpacity(0), AppColors.primary],
          ),
        ),
        child: const Center(
          child: Icon(Icons.mic_rounded, color: AppColors.primary, size: 28),
        ),
      ),
    );
  }
}

class _OutlineButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _OutlineButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.surface2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.textSecondary, size: 16),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
