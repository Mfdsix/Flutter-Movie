import 'package:ditonton/data/datasources/helpers/database_helper.dart';
import 'package:ditonton/data/datasources/local/watchlist_local_data_source.dart';
import '../movie/lib/data/datasources/remote/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/remote/tv_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/tv_repository_impl.dart';
import '../movie/lib/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/tv/get_now_playing_tvs.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tvs.dart';
import 'package:ditonton/domain/usecases/tv/get_recommendation_tvs.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_tvs.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/tv/search_tvs.dart';
import 'package:ditonton/domain/usecases/watchlist/get_watchlist.dart';
import 'package:ditonton/domain/usecases/watchlist/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/watchlist/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/watchlist/save_watchlist.dart';
import 'package:ditonton/domain/usecases/movie/search_movies.dart';
import 'package:ditonton/presentation/bloc/movie/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_search_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_on_airing_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_search_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist/watchlist_tv_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:http/io_client.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => MovieNowPlayingBloc(
      locator()
    ),
  );
  locator.registerFactory(
        () => MoviePopularBloc(
        locator()
    ),
  );
  locator.registerFactory(
        () => MovieTopRatedBloc(
        locator()
    ),
  );
  locator.registerFactory(
    () => MovieDetailBloc(
      locator(), locator(), locator(), locator(), locator()
    ),
  );
  locator.registerFactory(
    () => MovieSearchBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieBloc(
      locator(),
    ),
  );

  locator.registerFactory(
        () => TvOnAiringBloc(
          locator()
    ),
  );
  locator.registerFactory(
        () => TvPopularBloc(
        locator()
    ),
  );
  locator.registerFactory(
        () => TvTopRatedBloc(
        locator()
    ),
  );
  locator.registerFactory(
        () => TvDetailBloc(
          locator(), locator(), locator(), locator(), locator()
    ),
  );
  locator.registerFactory(
        () => TvSearchBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => WatchlistTvBloc(
      locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetMovieWatchlistStatus(locator()));
  locator.registerLazySingleton(() => SaveMovieToWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveMovieFromWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetNowPlayingTvs(locator()));
  locator.registerLazySingleton(() => GetPopularTvs(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvs(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetRecommendationTvs(locator()));
  locator.registerLazySingleton(() => SearchTvs(locator()));
  locator.registerLazySingleton(() => GetTvWatchlistStatus(locator()));
  locator.registerLazySingleton(() => SaveTvToWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveTvFromWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvs(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvRepository>(
        () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvRemoteDataSource>(
          () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => IOClient());
}
