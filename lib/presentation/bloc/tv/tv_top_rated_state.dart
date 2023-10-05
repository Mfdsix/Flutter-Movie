part of 'tv_top_rated_bloc.dart';

abstract class TvTopRatedState extends Equatable {
  const TvTopRatedState();

  @override
  List<Object> get props => [];
}

class TopRatedTvsEmpty extends TvTopRatedState {}
class TopRatedTvsLoading extends TvTopRatedState {}

class TopRatedTvsError extends TvTopRatedState {
  final String message;

  const TopRatedTvsError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedTvsHasData extends TvTopRatedState {
  final List<Tv> result;

  const TopRatedTvsHasData(this.result);

  @override
  List<Object> get props => [result];
}