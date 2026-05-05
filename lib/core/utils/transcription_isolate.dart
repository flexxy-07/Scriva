import 'dart:isolate';

import 'package:flutter/services.dart';
import 'package:scriva/core/utils/isolate_messages.dart' as isolate_msg;
import 'package:whisper_flutter_new/whisper_flutter_new.dart';
import 'package:whisper_flutter_new/bean/request_bean.dart' as whisper_req;

// entry point for isolate
void transcriptionIsolateEntry((SendPort, RootIsolateToken?) args) {
  final sendPort = args.$1;
  final rootToken = args.$2;

  _transcribe(sendPort, rootToken);
}

Future<void> _transcribe(SendPort sendPort, RootIsolateToken? rootToken) async {
  // Initialize binary messenger for the isolate to use platform channels
  if (rootToken != null) {
    try {
      BackgroundIsolateBinaryMessenger.ensureInitialized(rootToken);
    } catch (e) {
      print('Failed to initialize BackgroundIsolateBinaryMessenger: $e');
    }
  }

  // recieve port for isolation
  final recievePort = ReceivePort();
  sendPort.send(recievePort.sendPort);

  await for (final msg in recievePort){
    if(msg is isolate_msg.TranscribeRequest){
      try {
        final whisper = Whisper(model: WhisperModel.tiny,
        downloadHost: 'https://huggingface.co/ggerganov/whisper.cpp/resolve/main'
        );

        final result = await whisper.transcribe(transcribeRequest: whisper_req.TranscribeRequest(audio: msg.audiPath, isTranslate: false, isNoTimestamps: true, splitOnWord: true, ));

        final text = result.text.trim();
        if(text.isEmpty){
          sendPort.send(
            const isolate_msg.TranscribeResult(error: 'No speech detected')
          );
        }else{
          sendPort.send(isolate_msg.TranscribeResult(transcript: text));
        }
      }catch(e){
        sendPort.send(isolate_msg.TranscribeResult(error: e.toString()));
      }

      recievePort.close();
    }
  }
}