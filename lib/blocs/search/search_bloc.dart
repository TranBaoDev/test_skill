import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import '../../data/repositories/lesson_repository.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final LessonRepository repository;

  SearchBloc(this.repository) : super(const SearchInitial()) {
    on<SearchQueryChanged>(_onQueryChanged, transformer: restartable());
  }

  Future<void> _onQueryChanged(
    SearchQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    final query = event.query.trim();

    if (query.isEmpty) {
      emit(const SearchInitial());
      return;
    }

    emit(const SearchLoading());

    // Debounce đơn giản: đợi 300ms, nếu trong lúc đó có query mới,
    // restartable() sẽ tự huỷ handler này trước khi tới dòng search thật
    await Future.delayed(const Duration(milliseconds: 300));

    final results = await repository.searchLessons(query, limit: 50);

    if (results.isEmpty) {
      emit(SearchEmpty(query));
    } else {
      emit(SearchLoaded(results, query));
    }
  }
}
