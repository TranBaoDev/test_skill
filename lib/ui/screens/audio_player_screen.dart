import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../injection.dart';
import '../../blocs/audio_player/audio_player_cubit.dart';
import '../../blocs/audio_player/audio_player_state.dart';
import '../../blocs/app_lifecycle/app_lifecycle_cubit.dart';
import '../../data/models/lesson.dart';
import '../widgets/bookmark_button.dart';

import '../../data/models/lesson_extensions.dart';

class AudioPlayerScreen extends StatelessWidget {
  final Lesson lesson;
  final int? lessonNumber;
  const AudioPlayerScreen({super.key, required this.lesson, this.lessonNumber});

  @override
  Widget build(BuildContext context) {
    final title = lessonNumber != null
        ? 'Bài $lessonNumber: ${lesson.displayTitle}'
        : lesson.displayTitle;

    return BlocProvider(
      key: ValueKey(lesson.id),
      create: (_) => AudioPlayerCubit(
        progressRepository: getIt(),
        lessonId: lesson.id,
      )..load(lesson.contentPath, title),
      child: _AudioPlayerView(title: title, lessonId: lesson.id),
    );
  }
}

class _AudioPlayerView extends StatelessWidget {
  final String title;
  final int lessonId;
  const _AudioPlayerView({required this.title, required this.lessonId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [BookmarkButton(lessonId: lessonId)],
      ),
      body: BlocListener<AppLifecycleCubit, AppLifecycleState>(
        listener: (context, lifecycleState) {
          final audioCubit = context.read<AudioPlayerCubit>();
          if (lifecycleState == AppLifecycleState.paused ||
              lifecycleState == AppLifecycleState.inactive) {
            audioCubit.pause();
            audioCubit.flushPosition();
          }
        },
        child: BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.audiotrack_rounded,
                      size: 96, color: Color(0xFF00C48C)),
                  const SizedBox(height: 32),
                  Slider(
                    value: state.position.inMilliseconds.toDouble().clamp(
                          0,
                          state.duration.inMilliseconds
                              .toDouble()
                              .clamp(1, double.infinity),
                        ),
                    max: state.duration.inMilliseconds
                        .toDouble()
                        .clamp(1, double.infinity),
                    onChanged: (v) {
                      context
                          .read<AudioPlayerCubit>()
                          .seek(Duration(milliseconds: v.toInt()));
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_formatDuration(state.position)),
                      Text(_formatDuration(state.duration)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  IconButton(
                    iconSize: 64,
                    icon: Icon(
                      state.isPlaying
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_filled,
                      color: const Color(0xFF00C48C),
                    ),
                    onPressed: () =>
                        context.read<AudioPlayerCubit>().togglePlayPause(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes;
    final seconds = d.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
