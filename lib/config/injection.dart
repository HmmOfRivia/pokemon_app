import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:persistent_storage/persistent_storage.dart';
import 'package:pokemon_app/config/injection.config.dart';
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
}
