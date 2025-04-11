import 'package:flutter_ssl_pinning/network/api_base_repository.dart';

class UserRepository extends ApiBaseRepository {
  UserRepository({
    required super.baseUrl,
    required super.certPath,
  });

  Future<dynamic> getUserData({
    required String endpoint,
  }) async {
    return await get(endpoint: endpoint);
  }
}
