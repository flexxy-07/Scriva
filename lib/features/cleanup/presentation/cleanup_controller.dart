import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scriva/features/cleanup/data/cleanup_repository.dart';
import 'package:scriva/features/cleanup/domain/cleanup_mode.dart';
import 'package:scriva/features/cleanup/domain/cleanup_state.dart';

class CleanupController extends StateNotifier<CleanupState> {
  final CleanupRepository _repo;
  final String _rawTranscript;

  CleanupController(this._repo, this._rawTranscript)
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
    state = state.copyWith(
      status: CleanupStatus.loading,
      cleanedText: null,
      errorMessage: null,
    );

    try {
      final result = await _repo.cleanUp(
        rawTranscript: _rawTranscript,
        mode: state.selectedMode,
      );
      state = state.copyWith(status: CleanupStatus.done, cleanedText: result);
    } catch (e) {
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

final cleanupControllerProvider =
    StateNotifierProvider.family<CleanupController, CleanupState, String>(
      (ref, rawTranscript) => CleanupController(
        ref.watch(cleanupRepositoryProvider),
        rawTranscript,
      ),
    );
