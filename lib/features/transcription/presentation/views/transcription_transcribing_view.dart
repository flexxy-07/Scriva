part of '../transcription_screen.dart';

class _TranscribingView extends ConsumerWidget {
  final String audioPath;

  const _TranscribingView({required this.audioPath});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch state to get progress message
    final state = ref.watch(
        transcriptionControllerProvider(audioPath));

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const _TranscribingAnimation(),
          const SizedBox(height: 24),
          const Text(
            'Transcribing...',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Text(
              state.progressMessage,
              key: ValueKey(state.progressMessage),
              style: const TextStyle(
                  color: AppColors.textSecondary, fontSize: 13),
            ),
          ),
          const SizedBox(height: 32),
          // Tip while waiting
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                Icon(Icons.lock_outline_rounded,
                    color: AppColors.primary, size: 16),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Processing entirely on your device.\nNo data leaves your phone.',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
