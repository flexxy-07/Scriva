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
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: const BoxDecoration(
            color: AppColors.surface,
            border: Border(
              bottom: BorderSide(color: AppColors.surface2, width: 1),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: const BoxDecoration(
                  color: AppColors.success,
                ),
                child: Text(
                  state.selectedMode.label.toUpperCase(),
                  style: GoogleFonts.spaceGrotesk(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                '${state.cleanedText!.split(' ').length} WORDS',
                style: GoogleFonts.spaceGrotesk(
                  color: AppColors.textSecondary,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => ref
                    .read(cleanupControllerProvider(rawTranscript).notifier)
                    .reset(),
                child: Text(
                  'RESET ENGINE',
                  style: GoogleFonts.spaceGrotesk(
                    color: AppColors.primary,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Cleaned text
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: SelectableText(
              state.cleanedText!,
              style: GoogleFonts.inter(
                color: AppColors.textPrimary,
                fontSize: 16,
                height: 1.8,
              ),
            ),
          ),
        ),

        // Actions
        Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: AppColors.surface,
            border: Border(
              top: BorderSide(color: AppColors.surface2, width: 1),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: _OutlineButton(
                  label: 'Copy Result',
                  icon: Icons.content_copy,
                  onTap: () =>
                      _copyToClipboard(context, state.cleanedText!),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _OutlineButton(
                  label: 'Share Module',
                  icon: Icons.share,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'SHARE MODULE INITIALIZING...',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
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
