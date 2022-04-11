import 'package:dio/dio.dart';

abstract class UserAPI {
  Future<Response<String>> login({
    required String username,
    required String password,
  });

  void stop();
}
