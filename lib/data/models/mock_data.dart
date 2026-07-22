class MockData {
  final List<MockCourse> courses;
  MockData(this.courses);
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
