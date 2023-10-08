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
  final GetTvWatchlistStatus _getWatchListStatus;
  final SaveTvToWatchlist _saveWatchlist;
  final RemoveTvFromWatchlist _removeWatchlist;

  TvDetailBloc(this._getTvDetail, this._getMovieRecommendations, this._getWatchListStatus, this._saveWatchlist, this._removeWatchlist) : super(TvDetailEmpty()) {
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
          emit(TvDetailHasData(movie));

          recommendations.fold(
              (failure) {
                emit(TvDetailError(failure.message));
              },
              (recommendations) {
                emit(TvRecommendationHasData(recommendations));
              }
          );
        }
      );
    });

    on<OnAddWatchlist>((event, emit) async {
      final tv = event.tvDetail;

      final result = await _saveWatchlist.execute(tv);

      result.fold(
          (failure) {
            emit(AddWatchlistFailed());
          },
          (successMessage) {
            emit(AddWatchlistSuccess());
          }
      );

      add(OnLoadWatchlistStatus(tv.id));
    });

    on<OnRemoveWatchlist>((event, emit) async {
      final tv = event.tvDetail;

      final result = await _removeWatchlist.execute(tv);

      result.fold(
              (failure) {
            emit(RemoveWatchlistFailed());
          },
              (successMessage) {
            emit(RemoveWatchlistSuccess());
          }
      );

      add(OnLoadWatchlistStatus(tv.id));
    });

    on<OnLoadWatchlistStatus>((event, emit) async {
      final tvId = event.tvId;

      final result = await _getWatchListStatus.execute(tvId);
      emit(WatchlistStatusFetched(result));
    });
  }
}