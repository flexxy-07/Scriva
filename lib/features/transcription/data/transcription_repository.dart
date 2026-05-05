import 'dart:async';
import 'dart:isolate';

import 'package:flutter/services.dart';
import 'package:scriva/core/constants/model_constants.dart';
import 'package:scriva/core/utils/file_utils.dart';
import 'package:scriva/core/utils/transcription_isolate.dart';
import 'package:scriva/core/utils/isolate_messages.dart' as isolate_message;

class TranscriptionRepository {
  Future<String> transcribe(String audioPath) async {
    final modelPath = await FileUtils.getModelPath(ModelConstants.whisperTinyName);

    // Get the root isolate token to pass to the background isolate
    final rootToken = RootIsolateToken.instance;

    // creating a receive port to get results back
    final resultPort = ReceivePort();
    SendPort? isolateSendPort;

    // spawning isolate
    final isolate = await Isolate.spawn<(SendPort, RootIsolateToken?)>(
      transcriptionIsolateEntry
      , (resultPort.sendPort, rootToken), errorsAreFatal: true);

    final completer = Completer<String>();

    resultPort.listen((msg){
      if(msg is SendPort){
        // isolate is ready, send the request
        isolateSendPort = msg;
        isolateSendPort!.send(isolate_message.TranscribeRequest(audiPath: audioPath, modelPath: modelPath) );
      }else if(msg is isolate_message.TranscribeResult){
        if (msg.isSuccess){
          completer.complete(msg.transcript!);
        }else{
          completer.completeError(
            Exception(msg.error ?? 'Transcription failed')
          );
        }
        resultPort.close();
        isolate.kill();
      }
    });
    return completer.future;
  }
}