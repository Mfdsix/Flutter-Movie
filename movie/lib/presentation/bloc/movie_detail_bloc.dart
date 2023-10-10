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

  MovieDetailBloc(this._getMovieDetail, this._getMovieRecommendations) : super(MovieDetailEmpty()) {
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
          recommendations.fold(
              (failure) {
                emit(MovieDetailError(failure.message));
              },
              (recommendations) {
                emit(MovieDetailHasData(movie, recommendations));
              }
          );
        }
      );
    });
  }
}