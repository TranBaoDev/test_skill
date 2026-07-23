import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';

import '../models/course.dart';
import '../models/lesson.dart';
import '../models/mock_data.dart';
import '../models/quiz_question.dart';

class DatabaseService {
  static Future<void> seedIfEmpty(Isar isar) async {
    final courseCount = await isar.courses.count();
    if (courseCount > 0) return;

    final coursesJson = await rootBundle.loadString('assets/mock/courses.json');
    final quizJson = await rootBundle.loadString('assets/mock/quiz.json');

    // Parse cả 2 file nặng trong isolate riêng, không block UI
    final parsed = await compute(_parseJsonIsolate, {
      'courses': coursesJson,
      'quiz': quizJson,
    });

    await isar.writeTxn(() async {
      final courseModels = parsed.courses
          .map(
            (c) => Course()
              ..id = c.id
              ..title = c.title
              ..thumbnailPath = c.thumbnailPath,
          )
          .toList();

      final lessonModels = parsed.courses
          .expand((c) => c.lessons)
          .map(
            (l) => Lesson()
              ..id = l.id
              ..courseId = l.courseId
              ..title = l.title
              ..type = l.type
              ..contentPath = l.contentPath
              ..durationMs = l.durationMs,
          )
          .toList();

      final quizModels = parsed.quizQuestions
          .map(
            (q) => QuizQuestion()
              ..id = q.id
              ..quizId = q.quizId
              ..question = q.question
              ..imagePath = q.imagePath
              ..audioPath = q.audioPath
              ..options = q.options,
          )
          .toList();

      await isar.courses.putAll(courseModels);
      await isar.lessons.putAll(lessonModels);
      await isar.quizQuestions.putAll(quizModels);
    });
  }
}

MockData _parseJsonIsolate(Map<String, String> input) {
  final coursesMap = jsonDecode(input['courses']!) as Map<String, dynamic>;
  final quizMap = jsonDecode(input['quiz']!) as Map<String, dynamic>;

  final courses = (coursesMap['courses'] as List).map((c) {
    final lessons = (c['lessons'] as List)
        .map(
          (l) => MockLesson(
            id: l['id'],
            courseId: l['courseId'],
            title: l['title'],
            type: l['type'],
            contentPath: l['contentPath'],
            durationMs: l['durationMs'],
          ),
        )
        .toList();

    return MockCourse(
      id: c['id'],
      title: c['title'],
      thumbnailPath: c['thumbnailPath'],
      lessons: lessons,
    );
  }).toList();

  final quizQuestions = (quizMap['questions'] as List).map((q) {
    return MockQuizQuestion(
      id: q['id'],
      quizId: q['quizId'],
      question: q['question'],
      imagePath: q['imagePath'],
      audioPath: q['audioPath'],
      options: List<String>.from(q['options']),
    );
  }).toList();

  return MockData(courses, quizQuestions);
}
