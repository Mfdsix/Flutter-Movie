import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:watchlist/data/models/watchlist_table.dart';
import 'package:watchlist/domain/repositories/watchlist_repository.dart';

class RemoveWatchlist{
  final WatchlistRepository repository;

  RemoveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(WatchlistTable watchlistTable) {
    return repository.removeFromWatchlist(watchlistTable);
  }
}
