import 'package:http/io_client.dart';
import 'package:mockito/annotations.dart';
import 'package:movie/data/datasources/remote/movie_remote_data_source.dart';
import 'package:movie/domain/repositories/movie_repository.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
], customMocks: [
  MockSpec<IOClient>(as: #MockHttpClient)
])
void main() {}
