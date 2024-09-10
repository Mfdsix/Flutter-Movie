import 'package:core/common/exception.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:watchlist/data/datasources/local/watchlist_local_data_source.dart';
import 'package:watchlist/domain/entities/watchlist_table.dart';
import 'package:watchlist/domain/repositories/watchlist_repository.dart';

class WatchlistRepositoryImpl implements WatchlistRepository {
  final WatchlistLocalDataSource localDataSource;

  WatchlistRepositoryImpl({
    required this.localDataSource
  });

  @override
  Future<Either<Failure, List<WatchlistTable>>> getWatchlistByType(String type) async {
    final result = await localDataSource.getWatchlistMovies(type);
    return Right(result);
  }

  @override
  Future<bool> isAddedToWatchlist(int watchlistId) async {
    final result = await localDataSource.getMovieById(watchlistId);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeFromWatchlist(WatchlistTable watchlistTable) async {
    try {
      final result =
          await localDataSource.removeWatchlist(watchlistTable);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveToWatchlist(WatchlistTable watchlistTable) async {
    try {
      final result =
          await localDataSource.insertWatchlist(watchlistTable);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }}