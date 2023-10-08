part of 'tv_detail_bloc.dart';

abstract class TvDetailState extends Equatable {
  const TvDetailState();

  @override
  List<Object> get props => [];
}

class TvDetailEmpty extends TvDetailState {}
class TvDetailLoading extends TvDetailState {}

class TvDetailError extends TvDetailState {
  final String message;

  const TvDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class TvDetailHasData extends TvDetailState {
  final TvDetail result;

  const TvDetailHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TvRecommendationHasData extends TvDetailState {
  final List<Tv> recommendations;

  const TvRecommendationHasData(this.recommendations);

  @override
  List<Object> get props => [recommendations];
}

class AddWatchlistSuccess extends TvDetailState {}
class AddWatchlistFailed extends TvDetailState {}

class RemoveWatchlistSuccess extends TvDetailState {}
class RemoveWatchlistFailed extends TvDetailState {}

class WatchlistStatusFetched extends TvDetailState {
  final bool watchlistStatus;

  const WatchlistStatusFetched(this.watchlistStatus);

  @override
  List<Object> get props => [watchlistStatus];
}