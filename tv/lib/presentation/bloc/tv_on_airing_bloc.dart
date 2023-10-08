import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_now_playing_tvs.dart';

part 'tv_on_airing_event.dart';
part 'tv_on_airing_state.dart';

class TvOnAiringBloc extends Bloc<TvOnAiringEvent, TvOnAiringState>{
  final GetNowPlayingTvs _getNowPlayingTvs;

  TvOnAiringBloc(
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

