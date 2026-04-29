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

  // static const String tinyLlamaUrl =
  //     'https://huggingface.co/TheBloke/TinyLlama-1.1B-Chat-v1.0-GGUF/resolve/main/tinyllama-1.1b-chat-v1.0.Q4_K_M.gguf';
  // static const String tinyLlamaName = 'tinyllama-q4.gguf';
  // static const int tinyLlamaSize = 400; 
}
