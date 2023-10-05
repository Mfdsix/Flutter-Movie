import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_recommendation_tvs.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/watchlist/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/watchlist/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/watchlist/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/tv/tv_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../provider/tv/tv_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetRecommendationTvs,
  GetTvWatchlistStatus,
  SaveTvToWatchlist,
  RemoveTvFromWatchlist,
])
void main() {
  late TvDetailBloc tvDetailBloc;
  late MockGetTvDetail mockGetMovieDetail;
  late MockGetRecommendationTvs mockGetMovieRecommendations;
  late MockGetTvWatchlistStatus mockGetWatchlistStatus;
  late MockSaveTvToWatchlist mockSaveWatchlist;
  late MockRemoveTvFromWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetTvDetail();
    mockGetMovieRecommendations = MockGetRecommendationTvs();
    mockGetWatchlistStatus = MockGetTvWatchlistStatus();
    mockSaveWatchlist = MockSaveTvToWatchlist();
    mockRemoveWatchlist = MockRemoveTvFromWatchlist();
    tvDetailBloc = TvDetailBloc(mockGetMovieDetail, mockGetMovieRecommendations,
        mockGetWatchlistStatus, mockSaveWatchlist, mockRemoveWatchlist);
  });

  const tId = 1;

  final tv = Tv(
      backdropPath: "backdrop.png",
      firstAirDate: "2023-09-09",
      genreIds: const [1, 2, 3],
      id: 1,
      name: "Sinetron Azab",
      originalCountry: const ["Indonesia"],
      originalLanguage: "Indonesia",
      originalName: "Sinetron Indosiar",
      overview: "Sinetron indosiar terbaik",
      popularity: 4.5,
      posterPath: "poster.png",
      voteAverage: 4.8,
      voteCount: 900);
  final tvs = <Tv>[tv];

  group('Get Tv Detail', () {
    test('initial state should be empty', () {
      expect(tvDetailBloc.state, TvDetailEmpty());
    });

    blocTest<TvDetailBloc, TvDetailState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetMovieDetail.execute(tId))
              .thenAnswer((_) async => Right(testTvDetail));
          when(mockGetMovieRecommendations.execute(tId))
              .thenAnswer((_) async => Right(tvs));

          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(const OnFetchTvDetail(tId)),
        wait: const Duration(microseconds: 100),
        expect: () => [
              TvDetailLoading(),
              TvDetailHasData(testTvDetail),
              TvRecommendationHasData(tvs)
            ],
        verify: (bloc) {
          verify(mockGetMovieDetail.execute(tId));
        });

    blocTest<TvDetailBloc, TvDetailState>(
        'Should emit [Loading, Error] when failed',
        build: () {
          when(mockGetMovieDetail.execute(tId))
              .thenAnswer((_) async => Left(ServerFailure("server error")));
          when(mockGetMovieRecommendations.execute(tId))
              .thenAnswer((_) async => Right(tvs));

          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(const OnFetchTvDetail(tId)),
        wait: const Duration(microseconds: 100),
        expect: () =>
            [TvDetailLoading(), const TvDetailError("server error")],
        verify: (bloc) {
          verify(mockGetMovieDetail.execute(tId));
    });

    blocTest<TvDetailBloc, TvDetailState>(
        'Should emit [Loading, Error] when failed',
        build: () {
          when(mockGetMovieDetail.execute(tId))
              .thenAnswer((_) async => Right(testTvDetail));
          when(mockGetMovieRecommendations.execute(tId))
              .thenAnswer((_) async => Left(ServerFailure("server error")));

          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(const OnFetchTvDetail(tId)),
        wait: const Duration(microseconds: 100),
        expect: () => [
              TvDetailLoading(),
              TvDetailHasData(testTvDetail),
              const TvDetailError("server error")
            ],
        verify: (bloc) {
          verify(mockGetMovieDetail.execute(tId));
        });
  });

  group('Add Tv To Watchlist', () {
    blocTest<TvDetailBloc, TvDetailState>(
        'Should emit [Successs] when data is gotten successfully',
        build: () {
          when(mockSaveWatchlist.execute(testTvDetail))
              .thenAnswer((_) async => const Right("success"));
          when(mockGetWatchlistStatus.execute(testTvDetail.id))
              .thenAnswer((_) async => true);

          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(OnAddWatchlist(testTvDetail)),
        wait: const Duration(microseconds: 100),
        expect: () =>
            [AddWatchlistSuccess(), const WatchlistStatusFetched(true)],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testTvDetail));
        });

    blocTest<TvDetailBloc, TvDetailState>(
        'Should emit [Error] when failed',
        build: () {
          when(mockSaveWatchlist.execute(testTvDetail))
              .thenAnswer((_) async => Left(ServerFailure("server error")));
          when(mockGetWatchlistStatus.execute(testTvDetail.id))
              .thenAnswer((_) async => false);

          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(OnAddWatchlist(testTvDetail)),
        wait: const Duration(microseconds: 100),
        expect: () =>
            [AddWatchlistFailed(), const WatchlistStatusFetched(false)],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testTvDetail));
        });
  });

  group('Remove Tv To Watchlist', () {
    blocTest<TvDetailBloc, TvDetailState>(
        'Should emit [Successs] when data is gotten successfully',
        build: () {
          when(mockRemoveWatchlist.execute(testTvDetail))
              .thenAnswer((_) async => const Right("success"));
          when(mockGetWatchlistStatus.execute(testTvDetail.id))
              .thenAnswer((_) async => false);

          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(OnRemoveWatchlist(testTvDetail)),
        wait: const Duration(microseconds: 100),
        expect: () =>
            [RemoveWatchlistSuccess(), const WatchlistStatusFetched(false)],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(testTvDetail));
        });

    blocTest<TvDetailBloc, TvDetailState>(
        'Should emit [Error] when failed',
        build: () {
          when(mockRemoveWatchlist.execute(testTvDetail))
              .thenAnswer((_) async => Left(ServerFailure("server error")));
          when(mockGetWatchlistStatus.execute(testTvDetail.id))
              .thenAnswer((_) async => false);

          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(OnRemoveWatchlist(testTvDetail)),
        wait: const Duration(microseconds: 100),
        expect: () =>
            [RemoveWatchlistFailed(), const WatchlistStatusFetched(false)],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(testTvDetail));
        });
  });

  group('Get Tv Watchlist Status', () {
    blocTest<TvDetailBloc, TvDetailState>(
        'Should emit [Successs] when data is gotten successfully',
        build: () {
          when(mockGetWatchlistStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => true);

          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(OnLoadWatchlistStatus(testMovieDetail.id)),
        wait: const Duration(microseconds: 100),
        expect: () => [const WatchlistStatusFetched(true)],
        verify: (bloc) {
          verify(mockGetWatchlistStatus.execute(testMovieDetail.id));
        });
  });
}
