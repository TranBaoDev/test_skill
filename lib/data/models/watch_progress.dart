import 'package:isar/isar.dart';

part 'watch_progress.g.dart';

@collection
class WatchProgress {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late int lessonId;

  late int positionMs;
  late DateTime updatedAt;
}
