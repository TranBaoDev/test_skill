import 'package:isar/isar.dart';

part 'lesson.g.dart';

@collection
class Lesson {
  Id id = Isar.autoIncrement;

  @Index()
  late int courseId;

  @Index(type: IndexType.value, caseSensitive: false)
  late String title;

  late String type; // video | audio | pdf | image | quiz
  late String contentPath;
  int? durationMs;
}
