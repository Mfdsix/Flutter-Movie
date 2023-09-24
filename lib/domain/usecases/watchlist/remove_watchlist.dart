import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

abstract class RemoveWatchlist {
  execute(int id);
}

class RemoveMovieWatchlist{
  final MovieRepository repository;

  RemoveMovieWatchlist(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.removeWatchlist(movie);
  }
}

class RemoveTvWatchlist implements RemoveWatchlist{
  final TvRepository repository;

  RemoveTvWatchlist(this.repository);

  @override
  Future<Either<Failure, String>> execute(int id) {
    return repository.removeWatchlist(id);
  }
}
