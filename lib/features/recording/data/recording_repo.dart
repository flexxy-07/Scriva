import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:scriva/core/constants/app_constants.dart';
import 'package:scriva/core/utils/file_utils.dart';
import 'package:path/path.dart' as p;

class RecordingRepo {
  final _recorder = AudioRecorder();

  Future<bool> requestPermission() async {
    final status = await Permission.microphone.request();
    return status == PermissionStatus.granted;
  }
  Future<bool> hasPermission() async {
    return await Permission.microphone.isGranted;
  }

  Future<String> startRecording() async {
    final dir = await FileUtils.getRecordingsDir();
    final fileName = 'rec_${DateTime.now().millisecondsSinceEpoch}.wav';
    final filePath = p.join(dir, fileName);

    await _recorder.start(
      RecordConfig(
        encoder: AudioEncoder.wav,
        sampleRate: AppConstants.sampleRate,
        numChannels: AppConstants.audioChannels
      ), 
      path: filePath

    );
    return filePath;
  }

  Future<void> pauseRecording() async {
    await _recorder.pause();
  }

  Future<void> resumeRecording() async {
    await _recorder.resume();
  }

  Future<String?> stopRecording() async {
    return await _recorder.stop();
  }

  Future<void> cancelRecording() async {
    await _recorder.cancel();
  }

  Future<bool> isRecording() async {
    return await _recorder.isRecording();
  }

  void dispose() {
    _recorder.dispose();
  }

}