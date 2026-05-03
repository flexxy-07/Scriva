import 'package:isar/isar.dart';
part 'transcript_entry.g.dart';
@collection
class TransciptEntry {
  Id id = Isar.autoIncrement;
  late String audioPath;
  late String rawTranscript;
  String? cleanedTranscript;
  String? cleanupMode;

  @Index()
  late DateTime createdAt;

  late int durationSeconds;

  int get rawWordCount => rawTranscript.trim().split(' ').length;

  int get cleanedWordCount => cleanedTranscript?.trim().split(' ').length ?? 0;

  String get title {
    final words = rawTranscript.trim().split(' ');
    final preview = words.take(6).join(' ');
    return words.length > 6 ? '$preview...' : preview;
  }

  String get formattedDuration {
    final d = Duration(seconds: durationSeconds);
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');

    return '$m:$s';
  }
}