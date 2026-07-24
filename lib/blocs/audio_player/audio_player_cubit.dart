import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import '../../data/repositories/watch_progress_repository.dart';
import 'audio_player_state.dart';

class AudioPlayerCubit extends Cubit<AudioPlayerState> {
  final AudioPlayer _player = AudioPlayer();
  final WatchProgressRepository progressRepository;
  final int lessonId;

  StreamSubscription? _positionSub;
  StreamSubscription? _playerStateSub;
  Timer? _saveThrottle;

  AudioPlayerCubit({
    required this.progressRepository,
    required this.lessonId,
  }) : super(const AudioPlayerState());

  Future<void> load(String path) async {
    try {
      if (path.startsWith('http')) {
        await _player.setUrl(path);
      } else {
        await _player.setAsset(path);
      }
      if (isClosed) return;

      final saved = await progressRepository.getProgress(lessonId);
      if (isClosed) return;

      if (saved != null && saved.positionMs > 0) {
        await _player.seek(Duration(milliseconds: saved.positionMs));
        if (isClosed) return;
      }

      _positionSub = _player.positionStream.listen((position) {
        if (isClosed) return; // guard trong listener
        emit(state.copyWith(position: position));
        _saveThrottle?.cancel();
        _saveThrottle = Timer(const Duration(seconds: 2), () {
          progressRepository.saveProgress(lessonId, position.inMilliseconds);
        });
      });

      _playerStateSub = _player.playerStateStream.listen((playerState) {
        if (isClosed) return;
        emit(state.copyWith(isPlaying: playerState.playing));
      });

      if (isClosed) return;
      emit(state.copyWith(
        duration: _player.duration ?? Duration.zero,
        isLoading: false,
      ));

      await _player.play();
    } catch (_) {
      if (!isClosed) {
        emit(state.copyWith(isLoading: false));
      }
    }
  }

  Future<void> togglePlayPause() async {
    if (isClosed) return;
    if (_player.playing) {
      await _player.pause();
    } else {
      await _player.play();
    }
  }

  Future<void> seek(Duration position) async {
    if (isClosed) return;
    await _player.seek(position);
  }

  Future<void> pause() async {
    if (isClosed) return;
    await _player.pause();
  }

  Future<void> flushPosition() async {
    _saveThrottle?.cancel();
    await progressRepository.saveProgress(
        lessonId, _player.position.inMilliseconds);
  }

  @override
  Future<void> close() async {
    await _positionSub?.cancel();
    await _playerStateSub?.cancel();
    _saveThrottle?.cancel();
    await flushPosition();
    await _player.pause();
    await _player.dispose();
    return super.close();
  }
}
