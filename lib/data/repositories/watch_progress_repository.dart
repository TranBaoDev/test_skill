import 'package:isar/isar.dart';
import '../models/watch_progress.dart';

class WatchProgressRepository {
  final Isar isar;
  WatchProgressRepository(this.isar);

  Future<WatchProgress?> getProgress(int lessonId) {
    return isar.watchProgress.filter().lessonIdEqualTo(lessonId).findFirst();
  }

  Future<void> saveProgress(int lessonId, int positionMs) {
    return isar.writeTxn(() async {
      final existing = await isar.watchProgress
          .filter()
          .lessonIdEqualTo(lessonId)
          .findFirst();

      final progress = existing ?? WatchProgress();
      progress
        ..lessonId = lessonId
        ..positionMs = positionMs
        ..updatedAt = DateTime.now();

      await isar.watchProgress.put(progress);
    });
  }

  Future<List<WatchProgress>> getRecentHistory({int limit = 30}) {
    return isar.watchProgress
        .where()
        .sortByUpdatedAtDesc()
        .limit(limit)
        .findAll();
  }
}
