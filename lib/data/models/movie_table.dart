import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

class MovieTable extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;
  final String? type;

  const MovieTable(
      {required this.id,
      required this.title,
      required this.posterPath,
      required this.overview,
      this.type = "movie"});

  factory MovieTable.fromMovieEntity(MovieDetail movie) => MovieTable(
      id: movie.id,
      title: movie.title,
      posterPath: movie.posterPath,
      overview: movie.overview,
      type: "movie");

  factory MovieTable.fromTvEntity(TvDetail tv) => MovieTable(
      id: tv.id,
      title: tv.name,
      posterPath: tv.posterPath,
      overview: tv.overview,
      type: "tv");

  factory MovieTable.fromMap(Map<String, dynamic> map) => MovieTable(
      id: map['id'],
      title: map['title'],
      posterPath: map['posterPath'],
      overview: map['overview'],
      type: map['type']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
        'type': type
      };

  Movie toMovieEntity() => Movie.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        title: title,
      );

  Tv toTvEntity() => Tv.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        name: title,
      );

  @override
  List<Object?> get props => [id, title, posterPath, overview];
}
