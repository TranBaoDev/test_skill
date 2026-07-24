import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audio_service/audio_service.dart';
import 'injection.dart';
import 'blocs/app_lifecycle/app_lifecycle_cubit.dart';
import 'data/services/audio_handler_service.dart';
import 'ui/screens/home_screen.dart';

late AudioHandlerService audioHandler;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupInjection();

  audioHandler = await AudioService.init(
    builder: () => AudioHandlerService(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.example.course_app.audio',
      androidNotificationChannelName: 'Course App Audio',
      androidNotificationOngoing: true,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppLifecycleCubit(),
      child: MaterialApp(
        title: 'Edu Care',
        theme: ThemeData(useMaterial3: true),
        home: const HomeScreen(),
      ),
    );
  }
}
