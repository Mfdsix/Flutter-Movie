import 'dart:io';
import 'package:http/io_client.dart';

import 'package:flutter/services.dart';

const THEMOVIEDB_API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
const THEMOVIEDB_BASE_URL = 'https://api.themoviedb.org/3';

Future<IOClient> get client async {
  final sslCert = await rootBundle.load('assets/certificate/developer.themoviedb.org.cer');
  SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
  securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
  HttpClient client = HttpClient(context: securityContext);
  client.badCertificateCallback =
      (X509Certificate cert, String host, int port) => false;
  return IOClient(client);
}