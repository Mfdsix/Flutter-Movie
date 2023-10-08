import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/domain/entities/movie.dart';
import 'package:watchlist/domain/usecases/get_watchlist.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc extends Bloc<WatchlistMovieEvent, WatchlistMovieState>{
  final GetWatchlist _getWatchlist;

  WatchlistMovieBloc(
      this._getWatchlist,
      ) : super(WatchlistMovieEmpty()){
        on<OnFetchWatchlistMovie>((event, emit) async {
          emit(WatchlistMovieLoading());

          final result = await _getWatchlist.execute("movie");
          result.fold(
            (failure){
              emit(WatchlistMovieError(failure.message));
            },
            (movies){
              emit(WatchlistMovieHasData(movies.map((e) => e.toMovieEntity()).toList()));
            },
            );
        });
      }
}

