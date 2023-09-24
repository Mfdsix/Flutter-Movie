import 'package:ditonton/data/models/tv/tv_model.dart';

class TvResponse {
  List<TvModel> results;

  TvResponse({
    required this.results
  });

  factory TvResponse.fromJson(Map<String, dynamic> json) => TvResponse(
    results: List<TvModel>.from(json["results"].map((x) => TvModel.fromJson(x)))
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}
