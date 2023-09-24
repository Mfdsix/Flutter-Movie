import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_recommendation_tvs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetRecommendationTvs usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetRecommendationTvs(mockTvRepository);
  });

  const tvId = 1;
  final tvs = <Tv>[];

  test('should get list of tv recommendations from the repository',
      () async {
    // arrange
    when(mockTvRepository.getRecommendationTvs(tvId))
        .thenAnswer((_) async => Right(tvs));
    // act
    final result = await usecase.execute(tvId);
    // assert
    expect(result, Right(tvs));
  });
}
