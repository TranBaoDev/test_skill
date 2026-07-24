import 'package:flutter/material.dart';
import '../../injection.dart';
import '../../data/repositories/bookmark_repository.dart';
import '../../data/models/lesson.dart';
import '../../data/models/lesson_extensions.dart';
import '../widgets/bookmark_button.dart';
import 'video_player_screen.dart';
import 'audio_player_screen.dart';
import 'pdf_viewer_screen.dart';
import 'image_viewer_screen.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  late Future<List<Lesson>> _future;

  @override
  void initState() {
    super.initState();
    _future = getIt<BookmarkRepository>().getBookmarkedLessons();
  }

  Future<void> _refresh() async {
    setState(() {
      _future = getIt<BookmarkRepository>().getBookmarkedLessons();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F8),
      appBar: AppBar(
        title: const Text('Đã lưu'),
        backgroundColor: const Color(0xFFF3F4F8),
        elevation: 0,
        foregroundColor: const Color(0xFF1B1D28),
      ),
      body: FutureBuilder<List<Lesson>>(
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final lessons = snapshot.data!;
          if (lessons.isEmpty) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.bookmark_border_rounded,
                      size: 48, color: Colors.grey),
                  SizedBox(height: 12),
                  Text('Chưa có bài học nào được lưu',
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: lessons.length,
              itemBuilder: (context, index) {
                return _BookmarkTile(
                    lesson: lessons[index], onChanged: _refresh);
              },
            ),
          );
        },
      ),
    );
  }
}

class _BookmarkTile extends StatelessWidget {
  final Lesson lesson;
  final VoidCallback onChanged;
  const _BookmarkTile({required this.lesson, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final style = _styleFor(lesson.type);
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: style.color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(style.icon, color: style.color, size: 20),
        ),
        title: Text(lesson.displayTitle,
            maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Text(style.label),
        trailing: GestureDetector(
          // Bọc riêng để bắt sự kiện onChanged sau khi bỏ bookmark
          onTap: () async {
            await getIt<BookmarkRepository>().toggleBookmark(lesson.id);
            onChanged();
          },
          child: const Icon(Icons.bookmark_rounded, color: Color(0xFF3D5CFF)),
        ),
        onTap: () => _openLesson(context),
      ),
    );
  }

  void _openLesson(BuildContext context) {
    switch (lesson.type) {
      case 'video':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => VideoPlayerScreen(lesson: lesson)));
        break;
      case 'audio':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => AudioPlayerScreen(lesson: lesson)));
        break;
      case 'pdf':
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => PdfViewerScreen(lesson: lesson)));
        break;
      case 'image':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ImageViewerScreen(lesson: lesson)));
        break;
    }
  }

  _StyleInfo _styleFor(String type) {
    switch (type) {
      case 'video':
        return _StyleInfo(
            Icons.play_circle_fill_rounded, const Color(0xFF3D5CFF), 'Video');
      case 'audio':
        return _StyleInfo(
            Icons.audiotrack_rounded, const Color(0xFF00C48C), 'Audio');
      case 'pdf':
        return _StyleInfo(
            Icons.picture_as_pdf_rounded, const Color(0xFFFF7A59), 'PDF');
      case 'image':
        return _StyleInfo(
            Icons.image_rounded, const Color(0xFFFFB800), 'Hình ảnh');
      case 'quiz':
        return _StyleInfo(Icons.quiz_rounded, const Color(0xFF9B3DFF), 'Quiz');
      default:
        return _StyleInfo(Icons.book_rounded, Colors.grey, 'Bài học');
    }
  }
}

class _StyleInfo {
  final IconData icon;
  final Color color;
  final String label;
  _StyleInfo(this.icon, this.color, this.label);
}
