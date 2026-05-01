enum RecordingStatus { idle, recording, paused , stopped }

class RecordingState {
  final RecordingStatus status;
  final Duration duration;
  final String? filePath;
  final String? errorMessage;

  const RecordingState({
    this.status = RecordingStatus.idle,
    this.duration = Duration.zero,
    this.filePath,
    this.errorMessage
  });

  RecordingState copyWith({
    RecordingStatus? status,
    Duration? duration,
    String? filePath,
    String? errorMessage,
  }) {
    return RecordingState(
      status: status ?? this.status,
      duration: duration ?? this.duration,
      filePath: filePath ?? this.filePath,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  bool get isRecording => status == RecordingStatus.recording;
  bool get isPaused => status == RecordingStatus.paused;
  bool get isIdle => status == RecordingStatus.idle;
  bool get isStopped => status == RecordingStatus.stopped;
}
