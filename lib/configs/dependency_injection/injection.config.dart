// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;
import 'package:logger/logger.dart' as _i5;

import '../../app_bloc_observer.dart' as _i8;
import '../../modules/auth/data/data_providers/user_api.dart' as _i7;
import '../../modules/auth/data/repositories/authentication_repository.dart'
    as _i9;
import '../../modules/sign_in/business_logic/sign_in_bloc.dart' as _i10;
import '../../modules/theme/business_logic/theme_bloc.dart' as _i6;
import '../../shared/services/client_common.dart' as _i4;
import 'injection.dart' as _i11; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final httpModule = _$HttpModule();
  final loggerModule = _$LoggerModule();
  gh.singleton<_i3.Client>(httpModule.client);
  gh.singleton<_i4.ClientCommon>(_i4.ClientCommon(client: get<_i3.Client>()));
  gh.singleton<_i5.Logger>(loggerModule.logger);
  gh.singleton<_i6.ThemeBloc>(_i6.ThemeBloc());
  gh.singleton<_i7.UserAPI>(_i7.UserAPI(clientCommon: get<_i4.ClientCommon>()));
  gh.factory<_i8.AppBlocObserver>(
      () => _i8.AppBlocObserver(logger: get<_i5.Logger>()));
  gh.singleton<_i9.AuthenticationRepository>(
      _i9.AuthenticationRepository(userAPI: get<_i7.UserAPI>()));
  gh.singleton<_i10.SignInBloc>(_i10.SignInBloc(
      authenticationRepository: get<_i9.AuthenticationRepository>()));
  return get;
}

class _$HttpModule extends _i11.HttpModule {}

class _$LoggerModule extends _i11.LoggerModule {}
