import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_tvs.dart';
import 'package:ditonton/presentation/bloc/tv/tv_top_rated_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../provider/tv/tv_list_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedTvs])
void main() {
  late TvTopRatedBloc bloc;
  late MockGetTopRatedTvs mockGetTopRatedTvs;

  setUp(() {
    mockGetTopRatedTvs = MockGetTopRatedTvs();
    bloc = TvTopRatedBloc(mockGetTopRatedTvs);
  });

  group('Get TopRated Tv', () {
    test('initial state should be empty', () {
      expect(bloc.state, TopRatedTvsEmpty());
    });

    blocTest<TvTopRatedBloc, TvTopRatedState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetTopRatedTvs.execute())
              .thenAnswer((_) async => Right(tvs));

          return bloc;
        },
        act: (bloc) => bloc.add(const OnFetchTopRatedTvs()),
        wait: const Duration(microseconds: 100),
        expect: () =>
            [TopRatedTvsLoading(), TopRatedTvsHasData(tvs)],
        verify: (bloc) {
          verify(mockGetTopRatedTvs.execute());
        });

    blocTest<TvTopRatedBloc, TvTopRatedState>(
        'Should emit [Loading, Error] when failed',
        build: () {
          when(mockGetTopRatedTvs.execute())
              .thenAnswer((_) async => Left(ServerFailure("server error")));

          return bloc;
        },
        act: (bloc) => bloc.add(const OnFetchTopRatedTvs()),
        wait: const Duration(microseconds: 100),
        expect: () =>
            [TopRatedTvsLoading(), const TopRatedTvsError("server error")],
        verify: (bloc) {
          verify(mockGetTopRatedTvs.execute());
        });
  });
}
