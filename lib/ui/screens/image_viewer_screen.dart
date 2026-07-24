import 'package:flutter/material.dart';
import '../../data/models/lesson.dart';
import '../../data/models/lesson_extensions.dart';
import '../widgets/bookmark_button.dart';

class ImageViewerScreen extends StatelessWidget {
  final Lesson lesson;
  final int? lessonNumber;
  const ImageViewerScreen({super.key, required this.lesson, this.lessonNumber});

  @override
  Widget build(BuildContext context) {
    final title = lessonNumber != null
        ? 'Bài $lessonNumber: ${lesson.displayTitle}'
        : lesson.displayTitle;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(title),
        actions: [BookmarkButton(lessonId: lesson.id)],
      ),
      body: Center(
        child:
            InteractiveViewer(minScale: 0.5, maxScale: 4, child: _buildImage()),
      ),
    );
  }

  Widget _buildImage() {
    if (lesson.contentPath.startsWith('http')) {
      return Image.network(
        lesson.contentPath,
        errorBuilder: (_, __, ___) => const _ImageError(),
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return const Center(child: CircularProgressIndicator());
        },
      );
    }
    return Image.asset(lesson.contentPath,
        errorBuilder: (_, __, ___) => const _ImageError());
  }
}

class _ImageError extends StatelessWidget {
  const _ImageError();
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.broken_image_outlined, color: Colors.white54, size: 64),
        SizedBox(height: 12),
        Text('Không thể tải hình ảnh', style: TextStyle(color: Colors.white54)),
      ],
    );
  }
}
