import 'package:equatable/equatable.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();
  @override
  List<Object?> get props => [];
}

class QuizStarted extends QuizEvent {
  final int quizId;
  const QuizStarted(this.quizId);
  @override
  List<Object?> get props => [quizId];
}

class QuizPageChanged extends QuizEvent {
  final int index;
  const QuizPageChanged(this.index);
  @override
  List<Object?> get props => [index];
}

class QuizAnswerSelected extends QuizEvent {
  final int questionId;
  final int selectedIndex;
  const QuizAnswerSelected(this.questionId, this.selectedIndex);
  @override
  List<Object?> get props => [questionId, selectedIndex];
}
