part of '../cleanup_screen.dart';

class _DoneView extends ConsumerWidget {
  final String rawTranscript;
  final CleanupState state;

  const _DoneView({required this.rawTranscript, required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        // Badge bar
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          color: AppColors.surface,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  state.selectedMode.label.toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.success,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '${state.cleanedText!.split(' ').length} words',
                style: const TextStyle(
                    color: AppColors.textSecondary, fontSize: 13),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => ref
                    .read(cleanupControllerProvider(rawTranscript)
                        .notifier)
                    .reset(),
                child: const Text(
                  'Try another mode',
                  style: TextStyle(
                      color: AppColors.primary, fontSize: 12),
                ),
              ),
            ],
          ),
        ),

        // Cleaned text
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: SelectableText(
              state.cleanedText!,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                height: 1.75,
              ),
            ),
          ),
        ),

        // Actions
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            border: Border(
              top: BorderSide(
                  color: AppColors.surface2.withOpacity(0.5)),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: _OutlineButton(
                  label: 'Copy',
                  icon: Icons.copy_rounded,
                  onTap: () =>
                      _copyToClipboard(context, state.cleanedText!),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _OutlineButton(
                  label: 'Share',
                  icon: Icons.share_rounded,
                  onTap: () {
                    // Share — coming Step 7
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Share coming soon!'),
                        backgroundColor: AppColors.surface2,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
