part of '../recording_screen.dart';

class _TimerView extends StatelessWidget {
  final RecordingState state;

  const _TimerView({required this.state});

  @override
  Widget build(BuildContext context) {
    final d = state.duration;
    final hours = d.inHours;
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');

    final timeString =
        hours > 0 ? '$hours:$minutes:$seconds' : '$minutes:$seconds';

    return Center(
      child: Text(
        timeString,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 52,
          fontWeight: FontWeight.w200,
          letterSpacing: -1,
          fontFeatures: [FontFeature.tabularFigures()],
        ),
      ),
    );
  }
}
