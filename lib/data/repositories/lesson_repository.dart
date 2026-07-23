import 'package:isar/isar.dart';
import '../models/lesson.dart';

class LessonRepository {
  final Isar isar;
  LessonRepository(this.isar);

  Future<List<Lesson>> getLessonsPage(
    int courseId, {
    required int offset,
    required int limit,
    String? type,
  }) {
    if (type != null) {
      return isar.lessons
          .filter()
          .courseIdEqualTo(courseId)
          .typeEqualTo(type)
          .sortByCourseId() // đảm bảo thứ tự ổn định, không đổi giữa các lần load trang
          .offset(offset)
          .limit(limit)
          .findAll();
    }
    return isar.lessons
        .filter()
        .courseIdEqualTo(courseId)
        .sortByCourseId()
        .offset(offset)
        .limit(limit)
        .findAll();
  }

  Future<List<Lesson>> searchLessons(String query, {int limit = 50}) {
    return isar.lessons
        .filter()
        .titleContains(query, caseSensitive: false)
        .sortByCourseId()
        .limit(limit)
        .findAll();
  }
}
