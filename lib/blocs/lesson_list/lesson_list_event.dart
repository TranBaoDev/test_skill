import 'package:equatable/equatable.dart';

abstract class LessonListEvent extends Equatable {
  const LessonListEvent();
  @override
  List<Object?> get props => [];
}

class LessonListStarted extends LessonListEvent {
  final int courseId;
  final String? type;
  const LessonListStarted(this.courseId, {this.type});
  @override
  List<Object?> get props => [courseId, type];
}

class LessonListNextPageRequested extends LessonListEvent {
  const LessonListNextPageRequested();
}
