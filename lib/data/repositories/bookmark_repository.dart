import 'package:isar/isar.dart';
import '../models/bookmark.dart';
import '../models/lesson.dart';

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
    final all = await isar.bookmarks.where().sortByCreatedAtDesc().findAll();
    return all.map((b) => b.lessonId).toList();
  }

  /// Lấy đầy đủ thông tin Lesson đã bookmark (JOIN thủ công vì Isar không JOIN như SQL)
  Future<List<Lesson>> getBookmarkedLessons() async {
    final lessonIds = await getBookmarkedLessonIds();
    if (lessonIds.isEmpty) return [];

    final lessons = await isar.lessons
        .filter()
        .anyOf(lessonIds, (q, id) => q.idEqualTo(id))
        .findAll();

    // Giữ đúng thứ tự bookmark gần nhất trước (vì "anyOf" không đảm bảo thứ tự)
    final lessonMap = {for (final l in lessons) l.id: l};
    return lessonIds.map((id) => lessonMap[id]).whereType<Lesson>().toList();
  }
}
