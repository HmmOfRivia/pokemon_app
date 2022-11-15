import 'package:favourite_repository/favourite_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:persistent_storage/persistent_storage.dart';
import 'package:pokemon_app/config/injection.config.dart';
import 'package:pokemon_repository/pokemon_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

@InjectableInit()
void configureInjection(String environment) {
  $initGetIt(GetIt.I, environment: environment);
}

@module
abstract class InjectableModule {
  @singleton
  Future<SharedPreferences> get sharedPrefs async =>
      SharedPreferences.getInstance();

  @singleton
  Future<PersistentStorage> get persistentStorage async =>
      PersistentStorage(sharedPreferences: await sharedPrefs);

  @singleton
  PokemonRepository get pokemonRepository => PokemonRepository();

  @singleton
  Future<FavouriteRepository> get favouriteRepository async =>
      FavouriteRepository(storage: await persistentStorage);
}
