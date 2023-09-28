import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/watchlist/get_watchlist_movies.dart';
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

  test('should get list of movies from the repository', () async {
    // arrange
    final usecase = GetWatchlistMovies(mockMovieRepository);
    when(mockMovieRepository.getWatchlistMovies())
        .thenAnswer((_) async => Right(testMovieList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testMovieList));
  });

  test('should get list of tv from the repository', () async {
    // arrange
    final usecase = GetWatchlistTvs(mockTvRepository);
    when(mockTvRepository.getWatchlistTvs())
        .thenAnswer((_) async => Right(testTvList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTvList));
  });
}
