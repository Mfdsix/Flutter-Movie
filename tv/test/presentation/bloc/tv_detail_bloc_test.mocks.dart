// Mocks generated by Mockito 5.4.4 from annotations
// in tv/test/presentation/bloc/tv_detail_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:core/common/failure.dart' as _i7;
import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tv/domain/entities/tv.dart' as _i10;
import 'package:tv/domain/entities/tv_detail.dart' as _i8;
import 'package:tv/domain/repositories/tv_repository.dart' as _i2;
import 'package:tv/domain/usecases/get_recommendation_tvs.dart' as _i9;
import 'package:tv/domain/usecases/get_tv_detail.dart' as _i5;
import 'package:watchlist/domain/entities/watchlist_table.dart' as _i13;
import 'package:watchlist/domain/repositories/watchlist_repository.dart' as _i4;
import 'package:watchlist/domain/usecases/get_watchlist_status.dart' as _i11;
import 'package:watchlist/domain/usecases/remove_watchlist.dart' as _i14;
import 'package:watchlist/domain/usecases/save_watchlist.dart' as _i12;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeTvRepository_0 extends _i1.SmartFake implements _i2.TvRepository {
  _FakeTvRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWatchlistRepository_2 extends _i1.SmartFake
    implements _i4.WatchlistRepository {
  _FakeWatchlistRepository_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetTvDetail].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTvDetail extends _i1.Mock implements _i5.GetTvDetail {
  MockGetTvDetail() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTvRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.TvRepository);

  @override
  _i6.Future<_i3.Either<_i7.Failure, _i8.TvDetail>> execute(int? tvId) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [tvId],
        ),
        returnValue: _i6.Future<_i3.Either<_i7.Failure, _i8.TvDetail>>.value(
            _FakeEither_1<_i7.Failure, _i8.TvDetail>(
          this,
          Invocation.method(
            #execute,
            [tvId],
          ),
        )),
      ) as _i6.Future<_i3.Either<_i7.Failure, _i8.TvDetail>>);
}

/// A class which mocks [GetRecommendationTvs].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetRecommendationTvs extends _i1.Mock
    implements _i9.GetRecommendationTvs {
  MockGetRecommendationTvs() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTvRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.TvRepository);

  @override
  _i6.Future<_i3.Either<_i7.Failure, List<_i10.Tv>>> execute(int? tvId) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [tvId],
        ),
        returnValue: _i6.Future<_i3.Either<_i7.Failure, List<_i10.Tv>>>.value(
            _FakeEither_1<_i7.Failure, List<_i10.Tv>>(
          this,
          Invocation.method(
            #execute,
            [tvId],
          ),
        )),
      ) as _i6.Future<_i3.Either<_i7.Failure, List<_i10.Tv>>>);
}

/// A class which mocks [GetWatchlistStatus].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchlistStatus extends _i1.Mock
    implements _i11.GetWatchlistStatus {
  MockGetWatchlistStatus() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.WatchlistRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeWatchlistRepository_2(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i4.WatchlistRepository);

  @override
  _i6.Future<bool> execute(int? id) => (super.noSuchMethod(
        Invocation.method(
          #execute,
          [id],
        ),
        returnValue: _i6.Future<bool>.value(false),
      ) as _i6.Future<bool>);
}

/// A class which mocks [SaveWatchlist].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveWatchlist extends _i1.Mock implements _i12.SaveWatchlist {
  MockSaveWatchlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.WatchlistRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeWatchlistRepository_2(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i4.WatchlistRepository);

  @override
  _i6.Future<_i3.Either<_i7.Failure, String>> execute(
          _i13.WatchlistTable? watchlistTable) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [watchlistTable],
        ),
        returnValue: _i6.Future<_i3.Either<_i7.Failure, String>>.value(
            _FakeEither_1<_i7.Failure, String>(
          this,
          Invocation.method(
            #execute,
            [watchlistTable],
          ),
        )),
      ) as _i6.Future<_i3.Either<_i7.Failure, String>>);
}

/// A class which mocks [RemoveWatchlist].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveWatchlist extends _i1.Mock implements _i14.RemoveWatchlist {
  MockRemoveWatchlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.WatchlistRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeWatchlistRepository_2(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i4.WatchlistRepository);

  @override
  _i6.Future<_i3.Either<_i7.Failure, String>> execute(
          _i13.WatchlistTable? watchlistTable) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [watchlistTable],
        ),
        returnValue: _i6.Future<_i3.Either<_i7.Failure, String>>.value(
            _FakeEither_1<_i7.Failure, String>(
          this,
          Invocation.method(
            #execute,
            [watchlistTable],
          ),
        )),
      ) as _i6.Future<_i3.Either<_i7.Failure, String>>);
}
