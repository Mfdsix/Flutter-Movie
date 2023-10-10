import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/usecases/get_recommendation_tvs.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState>{
  final GetTvDetail _getTvDetail;
  final GetRecommendationTvs _getMovieRecommendations;

  TvDetailBloc(this._getTvDetail, this._getMovieRecommendations) : super(TvDetailEmpty()) {
    on<OnFetchTvDetail>((event, emit) async {
      final tvId = event.tvId;

      emit(TvDetailLoading());
      final result = await _getTvDetail.execute(tvId);
      final recommendations = await _getMovieRecommendations.execute(tvId);

      result.fold(
        (failure) {
          emit(TvDetailError(failure.message));
        },
        (movie) {

          recommendations.fold(
              (failure) {
                emit(TvDetailError(failure.message));
              },
              (recommendations) {
                emit(TvDetailHasData(movie, recommendations));
              }
          );
        }
      );
    });
  }
}