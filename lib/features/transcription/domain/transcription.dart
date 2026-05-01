enum TranscriptionStatus { idle, transcribing, done, error }

class TranscriptionState {
  final TranscriptionStatus status;
  final String? rawTranscript;
  final String? errorMessage;
  final String audioPath;

  const TranscriptionState({
    required this.audioPath,
    this.status = TranscriptionStatus.idle,
    this.rawTranscript,
    this.errorMessage,
  });

  TranscriptionState copyWith({
    TranscriptionStatus? status,
    String? rawTranscript,
    String? errorMessage,
  }) {
    return TranscriptionState(
      audioPath: audioPath,
      status: status ?? this.status,
      rawTranscript: rawTranscript ?? this.rawTranscript,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  bool get isTranscribing => status == TranscriptionStatus.transcribing;
  bool get isDone => status == TranscriptionStatus.done;
  bool get hasError => status == TranscriptionStatus.error;
}