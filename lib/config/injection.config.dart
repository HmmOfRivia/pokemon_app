// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:favourite_repository/favourite_repository.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:persistent_storage/persistent_storage.dart' as _i4;
import 'package:pokemon_repository/pokemon_repository.dart' as _i5;
import 'package:shared_preferences/shared_preferences.dart' as _i6;

import '../pokemon_list_page/bloc/pokemon_list_bloc.dart' as _i8;
import '../pokemon_list_page/bloc/pokemon_list_tile_bloc.dart' as _i9;
import '../theme/bloc/theme_bloc.dart' as _i10;
import '../theme/repository/theme_repository.dart' as _i7;
import 'injection.dart' as _i11; // ignore_for_file: unnecessary_lambdas

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
  gh.singletonAsync<_i3.FavouriteRepository>(
      () => injectableModule.favouriteRepository);
  gh.singletonAsync<_i4.PersistentStorage>(
      () => injectableModule.persistentStorage);
  gh.singleton<_i5.PokemonRepository>(injectableModule.pokemonRepository);
  gh.singletonAsync<_i6.SharedPreferences>(() => injectableModule.sharedPrefs);
  gh.singletonAsync<_i7.ThemeRepository>(() async =>
      _i7.ThemeRepository(await get.getAsync<_i4.PersistentStorage>()));
  gh.lazySingleton<_i8.PokemonListBloc>(
      () => _i8.PokemonListBloc(get<_i5.PokemonRepository>()));
  gh.singletonAsync<_i9.PokemonListTileBloc>(
      () async => _i9.PokemonListTileBloc(
            get<_i5.PokemonRepository>(),
            await get.getAsync<_i3.FavouriteRepository>(),
          ));
  gh.singletonAsync<_i10.ThemeBloc>(
      () async => _i10.ThemeBloc(await get.getAsync<_i7.ThemeRepository>()));
  return get;
}

class _$InjectableModule extends _i11.InjectableModule {}
