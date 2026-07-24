import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import '../../injection.dart';
import '../../blocs/video_player/video_player_cubit.dart';
import '../../blocs/video_player/video_player_state.dart';
import '../../blocs/app_lifecycle/app_lifecycle_cubit.dart';
import '../../data/models/lesson.dart';

import '../../data/models/lesson_extensions.dart';

class VideoPlayerScreen extends StatelessWidget {
  final Lesson lesson;
  final int? lessonNumber;
  const VideoPlayerScreen({super.key, required this.lesson, this.lessonNumber});

  @override
  Widget build(BuildContext context) {
    final title = lessonNumber != null
        ? 'Bài $lessonNumber: ${lesson.displayTitle}'
        : lesson.displayTitle;

    return BlocProvider(
      key: ValueKey(lesson.id),
      create: (_) => VideoPlayerCubit(
        pool: getIt(),
        progressRepository: getIt(),
        lessonId: lesson.id,
      )..load(lesson.contentPath),
      child: _VideoPlayerView(title: title),
    );
  }
}

class _VideoPlayerView extends StatelessWidget {
  final String title;
  const _VideoPlayerView({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: MultiBlocListener(
        listeners: [
          // Lắng nghe lifecycle toàn app để pause video khi vào background
          BlocListener<AppLifecycleCubit, AppLifecycleState>(
            listener: (context, lifecycleState) {
              final videoCubit = context.read<VideoPlayerCubit>();
              if (lifecycleState == AppLifecycleState.paused ||
                  lifecycleState == AppLifecycleState.inactive) {
                videoCubit.pause();
                videoCubit.flushPosition();
              }
            },
          ),
        ],
        child: BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
          builder: (context, state) {
            if (state.isLoadError) {
              return const Center(child: Text('Không thể tải video'));
            }
            if (!state.isInitialized || state.controller == null) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                AspectRatio(
                  aspectRatio: state.controller!.value.aspectRatio,
                  child: VideoPlayer(state.controller!),
                ),
                _VideoControls(controller: state.controller!),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _VideoControls extends StatefulWidget {
  final VideoPlayerController controller;
  const _VideoControls({required this.controller});

  @override
  State<_VideoControls> createState() => _VideoControlsState();
}

class _VideoControlsState extends State<_VideoControls> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_refresh);
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    widget.controller.removeListener(_refresh);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final value = widget.controller.value;
    return Column(
      children: [
        Slider(
          value: value.position.inMilliseconds.toDouble().clamp(
                0,
                value.duration.inMilliseconds.toDouble(),
              ),
          max: value.duration.inMilliseconds
              .toDouble()
              .clamp(1, double.infinity),
          onChanged: (v) {
            widget.controller.seekTo(Duration(milliseconds: v.toInt()));
          },
        ),
        IconButton(
          icon: Icon(value.isPlaying ? Icons.pause : Icons.play_arrow),
          onPressed: () {
            value.isPlaying
                ? widget.controller.pause()
                : widget.controller.play();
          },
        ),
      ],
    );
  }
}
