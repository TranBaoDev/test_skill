import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'data/models/course.dart';
import 'data/models/lesson.dart';
import 'data/models/watch_progress.dart';
import 'data/models/quiz_question.dart';
import 'data/models/quiz_answer.dart';
import 'data/models/bookmark.dart';
import 'data/repositories/lesson_repository.dart';
import 'data/repositories/watch_progress_repository.dart';
import 'data/services/database_service.dart';
import 'data/services/video_controller_pool.dart';

final getIt = GetIt.instance;

Future<void> setupInjection() async {
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [
      CourseSchema,
      LessonSchema,
      WatchProgressSchema,
      QuizQuestionSchema,
      QuizAnswerSchema,
      BookmarkSchema,
    ],
    directory: dir.path,
  );

  await DatabaseService.seedIfEmpty(isar);

  getIt.registerSingleton<Isar>(isar);
  getIt.registerSingleton<LessonRepository>(LessonRepository(isar));
  getIt.registerSingleton<WatchProgressRepository>(
      WatchProgressRepository(isar));
  getIt
      .registerSingleton<VideoControllerPool>(VideoControllerPool(maxAlive: 2));
}
