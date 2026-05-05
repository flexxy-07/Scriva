class TranscribeRequest {
  final String audiPath;
  final String modelPath;

  const TranscribeRequest({
    required this.audiPath,
    required this.modelPath
  });

}

class TranscribeResult {
  final String? transcript;
  final String? error;

  const TranscribeResult({this.transcript, this.error});

  bool get isSuccess => transcript != null;
  bool get isError => error != null;
}