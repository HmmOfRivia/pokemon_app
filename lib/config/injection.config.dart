// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:persistent_storage/persistent_storage.dart' as _i3;
import 'package:shared_preferences/shared_preferences.dart' as _i4;

import '../theme/bloc/theme_bloc.dart' as _i6;
import '../theme/repository/theme_repository.dart' as _i5;
import 'injection.dart' as _i7; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final injectableModule = _$InjectableModule();
  gh.singletonAsync<_i3.PersistentStorage>(
      () => injectableModule.persistentStorage);
  gh.singletonAsync<_i4.SharedPreferences>(() => injectableModule.sharedPrefs);
  gh.singletonAsync<_i5.ThemeRepository>(() async =>
      _i5.ThemeRepository(await get.getAsync<_i3.PersistentStorage>()));
  gh.singletonAsync<_i6.ThemeBloc>(
      () async => _i6.ThemeBloc(await get.getAsync<_i5.ThemeRepository>()));
  return get;
}

class _$InjectableModule extends _i7.InjectableModule {}
