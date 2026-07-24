import 'package:equatable/equatable.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();
  @override
  List<Object?> get props => [];
}

class QuizStarted extends QuizEvent {
  final int bankId;
  const QuizStarted(this.bankId);
  @override
  List<Object?> get props => [bankId];
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

class QuizSubmitted extends QuizEvent {
  const QuizSubmitted();
}
