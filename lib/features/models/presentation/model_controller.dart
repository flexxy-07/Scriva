import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scriva/core/constants/model_constants.dart';
import 'package:scriva/features/models/data/model_repo.dart';
import 'package:scriva/features/models/domain/model_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ModelController extends StateNotifier<List<ModelInfo>>{
  final ModelRepo _repo;
  ModelController(this._repo) : super(_initialModels()) {
    _checkExistingModels();
  }

  static List<ModelInfo> _initialModels() => [
    ModelInfo(name: 'Whisper Tiny', fileName: ModelConstants.whisperTinyName, url: ModelConstants.whisperTinyUrl, sizeMb: ModelConstants.whisperTinySize, isRequired: true),

    ModelInfo(
    name: 'Gemma 3 1B',
    fileName: ModelConstants.gemma3_1bName,
    url: ModelConstants.gemma3_1bUrl,
    sizeMb: ModelConstants.gemma3_1bSize,
    isRequired: false,
  ),
  ];

  Future<void> _checkExistingModels() async {
    final updated = <ModelInfo>[];
    bool anyReady = false;
    for (final model in state){
      final exists = await _repo.isModelDownloaded(model.fileName);
      if(exists) anyReady = true;
      updated.add(model.copyWith(
        status: exists ? ModelStatus.downloaded : ModelStatus.notDownloaded
      ));
    }
    state = updated;

    //persist
    if(anyReady){
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('whisper_model_ready', true);
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
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('whisper_model_ready', true);
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