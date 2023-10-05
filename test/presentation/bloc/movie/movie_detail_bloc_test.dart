import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/watchlist/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/watchlist/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/watchlist/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie/movie_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../provider/movie/movie_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetMovieWatchlistStatus,
  SaveMovieToWatchlist,
  RemoveMovieFromWatchlist,
])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetMovieWatchlistStatus mockGetWatchlistStatus;
  late MockSaveMovieToWatchlist mockSaveWatchlist;
  late MockRemoveMovieFromWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchlistStatus = MockGetMovieWatchlistStatus();
    mockSaveWatchlist = MockSaveMovieToWatchlist();
    mockRemoveWatchlist = MockRemoveMovieFromWatchlist();
    movieDetailBloc = MovieDetailBloc(
        mockGetMovieDetail,
        mockGetMovieRecommendations,
        mockGetWatchlistStatus,
        mockSaveWatchlist,
        mockRemoveWatchlist);
  });

  const tId = 1;

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovies = <Movie>[tMovie];

  group('Get Movie Detail', () {
    test('initial state should be empty', () {
      expect(movieDetailBloc.state, MovieDetailEmpty());
    });

    blocTest<MovieDetailBloc, MovieDetailState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetMovieDetail.execute(tId))
              .thenAnswer((_) async => Right(testMovieDetail));
          when(mockGetMovieRecommendations.execute(tId))
              .thenAnswer((_) async => Right(tMovies));

          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(const OnFetchMovieDetail(tId)),
        wait: const Duration(microseconds: 100),
        expect: () => [
              MovieDetailLoading(),
              MovieDetailHasData(testMovieDetail),
              MovieRecommendationHasData(tMovies)
            ],
        verify: (bloc) {
          verify(mockGetMovieDetail.execute(tId));
        });

    blocTest<MovieDetailBloc, MovieDetailState>(
        'Should emit [Loading, Error] when failed',
        build: () {
          when(mockGetMovieDetail.execute(tId))
              .thenAnswer((_) async => Left(ServerFailure("server error")));
          when(mockGetMovieRecommendations.execute(tId))
              .thenAnswer((_) async => Right(tMovies));

          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(const OnFetchMovieDetail(tId)),
        wait: const Duration(microseconds: 100),
        expect: () =>
            [MovieDetailLoading(), const MovieDetailError("server error")],
        verify: (bloc) {
          verify(mockGetMovieDetail.execute(tId));
        });

    blocTest<MovieDetailBloc, MovieDetailState>(
        'Should emit [Loading, Error] when failed',
        build: () {
          when(mockGetMovieDetail.execute(tId))
              .thenAnswer((_) async => Right(testMovieDetail));
          when(mockGetMovieRecommendations.execute(tId))
              .thenAnswer((_) async => Left(ServerFailure("server error")));

          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(const OnFetchMovieDetail(tId)),
        wait: const Duration(microseconds: 100),
        expect: () => [
              MovieDetailLoading(),
              MovieDetailHasData(testMovieDetail),
              const MovieDetailError("server error")
            ],
        verify: (bloc) {
          verify(mockGetMovieDetail.execute(tId));
        });
  });

  group('Add Movie To Watchlist', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
        'Should emit [Successs] when data is gotten successfully',
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => const Right("success"));
          when(mockGetWatchlistStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => true);

          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(OnAddWatchlist(testMovieDetail)),
        wait: const Duration(microseconds: 100),
        expect: () =>
            [AddWatchlistSuccess(), const WatchlistStatusFetched(true)],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testMovieDetail));
        });

    blocTest<MovieDetailBloc, MovieDetailState>(
        'Should emit [Error] when failed',
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Left(ServerFailure("server error")));
          when(mockGetWatchlistStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => false);

          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(OnAddWatchlist(testMovieDetail)),
        wait: const Duration(microseconds: 100),
        expect: () =>
            [AddWatchlistFailed(), const WatchlistStatusFetched(false)],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testMovieDetail));
        });
  });

  group('Remove Movie To Watchlist', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
        'Should emit [Successs] when data is gotten successfully',
        build: () {
          when(mockRemoveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => const Right("success"));
          when(mockGetWatchlistStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => false);

          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(OnRemoveWatchlist(testMovieDetail)),
        wait: const Duration(microseconds: 100),
        expect: () =>
            [RemoveWatchlistSuccess(), const WatchlistStatusFetched(false)],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(testMovieDetail));
        });

    blocTest<MovieDetailBloc, MovieDetailState>(
        'Should emit [Error] when failed',
        build: () {
          when(mockRemoveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Left(ServerFailure("server error")));
          when(mockGetWatchlistStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => false);

          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(OnRemoveWatchlist(testMovieDetail)),
        wait: const Duration(microseconds: 100),
        expect: () =>
            [RemoveWatchlistFailed(), const WatchlistStatusFetched(false)],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(testMovieDetail));
        });
  });

  group('Get Movie Watchlist Status', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
        'Should emit [Successs] when data is gotten successfully',
        build: () {
          when(mockGetWatchlistStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => true);

          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(OnLoadWatchlistStatus(testMovieDetail.id)),
        wait: const Duration(microseconds: 100),
        expect: () =>
            [const WatchlistStatusFetched(true)],
        verify: (bloc) {
          verify(mockGetWatchlistStatus.execute(testMovieDetail.id));
        });
  });
}
