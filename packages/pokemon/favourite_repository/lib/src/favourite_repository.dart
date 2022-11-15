import 'package:persistent_storage/persistent_storage.dart';

class FavouriteRepository {
  FavouriteRepository({required PersistentStorage storage})
      : _storage = storage;

  final PersistentStorage _storage;

  static const String favouritesKey = 'FavouriteRepository_Favourites';

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
  }

  Future<bool> isPokemonFavourite(String name) async {
    final currentFavourites = await _storage.readStringList(key: favouritesKey);

    if (currentFavourites == null) {
      return false;
    }

    return currentFavourites.contains(name);
  }
}
