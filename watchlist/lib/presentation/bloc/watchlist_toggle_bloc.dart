import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/domain/entities/watchlist_table.dart';
import 'package:watchlist/domain/usecases/get_watchlist_status.dart';
import 'package:watchlist/domain/usecases/remove_watchlist.dart';
import 'package:watchlist/domain/usecases/save_watchlist.dart';

part 'watchlist_toggle_event.dart';
part 'watchlist_toggle_state.dart';

class WatchlistToggleBloc extends Bloc<WatchlistToggleEvent, WatchlistToggleState>{
  final GetWatchlistStatus _getWatchListStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;

  WatchlistToggleBloc(this._getWatchListStatus, this._saveWatchlist, this._removeWatchlist) : super(const WatchlistStatusFetched(false)) {
    on<OnAddWatchlist>((event, emit) async {
      final watchlist = event.watchlist;

      final result = await _saveWatchlist.execute(watchlist);

      result.fold(
              (failure) {
            emit(AddWatchlistFailed());
          },
              (successMessage) {
            emit(AddWatchlistSuccess());
          }
      );

      add(OnGetWatchlistStatus(watchlist.id));
    });

    on<OnRemoveWatchlist>((event, emit) async {
      final watchlist = event.watchlist;

      final result = await _removeWatchlist.execute(watchlist);

      result.fold(
              (failure) {
            emit(RemoveWatchlistFailed());
          },
              (successMessage) {
            emit(RemoveWatchlistSuccess());
          }
      );

      add(OnGetWatchlistStatus(watchlist.id));
    });

    on<OnGetWatchlistStatus>((event, emit) async {
      final movieId = event.watchlistId;

      final result = await _getWatchListStatus.execute(movieId);
      emit(WatchlistStatusFetched(result));
    });
  }
}