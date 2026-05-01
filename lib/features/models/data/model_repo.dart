import 'dart:io';

import 'package:dio/dio.dart';
import 'package:scriva/core/utils/file_utils.dart';

class ModelRepo {
  final _dio = Dio();

  Future<bool> isModelDownloaded(String fileName) async {
    return FileUtils.modelExists(fileName);
  }

  Future<void> downloadModel({
    required String url,
    required String fileName,
    required void Function(double progress) onProgress,
  }) async {
    final savePath = await FileUtils.getModelPath(fileName);
    final tempPath = '$savePath.tmp';

    try {
      await _dio.download(
        url,
        tempPath,
        onReceiveProgress: (recieved, total) {
          if (total > 0) {
            onProgress(recieved / total);
          }
        },
        options: Options(
          receiveTimeout: const Duration(minutes: 30),
          sendTimeout: const Duration(minutes: 1),
        ),
      );
      // Rename temp to final only after full download.
      await File(tempPath).rename(savePath);
    } catch (e) {
      // Clean up any partial downloads.
      final tmpFile = File(tempPath);
      if (await tmpFile.exists()) await tmpFile.delete();
      rethrow;
    }
  }

  Future<void> deleteModel(String fileName) async {
    final path = await FileUtils.getModelPath(fileName);
    final file = File(path);
    if (await file.exists()) await file.delete();
  }

  Future<int> getModelSizeOnDisk(String fileName) async {
    final path = await FileUtils.getModelPath(fileName);
    final file = File(path);
    if (await file.exists()) return await file.length();
    return 0;
  }
}
