import 'package:flutter_gemma/flutter_gemma.dart';
import 'package:scriva/core/constants/model_constants.dart';
import 'package:scriva/core/utils/file_utils.dart';
import 'package:scriva/features/cleanup/domain/cleanup_mode.dart';

class LocalLLMRepository {
  bool _isInstalled = false;

  Future<void> _ensureModelInstalled() async {
    if(_isInstalled) return;

    final isInstalled = await FlutterGemma.isModelInstalled(ModelConstants.gemma3_1bModelId);

   if(!isInstalled){
    final modelPath = await FileUtils.getModelPath(ModelConstants.gemma3_1bName);

    await FlutterGemma.installModel(modelType: ModelType.gemmaIt, fileType: ModelFileType.task).fromFile(modelPath).install();
   }

    _isInstalled = true;
  }

  Future<String> cleanUp({
    required String rawTranscript,
    required CleanupMode mode,
  }) async {
    await _ensureModelInstalled();
    final inferenceModel = await FlutterGemma.getActiveModel(
      maxTokens: 1024,
      preferredBackend: PreferredBackend.gpu, 
    );

    final chat = await inferenceModel.createChat(
      temperature: 0.2,
      topK: 40
    );
    final prompt = '''${mode.prompt}

  RAW TRANSCRIPT: 
  """
  $rawTranscript
"""

''';

  await chat.addQueryChunk(
    Message.text(text: prompt, isUser: true),
  );

  final response = await chat.generateChatResponse();
  
  if (response is! TextResponse) {
    throw Exception('Unexpected response type from model');
  }
  
  final text = response.token.trim();

  if(text.isEmpty){
    throw Exception('Empty response from model');
  }
  return text;
}

  void reset(){
    _isInstalled = false;
  }

}