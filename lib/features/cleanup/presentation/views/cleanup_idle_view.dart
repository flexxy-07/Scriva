part of '../cleanup_screen.dart';

class _IdleView extends ConsumerWidget {
  final String rawTranscript;
  final CleanupState state;

  const _IdleView({required this.rawTranscript, required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Raw transcript preview',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  rawTranscript.length > 200
                      ? '${rawTranscript.substring(0, 200)}...'
                      : rawTranscript,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: AppButton(
              label: 'Clean with ${state.selectedMode.label}',
              icon: Icons.auto_fix_high_rounded,
              onTap: () => ref
                  .read(cleanupControllerProvider(rawTranscript).notifier)
                  .runCleanup(),
            ),
          ),
        ],
      ),
    );
  }
}
