import 'package:isar/isar.dart';

part 'bookmark.g.dart';

@collection
class Bookmark {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late int lessonId;

  late DateTime createdAt;
}
