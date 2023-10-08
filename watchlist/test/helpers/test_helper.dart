import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:watchlist/data/datasources/helpers/database_helper.dart';
import 'package:watchlist/data/datasources/local/watchlist_local_data_source.dart';
import 'package:watchlist/domain/repositories/watchlist_repository.dart';

@GenerateMocks([
  WatchlistRepository,
  WatchlistLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
