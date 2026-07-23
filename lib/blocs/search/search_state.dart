import 'package:equatable/equatable.dart';
import '../../data/models/lesson.dart';

abstract class SearchState extends Equatable {
  const SearchState();
  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {
  const SearchInitial();
}

class SearchLoading extends SearchState {
  const SearchLoading();
}

class SearchLoaded extends SearchState {
  final List<Lesson> results;
  final String query;
  const SearchLoaded(this.results, this.query);
  @override
  List<Object?> get props => [results, query];
}

class SearchEmpty extends SearchState {
  final String query;
  const SearchEmpty(this.query);
  @override
  List<Object?> get props => [query];
}
