part of '../cleanup_screen.dart';

class _ErrorView extends ConsumerWidget {
  final String rawTranscript;
  final CleanupState state;

  const _ErrorView({required this.rawTranscript, required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              'Cleanup failed',
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
              label: 'Retry',
              icon: Icons.refresh_rounded,
              onTap: () => ref
                  .read(cleanupControllerProvider(rawTranscript).notifier)
                  .retry(),
            ),
          ],
        ),
      ),
    );
  }
}
