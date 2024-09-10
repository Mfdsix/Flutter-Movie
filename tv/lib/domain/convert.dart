import 'package:watchlist/domain/entities/watchlist_table.dart';
import 'package:tv/domain/entities/tv_detail.dart';

class Convert {
  static WatchlistTable tvToWatchlist(TvDetail data){
    return WatchlistTable(
        id: data.id,
        title: data.name,
        posterPath: data.posterPath,
        overview: data.overview,
        type: "tv"
      );
  }
}