part of '../transcription_screen.dart';

class _TranscribingView extends ConsumerWidget {
  final String audioPath;

  const _TranscribingView({required this.audioPath});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(transcriptionControllerProvider(audioPath));

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const TechnicalPulseAnimation(),
          const SizedBox(height: 32),
          Text(
            'ENGINE ACTIVE',
            style: GoogleFonts.spaceGrotesk(
              color: AppColors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 12),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Text(
              state.progressMessage.toUpperCase(),
              key: ValueKey(state.progressMessage),
              style: GoogleFonts.spaceGrotesk(
                color: AppColors.textSecondary,
                fontSize: 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.0,
              ),
            ),
          ),
          const SizedBox(height: 48),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 48),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              border: Border.all(color: AppColors.surface2, width: 1),
            ),
            child: Row(
              children: [
                const Icon(Icons.security_outlined,
                    color: AppColors.primary, size: 16),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'LOCAL PROCESSING ACTIVE. DATA PERSISTED ON SECURE LOCAL STORAGE.',
                    style: GoogleFonts.spaceGrotesk(
                      color: AppColors.textSecondary,
                      fontSize: 9,
                      height: 1.6,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
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
