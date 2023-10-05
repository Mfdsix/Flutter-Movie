import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:ditonton/presentation/bloc/movie/movie_now_playing_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../provider/movie/movie_list_notifier_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late MovieNowPlayingBloc bloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    bloc = MovieNowPlayingBloc(mockGetNowPlayingMovies);
  });

  group('Get Now Playing Movie', () {
    test('initial state should be empty', () {
      expect(bloc.state, NowPlayingMoviesEmpty());
    });

    blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetNowPlayingMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));

          return bloc;
        },
        act: (bloc) => bloc.add(const OnFetchNowPlayingMovies()),
        wait: const Duration(microseconds: 100),
        expect: () =>
            [NowPlayingMoviesLoading(), NowPlayingMoviesHasData(tMovieList)],
        verify: (bloc) {
          verify(mockGetNowPlayingMovies.execute());
        });

    blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
        'Should emit [Loading, Error] when failed',
        build: () {
          when(mockGetNowPlayingMovies.execute())
              .thenAnswer((_) async => Left(ServerFailure("server error")));

          return bloc;
        },
        act: (bloc) => bloc.add(const OnFetchNowPlayingMovies()),
        wait: const Duration(microseconds: 100),
        expect: () =>
            [NowPlayingMoviesLoading(), const NowPlayingMoviesError("server error")],
        verify: (bloc) {
          verify(mockGetNowPlayingMovies.execute());
        });
  });
}
