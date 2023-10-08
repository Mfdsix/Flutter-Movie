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

class OnAddWatchlist extends MovieDetailEvent {
  final MovieDetail movieDetail;

  const OnAddWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class OnRemoveWatchlist extends MovieDetailEvent {
  final MovieDetail movieDetail;

  const OnRemoveWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class OnLoadWatchlistStatus extends MovieDetailEvent {
  final int movieId;

  const OnLoadWatchlistStatus(this.movieId);

  @override
  List<Object> get props => [movieId];
}