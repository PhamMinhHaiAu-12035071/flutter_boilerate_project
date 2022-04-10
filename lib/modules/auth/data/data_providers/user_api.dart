import 'dart:convert';

import 'package:flutter_boilerate_project/configs/flavors/flavor_config.dart';
import 'package:flutter_boilerate_project/shared/services/client_common.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

@singleton
class UserAPI {
  const UserAPI({required ClientCommon clientCommon}) : _client = clientCommon;

  final ClientCommon _client;

  String get pathLogin => '/api/oauth2/token';

  Future<Response> login({
    required String username,
    required String password,
  }) async {
    final url = Uri.parse('${FlavorConfig.baseURL}$pathLogin');
    final obj = <String, String>{
      'username': username,
      'password': password,
    };
    final params = jsonEncode(obj);
    final response = await _client.post(url, body: params);
    return response;
  }
}
