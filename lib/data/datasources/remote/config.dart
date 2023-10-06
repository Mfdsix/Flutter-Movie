import 'dart:io';
import 'package:http/io_client.dart';

import 'package:flutter/services.dart';

const THEMOVIEDB_API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
const THEMOVIEDB_BASE_URL = 'https://api.themoviedb.org/3';

Future<SecurityContext> get globalContext async {
  final sslCert = await rootBundle.load('certificates/certificates.pem');
  SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
  securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
  return securityContext;
}

Future<IOClient> get client async {
  HttpClient client = HttpClient(context: await globalContext);
  client.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
  IOClient ioClient = IOClient(client);

  return ioClient;
}