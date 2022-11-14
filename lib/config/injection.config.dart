// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:persistent_storage/persistent_storage.dart' as _i3;
import 'package:pokemon_repository/pokemon_repository.dart' as _i4;
import 'package:shared_preferences/shared_preferences.dart' as _i5;

import '../pokemon_list_page/bloc/pokemon_list_bloc.dart' as _i7;
import '../pokemon_list_page/bloc/pokemon_list_tile_bloc.dart' as _i8;
import '../theme/bloc/theme_bloc.dart' as _i9;
import '../theme/repository/theme_repository.dart' as _i6;
import 'injection.dart' as _i10; // ignore_for_file: unnecessary_lambdas

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
  gh.singleton<_i4.PokemonRepository>(injectableModule.pokemonRepository);
  gh.singletonAsync<_i5.SharedPreferences>(() => injectableModule.sharedPrefs);
  gh.singletonAsync<_i6.ThemeRepository>(() async =>
      _i6.ThemeRepository(await get.getAsync<_i3.PersistentStorage>()));
  gh.lazySingleton<_i7.PokemonListBloc>(
      () => _i7.PokemonListBloc(get<_i4.PokemonRepository>()));
  gh.singleton<_i8.PokemonListTileBloc>(
      _i8.PokemonListTileBloc(get<_i4.PokemonRepository>()));
  gh.singletonAsync<_i9.ThemeBloc>(
      () async => _i9.ThemeBloc(await get.getAsync<_i6.ThemeRepository>()));
  return get;
}

class _$InjectableModule extends _i10.InjectableModule {}
