part of '../recording_screen.dart';

class _ControlsView extends ConsumerWidget {
  final RecordingState state;

  const _ControlsView({required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(recordingControllerProvider.notifier);

    if (state.isIdle) {
      return _RecordButton(
        onTap: () => controller.startRecording(),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Cancel
        _CircleButton(
          icon: Icons.close_rounded,
          color: AppColors.surface2,
          size: 56,
          onTap: () => controller.cancelRecording(),
        ),
        const SizedBox(width: 24),

        // Pause / Resume
        _CircleButton(
          icon: state.isRecording
              ? Icons.pause_rounded
              : Icons.mic_rounded,
          color: AppColors.primary.withOpacity(0.15),
          iconColor: AppColors.primary,
          size: 72,
          onTap: () => state.isRecording
              ? controller.pauseRecording()
              : controller.resumeRecording(),
        ),
        const SizedBox(width: 24),

        // Stop → transcribe
        _CircleButton(
          icon: Icons.stop_rounded,
          color: AppColors.success.withOpacity(0.15),
          iconColor: AppColors.success,
          size: 56,
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
