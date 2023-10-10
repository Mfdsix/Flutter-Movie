part of 'watchlist_toggle_bloc.dart';

abstract class WatchlistToggleEvent extends Equatable {
  const WatchlistToggleEvent();

  @override
  List<Object> get props => [];
}

class OnGetWatchlistStatus extends WatchlistToggleEvent {
  final int watchlistId;

  const OnGetWatchlistStatus(this.watchlistId);

  @override
  List<Object> get props => [watchlistId];
}

class OnAddWatchlist extends WatchlistToggleEvent {
  final WatchlistTable watchlist;

  const OnAddWatchlist(this.watchlist);

  @override
  List<Object> get props => [watchlist];
}

class OnRemoveWatchlist extends WatchlistToggleEvent {
  final WatchlistTable watchlist;

  const OnRemoveWatchlist(this.watchlist);

  @override
  List<Object> get props => [watchlist];
}