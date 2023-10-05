part of 'tv_detail_bloc.dart';

abstract class TvDetailEvent extends Equatable {
  const TvDetailEvent();

  @override
  List<Object> get props => [];
}

class OnFetchTvDetail extends TvDetailEvent {
  final int tvId;

  const OnFetchTvDetail(this.tvId);

  @override
  List<Object> get props => [tvId];
}

class OnAddWatchlist extends TvDetailEvent {
  final TvDetail tvDetail;

  const OnAddWatchlist(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class OnRemoveWatchlist extends TvDetailEvent {
  final TvDetail tvDetail;

  const OnRemoveWatchlist(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class OnLoadWatchlistStatus extends TvDetailEvent {
  final int tvId;

  const OnLoadWatchlistStatus(this.tvId);

  @override
  List<Object> get props => [tvId];
}