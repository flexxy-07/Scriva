import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scriva/features/history/domain/transcript_entry.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path/path.dart' as p;

enum ExportFormat { txt, markdown }

class ExportService {
  final _share = SharePlus.instance;
  Future<void> shareText(String text, String subject) async {
    await _share.share(ShareParams(text: text, subject: subject));
  }

  Future<void> exportAndShare({
    required TransciptEntry entry,
    required ExportFormat format,
    required bool useCleaned,
  }) async {
    final content = _buildContent(entry, format, useCleaned);
    final fileName = _buildFileName(entry, format);
    final filePath = await _writeToTemp(content, fileName);

    await _share.share(
      ShareParams(files: [XFile(filePath)], subject: 'Scriva — ${entry.title}'),
    );
  }

  String _buildContent(
    TransciptEntry entry,
    ExportFormat format,
    bool useCleaned,
  ) {
    final text = useCleaned && entry.cleanedTranscript != null
        ? entry.cleanedTranscript!
        : entry.rawTranscript;

    switch (format) {
      case ExportFormat.txt:
        return ''' Scriva Transcript
        Generated : ${_formatDate(entry.createdAt)}
        Duration : ${entry.formattedDuration}
        ${useCleaned ? 'Mode: ${entry.cleanupMode ?? 'Cleaned'}' : 'Mode : Raw'}

  ---
  $text

''';
      case ExportFormat.markdown:
        return '''# Scriva Transcript

**Generated:** ${_formatDate(entry.createdAt)}
**Duration:** ${entry.formattedDuration}
**Mode:** ${useCleaned ? (entry.cleanupMode ?? 'Cleaned') : 'Raw'}

---

$text

${entry.cleanedTranscript != null && !useCleaned ? '''
---

## Cleaned Version

${entry.cleanedTranscript}
''' : ''}
''';
    }
  }

  String _buildFileName(TransciptEntry entry, ExportFormat format) {
    final date = entry.createdAt;
    final stamp = '${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}';
    final ext = format == ExportFormat.txt ? 'txt' : 'md';
    return 'scriva_$stamp.$ext';
  }

  Future<String> _writeToTemp(String content, String fileName) async {
    final dir = await getTemporaryDirectory();
    final file = File(p.join(dir.path, fileName));
    await file.writeAsString(content);
    return file.path;
  }

  String _formatDate(DateTime dt) {
    return '${dt.day}/${dt.month}/${dt.year} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}

final exportServiceProvider = Provider((ref) => ExportService());
