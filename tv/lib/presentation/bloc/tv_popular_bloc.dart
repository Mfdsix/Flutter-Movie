import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_popular_tvs.dart';

part 'tv_popular_event.dart';
part 'tv_popular_state.dart';

class TvPopularBloc extends Bloc<TvPopularEvent, TvPopularState>{
  final GetPopularTvs _getPopularTvs;

  TvPopularBloc(
      this._getPopularTvs,
      ) : super(PopularTvsEmpty()) {
        on<OnFetchPopularTvs>((event, emit) async {
          emit(PopularTvsLoading());

          final result = await _getPopularTvs.execute();
          result.fold(
            (failure){
              emit(PopularTvsError(failure.message));
            },
            (tvs){
              emit(PopularTvsHasData(tvs));
            },
            );
        });
      }
}

