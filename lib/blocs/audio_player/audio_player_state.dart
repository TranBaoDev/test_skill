import 'package:equatable/equatable.dart';

class AudioPlayerState extends Equatable {
  final Duration position;
  final Duration duration;
  final bool isPlaying;
  final bool isLoading;

  const AudioPlayerState({
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.isPlaying = false,
    this.isLoading = true,
  });

  AudioPlayerState copyWith({
    Duration? position,
    Duration? duration,
    bool? isPlaying,
    bool? isLoading,
  }) {
    return AudioPlayerState(
      position: position ?? this.position,
      duration: duration ?? this.duration,
      isPlaying: isPlaying ?? this.isPlaying,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [position, duration, isPlaying, isLoading];
}
