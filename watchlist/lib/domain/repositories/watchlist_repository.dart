import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:watchlist/domain/entities/watchlist_table.dart';

abstract class WatchlistRepository {
  Future<Either<Failure, List<WatchlistTable>>> getWatchlistByType(String type);
  Future<Either<Failure, String>> saveToWatchlist(WatchlistTable tv);
  Future<Either<Failure, String>> removeFromWatchlist(WatchlistTable tv);
  Future<bool> isAddedToWatchlist(int watchlistId);
}