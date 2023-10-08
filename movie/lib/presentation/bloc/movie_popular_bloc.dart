import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';

part 'movie_popular_event.dart';
part 'movie_popular_state.dart';

class MoviePopularBloc extends Bloc<MoviePopularEvent, MoviePopularState>{
  final GetPopularMovies _getPopularMovies;

  MoviePopularBloc(
      this._getPopularMovies,
      ) : super(PopularMoviesEmpty()) {
        on<OnFetchPopularMovies>((event, emit) async {
          emit(PopularMoviesLoading());

          final result = await _getPopularMovies.execute();
          result.fold(
            (failure){
              emit(PopularMoviesError(failure.message));
            },
            (movies){
              emit(PopularMoviesHasData(movies));
            },
            );
        });
      }
}

