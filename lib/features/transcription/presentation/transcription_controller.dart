import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scriva/features/transcription/data/transcription_repository.dart';
import 'package:scriva/features/transcription/domain/transcription.dart';

class TranscriptionController extends StateNotifier<TranscriptionState> {
  final TranscriptionRepository _repo;

  TranscriptionController(this._repo, String audioPath)
    : super(TranscriptionState(audioPath: audioPath)) {
    transcribe();
  }

  Future<void> transcribe() async {
    state = state.copyWith(status: TranscriptionStatus.transcribing);
    try {
      final transcript = await _repo.transcribe(state.audioPath);
      state = state.copyWith(
        status: TranscriptionStatus.done,
        rawTranscript: transcript,
      );
    } catch (e) {
      state = state.copyWith(
        status: TranscriptionStatus.error,
        errorMessage: e.toString().replaceAll('Exception', ''),
      );
    }
  }

  void retry() => transcribe();
}

final transcriptionRepositoryProvider = Provider((ref) => TranscriptionRepository());

final transcriptionControllerProvider = StateNotifierProvider.family<TranscriptionController, TranscriptionState, String>((
  ref, audioPath
) => TranscriptionController(ref.watch(transcriptionRepositoryProvider), audioPath));