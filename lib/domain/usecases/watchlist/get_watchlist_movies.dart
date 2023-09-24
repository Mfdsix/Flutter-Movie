import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

abstract class GetWatchlist {
  execute();
}

class GetWatchlistMovies implements GetWatchlist {
  final MovieRepository _repository;

  GetWatchlistMovies(this._repository);

  @override
  Future<Either<Failure, List<Movie>>> execute() {
    return _repository.getWatchlistMovies();
  }
}

class GetWatchlistTvs implements GetWatchlist {
  final TvRepository _repository;

  GetWatchlistTvs(this._repository);

  @override
  Future<Either<Failure, List<Tv>>> execute() {
    return _repository.getWatchlistTvs();
  }
}
