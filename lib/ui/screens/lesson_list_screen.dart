import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../injection.dart';
import '../../blocs/lesson_list/lesson_list_bloc.dart';
import '../../blocs/lesson_list/lesson_list_event.dart';
import '../../blocs/lesson_list/lesson_list_state.dart';
import '../../data/models/lesson.dart';

class LessonListScreen extends StatelessWidget {
  final int courseId;
  const LessonListScreen({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LessonListBloc(getIt())..add(LessonListStarted(courseId)),
      child: Scaffold(
        appBar: AppBar(title: const Text('Bài học')),
        body: BlocBuilder<LessonListBloc, LessonListState>(
          buildWhen: (prev, curr) => prev.lessons.length != curr.lessons.length,
          builder: (context, state) {
            if (state.lessons.isEmpty && state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.lessons.isEmpty) {
              return const Center(child: Text('Chưa có bài học nào'));
            }
            return NotificationListener<ScrollEndNotification>(
              onNotification: (notification) {
                if (notification.metrics.extentAfter < 300) {
                  context
                      .read<LessonListBloc>()
                      .add(const LessonListNextPageRequested());
                }
                return false;
              },
              child: ListView.builder(
                itemExtent: 72,
                itemCount: state.lessons.length,
                itemBuilder: (context, index) {
                  return _LessonTile(lesson: state.lessons[index]);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class _LessonTile extends StatelessWidget {
  final Lesson lesson;
  const _LessonTile({required this.lesson});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(_iconFor(lesson.type)),
      title: Text(lesson.title),
      subtitle: Text(lesson.type),
      onTap: () {
        // TODO: điều hướng tới màn hình xem nội dung theo type (bước tiếp theo)
      },
    );
  }

  IconData _iconFor(String type) {
    switch (type) {
      case 'video':
        return Icons.play_circle_outline;
      case 'audio':
        return Icons.audiotrack;
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'image':
        return Icons.image;
      case 'quiz':
        return Icons.quiz;
      default:
        return Icons.book;
    }
  }
}
