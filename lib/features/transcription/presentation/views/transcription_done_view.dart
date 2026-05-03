part of '../transcription_screen.dart';

class _DoneView extends ConsumerWidget {
  final String audioPath;
  final TranscriptionState state;

  const _DoneView({required this.audioPath, required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
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
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.lock_outline_rounded,
                color: AppColors.textSecondary,
                size: 14,
              ),
              const SizedBox(width: 4),
              const Text(
                'on-device',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
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
                color: AppColors.surface2.withOpacity(0.5),
                width: 1,
              ),
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: AppButton(
                  label: 'Clean with AI',
                  icon: Icons.auto_fix_high_rounded,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            CleanupScreen(rawTranscript: state.rawTranscript!),
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
                      onTap: () =>
                          _copyToClipboard(context, state.rawTranscript!),
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
  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Copied to clipboard'),
        duration: Duration(seconds: 2),
      ),
    );
  }}
