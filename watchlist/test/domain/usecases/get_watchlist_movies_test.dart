import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/domain/usecases/get_watchlist.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockWatchlistRepository mockWatchlistRepository;

  setUp(() {
    mockWatchlistRepository = MockWatchlistRepository();
  });

  test('should get list of movies from the repository', () async {
    // arrange
    final usecase = GetWatchlist(mockWatchlistRepository);
    when(mockWatchlistRepository.getWatchlistByType('movie'))
        .thenAnswer((_) async => Right(testWatchlists));
    // act
    final result = await usecase.execute('movie');
    // assert
    expect(result, Right(testWatchlists));
  });

  test('should get list of tv from the repository', () async {
    // arrange
    final usecase = GetWatchlist(mockWatchlistRepository);
    when(mockWatchlistRepository.getWatchlistByType('tv'))
        .thenAnswer((_) async => Right(testWatchlists));
    // act
    final result = await usecase.execute('tv');
    // assert
    expect(result, Right(testWatchlists));
  });
}
