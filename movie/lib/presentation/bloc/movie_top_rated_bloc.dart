import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';

part 'movie_top_rated_event.dart';
part 'movie_top_rated_state.dart';

class MovieTopRatedBloc extends Bloc<MovieTopRatedEvent, MovieTopRatedState>{
  final GetTopRatedMovies _getTopRatedMovies;

  MovieTopRatedBloc(
      this._getTopRatedMovies,
      ) : super(TopRatedMoviesEmpty()) {
        on<OnFetchTopRatedMovies>((event, emit) async {
          emit(TopRatedMoviesLoading());

          final result = await _getTopRatedMovies.execute();
          result.fold(
            (failure){
              emit(TopRatedMoviesError(failure.message));
            },
            (movies){
              emit(TopRatedMoviesHasData(movies));
            },
            );
        });
      }
}

