import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/domain/usecases/save_watchlist.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockWatchlistRepository mockWatchlistRepository;

  setUp(() {
    mockWatchlistRepository = MockWatchlistRepository();
  });

  test('should save movie to the repository', () async {
    // arrange
    final usecase = SaveWatchlist(mockWatchlistRepository);
    when(mockWatchlistRepository.saveToWatchlist(testWatchlist))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testWatchlist);
    // assert
    verify(mockWatchlistRepository.saveToWatchlist(testWatchlist));
    expect(result, Right('Added to Watchlist'));
  });

  test('should save tv to the repository', () async {
    // arrange
    final usecase = SaveWatchlist(mockWatchlistRepository);
    when(mockWatchlistRepository.saveToWatchlist(testWatchlist))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testWatchlist);
    // assert
    verify(mockWatchlistRepository.saveToWatchlist(testWatchlist));
    expect(result, Right('Added to Watchlist'));
  });
}
