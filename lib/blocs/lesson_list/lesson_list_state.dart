import 'package:equatable/equatable.dart';
import '../../data/models/lesson.dart';

class LessonListState extends Equatable {
  final List<Lesson> lessons;
  final bool hasReachedMax;
  final bool isLoading;

  const LessonListState({
    this.lessons = const [],
    this.hasReachedMax = false,
    this.isLoading = false,
  });

  LessonListState copyWith({
    List<Lesson>? lessons,
    bool? hasReachedMax,
    bool? isLoading,
  }) {
    return LessonListState(
      lessons: lessons ?? this.lessons,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [lessons.length, hasReachedMax, isLoading];
}
