import 'package:isar/isar.dart';

part 'quiz_question.g.dart';

@collection
class QuizQuestion {
  Id id = Isar.autoIncrement;

  @Index()
  late int bankId; // 1-5, đại diện cho ngân hàng câu hỏi

  late String question;
  String? imagePath;
  String? audioPath;
  late List<String> options;
  late int correctIndex; // index đáp án đúng trong options
}
