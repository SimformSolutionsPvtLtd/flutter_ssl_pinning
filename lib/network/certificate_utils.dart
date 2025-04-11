import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CertificateUtils {
  CertificateUtils._();

  static void setupHttpClient({
    required Dio dio,
    required String certPath,
  }) async {
    // Get or fetch the sslCertValue
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);

    try {
      // Load the certificate from assets
      ByteData sslCertByteData = await rootBundle.load(certPath);
      Uint8List certificateUint8List = sslCertByteData.buffer.asUint8List();

      // Set the trusted certificate
      securityContext.setTrustedCertificatesBytes(certificateUint8List);

      dio.httpClientAdapter = IOHttpClientAdapter(
        createHttpClient: () {
          final HttpClient client = HttpClient(context: securityContext);

          // Only allow valid SSL certificates
          client.badCertificateCallback =
              (X509Certificate cert, String host, int port) {
            debugPrint(
                'SSL Pinning: Rejecting untrusted certificate for $host');
            return false;
          };

          return client;
        },
      );
    } catch (e) {
      debugPrint('Failed to load SSL certificate: $e');
    }
  }
}
