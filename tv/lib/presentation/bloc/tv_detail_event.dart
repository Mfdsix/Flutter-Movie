part of 'tv_detail_bloc.dart';

abstract class TvDetailEvent extends Equatable {
  const TvDetailEvent();

  @override
  List<Object> get props => [];
}

class OnFetchTvDetail extends TvDetailEvent {
  final int tvId;

  const OnFetchTvDetail(this.tvId);

  @override
  List<Object> get props => [tvId];
}