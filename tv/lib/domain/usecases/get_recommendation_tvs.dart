import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/repositories/tv_repository.dart';

class GetRecommendationTvs{
  final TvRepository repository;

  GetRecommendationTvs(this.repository);

  Future<Either<Failure, List<Tv>>> execute(int tvId){
    return repository.getRecommendationTvs(tvId);
  }
}