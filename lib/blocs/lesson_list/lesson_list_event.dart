import 'package:equatable/equatable.dart';

abstract class LessonListEvent extends Equatable {
  const LessonListEvent();
  @override
  List<Object?> get props => [];
}

class LessonListStarted extends LessonListEvent {
  final int courseId;
  const LessonListStarted(this.courseId);
  @override
  List<Object?> get props => [courseId];
}

class LessonListNextPageRequested extends LessonListEvent {
  const LessonListNextPageRequested();
}
