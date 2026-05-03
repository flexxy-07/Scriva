import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scriva/features/history/data/history_repository.dart';
import 'package:scriva/features/history/domain/history_state.dart';
import 'package:scriva/features/history/domain/transcript_entry.dart';

class HistoryController extends StateNotifier<HistoryState> {
  final HistoryRepository _repo;
  
  HistoryController(this._repo) : super(const HistoryState()){
    loadHistory();
  }

  Future<void> loadHistory() async {
    state = state.copyWith(
      status: HistoryStatus.loading,
    );

    try {
      final entries = await _repo.getAllTranscipts();
      state = state.copyWith(
        status: entries.isEmpty ? HistoryStatus.empty : HistoryStatus.loaded,
        entries: entries
      );
    }catch(e){
      state = state.copyWith(
        status: HistoryStatus.error,
        errorMessage: e.toString()
      );
    }
  }

  Future<void> search(String query) async {
    state = state.copyWith(
      searchQuery: query
    );
    if(query.trim().isEmpty){
      await loadHistory();
      return;
    }
    try {
      final results = await _repo.searchTranscripts(query);
      state = state.copyWith(
        status: results.isEmpty ? HistoryStatus.empty : HistoryStatus.loaded,
        entries: results,
      );
    }catch(e) {
      state = state.copyWith(
        status: HistoryStatus.error,
        errorMessage: e.toString()
      );
    }
  }

  Future<void> deleteEntry(int id) async {
    await _repo.deleteTranscript(id);
    await loadHistory();
  }

  Future<int> saveTranscript(TransciptEntry entry) async {
    final id = await _repo.saveTranscript(entry);
    await loadHistory();
    return id;
  }
}

final historyRepositoryProvider = Provider((ref) => HistoryRepository());

final historyControllerProvider = StateNotifierProvider<HistoryController, HistoryState>(
  (ref) => HistoryController(ref.watch(historyRepositoryProvider))
);