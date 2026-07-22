import 'package:equatable/equatable.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerState extends Equatable {
  final VideoPlayerController? controller;
  final bool isInitialized;
  final bool isLoadError;

  const VideoPlayerState({
    this.controller,
    this.isInitialized = false,
    this.isLoadError = false,
  });

  VideoPlayerState copyWith({
    VideoPlayerController? controller,
    bool? isInitialized,
    bool? isLoadError,
  }) {
    return VideoPlayerState(
      controller: controller ?? this.controller,
      isInitialized: isInitialized ?? this.isInitialized,
      isLoadError: isLoadError ?? this.isLoadError,
    );
  }

  @override
  List<Object?> get props => [controller, isInitialized, isLoadError];
}
