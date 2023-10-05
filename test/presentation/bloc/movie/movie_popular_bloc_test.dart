import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie/get_popular_movies.dart';
import 'package:ditonton/presentation/bloc/movie/movie_popular_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../provider/movie/movie_list_notifier_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MoviePopularBloc bloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    bloc = MoviePopularBloc(mockGetPopularMovies);
  });

  group('Get Popular Movie', () {
    test('initial state should be empty', () {
      expect(bloc.state, PopularMoviesEmpty());
    });

    blocTest<MoviePopularBloc, MoviePopularState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetPopularMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));

          return bloc;
        },
        act: (bloc) => bloc.add(const OnFetchPopularMovies()),
        wait: const Duration(microseconds: 100),
        expect: () =>
            [PopularMoviesLoading(), PopularMoviesHasData(tMovieList)],
        verify: (bloc) {
          verify(mockGetPopularMovies.execute());
        });

    blocTest<MoviePopularBloc, MoviePopularState>(
        'Should emit [Loading, Error] when failed',
        build: () {
          when(mockGetPopularMovies.execute())
              .thenAnswer((_) async => Left(ServerFailure("server error")));

          return bloc;
        },
        act: (bloc) => bloc.add(const OnFetchPopularMovies()),
        wait: const Duration(microseconds: 100),
        expect: () =>
            [PopularMoviesLoading(), const PopularMoviesError("server error")],
        verify: (bloc) {
          verify(mockGetPopularMovies.execute());
        });
  });
}
