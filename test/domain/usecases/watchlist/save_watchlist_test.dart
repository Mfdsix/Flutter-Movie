import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/watchlist/save_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockMovieRepository mockMovieRepository;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    mockTvRepository = MockTvRepository();
  });

  test('should save movie to the repository', () async {
    // arrange
    final usecase = SaveMovieToWatchlist(mockMovieRepository);
    when(mockMovieRepository.saveWatchlist(testMovieDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testMovieDetail);
    // assert
    verify(mockMovieRepository.saveWatchlist(testMovieDetail));
    expect(result, Right('Added to Watchlist'));
  });

  test('should save tv to the repository', () async {
    // arrange
    final usecase = SaveTvToWatchlist(mockTvRepository);
    when(mockTvRepository.saveWatchlist(testTvDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTvDetail);
    // assert
    verify(mockTvRepository.saveWatchlist(testTvDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
