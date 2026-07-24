import 'package:isar/isar.dart';
import '../models/bookmark.dart';

class BookmarkRepository {
  final Isar isar;
  BookmarkRepository(this.isar);

  Future<bool> isBookmarked(int lessonId) async {
    final existing =
        await isar.bookmarks.filter().lessonIdEqualTo(lessonId).findFirst();
    return existing != null;
  }

  Future<void> toggleBookmark(int lessonId) async {
    await isar.writeTxn(() async {
      final existing =
          await isar.bookmarks.filter().lessonIdEqualTo(lessonId).findFirst();
      if (existing != null) {
        await isar.bookmarks.delete(existing.id);
      } else {
        final bookmark = Bookmark()
          ..lessonId = lessonId
          ..createdAt = DateTime.now();
        await isar.bookmarks.put(bookmark);
      }
    });
  }

  Future<List<int>> getBookmarkedLessonIds() async {
    final all = await isar.bookmarks.where().findAll();
    return all.map((b) => b.lessonId).toList();
  }
}
