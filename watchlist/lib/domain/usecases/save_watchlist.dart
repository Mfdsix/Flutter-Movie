import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:watchlist/domain/entities/watchlist_table.dart';
import 'package:watchlist/domain/repositories/watchlist_repository.dart';

class SaveWatchlist{
  final WatchlistRepository repository;

  SaveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(WatchlistTable watchlistTable) {
    return repository.saveToWatchlist(watchlistTable);
  }
}
