part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailEmpty extends MovieDetailState {}
class MovieDetailLoading extends MovieDetailState {}

class MovieDetailError extends MovieDetailState {
  final String message;

  const MovieDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieDetailHasData extends MovieDetailState {
  final MovieDetail result;

  const MovieDetailHasData(this.result);

  @override
  List<Object> get props => [result];
}

class MovieRecommendationHasData extends MovieDetailState {
  final List<Movie> recommendations;

  const MovieRecommendationHasData(this.recommendations);

  @override
  List<Object> get props => [recommendations];
}

class AddWatchlistSuccess extends MovieDetailState {}
class AddWatchlistFailed extends MovieDetailState {}

class RemoveWatchlistSuccess extends MovieDetailState {}
class RemoveWatchlistFailed extends MovieDetailState {}

class WatchlistStatusFetched extends MovieDetailState {
  final bool watchlistStatus;

  const WatchlistStatusFetched(this.watchlistStatus);

  @override
  List<Object> get props => [watchlistStatus];
}