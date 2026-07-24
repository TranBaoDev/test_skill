import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/watch_progress_repository.dart';
import '../../data/services/video_controller_pool.dart';
import 'video_player_state.dart';

class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  final VideoControllerPool pool;
  final WatchProgressRepository progressRepository;
  final int lessonId;

  Timer? _saveThrottle;

  VideoPlayerCubit({
    required this.pool,
    required this.progressRepository,
    required this.lessonId,
  }) : super(const VideoPlayerState());

  Future<void> load(String path) async {
    try {
      final controller = await pool.getController(lessonId, path);
      if (isClosed) return; // guard sau await đầu tiên

      final saved = await progressRepository.getProgress(lessonId);
      if (isClosed) return; // guard sau await thứ hai

      if (saved != null && saved.positionMs > 0) {
        await controller.seekTo(Duration(milliseconds: saved.positionMs));
        if (isClosed) return;
      }

      controller.addListener(_onControllerUpdate);
      emit(state.copyWith(controller: controller, isInitialized: true));

      await controller.play();
    } catch (_) {
      if (!isClosed) {
        emit(state.copyWith(isLoadError: true));
      }
    }
  }

  void _onControllerUpdate() {
    if (isClosed)
      return; // guard vì listener có thể fire ngay lúc close() đang chạy
    final controller = state.controller;
    if (controller == null || !controller.value.isInitialized) return;

    _saveThrottle?.cancel();
    _saveThrottle = Timer(const Duration(seconds: 2), () {
      _persistCurrentPosition();
    });
  }

  Future<void> _persistCurrentPosition() async {
    final controller = state.controller;
    if (controller == null) return;
    final positionMs = controller.value.position.inMilliseconds;
    await progressRepository.saveProgress(lessonId, positionMs);
  }

  Future<void> pause() async {
    if (isClosed) return;
    await state.controller?.pause();
  }

  Future<void> play() async {
    if (isClosed) return;
    await state.controller?.play();
  }

  Future<void> flushPosition() async {
    _saveThrottle?.cancel();
    await _persistCurrentPosition();
  }

  @override
  Future<void> close() async {
    state.controller?.removeListener(_onControllerUpdate);
    _saveThrottle?.cancel();
    await flushPosition();
    await state.controller?.pause();
    return super.close();
  }
}
