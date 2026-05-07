import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scriva/core/constants/model_constants.dart';
import 'package:scriva/core/services/settings_service.dart';
import 'package:scriva/core/utils/file_utils.dart';
import 'package:scriva/features/cleanup/data/cleanup_repository.dart';
import 'package:scriva/features/cleanup/data/local_llm_repository.dart';
import 'package:scriva/features/cleanup/domain/cleanup_mode.dart';
import 'package:scriva/features/cleanup/domain/cleanup_state.dart';

class CleanupController extends StateNotifier<CleanupState> {
  final CleanupRepository _geminiRepo;
  final LocalLLMRepository _localRepo;
  final CleanupEngine _engine;
  final String _rawTranscript;

  CleanupController(this._geminiRepo, this._localRepo, this._engine, this._rawTranscript)
    : super(const CleanupState());

  void selectMode(CleanupMode mode) {
    state = state.copyWith(
      selectedMode: mode,
      // will reset the result when mode changes
      status: CleanupStatus.idle,
      cleanedText: null,
    );
  }

  Future<void> runCleanup() async {
    if (_engine == CleanupEngine.local) {
      final exists = await FileUtils.modelExists(
          ModelConstants.gemma3_1bName);
      if (!exists) {
        state = state.copyWith(
          status: CleanupStatus.error,
          errorMessage:
              'Gemma model not downloaded. Go to Settings → Manage Models.',
        );
        return;
      }
    }
    state = state.copyWith(
      status: CleanupStatus.loading,
      cleanedText: null,
      errorMessage: null,
    );

    try {
      final result = _engine == CleanupEngine.local
          ? await _localRepo.cleanUp(
              rawTranscript: _rawTranscript,
              mode: state.selectedMode,
            )
          : await _geminiRepo.cleanUp(
              rawTranscript: _rawTranscript,
              mode: state.selectedMode,
            );

      state = state.copyWith(
        status: CleanupStatus.done,
        cleanedText: result,
      );
    }catch (e) {
      state = state.copyWith(
        status: CleanupStatus.error,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
    }

  }

  void retry() => runCleanup();
  void reset() => state = const CleanupState();
}

final cleanupRepositoryProvider = Provider((ref) => CleanupRepository());
final localLLMRepositoryProvider = Provider((ref) => LocalLLMRepository());


final cleanupControllerProvider =
    StateNotifierProvider.family<CleanupController, CleanupState, String>(
      (ref, rawTranscript) => CleanupController(
        ref.watch(cleanupRepositoryProvider),
        ref.watch(localLLMRepositoryProvider),
        ref.watch(settingsServiceProvider),
        rawTranscript,
      ),
    );
