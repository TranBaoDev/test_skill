class MockData {
  final List<MockCourse> courses;
  final List<MockQuizQuestion> quizQuestions;
  MockData(this.courses, this.quizQuestions);
}

class MockCourse {
  final int id;
  final String title;
  final String thumbnailPath;
  final List<MockLesson> lessons;
  MockCourse(
      {required this.id,
      required this.title,
      required this.thumbnailPath,
      required this.lessons});
}

class MockLesson {
  final int id;
  final int courseId;
  final String title;
  final String type;
  final String contentPath;
  final int? durationMs;
  MockLesson({
    required this.id,
    required this.courseId,
    required this.title,
    required this.type,
    required this.contentPath,
    this.durationMs,
  });
}

class MockQuizQuestion {
  final int id;
  final int bankId;
  final String question;
  final String? imagePath;
  final String? audioPath;
  final List<String> options;
  final int correctIndex;
  MockQuizQuestion({
    required this.id,
    required this.bankId,
    required this.question,
    this.imagePath,
    this.audioPath,
    required this.options,
    required this.correctIndex,
  });
}
