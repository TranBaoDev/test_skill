import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import '../models/course.dart';
import '../models/lesson.dart';
import '../models/quiz_question.dart';
import '../models/mock_data.dart';

class DatabaseService {
  static const _bankCount = 5;

  static Future<void> seedIfEmpty(Isar isar) async {
    final courseCount = await isar.courses.count();
    if (courseCount > 0) return;

    final coursesJson = await rootBundle.loadString('assets/mock/courses.json');

    final bankJsonList = <String>[];
    for (var i = 1; i <= _bankCount; i++) {
      bankJsonList
          .add(await rootBundle.loadString('assets/mock/quiz_bank_$i.json'));
    }

    final parsed = await compute(_parseJsonIsolate, {
      'courses': coursesJson,
      'banks': bankJsonList,
    });

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

      final quizModels = parsed.quizQuestions
          .map((q) => QuizQuestion()
            ..id = q.id
            ..bankId = q.bankId
            ..question = q.question
            ..imagePath = q.imagePath
            ..audioPath = q.audioPath
            ..options = q.options
            ..correctIndex = q.correctIndex)
          .toList();

      await isar.courses.putAll(courseModels);
      await isar.lessons.putAll(lessonModels);
      await isar.quizQuestions.putAll(quizModels);
    });
  }
}

MockData _parseJsonIsolate(Map<String, dynamic> input) {
  final coursesMap =
      jsonDecode(input['courses'] as String) as Map<String, dynamic>;
  final bankJsonList = input['banks'] as List<String>;

  final courses = (coursesMap['courses'] as List).map((c) {
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

  final quizQuestions = <MockQuizQuestion>[];
  for (final bankJson in bankJsonList) {
    final bankMap = jsonDecode(bankJson) as Map<String, dynamic>;
    for (final q in bankMap['questions'] as List) {
      quizQuestions.add(MockQuizQuestion(
        id: q['id'],
        bankId: q['bankId'],
        question: q['question'],
        imagePath: q['imagePath'],
        audioPath: q['audioPath'],
        options: List<String>.from(q['options']),
        correctIndex: q['correctIndex'],
      ));
    }
  }

  return MockData(courses, quizQuestions);
}
