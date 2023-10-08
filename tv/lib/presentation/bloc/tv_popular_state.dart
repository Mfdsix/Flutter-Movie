part of 'tv_popular_bloc.dart';

abstract class TvPopularState extends Equatable {
  const TvPopularState();

  @override
  List<Object> get props => [];
}

class PopularTvsEmpty extends TvPopularState {}
class PopularTvsLoading extends TvPopularState {}

class PopularTvsError extends TvPopularState {
  final String message;

  const PopularTvsError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularTvsHasData extends TvPopularState {
  final List<Tv> result;

  const PopularTvsHasData(this.result);

  @override
  List<Object> get props => [result];
}