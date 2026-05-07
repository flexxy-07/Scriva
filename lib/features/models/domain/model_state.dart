enum ModelStatus {
  notDownloaded,
  downloading,
  downloaded,
  error,
}

class ModelInfo {
  final String name;
  final String fileName;
  final String url;
  final int sizeMb;
  final bool isRequired;
  final ModelStatus status;
  final double downloadProgress;
  final String? errorMessage;

  const ModelInfo({
    required this.name,
    required this.fileName,
    required this.url,
    required this.sizeMb,
    this.isRequired = false,
    this.status = ModelStatus.notDownloaded,
    this.downloadProgress = 0.0,
    this.errorMessage,
  });

  ModelInfo copyWith({
    ModelStatus? status,
    double? downloadProgress,
    String? errorMessage,
  }){
    return ModelInfo(name: name, fileName: fileName, url: url, sizeMb: sizeMb,
    isRequired: isRequired,
    status: status ?? this.status,
    downloadProgress: downloadProgress ?? this.downloadProgress,
    errorMessage: errorMessage ?? this.errorMessage
    );
  }

  bool get isReady => status == ModelStatus.downloaded;
  bool get isDownloading => status == ModelStatus.downloading;
}

