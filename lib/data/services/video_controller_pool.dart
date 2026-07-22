import 'dart:io';
import 'package:video_player/video_player.dart';

/// Quản lý vòng đời VideoPlayerController để tránh phình RAM khi
/// người dùng chuyển qua lại nhiều video liên tục.
/// Chỉ giữ tối đa [maxAlive] controller sống cùng lúc.
class VideoControllerPool {
  final int maxAlive;
  final Map<int, VideoPlayerController> _controllers = {};
  final List<int> _accessOrder = []; // theo dõi thứ tự dùng gần nhất

  VideoControllerPool({this.maxAlive = 2});

  bool get isEmpty => _controllers.isEmpty;

  VideoPlayerController? peek(int lessonId) => _controllers[lessonId];

  Future<VideoPlayerController> getController(int lessonId, String path) async {
    if (_controllers.containsKey(lessonId)) {
      _touch(lessonId);
      return _controllers[lessonId]!;
    }

    // Nếu đã đạt giới hạn, giải phóng controller cũ nhất (LRU)
    while (_controllers.length >= maxAlive) {
      final oldestId = _accessOrder.first;
      await _disposeController(oldestId);
    }

    final controller = _createController(path);
    await controller.initialize();

    _controllers[lessonId] = controller;
    _touch(lessonId);
    return controller;
  }

  VideoPlayerController _createController(String path) {
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return VideoPlayerController.networkUrl(Uri.parse(path));
    }
    if (path.startsWith('assets/')) {
      return VideoPlayerController.asset(path);
    }
    return VideoPlayerController.file(File(path));
  }

  void _touch(int lessonId) {
    _accessOrder.remove(lessonId);
    _accessOrder.add(lessonId);
  }

  Future<void> _disposeController(int lessonId) async {
    final controller = _controllers.remove(lessonId);
    _accessOrder.remove(lessonId);
    if (controller != null) {
      await controller.pause();
      await controller.dispose();
    }
  }

  /// Gọi khi app vào background — pause tất cả nhưng KHÔNG dispose,
  /// để giữ nguyên vị trí xem và khôi phục nhanh khi quay lại.
  Future<void> pauseAll() async {
    for (final controller in _controllers.values) {
      if (controller.value.isPlaying) {
        await controller.pause();
      }
    }
  }

  /// Chủ động giải phóng 1 controller cụ thể (khi rời màn hình lesson đó hẳn).
  Future<void> disposeLesson(int lessonId) => _disposeController(lessonId);

  Future<void> disposeAll() async {
    for (final id in List<int>.from(_accessOrder)) {
      await _disposeController(id);
    }
  }
}
