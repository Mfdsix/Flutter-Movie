import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/tv_model.dart';
import 'package:tv/domain/entities/tv.dart';

void main() {
  final tvModel = TvModel(
      backdropPath: "backdrop.png",
      firstAirDate: "2023-09-09",
      genreIds: const [1, 2, 3],
      id: 1,
      name: "Sinetron Azab",
      originCountry: const ["Indonesia"],
      originalLanguage: "Indonesia",
      originalName: "Azab Indosiar",
      overview: "Film azab pengingat manusia",
      popularity: 8.2,
      posterPath: "poster.png",
      voteAverage: 4.5,
      voteCount: 2500000);

  final tv = Tv(
      backdropPath: tvModel.backdropPath,
      firstAirDate: tvModel.firstAirDate,
      genreIds: tvModel.genreIds,
      id: tvModel.id,
      name: tvModel.name,
      originalName: tvModel.originalName,
      originalCountry: tvModel.originCountry,
      originalLanguage: tvModel.originalLanguage,
      overview: tvModel.overview,
      popularity: tvModel.popularity,
      posterPath: tvModel.posterPath,
      voteAverage: tvModel.voteAverage,
      voteCount: tvModel.voteCount);

  test('should be a subclass of Tv entity', () async {
    final result = tvModel.toEntity();
    expect(result, tv);
  });
}
