import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_now_playing_event.dart';
part 'movie_now_playing_state.dart';

class MovieNowPlayingBloc extends Bloc<MovieNowPlayingEvent, MovieNowPlayingState>{
  final GetNowPlayingMovies _getNowPlayingMovies;

  MovieNowPlayingBloc(
      this._getNowPlayingMovies,
      ) : super(NowPlayingMoviesEmpty()){
        on<OnFetchNowPlayingMovies>((event, emit) async {
          emit(NowPlayingMoviesLoading());

          final result = await _getNowPlayingMovies.execute();
          result.fold(
            (failure){
              emit(NowPlayingMoviesError(failure.message));
            },
            (movies){
              emit(NowPlayingMoviesHasData(movies));
            },
            );
        });
      }
}

