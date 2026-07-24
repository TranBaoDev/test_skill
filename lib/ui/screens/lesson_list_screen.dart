import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../injection.dart';
import '../../blocs/lesson_list/lesson_list_bloc.dart';
import '../../blocs/lesson_list/lesson_list_event.dart';
import '../../blocs/lesson_list/lesson_list_state.dart';
import '../../data/models/lesson.dart';
import 'quiz_screen.dart';
import 'video_player_screen.dart';

class LessonListScreen extends StatelessWidget {
  final int courseId;
  final String? typeFilter;
  final String screenTitle;

  const LessonListScreen({
    super.key,
    required this.courseId,
    this.typeFilter,
    this.screenTitle = 'Bài học',
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LessonListBloc(getIt())
        ..add(LessonListStarted(courseId, type: typeFilter)),
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F4F8),
        appBar: AppBar(
          title: Text(screenTitle),
          backgroundColor: const Color(0xFFF3F4F8),
          elevation: 0,
          foregroundColor: const Color(0xFF1B1D28),
        ),
        body: BlocBuilder<LessonListBloc, LessonListState>(
          buildWhen: (prev, curr) => prev.lessons.length != curr.lessons.length,
          builder: (context, state) {
            if (state.lessons.isEmpty && state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.lessons.isEmpty) {
              return _buildEmptyState();
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
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                itemCount: state.lessons.length + (state.hasReachedMax ? 0 : 1),
                itemBuilder: (context, index) {
                  if (index >= state.lessons.length) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  return _LessonCard(
                    // Số thứ tự tính theo VỊ TRÍ THỰC TẾ trong danh sách đã lọc,
                    // không dùng số nhúng trong title -> luôn liên tục 1,2,3...
                    displayIndex: index + 1,
                    lesson: state.lessons[index],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.inbox_outlined, size: 48, color: Colors.grey),
          SizedBox(height: 12),
          Text('Chưa có bài học nào', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}

class _LessonCard extends StatelessWidget {
  final int displayIndex;
  final Lesson lesson;
  const _LessonCard({required this.displayIndex, required this.lesson});

  @override
  Widget build(BuildContext context) {
    final style = _styleFor(lesson.type);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _onTap(context),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                // Số thứ tự
                SizedBox(
                  width: 28,
                  child: Text(
                    '$displayIndex',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF9A9DAE),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                // Icon box theo loại bài học
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: style.color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(style.icon, color: style.color, size: 22),
                ),
                const SizedBox(width: 12),
                // Title + subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _cleanTitle(lesson.title),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1B1D28),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: style.color.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              style.label,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: style.color,
                              ),
                            ),
                          ),
                          if (lesson.durationMs != null) ...[
                            const SizedBox(width: 8),
                            Icon(Icons.access_time_rounded,
                                size: 12, color: Colors.grey.shade500),
                            const SizedBox(width: 3),
                            Text(
                              _formatDuration(lesson.durationMs!),
                              style: TextStyle(
                                  fontSize: 11, color: Colors.grey.shade500),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right_rounded, color: Colors.grey.shade400),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTap(BuildContext context) {
    switch (lesson.type) {
      case 'video':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => VideoPlayerScreen(lesson: lesson)),
        );
        break;
      case 'quiz':
        // Random chọn 1 trong 5 ngân hàng câu hỏi mỗi lần vào Exam
        final randomBankId = Random().nextInt(5) + 1; // 1-5
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                QuizScreen(bankId: randomBankId, title: 'Trắc nghiệm'),
          ),
        );
        break;
      default:
        break;
    }
  }

  /// Xóa số thứ tự cũ đã nhúng cứng trong title mock data (nếu có dạng "Bài N: ...")
  /// để không hiển thị trùng lặp với displayIndex mới tính lại.
  String _cleanTitle(String title) {
    final match = RegExp(r'^Bài\s*\d+:\s*(.+)$').firstMatch(title);
    return match != null ? match.group(1)!.trim() : title;
  }

  String _formatDuration(int ms) {
    final totalSeconds = ms ~/ 1000;
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  _LessonTypeStyle _styleFor(String type) {
    switch (type) {
      case 'video':
        return _LessonTypeStyle(
            Icons.play_circle_fill_rounded, const Color(0xFF3D5CFF), 'Video');
      case 'audio':
        return _LessonTypeStyle(
            Icons.audiotrack_rounded, const Color(0xFF00C48C), 'Audio');
      case 'pdf':
        return _LessonTypeStyle(
            Icons.picture_as_pdf_rounded, const Color(0xFFFF7A59), 'PDF');
      case 'image':
        return _LessonTypeStyle(
            Icons.image_rounded, const Color(0xFFFFB800), 'Hình ảnh');
      case 'quiz':
        return _LessonTypeStyle(
            Icons.quiz_rounded, const Color(0xFF9B3DFF), 'Quiz');
      default:
        return _LessonTypeStyle(Icons.book_rounded, Colors.grey, 'Bài học');
    }
  }
}

class _LessonTypeStyle {
  final IconData icon;
  final Color color;
  final String label;
  _LessonTypeStyle(this.icon, this.color, this.label);
}
