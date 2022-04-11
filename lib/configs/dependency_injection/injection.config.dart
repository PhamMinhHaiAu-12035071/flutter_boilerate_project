// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive_flutter/hive_flutter.dart' as _i6;
import 'package:http/http.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;
import 'package:logger/logger.dart' as _i7;

import '../../app_bloc_observer.dart' as _i15;
import '../../modules/auth/data/api/json_parsers/token_parser.dart' as _i9;
import '../../modules/auth/data/api/json_parsers/user_error_parser.dart'
    as _i14;
import '../../modules/auth/data/api/user_api.dart' as _i12;
import '../../modules/auth/data/api/user_api_impl.dart' as _i13;
import '../../modules/auth/data/repositories/authentication_repository.dart'
    as _i16;
import '../../modules/auth/data/repositories/authentication_repository_impl.dart'
    as _i17;
import '../../modules/auth/data/repositories/token_offline_repository_impl.dart'
    as _i11;
import '../../modules/auth/data/repositories/token_repository.dart' as _i10;
import '../../modules/sign_in/business_logic/sign_in_bloc.dart' as _i18;
import '../../modules/theme/business_logic/theme_bloc.dart' as _i8;
import '../../shared/services/client_common.dart' as _i4;
import 'injection.dart' as _i19; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final httpModule = _$HttpModule();
  final dioModule = _$DioModule();
  final hiveModule = _$HiveModule();
  final loggerModule = _$LoggerModule();
  gh.singleton<_i3.Client>(httpModule.client);
  gh.singleton<_i4.ClientCommon>(_i4.ClientCommon(client: get<_i3.Client>()));
  gh.factory<_i5.Dio>(() => dioModule.dio);
  await gh.singletonAsync<_i6.HiveInterface>(() => hiveModule.hive,
      preResolve: true);
  gh.singleton<_i7.Logger>(loggerModule.logger);
  gh.factory<String>(() => hiveModule.tokenBoxName,
      instanceName: 'tokenBoxName');
  gh.singleton<_i8.ThemeBloc>(_i8.ThemeBloc());
  gh.singleton<_i9.TokenParser>(_i9.TokenParser());
  gh.singleton<_i10.TokenRepository>(
      _i11.TokenOfflineRepositoryImpl(
          get<String>(instanceName: 'tokenBoxName')),
      instanceName: 'TokenOfflineRepositoryImpl');
  gh.singleton<_i12.UserAPI>(_i13.UserApiImpl(get<_i5.Dio>()),
      instanceName: 'UserApiImpl');
  gh.singleton<_i14.UserErrorParser>(_i14.UserErrorParser());
  gh.factory<_i15.AppBlocObserver>(
      () => _i15.AppBlocObserver(logger: get<_i7.Logger>()));
  gh.singleton<_i16.AuthenticationRepository>(
      _i17.AuthenticationRepositoryImpl(
          get<_i12.UserAPI>(instanceName: 'UserApiImpl'),
          get<_i10.TokenRepository>(
              instanceName: 'TokenOfflineRepositoryImpl')),
      instanceName: 'AuthenticationRepositoryImpl');
  gh.singleton<_i18.SignInBloc>(_i18.SignInBloc(
      get<_i16.AuthenticationRepository>(
          instanceName: 'AuthenticationRepositoryImpl')));
  return get;
}

class _$HttpModule extends _i19.HttpModule {}

class _$DioModule extends _i19.DioModule {}

class _$HiveModule extends _i19.HiveModule {}

class _$LoggerModule extends _i19.LoggerModule {}
