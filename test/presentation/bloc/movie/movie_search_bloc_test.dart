import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie/search_movies.dart';
import 'package:ditonton/presentation/bloc/movie/movie_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../provider/movie/movie_search_notifier_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late MovieSearchBloc bloc;
  late MockSearchMovies mockSearchMovies;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    bloc = MovieSearchBloc(mockSearchMovies);
  });

  final query = "Best Movie";

  group('Search Movie', () {
    test('initial state should be empty', () {
      expect(bloc.state, SearchMoviesEmpty());
    });

    blocTest<MovieSearchBloc, MovieSearchState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockSearchMovies.execute(query))
              .thenAnswer((_) async => Right(tMovieList));

          return bloc;
        },
        act: (bloc) => bloc.add(OnSearchMovies(query)),
        wait: const Duration(microseconds: 100),
        expect: () =>
            [SearchMoviesLoading(), SearchMoviesHasData(tMovieList)],
        verify: (bloc) {
          verify(mockSearchMovies.execute(query));
        });

    blocTest<MovieSearchBloc, MovieSearchState>(
        'Should emit [Loading, Error] when failed',
        build: () {
          when(mockSearchMovies.execute(query))
              .thenAnswer((_) async => Left(ServerFailure("server error")));

          return bloc;
        },
        act: (bloc) => bloc.add(OnSearchMovies(query)),
        wait: const Duration(microseconds: 100),
        expect: () =>
            [SearchMoviesLoading(), const SearchMoviesError("server error")],
        verify: (bloc) {
          verify(mockSearchMovies.execute(query));
        });
  });
}
