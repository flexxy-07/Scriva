part of '../transcription_screen.dart';

class _DoneView extends ConsumerWidget {
  final String audioPath;
  final TranscriptionState state;

  const _DoneView({required this.audioPath, required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        // Header info
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
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                ),
                child: Text(
                  'RAW',
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
                '${state.rawTranscript!.split(' ').length} WORDS',
                style: GoogleFonts.spaceGrotesk(
                  color: AppColors.textSecondary,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.lock_outline,
                color: AppColors.textSecondary,
                size: 14,
              ),
              const SizedBox(width: 6),
              Text(
                'ON-DEVICE',
                style: GoogleFonts.spaceGrotesk(
                  color: AppColors.textSecondary,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),

        // Transcript text
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: SelectableText(
              state.rawTranscript!,
              style: GoogleFonts.inter(
                color: AppColors.textPrimary,
                fontSize: 16,
                height: 1.8,
              ),
            ),
          ),
        ),

        // Bottom actions
        Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: AppColors.surface,
            border: Border(
              top: BorderSide(color: AppColors.surface2, width: 1),
            ),
          ),
          child: Column(
            children: [
              AppButton(
                label: 'Clean with AI',
                icon: Icons.auto_fix_high_outlined,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) =>
                          CleanupScreen(rawTranscript: state.rawTranscript!),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _OutlineButton(
                      label: 'Copy',
                      icon: Icons.content_copy,
                      onTap: () =>
                          _copyToClipboard(context, state.rawTranscript!),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _OutlineButton(
                      label: 'Export',
                      icon: Icons.upload,
                      onTap: () async {
                        final entries = await ref
                            .read(historyRepositoryProvider)
                            .getAllTranscipts();
                        final entry = entries.firstWhere(
                          (e) => e.audioPath == audioPath,
                          orElse: () => TransciptEntry()
                            ..audioPath = audioPath
                            ..rawTranscript = state.rawTranscript!
                            ..createdAt = DateTime.now()
                            ..durationSeconds = 0,
                        );
                        if (context.mounted) {
                          ExportSheet.show(context, entry);
                        }
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

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'COPIED TO CLIPBOARD',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: AppColors.surface2,
      ),
    );
  }
}
