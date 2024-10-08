part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieEvent extends Equatable {
  const WatchlistMovieEvent();

  @override
  List<Object> get props => [];
}

class OnFetchWatchlistMovie extends WatchlistMovieEvent {
  const OnFetchWatchlistMovie();

  @override
  List<Object> get props => [];
}