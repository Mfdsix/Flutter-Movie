import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tvs.dart';
import 'package:ditonton/presentation/provider/tv/popular_tvs_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_tvs_notifier_test.mocks.dart';

@GenerateMocks([GetPopularTvs])
void main() {
  late MockGetPopularTvs mockGetPopularMovies;
  late PopularTvsNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularMovies = MockGetPopularTvs();
    notifier = PopularTvsNotifier(mockGetPopularMovies)
      ..addListener(() {
        listenerCallCount++;
      });
  });

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
      voteCount: 900
  );
  final tvs = <Tv>[tv];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetPopularMovies.execute())
        .thenAnswer((_) async => Right(tvs));
    // act
    notifier.fetchPopularMovies();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetPopularMovies.execute())
        .thenAnswer((_) async => Right(tvs));
    // act
    await notifier.fetchPopularMovies();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.movies, tvs);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetPopularMovies.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchPopularMovies();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
