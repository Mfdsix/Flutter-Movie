part of 'movie_popular_bloc.dart';

abstract class MoviePopularState extends Equatable {
  const MoviePopularState();

  @override
  List<Object> get props => [];
}

class PopularMoviesEmpty extends MoviePopularState {}
class PopularMoviesLoading extends MoviePopularState {}

class PopularMoviesError extends MoviePopularState {
  final String message;

  const PopularMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularMoviesHasData extends MoviePopularState {
  final List<Movie> result;

  const PopularMoviesHasData(this.result);

  @override
  List<Object> get props => [result];
}