import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/watchlist/get_watchlist_movies.dart';
import 'package:ditonton/presentation/bloc/watchlist/watchlist_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../provider/watchlist/watchlist_tv_notifier_test.mocks.dart';

@GenerateMocks([GetWatchlistTvs])
void main(){
  late WatchlistTvBloc bloc;
  late MockGetWatchlistTvs mockGetWatchlistTvs;

  setUp(() {
    mockGetWatchlistTvs = MockGetWatchlistTvs();
    bloc = WatchlistTvBloc(mockGetWatchlistTvs);
  });

  group('Get Watchlist Tv', () {
    test('initial state should be empty', () {
      expect(bloc.state, WatchlistTvEmpty());
    });

    blocTest<WatchlistTvBloc, WatchlistTvState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetWatchlistTvs.execute())
              .thenAnswer((_) async => Right(tvs));

          return bloc;
        },
        act: (bloc) => bloc.add(const OnFetchWatchlistTv()),
        wait: const Duration(microseconds: 100),
        expect: () =>
        [WatchlistTvLoading(), WatchlistTvHasData(tvs)],
        verify: (bloc) {
          verify(mockGetWatchlistTvs.execute());
        });

    blocTest<WatchlistTvBloc, WatchlistTvState>(
        'Should emit [Loading, Error] when failed',
        build: () {
          when(mockGetWatchlistTvs.execute())
              .thenAnswer((_) async => Left(ServerFailure("server error")));

          return bloc;
        },
        act: (bloc) => bloc.add(const OnFetchWatchlistTv()),
        wait: const Duration(microseconds: 100),
        expect: () =>
        [WatchlistTvLoading(), const WatchlistTvError("server error")],
        verify: (bloc) {
          verify(mockGetWatchlistTvs.execute());
        });
  });
}