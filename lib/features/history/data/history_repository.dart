import 'package:isar/isar.dart';
import 'package:scriva/core/services/db_service.dart';
import 'package:scriva/features/history/domain/transcript_entry.dart';

class HistoryRepository {
  Future<int> saveTranscript(TransciptEntry entry) async {
    final db = await DatabaseService.instance;
    return await db.writeTxn(() async {
      return await db.transciptEntrys.put(entry);
    });

  }

  Future<TransciptEntry?> getTranscript(int id) async {
    final db = await DatabaseService.instance;
    return await db.transciptEntrys.get(id);
  }

  Future<List<TransciptEntry>> getAllTranscipts() async {
    final db = await DatabaseService.instance;
    return await db.transciptEntrys.where().sortByCreatedAt().findAll();
  }

  Future<List<TransciptEntry>> searchTranscripts(String query) async {
    final db = await DatabaseService.instance;
    final all = await db.transciptEntrys.where().sortByCreatedAt().findAll();

    final q = query.toLowerCase();
    return all.where((e) => e.rawTranscript.toLowerCase().contains(q) || (e.cleanedTranscript?.toLowerCase().contains(q) ?? false)).toList();
  }

  Future<void> updateCleanedTranscript(
    int id, String cleaned, String mode
  ) async {
    final db = await DatabaseService.instance;
    final entry = await db.transciptEntrys.get(id);
    if(entry == null) return;
    entry.cleanedTranscript = cleaned;
    entry.cleanupMode = mode;
    await db.writeTxn(() async {
      await db.transciptEntrys.put(entry);
    });
  }

  Future<void> deleteTranscript(int id) async {
    final db = await DatabaseService.instance;
    await db.writeTxn(() async {
      await db.transciptEntrys.delete(id);
    });
  }

  Future<int> getTotalCount() async {
    final db = await DatabaseService.instance;
    return await db.transciptEntrys.count();
  }

}