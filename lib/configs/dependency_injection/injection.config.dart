// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;
import 'package:logger/logger.dart' as _i6;

import '../../app_bloc_observer.dart' as _i11;
import '../../modules/auth/data/api/json_parsers/token_parser.dart' as _i8;
import '../../modules/auth/data/api/json_parsers/user_error_parser.dart'
    as _i10;
import '../../modules/auth/data/api/user_api.dart' as _i9;
import '../../modules/auth/data/repositories/authentication_repository.dart'
    as _i12;
import '../../modules/sign_in/business_logic/sign_in_bloc.dart' as _i13;
import '../../modules/theme/business_logic/theme_bloc.dart' as _i7;
import '../../shared/services/client_common.dart' as _i4;
import 'injection.dart' as _i14; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final httpModule = _$HttpModule();
  final dioModule = _$DioModule();
  final loggerModule = _$LoggerModule();
  gh.singleton<_i3.Client>(httpModule.client);
  gh.singleton<_i4.ClientCommon>(_i4.ClientCommon(client: get<_i3.Client>()));
  gh.factory<_i5.Dio>(() => dioModule.dio);
  gh.singleton<_i6.Logger>(loggerModule.logger);
  gh.singleton<_i7.ThemeBloc>(_i7.ThemeBloc());
  gh.singleton<_i8.TokenParser>(_i8.TokenParser());
  gh.singleton<_i9.UserAPI>(_i9.UserAPI(dio: get<_i5.Dio>()));
  gh.singleton<_i10.UserErrorParser>(_i10.UserErrorParser());
  gh.factory<_i11.AppBlocObserver>(
      () => _i11.AppBlocObserver(logger: get<_i6.Logger>()));
  gh.singleton<_i12.AuthenticationRepository>(
      _i12.AuthenticationRepository(userAPI: get<_i9.UserAPI>()));
  gh.singleton<_i13.SignInBloc>(_i13.SignInBloc(
      authenticationRepository: get<_i12.AuthenticationRepository>()));
  return get;
}

class _$HttpModule extends _i14.HttpModule {}

class _$DioModule extends _i14.DioModule {}

class _$LoggerModule extends _i14.LoggerModule {}
