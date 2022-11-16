import 'dart:async';

import 'package:persistent_storage/persistent_storage.dart';
import 'package:rxdart/subjects.dart';

class FavouriteRepository {
  FavouriteRepository({required PersistentStorage storage})
      : _storage = storage;

  final PersistentStorage _storage;

  static const String favouritesKey = 'FavouriteRepository_Favourites';

  PublishSubject<String> removePokemonStream = PublishSubject();

  Future<void> writeFavouriteToStorage(String name) async {
    final currentFavourites =
        await _storage.readStringList(key: favouritesKey) ?? [];

    currentFavourites.add(name);

    _storage.writeStringList(key: favouritesKey, value: currentFavourites);
  }

  Future<void> removeFavouriteFromStorage(String name) async {
    final currentFavourites = await _storage.readStringList(key: favouritesKey);

    if (currentFavourites == null) throw Exception();

    currentFavourites.remove(name);

    _storage.writeStringList(key: favouritesKey, value: currentFavourites);

    removePokemonStream.add(name);
  }

  Future<bool> isPokemonFavourite(String name) async {
    final currentFavourites = await _storage.readStringList(key: favouritesKey);

    if (currentFavourites == null) {
      return false;
    }

    return currentFavourites.contains(name);
  }

  Future<List<String>> getFavouritesPokemons() async {
    return await _storage.readStringList(key: favouritesKey) ?? [];
  }

  Future<List<String>> reorderPokemonAndSaveInStorage(
    int oldIndex,
    int newIndex,
  ) async {
    final pokemonNames = await _storage.readStringList(key: favouritesKey);

    if (pokemonNames == null) {
      throw Exception();
    }

    final name = pokemonNames.removeAt(oldIndex);
    pokemonNames.insert(newIndex, name);
    _storage.writeStringList(key: favouritesKey, value: pokemonNames);
    return pokemonNames;
  }

  void cancelStreams() {
    removePokemonStream.close();
  }
}
