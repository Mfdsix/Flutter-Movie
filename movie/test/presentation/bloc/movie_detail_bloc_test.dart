import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/presentation/bloc/movie_detail_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations
])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    movieDetailBloc = MovieDetailBloc(
        mockGetMovieDetail,
        mockGetMovieRecommendations);
  });

  const tId = 1;

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
              .thenAnswer((_) async => Right(tMovieList));

          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(const OnFetchMovieDetail(tId)),
        wait: const Duration(microseconds: 100),
        expect: () => [
              MovieDetailLoading(),
              MovieDetailHasData(testMovieDetail, tMovieList)
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
              .thenAnswer((_) async => Right(tMovieList));

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
              const MovieDetailError("server error")
            ],
        verify: (bloc) {
          verify(mockGetMovieDetail.execute(tId));
        });
  });
}
