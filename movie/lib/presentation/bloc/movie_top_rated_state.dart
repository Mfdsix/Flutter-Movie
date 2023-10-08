part of 'movie_top_rated_bloc.dart';

abstract class MovieTopRatedState extends Equatable {
  const MovieTopRatedState();

  @override
  List<Object> get props => [];
}

class TopRatedMoviesEmpty extends MovieTopRatedState {}
class TopRatedMoviesLoading extends MovieTopRatedState {}

class TopRatedMoviesError extends MovieTopRatedState {
  final String message;

  const TopRatedMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedMoviesHasData extends MovieTopRatedState {
  final List<Movie> result;

  const TopRatedMoviesHasData(this.result);

  @override
  List<Object> get props => [result];
}