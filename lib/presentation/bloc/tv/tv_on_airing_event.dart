part of 'tv_on_airing_bloc.dart';

abstract class TvOnAiringEvent extends Equatable {
  const TvOnAiringEvent();

  @override
  List<Object> get props => [];
}

class OnFetchOnAiringTv extends TvOnAiringEvent {
  const OnFetchOnAiringTv();

  @override
  List<Object> get props => [];
}