import 'dart:convert';

import 'package:ditonton/data/models/tv/tv_model.dart';
import 'package:ditonton/data/models/tv/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

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

  final tvResponseModel = TvResponse(results: <TvModel>[tvModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_list_response.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      print(result);
      // assert
      expect(result, tvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tvResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": tvModel.backdropPath,
            "first_air_date": tvModel.firstAirDate,
            "genre_ids": tvModel.genreIds,
            "id": tvModel.id,
            "name": tvModel.name,
            "origin_country": tvModel.originCountry,
            "original_language": tvModel.originalLanguage,
            "original_name": tvModel.originalName,
            "overview": tvModel.overview,
            "popularity": tvModel.popularity,
            "poster_path": tvModel.posterPath,
            "vote_average": tvModel.voteAverage,
            "vote_count": tvModel.voteCount
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
