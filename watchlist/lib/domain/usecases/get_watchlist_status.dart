import 'package:watchlist/domain/repositories/watchlist_repository.dart';

class GetWatchlistStatus {
  final WatchlistRepository repository;

  GetWatchlistStatus(this.repository);

  @override
  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
