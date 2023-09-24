import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';

abstract class TVRepository {
  Future<Either<Failure, List<Tv>>> getNowPlayingTvs();
  Future<Either<Failure, List<Tv>>> getPopularTvs();
  Future<Either<Failure, List<Tv>>> getTopRatedTvs();
  Future<Either<Failure, TvDetail>> getDetailTv();
  Future<Either<Failure, List<Tv>>> getRecommendationTvs();
  Future<Either<Failure, List<Tv>>> searchTvs();
  Future<Either<Failure, String>> saveWatchlist(TvDetail tv);
  Future<Either<Failure, String>> removeWatchlist(String tvId);
  Future<Either<Failure, bool>> isAddedToWatchlist(String tvId);
  Future<Either<Failure, List<Tv>>> getWatchlistTvs();
}