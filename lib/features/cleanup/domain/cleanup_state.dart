import 'package:scriva/features/cleanup/domain/cleanup_mode.dart';

enum CleanupStatus {
  idle,
  loading,
  done,
  error
}

class CleanupState {
  final CleanupStatus status;
  final CleanupMode selectedMode;
  final String? cleanedText;
  final String? errorMessage;

  const CleanupState({
    this.status = CleanupStatus.idle,
    this.selectedMode = CleanupMode.clean,
    this.cleanedText,
    this.errorMessage
  });

  CleanupState copyWith ({
    CleanupStatus? status,
    CleanupMode? selectedMode,
    String? cleanedText,
    String? errorMessage,
  }) {
    return CleanupState(
      status: status ?? this.status,
      selectedMode: selectedMode ?? this.selectedMode,
      cleanedText: cleanedText ?? this.cleanedText,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  bool get isLoading => status == CleanupStatus.loading;
  bool get isDone => status == CleanupStatus.done;
  bool get hasError => status == CleanupStatus.error;
}