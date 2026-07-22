import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection.dart';
import 'blocs/app_lifecycle/app_lifecycle_cubit.dart';
import 'ui/screens/course_list_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppLifecycleCubit(),
      child: MaterialApp(
        title: 'Course App',
        home: const CourseListScreen(),
      ),
    );
  }
}
