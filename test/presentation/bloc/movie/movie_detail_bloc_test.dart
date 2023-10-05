import 'package:ditonton/domain/usecases/movie/get_movie_detail.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  GetMovieDetail,
])
void main() {
  late MovieDetailBloc

  setUp(() {
    listenerCallCount = 0;
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchlistStatus = MockGetMovieWatchlistStatus();
    mockSaveWatchlist = MockSaveMovieToWatchlist();
    mockRemoveWatchlist = MockRemoveMovieFromWatchlist();
    bloc = MovieDetailBloc(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    )
      ..addListener(() {
        listenerCallCount += 1;
      });
  });
}