import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../features/history/domain/transcript_entry.dart';
class DatabaseService {
  static Isar? _isar;

  static Future<Isar> get instance async {
    if (_isar != null && _isar!.isOpen) return _isar!;
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      
      [TransciptEntrySchema], directory: dir.path, name: 'scriva_db');
      return  _isar!;
  }
}