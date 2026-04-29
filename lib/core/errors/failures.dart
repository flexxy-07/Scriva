abstract class Failure {
  final String message;
  const Failure(this.message);
}

class PermissionFailure extends Failure {
  const PermissionFailure() : super('Microphone permission denied');
}

class RecordingFailure extends Failure {
  const RecordingFailure(super.message);
}
class TranscriptionFailure extends Failure {
  const TranscriptionFailure(super.message);
}
class ModelNotFoundFailure extends Failure {
  const ModelNotFoundFailure() : super("AI model not downloaded yet. Please download the model to proceed.");
}
class ModelDownloadFailure extends Failure {
  const ModelDownloadFailure(super.message);
}

class StorageFailure extends Failure {
  const StorageFailure(super.message);
}