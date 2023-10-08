import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_popular_tvs.dart';
import 'package:tv/presentation/bloc/tv_popular_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvs])
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
