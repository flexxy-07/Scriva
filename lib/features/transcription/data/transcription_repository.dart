import 'package:whisper_flutter_new/whisper_flutter_new.dart';

class TranscriptionRepository {
  Future<String> transcribe(String audioPath) async {
    final whisper = Whisper(model: WhisperModel.tiny,
    downloadHost: 'https://huggingface.co/ggerganov/whisper.cpp/resolve/main',
    );

    final result = await whisper.transcribe(transcribeRequest: TranscribeRequest(audio: audioPath,
      isTranslate: false,
      isNoTimestamps: true,
      splitOnWord: true,
    ));

    final text = result.text.trim();
    if(text.isEmpty){
      throw Exception(
        'No speech detected in audio.'
      );
    }
    return text;
  }
}