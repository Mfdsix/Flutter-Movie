import 'package:watchlist/domain/entities/watchlist_table.dart';
import 'package:movie/domain/entities/movie_detail.dart';

class Convert {
  static WatchlistTable movieToWatchlist(MovieDetail data) {
    return WatchlistTable(
      id: data.id,
      title: data.title,
      posterPath: data.posterPath,
      overview: data.overview,
      type: "movie");
  }
}