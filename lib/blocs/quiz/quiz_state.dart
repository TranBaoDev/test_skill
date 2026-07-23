import 'package:equatable/equatable.dart';
import '../../data/models/quiz_question.dart';

class QuizState extends Equatable {
  final List<QuizQuestion> questions;
  final Map<int, int> answers; // questionId -> selectedIndex
  final int currentIndex;
  final bool isLoading;

  const QuizState({
    this.questions = const [],
    this.answers = const {},
    this.currentIndex = 0,
    this.isLoading = false,
  });

  QuizState copyWith({
    List<QuizQuestion>? questions,
    Map<int, int>? answers,
    int? currentIndex,
    bool? isLoading,
  }) {
    return QuizState(
      questions: questions ?? this.questions,
      answers: answers ?? this.answers,
      currentIndex: currentIndex ?? this.currentIndex,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  int get answeredCount => answers.length;

  @override
  List<Object?> get props =>
      [questions.length, answers, currentIndex, isLoading];
}
