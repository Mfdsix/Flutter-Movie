import 'package:core/common/exception.dart';
import 'package:watchlist/data/datasources/helpers/database_helper.dart';
import 'package:watchlist/data/models/watchlist_table.dart';

abstract class WatchlistLocalDataSource {
  Future<String> insertWatchlist(WatchlistTable watchlist);
  Future<String> removeWatchlist(WatchlistTable watchlist);
  Future<WatchlistTable?> getMovieById(int id);
  Future<List<WatchlistTable>> getWatchlistMovies([String type = 'movie']);
}

class WatchlistLocalDataSourceImpl implements WatchlistLocalDataSource {
  final DatabaseHelper databaseHelper;

  WatchlistLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(WatchlistTable watchlist) async {
    try {
      await databaseHelper.insertWatchlist(watchlist);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(WatchlistTable watchlist) async {
    try {
      await databaseHelper.removeWatchlist(watchlist);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<WatchlistTable?> getMovieById(int id) async {
    final result = await databaseHelper.getWatchlistById(id);
    if (result != null) {
      return WatchlistTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<WatchlistTable>> getWatchlistMovies([String type = "movie"]) async {
    final result = await databaseHelper.getWatchlistByType(type);
    return result.map((data) => WatchlistTable.fromMap(data)).toList();
  }
}
