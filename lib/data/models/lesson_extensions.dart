import 'lesson.dart';

/// Tách phần mô tả ra khỏi title gốc trong mock data (dạng "Bài N: Mô tả"),
/// vì số N gốc không phản ánh đúng vị trí sau khi filter theo type.
extension LessonDisplay on Lesson {
  String get displayTitle {
    final match = RegExp(r'^Bài\s*\d+:\s*(.+)$').firstMatch(title);
    return match != null ? match.group(1)!.trim() : title;
  }
}
