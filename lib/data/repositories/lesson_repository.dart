import 'package:isar/isar.dart';
import '../models/lesson.dart';
import '../models/watch_progress.dart';

class LessonRepository {
  final Isar isar;
  LessonRepository(this.isar);

  Future<List<Lesson>> getLessonsPage(int courseId,
      {required int offset, required int limit}) {
    return isar.lessons
        .filter()
        .courseIdEqualTo(courseId)
        .offset(offset)
        .limit(limit)
        .findAll();
  }

  Future<List<Lesson>> searchLessons(String query, {int limit = 50}) {
    return isar.lessons
        .filter()
        .titleContains(query, caseSensitive: false)
        .limit(limit)
        .findAll();
  }
}
