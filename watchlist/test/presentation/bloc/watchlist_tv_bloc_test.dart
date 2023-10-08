import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/watchlist.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlist])
void main(){
  late WatchlistTvBloc bloc;
  late MockGetWatchlist mockGetWatchlistTvs;

  setUp(() {
    mockGetWatchlistTvs = MockGetWatchlist();
    bloc = WatchlistTvBloc(mockGetWatchlistTvs);
  });

  group('Get Watchlist Tv', () {
    test('initial state should be empty', () {
      expect(bloc.state, WatchlistTvEmpty());
    });

    blocTest<WatchlistTvBloc, WatchlistTvState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetWatchlistTvs.execute('tv'))
              .thenAnswer((_) async => Right(testWatchlists));

          return bloc;
        },
        act: (bloc) => bloc.add(const OnFetchWatchlistTv()),
        wait: const Duration(microseconds: 100),
        expect: () =>
        [WatchlistTvLoading(), WatchlistTvHasData(tvs)],
        verify: (bloc) {
          verify(mockGetWatchlistTvs.execute('tv'));
        });

    blocTest<WatchlistTvBloc, WatchlistTvState>(
        'Should emit [Loading, Error] when failed',
        build: () {
          when(mockGetWatchlistTvs.execute('tv'))
              .thenAnswer((_) async => Left(ServerFailure("server error")));

          return bloc;
        },
        act: (bloc) => bloc.add(const OnFetchWatchlistTv()),
        wait: const Duration(microseconds: 100),
        expect: () =>
        [WatchlistTvLoading(), const WatchlistTvError("server error")],
        verify: (bloc) {
          verify(mockGetWatchlistTvs.execute('tv'));
        });
  });
}