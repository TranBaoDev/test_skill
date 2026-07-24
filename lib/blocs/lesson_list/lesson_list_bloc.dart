import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import '../../data/repositories/lesson_repository.dart';
import 'lesson_list_event.dart';
import 'lesson_list_state.dart';

class LessonListBloc extends Bloc<LessonListEvent, LessonListState> {
  final LessonRepository repository;
  static const pageSize = 30;
  late int _courseId;
  String? _typeFilter;

  LessonListBloc(this.repository) : super(const LessonListState()) {
    on<LessonListStarted>(_onStarted);
    on<LessonListNextPageRequested>(_onNextPage, transformer: sequential());
  }

  Future<void> _onStarted(
    LessonListStarted event,
    Emitter<LessonListState> emit,
  ) async {
    _courseId = event.courseId;
    _typeFilter = event.type;
    emit(const LessonListState(isLoading: true));
    final firstPage = await repository.getLessonsPage(
      _courseId,
      offset: 0,
      limit: pageSize,
      type: _typeFilter,
    );
    if (isClosed) return; // guard sau await
    emit(LessonListState(
      lessons: firstPage,
      hasReachedMax: firstPage.length < pageSize,
    ));
  }

  Future<void> _onNextPage(
    LessonListNextPageRequested event,
    Emitter<LessonListState> emit,
  ) async {
    if (state.hasReachedMax || state.isLoading) return;
    emit(state.copyWith(isLoading: true));
    final nextPage = await repository.getLessonsPage(
      _courseId,
      offset: state.lessons.length,
      limit: pageSize,
      type: _typeFilter,
    );
    if (isClosed) return; // guard sau await
    emit(state.copyWith(
      lessons: [...state.lessons, ...nextPage],
      hasReachedMax: nextPage.length < pageSize,
      isLoading: false,
    ));
  }
}
