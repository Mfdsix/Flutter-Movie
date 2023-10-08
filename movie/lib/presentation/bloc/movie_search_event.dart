part of 'movie_search_bloc.dart';

abstract class MovieSearchEvent extends Equatable {
  const MovieSearchEvent();

  @override
  List<Object> get props => [];
}

class OnSearchMovies extends MovieSearchEvent {
  final String query;

  const OnSearchMovies(this.query);

  @override
  List<Object> get props => [];
}