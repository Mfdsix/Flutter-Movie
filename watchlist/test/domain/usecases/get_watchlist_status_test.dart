import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/domain/usecases/get_watchlist_status.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockWatchlistRepository mockWatchlistRepository;

  setUp(() {
    mockWatchlistRepository = MockWatchlistRepository();
  });

  test('should get watchlist status from repository', () async {
    // arrange
    final usecase = GetWatchlistStatus(mockWatchlistRepository);
    when(mockWatchlistRepository.isAddedToWatchlist(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });

  test('should get tv watchlist status from repository', () async {
    // arrange
    final usecase = GetWatchlistStatus(mockWatchlistRepository);
    when(mockWatchlistRepository.isAddedToWatchlist(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}
