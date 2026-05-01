import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:scriva/core/constants/app_constants.dart';

class FileUtils {
  FileUtils._();


  static Future<String> getModelsDir() async {
    final appDir = await getApplicationDocumentsDirectory();

    final modelsDir = Directory(
      p.join(appDir.path, AppConstants.modelsFolder)
    ) ;

    if(!await modelsDir.exists()) await modelsDir.create(recursive: true);
    return modelsDir.path;
  }

  static Future<String> getRecordingsDir() async {
    final appDir = await getApplicationDocumentsDirectory();
    final recDir = Directory(
      p.join(appDir.path, AppConstants.recordingsFolder)
    );

    if(!await recDir.exists()) await recDir.create(recursive: true);

    return recDir.path;
  }

  static Future<String> getModelPath(String modelName) async {
    final dir = await getModelsDir();
    return p.join(dir, modelName);
  }

  static Future<bool> modelExists(String modelName) async {
    final path = await getModelPath(modelName);
    return File(path).exists();
  }

  static String formatBytes(int bytes){
    if(bytes < 1024) return '$bytes B';
    if(bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';

    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}