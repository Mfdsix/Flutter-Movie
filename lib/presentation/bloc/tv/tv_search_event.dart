part of 'tv_search_bloc.dart';

abstract class TvSearchEvent extends Equatable {
  const TvSearchEvent();

  @override
  List<Object> get props => [];
}

class OnSearchTv extends TvSearchEvent {
  final String query;

  const OnSearchTv(this.query);

  @override
  List<Object> get props => [];
}