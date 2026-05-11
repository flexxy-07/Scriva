part of '../recording_screen.dart';

class _VisualizerView extends StatelessWidget {
  final RecordingState state;

  const _VisualizerView({required this.state});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: state.isRecording
          ? const _TechnicalWaveform()
          : _TechnicalMicIndicator(isPaused: state.isPaused),
    );
  }
}
