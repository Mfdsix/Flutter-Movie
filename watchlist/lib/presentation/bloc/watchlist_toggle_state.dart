part of 'watchlist_toggle_bloc.dart';

abstract class WatchlistToggleState extends Equatable {
  const WatchlistToggleState();

  @override
  List<Object> get props => [];
}

class AddWatchlistSuccess extends WatchlistToggleState {}
class AddWatchlistFailed extends WatchlistToggleState {}

class RemoveWatchlistSuccess extends WatchlistToggleState {}
class RemoveWatchlistFailed extends WatchlistToggleState {}

class WatchlistStatusLoading extends WatchlistToggleState {}
class WatchlistStatusFetched extends WatchlistToggleState {
  final bool watchlistStatus;

  const WatchlistStatusFetched(this.watchlistStatus);

  @override
  List<Object> get props => [watchlistStatus];
}