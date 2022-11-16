import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_api/pokemon_api.dart';
import 'package:pokemon_app/pokemon_favourites_list_page/bloc/favourites_list_bloc.dart';

void main() {
  group('favourites state comparison', () {
    final pokemonsMock =
        List.generate(10, (index) => Pokemon(name: 'name$index'));
    test('supports value comparison', () {
      final updatedList = List<Pokemon>.from(pokemonsMock)..removeAt(2);

      expect(
        FavouritesListLoaded(favouritesPokemons: pokemonsMock),
        isNot(FavouritesListLoaded(favouritesPokemons: updatedList)),
      );
    });
  });
}
