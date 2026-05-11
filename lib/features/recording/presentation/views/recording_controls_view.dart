part of '../recording_screen.dart';

class _ControlsView extends ConsumerWidget {
  final RecordingState state;

  const _ControlsView({required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(recordingControllerProvider.notifier);

    if (state.isIdle) {
      return _TechnicalRecordButton(
        onTap: () => controller.startRecording(),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Cancel
        _SquareActionButton(
          icon: Icons.close_outlined,
          label: 'Cancel',
          onTap: () => controller.cancelRecording(),
        ),
        const SizedBox(width: 32),

        // Pause / Resume
        _SquareActionButton(
          icon: state.isRecording
              ? Icons.pause_outlined
              : Icons.mic_none_outlined,
          backgroundColor: AppColors.primary,
          iconColor: Colors.white,
          size: 72,
          label: state.isRecording ? 'Pause' : 'Resume',
          onTap: () => state.isRecording
              ? controller.pauseRecording()
              : controller.resumeRecording(),
        ),
        const SizedBox(width: 32),

        // Stop & transcribe
        _SquareActionButton(
          icon: Icons.check_outlined,
          label: 'Finish',
          onTap: () async {
            final duration = ref
                .read(recordingControllerProvider)
                .duration
                .inSeconds;
            final path = await controller.stopRecording();
            if (path != null && context.mounted) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => TranscriptionScreen(
                    audioPath: path,
                    recordingDurationSeconds: duration,
                  ),
                ),
              );
            }
            controller.reset();
          },
        ),
      ],
    );
  }
}
