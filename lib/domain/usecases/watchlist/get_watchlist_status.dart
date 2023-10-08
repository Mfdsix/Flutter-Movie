import '../../../../movie/lib/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

abstract class GetWatchlistStatus {
  execute(int id);
}

class GetMovieWatchlistStatus implements GetWatchlistStatus {
  final MovieRepository repository;

  GetMovieWatchlistStatus(this.repository);

  @override
  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}

class GetTvWatchlistStatus implements GetWatchlistStatus {
  final TvRepository repository;

  GetTvWatchlistStatus(this.repository);

  @override
  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
