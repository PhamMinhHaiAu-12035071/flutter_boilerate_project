// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;
import 'package:logger/logger.dart' as _i4;

import '../../app_bloc_observer.dart' as _i6;
import '../../modules/theme/business_logic/theme_bloc.dart' as _i5;
import 'injection.dart' as _i7; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final httpModule = _$HttpModule();
  final loggerModule = _$LoggerModule();
  gh.singleton<_i3.Client>(httpModule.client);
  gh.singleton<_i4.Logger>(loggerModule.logger);
  gh.singleton<_i5.ThemeBloc>(_i5.ThemeBloc());
  gh.factory<_i6.AppBlocObserver>(
      () => _i6.AppBlocObserver(logger: get<_i4.Logger>()));
  return get;
}

class _$HttpModule extends _i7.HttpModule {}

class _$LoggerModule extends _i7.LoggerModule {}
