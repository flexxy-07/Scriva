import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scriva/features/transcription/domain/transcription.dart';
import 'transcription_controller.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../shared/widgets/app_button.dart';

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
              icon: const Icon(Icons.copy_rounded,
                  color: AppColors.textSecondary),
              onPressed: () => _copyToClipboard(context, state.rawTranscript!),
            ),
        ],
      ),
      body: SafeArea(
        child: switch (state.status) {
          TranscriptionStatus.idle => const SizedBox.shrink(),
          TranscriptionStatus.transcribing => _buildTranscribing(),
          TranscriptionStatus.done => _buildDone(context, ref, state),
          TranscriptionStatus.error => _buildError(context, ref, state),
        },
      ),
    );
  }

  Widget _buildTranscribing() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _TranscribingAnimation(),
          SizedBox(height: 24),
          Text(
            'Transcribing...',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Running on-device — this may take a moment',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildDone(
      BuildContext context, WidgetRef ref, TranscriptionState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          color: AppColors.surface,
          child: Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'RAW',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '${state.rawTranscript!.split(' ').length} words',
                style: const TextStyle(
                    color: AppColors.textSecondary, fontSize: 13),
              ),
              const Spacer(),
              const Icon(Icons.lock_outline_rounded,
                  color: AppColors.textSecondary, size: 14),
              const SizedBox(width: 4),
              const Text(
                'on-device',
                style:
                    TextStyle(color: AppColors.textSecondary, fontSize: 12),
              ),
            ],
          ),
        ),

        // Transcript text
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: SelectableText(
              state.rawTranscript!,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                height: 1.7,
              ),
            ),
          ),
        ),

        // Bottom actions
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            border: Border(
              top: BorderSide(
                  color: AppColors.surface2.withOpacity(0.5), width: 1),
            ),
          ),
          child: Column(
            children: [
              // Cleanup button — placeholder for Step 5
              SizedBox(
                width: double.infinity,
                child: AppButton(
                  label: 'Clean with AI',
                  icon: Icons.auto_fix_high_rounded,
                  onTap: () {
                    // Cleanup — coming Step 5
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('AI Cleanup coming in next step!'),
                        backgroundColor: AppColors.surface2,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _OutlineButton(
                      label: 'Copy',
                      icon: Icons.copy_rounded,
                      onTap: () => _copyToClipboard(
                          context, state.rawTranscript!),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _OutlineButton(
                      label: 'Save',
                      icon: Icons.save_outlined,
                      onTap: () {
                        // History save — coming Step 5
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Save to history coming next!'),
                            backgroundColor: AppColors.surface2,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildError(
      BuildContext context, WidgetRef ref, TranscriptionState state) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline_rounded,
                color: AppColors.error, size: 48),
            const SizedBox(height: 16),
            const Text(
              'Transcription failed',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              state.errorMessage ?? 'Something went wrong',
              style: const TextStyle(
                  color: AppColors.textSecondary, fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            AppButton(
              label: 'Try Again',
              icon: Icons.refresh_rounded,
              onTap: () =>
                  ref.read(transcriptionControllerProvider(audioPath)
                      .notifier).retry(),
            ),
          ],
        ),
      ),
    );
  }

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
}

// Animated transcribing indicator
class _TranscribingAnimation extends StatefulWidget {
  const _TranscribingAnimation();

  @override
  State<_TranscribingAnimation> createState() =>
      _TranscribingAnimationState();
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
          border: Border.all(
            color: AppColors.primary,
            width: 3,
          ),
          gradient: SweepGradient(
            colors: [
              AppColors.primary.withOpacity(0),
              AppColors.primary,
            ],
          ),
        ),
        child: const Center(
          child: Icon(
            Icons.mic_rounded,
            color: AppColors.primary,
            size: 28,
          ),
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
                  color: AppColors.textSecondary, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}