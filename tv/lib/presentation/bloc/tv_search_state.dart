part of 'tv_search_bloc.dart';

abstract class TvSearchState extends Equatable {
  const TvSearchState();

  @override
  List<Object> get props => [];
}

class SearchTvsEmpty extends TvSearchState {}
class SearchTvsLoading extends TvSearchState {}

class SearchTvsError extends TvSearchState {
  final String message;

  const SearchTvsError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchTvsHasData extends TvSearchState {
  final List<Tv> result;

  const SearchTvsHasData(this.result);

  @override
  List<Object> get props => [result];
}