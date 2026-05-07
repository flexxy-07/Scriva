class ModelConstants {
  ModelConstants._();
   
  static const String whisperTinyUrl =
      'https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-tiny.bin';
  static const String whisperBaseUrl =
      'https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-base.bin';

  static const String whisperTinyName = 'ggml-tiny.bin';
  static const String whisperBaseName = 'ggml-base.bin';

  // MBs
  static const int whisperTinySize = 75;
  static const int whisperBaseSize = 150;

  // offline model : Gemma
  static const String gemma3_1bUrl = 'https://github.com/flexxy-07/scriva-models/releases/download/v1-models/gemma3-1b-it-int4.task';

  static const String gemma3_1bName = 'gemma3-1b-it-int4.task';

  static const String gemma3_1bModelId = 'gemma3-1b-it-int4';
  static const int gemma3_1bSize = 530;
}
