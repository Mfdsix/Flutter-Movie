import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/domain/entities/tv.dart';
import 'package:watchlist/domain/usecases/get_watchlist.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState>{
  final GetWatchlist _getWatchlist;

  WatchlistTvBloc(
      this._getWatchlist,
      ) : super(WatchlistTvEmpty()){
        on<OnFetchWatchlistTv>((event, emit) async {
          emit(WatchlistTvLoading());

          final result = await _getWatchlist.execute("tv");
          result.fold(
            (failure){
              emit(WatchlistTvError(failure.message));
            },
            (tvs){
              emit(WatchlistTvHasData(tvs.map((e) => e.toTvEntity()).toList()));
            },
            );
        });
      }
}

mixin GetWatchlis {
}

