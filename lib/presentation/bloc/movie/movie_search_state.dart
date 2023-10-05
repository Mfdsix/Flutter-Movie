part of 'movie_search_bloc.dart';

abstract class MovieSearchState extends Equatable {
  const MovieSearchState();

  @override
  List<Object> get props => [];
}

class SearchMoviesEmpty extends MovieSearchState {}
class SearchMoviesLoading extends MovieSearchState {}

class SearchMoviesError extends MovieSearchState {
  final String message;

  const SearchMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchMoviesHasData extends MovieSearchState {
  final List<Movie> result;

  const SearchMoviesHasData(this.result);

  @override
  List<Object> get props => [result];
}