import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie/get_popular_movies.dart';
import 'package:ditonton/presentation/bloc/tv/tv_popular_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../provider/tv/tv_list_notifier_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late TvPopularBloc bloc;
  late MockGetPopularTvs mockGetPopularTvs;

  setUp(() {
    mockGetPopularTvs = MockGetPopularTvs();
    bloc = TvPopularBloc(mockGetPopularTvs);
  });

  group('Get Popular Tv', () {
    test('initial state should be empty', () {
      expect(bloc.state, PopularTvsEmpty());
    });

    blocTest<TvPopularBloc, TvPopularState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetPopularTvs.execute())
              .thenAnswer((_) async => Right(tvs));

          return bloc;
        },
        act: (bloc) => bloc.add(const OnFetchPopularTvs()),
        wait: const Duration(microseconds: 100),
        expect: () =>
            [PopularTvsLoading(), PopularTvsHasData(tvs)],
        verify: (bloc) {
          verify(mockGetPopularTvs.execute());
        });

    blocTest<TvPopularBloc, TvPopularState>(
        'Should emit [Loading, Error] when failed',
        build: () {
          when(mockGetPopularTvs.execute())
              .thenAnswer((_) async => Left(ServerFailure("server error")));

          return bloc;
        },
        act: (bloc) => bloc.add(const OnFetchPopularTvs()),
        wait: const Duration(microseconds: 100),
        expect: () =>
            [PopularTvsLoading(), const PopularTvsError("server error")],
        verify: (bloc) {
          verify(mockGetPopularTvs.execute());
        });
  });
}
