import 'package:equatable/equatable.dart';
import '../../data/models/quiz_question.dart';

class QuizState extends Equatable {
  final List<QuizQuestion> questions;
  final Map<int, int> answers;
  final int currentIndex;
  final bool isLoading;
  final bool isSubmitted;

  const QuizState({
    this.questions = const [],
    this.answers = const {},
    this.currentIndex = 0,
    this.isLoading = false,
    this.isSubmitted = false,
  });

  QuizState copyWith({
    List<QuizQuestion>? questions,
    Map<int, int>? answers,
    int? currentIndex,
    bool? isLoading,
    bool? isSubmitted,
  }) {
    return QuizState(
      questions: questions ?? this.questions,
      answers: answers ?? this.answers,
      currentIndex: currentIndex ?? this.currentIndex,
      isLoading: isLoading ?? this.isLoading,
      isSubmitted: isSubmitted ?? this.isSubmitted,
    );
  }

  int get answeredCount => answers.length;

  int get correctCount {
    var count = 0;
    for (final q in questions) {
      if (answers[q.id] == q.correctIndex) count++;
    }
    return count;
  }

  double get scorePercent =>
      questions.isEmpty ? 0 : (correctCount / questions.length) * 100;

  @override
  List<Object?> get props =>
      [questions.length, answers, currentIndex, isLoading, isSubmitted];
}
