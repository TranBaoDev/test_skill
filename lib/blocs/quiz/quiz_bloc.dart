import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import '../../data/repositories/quiz_repository.dart';
import 'quiz_event.dart';
import 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final QuizRepository repository;

  QuizBloc(this.repository) : super(const QuizState(isLoading: true)) {
    on<QuizStarted>(_onStarted);
    on<QuizPageChanged>((event, emit) {
      if (isClosed) return;
      emit(state.copyWith(currentIndex: event.index));
    });
    on<QuizAnswerSelected>(_onAnswerSelected, transformer: sequential());
  }

  Future<void> _onStarted(QuizStarted event, Emitter<QuizState> emit) async {
    emit(state.copyWith(isLoading: true));
    final questions = await repository.getQuestionsByBank(event.bankId);
    if (isClosed) return; // guard

    final savedAnswers = await repository.getSavedAnswers(
      questions.map((q) => q.id).toList(),
    );
    if (isClosed) return; // guard

    emit(state.copyWith(
      questions: questions,
      answers: savedAnswers,
      isLoading: false,
    ));
  }

  Future<void> _onAnswerSelected(
    QuizAnswerSelected event,
    Emitter<QuizState> emit,
  ) async {
    if (isClosed) return;
    emit(state.copyWith(
      answers: {...state.answers, event.questionId: event.selectedIndex},
    ));
    unawaited(repository.saveAnswer(event.questionId, event.selectedIndex));
  }
}
