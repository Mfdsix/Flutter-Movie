import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/watchlist/get_watchlist_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState>{
  final GetWatchlistTvs _getWatchlistTvs;

  WatchlistTvBloc(
      this._getWatchlistTvs,
      ) : super(WatchlistTvEmpty()){
        on<OnFetchWatchlistTv>((event, emit) async {
          emit(WatchlistTvLoading());

          final result = await _getWatchlistTvs.execute();
          result.fold(
            (failure){
              emit(WatchlistTvError(failure.message));
            },
            (tvs){
              emit(WatchlistTvHasData(tvs));
            },
            );
        });
      }
}

