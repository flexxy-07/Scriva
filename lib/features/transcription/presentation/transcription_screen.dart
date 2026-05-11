import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scriva/features/transcription/domain/transcription_state.dart';
import 'package:scriva/shared/widgets/export_sheet.dart';
import 'transcription_controller.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../shared/widgets/app_button.dart';
import '../../cleanup/presentation/cleanup_screen.dart';
import '../../history/presentation/history_controller.dart';
import '../../history/domain/transcript_entry.dart';
import 'package:scriva/shared/widgets/technical_animations.dart';
import 'package:google_fonts/google_fonts.dart';

part 'views/transcription_transcribing_view.dart';
part 'views/transcription_done_view.dart';
part 'views/transcription_error_view.dart';

class TranscriptionScreen extends ConsumerStatefulWidget {
  final String audioPath;
  final TransciptEntry? savedEntry;
  final int? recordingDurationSeconds;

  const TranscriptionScreen({
    super.key,
    required this.audioPath,
    this.savedEntry,
    this.recordingDurationSeconds,
  });

  @override
  ConsumerState<TranscriptionScreen> createState() =>
      _TranscriptionScreenState();
}

class _TranscriptionScreenState
    extends ConsumerState<TranscriptionScreen> {
  bool _saved = false;

  @override
  Widget build(BuildContext context) {
    final state =
        ref.watch(transcriptionControllerProvider(widget.audioPath));

    if (state.isDone && !_saved && widget.savedEntry == null) {
      _saved = true;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final entry = TransciptEntry()
          ..audioPath = widget.audioPath
          ..rawTranscript = state.rawTranscript!
          ..createdAt = DateTime.now()
          ..durationSeconds = widget.recordingDurationSeconds ?? 0;
        await ref
            .read(historyControllerProvider.notifier)
            .saveTranscript(entry);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TRANSCRIPT',
          style: GoogleFonts.spaceGrotesk(
            fontWeight: FontWeight.w800,
            letterSpacing: 2.0,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          if (state.isDone)
            IconButton(
              icon: const Icon(Icons.content_copy,
                  color: AppColors.textSecondary, size: 20),
              onPressed: () =>
                  _copyToClipboard(context, state.rawTranscript!),
            ),
        ],
      ),
      body: SafeArea(
        child: switch (state.status) {
          TranscriptionStatus.idle => const SizedBox.shrink(),
          TranscriptionStatus.transcribing => _TranscribingView(audioPath: widget.audioPath),
          TranscriptionStatus.done =>
            _DoneView(audioPath: widget.audioPath, state: state),
          TranscriptionStatus.error =>
            _ErrorView(audioPath: widget.audioPath, state: state),
        },
      ),
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
            letterSpacing: 1.0,
          ),
        ),
        backgroundColor: AppColors.surface2,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

class _OutlineButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _OutlineButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.surface2, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.textSecondary, size: 18),
            const SizedBox(width: 12),
            Text(
              label.toUpperCase(),
              style: GoogleFonts.spaceGrotesk(
                color: AppColors.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}