import 'package:isar/isar.dart';
import '../models/course.dart';

class CourseRepository {
  final Isar isar;
  CourseRepository(this.isar);

  Future<List<Course>> getAllCourses() {
    return isar.courses.where().findAll();
  }
}
