import 'package:isar/isar.dart';

part 'quiz_answer.g.dart';

@collection
class QuizAnswer {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late int questionId;

  late int selectedIndex;
  late DateTime answeredAt;
}
