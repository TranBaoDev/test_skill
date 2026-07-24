import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import '../../data/models/lesson_extensions.dart';
import '../../injection.dart';
import '../../data/repositories/watch_progress_repository.dart';
import '../../data/models/watch_progress.dart';
import '../../data/models/lesson.dart';
import 'video_player_screen.dart';
import 'audio_player_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F8),
      appBar: AppBar(
          title: const Text('Lịch sử xem'),
          backgroundColor: const Color(0xFFF3F4F8),
          elevation: 0),
      body: FutureBuilder<List<WatchProgress>>(
        future: getIt<WatchProgressRepository>().getRecentHistory(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final history = snapshot.data!;
          if (history.isEmpty) {
            return const Center(child: Text('Chưa có lịch sử xem nào'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: history.length,
            itemBuilder: (context, index) {
              return _HistoryTile(progress: history[index]);
            },
          );
        },
      ),
    );
  }
}

class _HistoryTile extends StatelessWidget {
  final WatchProgress progress;
  const _HistoryTile({required this.progress});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Lesson?>(
      future: getIt<Isar>().lessons.get(progress.lessonId),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return const SizedBox.shrink();
        }
        final lesson = snapshot.data!;
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            leading: Icon(
              lesson.type == 'video'
                  ? Icons.play_circle_outline
                  : Icons.audiotrack,
              color: const Color(0xFF3D5CFF),
            ),
            title: Text(lesson.displayTitle,
                maxLines: 1, overflow: TextOverflow.ellipsis),
            subtitle: Text(
                'Đã xem: ${_formatMs(progress.positionMs)} • ${_formatDate(progress.updatedAt)}'),
            onTap: () {
              if (lesson.type == 'video') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => VideoPlayerScreen(lesson: lesson)));
              } else if (lesson.type == 'audio') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => AudioPlayerScreen(lesson: lesson)));
              }
            },
          ),
        );
      },
    );
  }

  String _formatMs(int ms) {
    final totalSeconds = ms ~/ 1000;
    return '${totalSeconds ~/ 60}:${(totalSeconds % 60).toString().padLeft(2, '0')}';
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
