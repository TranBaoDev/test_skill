import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../main.dart' show audioHandler;
import '../../data/repositories/watch_progress_repository.dart';
import 'audio_player_state.dart';

class AudioPlayerCubit extends Cubit<AudioPlayerState> {
  final WatchProgressRepository progressRepository;
  final int lessonId;

  StreamSubscription? _positionSub;
  StreamSubscription? _playerStateSub;
  Timer? _saveThrottle;

  AudioPlayerCubit({
    required this.progressRepository,
    required this.lessonId,
  }) : super(const AudioPlayerState());

  Future<void> load(String path, String title) async {
    try {
      await audioHandler.loadMedia(path, title);
      if (isClosed) return;

      final saved = await progressRepository.getProgress(lessonId);
      if (isClosed) return;

      if (saved != null && saved.positionMs > 0) {
        await audioHandler.seek(Duration(milliseconds: saved.positionMs));
        if (isClosed) return;
      }

      _positionSub = audioHandler.player.positionStream.listen((position) {
        if (isClosed) return;
        emit(state.copyWith(position: position));
        _saveThrottle?.cancel();
        _saveThrottle = Timer(const Duration(seconds: 2), () {
          progressRepository.saveProgress(lessonId, position.inMilliseconds);
        });
      });

      _playerStateSub =
          audioHandler.player.playerStateStream.listen((playerState) {
        if (isClosed) return;
        emit(state.copyWith(isPlaying: playerState.playing));
      });

      if (isClosed) return;
      emit(state.copyWith(
        duration: audioHandler.player.duration ?? Duration.zero,
        isLoading: false,
      ));

      await audioHandler.play();
    } catch (_) {
      if (!isClosed) emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> togglePlayPause() async {
    if (isClosed) return;
    if (audioHandler.player.playing) {
      await audioHandler.pause();
    } else {
      await audioHandler.play();
    }
  }

  Future<void> seek(Duration position) async {
    if (isClosed) return;
    await audioHandler.seek(position);
  }

  Future<void> pause() async {
    if (isClosed) return;
    await audioHandler.pause();
  }

  Future<void> flushPosition() async {
    _saveThrottle?.cancel();
    await progressRepository.saveProgress(
        lessonId, audioHandler.player.position.inMilliseconds);
  }

  @override
  Future<void> close() async {
    await _positionSub?.cancel();
    await _playerStateSub?.cancel();
    _saveThrottle?.cancel();
    await flushPosition();
    await audioHandler.pause();
    // KHÔNG dispose audioHandler.player ở đây — nó dùng chung toàn app
    return super.close();
  }
}
