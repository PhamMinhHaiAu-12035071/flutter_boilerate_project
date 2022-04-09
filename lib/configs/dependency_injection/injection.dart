import 'package:flutter_boilerate_project/configs/dependency_injection/injection.config.dart';
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
