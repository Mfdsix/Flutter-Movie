import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/domain/usecases/remove_watchlist.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockWatchlistRepository mockWatchlistRepository;

  setUp(() {
    mockWatchlistRepository = MockWatchlistRepository();
  });

  test('should remove watchlist movie from repository', () async {
    // arrange
    final usecase = RemoveWatchlist(mockWatchlistRepository);
    when(mockWatchlistRepository.removeFromWatchlist(testWatchlist))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testWatchlist);
    // assert
    verify(mockWatchlistRepository.removeFromWatchlist(testWatchlist));
    expect(result, Right('Removed from watchlist'));
  });

  test('should remove watchlist tv from repository', () async {
    // arrange
    final usecase = RemoveWatchlist(mockWatchlistRepository);
    when(mockWatchlistRepository.removeFromWatchlist(testWatchlist))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testWatchlist);
    // assert
    verify(mockWatchlistRepository.removeFromWatchlist(testWatchlist));
    expect(result, Right('Removed from watchlist'));
  });
}
