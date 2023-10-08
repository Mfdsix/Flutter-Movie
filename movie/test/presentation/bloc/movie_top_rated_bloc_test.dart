import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/presentation/bloc/movie_top_rated_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_top_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late MovieTopRatedBloc bloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    bloc = MovieTopRatedBloc(mockGetTopRatedMovies);
  });

  group('Get TopRated Movie', () {
    test('initial state should be empty', () {
      expect(bloc.state, TopRatedMoviesEmpty());
    });

    blocTest<MovieTopRatedBloc, MovieTopRatedState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetTopRatedMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));

          return bloc;
        },
        act: (bloc) => bloc.add(const OnFetchTopRatedMovies()),
        wait: const Duration(microseconds: 100),
        expect: () =>
            [TopRatedMoviesLoading(), TopRatedMoviesHasData(tMovieList)],
        verify: (bloc) {
          verify(mockGetTopRatedMovies.execute());
        });

    blocTest<MovieTopRatedBloc, MovieTopRatedState>(
        'Should emit [Loading, Error] when failed',
        build: () {
          when(mockGetTopRatedMovies.execute())
              .thenAnswer((_) async => Left(ServerFailure("server error")));

          return bloc;
        },
        act: (bloc) => bloc.add(const OnFetchTopRatedMovies()),
        wait: const Duration(microseconds: 100),
        expect: () =>
            [TopRatedMoviesLoading(), const TopRatedMoviesError("server error")],
        verify: (bloc) {
          verify(mockGetTopRatedMovies.execute());
        });
  });
}
