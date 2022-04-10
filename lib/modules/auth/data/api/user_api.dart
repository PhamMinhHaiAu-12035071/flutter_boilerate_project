import 'package:dio/dio.dart';
import 'package:flutter_boilerate_project/configs/flavors/flavor_config.dart';
import 'package:injectable/injectable.dart';

@singleton
class UserAPI {
  const UserAPI({required Dio dio}) : _dio = dio;

  final Dio _dio;

  String get pathLogin => '/api/oauth2/token';

  Future<Response<String>> login({
    required String username,
    required String password,
  }) async {
    final url = '${FlavorConfig.baseURL}$pathLogin';
    final obj = <String, String>{
      'username': username,
      'password': password,
    };
    final response = await _dio.post<String>(url, data: obj);
    return response;
  }
}
