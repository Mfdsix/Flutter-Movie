import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/watchlist.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlist])
void main(){
  late WatchlistMovieBloc bloc;
  late MockGetWatchlist mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlist();
    bloc = WatchlistMovieBloc(mockGetWatchlistMovies);
  });

  group('Get Watchlist Movie', () {
    test('initial state should be empty', () {
      expect(bloc.state, WatchlistMovieEmpty());
    });

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetWatchlistMovies.execute('movie'))
              .thenAnswer((_) async => Right(testWatchlists));

          return bloc;
        },
        act: (bloc) => bloc.add(const OnFetchWatchlistMovie()),
        wait: const Duration(microseconds: 100),
        expect: () =>
        [WatchlistMovieLoading(), WatchlistMovieHasData(tMovieList)],
        verify: (bloc) {
          verify(mockGetWatchlistMovies.execute('movie'));
        });

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'Should emit [Loading, Error] when failed',
        build: () {
          when(mockGetWatchlistMovies.execute('movie'))
              .thenAnswer((_) async => Left(ServerFailure("server error")));

          return bloc;
        },
        act: (bloc) => bloc.add(const OnFetchWatchlistMovie()),
        wait: const Duration(microseconds: 100),
        expect: () =>
        [WatchlistMovieLoading(), const WatchlistMovieError("server error")],
        verify: (bloc) {
          verify(mockGetWatchlistMovies.execute('movie'));
        });
  });
}