import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv/get_now_playing_tvs.dart';
import 'package:ditonton/presentation/bloc/tv/tv_on_airing_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_on_airing_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvs])
void main() {
  late TvOnAiringBloc bloc;
  late MockGetNowPlayingTvs mockGetNowPlayingTvs;

  setUp(() {
    mockGetNowPlayingTvs = MockGetNowPlayingTvs();
    bloc = TvOnAiringBloc(mockGetNowPlayingTvs);
  });

  group('Get On Airing Tv', () {
    test('initial state should be empty', () {
      expect(bloc.state, OnAiringTvEmpty());
    });

    blocTest<TvOnAiringBloc, TvOnAiringState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetNowPlayingTvs.execute())
              .thenAnswer((_) async => Right(tvs));

          return bloc;
        },
        act: (_bloc) => _bloc.add(const OnFetchOnAiringTv()),
        wait: const Duration(microseconds: 100),
        expect: () =>
            [OnAiringTvLoading(), OnAiringTvHasData(tvs)],
        verify: (bloc) {
          verify(mockGetNowPlayingTvs.execute());
        });

    blocTest<TvOnAiringBloc, TvOnAiringState>(
        'Should emit [Loading, Error] when failed',
        build: () {
          when(mockGetNowPlayingTvs.execute())
              .thenAnswer((_) async => Left(ServerFailure("server error")));

          return bloc;
        },
        act: (bloc) => bloc.add(const OnFetchOnAiringTv()),
        wait: const Duration(microseconds: 100),
        expect: () =>
            [OnAiringTvLoading(), const OnAiringTvError("server error")],
        verify: (bloc) {
          verify(mockGetNowPlayingTvs.execute());
        });
  });
}
