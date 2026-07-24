import 'package:isar/isar.dart';
import '../models/quiz_question.dart';
import '../models/quiz_answer.dart';

class QuizRepository {
  final Isar isar;
  QuizRepository(this.isar);

  Future<List<QuizQuestion>> getQuestionsByBank(int bankId) {
    return isar.quizQuestions
        .filter()
        .bankIdEqualTo(bankId)
        .sortByBankId()
        .findAll();
  }

  Future<Map<int, int>> getSavedAnswers(List<int> questionIds) async {
    final answers = await isar.quizAnswers
        .filter()
        .anyOf(questionIds, (q, id) => q.questionIdEqualTo(id))
        .findAll();
    return {for (final a in answers) a.questionId: a.selectedIndex};
  }

  Future<void> saveAnswer(int questionId, int selectedIndex) {
    return isar.writeTxn(() async {
      final existing = await isar.quizAnswers
          .filter()
          .questionIdEqualTo(questionId)
          .findFirst();

      final answer = existing ?? QuizAnswer();
      answer
        ..questionId = questionId
        ..selectedIndex = selectedIndex
        ..answeredAt = DateTime.now();

      await isar.quizAnswers.put(answer);
    });
  }
}
