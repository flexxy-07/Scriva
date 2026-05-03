part of '../recording_screen.dart';

class _StatusTextView extends StatelessWidget {
  final RecordingState state;

  const _StatusTextView({required this.state});

  @override
  Widget build(BuildContext context) {
    final (text, color) = switch (state.status) {
      RecordingStatus.idle => ('Tap to record', AppColors.textSecondary),
      RecordingStatus.recording => ('Recording...', AppColors.primary),
      RecordingStatus.paused => ('Paused', AppColors.textSecondary),
      RecordingStatus.stopped => ('Processing...', AppColors.success),
    };

    if (state.errorMessage != null) {
      return Center(
        child: Text(state.errorMessage!,
            style: const TextStyle(color: AppColors.error, fontSize: 14)),
      );
    }

    return Center(
      child: Text(text,
          style: TextStyle(color: color, fontSize: 15)),
    );
  }
}
