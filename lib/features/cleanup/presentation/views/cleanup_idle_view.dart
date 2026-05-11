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
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.surface,
              border: Border.all(color: AppColors.surface2, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'RAW SOURCE PREVIEW',
                  style: GoogleFonts.spaceGrotesk(
                    color: AppColors.textSecondary,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  rawTranscript.length > 300
                      ? '${rawTranscript.substring(0, 300)}...'
                      : rawTranscript,
                  style: GoogleFonts.inter(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    height: 1.7,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          AppButton(
            label: 'Process with ${state.selectedMode.label}',
            icon: Icons.auto_fix_high_outlined,
            onTap: () => ref
                .read(cleanupControllerProvider(rawTranscript).notifier)
                .runCleanup(),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
