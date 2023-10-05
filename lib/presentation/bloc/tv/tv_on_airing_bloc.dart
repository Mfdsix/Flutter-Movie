import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/Tv/get_now_playing_Tvs.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_on_airing_event.dart';
part 'tv_on_airing_state.dart';

class TvOnAirinhBloc extends Bloc<TvOnAiringEvent, TvOnAiringState>{
  final GetNowPlayingTvs _getNowPlayingTvs;

  TvOnAirinhBloc(
      this._getNowPlayingTvs,
      ) : super(OnAiringTvEmpty()){
        on<OnFetchOnAiringTv>((event, emit) async {
          emit(OnAiringTvLoading());

          final result = await _getNowPlayingTvs.execute();
          result.fold(
            (failure){
              emit(OnAiringTvError(failure.message));
            },
            (tvs){
              emit(OnAiringTvHasData(tvs));
            },
            );
        });
      }
}

