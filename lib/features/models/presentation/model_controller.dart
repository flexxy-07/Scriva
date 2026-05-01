import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scriva/core/constants/model_constants.dart';
import 'package:scriva/features/models/data/model_repo.dart';
import 'package:scriva/features/models/domain/model_state.dart';

class ModelController extends StateNotifier<List<ModelInfo>>{
  final ModelRepo _repo;
  ModelController(this._repo) : super(_initialModels()) {
    _checkExistingModels();
  }

  static List<ModelInfo> _initialModels() => [
    ModelInfo(name: 'Whisper Tiny', fileName: ModelConstants.whisperTinyName, url: ModelConstants.whisperTinyUrl, sizeMb: ModelConstants.whisperTinySize),
  ];

  Future<void> _checkExistingModels() async {
    for (final model in state) {
      final isDownloaded = await _repo.isModelDownloaded(model.fileName);
      _updateModel(
        model.fileName,
        status: isDownloaded ? ModelStatus.downloaded : ModelStatus.notDownloaded,
        progress: isDownloaded ? 1.0 : 0.0,
      );
    }
  }

  Future<void> downloadModel(String fileName) async {
    _updateModel(fileName, status: ModelStatus.downloading, progress: 0.0);

    try {
      final model = state.firstWhere((m) => m.fileName == fileName);
      await _repo.downloadModel(
        url: model.url,
        fileName: fileName,
        onProgress: (progress) {
          _updateModel(fileName,
              status: ModelStatus.downloading, progress: progress);
        },
      );
      _updateModel(fileName, status: ModelStatus.downloaded, progress: 1.0);
    } catch (e) {
      _updateModel(
        fileName,
        status: ModelStatus.error,
        progress: 0.0,
        error: 'Download failed. Check connection and retry.',
      );
    }
  }

  Future<void> deleteModel(String fileName) async {
    await _repo.deleteModel(fileName);
    _updateModel(fileName, status : ModelStatus.notDownloaded, progress : 0.0);
  }

  void _updateModel(
    String fileName, {
      required ModelStatus status,
      double progress = 0.0,
      String? error,
    }
  ) {
    state = state.map((m){
      if (m.fileName != fileName) return m;
      return m.copyWith(
        status: status,
        downloadProgress: progress,
        errorMessage: error,
      );
    }).toList();
  }
  bool get isRequiredModelReady => state.any((m) => m.fileName == ModelConstants.whisperTinyName && m.isReady);
}   

// provs
final modelRepositoryProvider = Provider((ref) => ModelRepo());

final modelControllerProvider = StateNotifierProvider<ModelController, List<ModelInfo>>(
  (ref) => ModelController(
    ref.watch(modelRepositoryProvider)
  )
);

final isAppReadyProvider = Provider<bool>((ref){
  final models = ref.watch(modelControllerProvider);
  return models.any((m) => m.fileName == ModelConstants.whisperTinyName && m.isReady);
});