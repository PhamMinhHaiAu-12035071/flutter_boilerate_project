import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_boilerate_project/configs/dependency_injection/injection.config.dart';
import 'package:flutter_boilerate_project/configs/flavors/flavor_config.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

final getIt = GetIt.instance;

@InjectableInit(
  generateForDir: ['lib'],
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
Future<GetIt> configureDependencies() async {
  return $initGetIt(getIt);
}

/// Register third party module
@module
abstract class HttpModule {
  @singleton
  Client get client => Client();
}

@module
abstract class LoggerModule {
  @singleton
  Logger get logger => Logger(
        printer: PrettyPrinter(
          printTime: true, // Should each log print contain a timestamp
        ),
      );
}

@module
abstract class DioModule {
  @injectable
  Dio get dio => Dio(
        BaseOptions(
          baseUrl: FlavorConfig.baseURL,
          connectTimeout: 5000,
          receiveTimeout: 3000,
          headers: <String, dynamic>{
            HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
            HttpHeaders.acceptHeader: '*/*',
            HttpHeaders.cacheControlHeader: 'no-cache',
            'X-Kii-AppID': 'bdf72f34',
            'X-Kii-AppKey': 'fed756c9a38466bea5c347bc26c4f995',
          },
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
}
