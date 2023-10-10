part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class OnFetchMovieDetail extends MovieDetailEvent {
  final int movieId;

  const OnFetchMovieDetail(this.movieId);

  @override
  List<Object> get props => [movieId];
}