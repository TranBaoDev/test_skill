import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import '../models/course.dart';
import '../models/lesson.dart';
import '../models/mock_data.dart';

class DatabaseService {
  static Future<void> seedIfEmpty(Isar isar) async {
    final courseCount = await isar.courses.count();
    if (courseCount > 0) return; // đã seed rồi, bỏ qua

    final jsonString = await rootBundle.loadString('assets/mock/courses.json');
    // Parse JSON nặng (~3000 record) trong isolate riêng, không block UI thread
    final parsed = await compute(_parseJsonIsolate, jsonString);

    await isar.writeTxn(() async {
      final courseModels = parsed.courses
          .map((c) => Course()
            ..id = c.id
            ..title = c.title
            ..thumbnailPath = c.thumbnailPath)
          .toList();

      final lessonModels = parsed.courses
          .expand((c) => c.lessons)
          .map((l) => Lesson()
            ..id = l.id
            ..courseId = l.courseId
            ..title = l.title
            ..type = l.type
            ..contentPath = l.contentPath
            ..durationMs = l.durationMs)
          .toList();

      await isar.courses.putAll(courseModels);
      await isar.lessons.putAll(lessonModels);
    });
  }
}

// Top-level function bắt buộc để dùng được với compute()
MockData _parseJsonIsolate(String jsonString) {
  final map = jsonDecode(jsonString) as Map<String, dynamic>;
  final courses = (map['courses'] as List).map((c) {
    final lessons = (c['lessons'] as List)
        .map((l) => MockLesson(
              id: l['id'],
              courseId: l['courseId'],
              title: l['title'],
              type: l['type'],
              contentPath: l['contentPath'],
              durationMs: l['durationMs'],
            ))
        .toList();

    return MockCourse(
      id: c['id'],
      title: c['title'],
      thumbnailPath: c['thumbnailPath'],
      lessons: lessons,
    );
  }).toList();

  return MockData(courses);
}
