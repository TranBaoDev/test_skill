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

      // Khôi phục đúng vị trí đang xem trước khi thoát app / rời màn hình
      final saved = await progressRepository.getProgress(lessonId);
      if (saved != null && saved.positionMs > 0) {
        await controller.seekTo(Duration(milliseconds: saved.positionMs));
      }

      controller.addListener(_onControllerUpdate);
      emit(state.copyWith(controller: controller, isInitialized: true));
      await controller.play();
    } catch (_) {
      emit(state.copyWith(isLoadError: true));
    }
  }

  void _onControllerUpdate() {
    final controller = state.controller;
    if (controller == null || !controller.value.isInitialized) return;

    // Throttle ghi DB — không ghi mỗi frame, chỉ ghi tối đa 1 lần / 2 giây
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
    await state.controller?.pause();
  }

  Future<void> play() async {
    await state.controller?.play();
  }

  /// Gọi khi app vào background hoặc rời màn hình —
  /// ghi vị trí NGAY, không chờ throttle 2 giây.
  Future<void> flushPosition() async {
    _saveThrottle?.cancel();
    await _persistCurrentPosition();
  }

  @override
  Future<void> close() async {
    state.controller?.removeListener(_onControllerUpdate);
    _saveThrottle?.cancel();
    await flushPosition(); // đảm bảo không mất vị trí xem khi rời màn hình
    return super.close();
  }
}
