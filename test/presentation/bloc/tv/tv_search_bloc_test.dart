import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv/search_tvs.dart';
import 'package:ditonton/presentation/bloc/tv/tv_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../provider/tv/tv_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTvs])
void main() {
  late TvSearchBloc bloc;
  late MockSearchTvs mockSearchTvs;

  setUp(() {
    mockSearchTvs = MockSearchTvs();
    bloc = TvSearchBloc(mockSearchTvs);
  });

  final query = "Best Tv";

  group('Search Tv', () {
    test('initial state should be empty', () {
      expect(bloc.state, SearchTvsEmpty());
    });

    blocTest<TvSearchBloc, TvSearchState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockSearchTvs.execute(query))
              .thenAnswer((_) async => Right(tvs));

          return bloc;
        },
        act: (bloc) => bloc.add(OnSearchTv(query)),
        wait: const Duration(milliseconds: 500),
        expect: () =>
            [SearchTvsLoading(), SearchTvsHasData(tvs)],
        verify: (bloc) {
          verify(mockSearchTvs.execute(query));
        });

    blocTest<TvSearchBloc, TvSearchState>(
        'Should emit [Loading, Error] when failed',
        build: () {
          when(mockSearchTvs.execute(query))
              .thenAnswer((_) async => Left(ServerFailure("server error")));

          return bloc;
        },
        act: (bloc) => bloc.add(OnSearchTv(query)),
        wait: const Duration(milliseconds: 500),
        expect: () =>
            [SearchTvsLoading(), const SearchTvsError("server error")],
        verify: (bloc) {
          verify(mockSearchTvs.execute(query));
        });
  });
}
