import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_top_rated_tvs.dart';

part 'tv_top_rated_event.dart';
part 'tv_top_rated_state.dart';

class TvTopRatedBloc extends Bloc<TvTopRatedEvent, TvTopRatedState>{
  final GetTopRatedTvs _getTopRatedTvs;

  TvTopRatedBloc(
      this._getTopRatedTvs,
      ) : super(TopRatedTvsEmpty()) {
        on<OnFetchTopRatedTvs>((event, emit) async {
          emit(TopRatedTvsLoading());

          final result = await _getTopRatedTvs.execute();
          result.fold(
            (failure){
              emit(TopRatedTvsError(failure.message));
            },
            (movies){
              emit(TopRatedTvsHasData(movies));
            },
            );
        });
      }
}

