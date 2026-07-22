import 'package:isar/isar.dart';

part 'course.g.dart';

@collection
class Course {
  Id id = Isar.autoIncrement;
  late String title;
  late String thumbnailPath;
}
