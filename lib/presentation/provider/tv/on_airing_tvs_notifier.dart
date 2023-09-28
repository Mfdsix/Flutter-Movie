import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_now_playing_tvs.dart';
import 'package:flutter/material.dart';

class OnAiringTvsNotifier extends ChangeNotifier {
  final GetNowPlayingTvs getNowPlayingTvs;

  OnAiringTvsNotifier(this.getNowPlayingTvs);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tv> _movies = [];
  List<Tv> get movies => _movies;

  String _message = '';
  String get message => _message;

  Future<void> fetchOnAiringMovies() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingTvs.execute();

    result.fold(
          (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
          (moviesData) {
        _movies = moviesData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
