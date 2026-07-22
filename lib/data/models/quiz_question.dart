import 'package:isar/isar.dart';

part 'quiz_question.g.dart';

@collection
class QuizQuestion {
  Id id = Isar.autoIncrement;

  @Index()
  late int quizId;

  late String question;
  String? imagePath;
  String? audioPath;
  late List<String> options;
}
