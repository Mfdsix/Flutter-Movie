import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/watchlist/get_watchlist.dart';
import 'package:ditonton/presentation/bloc/watchlist/watchlist_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../provider/watchlist/watchlist_movie_notifier_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main(){
  late WatchlistMovieBloc bloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    bloc = WatchlistMovieBloc(mockGetWatchlistMovies);
  });

  group('Get Watchlist Movie', () {
    test('initial state should be empty', () {
      expect(bloc.state, WatchlistMovieEmpty());
    });

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetWatchlistMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));

          return bloc;
        },
        act: (bloc) => bloc.add(const OnFetchWatchlistMovie()),
        wait: const Duration(microseconds: 100),
        expect: () =>
        [WatchlistMovieLoading(), WatchlistMovieHasData(tMovieList)],
        verify: (bloc) {
          verify(mockGetWatchlistMovies.execute());
        });

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'Should emit [Loading, Error] when failed',
        build: () {
          when(mockGetWatchlistMovies.execute())
              .thenAnswer((_) async => Left(ServerFailure("server error")));

          return bloc;
        },
        act: (bloc) => bloc.add(const OnFetchWatchlistMovie()),
        wait: const Duration(microseconds: 100),
        expect: () =>
        [WatchlistMovieLoading(), const WatchlistMovieError("server error")],
        verify: (bloc) {
          verify(mockGetWatchlistMovies.execute());
        });
  });
}