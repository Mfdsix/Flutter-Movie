import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/search_movies.dart';
import 'package:movie/presentation/bloc/movie_search_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_search_bloc_test.mocks.dart';

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
        wait: const Duration(microseconds: 500),
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
        wait: const Duration(microseconds: 500),
        expect: () =>
            [SearchMoviesLoading(), const SearchMoviesError("server error")],
        verify: (bloc) {
          verify(mockSearchMovies.execute(query));
        });
  });
}
