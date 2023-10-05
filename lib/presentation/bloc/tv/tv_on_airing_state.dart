part of 'tv_on_airing_bloc.dart';

abstract class TvOnAiringState extends Equatable {
  const TvOnAiringState();

  @override
  List<Object> get props => [];
}

class OnAiringTvEmpty extends TvOnAiringState {}
class OnAiringTvLoading extends TvOnAiringState {}

class OnAiringTvError extends TvOnAiringState {
  final String message;

  const OnAiringTvError(this.message);

  @override
  List<Object> get props => [message];
}

class OnAiringTvHasData extends TvOnAiringState {
  final List<Tv> result;

  const OnAiringTvHasData(this.result);

  @override
  List<Object> get props => [result];
}