import 'package:scriva/features/history/domain/transcript_entry.dart';

enum HistoryStatus {
  idle, 
  loading, 
  loaded,
  empty,
  error
}

class HistoryState {
  final HistoryStatus status;
  final List<TransciptEntry> entries;
  final String searchQuery;
  final String? errorMessage;

  const HistoryState({
    this.status = HistoryStatus.idle,
    this.entries = const [],
    this.searchQuery = '',
    this.errorMessage,
  });

  HistoryState copyWith({
    HistoryStatus? status,
    List<TransciptEntry>? entries,
    String? searchQuery,
    String? errorMessage,
  }) {
    return HistoryState(
      status: status ?? this.status,
      entries: entries ?? this.entries,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  bool get isEmpty => entries.isEmpty;
}