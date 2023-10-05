part of 'movie_top_rated_bloc.dart';

abstract class MovieTopRatedEvent extends Equatable {
  const MovieTopRatedEvent();

  @override
  List<Object> get props => [];
}

class OnFetchTopRatedMovies extends MovieTopRatedEvent {
  const OnFetchTopRatedMovies();

  @override
  List<Object> get props => [];
}