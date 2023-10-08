import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';

import '../../domain/entities/movie_detail.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState>{
  final GetMovieDetail _getMovieDetail;
  final GetMovieRecommendations _getMovieRecommendations;
  final GetMovieWatchlistStatus _getWatchListStatus;
  final SaveMovieToWatchlist _saveWatchlist;
  final RemoveMovieFromWatchlist _removeWatchlist;

  MovieDetailBloc(this._getMovieDetail, this._getMovieRecommendations, this._getWatchListStatus, this._saveWatchlist, this._removeWatchlist) : super(MovieDetailEmpty()) {
    on<OnFetchMovieDetail>((event, emit) async {
      final movieId = event.movieId;

      emit(MovieDetailLoading());
      final result = await _getMovieDetail.execute(movieId);
      final recommendations = await _getMovieRecommendations.execute(movieId);

      result.fold(
        (failure) {
          emit(MovieDetailError(failure.message));
        },
        (movie) {
          emit(MovieDetailHasData(movie));

          recommendations.fold(
              (failure) {
                emit(MovieDetailError(failure.message));
              },
              (recommendations) {
                emit(MovieRecommendationHasData(recommendations));
              }
          );
        }
      );
    });

    on<OnAddWatchlist>((event, emit) async {
      final movie = event.movieDetail;

      final result = await _saveWatchlist.execute(movie);

      result.fold(
          (failure) {
            emit(AddWatchlistFailed());
          },
          (successMessage) {
            emit(AddWatchlistSuccess());
          }
      );

      add(OnLoadWatchlistStatus(movie.id));
    });

    on<OnRemoveWatchlist>((event, emit) async {
      final movie = event.movieDetail;

      final result = await _removeWatchlist.execute(movie);

      result.fold(
              (failure) {
            emit(RemoveWatchlistFailed());
          },
              (successMessage) {
            emit(RemoveWatchlistSuccess());
          }
      );

      add(OnLoadWatchlistStatus(movie.id));
    });

    on<OnLoadWatchlistStatus>((event, emit) async {
      final movieId = event.movieId;

      final result = await _getWatchListStatus.execute(movieId);
      emit(WatchlistStatusFetched(result));
    });
  }
}