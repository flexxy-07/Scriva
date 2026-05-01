import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scriva/features/recording/data/recording_repo.dart';
import 'package:scriva/features/recording/domain/recording_state.dart';

class RecordingController extends StateNotifier<RecordingState>{
  final RecordingRepo _repo;
  Timer? _timer;

  RecordingController(this._repo) : super(const RecordingState());

  Future<void> startRecording() async {
    final hasPermission = await _repo.hasPermission();
    if(!hasPermission){
      final granted = await _repo.requestPermission();
      if(!granted){
        state = state.copyWith(
          errorMessage: 'Microphone permission is required'
        );
        return;
      }
    }
    try {
      final filePath = await _repo.startRecording();
      state = RecordingState(
        status: RecordingStatus.recording,
        filePath: filePath,
      );
      _startTimer();

    }catch(e){
      state = state.copyWith(errorMessage: 'Failed to start recording');
    }
  }

  Future<void> pauseRecording() async {
    _timer?.cancel();
    await _repo.pauseRecording();
    state = state.copyWith(status: RecordingStatus.paused);
  }

  Future<void> resumeRecording() async {
    await _repo.resumeRecording();
    _startTimer();
    state = state.copyWith(status: RecordingStatus.recording);
  }

  Future<String?> stopRecording() async {
    _timer!.cancel();
    final path = await _repo.stopRecording();
    state = state.copyWith(
      status: RecordingStatus.stopped,
      filePath: path
    );
    return path;
  }

  Future<void> cancelRecording() async {
    _timer?.cancel();
    await _repo.cancelRecording();
    state = const RecordingState();
  }
  void _startTimer() async {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_){
      state = state.copyWith(
        duration: state.duration + const Duration(seconds: 1)
      );
    });
  }

  void reset() async {
    _timer?.cancel();
    state = const RecordingState();

  }

  @override
  void dispose() {
    _timer?.cancel();
    _repo.dispose();
    super.dispose();
  }

}

final recordingRepositoryProvider = Provider((ref) => RecordingRepo());

final recordingControllerProvider = StateNotifierProvider<RecordingController, RecordingState>(
  (ref) => RecordingController(ref.watch(recordingRepositoryProvider))
);

