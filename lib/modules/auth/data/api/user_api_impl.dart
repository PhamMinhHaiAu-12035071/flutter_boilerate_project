import 'package:dio/dio.dart';
import 'package:flutter_boilerate_project/configs/flavors/flavor_config.dart';
import 'package:flutter_boilerate_project/modules/auth/data/api/user_api.dart';
import 'package:injectable/injectable.dart';

@Named('UserApiImpl')
@Singleton(as: UserAPI)
class UserApiImpl implements UserAPI {
  const UserApiImpl(this._dio);

  final Dio _dio;

  String get pathLogin => '/api/oauth2/token';

  @override
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

  @override
  void stop() {}
}
