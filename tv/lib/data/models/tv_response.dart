import 'package:equatable/equatable.dart';
import 'package:tv/data/models/tv_model.dart';

class TvResponse extends Equatable {
  final List<TvModel> results;

  const TvResponse({
    required this.results
  });

  factory TvResponse.fromJson(Map<String, dynamic> json) => TvResponse(
    results: List<TvModel>.from(json["results"].map((x) => TvModel.fromJson(x)))
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };

  @override
  List<Object?> get props => [
    results
  ];
}
