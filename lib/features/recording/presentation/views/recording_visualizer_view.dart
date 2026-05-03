part of '../recording_screen.dart';

class _VisualizerView extends StatelessWidget {
  final RecordingState state;

  const _VisualizerView({required this.state});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: state.isRecording
          ? const _PulsingWaveform()
          : _IdleCircle(isPaused: state.isPaused),
    );
  }
}
