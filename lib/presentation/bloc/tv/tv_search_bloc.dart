import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv/search_tvs.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_search_event.dart';
part 'tv_search_state.dart';

class TvSearchBloc extends Bloc<TvSearchEvent, TvSearchState>{
  final SearchTvs _searchTvs;

  TvSearchBloc(
      this._searchTvs,
      ) : super(SearchTvsEmpty()) {
        on<OnSearchTv>((event, emit) async {
          final query = event.query;

          emit(SearchTvsLoading());
          final result = await _searchTvs.execute(query);
          result.fold(
            (failure){
              emit(SearchTvsError(failure.message));
            },
            (tvs){
              emit(SearchTvsHasData(tvs));
            },
            );
        });
      }
}

