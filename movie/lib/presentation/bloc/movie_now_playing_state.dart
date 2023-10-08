part of 'movie_now_playing_bloc.dart';

abstract class MovieNowPlayingState extends Equatable {
  const MovieNowPlayingState();

  @override
  List<Object> get props => [];
}

class NowPlayingMoviesEmpty extends MovieNowPlayingState {}
class NowPlayingMoviesLoading extends MovieNowPlayingState {}

class NowPlayingMoviesError extends MovieNowPlayingState {
  final String message;

  const NowPlayingMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingMoviesHasData extends MovieNowPlayingState {
  final List<Movie> result;

  const NowPlayingMoviesHasData(this.result);

  @override
  List<Object> get props => [result];
}