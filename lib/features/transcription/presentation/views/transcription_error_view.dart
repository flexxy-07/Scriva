part of '../transcription_screen.dart';

class _ErrorView extends ConsumerWidget {
  final String audioPath;
  final TranscriptionState state;

  const _ErrorView({required this.audioPath, required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline_outlined,
              color: AppColors.error,
              size: 48,
            ),
            const SizedBox(height: 24),
            Text(
              'TRANSCRIPTION FAILED',
              style: GoogleFonts.spaceGrotesk(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              (state.errorMessage ?? 'UNKNOWN SYSTEM ERROR').toUpperCase(),
              style: GoogleFonts.spaceGrotesk(
                color: AppColors.textSecondary,
                fontSize: 11,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            AppButton(
              label: 'Retry Engine',
              icon: Icons.refresh_outlined,
              onTap: () => ref
                  .read(transcriptionControllerProvider(audioPath).notifier)
                  .retry(),
            ),
          ],
        ),
      ),
    );
  }
}
