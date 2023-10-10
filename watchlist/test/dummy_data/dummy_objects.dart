
import 'package:watchlist/data/models/watchlist_table.dart';
import 'package:watchlist/domain/entities/movie.dart';
import 'package:watchlist/domain/entities/tv.dart';

final testMovieMap = {
  'id': 1,
  'overview': 'ok',
  'posterPath': 'poster.png',
  'title': 'test',
};

final testWatchlist = WatchlistTable(id: 1, title: "test", posterPath: "poster.png", overview: "overview");

final testWatchlists = [
  WatchlistTable(id: 1, title: "test", posterPath: "poster.png", overview: "ok")
];

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
final tMovieList = <Movie>[tMovie];

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