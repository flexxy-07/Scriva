part of '../recording_screen.dart';

class _StatusTextView extends StatelessWidget {
  final RecordingState state;

  const _StatusTextView({required this.state});

  @override
  Widget build(BuildContext context) {
    final (text, color) = switch (state.status) {
      RecordingStatus.idle => ('READY TO RECORD', AppColors.textSecondary),
      RecordingStatus.recording => ('RECORDING ACTIVE', AppColors.primary),
      RecordingStatus.paused => ('RECORDING PAUSED', AppColors.textSecondary),
      RecordingStatus.stopped => ('PROCESSING AUDIO', AppColors.success),
    };

    if (state.errorMessage != null) {
      return Center(
        child: Text(
          state.errorMessage!.toUpperCase(),
          style: GoogleFonts.spaceGrotesk(
            color: AppColors.error,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.0,
          ),
        ),
      );
    }

    return Center(
      child: Text(
        text,
        style: GoogleFonts.spaceGrotesk(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}
