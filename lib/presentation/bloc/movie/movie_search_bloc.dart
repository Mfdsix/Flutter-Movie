import 'package:ditonton/common/debounce.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movie/search_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_search_event.dart';
part 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState>{
  final SearchMovies _getSearchMovies;

  MovieSearchBloc(
      this._getSearchMovies,
      ) : super(SearchMoviesEmpty()) {
        on<OnSearchMovies>((event, emit) async {
          final query = event.query;

          emit(SearchMoviesLoading());
          final result = await _getSearchMovies.execute(query);
          result.fold(
            (failure){
              emit(SearchMoviesError(failure.message));
            },
            (movies){
              emit(SearchMoviesHasData(movies));
            },
            );
        }, transformer: debounce(const Duration(microseconds: 500)));
      }
}

