import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'certificate_utils.dart';

abstract class ApiBaseRepository {
  late Dio dio;

  ApiBaseRepository({
    required String baseUrl,
    required String certPath,
  }) : dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
          ),
        ) {
    CertificateUtils.setupHttpClient(
      dio: dio,
      certPath: certPath,
    );
  }

  Future<dynamic> get({
    required String endpoint,
  }) async {
    try {
      final response = await dio.get(endpoint);
      return response.data;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
